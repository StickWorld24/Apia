var countDeleted;
var prev_button;

function showOptionButton(nameButton) {
	$(nameButton).removeClass('hidden');
}

function hideOptionButton(nameButton) {
	$(nameButton).addClass('hidden');
}

function setDivReadonly(nameDiv) {
	//$(nameDiv).children.attr('readonly', true);
	//$(nameDiv).attr("disabled", "true").off('click');

}

function removeDivReadonly(nameDiv) {
	//$(nameDiv).children.attr('readonly', false);
	//$(nameDiv).attr("disabled", "false").on('click');

}

function initPage(){
	//crear spinner de espere un momento
	sp = new Spinner(document.body,{message:WAIT_A_SECOND});

	['miApiaTab','channelsTab','publishedChannelsTab','remoteAppTab','messageModelTab'].each(function(ele) {
		ele = $(ele);
		var id = ele.get('id');
		var buttonsId = id.substring(0, id.indexOf('Tab')) + 'Buttons';
		var buttons = $(buttonsId);
		
		if (buttons == null) showMessage(id + " - " + buttonsId);
		
		ele.buttons = buttons;
		
		ele.addEvent("focus", function(evt) { 
			if(prev_button)
				prev_button.buttons.addClass('hidden');
			this.buttons.removeClass('hidden');
			$('currentParamTab').value = this.getAttribute("id"); 
			prev_button = ele;
		});

	});
	
	$('miApiaTab').buttons.removeClass('hidden');
	$('currentParamTab').value = 'miApiaTab';
	prev_button = $('miApiaTab');

	//actualizar
	var btnUpdate = $('btnUpdate');
	if (btnUpdate){
		btnUpdate.addEvent('click',function(e){
			e.stop();
			sp.show(true);
			window.location = CONTEXT + URL_REQUEST_AJAX + '?action=init&favFncId=131' + TAB_ID_REQUEST;
		})
	}
	//cerrar
	var btnCloseTab = $('btnCloseTab');
	if (btnCloseTab) {
		btnCloseTab.addEvent('click', function(e){
			e.stop();
			getTabContainerController().removeActiveTab();
		});
	}
	
	$$('div.fncDescriptionImage').each(function(e){
		var path = 'url(' + e.get('data-src') + ')'
		e.setStyle('background-image', path);
		e.setStyle('background-repeat', 'no-repeat');
		e.setStyle('width', '64px');
		e.setStyle('height', '64px');
	});
	
	//Unpublish All
/*	$('unpubAll').addEvent("click", function(e) {
		e.stop();
		if (countDeleted > 0){
			var request = new Request({
				method: 'post',
				url: CONTEXT + URL_REQUEST_AJAX + '?action=unpublishAllDeleted&isAjax=true' + TAB_ID_REQUEST,
				onRequest: function() { SYS_PANELS.showLoading(); },
				onComplete: function(resText, resXml) { SYS_PANELS.closeAll(); modalProcessXml(resXml); }
			}).send();		
		}
	});	*/
	
	initAdminFav();
	
	$$('div.fncDescriptionImage').each(function(e){
		var path = 'url(' + e.get('data-src') + ')'
		e.setStyle('background-image', path);
		e.setStyle('background-repeat', 'no-repeat');
		e.setStyle('width', '64px');
		e.setStyle('height', '64px');
	});
	
	//Cargar Web Services
	//loadWebServices();
	loadMyAppInformation();
	loadListChannels();
	loadListPublishedChannels();
	loadListRemoteApias();
	loadListModels();
	
}

function loadMyAppInformation(){
	
	invokeMethodAction('MTransferContainter1','loadMyAppInformation', '');
}


function invokeMethodAction(container,methodAction, params){
	
	var spTransferContainter1 = new Spinner($(container));
	spTransferContainter1.show(true);
	var request = new Request({
		method: 'post',
		url: CONTEXT + URL_REQUEST_AJAX + '?action='+ methodAction+ '&isAjax=true' + TAB_ID_REQUEST,
		onRequest: function() { },
		onComplete: function(resText, resXml) { modalProcessXml(resXml); SYS_PANELS.closeAll(); spTransferContainter1.hide(true); },
		data: params
	}).send();
}

function addHTMLToDiv(container, htmlToInsert){

	container.set('html', htmlToInsert)
}

function addHTMLToField(field, htmlToInsert){

	field.set('html', htmlToInsert)
}


function getAjaxData(){
	
	var ajaxCallXml = getLastFunctionAjaxCall().getElementsByTagName("messages")[0].getElementsByTagName("result")[0];

	if (ajaxCallXml != null) {
		
		//add parameter my apia
		var myAppData = ajaxCallXml.childNodes[0].childNodes[0]; //ajaxCallXml.getElemensByTagName("mTransfer")[0].getElementsByTagName("mTransferMyApp")[0];	
		return  myAppData;
	}
		
	
}

function processMyAppData(){
	
	var myAppData = getAjaxData();
	//proccessXmlMyAppData(myAppData,$('MTransferContainter1'));
	addHTMLToDiv($('MTransferContainter1'), myAppData.getAttribute("codname"));

}


function addBR(container){
	var brField = new Element("br");
	brField.inject(container);
}

function addInput(container,label,value, idField){
	label = label + ': ';
	var divField = new Element("div",{'class': 'fieldParameters required' });
	divField.inject(container);
	var labelField = new Element("label",{'title': label, html: label });
	labelField.inject(divField);
	var inputField = new Element("input",{'id': idField, 'name': idField, 'value': value});
	inputField.inject(divField);

}


function executeBtn(element) {
	
	var idBtn = element.id;
	//alert(idBtn);
	if(idBtn == 'addApplication'){//
		addApplication();
	}
	if(idBtn == 'addChannel'){//
		addTransferChannel();
	}
	
	if(idBtn == 'addPublishedChannel'){//
		addPublishedChannel();
	}
	
	if (idBtn == 'addParameterPublishedChannel'){//
		addParameterPublishedChannel();
	}
	
	if(idBtn == 'saveApp'){//
		saveApplication();
	}
	
	if(idBtn == 'deleteApp'){//
		deleteApplication();
	}

	if(idBtn == 'addRemoteChannel'){//
		addRemoteChannel();
	}
	
	if(idBtn == 'saveRemoteChannel'){//
		saveRemoteChannel();
	}
	
	if(idBtn == 'deleteRemoteChannel'){//
		deleteRemoteChannel();
	}
	
	if(idBtn == 'addParameterRemoteChannel'){//
		addParameterRemoteChannel();
	}
	
	if(idBtn == 'deleteParameterRemoteChannel'){
		deleteParameterRemoteChannel();
	}
	
	if(idBtn == 'saveTransferChannel'){//
		saveTransferChannel();
	}
	
	if(idBtn == 'deleteTransferChannel'){//
		deleteTransferChannel();
	}
	
	
	if(idBtn == 'publishChannel'){//
		publishChannel(element);
	}

	if (idBtn == 'deletePublishedChannel'){//
		deletePublishedChannel();
	}
	
	if(idBtn == 'newMessageModel'){//
		addMessageModel();
	}
	
	if (idBtn == 'addParamFPModel' || idBtn == 'addParamFEModel'){//
		addActionTableParameterForm(element);
	} 
	
	if (idBtn == 'addParamAPModel' || idBtn == 'addParamAEModel' || idBtn == 'addParamPCModel'){
		addActionTableParameter(element);
	}
	
	if(idBtn== 'saveMyApplication'){//
		saveMyApplication();
	}
	
	if (idBtn == 'saveMessageModel'){//
		saveMessageModel(element);
	}
	
	if (idBtn == 'deleteMessageModel'){//
		deleteMessageModel();
	}
	
	if (idBtn == 'newObjectEnable'){//
		newObjectEnable(element);
	}
	if (idBtn == 'addRemotAppObjectEnable'){
		addRemotAppObjectEnable(element);
	}
	if (idBtn == 'saveObjectEnable'){//
		saveObjectEnable(element);
	}
	
	
	if (idBtn == 'syncWithRemoteAppURL'){
		syncWithRemoteAppURL(element);
	}
		
	if (idBtn == 'syncGetRemoteModelListRemoteAppURL'){
		syncGetRemoteModelListRemoteAppURL(element);
	}
	
}


function saveMyApplication(){
	
	var nameMyApp = document.getElementById('nameMyApp').value;
	var ipMyApp = document.getElementById('ipMyApp').value;
	var contextMyApp = document.getElementById('contextMyApp').value;
	var portMyApp = document.getElementById('portMyApp').value;
	
	var tmpDirMyApp = document.getElementById('tmpDirMyApp').value;
	var backupDirMyApp = document.getElementById('backupDirMyApp').value;
	var backupSendFolderMyApp = document.getElementById('backupSendFolderMyApp').value;
	var backupRecFolderMyApp = document.getElementById('backupRecFolderMyApp').value;

	var levelGeneralLogMyApp = document.getElementById('levelGeneralLogMyApp').value;
	var levelRecLogMyApp = document.getElementById('levelRecLogMyApp').value;
	var levelSendLogMyApp = document.getElementById('levelSendLogMyApp').value;
	var levelDeleteFilesLogMyApp = document.getElementById('levelDeleteFilesLogMyApp').value;

	var obj = new Object();
	obj.nameMyApp = nameMyApp;
	obj.ipMyApp = ipMyApp;
	obj.contextMyApp = contextMyApp;
	obj.portMyApp = portMyApp;
	
	obj.tmpDirMyApp = tmpDirMyApp;
	obj.backupDirMyApp = backupDirMyApp;
	obj.backupSendFolderMyApp = backupSendFolderMyApp;
	obj.backupRecFolderMyApp = backupRecFolderMyApp;
	
	obj.levelGeneralLogMyApp = levelGeneralLogMyApp;
	obj.levelRecLogMyApp = levelRecLogMyApp;
	obj.levelSendLogMyApp = levelSendLogMyApp;
	obj.levelDeleteFilesLogMyApp = levelDeleteFilesLogMyApp;
	
	//var urlParam = "doAction.jsp?idElement=" + "" + "&idaction=" + 'saveMyAppInfo' + "&envId=" + document.getElementById('inputEnvId').value + TAB_ID_REQUEST;
	//saveInfo(urlParam, obj);
	invokeMethodAction('MTransferContainter1','saveMyAppInformation', obj);
}


function loadInfoSingleElement(element){
	var obj = new Object();
	obj.idElement = element.value;	
	invokeMethodAction(element.getAttribute('container'),element.getAttribute('idaction'), obj);
}

function loadObjectsEnabledProcess() {
	var obj = new Object();
	obj.idElement = '1';	
	invokeMethodAction('MTransferContainter2','getListEnableObjectsByAction', obj);
}

function loadObjectsEnabledEntity() {
	var obj = new Object();
	obj.idElement = '2';	
	invokeMethodAction('MTransferContainter2','getListEnableObjectsByAction', obj);
}

function loadObjectsEnabledQuery() {
	var obj = new Object();
	obj.idElement = '3';	
	invokeMethodAction('MTransferContainter2','getListEnableObjectsByAction', obj);
}

function loadObjectsEnabledBusClass() {
	var obj = new Object();
	obj.idElement = '4';	
	invokeMethodAction('MTransferContainter2','getListEnableObjectsByAction', obj);
}

function addRowToTable(tableID){
	
	var table = document.getElementById(tableID);
    var rowCount = table.rows.length;
    var row = table.insertRow(rowCount);

    return row;
}



function addRemotAppObjectEnable(element){
	
	var tableID = 'elementRemoteAppEnableList';
	var row = addRowToTable(tableID);
	var idRow = document.getElementById(tableID).rows.length - 1;
	
	var cell1 = row.insertCell(0);
	cell1.id = 'eoRmApp'+idRow;
	
	var SUFIX = 'eoRmApp';
	var cell2 = row.insertCell(1);
	cell2.innerHTML = "<div onClick=\"removeRowGrid('"+SUFIX+"',"+idRow+")\" style='background-image: url(page/administration/mtransfer/delete.png); background-position: center; background-size: 50% 50%; background-repeat: no-repeat; width: 34px; height: 34px;'></div>";
	cell2.id = 'td'+ SUFIX + 'Delete'+ idRow;
	
	var obj2 = new Object();
	obj2.idField = cell1.id;
	invokeMethodAction('MTransferContainter2','getSelectHTMLRemoteApps', obj2);
	
	
	//var urlParam = "doAction.jsp?idElement=" + "" + "&idaction=" + 'getSelectHTMLRemoteApps' + "&envId=" + document.getElementById('inputEnvId').value + TAB_ID_REQUEST;			
	//getInfo(urlParam, cell1.id)		
}


function newObjectEnable(element){
	var obj = new Object();
	obj.idElement = document.getElementById('idActionObjectsEnable').value;
	invokeMethodAction('MTransferContainter2','getObjectEnable', obj);
}

function saveObjectEnable(element){
	
	var idActionObjectsEnable = document.getElementById('idActionObjectsEnable').value;
	
	var divEnableObject = document.getElementById('selEnableObject');
	var selectEnableObject = divEnableObject.getElementsByTagName("select")[0];
	var valSelectEnableObject = selectEnableObject.options[selectEnableObject.selectedIndex].value;
	if (valSelectEnableObject == ''){
		showMessage(FIELD_EO_ELEMENT_EMPTY); //'no eligió el objeto a habilitar');
		return false;
	}
	
	var obj = new Object();
	obj.idActionObjectEnable = idActionObjectsEnable;
	obj.idEnableObject = valSelectEnableObject;
	obj.maxParameters = 0;
	obj.remoteAppEnableObject = [];
	
	var tableID = 'elementRemoteAppEnableList';
	var table = document.getElementById(tableID);
	var sizeTableRemoteApp = table.rows.length;

	for (i = 1; i < sizeTableRemoteApp; i++) { 
		
		var tdRemoteAppEnableObject = document.getElementById('eoRmApp'+i);
		var selectRemoteAppEnableObject = tdRemoteAppEnableObject.getElementsByTagName("select")[0];
		var valSelectRemoteAppEnableObject = selectRemoteAppEnableObject.options[selectRemoteAppEnableObject.selectedIndex].value;
		if (valSelectRemoteAppEnableObject == ''){
			showMessage(FIELD_EO_REMOTE_APP_RECORD_EMPTY); //'hay un registro de aplicación remota vacío.');
			return false;
		}
		obj.remoteAppEnableObject.push(valSelectRemoteAppEnableObject);	
		obj.maxParameters= obj.maxParameters+1;
	}

	invokeMethodAction('MTransferContainter3','saveObjectEnable', obj);

}

function deleteEnableObject(){
	
	if (!confirm(CHECK_DELETE_ENABLE_OBJECT)) { //'Desea eliminar el modelo de mensaje?')) {
		return false;
	}
	
	var idActionObjectsEnable = document.getElementById('idActionObjectsEnable').value;
	
	var divEnableObject = document.getElementById('selEnableObject');
	var selectEnableObject = divEnableObject.getElementsByTagName("select")[0];
	var valSelectEnableObject = selectEnableObject.options[selectEnableObject.selectedIndex].value;
	if (valSelectEnableObject == ''){
		showMessage(FIELD_EO_ELEMENT_EMPTY); //'no eligió el objeto a habilitar');
		return false;
	}
	
	var obj = new Object();
	obj.idActionObjectEnable = idActionObjectsEnable;
	obj.idEnableObject = valSelectEnableObject;

	invokeMethodAction('MTransferContainter3','deleteEnableObject', obj);

}

function processListEnabledObjects(){
	var myAppData = getAjaxData();
	addHTMLToDiv($('MTransferContainter2'), myAppData.getAttribute("codname"));
	addHTMLToDiv($('MTransferContainter3'), '');
	
	
	hideOptionButton('saveMyApplication');
	hideOptionButton('enableProcessMyApp');
	hideOptionButton('enableEntityMyApp');
	hideOptionButton('enableBusClassMyApp');
	hideOptionButton('enableQueryMyApp');
	
	showOptionButton('newObjectEnable');
	showOptionButton('cancelListObjects');

	hideOptionButton('saveObjectEnable');
	hideOptionButton('deleteObjectEnable');
	hideOptionButton('addRemotAppObjectEnable');
	hideOptionButton('cancelEnabledObject');

	setDivReadonly('MTChannelsContainer1');

}

function processEnabledObject(){
	var myAppData = getAjaxData();
	addHTMLToDiv($('MTransferContainter3'), myAppData.getAttribute("codname"));
	
	hideOptionButton('saveMyApplication');
	hideOptionButton('enableProcessMyApp');
	hideOptionButton('enableEntityMyApp');
	hideOptionButton('enableBusClassMyApp');
	hideOptionButton('enableQueryMyApp');
	
	hideOptionButton('newObjectEnable');
	hideOptionButton('cancelListObjects');

	showOptionButton('saveObjectEnable');
	showOptionButton('deleteObjectEnable');
	showOptionButton('addRemotAppObjectEnable');
	showOptionButton('cancelEnabledObject');

	setDivReadonly('MTChannelsContainer1');
	setDivReadonly('MTChannelsContainer2');

	
	setDivReadonly('MTChannelsContainer1');
}



function processSelectHTMLRemoteApp(idField){
	var myAppData = getAjaxData();
	addHTMLToField($(idField), myAppData.getAttribute("codname"));
}

function processSelectHTMLDataSources(idField){
	var myAppData = getAjaxData();
	addHTMLToField($(idField), myAppData.getAttribute("codname"));
}

function processSelectHTMLDataTypes(idField){
	var myAppData = getAjaxData();
	addHTMLToField($(idField), myAppData.getAttribute("codname"));
}

function processHTMLTableParamAction(idFieldParam){
	var myAppData = getAjaxData();
	addHTMLToField($(idFieldParam), myAppData.getAttribute("codname"));
}

function processSelectPVTC(idField){
	var myAppData = getAjaxData();
	addHTMLToField($(idField), myAppData.getAttribute("codname"));
}


function initMyAppTab() {

	showOptionButton('saveMyApplication');
	showOptionButton('enableProcessMyApp');
	showOptionButton('enableEntityMyApp');
	showOptionButton('enableBusClassMyApp');
	showOptionButton('enableQueryMyApp');

	hideOptionButton('newObjectEnable');
	hideOptionButton('cancelListObjects');

	hideOptionButton('saveObjectEnable');
	hideOptionButton('deleteObjectEnable');
	hideOptionButton('addRemotAppObjectEnable');
	hideOptionButton('cancelEnabledObject');

	removeDivReadonly('MTChannelsContainer1');
	addHTMLToDiv($('MTransferContainter2'), "");
	addHTMLToDiv($('MTransferContainter3'), "");

}

function returnListEnableObjects() {
	
	hideOptionButton('saveMyApplication');
	hideOptionButton('enableProcessMyApp');
	hideOptionButton('enableEntityMyApp');
	hideOptionButton('enableBusClassMyApp');
	hideOptionButton('enableQueryMyApp');

	showOptionButton('newObjectEnable');
	showOptionButton('cancelListObjects');

	hideOptionButton('saveObjectEnable');
	hideOptionButton('deleteObjectEnable');
	hideOptionButton('addRemotAppObjectEnable');
	hideOptionButton('cancelEnabledObject');

	
	removeDivReadonly('MTChannelsContainer1');
	removeDivReadonly('MTChannelsContainer2');
	addHTMLToDiv($('MTransferContainter3'), "");
}