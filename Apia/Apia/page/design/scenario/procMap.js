
function initPage(){}

var ret = undefined;

function btnConf_click() {
	ret = undefined;
	getFlashMovie("Designer").getSimulation();
	return ret ? ret : null;
}

function proTypeChange(){}

function getSelected(){
	return null;
}

function saveSimulation(xml){
	$("txtSimulation").value = xml;
	var request = new Request({
		method: 'post',
		url: CONTEXT + URL_REQUEST_AJAX + '?action=verifieXML&isAjax=true' + TAB_ID_REQUEST,
		async: false,
		onRequest: function() { SYS_PANELS.showLoading(); },
		onComplete: function(resText, resXml) { modalProcessXml(resXml); }
	}).send('&txtSimulation=' + encodeURIComponent($("txtSimulation").value));
}


function setSimulation(){
	var xml = $("txtSimulation").value;
	getFlashMovie("Designer").setSimulation(xml);
}

function validScenario(){
	SYS_PANELS.closeAll();
	updateSimulatorXml();	
}

function updateSimulatorXml(){
	var request = new Request({
		method: 'post',
		url: CONTEXT + URL_REQUEST_AJAX + '?action=updateSimulatorXml&isAjax=true' + TAB_ID_REQUEST,
		async: false,
		onRequest: function() { SYS_PANELS.showLoading(); },
		onComplete: function(resText, resXml) { modalProcessXml(resXml); }
	}).send('&xmlSimulator=' + encodeURIComponent($("txtSimulation").value));
}

function updateSimulatorXmlOK(){
	SYS_PANELS.closeAll();
	ret = true;
}

function invalidScenario(errornum){
	SYS_PANELS.closeAll();
	showMessage(errornum, GNR_TIT_WARNING, 'modalWarning');
	ret = false;
}

function entBlur() {}

function getModalReturnValue(){
	return btnConf_click(); 
}
