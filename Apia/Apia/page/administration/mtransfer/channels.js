function loadListChannels() {
	
	var spTransferContainter1 = new Spinner($('MTChannelsContainer1'));
	spTransferContainter1.show(true);
	var request = new Request({
		method: 'post',
		url: CONTEXT + URL_REQUEST_AJAX + '?action=loadListChannels&isAjax=true' + TAB_ID_REQUEST,
		onRequest: function() { },
		onComplete: function(resText, resXml) { modalProcessXml(resXml); SYS_PANELS.closeAll(); spTransferContainter1.hide(true); }
	}).send();
}

function processListChannels() {
	
	var myAppData = getAjaxData();
	//proccessXmlListChannels(myAppData,$('MTChannelsContainer1'));
	
	addHTMLToDiv($('MTChannelsContainer1'), myAppData.getAttribute("codname"));
	addHTMLToDiv($('MTChannelsContainer2'), '');
	initChannelTab();
}

/*
function proccessXmlListChannels(xmlMyApp,container){
		
	var divField = new Element("div",{html: xmlMyApp.getAttribute("codname") });
	divField.inject(container);
}*/

function processInfoChannel(){
	
	var myAppData = getAjaxData();
	//proccessXmlListChannels(myAppData,$('MTChannelsContainer2'));
	addHTMLToDiv($('MTChannelsContainer2'), myAppData.getAttribute("codname"));
	setDivReadonly('MTChannelsContainer1');
	showOptionButton('saveTransferChannel');
	showOptionButton('deleteTransferChannel');
	showOptionButton('cancelEditChannel');
	hideOptionButton('addChannel');

}

function addTransferChannel() {
	
	var obj = new Object();
	obj.idElement = '';	
	invokeMethodAction('MTChannelsContainer2','getInfoTransferChannel', obj);
}

function saveTransferChannel() {
	
	var idField = document.getElementById("idTransferChannel"); //.getElementsByTagName("input")[0];
	var validTransferChannel = idField.value;
	
	var nameField = document.getElementById("nameTransferChannel"); //.getElementsByTagName("input")[0];
	var valName = nameField.value;
	if (valName == '') {
		showMessage(FIELD_TRANSFER_CHANNEL_NAME_EMPTY); //'no ingreso un nombre para el canal');
		return false;
	}
	
	//executableTransferChannel
	var executableField = document.getElementById("executableTransferChannel"); //.getElementsByTagName("input")[0];
	var valExecutable = executableField.value;
	if (valExecutable == '') {
		showMessage(FIELD_TRANSFER_CHANNEL_EXEC_EMPTY); //'no ingreso un ejecutable para el canal');
		return false;
	}
	
	//isSyncrTransferChannel
	var isSyncrField = document.getElementById("isSyncrTransferChannel"); 
	var valIsSyncr = isSyncrField.checked; 
	
	var obj = new Object();
	   obj.id = validTransferChannel;
	   obj.name  = valName;
	   obj.executable = valExecutable;
	   obj.isSyncr = valIsSyncr;
	   	   
	invokeMethodAction('MTChannelsContainer2','saveTransferChannel', obj);

}

function deleteTransferChannel() {
	
	var idField = document.getElementById("idTransferChannel"); //.getElementsByTagName("input")[0];
	var validTransferChannel = idField.value;
	
	if (validTransferChannel == '') {
		return false;
	}
	
	if (!confirm(CHECK_DELETE_TRANSFER_CHANNEL)) { //'Desea eliminar el canal de transferencia?')){
		return false;
	}
	
	var obj = new Object();
	obj.idTransferChannel = validTransferChannel;
	
	invokeMethodAction('MTChannelsContainer2','deleteTransferChannel', obj);

}

function initChannelTab() {
	hideOptionButton('saveTransferChannel');
	hideOptionButton('deleteTransferChannel');
	hideOptionButton('cancelEditChannel');
	showOptionButton('addChannel');
	removeDivReadonly('MTChannelsContainer1');
	addHTMLToDiv($('MTChannelsContainer2'), "");

}

