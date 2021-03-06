function initPage(){
	//crear spinner de espere un momento
	sp = new Spinner(document.body,{message:WAIT_A_SECOND});
	
	$$('div.fncDescriptionImage').each(function(e){
		var path = 'url(' + e.get('data-src') + ')'
		e.setStyle('background-image', path);
		e.setStyle('background-repeat', 'no-repeat');
		e.setStyle('width', '64px');
		e.setStyle('height', '64px');
	});

	initAdminFav();
	
	$('btnBackToList').addEvent("click", function(e) {
		e.stop();
		sp.show(true);
		window.location = CONTEXT + URL_REQUEST_AJAX + '?action=list' + TAB_ID_REQUEST;
	});

	$('optionSimulate').addEvent("click", function(e) {
		e.stop();
		
		$('campaignsNotActive').empty();
		$('campaignsActive').empty();
		
		$('campaignsNotActiveElements').hideAll();
		$('campaignsActiveElements').hideAll();

		var form = $('frmData');
		var params = getFormParametersToSend(form);
		
		$('tabComponent').changeTo(1);
		
		var request = new Request({
			method: 'post',
			url: CONTEXT + URL_REQUEST_AJAX + '?action=doSimulate&isAjax=true' + TAB_ID_REQUEST,
			onRequest: function() { SYS_PANELS.showLoading(); },
			onComplete: function(resText, resXml) { modalProcessXml(resXml); SYS_PANELS.closeAll(); }
		}).send(params);
	});
	
	
	$('addUser').addEvent("click", function(e) {
		e.stop();
		USERMODAL_SELECTONLYONE = true;
		showUsersModal(processUsersModalReturn);
	});
	
	$('addProcess').addEvent("click", function(e) {
		e.stop();
		STATUSMODAL_SHOWGLOBAL = false;		
		PROCESSMODAL_SELECTONLYONE = true;
		showProcessModal(processProcessModalReturn);
	});

	$('addTask').addEvent("click", function(e) {
		e.stop();
		TASKMODAL_SELECTONLYONE = true;
		showTaskModal(processTaskModalReturn);
	});
	
	$('addFunctionality').addEvent("click", function(e) {
		e.stop();
		FNCS_ENVIRONMENT = "current";
		showFncsModal(processFunctionalityModalReturn);
	});
	
	$('functionalitiesContainer').onRemove = function() { $('addFunctionality').removeClass('hidden'); }
	$('processesContainer').onRemove = function() { $('addProcess').removeClass('hidden'); }
	$('tasksContainer').onRemove = function() { $('addTask').removeClass('hidden'); }
	
	var usersContainer = $('usersContainer');
	usersContainer.hasAUser = false;
	usersContainer.addButton = $('addUser');
	usersContainer.onRemove = function() { 
		this.hasAUser = false;
		this.addButton.removeClass('hidden');
		$('poolsContainer').emptyContainer();
		$('profilesContainer').emptyContainer();
		$('poolsContainer').enableContainer();
		$('profilesContainer').enableContainer();
	}
	
	var profilesContainer = $('profilesContainer');
	profilesContainer.isContainerEnable = true;
	profilesContainer.isEnable = function () { return this.isContainerEnable};
	profilesContainer.addButton = $('addProfile');
	profilesContainer.addButton.addEvent("click", function(e) {
		e.stop();
		PROFILEMODAL_SHOWGLOBAL = true;
		showProfilesModal(processProfilesModalReturn);
	});
	profilesContainer.emptyContainer = function() {
		this.getElements('div.option').each(function(ele){
			if (ele.get("data-helper") != "true") ele.destroy();
		});
	}
	profilesContainer.disableContainer = function() {
		this.isContainerEnable = false;
		this.addButton.addClass("hidden");
		this.addClass("modalOptionsContainerDisabled");
	}
	profilesContainer.enableContainer = function() {
		this.isContainerEnable = true;
		this.addButton.removeClass("hidden");
		this.removeClass("modalOptionsContainerDisabled");
	}
	
	var poolsContainer = $('poolsContainer');
	poolsContainer.isContainerEnable = true;
	poolsContainer.isEnable = function () { return this.isContainerEnable};
	poolsContainer.addButton = $('addPool');
	poolsContainer.addButton.addEvent("click", function(e) {
		e.stop();
		//setear variables de configuracion del modal de grupos
		POOLMODAL_SHOWAUTOGENERATED = false;
		POOLMODAL_SHOWCURRENTENV = true;
		//abrir modal
		showPoolsModal(processPoolsModalReturn);
	});
	poolsContainer.emptyContainer = function() {
		this.getElements('div.option').each(function(ele){
			if (ele.gete("data-helper") != "true") ele.destroy();
		});
	}
	poolsContainer.disableContainer = function() {
		this.isContainerEnable = false;
		this.addButton.addClass("hidden");
		this.addClass("modalOptionsContainerDisabled");
	}
	poolsContainer.enableContainer = function() {
		this.isContainerEnable = true;
		this.addButton.removeClass("hidden");
		this.removeClass("modalOptionsContainerDisabled");
	}
	
	$('campaignsNotActiveElements').hideAll = function() {
		this.getElements('div.option').each(function(ele){
			ele.addClass("hidden");
		});
	}
	
	$('campaignsActiveElements').hideAll = function() {
		this.getElements('div.option').each(function(ele){
			ele.addClass("hidden");
		});
	}
	
	$('campaignsNotActiveElements').hideAll();
	$('campaignsActiveElements').hideAll();
	
	$('cmpCondition0').addEvent('change', changedCmpCondition);
	$('cmpCondition1').addEvent('change', changedCmpCondition);
	$('cmpCondition2').addEvent('change', changedCmpCondition);
	$('cmpCondition3').addEvent('change', changedCmpCondition);
	$('cmpCondition4').addEvent('change', changedCmpCondition);
	$('cmpCondition5').addEvent('change', changedCmpCondition);
	$('cmpCondition6').addEvent('change', changedCmpCondition);
	$('cmpCondition7').addEvent('change', changedCmpCondition);
	$('cmpCondition8').addEvent('change', changedCmpCondition);
	$('cmpCondition9').addEvent('change', changedCmpCondition);
	$('cmpCondition10').addEvent('change', changedCmpCondition);
	$('cmpCondition11').addEvent('change', changedCmpCondition);
	
	//Init modals
	initUsrMdlPage();
	initPoolMdlPage();
	initPrfMdlPage();
	initProcMdlPage();
	initTaskMdlPage();
	initFncMdlPage();
}

function changedCmpCondition(evt) {
	var container = this.getAttribute("conditionContainer");
	var container = $(container);
	
	if (this.selectedIndex == 0) { 
		container.addClass('hidden');
	} else { 
		container.removeClass('hidden'); 
	}
}

function processFunctionalityModalReturn(ret){
	ret.each(function(e){
		var folder = e.getRowContent()[1];
		var text = e.getRowContent()[1];
		addActionElement($('functionalitiesContainer'),folder + " - " + text,e.getRowId(),"fncId");
		$('addFunctionality').addClass('hidden');
	});
}

function processProfilesModalReturn(ret){
	ret.each(function(e){
		var text = e.getRowContent()[0];
		var profilesContainer = $('profilesContainer');
		addActionElementAdmin(profilesContainer,text,e.getRowId(),"false",profilesContainer.isContainerEnable,"prfId");
	});
}

function processProcessModalReturn(ret){
	ret.each(function(e){
		var text = e.getRowContent()[0];
		addActionElement($('processesContainer'),text,e.getRowId(),"proId")
		$('addProcess').addClass('hidden');
	});
}

function processTaskModalReturn(ret){
	ret.each(function(e){
		var text = e.getRowContent()[0];
		addActionElement($('tasksContainer'),text,e.getRowId(),"tskId");
		$('addTask').addClass('hidden');
	});
}

function processPoolsModalReturn(ret){
	ret.each(function(e){
		var text = e.getRowContent()[0];
		var poolsContainer = $('poolsContainer')
		addActionElementAdmin(poolsContainer,text,e.getRowId(),"false",poolsContainer.isContainerEnable,"poolId");
	});
}

function processUsersModalReturn(ret){
	ret.each(function(e){
		var text = e.getRowContent()[0];
		var usersContainer = $('usersContainer');
		var newElement = addActionElement(usersContainer,text,e.getRowId(),"usrLogin");
		usersContainer.hasAUser = newElement != null;
		if (usersContainer.hasAUser) {
			usersContainer.addButton.addClass('hidden');
			loadUserInformation(e.getRowId());
		}
	});
}

function loadUserInformation(usrLogin) {
	$('poolsContainer').emptyContainer();
	$('profilesContainer').emptyContainer();
	$('poolsContainer').disableContainer();
	$('profilesContainer').disableContainer();
	
	var request = new Request({
		method: 'post',
		url: CONTEXT + URL_REQUEST_AJAX + '?action=loadUserInformation&isAjax=true' + TAB_ID_REQUEST,
		onRequest: function() { SYS_PANELS.showLoading(); },
		onComplete: function(resText, resXml) { modalProcessXml(resXml); SYS_PANELS.closeAll(); }
	}).send('usrLogin=' + usrLogin);

}

function loadXmlValuesGenericValueText(xml, tag, container, name, flag) {
	if (flag) $(flag).checked = xml.getAttribute('flag') == "true";
	
	//var elements = xml.getElements();
	var elements = xml.childNodes;
	if (elements != null) {
		container = $(container);
		for (var i = 0; i < elements.length; i++) {
			var element = elements[i];
			addActionElementAdmin(container,element.getAttribute("text"),element.getAttribute("value"),"false",container.isContainerEnable,name);
		}
	}
}

function loadXmlUserInformation() {
	var ajaxCallXml = getLastFunctionAjaxCall().getElementsByTagName("messages")[0].getElementsByTagName("result")[0];
	
	if (ajaxCallXml != null) {
		loadXmlValuesGenericValueText(ajaxCallXml.getElementsByTagName("pools")[0], 'pool', 'poolsContainer', 'poolId');
		loadXmlValuesGenericValueText(ajaxCallXml.getElementsByTagName("profiles")[0], 'profile', 'profilesContainer', 'prfId');
	}
}

function loadXmlSimulation() {
	var ajaxCallXml = getLastFunctionAjaxCall().getElementsByTagName("messages")[0].getElementsByTagName("result")[0];
	
	if (ajaxCallXml != null) {
		var state = ajaxCallXml.getAttribute('state');
		
		var campaignsNotActive = $('campaignsNotActive');
		var campaignsActive = $('campaignsActive');
		
		var campaigns = ajaxCallXml.getElementsByTagName("campaign");
		for (var i = 0; i < campaigns.length; i++) {
			var campaign = campaigns[i];
			var name = campaign.getAttribute('name');
			var active = campaign.getAttribute('active');
			
			var div = new Element('div', {'class': 'option optionWidthAll button', html: name});
			div.active = active;
			div.xmlAttributes = campaign.attributes;
			div.addEvent('click', showCampaignDetails);

			div.inject((active == "true") ? campaignsActive : campaignsNotActive)
		}
	}
}

function showCampaignDetails() {
	var cmpActive = this.active == "true" ? 'cmpActive' : 'cmpNotActive';
	var lastController = this.active == "true" ? $('campaignsActiveElements') : $('campaignsNotActiveElements');
	
	if (lastController.lastSelected) lastController.lastSelected.removeClass('selected');
	lastController.lastSelected = this;
	lastController.lastSelected.addClass('selected');
	
	for (var i = 0; i < this.xmlAttributes.length; i++) {
		var att = this.xmlAttributes[i];
		if (att.name.indexOf('cmpCondition') == -1) continue;
		
		var index = att.name.substring('cmpCondition'.length);
		var type = att.value.substring(0,1);
		var result = att.value.substring(2);
		
		if (type == "0") {
			$(cmpActive + 'Element' + index).addClass('hidden');
		} else {
			type = (type == "1") ? LBL_AND : LBL_OR;
			$(cmpActive + 'Element' + index).removeClass('hidden');
		}
		
		$(cmpActive + 'Type' + index).innerHTML = type;
		$(cmpActive + '' + index).innerHTML = (result == "true") ? LBL_TRUE : LBL_FALSE;
	}	
}
