var editor;
var validJsFunctions = '';	// guardo las funciones a usar en un string
var STRING_MSG_ERROR = null;
var mirrorCodeLine = 0;
var showHistoryPosition = 0;
var historyArray = new Array();
//var mirrorCode;

function initPage(){
	//crear spinner de espere un momento
	sp = new Spinner(document.body,{message:WAIT_A_SECOND});
	
	initAdminFav();
	
	/****EDITOR PARA HTML******/
	editor = CodeMirror.fromTextArea(document.getElementById("shellCommCommand"), {
		lineNumbers: true,
		matchBrackets: true,
		lineWrapping: true,
		lineNumberFormatter: function(cm) {return ">"},
		extraKeys: {"Ctrl-Q": "toggleComment"},
		theme: "nightlion"
	}); 
	editor.setSize('100%', 300);
	
	getURL(ECMA_URL, function(err, code) {
		if (err) throw new Error("Request for " + ECMA_FILE_NAME + ": " + err);
		server = new CodeMirror.TernServer({defs: [JSON.parse(code)]});
		editor.setOption("extraKeys", {
			"Ctrl-Space": function(cm) { server.complete(cm); },
			"Ctrl-I": function(cm) { server.showType(cm); },
			"Alt-.": function(cm) { server.jumpToDef(cm); },
			"Alt-,": function(cm) { server.jumpBack(cm); },
			"Ctrl-Enter": function(cm) { $('btnExecute').fireEvent('click'); },
			"Up": function(cm) { showHistory(cm, 'up'); },
			"Down": function(cm) { showHistory(cm, 'down'); }
		})
		editor.on("cursorActivity", function(cm) { server.updateArgHints(cm); });
	});
	editor.focus();
	
	//Ejecutar
	$('btnExecute').addEvent("click",function(e){
		if (e) e.stop();
		
		sp.show(true);
		
		var command = '';
		if (mirrorCodeLine == editor.lastLine()) {
			command = editor.getLine(editor.lastLine());
		} else {
			for (i = mirrorCodeLine; i <= editor.lastLine(); i++) {
				command += ' ' + editor.getLine(i);
			}
		}
		
		if (command == '' || command == null){
			showMessage(MSG_EMPTY_COMMAND, GNR_TIT_WARNING, 'modalWarning');
		} else {
			ApiaShellCommand.cleanResultContainer();
			
			var jsError = null;
			try {
			//Siempre es en modo cliente
			ApiaShellCommand.executeCommand(command);
			} catch (e){
				jsError = e.message;
				processError(e);
				jsError += STRING_MSG_ERROR != null ? '<br>' + STRING_MSG_ERROR : '';
			}

			//Muestra resultados
//			
			var buffer = '';
			var content = ApiaShellCommand.getResultContainer();
			
			processCommandResult(content);
			mirrorCodeLine = editor.lastLine();
			showHistoryPosition = historyArray.push(command);
			editor.focus();
//			
			if (jsError){ //muestra error de JS
				showMessage(jsError, GNR_TITILE_EXCEPTIONS, 'modalError');
			}
		}
		
		sp.hide(true);
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
	
	//Cerrar
	$('btnCloseTab').addEvent("click", function(e) {
		btnCloseTab.addEvent('click', getTabContainerController().removeActiveTab());
	});
	
	var mirrorCode = document.getElementsByClassName('CodeMirror-code')[0];
	if (mirrorCode) {
		mirrorCode.addEventListener('DOMNodeInserted', function(evt) {
			if( evt.target.parentNode.classList.contains('CodeMirror-code') ) {
				var codeChilds = mirrorCode.getChildren();
				if (codeChilds.length > 1) {
					for (i = 0; i < editor.lineCount() - 1; i++) {
						if (codeChilds[i] && codeChilds[i].getChildren()[0] && codeChilds[i].getChildren()[0].getChildren()[0]) {
							var gutter = codeChilds[i].getChildren()[0].getChildren()[0];
							gutter.classList.remove('CodeMirror-linenumber');
							gutter.classList.add('CodeMirror-linenumber-no-animation');
						}
					}
					var lineCount = editor.lineCount() - 1;
					if (codeChilds[lineCount] && codeChilds[lineCount].getChildren()[0] && codeChilds[lineCount].getChildren()[0].getChildren()[0]) {
						var gutter = codeChilds[editor.lineCount() - 1].getChildren()[0].getChildren()[0];
						gutter.classList.add('CodeMirror-linenumber');
						gutter.classList.remove('CodeMirror-linenumber-no-animation');
						
						//add CodeMirror-line class to <pre> tag
						var codeLine = codeChilds[lineCount].getChildren()[0].getChildren()[0];
						codeLine.classList.add('CodeMirror-line');
					}
				}
		    };
		})
	}
}

function styleLine(bold, messageType) {
	editor.addLineClass(editor.lastLine() - 1, 'gutter', 'CodeMirror-style-hide-gutter');
	editor.addLineClass(editor.lastLine() - 1, 'text', 'CodeMirror-style-show-text');
	if (bold) {
		editor.addLineClass(editor.lastLine() - 1, 'text', 'CodeMirror-style-bold');
	}
	
	switch (messageType){
	case "ERROR":
		editor.addLineClass(editor.lastLine() -1, 'text', 'CodeMirror-style-error-mssg');
		break;
	case "WARNING":
		editor.addLineClass(editor.lastLine() -1, 'text', 'CodeMirror-style-warning-mssg');
		break;
	case "SUCCESS":
		editor.addLineClass(editor.lastLine() -1 , 'text',  'CodeMirror-style-success-mssg');
		break;
	}
	
}

function processCommandResult(content) {
	//make new line
	var lineBreak = '\n';
	var currentLine = editor.getLine(editor.lastLine());
	editor.setLine(editor.lastLine(), currentLine + '\n');
	editor.save();
	if (content && content.length > 0){
		for (var i = 0; i < content.length; i++){
			var resComm = content[i];
			
			//Comando ejecutado
			editor.setLine(editor.lastLine(), resComm.command + '\n');
			styleLine(true);
			
			editor.setLine(editor.lastLine(), lineBreak);
			styleLine(false);
			
			//Resultado del comando ejecutado
			if (resComm.result && resComm.result.length > 0){
				for (var j = 0; j < resComm.result.length; j++){
					var resultLine = resComm.result[j];
					if (resultLine.includes('<B>')) {
						resultLine = resultLine.replace('<B>', '');
						resultLine = resultLine.replace('</B>', '');
					}
					
					
					editor.setLine(editor.lastLine(), resultLine + '\n');
					let msgType = resultLine.substr(0,resultLine.indexOf(' ') - 1);
					styleLine(true, msgType);
				}
			}
			editor.setLine(editor.lastLine(), lineBreak);
			styleLine(false);
			
			if (i+1 < content.length){
				editor.setLine(editor.lastLine(), lineBreak);
				styleLine(false);
				editor.setLine(editor.lastLine(), lineBreak);
				styleLine(false);
			}
		}
	}
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

function processJsFunctions(xml) {
	/*nuevo*/
	var functs = [];
	if (xml != null){
		functs = xml.getElementsByTagName('element');
	} 
	/*nuevo*/
//	var functs = xml.getElementsByTagName('element'); viejo
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

//function onClickFunction(str) {
//	var newFunct = new Function( str + ';');
//	newFunct();
//}

function showHistory(cm, where) {
	if (where == 'up') {
		if (showHistoryPosition > 0) {
			showHistoryPosition -= 1;
		} else {
			if (showHistoryPosition == 0 && historyArray.length == 0) {
				editor.setLine(editor.lastLine(), '');
				return;
			}
		}
	} else if (where == 'down') {
		if (historyArray.length > 0 && showHistoryPosition + 1 < historyArray.length) {
			showHistoryPosition += 1;
		} else if (historyArray == 0 || showHistoryPosition + 1 == historyArray.length || showHistoryPosition == historyArray.length) {
			if (showHistoryPosition + 1 == historyArray.length) {
				showHistoryPosition++;
			}
			editor.setLine(editor.lastLine(), '');
			return;
		} 
	}
	editor.setLine(editor.lastLine(), historyArray[showHistoryPosition]);
}
