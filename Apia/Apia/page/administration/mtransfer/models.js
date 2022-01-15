function loadListModels() {
	
	var spTransferContainter1 = new Spinner($('MTModelsContainter1'));
	spTransferContainter1.show(true);
	var request = new Request({
		method: 'post',
		url: CONTEXT + URL_REQUEST_AJAX + '?action=loadListModels&isAjax=true' + TAB_ID_REQUEST,
		onRequest: function() { },
		onComplete: function(resText, resXml) { modalProcessXml(resXml); SYS_PANELS.closeAll(); spTransferContainter1.hide(true); }
	}).send();
}

function processListModels() {
	
	var myAppData = getAjaxData();
	//proccessXmlListModels(myAppData,$('MTModelsContainter1'));
	
	addHTMLToDiv($('MTModelsContainter1'), myAppData.getAttribute("codname"));
	addHTMLToDiv($('MTModelsContainter2'), '');
	initModelsTab();
}

/*
function proccessXmlListModels(xmlMyApp,container){
		
//	var divField = new Element("div",{html: xmlMyApp.getAttribute("codname") });
//	divField.inject(container);
	
	container.set('html',xmlMyApp.getAttribute("codname"))

}
*/
function processInfoModel() {
	
	var myAppData = getAjaxData();
	addHTMLToDiv($('MTModelsContainter2'), myAppData.getAttribute("codname"));
	
	showOptionButton('saveMessageModel');
	showOptionButton('deleteMessageModel');
	showOptionButton('cancelMessageModel');
	hideOptionButton('newMessageModel');
	setDivReadonly('MTModelsContainter1');

}

function removeRowGrid(sufixTable, indexRow) {
	var idElementRow = "";
	if (document.getElementById('i'+sufixTable+'Id'+indexRow) != null){
		idElementRow =  document.getElementById('i'+sufixTable+'Id'+indexRow).value;
	}
	
	if (idElementRow != "") {
		
		if (!confirm('Desea eliminar el parametro?')) {
			return false;
		}
		
		var idMessageModel = document.getElementById("idMessageModel").value;
		var nroAction = "0"; //divParent.id.replace("actiondiv", "");
		var divActionIter = document.getElementById("actiondiv"+nroAction);
		
		//valor de la action elegida
		var idRelModelAction = divActionIter.getAttribute('idRelModelAction'); //document.getElementById("idRelModelAction").value;	
		
		var fieldAction = document.getElementById("selAction");
		var valAction = fieldAction.options[fieldAction.selectedIndex].value;
		if (valAction == '') {
			showMessage(FIELD_MODEL_MESSAGE_ACTION_EMPTY); //'no ingresó una acción para el modelo');
			return false;
		}
		
		var fieldElementOfAction = document.getElementById("idElementForAction");
		var idElementOfAction = fieldElementOfAction.value;
		if (idElementOfAction == '') {
			showMessage(FIELD_MODEL_MESSAGE_ELEMENT_ACTION_EMPTY); //'no ingresó un identificador del elemento de acción');
			return false;
		}
		
		var obj = new Object();
		obj.idMessage = idMessageModel;
		obj.idRelModelAction = idRelModelAction;
		obj.idAction = valAction;
		obj.idElementAction  = idElementOfAction;
		obj.idElementRow = idElementRow;
		
		invokeMethodAction('MTModelsContainter2','removeModelParammeter', obj);

	} else {
		var tableID = 'table'+sufixTable;
		document.getElementById(tableID).deleteRow(indexRow);
	}
}

function addActionTableParameterForm(element) {
	
	var idElement = element.id;
	var SUFIX = idElement.replace('add', '');
	
	//nombre de la tabla
	var tableID = 'table'+SUFIX;
	var row = addRowToTable(tableID);
	var idRow = document.getElementById(tableID).rows.length - 1;

	var cell1 = row.insertCell(0);
	cell1.innerHTML = "";
	cell1.style.display = "none";
	cell1.id = 'td'+ SUFIX + 'Id'+ idRow;
	
	var cell2 = row.insertCell(1);
	cell2.innerHTML = "<input type='text' id='i"+SUFIX+"Origen"+idRow+"' value=''>";
	cell2.id = 'td'+ SUFIX + 'Origen'+ idRow;
	
	var cell3 = row.insertCell(2);
	cell3.innerHTML = "<div onClick=\"removeRowGrid('"+SUFIX+"',"+idRow+")\" style='background-image: url(page/administration/mtransfer/delete.png); background-position: center; background-size: 50% 50%; background-repeat: no-repeat; width: 34px; height: 34px;'></div>";
	cell3.id = 'td'+ SUFIX + 'Delete'+ idRow;
	
}


function addActionTableParameter(element) {
	
	var idElement = element.id;
	var SUFIX = idElement.replace('add', '');
	
	//nombre de la tabla
	var tableID = 'table'+SUFIX;
	var row = addRowToTable(tableID);
	var idRow = document.getElementById(tableID).rows.length - 1;
	
	
	var cell1 = row.insertCell(0);
	cell1.innerHTML = "";
	cell1.style.display = "none";
	cell1.id = 'td'+ SUFIX + 'Id'+ idRow;
	
	var cell2 = row.insertCell(1);
	cell2.innerHTML = ""; //select
	cell2.id = 'td'+ SUFIX + 'DataType'+ idRow;
	
	var cell3 = row.insertCell(2);
	cell3.innerHTML = ""; //select //<input type='text' id='portPublishedChannel' value=''>";
	cell3.id = 'td'+ SUFIX + 'DataSource'+ idRow;
	
	var cell4 = row.insertCell(3);
	cell4.innerHTML = "<input type='text' id='i"+SUFIX+"Origen"+idRow+"' value=''>";
	cell4.id = 'td'+ SUFIX + 'Origen'+ idRow;
	
	var cell5 = row.insertCell(4);
	cell5.innerHTML = "<input type='text' id='i"+SUFIX+"Destino"+idRow+"' value=''>";; //"<button id='publishChannel' type='button' onClick='executeBtn(this)'>Publicar</button>";
	cell5.id = 'td'+ SUFIX + 'Destino'+ idRow;
	
	
	var cell6 = row.insertCell(5);
	cell6.innerHTML = "<input type='checkbox' id='c"+SUFIX+"IsOut"+idRow+"' value=''>";; //"<button id='publishChannel' type='button' onClick='executeBtn(this)'>Publicar</button>";
	cell6.id = 'td'+ SUFIX + 'IsOut'+ idRow;
	
	var obj = new Object();
	obj.idField = cell2.id;
	invokeMethodAction('MTModelsContainter2','getDataTypes', obj);

	//var urlParam = "doAction.jsp?idElement=" + "" + "&idaction=" + 'getDataTypes' + "&envId=" + document.getElementById('inputEnvId').value + TAB_ID_REQUEST;			
	//getInfo(urlParam, cell2.id)
	
	var obj2 = new Object();
	obj2.idField = cell3.id;
	invokeMethodAction('MTModelsContainter2','getDataSources', obj2);
	
	//urlParam = "doAction.jsp?idElement=" + "" + "&idaction=" + 'getDataSources' + "&envId=" + document.getElementById('inputEnvId').value + TAB_ID_REQUEST;			
	//getInfo(urlParam, cell3.id)
	var cell7 = row.insertCell(6);
	cell7.innerHTML = "<div onClick=\"removeRowGrid('"+SUFIX+"',"+idRow+")\" style='background-image: url(page/administration/mtransfer/delete.png); background-position: center; background-size: 50% 50%; background-repeat: no-repeat; width: 34px; height: 34px;'></div>";
	cell7.id = 'td'+ SUFIX + 'Delete'+ idRow;
	
}


function loadActionParamsTable(element) {
	
	//valor del idAction, segun el cual mostrare las tablas a llenar
	var valAction = element.options[element.selectedIndex].value;
	
	//calculo el div donde poner el html de las tablas
	var divParent = element.parentNode.parentNode;
	var nroAction = divParent.id.replace("actiondiv", "");
	var idFieldParam = "actionparamsdiv" + nroAction;
		
	var idRelModelAction = divParent.getAttribute("idRelModelAction");
	var idAutoMessageModel = document.getElementById("idMessageModel").value;
	
	
	var obj = new Object();
	obj.idAutoMessageModel = idAutoMessageModel;
	obj.valAction = valAction;
	obj.idRelModelAction = idRelModelAction;
	obj.idFieldParam = idFieldParam;
	
	invokeMethodAction('MTModelsContainter2','getHTMLTableParamAction', obj);

	//var urlParam = "doAction.jsp?idAutoMessageModel=" + idAutoMessageModel + "&valAction=" + valAction + "&idRelModelAction=" + idRelModelAction + "&idaction=" + 'getHTMLTableParamAction' + "&envId=" + document.getElementById('inputEnvId').value + TAB_ID_REQUEST;	
	//getInfo(urlParam, idFieldParam)
	
}

function addMessageModel() {
	
	var obj = new Object();
	obj.idElement = '';	
	invokeMethodAction('MTModelsContainter2','getInfoMessageModel', obj);
}


function saveMessageModel(element) {
	
	var idElement = element.id;	
	
	var idMessageModel = document.getElementById("idMessageModel").value;
	var nameMessage = document.getElementById("nameMessageModel").value;
	var fieldDescrMessageModel = document.getElementById("descrMessageModel");
	var descrMessageModel = fieldDescrMessageModel.value;
	if (descrMessageModel == '') {
		showMessage(FIELD_MODEL_MESSAGE_DESCR_EMPTY); //'no ingresó una descripción para el modelo');
		return false;
	}
	
	//var divParent = element.parentNode;
	var nroAction = "0"; //divParent.id.replace("actiondiv", "");
	var divActionIter = document.getElementById("actiondiv"+nroAction);
	
	//valor de la action elegida
	var idRelModelAction = divActionIter.getAttribute('idRelModelAction'); //document.getElementById("idRelModelAction").value;	
	
	var fieldAction = document.getElementById("selAction");
	var valAction = fieldAction.options[fieldAction.selectedIndex].value;
	if (valAction == '') {
		showMessage(FIELD_MODEL_MESSAGE_ACTION_EMPTY); //'no ingresó una acción para el modelo');
		return false;
	}
	
	var fieldElementOfAction = document.getElementById("idElementForAction");
	var idElementOfAction = fieldElementOfAction.value;
	if (idElementOfAction == '') {
		showMessage(FIELD_MODEL_MESSAGE_ELEMENT_ACTION_EMPTY); //'no ingresó un identificador del elemento de acción');
		return false;
	}
	
	var obj = new Object();
	obj.idMessage = idMessageModel;
	obj.nameMessage = nameMessage;
	obj.descrMessage = descrMessageModel;
	obj.idRelModelAction = idRelModelAction;
	obj.idAction = valAction;
	obj.idElementAction  = idElementOfAction;
	//parametros del action
	obj.maxParameters = 0;
	obj.parameterId = [];
	obj.parameterIdRelModelAction = [];
	obj.parameterParameterType = [];
	obj.parameterDataType = [];
	obj.parameterDataSource = [];
	obj.parameterOrigen = [];
	obj.parameterDestino = [];
	obj.parameterIsOut = [];

	loadParameterByTable(obj, 'tableParamAPModel', idRelModelAction);
	loadParameterByTable(obj, 'tableParamAEModel', idRelModelAction);
	loadParameterByTable(obj, 'tableParamPCModel', idRelModelAction);
	
	loadParameterFormByTable(obj, 'tableParamFPModel', idRelModelAction);
	loadParameterFormByTable(obj, 'tableParamFEModel', idRelModelAction);

	invokeMethodAction('MTModelsContainter2','saveMessageModel', obj);

//	var urlParam = "doAction.jsp?idElement=" + "" + "&idaction=" + 'saveMessageModel' + "&envId=" + document.getElementById('inputEnvId').value + TAB_ID_REQUEST;
//		
//	saveInfo(urlParam, obj);

}


function loadParameterFormByTable(obj, nameTable, idRelModelAction) {
	
	//si no está la tabla salgo
	var table = document.getElementById(nameTable);
	if (table == null){
		return;
	}
	
	var SUFIX = nameTable.replace('table', '');

	//cargo la tabla de parámetros con id remoteChannelParameterList
	var sizeTableParam = table.rows.length;
	//alert(sizeTableParam);
	for (i = 1; i < sizeTableParam; i++) { 
		//alert(document.getElementById('parameterId'+i).value + ' ' + document.getElementById('parameterValue'+i).value);
		//obj.parId.push(document.getElementById('parameterId'+i).value);
		//obj.parValue.push(document.getElementById('parameterValue'+i).value);
		if (document.getElementById('i'+SUFIX+'Id'+i) != null){
			obj.parameterId.push(document.getElementById('i'+SUFIX+'Id'+i).value);
		}else{
			obj.parameterId.push('');	
		}
		
		if (idRelModelAction == null){
			obj.parameterIdRelModelAction.push('');	
		}else{
			obj.parameterIdRelModelAction.push(idRelModelAction);
		}

		obj.parameterParameterType.push(SUFIX);

		obj.parameterDataType.push('-1');
		obj.parameterDataSource.push('-1');

		obj.parameterOrigen.push(document.getElementById('i'+SUFIX+'Origen'+i).value);
		obj.parameterDestino.push('-');
		obj.parameterIsOut.push(false);
		obj.maxParameters= obj.maxParameters+1;
	}
	
}

function loadParameterByTable(obj, nameTable, idRelModelAction) {
	//si no está la tabla salgo
	var table = document.getElementById(nameTable);
	if (table == null) {
		return;
	}
	
	var SUFIX = nameTable.replace('table', '');

	//cargo la tabla de parámetros con id remoteChannelParameterList
	var sizeTableParam = table.rows.length;
	//alert(sizeTableParam);
	for (i = 1; i < sizeTableParam; i++) { 
		//alert(document.getElementById('parameterId'+i).value + ' ' + document.getElementById('parameterValue'+i).value);
		//obj.parId.push(document.getElementById('parameterId'+i).value);
		//obj.parValue.push(document.getElementById('parameterValue'+i).value);
		if (document.getElementById('i'+SUFIX+'Id'+i) != null){
			obj.parameterId.push(document.getElementById('i'+SUFIX+'Id'+i).value);
		}else{
			obj.parameterId.push('');	
		}
		
		if (idRelModelAction == null){
			obj.parameterIdRelModelAction.push('');	
		}else{
			obj.parameterIdRelModelAction.push(idRelModelAction);
		}
		
		obj.parameterParameterType.push(SUFIX);
		
		var tdDataType = document.getElementById('td'+SUFIX+'DataType'+i);
		var selectFieldDataType = tdDataType.getElementsByTagName("select")[0];
		var valSelectDataType = selectFieldDataType.options[selectFieldDataType.selectedIndex].value;
		if (valSelectDataType == '') {
			showMessage(FIELD_MODEL_MESSAGE_PARAM_DATATYPE_EMPTY); //'no eligió el tipo de datos de un parámetro');
			return false;
		}
		obj.parameterDataType.push(valSelectDataType);
		
		
		var tdDataSource = document.getElementById('td'+SUFIX+'DataSource'+i);
		var selectFieldDataSource = tdDataSource.getElementsByTagName("select")[0];
		var valSelectDataSource = selectFieldDataSource.options[selectFieldDataSource.selectedIndex].value;
		if (valSelectDataSource == ''){
			showMessage(FIELD_MODEL_MESSAGE_PARAM_SOURCETYPE_EMPTY); //'no eligió la fuente de datos de un parámetro');
			return false;
		}
		obj.parameterDataSource.push(valSelectDataSource);
		
		
		
		obj.parameterOrigen.push(document.getElementById('i'+SUFIX+'Origen'+i).value);
		obj.parameterDestino.push(document.getElementById('i'+SUFIX+'Destino'+i).value);
		
		obj.parameterIsOut.push(document.getElementById('c'+SUFIX+'IsOut'+i).checked);
		
		obj.maxParameters= obj.maxParameters+1;
	}
	
	
}


function deleteMessageModel() {
	
	var idMessageModel = document.getElementById("idMessageModel").value;

	if (idMessageModel == '') {
		return false;
	}
	
	if (!confirm(CHECK_DELETE_MODEL_MESSAGE)) { //'Desea eliminar el modelo de mensaje?')) {
		return false;
	}
	
	var obj = new Object();
	obj.idMessageModel = idMessageModel;
	
	invokeMethodAction('MTModelsContainter2','deleteMessageModel', obj);


}

function initModelsTab() {
	hideOptionButton('saveMessageModel');
	hideOptionButton('deleteMessageModel');
	hideOptionButton('cancelMessageModel');
	showOptionButton('newMessageModel');
	removeDivReadonly('MTModelsContainter1');
	addHTMLToDiv($('MTModelsContainter2'), "");

}
