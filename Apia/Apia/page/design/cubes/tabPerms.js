var usePrjPerms;

function initPermissionsTab(mode) {

	//Configuramos acci�n del bot�n de agregar permisos
	if ($('prmAddPool')) { 
		$('prmAddPool').addEvent("click", function(e) {
			e.stop();
			//setear variables de configuracion del modal de grupos
			POOLMODAL_SHOWAUTOGENERATED = true;
			POOLMODAL_SHOWNOTAUTOGENERATED = true;
			POOLMODAL_SHOWGLOBAL = true;
			POOLMODAL_SHOWCURRENTENV = true;
			ADDITIONAL_INFO_IN_TABLE_DATA = false;
			//abrir modal
			showPoolsModal(prmProcessPoolsModalReturn);
		});
	}
	
	//Configuramos acci�n del bot�n de agregar perfiles con acceso al cubo en modo navegador
	if ($('divAddProfileNav')) {
		$('divAddProfileNav').addEvent("click", function(e) {
			e.stop();
			STATUSMODAL_SHOWGLOBAL = true;
			PROFILEMODAL_FROMENVS = CURRENT_ENV;
			//abrir modal
			showProfilesModal(prmProcessProfModalNav);
			
		});
	}
	
	//Configuramos acci�n del bot�n de agregar perfiles en modo visualizador
//	$('addProfileVis').addEvent("click", function(e) {
//		e.stop();
//		STATUSMODAL_SHOWGLOBAL = true;		
//		showProfilesModal(prmProcessProfModalVw);
//	});
	
	initPoolMdlPage(); //Para el modal de selecci�n de grupos
	initPrfMdlPage();  //Para los modal de seleccion de perfiles
	
	loadPermissions(); //Cargamos los grupos con los permisos
	loadNavigatorAccessProfiles(); //Cargamos los perfiles con acceso al cubo en modo navegador
//	loadViewerAccessProfiles(); //Cargamos los perfiles con acceso restringido en algunas dimensiones del cubo en modo visualizador
	
}

//Abre modal para seleccionar grupos para asignar permisos
function prmProcessPoolsModalReturn(ret) {
	ret.each(function(e){
		var poolName = e.getRowContent()[0];
		var poolId = e.getRowId();
		
		addPermissionToContainer(poolName, poolId);
	});
}

//Procesa la informacion devuelta por el modal para seleccionar perfiles con acceso en modo navegador
function prmProcessProfModalNav(ret) {
	ret.each(function(e){
		var text = e.getRowContent()[0];
		addActionElement($('divProfilesNav'), text, e.getRowId(), "prfNavId");
	});
}

//Procesa la informacion devuelta por el modal para seleccionar perfiles con acceso restringido en alguna dimensiones en modo visualizador
function prmProcessProfModalVw(ret){
	ret.each(function(e){
		var text = e.getRowContent()[0];
		addActionElementProfileView($('divProfilesVis'),text,e.getRowId(),"true",true,"prfVwId",true);
	});
}

//Agrega un perfil en el container de perfiles con acceso restringido en alguna dimensi�n en modo visualizador
function addActionElementProfileView(container, text, id, helper, addRemove, inputName, isNew){
	var repeated = false;
	//primero verificar que no exista
	container.getElements("DIV").each(function(item,index){
		if(item.getAttribute("id")==id){
			repeated = true;
		}
	});
	if(repeated){
		return;
	}
	
	//si no est�, se agrega
	var divElement = new Element('div', {'class': 'option optionRemove'});
	divElement.set("id", id);
	divElement.set("data-helper", helper);
	
	var divData = new Element('div',{'class':'profileNoAccData',html:text});
	divData.inject(divElement);
	
	var input =  new Element('input',{type:'hidden','name':inputName,value:id,'flagNew':isNew,'profile':text});	
	input.inject(divElement);	
	
	var editIcon = new Element('div', {'class': 'editIcon'});
	editIcon.addEvent("click", function(e){
		//Para agregar un perfil de acceso restringido, se debe verificar previamente que el cubo tenga nombre
		if ($("cbeName")==""){
			showMessage(MSG_CBE_NAME_MISS);
			return;
		}
		if (!e) var e = window.event; e.cancelBubble = true; if (e.stopPropagation) e.stopPropagation();
			
		var request = new Request({
			method: 'post',
			data:{'prfName':text, cbeName:$("cbeName").value, dimNames:getDimensionsNames()},
			url: CONTEXT + URL_REQUEST_AJAX + '?action=loadDims&isAjax=true' + TAB_ID_REQUEST,
			onRequest: function() { sp.show(true); },
			onComplete: function(resText, resXml) { 
				modalProcessXml(resXml); 
				sp.hide(true); 
			}
		}).send();
		
		
		
	});
	editIcon.inject(divElement);
	
	if(addRemove){
		//divElement.container = container;		
		divElement.addEvent("click", function(e){
			var request = new Request({
				method: 'post',
				data:{'prfName':text},
				url: CONTEXT + URL_REQUEST_AJAX +'?action=removePrfRestrictions&isAjax=true' + TAB_ID_REQUEST,				
				onRequest: function() { sp.show(true); },
				onComplete: function(resText, resXml) { 
					modalProcessXml(resXml);
					sp.hide(true);
				}
			}).send();
			this.destroy();
			if (this.container && this.container.onRemove) this.container.onRemove();
		});
//		divElement.addEvent("mouseenter", actionElementAdminMouseOverToggleClasss);
//		divElement.addEvent("mouseleave", actionElementAdminMouseOverToggleClasss);
	}
	
	divElement.inject(container.getLast(),'before');
	
	return divElement;
}

//Carga los permisos con acceso de edici�n sobre el cubo
function loadPermissions() {
	var request = new Request({
		method: 'post',
		url: CONTEXT + URL_REQUEST_AJAX + '?action=loadCubePermissions&isAjax=true' + TAB_ID_REQUEST,
		onRequest: function() { },
		onComplete: function(resText, resXml) { processXMLPerms(resXml); }
	}).send();
}

//Carga los perfiles con acceso en modo navegador al cubo
function loadNavigatorAccessProfiles() {
	var request = new Request({
		method: 'post',
		url: CONTEXT + URL_REQUEST_AJAX + '?action=getProfilesForNavigator&isAjax=true' + TAB_ID_REQUEST,
		onRequest: function() { },
		onComplete: function(resText, resXml) { processXMLNavPerms(resXml); }
	}).send();
}

//Carga los perfiles con acceso restringido en algunas dimensiones del cubo en modo visualizador
function loadViewerAccessProfiles() {
	var request = new Request({
		method: 'post',
		url: CONTEXT + URL_REQUEST_AJAX + '?action=getProfilesForViewer&isAjax=true' + TAB_ID_REQUEST,
		onRequest: function() { },
		onComplete: function(resText, resXml) { processXMLVwPerms(resXml); }
	}).send();
}

//Procesa el XML con los permisos de edici�n sobre el cubo
function processXMLPerms(ajaxCallXml){
	if (ajaxCallXml != null) {
		var atts = ajaxCallXml.getElementsByTagName("perms");
		if (atts != null && atts.length > 0 && atts.item(0) != null) {
			atts = atts.item(0).getElementsByTagName("perm");
			for(var i = 0; i < atts.length; i++) {
				var att = atts.item(i);
				
				var pool_id = att.getAttribute("pool_id");
				var pool_name = att.getAttribute("pool_name");
				var perms = att.getAttribute("perms");
			
				addPermissionToContainer(pool_name, pool_id, perms);
			}
		}
	}
}

//Procesa el XML con los perfiles con acceso al cubo en modo navegador
function processXMLNavPerms(ajaxCallXml){
	if (ajaxCallXml != null) {
		var profiles = ajaxCallXml.getElementsByTagName("profiles");
		if (profiles != null && profiles.length > 0 && profiles.item(0) != null) {
			profiles = profiles.item(0).getElementsByTagName("profile");
			for(var i = 0; i < profiles.length; i++) {
				var profile = profiles.item(i);
				
				var prfName = profile.getAttribute("prfName");
				var prfId = profile.getAttribute("prfId");
				
				addActionElement($('divProfilesNav'), prfName, prfId, "prfNavId");
			}
		}
	}
}

//Procesa el XML con los perfiles con acceso restringido en algunas dimensiones del cubo en modo visualizador
function processXMLVwPerms(ajaxCallXml){
	if (ajaxCallXml != null) {
		var profiles = ajaxCallXml.getElementsByTagName("profiles");
		if (profiles != null && profiles.length > 0 && profiles.item(0) != null) {
			profiles = profiles.item(0).getElementsByTagName("profile");
			for(var i = 0; i < profiles.length; i++) {
				var profile = profiles.item(i);
				
				var prfName = profile.getAttribute("prfName");
				
				addActionElementProfileView($('divProfilesVis'),prfName,i,"true",true,"prfVwId",true);
			}
		}
	}
}

//Agrega un grupo en el container de permisos 
function addPermissionToContainer(poolName, poolId, perms) {
	var content;
	
	if(poolId == -1) content = addActionElementAdmin($('divPools'), poolName + " ", poolId, "false", false, "hidPerPoolId");
	else content = addActionElement($('divPools'),poolName + " ", poolId, "hidPerPoolId");
	
	if (content == null) return;
	
	var noPerm = "";
	var readPerm = "";
	var writePerm = "";
	
	if (perms=="R"){
		readPerm = "selected";
	}else if (perms=="RW"){
		writePerm = "selected";
	}else {
		noPerm = "selected";
	}
	
	var ele2 = new Element('select', {
		name:'selPerPoolPermRW', 
		id: 'selPerPoolPermRW',		
		html: '<option value="0"' + noPerm + '></option><option value="1"' + readPerm + '>' + 'Leer' + '</option><option value="2"' + writePerm + '>' + 'Leer y modificar' + '</option>'
	}).setStyle('width', 150).addEvent('click', function (e) {
		e.stopPropagation();
	});
	ele2.addClass("validate['~validatePerms']");
	ele2.inject(content);
	
	$('frmData').formChecker.register(ele2,1);
}

//Validaci�n de permisos
function validatePerms(el){ //Al menos un usuario debe tener permiso de modificacion en el cubo
	var container = $('divPools');
	
	for (var i = 0; i < container.getElementsByTagName("select").length; i=i+1){
		var sel = container.getElementsByTagName("select")[i];
		if (sel.value > 1) return true;
	}

	el.errors.push(MSG_CUBE_PRIV_ERRORS);
    return false;

}