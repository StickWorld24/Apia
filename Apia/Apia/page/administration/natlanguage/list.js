var sp;

function initPage() {
	
//	//crear spinner de espere un momento
	sp = new Spinner($('gridBody').getParent(),{message:WAIT_A_SECOND});

	['orderByName','orderByTitle','orderByDesc', 'orderByLanguage', 'orderByRegUser','orderByRegDate'].each(setAdmOrder);
	['orderByName','orderByTitle','orderByDesc','orderByLanguage', 'orderByRegUser','orderByRegDate'].each(setAdmListTitle);
	['nameFilter','titleFilter','descFilter', 'langFilter', 'regUsrFilter','regUsrFilter'].each(setAdmFilters);
	['regDateFilter'].each(setDateFilters);
	
	$('clearFilters').addEvent("click", function(e) {
		if(e) e.stop();
		['nameFilter','titleFilter','descFilter', 'langFilter', 'regUsrFilter', 'typeFilter', 'langFilter'].each(clearFilter);
		['regDateFilter'].each(clearFilterDate);
		$('nameFilter').setFilter();
	}).addEvent('keypress', Generic.enterKeyToClickListener);
	
	var btnDwn = $('optionDownload');
	if (btnDwn) {
		btnDwn.addEvent('click', function(e) {
			if (selectionCount($('tableData')) == 0) {
				showMessage(GNR_CHK_AT_LEAST_ONE, GNR_TIT_WARNING, 'modalWarning');		
			} else {
				var rows = getSelectedRows($('tableData'));
				var rowsId = '';
				for (i = 0; i < rows.length; i++) {
					rowsId += rows[i].getRowId();
					if (i < rows.length - 1) {
						rowsId += ";";
					}
				}
				
				sp = new Spinner($('tableData'),{message:WAIT_A_SECOND});
				createDownloadIFrame(TIT_DOWNLOAD, CONTENT_DOWNLOAD, URL_REQUEST_AJAX, "download", "&id=" + rowsId, "", "", null);
			}
		})
	}
	
	var btnDwnAll = $('optionDownloadAll');
	if (btnDwnAll) {
		btnDwnAll.addEvent('click', function(e) {
			var table = $('tableData').children;
			var ids = '';
			if (table && table.length > 0) {
				for (i = 0; i < table.length; i++) {
					ids += table[i].getAttribute('data-rowId');
					if (i < table.length - 1) {
						ids += ";"; 
					}
				}
			}
			if (ids == '') {
				showMessage(NO_ELEMS_TO_DOWNLOAD, GNR_TIT_WARNING, 'modalWarning');
			} else {
				sp = new Spinner($('tableData'),{message:WAIT_A_SECOND});
				createDownloadIFrame(TIT_DOWNLOAD, CONTENT_DOWNLOAD, URL_REQUEST_AJAX, "download", "&id=" + ids, "", "", null);
			}
		})
	}
	
	initAdminActions(false, false, false, false, true, false);
	initNavButtons();
	
	callNavigate();
}

function setFilter(){
	callNavigateFilter({
			txtName		: $('nameFilter').value,
			txtTitle	: $('titleFilter').value,
			txtDesc		: $('descFilter').value,
			txtRegUser	: $('regUsrFilter').value,
			txtRegDate	: $('regDateFilter').value,
			txtLangId	: $('langFilter').value,
			txtType		: $('typeFilter').value,
			
			
		},null);
}

function setFilterAndPopuate() {
	setFilter();
}