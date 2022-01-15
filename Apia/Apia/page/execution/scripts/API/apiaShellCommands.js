var ApiaShellCommand = {}

ApiaShellCommand.URL_API_REQUEST_AJAX = '/apia.design.ShellCommandsAction.run';

/**********************************************/
/*****************  OTHERS  *******************/
/**********************************************/

ApiaShellCommand.commandTokenSeparator = ' ';

/************************************************/
/******************  GENERICO  ******************/
/************************************************/

/**
 * Verifica si el comando enviado por parametro es sintacticamente correcto
 * 
 * Parameters:
 * 'command' (String): comando simple o multiples (separados por punto y coma ;)"
 * 
 * Return:
 * Mensaje de exito o error
 */
ApiaShellCommand.checkSyntaxCommand = function(command){
	var request = new Request({
		method: 'post',
		async: false,
		url: CONTEXT + ApiaShellCommand.URL_API_REQUEST_AJAX + '?action=checkSyntaxCommand&isAjax=true' + TAB_ID_REQUEST,
		onRequest: function() { SYS_PANELS.showLoading(); },
		onComplete: function(resText, resXml) { modalProcessXml(resXml); }
	}).send("command=" + command);
};

/**
 * Ejecuta el/los comando/s de 'command' 
 * 
 * Parameters:
 * 'command' (String): comando simple o multiples (separados por punto y coma ";") 
 * 
 * Return:
 * Array con los mensajes a mostrar. Realiza lo que corresponda en nuevos tabs
 */
ApiaShellCommand.executeCommand = function(command){
	var request = new Request({
		method: 'post',
		async: false,
		url: CONTEXT + ApiaShellCommand.URL_API_REQUEST_AJAX + '?action=executeCommand&isAjax=true' + TAB_ID_REQUEST,
		onRequest: function() { SYS_PANELS.showLoading(); },
		onComplete: function(resText, resXml) { modalProcessXml(resXml); }
	}).send("command=" + command);
};


/**
 * Genera la sintaxis de ejecucion de varios comandos de forma simultanea
 * 
 * Parameters:
 * 'arrCommands' (String[]): array de comandos simples o multiples (separados por punto y coma ";") 
 * 
 * Return:
 * Array con los mensajes a mostrar. Realiza lo que corresponda en nuevos tabs
 */
ApiaShellCommand.executeCommands = function(arrCommands){
	var commands = '';
	if (arrCommands && arrCommands.length > 0){
		for (var i = 0; i < arrCommands.length; i++){
			if (commands != '') commands += ';'
			commands += arrCommands[i];
		}
	}
	return ApiaShellCommand.executeCommand(commands);
}


/***********************************************************/
/******************  PROCESAR RESPUESTAS  ******************/
/***********************************************************/
/**
 * Formato de XML de respuesta recibido:
 * 
 * <result>
 *	<ShellCommandResponse>
 *		<CommandResponse>
 *			<ShowLines>
 *				<Line></Line>
 *				<Line></Line>
 *				...
 *				<Line></Line>
 *			</ShowLines>
 *			<Open url='' title=''></Open>
 *		</CommandResponse>
 *		...
 *		<CommandResponse>
 * 			...
 *		</CommandResponse>
 *	</ShellCommandResponse>
 * </result>
 * 
 * Agrega al contenedor de respuestas las lineas a mostrar en consola para cada comando.
 * Abre los tabs que correspondan.
 * 
 */
function processXMLShellCommandsResponse(){
	SYS_PANELS.closeAll();
	var ret = new Array();
	var ajaxCallXml = getLastFunctionAjaxCall();
	var result = ajaxCallXml.getElementsByTagName("result"); //tag: result
	var shellCommandResponse = result != null && result.length > 0 ? result[0].getElementsByTagName("ShellCommandResponse") : null; //tag: ShellCommandResponse
	if (shellCommandResponse && shellCommandResponse.length > 0){
		var arrCommandRespose = shellCommandResponse[0].getElementsByTagName("CommandResponse"); //tag: CommandResponse
		for (var i = 0; i < arrCommandRespose.length; i++){
			var commandResponse = arrCommandRespose[i]; //tag: CommandResponse
			
			var hashResponse = {
					'command': '',
					'result': null,
					'sintax': ''
			};
			
			var sintax = commandResponse.getAttribute('execution'); 
			if (sintax) {
				hashResponse.sintax = sintax;
			}
			
			var command = commandResponse.getElementsByTagName("Command");
//			if (command != null && command.length > 0){
//				command = command[0];
//				hashResponse.command = command.textContent;
//			}
			
			var showLines = commandResponse.getElementsByTagName("ShowLines"); //tag: ShowLines
			if (showLines && showLines.length > 0){
				//tiene lines a mostrar en consola
				var lines = showLines[0].getElementsByTagName("Line"); //tag: Line
				if (lines && lines.length > 0){
					var commLines = new Array();
					for (var l = 0; l < lines.length; l++){
						commLines.push(lines[l].textContent);
					}
					hashResponse.result = commLines;
				}

			}
			
			var open = commandResponse.getElementsByTagName("Open"); //tag: Open
			if (open && open.length > 0){
				Array.from(open).forEach(function (iOpen){
					var urlOpen = iOpen.getAttribute("url");
					var urlTitle = iOpen.getAttribute("title");
					if (urlOpen && urlOpen != ""){
//					alert("open: title=" + urlTitle + " // url=" + urlOpen);
						
						var TAB_CONTAINER = document.getElementById("tabContainer");
						if (TAB_CONTAINER == null && window.parent != null && window.parent.document != null){
							//iframe
							TAB_CONTAINER = window.parent.document.getElementById("tabContainer");
						}
						if (TAB_CONTAINER == null) {
							TAB_CONTAINER = new Object();
							TAB_CONTAINER.addNewTab = function(name, url) {
								showMessage(Generic.formatMsg(ERR_OPEN_URL, name, url));
							}
						} else {
							TAB_CONTAINER.addNewTab(urlTitle, urlOpen, null);
						}
					}
					
				})
			}
			ret.push(hashResponse);
		}
	}
	
	ApiaShellCommand.addResult(ret);
}

/*************************************************************/
/*****************  CONTENEDOR RESPUESTAS  *******************/
/*************************************************************/
/**
 * Formato:
 * 
 * [{command : '', result : [line1, line2, ..., lineN] }, {command : '', result : [line1, line2, ..., lineN] }, ... ]
 * 
 */
ApiaShellCommand.resultContainer = null;

/**
 * Añade las respuetas del último comando ejecutado.
 * 
 * Parameters:
 * 'response' (Array<{String,Array<String>}>): Array de string que representan las lineas a mostrar
 * 
 */
ApiaShellCommand.addResult = function(response){
	if (ApiaShellCommand.resultContainer == null){
		ApiaShellCommand.resultContainer = new Array();
	}
	if (response && response.length > 0){
		for (var i = 0; i < response.length; i++){
			ApiaShellCommand.resultContainer.push(response[i]);
		}
	}
}

/**
 * Retorna el contenedor de respuestas actual.
 */
ApiaShellCommand.getResultContainer = function(){
	return ApiaShellCommand.resultContainer;
}

/**
 * Inicializa el contenedor de respuetas.
 */
ApiaShellCommand.cleanResultContainer = function(){
	ApiaShellCommand.resultContainer = null;
}

/************************************************/
/******************  AUXILIAR  ******************/
/************************************************/
function traslateKeyValue(keyValue){
	var ret = '';
	if (keyValue){
		ret += keyValue[0].toUpper(); //clave
		ret += '"';
		ret += keyValue[1]; //valor 
		ret += '"';
	}
}