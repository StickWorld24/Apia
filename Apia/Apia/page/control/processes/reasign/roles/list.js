function initPage(){
	sp = new Spinner($('gridBody').getParent(),{message:WAIT_A_SECOND});
	
	$$('div.fncDescriptionImage').each(function(e){
		var path = 'url(' + e.get('data-src') + ')'
		e.setStyle('background-image', path);
		e.setStyle('background-repeat', 'no-repeat');
		e.setStyle('width', '64px');
		e.setStyle('height', '64px');
	});
	
	['orderByProPiority','orderByRegNumber','orderByTitle','orderByAction','orderByCreateUser','orderByDateCreate'].each(function(ele){
		setAdmListTitle(ele);
		setAdmOrder(ele);
	});
	
	['activityFilter','numRegFilter','titleFilter','actionFilter','userFilter','priorityFilter','createDateFilterStart','createDateFilterEnd',
		'alertDateFilterStart','alertDateFilterEnd','overdueDateFilterStart','overdueDateFilterEnd'].each(setAdmFilters);

	['createDateFilterStart','createDateFilterEnd','alertDateFilterStart','alertDateFilterEnd','overdueDateFilterStart','overdueDateFilterEnd'].each(setDateFilters);
	
	$('clearFilters').addEvent("click", function(e) {
		if(e) e.stop();
		['activityFilter','numRegFilter','titleFilter','actionFilter','priorityFilter','userFilter'].each(clearFilter);
		['createDateFilterStart','createDateFilterEnd','alertDateFilterStart','alertDateFilterEnd','overdueDateFilterStart','overdueDateFilterEnd'].each(clearFilterDate); 
		$('activityFilter').setFilter();
	}).addEvent('keypress', Generic.enterKeyToClickListener);
	
	//Reasignar
	$('btnReaRol').addEvent("click", function(e) {
		e.stop();
		//verificar que solo un registro est� seleccionado
		if (selectionCount($('tableData')) > 1) {
			showMessage(GNR_CHK_ONLY_ONE, GNR_TIT_WARNING, 'modalWarning');
		} else if(selectionCount($('tableData')) == 0) {
			showMessage(GNR_CHK_AT_LEAST_ONE, GNR_TIT_WARNING, 'modalWarning');
		} else {
			var id = getSelectedRows($('tableData'))[0].getRowId();			
			showReasignRolesModal(id);
		}		
	});
	//['btnReaRol'].each(setTooltip);
	
	setDatesChecker();
	initReasignRolesMdlPage();
	initAdminFav();
	initNavButtons();
	
	var gridBody = $('gridBody');
	firstTimeMsg = new Element('div', {'class': 'noDataMessage', html: MSG_FIRST_TIME}).inject(gridBody);
	firstTimeMsg.setStyle('display','');
	firstTimeMsg.setStyle("width",gridBody.getStyle("width"));
	firstTimeMsg.position( {
		relativeTo: gridBody,
		position: 'upperLeft'
	});
	gridBody.noDataMessage = firstTimeMsg;	
}

//establecer un filtro
function setFilter(){
	callNavigateFilter({
		cmbBackLog: $('activityFilter').value,		
		filProName: $('numRegFilter').value,
		txtNam: $('titleFilter').value,
		cmbAct: $('actionFilter').value,
		txtInstUser: $('userFilter').value,
		cmbPriority: $('priorityFilter').value,
		txtStaSta: $('createDateFilterStart').value,
		txtStaEnd: $('createDateFilterEnd').value,
		txtWarnSta: $('alertDateFilterStart').value,
		txtWarnEnd: $('alertDateFilterEnd').value,
		txtOverdueSta: $('overdueDateFilterStart').value,
		txtOverdueEnd: $('overdueDateFilterEnd').value
	},null);
}

function validateDates(obj){
	if (obj.id.startsWith('create')) {
		var dteStart = $('createDateFilterStart');
		var dteEnd = $('createDateFilterEnd');
	} else if (obj.id.startsWith('alert')) {
		var dteStart = $('alertDateFilterStart');
		var dteEnd = $('alertDateFilterEnd');
	} else if (obj.id.startsWith('overdue')) {
		var dteStart = $('overdueDateFilterStart');
		var dteEnd = $('overdueDateFilterEnd');
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

