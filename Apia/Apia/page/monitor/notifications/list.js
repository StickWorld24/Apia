function initPage(){
	//crear spinner de espere un momento
	sp = new Spinner($('gridBody').getParent(),{message:WAIT_A_SECOND});
	
	
	if(!GLOBAL){
		$('divUsrFilter').style.display = 'none';
	}
	
	Generic.updateFncImages();
	
	['orderByHasRead','orderByMessage','orderByDate','orderByFrom','orderByEvent'].each(setAdmListTitle);
	
	//asociar eventos para los filtros
	
	['messageFilter','dateFilter','fromFilter','eventFilter','userFilter','dteFrom','dteTo'].each(setAdmFilters);
	['dateFilter', 'dteFrom', 'dteTo'].each(setDateFilters);
	
	$('clearFilters').addEvent("click", function(e) {
		if(e) e.stop();
		['messageFilter','fromFilter','eventFilter','userFilter'].each(clearFilter);
		['dateFilter','dteFrom','dteTo'].each(clearFilterDate);				
		$('messageFilter').setFilter();
	}).addEvent('keypress', Generic.enterKeyToClickListener);
	
	//eventos para order
	['orderByHasRead','orderByMessage','orderByDate','orderByFrom','orderByEvent'].each(setAdmOrder);
	
	//eventos para opciones
	var btnDelete = $('btnDelete');
	btnDelete.set('title', GNR_NAV_ADM_CLONE);
	
	if (btnDelete) {
		btnDelete.addEvent("click", function(e) {
			e.stop();
			hideMessage();
			if (selectionCount($('tableData')) == 0) {
				showMessage(GNR_CHK_AT_LEAST_ONE, GNR_TIT_WARNING, 'modalWarning');
			} else {
				
				SYS_PANELS.newPanel();
				var panel = SYS_PANELS.getActive();
				panel.addClass("modalWarning");
				panel.content.innerHTML = CONFIRM_ELEMENT_DELETE;
				panel.footer.innerHTML = "<div class='button' onClick=\"SYS_PANELS.closeAll(); btnDeleteClickConfirm();\">" + GNR_NAV_ADM_DELETE + "</div>";
				SYS_PANELS.addClose(panel);
				
				SYS_PANELS.refresh();
			}
		});
	}
	
	var btnCloseTab = $('btnCloseTab');
	if (btnCloseTab) {
		btnCloseTab.addEvent('click', function() {
			getTabContainerController(true).removeActiveTab();
		});
	}
	
	setDatesChecker();
	initNavButtons();	
	initAdminFav();	
	initPinGridOptions();
		
	callNavigate();
}

//navegar a una pagina 

//establecer un filtro
function setFilter(){
	callNavigateFilter({
		txtMessage: $('messageFilter').value,			
		dte: $('dateFilter').value,
		cmbFrom: $('fromFilter').value,
		cmbEvent: $('eventFilter').value,			
		txtUserLogin: $('userFilter').value,
		dteTo: $('dteTo').value,
		dteFrom: $('dteFrom').value
	},null);
}

//establecer el orden
function setOrderByClass(obj){
	obj.toggleClass("orderedBy");
	if(obj.hasClass("unsorted")){
		obj.removeClass("unsorted")
		obj.addClass("sortUp");
	} else {
		if(obj.hasClass("sortUp")){
			obj.removeClass("sortUp")
			obj.addClass("sortDown");
		}else{
			obj.addClass("sortUp")
			obj.removeClass("sortDown");
		}
	}
}

function removeOrderByClass(obj){
	$('trOrderBy').getElements(".orderedBy").each(function(item, index){
	    item.removeClass("orderedBy");
	});
	
	$('trOrderBy').getElements(".sortUp").each(function(item, index){
		if(obj!=item){
			item.removeClass("sortUp");
			item.addClass("unsorted");
		}
	});
	
	$('trOrderBy').getElements(".sortDown").each(function(item, index){
		if(obj!=item){
			item.removeClass("sortDown");
			item.addClass("unsorted");
		}
	});
}

function btnDeleteClickConfirm() {
	var selected = getSelectedRows($('tableData'));
	var selection = "";
	for(i=0; i<selected.length; i++){
		selection+=selected[i].getRowId();
		if(i<selected.length-1){
			selection+=";";
		}
	}
	var request = new Request({
		method: 'post',
		url: CONTEXT + URL_REQUEST_AJAX + '?action=delete&isAjax=true'+ TAB_ID_REQUEST,
		onRequest: function() { sp.show(true); },
		onComplete: function(resText, resXml) { modalProcessXml(resXml); sp.hide(true); }
	}).send('&id='+encodeURIComponent(selection) );
}

function processXMLResponseReload(ajaxCallXml){
	if (ajaxCallXml != null) {
		//recargar la pagina--- no se llama a la funcion navigate para que no borre los mensajes
		var currPage = parseInt($('navBarCurrentPage').value);
		var request = new Request({
			method: 'post',
			url: CONTEXT + URL_REQUEST_AJAX+'?action=page&isAjax=true&pageNumber='+currPage + TAB_ID_REQUEST,
			onRequest: function() { sp.show(true); },
			onComplete: function(resText, resXml) { processXMLListResponse(resXml); sp.hide(true); }
		}).send();
		
		//obtener el codigo de retorno
		var code = ajaxCallXml.getElementsByTagName("code");
		if("0" == code.item(0).firstChild.nodeValue){
			
		} else {
			//si el codigo es diferente de 0	
			var messages = ajaxCallXml.getElementsByTagName("messages");
			if (messages != null && messages.length > 0 && messages.item(0) != null) {
				messages = messages.item(0).getElementsByTagName("message");
				for(var i = 0; i < messages.length; i++) {
					var message = messages.item(i);
					var text	= message.getAttribute("text");
					showMessage(text);	
				}
			}
			
			messages = ajaxCallXml.getElementsByTagName("exceptions");
			if (messages != null && messages.length > 0 && messages.item(0) != null) {
				messages = messages.item(0).getElementsByTagName("exception");
				for(var i = 0; i < messages.length; i++) {
					var message = messages.item(i);
					var text	= message.getAttribute("text");
					showMessage(text);	
				}
			}
		}
	}
}

function validateDates(obj){
	if (obj.id.startsWith('dte')) {
		var dteStart = $('dteFrom');
		var dteEnd = $('dteTo');
	} 
	
	var datesOk = verifyDates(dteStart,dteEnd);
	var checkTime = true;
	if (!datesOk || (datesOk && !checkTime)){
		showMessage(MSG_ERROR_DATE, GNR_TIT_WARNING, 'modalWarning');
		var toClear;
		if (obj == dteStart){
			toClear = dteStart;
		} else if (obj == dteEnd){
			toClear = dteEnd;
		}
		toClear.value = "";
		if (toClear == dteStart || toClear == dteEnd){
			toClear.getNext().value = "";		
		}
	}
}


