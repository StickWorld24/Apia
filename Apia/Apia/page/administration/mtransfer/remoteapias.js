function loadListRemoteApias() {
	
	var spTransferContainter1 = new Spinner($('MTRemoteApiaContainter1'));
	spTransferContainter1.show(true);
	var request = new Request({
		method: 'post',
		url: CONTEXT + URL_REQUEST_AJAX + '?action=loadListRemoteApias&isAjax=true' + TAB_ID_REQUEST,
		onRequest: function() { },
		onComplete: function(resText, resXml) { modalProcessXml(resXml); SYS_PANELS.closeAll(); spTransferContainter1.hide(true); }
	}).send();
}

function processListRemoteApias() {
	
	var myAppData = getAjaxData();
	//proccessXmlListModels(myAppData,$('MTRemoteApiaContainter1'));
	addHTMLToDiv($('MTRemoteApiaContainter1'), myAppData.getAttribute("codname"));
	addHTMLToDiv($('MTRemoteApiaContainter2'), '');
	addHTMLToDiv($('MTRemoteApiaContainter3'), '');
	initRemoteAppsTab();
}

/*
function proccessXmlRemoteApias(xmlMyApp,container){
	var divField = new Element("div",{html: xmlMyApp.getAttribute("codname") });
	divField.inject(container);

}*/

function processInfoRemoteApp() {
	
	var myAppData = getAjaxData();
	addHTMLToDiv($('MTRemoteApiaContainter2'), myAppData.getAttribute("codname"));
	addHTMLToDiv($('MTRemoteApiaContainter3'), '');
	
	returnRemoteAppInfoTab();
}

function processInfoRemoteChannel() {
	var myAppData = getAjaxData();
	addHTMLToDiv($('MTRemoteApiaContainter3'), myAppData.getAttribute("codname"));
	
	
	hideOptionButton('addApplication');
	setDivReadonly('MTRemoteApiaContainter1');
	
	hideOptionButton('saveApp');
	hideOptionButton('deleteApp');
	hideOptionButton('addRemoteChannel');
	hideOptionButton('cancelEditRemoteApp');
	setDivReadonly('MTRemoteApiaContainter2');
	
	showOptionButton('saveRemoteChannel');
	showOptionButton('deleteRemoteChannel');
	showOptionButton('cancelEditRemoteChannel');	
	removeDivReadonly('MTRemoteApiaContainter3');
}


function addParameterRemoteChannel() {
	
	var tableID = 'remoteChannelParameterList';
	var row = addRowToTable(tableID);
	var idRow = document.getElementById(tableID).rows.length - 1;
	
	
	var cell1 = row.insertCell(0);
	cell1.innerHTML = "<input type='text' id='parameterId"+idRow+"' value=''>";
	
	var cell2 = row.insertCell(1);
	cell2.innerHTML =  "<input type='text' id='parameterValue"+idRow+"' value=''>";
	//cell2.id = 'parameterValue'+idRow;
	var cell3= row.insertCell(2);
	cell3.style.display = "none";
	cell3.innerHTML =  "<input type='text' id='rcinfoparId"+idRow+"' value=''>";
	
	var SUFIX = 'rc';
	var cell4 = row.insertCell(3);
	cell4.innerHTML = "<div onClick=\"removeRowGrid('"+SUFIX+"',"+idRow+")\" style='background-image: url(page/administration/mtransfer/delete.png); background-position: center; background-size: 50% 50%; background-repeat: no-repeat; width: 34px; height: 34px;'></div>";
	cell4.id = 'td'+ SUFIX + 'Delete'+ idRow;

}

function addApplication() {
	
	var obj = new Object();
	obj.idElement = '';	
	invokeMethodAction('MTRemoteApiaContainter2','getInfoRemoteApp', obj);
}

function addRemoteChannel() {
	
	var obj = new Object();
	obj.idElement = document.getElementById('idAppRemote').value+'SEPARATOR';	
	invokeMethodAction('MTRemoteApiaContainter3','getInfoRemoteChannel', obj);
}

function saveApplication() {
	
	//idAppRemote
	var idAppRemoteField = document.getElementById("idAppRemote");
	var validAppRemote = idAppRemoteField.value;
	if (validAppRemote == ''){
		showMessage(FIELD_REMOTE_APP_NAME_EMPTY); //'no ingreso un nombre para la aplicación remota');
		return false;
	}
	
	//ipAppRemote
	var ipAppRemoteField = document.getElementById("ipAppRemote"); //.getElementsByTagName("input")[0];
	var valIPAppRemote = ipAppRemoteField.value;
	if (valIPAppRemote == ''){
		showMessage(FIELD_REMOTE_APP_IP_EMPTY); //'no ingreso una dirección IP');
		return false;
	}
	
	//portAppRemote
	var portField = document.getElementById("portAppRemote"); //.getElementsByTagName("input")[0];
	var valPort = portField.value;
	if (valPort == ''){
		showMessage(FIELD_REMOTE_APP_PORT_EMPTY); //'no ingreso un nro de puerto');
		return false;
	}
	
	//contexto
	var contextField = document.getElementById("contextAppRemote"); //.getElementsByTagName("input")[0];
	var valContext = contextField.value;
	if (valContext == ''){
		showMessage(FIELD_REMOTE_APP_CONTEXT_EMPTY); //'no ingreso un nro de puerto');
		return false;
	}
	
	//isApiaAppRemote
	var isApiaAppRemoteField = document.getElementById("isApiaAppRemote"); //.getElementsByTagName("select")[0];
	var valIsApiaAppRemote = isApiaAppRemoteField.checked; //selectField.options[selectField.selectedIndex].value;
	
	var obj = new Object();
	   obj.id = validAppRemote;
	   obj.ip  = valIPAppRemote;
	   obj.port = valPort;
	   obj.context = valContext;
	   obj.isApia = valIsApiaAppRemote;
	 
	invokeMethodAction('MTRemoteApiaContainter2','saveRemoteApp', obj);

}


function saveRemoteChannel() {
	
	var idAppRemoteField = document.getElementById("idAppRemote");
	var valIdAppRemote = idAppRemoteField.value;
	if (valIdAppRemote == ''){
		showMessage(FIELD_REMOTE_APP_EMPTY); //'no ingreso un nombre para la aplicación remota');
		return false;
	}
	
	//idRemoteChannel
	var idRemoteChannelField = document.getElementById("idRemoteChannel"); //.getElementsByTagName("input")[0];
	var valIdRemoteChannel = idRemoteChannelField.value;
	
	
	
	var selectField = document.getElementById("selTransferChannelRemoteChannel").getElementsByTagName("select")[0];
	var valSelect = selectField.options[selectField.selectedIndex].value;
	if (valSelect == ''){
		showMessage(FIELD_TRANSFER_CHANNEL_EMPTY); //'no eligió el canal de transferencia del canal remoto');
		return false;
	}
	
	
	//portRemoteChannel
	var portRemoteChannelField = document.getElementById("portRemoteChannel"); //.getElementsByTagName("input")[0];
	var valPort = portRemoteChannelField.value;
	if (valPort == ''){
		showMessage(FIELD_REMOTE_CHANNEL_PORT_EMPTY); //'no ingresó el puerto del canal remoto');
		return false;
	}
	
	
	//remoteEnvironment
	var remoteEnvironmentField = document.getElementById("remoteEnvironment"); //;
	var valRemoteEnvironment = remoteEnvironmentField.value;
	if (valRemoteEnvironment == null || valRemoteEnvironment== 'undefined'){
		valRemoteEnvironment = '';
	}
	
	var obj = new Object();
	obj.idRemoteApp = valIdAppRemote;
	obj.idRemoteChannel = valIdRemoteChannel;
	obj.idTransferChannel = valSelect;
	obj.puerto  = valPort;
	obj.remoteEnvironment = valRemoteEnvironment;
	obj.maxParameters = 0;
	obj.rcinfoparId = [];
	obj.parId = [];
	obj.parValue = [];
	
	//cargo la tabla de parámetros con id remoteChannelParameterList
	var sizeTableParam = document.getElementById('remoteChannelParameterList').rows.length;
	//alert(sizeTableParam);
	for (i = 1; i < sizeTableParam; i++) { 
		//alert(document.getElementById('parameterId'+i).value + ' ' + document.getElementById('parameterValue'+i).value);
		obj.rcinfoparId.push(document.getElementById('rcinfoparId'+i).value);
		obj.parId.push(document.getElementById('parameterId'+i).value);
		obj.parValue.push(document.getElementById('parameterValue'+i).value);
		obj.maxParameters= obj.maxParameters+1;
	}
	
	
	invokeMethodAction('MTRemoteApiaContainter3','saveRemoteChannel', obj);


}


function deleteApplication() {
	
	if (!confirm(CHECK_DELETE_REMOTE_APP)) { //'Desea eliminar la aplicación?')){
		return false;
	}
	
	var idAppRemoteField = document.getElementById("idAppRemote");
	var validAppRemote = idAppRemoteField.value;
	if (validAppRemote == '') {
		showMessage(FIELD_REMOTE_APP_EMPTY); //'no ingreso un nombre para la aplicación remota');
		return false;
	}
	
	var obj = new Object();
	obj.id = validAppRemote;
	
	invokeMethodAction('MTRemoteApiaContainter2','deleteRemoteApplication', obj);

	
}


function deleteRemoteChannel() {
	
	var idRemoteChannelField = document.getElementById("idRemoteChannel"); //.getElementsByTagName("input")[0];
	var valIdRemoteChannel = idRemoteChannelField.value;
	
	if (valIdRemoteChannel == ''){
		return false;
	}
	
	if (!confirm(CHECK_DELETE_REMOTE_CHANNEL)) { //'Desea eliminar el canal remoto de la aplicación?')){
		return false;
	}
	
	var idAppRemoteField = document.getElementById("idAppRemote");
	var validAppRemote = idAppRemoteField.value;
	if (validAppRemote == '') {
		showMessage(FIELD_REMOTE_APP_EMPTY); //'no ingreso un nombre para la aplicación remota');
		return false;
	}
	
	var obj = new Object();
	obj.idRemoteApp = validAppRemote;
	obj.idRemoteChannel = valIdRemoteChannel;
	
	invokeMethodAction('MTRemoteApiaContainter3','deleteRemoteChannel', obj);


}

function syncWithRemoteAppURL(element){
	var urlToSyncr = document.getElementById('urlToSyncr').value;
	
	var obj = new Object();
	obj.urlToSyncr = urlToSyncr;

	invokeMethodAction('MTRemoteApiaContainter1','syncWithRemoteAppURL', obj);

	//var urlParam = "doAction.jsp?idElement=" + "" + "&idaction=" + 'syncWithRemoteAppURL' + "&envId=" + document.getElementById('inputEnvId').value + TAB_ID_REQUEST;
	//saveInfo(urlParam, obj);

}

function syncGetRemoteModelListRemoteAppURL(element){
	var urlToSyncrMessage = document.getElementById('urlToSyncrMessage').value;
	var remoteEnvToSyncrMessage = document.getElementById('remoteEnvToSyncrMessage').value;
	
	var obj = new Object();
	obj.urlToSyncrMessage = urlToSyncrMessage;
	obj.remoteEnvToSyncrMessage = remoteEnvToSyncrMessage;

	invokeMethodAction('MTRemoteApiaContainter1','syncGetRemoteModelListRemoteAppURL', obj);

	//var urlParam = "doAction.jsp?idElement=" + "" + "&idaction=" + 'syncGetRemoteModelListRemoteAppURL' + "&envId=" + document.getElementById('inputEnvId').value + TAB_ID_REQUEST;			
	//getInfo3(urlParam, obj, "pannelRight");
}


function processListRemoteModels(){
	
	var myAppData = getAjaxData();
	//proccessXmlListModels(myAppData,$('MTRemoteApiaContainter1'));
	//addHTMLToDiv($('MTRemoteApiaContainter1'), myAppData.getAttribute("codname"));
	addHTMLToDiv($('MTRemoteApiaContainter2'), myAppData.getAttribute("codname"));
	addHTMLToDiv($('MTRemoteApiaContainter3'), '');
}


function syncSaveRemoteMessageRemoteApp(element){
	
	if (confirm(CHECK_SAVE_REMOTE_MODEL_MESSAGE)) { //'desea guardar ese modelo de mensaje?')){
	
		var idMessage = element.value;
		
		
		var urlToSyncrMessage = document.getElementById('urlToSyncrMessage').value;
		var remoteEnvToSyncrMessage = document.getElementById('remoteEnvToSyncrMessage').value;
		
		var obj = new Object();
		obj.urlToSyncrMessage = urlToSyncrMessage;
		obj.remoteEnvToSyncrMessage = remoteEnvToSyncrMessage;
		obj.idMessage = idMessage;
		
		invokeMethodAction('MTRemoteApiaContainter2','syncSaveRemoteMessageRemoteApp', obj);

		//var urlParam = "doAction.jsp?idElement=" + "" + "&idaction=" + 'syncSaveRemoteMessageRemoteApp' + "&envId=" + document.getElementById('inputEnvId').value + TAB_ID_REQUEST;
		//saveInfo(urlParam, obj);
	}

}

function initRemoteAppsTab() {
	showOptionButton('addApplication');
	removeDivReadonly('MTRemoteApiaContainter1');

	hideOptionButton('saveApp');
	hideOptionButton('deleteApp');
	hideOptionButton('addRemoteChannel');
	hideOptionButton('cancelEditRemoteApp');
	addHTMLToDiv($('MTRemoteApiaContainter2'), "");
	
	hideOptionButton('saveRemoteChannel');
	hideOptionButton('deleteRemoteChannel');
	hideOptionButton('cancelEditRemoteChannel');	
	addHTMLToDiv($('MTRemoteApiaContainter3'), "");
}

function returnRemoteAppInfoTab() {
	
	hideOptionButton('addApplication');
	setDivReadonly('MTRemoteApiaContainter1');
	
	showOptionButton('saveApp');
	showOptionButton('deleteApp');
	showOptionButton('addRemoteChannel');
	showOptionButton('cancelEditRemoteApp');
	removeDivReadonly('MTRemoteApiaContainter2');
	
	hideOptionButton('saveRemoteChannel');
	hideOptionButton('deleteRemoteChannel');
	hideOptionButton('cancelEditRemoteChannel');	
	addHTMLToDiv($('MTRemoteApiaContainter3'), "");

}
