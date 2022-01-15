var filters;

function initPage(){
	//crear spinner de espere un momento
	sp = new Spinner($('gridBody').getParent(),{message:WAIT_A_SECOND});
	
	//asociar eventos para los filtros
	filters = ['idFilter','nameFilter','createUserFilter','fecCreStartFilter','fecCreEndFilter'];
	filters.each(setAdmFilters);
	//eventos para orden
	$$('.allowSort').each(setAdmOrder);
	
	//tooltips para orden
	$$('.allowFilter').each(setAdmFilters);
	
	['fecCreStartFilter', 'fecCreEndFilter'].each(setDateFilters);	
	
	
	$('clearFilters').addEvent("click", function(e) {
		if(e) e.stop();
		['idFilter','nameFilter','createUserFilter'].each(clearFilter);
		['fecCreStartFilter','fecCreEndFilter'].each(clearFilterDate);	
		$('idFilter').setFilter();
	}).addEvent('keypress', Generic.enterKeyToClickListener);
	
	$$("div.button").each(function(ele){
		ele.addEvent("mouseover", function(evt) {this.toggleClass("buttonHover")});
		ele.addEvent("mouseout", function(evt) {this.toggleClass("buttonHover")});
	});
	
	$('btnStart').addEvent("click",function(e){
		
		e.stop();
		// verificar que solo un usuario est� seleccionado
		if (selectionCount($('tableData')) > 1) {
			showMessage(GNR_CHK_ONLY_ONE, GNR_TIT_WARNING, 'modalWarning');
		} else if (selectionCount($('tableData')) == 0) {
			showMessage(GNR_CHK_AT_LEAST_ONE, GNR_TIT_WARNING,'modalWarning');
		} else {
			var tokenId = TAB_ID_REQUEST.substring(TAB_ID_REQUEST.indexOf("&tokenId"));
			var id = getSelectedRows($('tableData'))[0].getRowId();
			var busEntinstId = id.split("-")[0];
			var proInstCancelId = id.split("-")[1];
			getTabContainerController().addNewTab("", "apia.execution.TaskAction.run?action=startCancelProcess&fromProCancel=true&cancelOp=true&busEntInstId=" 
												+ busEntinstId + "&proInstCancelId=" + proInstCancelId + "&proId=" + PRO_ID + tokenId);
		}
	});
	
	setDatesChecker();
	initNavButtons();
	
	callNavigate();

}

//navegar a una pagina 

//establecer un filtro
function setFilter(){
	var data = {
		txtId: $('idFilter').value,
		txtProTitle: $('nameFilter').value.toUpperCase(),		
		txtStaSta: $('fecCreStartFilter').value,
		txtStaEnd: $('fecCreEndFilter').value,	
		txtInstUser: $('createUserFilter').value.toLowerCase() 
	};
	
	$$('.allowFilter').each(function(ele) {
		data[ele.name] = ele.value;
	});
	
	callNavigateFilter(data,null);
}

function customCheckReqFilters(){
	var cantVacios = 0;
	if (filters && filters.length > 0){
		for (var i = 0; i < filters.length; i++){
			var filter = $(filters[i]);
			if (filter && (filter.value == null || filter.value == "")){
				cantVacios++;
			}
		}	
	}
	return cantVacios < filters.length;
}

function validateDates(obj){
	if (obj.id.startsWith('fecCre')) {
		var dteStart = $('fecCreStartFilter');
		var dteEnd = $('fecCreEndFilter');
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

