var editor;
var validJsFunctions = '';	// guardo las funciones a usar en un array
var STRING_MSG_ERROR = null;

function initPage(){
	//crear spinner de espere un momento
	sp = new Spinner(document.body,{message:WAIT_A_SECOND});
	
	initAdminActionsEdition(executeBeforeConfirm);
	initAdminFav();
	
	/****EDITOR PARA HTML******/
	editor = CodeMirror.fromTextArea(document.getElementById("shellCommCommand"), {
		lineNumbers: true,
		matchBrackets: true,
		extraKeys: {"Ctrl-Q": "toggleComment"},
		theme: "eclipse"
	}); 
	
	initAdminFieldOnChangeHighlight(false, false, true);
	addElementsOnChangeHighlight($$('#shellCommDesc'));
	initAdminEditorOnChangeHighlight(editor);
	
	getURL(ECMA_URL, function(err, code) {
		if (err) throw new Error("Request for " + ECMA_FILE_NAME + ": " + err);
		server = new CodeMirror.TernServer({defs: [JSON.parse(code)]});
		editor.setOption("extraKeys", {
			"Ctrl-Space": function(cm) { server.complete(cm); },
			"Ctrl-I": function(cm) { server.showType(cm); },
			"Alt-.": function(cm) { server.jumpToDef(cm); },
			"Alt-,": function(cm) { server.jumpBack(cm); },
			"Ctrl-Enter": function(cm) { $('btnExecute').fireEvent('click'); }
		})
		editor.on("cursorActivity", function(cm) { server.updateArgHints(cm); });
	});
	
	//Ejecutar
	$('btnExecute').addEvent("click",function(e){
		if (e) e.stop();
		
		var command = editor.getValue();
		if (command == '' || command == null){
			showMessage(MSG_EMPTY_COMMAND, GNR_TIT_WARNING, 'modalWarning');
		} else {
			ApiaShellCommand.cleanResultContainer();
			
			ApiaShellCommand.checkSyntaxCommand(command);
			
//			var jsError = null;
//			var commandType = $('shellCommType').value; 
//			var clientNoError = true;
//			if (commandType == '0' || commandType == '2'){ //0 - Cliente; 2 - reusable
////				var jsFunctions = $('reusable_imported').value;
//				try {
//					onClickFunction(command);
//				} catch (e){
//					clientNoError = false;
//					jsError = e;
////					console.log(e.stack);
//					processError(e);
//					jsError += STRING_MSG_ERROR != null ? '<br>' + STRING_MSG_ERROR : '';
//				}
//			} else { //1 - Servidor
//				ApiaShellCommand.executeCommand(command);
//			}
//
//			if (clientNoError)
//				showResultsModal(); //muestra modal con resultados
//			
//			if (jsError){ //muestra error de JS
//				showMessage(jsError, GNR_TITILE_EXCEPTIONS, 'modalError');
//			}

		}
	});
	
	var request = new Request({
		method: 'post',
		url: CONTEXT + URL_REQUEST_AJAX + '?action=jsFunctionsList&isAjax=true' + TAB_ID_REQUEST,
		onRequest: function() { },
		onComplete: function(resText, resXml) { processJsFunctions(resXml); }
	}).send();
	
	if ($('btnShowJsFnc')) {
		$('btnShowJsFnc').addEvent('click', function(e) {
			var request = new Request({
				method: 'post',
				url: CONTEXT + URL_REQUEST_AJAX + '?action=jsFunctionsList&isAjax=true' + TAB_ID_REQUEST,
				onRequest: function() { },
				onComplete: function(resText, resXml) { modalProcessXml(resXml); }
			}).send();
		})
	}
	
	//Cargar ayuda
	loadHelpTab();
	
	initPermissions(true /*hide Project permissions */);
	initResultsMdlPage();
	
	if (document.getElementsByClassName("CodeMirror")) {
		document.getElementsByClassName("CodeMirror")[0].style.width = '980px';
		document.getElementsByClassName("CodeMirror-hscrollbar")[0].style.left = '29px';
		document.getElementsByClassName("CodeMirror-hscrollbar")[0].style.display = 'block';
		document.getElementsByClassName("CodeMirror-hscrollbar")[0].style.right = '0px';
	}
}

function executeBeforeConfirm(){
	if(!verifyPermissions()){
		return false;
	}
	
	//Se carga el valor del editor en el comando
	$('shellCommCommand').set('value', editor.getValue());
	
	return true;
}

function getURL(url, c) {
	var xhr = new XMLHttpRequest();
	xhr.open("get", url, true);
	xhr.send();
	xhr.onreadystatechange = function() {
		if (xhr.readyState != 4) return;
		if (xhr.status < 400) return c(null, xhr.responseText);
		var e = new Error(xhr.responseText || "No response");
		e.status = xhr.status;
		c(e);
	};
}	

function loadHelpTab(){
	ApiaShellCommand.cleanResultContainer();
//	ApiaShellCommand.executeCommandHelp();
	
	var lineBreakHelp = '<br>';
	
	var help = '';
	var content = ApiaShellCommand.getResultContainer();
	if (content && content.length > 0){
		for (var i = 0; i < content.length; i++){
			var resComm = content[i];
			
			//Resultado del comando ejecutado
			if (resComm.result && resComm.result.length > 0){
				for (var j = 0; j < resComm.result.length; j++){
					help += resComm.result[j];
					help += lineBreakHelp;
				}
			}
			help += lineBreakHelp;
			
			if (i+1 < content.length){
				help += lineBreakHelp;
				help += lineBreakHelp;
			}
		}
	}
	
	$('shellCommHelp').innerHTML = help;
}

function processJsFunctions(xml) {
	var functs = xml.getElementsByTagName('element');
	if (functs.length > 0) {
		for (i = 0; i < functs.length; i++) {
			validJsFunctions += functs[i].getAttribute('value') + ";";
		}
	} else {
		$('btnShowJsFnc').style.display = 'none';
	}
}

function processError(err) {
	var elems = [];
	var arrayError  = ErrorStackParser.parse(err);
	var index = 0;
	for (i = 0; i < arrayError.length; i++) {
		if (validJsFunctions.includes(arrayError[i].functionName)) {
			elems[index] = arrayError[i].functionName;
			index++;
		} else {
			break;
		}
	}
	
	if (elems.length > 0) {
		STRING_MSG_ERROR = STACKTRACE + '<br>';
		for (i = 0; i < elems.length; i++) {
			if (i == elems.length - 1) {
				STRING_MSG_ERROR += LBL_CAUSED_BY + ': <br>';
			}
			STRING_MSG_ERROR += '&nbsp - ' + elems[i] + '<br>';
		}
	}
}

function onClickFunction(str) {
	var newFunct = new Function( str + ';');
	newFunct();
}