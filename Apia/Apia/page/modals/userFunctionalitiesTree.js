var spUserTreeFncMdl = null;

var USERFNCTREE_MODAL_HIDE_OVERFLOW	= true;

var selectedUser;

function initUserFncTreeMdlPage(){
	var mdlTreeFncsContainer = $('mdlUsrTreeFncsContainer');
	if (mdlTreeFncsContainer.initDone) return;
	mdlTreeFncsContainer.initDone = true;

	mdlTreeFncsContainer.blockerModal = new Mask();
	spUserTreeFncMdl = new Spinner($('mdlUsrTreeFncBody'),{message:WAIT_A_SECOND});
	
	$('closeUsrTreeFncMdl').addEvent("click", function(e) {
		e.stop();
		closeUsrTreeFncsModal();
	});	
}

function showUserTreeFncsModal(userId, envId){
	if(USERFNCTREE_MODAL_HIDE_OVERFLOW) {
		$(document.body).setStyle('overflow', 'hidden');
	}
	
	var mdlTreeFncsContainer = $('mdlUsrTreeFncsContainer');
	mdlTreeFncsContainer.removeClass('hiddenModal');
	mdlTreeFncsContainer.position();
	mdlTreeFncsContainer.blockerModal.show();
	mdlTreeFncsContainer.setStyle('zIndex', SYS_PANELS.getNewZIndex());
	
	selectedUser = userId;
	loadUserEnvironments();
	setUserTree(envId);
	mdlTreeFncsContainer.position();
	
}

function setUserTree(envId){
	spUserTreeFncMdl.show(true);
	
	var fncsContainerTreeMdl = $('usrFncsContainerTreeMdl');
	fncsContainerTreeMdl.empty();
	fncsContainerTreeMdl.scrollTop=0;
			
	var request = new Request({
		method : 'post',
		async: false,
		url : CONTEXT + URL_REQUEST_AJAX_TREE_FNC + '?action=loadUserFunctionalitiesTreeMode&isAjax=true&txtUserId='+selectedUser+'&txtEnvId=' + envId + TAB_ID_REQUEST,
		onRequest : function() { },
		onComplete : function(resText, resXml) { processXmlFncsTree(resXml); }
	}).send();
}

function processXmlFncsTree(resXml){
	var fncsContainerTreeMdl = $('usrFncsContainerTreeMdl');
	var fncs = resXml.getElementsByTagName("result")
	if (fncs != null && fncs.length > 0 && fncs.item(0) != null) {
		fncs = fncs.item(0).getElementsByTagName("functionality");
		
		for (var i = 0; i < fncs.length; i++){
			var xmlFnc = fncs[i];
			
			if (!$("mdl_fnc_"+xmlFnc.getAttribute("id"))){
				var attFather = xmlFnc.getAttribute("father");
				var father = attFather && attFather != "-1" ? $("mdl_father_"+attFather) : fncsContainerTreeMdl;
				var fncId = xmlFnc.getAttribute("id");
				
				var elem = new Element('li.modal',{'id': "mdl_fnc_"+fncId});
				elem.setAttribute("father",father.getAttribute("id"));
				if (xmlFnc.getAttribute("father") != "") { elem.setAttribute("fncFatherId","mdl_fnc_"+attFather); }
				elem.setAttribute("fncType",xmlFnc.getAttribute("type"));
				elem.inject(father);
				
				var span = new Element("span",{ html: xmlFnc.getAttribute("title") });
				span.inject(elem);
					
				if (xmlFnc.getAttribute("type") == "F") {
					elem.addClass("fncTypeFolder with-collapse-opt");
					var ul = new Element("ul.modal",{'id': "mdl_father_"+fncId });
					ul.inject(elem);					
					var opclo = new Element("div",{'class': "hideChilds collapse-opt"});
					opclo.setAttribute("childs","mdl_father_"+fncId);
					opclo.setAttribute("open","true");
					opclo.addEvent('click', function(evt) { showOrHideChilds(this); evt.stopPropagation(); });
					opclo.inject(span,"before");
					elem.addEvent('click', function(evt){ evt.stopPropagation(); this.getElement('div').click(); }); 
				} else {
					if (father == fncsContainerTreeMdl) { elem.addClass("noFather"); }
				}
				
				if (CHROME || SAFARI){
					if (elem.hasClass("noFather")){
						elem.removeClass("noFather");
						elem.setStyle("padding-left","20px");
						elem.setStyle("margin-left","-35px");
					}
				}
			}
		}
	}
	
	removeEmptyFolders();
	
	if (fncsContainerTreeMdl.getElements('li').length==0){
		var li = new Element('li').inject(fncsContainerTreeMdl);
		var span = new Element("span",{ html: MSG_NO_ITEMS, styles : {'font-style':'italic'} });
		span.inject(li);
	}
	
	SYS_PANELS.closeActive();
	spUserTreeFncMdl.hide(true);
}

function removeEmptyFolders(){
	$$('li.fncTypeFolder').each(function(li){
		var ul = li.getElement('ul.modal');
		
		if (ul && ul.getElements('li.modal').length == 0 && ul.getElements('ul.modal').length == 0){
			li.destroy();
		}
	});
	
	$$('li.fncTypeFolder').each(function(li){
		//Borra directorios vacios
		if (li.getElements('li:not([fnctype="F"])').length==0) li.destroy();
	});
}

function closeUsrTreeFncsModal(){
	var mdlTreeFncsContainer = $('mdlUsrTreeFncsContainer');
	
	if(Browser.chrome || Browser.firefox || Browser.safari) {
		var morph = new Fx.Morph(mdlTreeFncsContainer, {duration: 200, wait: false});
		
		morph.start({
			'margin-top': '-10px',
			'opacity': 0
		}).chain(function() {
			
			mdlTreeFncsContainer.addClass('hiddenModal');
			mdlTreeFncsContainer.setStyles({
				'opacity': 1,
				'margin-top': ''
			}); //Limpiar la transicion
						
			mdlTreeFncsContainer.blockerModal.hide();
			if (mdlTreeFncsContainer.onModalClose) mdlTreeFncsContainer.onModalClose();
			
			if(USERFNCTREE_MODAL_HIDE_OVERFLOW) {
				$(document.body).setStyle('overflow', '');
			}
		});
	} else {
		
		mdlTreeFncsContainer.addClass('hiddenModal');
		
		mdlTreeFncsContainer.blockerModal.hide();
		if (mdlTreeFncsContainer.onModalClose) mdlTreeFncsContainer.onModalClose();
		
		if(USERFNCTREE_MODAL_HIDE_OVERFLOW) {
			$(document.body).setStyle('overflow', '');
		}
	}	
}

function updateEnvUsrTreeFunc(){
	setUserTree($('userEnvs').selectedOptions[0].value);
}

function loadUserEnvironments(){
	$('userEnvs').empty();
	
	var request = new Request({
		method : 'post',
		async: false,
		url : CONTEXT + URL_REQUEST_AJAX_TREE_FNC + '?action=loadUserEnvironments&isAjax=true&txtUserId='+selectedUser + TAB_ID_REQUEST,
		onRequest : function() { },
		onComplete : function(resText, resXml) { 
			var envs = resXml.getElementsByTagName("result")
			if (envs != null && envs.length > 0 && envs.item(0) != null) {
				envs = envs.item(0).getElementsByTagName("environment");
				
				var select = $('userEnvs');
				for (var i = 0; i < envs.length; i++){
					var xmlEnv = envs[i];
					var id = xmlEnv.getAttribute("id");
					var option = new Element('option',{value:id, html:xmlEnv.getAttribute("title")});
					if (id == CURRENT_ENVIRONMENT) option.setAttribute('selected','');
					option.inject(select);
				}
			}
		}
	}).send();
}

function showOrHideChilds(obj){
	if (obj.getAttribute("open") == "true"){
		obj.removeClass("hideChilds");
		obj.addClass("showChilds");
		obj.setAttribute("open","false");
		$(obj.getAttribute("childs")).setStyle("display","none");
	} else {
		obj.removeClass("showChilds");
		obj.addClass("hideChilds");
		obj.setAttribute("open","true");
		$(obj.getAttribute("childs")).setStyle("display","");
	}
}