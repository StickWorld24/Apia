function loadListPublishedChannels() {
	
	var spTransferContainter1 = new Spinner($('MTPublishedChannelsContainter1'));
	spTransferContainter1.show(true);
	var request = new Request({
		method: 'post',
		url: CONTEXT + URL_REQUEST_AJAX + '?action=loadListPublishedChannels&isAjax=true' + TAB_ID_REQUEST,
		onRequest: function() { },
		onComplete: function(resText, resXml) { modalProcessXml(resXml); SYS_PANELS.closeAll(); spTransferContainter1.hide(true); }
	}).send();
}

function processListPublishedChannels() {
	
	var myAppData = getAjaxData();
	//proccessXmlListModels(myAppData,$('MTPublishedChannelsContainter1'));
	addHTMLToDiv($('MTPublishedChannelsContainter1'), myAppData.getAttribute("codname"));
	addHTMLToDiv($('MTPublishedChannelsContainter2'), '');
	initPublishedChannelTab();
}

/*
function proccessXmlPublishedChannels(xmlMyApp,container){
	var divField = new Element("div",{html: xmlMyApp.getAttribute("codname") });
	divField.inject(container);

}*/

function processInfoPublishedChannel() {
	
	var myAppData = getAjaxData();
	addHTMLToDiv($('MTPublishedChannelsContainter2'), myAppData.getAttribute("codname"));
	
	showOptionButton('publishChannel');
	showOptionButton('deletePublishedChannel');
	showOptionButton('cancelEditPublishedChannel');
	hideOptionButton('addPublishedChannel');
	setDivReadonly('MTPublishedChannelsContainter1');

}

function addParameterPublishedChannel() {
	
	var tableID = 'publishedChannelParameterList';
	var row = addRowToTable(tableID);
	var idRow = document.getElementById(tableID).rows.length - 1;
	
	
	var cell1 = row.insertCell(0);
	cell1.innerHTML = "<input type='text' id='parameterId"+idRow+"' value=''>";
	
	var cell2 = row.insertCell(1);
	cell2.innerHTML =  "<input type='text' id='parameterValue"+idRow+"' value=''>";
	
	var cell3 = row.insertCell(2);
	cell3.innerHTML =  "<input type='checkbox' id='parameterShareValue"+idRow+"' value=''>";
	
	var cell4 = row.insertCell(3);
	cell4.style.display = "none";
	cell4.innerHTML =  "<input type='text' id='liparId"+idRow+"' value=''>";
	//cell2.id = 'parameterValue'+idRow;
	
	var SUFIX = 'pc';
	var cell5 = row.insertCell(4);
	cell5.innerHTML = "<div onClick=\"removeRowGrid('"+SUFIX+"',"+idRow+")\" style='background-image: url(page/administration/mtransfer/delete.png); background-position: center; background-size: 50% 50%; background-repeat: no-repeat; width: 34px; height: 34px;'></div>";
	cell5.id = 'td'+ SUFIX + 'Delete'+ idRow;
}

function addPublishedChannel() {
	
	var obj = new Object();
	obj.idElement = '';	
	invokeMethodAction('MTPublishedChannelsContainter2','getInfoPublishedChannel', obj);
}

function publishChannel() {
	
	var portField = document.getElementById("pcPort");
	var valPort = portField.value;
	if (valPort == '') {
		showMessage(FIELD_PUBLISHED_CHANNEL_PORT_EMPTY); //'no ingreso un nro de puerto');
		return false;
	}
	
	var idPC = document.getElementById("pcIdPublishedChannel");
	var valIdPc = idPC.value;
	
	var selectField = document.getElementById("pcTransferChannel").getElementsByTagName("select")[0];
	var valSelect = selectField.options[selectField.selectedIndex].value;
	if (valSelect == '') {
		showMessage(FIELD_PUBLISHED_CHANNEL_TRANSFER_CHANNEL_EMPTY); //'no eligio un canal de transferencia a publicar');
		return false;
	}
	
	var obj = new Object();
	   obj.puerto = valPort;
	   obj.transferChannel  = valSelect;
	   obj.id = valIdPc;
	   obj.maxParameters = 0;
	   obj.localInfoParameterId = [];
	   obj.parId = [];
	   obj.parValue = [];
	   obj.shareValueParams = [];
	   
	//cargo la tabla de parámetros con id remoteChannelParameterList
	var sizeTableParam = document.getElementById('publishedChannelParameterList').rows.length;
	//alert(sizeTableParam);
	for (i = 1; i < sizeTableParam; i++) { 
		//alert(document.getElementById('parameterId'+i).value + ' ' + document.getElementById('parameterValue'+i).value);
		obj.localInfoParameterId.push(document.getElementById('liparId'+i).value);
		obj.parId.push(document.getElementById('parameterId'+i).value);
		obj.parValue.push(document.getElementById('parameterValue'+i).value);
		
		if (document.getElementById('parameterShareValue'+i).checked){
			obj.shareValueParams.push("true");
		}else{
			obj.shareValueParams.push("false");
		}
		obj.maxParameters= obj.maxParameters+1;
	}
	
	invokeMethodAction('MTPublishedChannelsContainter2','savePublishChannel', obj);

}


function deletePublishedChannel() {
	
	var idPC = document.getElementById("pcIdPublishedChannel");
	var valIdPc = idPC.value;
	
	if (valIdPc == '') {
		return false;
	}
	
	if (!confirm(CHECK_DELETE_PUBLISHED_CHANNEL)) { //'Desea eliminar el canal publicado?')){
		return false;
	}
	
	var obj = new Object();
	obj.idPublishedChannel = valIdPc;
	
	invokeMethodAction('MTPublishedChannelsContainter2','deletePublishedChannel', obj);

}

function initPublishedChannelTab() {
	hideOptionButton('publishChannel');
	hideOptionButton('deletePublishedChannel');
	hideOptionButton('cancelEditPublishedChannel');
	showOptionButton('addPublishedChannel');
	removeDivReadonly('MTPublishedChannelsContainter1');
	addHTMLToDiv($('MTPublishedChannelsContainter2'), "");

}
