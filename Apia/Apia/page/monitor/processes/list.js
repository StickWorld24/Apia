function initPage(){
	//crear spinner de espere un momento
	sp = new Spinner($('gridBody').getParent(),{message:WAIT_A_SECOND});
			 
	$$('div.fncDescriptionImage').each(function(e){
		var path = 'url(' + e.get('data-src') + ')'
		e.setStyle('background-image', path);
		e.setStyle('background-repeat', 'no-repeat');
		e.setStyle('width', '64px');
		e.setStyle('height', '64px');
	});
	
	var btnExport = $('btnExport');
	if (btnExport){
		btnExport.addEvent("click", function(e) {
		e.stop();
		var request = new Request({
			method: 'post',
			url: CONTEXT + URL_REQUEST_AJAX + '?action=prepareModalDownload&isAjax=true' + TAB_ID_REQUEST,
			onRequest: function() { SYS_PANELS.showLoading(); },
			onComplete: function(resText, resXml) { modalProcessXml(resXml); }
			}).send(); 
		});
	}
	
	var btnTasks = $('btnTasks');
	if (btnTasks){
		btnTasks.addEvent("click", function(e) {
			e.stop();
			//verificar que solo un registro est� seleccionado
			if (selectionCount($('tableData')) > 1) {
				showMessage(GNR_CHK_ONLY_ONE, GNR_TIT_WARNING, 'modalWarning');
			} else if(selectionCount($('tableData')) == 0) {
				showMessage(GNR_CHK_AT_LEAST_ONE, GNR_TIT_WARNING, 'modalWarning');
			} else {
				//obtener el registro seleccionado
				SYS_PANELS.showLoading();
				var id = getSelectedRows($('tableData'))[0].getRowId();
				window.location = CONTEXT + URL_REQUEST_AJAX + '?action=task&id=' + id + "&markSelected=true" + TAB_ID_REQUEST+"&proMaxDur="+id.split(PRIMARY_SEPARATOR)[1];
			}
		});
	}
	
	var btnDetails = $('btnDetails');
	if (btnDetails){
		btnDetails.addEvent("click", function(e) {
			e.stop();
			//verificar que solo un registro est� seleccionado
			if (selectionCount($('tableData')) > 1) {
				showMessage(GNR_CHK_ONLY_ONE, GNR_TIT_WARNING, 'modalWarning');
			} else if(selectionCount($('tableData')) == 0) {
				showMessage(GNR_CHK_AT_LEAST_ONE, GNR_TIT_WARNING, 'modalWarning');
			} else {
				//obtener el registro seleccionado
			  	SYS_PANELS.showLoading();
				var id = getSelectedRows($('tableData'))[0].getRowId();
				window.location = CONTEXT + URL_REQUEST_AJAX + '?action=details&id=' + id + "&markSelected=true" + TAB_ID_REQUEST;
			}
		});
	}
	
	var btnDocuments = $('btnDocuments');
	if (btnDocuments){
		btnDocuments.addEvent("click",function(e){
			e.stop();
			//verificar que solo un registro est� seleccionado
			if (selectionCount($('tableData')) > 1) {
				showMessage(GNR_CHK_ONLY_ONE, GNR_TIT_WARNING, 'modalWarning');
			} else if(selectionCount($('tableData')) == 0) {
				showMessage(GNR_CHK_AT_LEAST_ONE, GNR_TIT_WARNING, 'modalWarning');
			} else {
				var id = getSelectedRows($('tableData'))[0].getRowId();
				var request = new Request({
					method: 'post',
					url: CONTEXT + URL_REQUEST_AJAX + '?action=getProcessInfoForMonDocument&isAjax=true&id=' + id + TAB_ID_REQUEST,
					onRequest: function() { SYS_PANELS.showLoading(); },
					onComplete: function(resText, resXml) { modalProcessXml(resXml); }
				}).send();
			}
		});
	}
	
	var btnCloseTab = $('btnCloseTab');
	if (btnCloseTab) {
		btnCloseTab.addEvent('click', function() {
			getTabContainerController(true).removeActiveTab();
		});
	}
	
	//['btnExport','btnTasks','btnDetails','btnDocuments'].each(setTooltip);
		
	['orderByProPiority','orderByRegNumber','orderByTitle','orderByCreateUser','orderByDateCreate','orderByDateEnd'].each(function(ele){
		setAdmListTitle(ele);
		setAdmOrder(ele);
	});
	
	//asociar eventos para los filtros	
	
	[
	 	'activityFilter',
		 'numRegFilter',
		 'titleFilter',
		 'actionFilter',
		 'userFilter',
		 'statusFilter',
		 'priorityFilter',
		 'createDateFilterStart',
		 'createDateFilterEnd',
		 'endDateFilterStart',
		 'endDateFilterEnd',
		 'alertDateFilterStart',
		 'alertDateFilterEnd',
		 'overdueDateFilterStart',
		 'overdueDateFilterEnd'
	 ].each(setAdmFilters);

	[
		'createDateFilterStart',
		'createDateFilterEnd',
		'endDateFilterStart',
		'endDateFilterEnd',
		'alertDateFilterStart',
		'alertDateFilterEnd',
		'overdueDateFilterStart',
		'overdueDateFilterEnd',
	 ].each(setDateFilters);
	
	$('clearFilters').addEvent("click", function(e) {
		if(e) e.stop();
		['activityFilter','numRegFilter','titleFilter','actionFilter','statusFilter','priorityFilter','userFilter','statusFilter'].each(clearFilter);
		['createDateFilterStart','createDateFilterEnd','endDateFilterStart','endDateFilterEnd','alertDateFilterStart','alertDateFilterEnd',
		 'overdueDateFilterStart','overdueDateFilterEnd'].each(clearFilterDate);
		$('statusFilter').selectedIndex=1;
		$('titleFilter').setFilter(false);
	}).addEvent('keypress', Generic.enterKeyToClickListener);
	
	//eventos para order
	
	initNavButtons();
	
	setDatesChecker()
	
	if (!BACK){
		//callNavigate();
		var gridBody = $('gridBody');
		firstTimeMsg = new Element('div', {'class': 'noDataMessage', html: MSG_FIRST_TIME}).inject(gridBody);
		firstTimeMsg.setStyle('display','');
		firstTimeMsg.setStyle("width",gridBody.getStyle("width"));
		firstTimeMsg.position( {
			relativeTo: gridBody,
			position: 'upperLeft'
		});
		gridBody.noDataMessage = firstTimeMsg;
	}else{
		setFilter(true);
	}
	
	initAdminFav();
	initPinGridOptions();
}

//navegar a una pagina 
function callNavigateFilterProcesses(strParams,url){
	hideMessage();
	if(!url)
		url = URL_REQUEST_AJAX;
	
	var request = new Request({
		method: 'post',	
		data: strParams,
		url: CONTEXT + url + '?action=filterProcesses&isAjax=true' + TAB_ID_REQUEST,
		onRequest: function() { sp.show(true); },
		onComplete: function(resText, resXml) { modalProcessXml(resXml); sp.hide(true); }
	}).send(strParams);
}

//establecer un filtro
function setFilter(b){
	callNavigateFilterProcesses({
		cmbBackLog: $('activityFilter').value,		
		filProName: $('numRegFilter').value,
		txtNam: $('titleFilter').value,
		//txtProTitle: $('titleFilter').getSelected()[0].text,
		cmbAct: $('actionFilter').value,
		txtInstUser: $('userFilter').value,
		cmbSta: $('statusFilter').value,
		cmbPriority: $('priorityFilter').value,
		txtStaSta: $('createDateFilterStart').value,
		txtStaEnd: $('createDateFilterEnd').value,
		txtEndSta: $('endDateFilterStart').value,
		txtEndEnd: $('endDateFilterEnd').value,
		txtWarnSta: $('alertDateFilterStart').value,
		txtWarnEnd: $('alertDateFilterEnd').value,
		txtOverdueSta: $('overdueDateFilterStart').value,
		txtOverdueEnd: $('overdueDateFilterEnd').value,
		back:b
	},null);
}

function btnDeleteClickConfirm() {
	var selected = getSelectedRows($('tableData'));
	var selection = "";
	for(i=0; i<selected.length; i++){
		selection+=selected[i].getRowId();
		if(i<selected.length-1)
			selection+=";";
	}
	var request = new Request({
		method: 'post',
		url: CONTEXT + URL_REQUEST_AJAX + '?action=delete&isAjax=true&id='+selection + TAB_ID_REQUEST,
		onRequest: function() { sp.show(true); },
		onComplete: function(resText, resXml) { modalProcessXml(resXml); sp.hide(true); }
	}).send();
}

function download(){
	
	var pdf = $('pdf'); 
	var excel = $('excel'); 
	
	var all = $('all'); 
	
	var format = "csv";
	var count = "actual";
	if (pdf.checked){
		format="pdf";
	} else if (excel.checked){
		format = "excel";
	}
	
	if (all.checked)
		count = "all";
	
	hideMessage();
	createDownloadIFrame("",DOWNLOADING,URL_REQUEST_AJAX,"download","&count="+count+"&format="+format,"","",null);
}

function openMonDocument(procTitle, procRegInst, busEntTitle, busEntRegInst){
	SYS_PANELS.closeAll();
	var tabContainer = window.parent.document.getElementById('tabContainer');
	var url = CONTEXT + URL_REQUEST_AJAX_MON_DOCUMENT + '?action=init&favFncId=54&preFilProcess=true&procTitle=' + procTitle + '&procRegInst=' + procRegInst + '&busEntTitle=' + busEntTitle + '&busEntRegInst=' + busEntRegInst + TAB_ID_REQUEST;
	tabContainer.addNewTab(MON_DOC_TAB_TITLE,url,null);		
}

function validateDates(obj){
	if (obj.id.startsWith('create')) {
		var dteStart = $('createDateFilterStart');
		var dteEnd = $('createDateFilterEnd');
	} else if (obj.id.startsWith('end')) {
		var dteStart = $('endDateFilterStart');
		var dteEnd = $('endDateFilterEnd');
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
//		} else if (obj == hrMinStart){
//			toClear = hrMinStart;
		} else if (obj == dteEnd){
			toClear = dteEnd;
//		} else {
//			toClear = hrMinEnd;
		}
		toClear.value = "";
		if (toClear == dteStart || toClear == dteEnd){
			toClear.getNext().value = "";		
		}
	}
}
