function initPage(){
	//crear spinner de espere un momento
	sp = new Spinner($('gridBody').getParent(),{message:WAIT_A_SECOND});
	
	Generic.updateFncImages();
	
	var btnProSus = $('btnProSus');
	if (btnProSus){
		btnProSus.addEvent("click", function(e){	
		e.stop();
		//verificar que solo un registro est� seleccionado
		if(selectionCount($('tableData')) == 0) {
			showMessage(GNR_CHK_AT_LEAST_ONE, GNR_TIT_WARNING, 'modalWarning');
		} else {
			var toSend = "";
			var rows = getSelectedRows($('tableData'));
			for (var i = 0; i < rows.length; i++) {
				if (i > 0) toSend += "&";
				toSend += "id=" + rows[i].getRowId();
			}
			var request = new Request({
				method: 'post',
				url: CONTEXT + URL_REQUEST_AJAX + '?action=suspend&isAjax=true' + TAB_ID_REQUEST,
				onRequest: function() { SYS_PANELS.showLoading(); },
				onComplete: function(resText, resXml) { modalProcessXml(resXml); }
			}).send(toSend);
		}
		});
	}
	
	var btnProCon = $('btnProCon');
	if (btnProCon){
		btnProCon.addEvent("click", function(e){	
		e.stop();
		//verificar que solo un registro est� seleccionado
		if(selectionCount($('tableData')) == 0) {
			showMessage(GNR_CHK_AT_LEAST_ONE, GNR_TIT_WARNING, 'modalWarning');
		} else {
			var toSend = "";
			var rows = getSelectedRows($('tableData'));
			for (var i = 0; i < rows.length; i++) {
				if (i > 0) toSend += "&";
				toSend += "id=" + rows[i].getRowId();
			}
			var request = new Request({
				method: 'post',
				url: CONTEXT + URL_REQUEST_AJAX + '?action=restore&isAjax=true' + TAB_ID_REQUEST,
				onRequest: function() { SYS_PANELS.showLoading(); },
				onComplete: function(resText, resXml) { modalProcessXml(resXml); }
			}).send(toSend);
		}
		});
	}
	
	['orderByRegNumber','orderByTitle','orderByState','orderByAction'].each(function(ele){
		setAdmListTitle(ele);
	});
	
	//asociar eventos para los filtros
	
	['actionFilter',
	 'stateFilter',
	 'userFilter',
	 'numRegFilter',
	 'activityFilter',	
	 'createDateFilterStart',
	 'createDateFilterEnd'
	 ].each(function(ele) {
		 setAdmFilters(ele);	
	});
	
	['createDateFilterStart', 'createDateFilterEnd'].each(setDateFilters);
	
	$('clearFilters').addEvent("click", function(e) {
		if(e) e.stop();
		['titleFilter','actionFilter','stateFilter','userFilter','numRegFilter','activityFilter'].each(clearFilter);			
		['createDateFilterStart','createDateFilterEnd'].each(clearFilterDate);
		$('titleFilter').setFilter();
	}).addEvent('keypress', Generic.enterKeyToClickListener);
	
	//eventos para order
	['orderByRegNumber','orderByTitle','orderByState','orderByAction'].each(function(ele){
		setAdmOrder(ele);
	});
	
	setDatesChecker();
	initNavButtons(URL_REQUEST_AJAX,"",['titleFilter','stateFilter'],'tableData');
	initAdminFav();
	callNavigate();
}

//navegar a una pagina 


//establecer un filtro
function setFilter(){
	callNavigateFilter({
		txtNam: $('titleFilter').value,
		cmbAct: $('actionFilter').value,
		cmbSta: $('stateFilter').value==""?defaultValue():$('stateFilter').value,
		txtInstUser: $('userFilter').value,
		filProName: $('numRegFilter').value,
		cmbBackLog: $('activityFilter').value,		
		txtStaSta: $('createDateFilterStart').value,
		txtStaEnd: $('createDateFilterEnd').value			
	},null);
}

function defaultValue(){
	var aux = "";
	var combo = $('stateFilter');
	var l = combo.length;
	var v="";
	for (var i=0;i<l;i++){
		v = combo.options[i].value;
		if (v!=""){
			aux+=v+"-";
		}
	}
	aux = aux.substring(0,aux.lastIndexOf("-"));
	return aux;
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
	if (obj.id.startsWith('create')) {
		var dteStart = $('createDateFilterStart');
		var dteEnd = $('createDateFilterEnd');
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

