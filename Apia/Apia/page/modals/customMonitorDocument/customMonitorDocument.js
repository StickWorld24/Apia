function initTableEvents() {
	$('mdlAccessFilters').addEvent('click', function(ele) {
		$('cusDocMonMdlOptions').toggleClass('open');
	}).addEvent('keypress', Generic.enterKeyToClickListener);
	$('cmbDocTypeId').value = parseInt(SELECTED_INDEX);
//	console.log(SELECTED_INDEX);
	setFilter();
}

function getModalReturnValue() {
	var tableData = $('tableData');
	
	if (selectionCount(tableData) > 1) {
		showMessage(GNR_CHK_ONLY_ONE, GNR_TIT_WARNING, 'modalWarning');
		return null;
	} else if (selectionCount($('tableData')) == 0) {
		showMessage(GNR_CHK_AT_LEAST_ONE, GNR_TIT_WARNING, 'modalWarning');
		return null;
	} else {
		var docLock = toBoolean(getSelectedRows($('tableData'))[0].getAttribute('docLock'));
		var docLockByCurrUsr = toBoolean(getSelectedRows($('tableData'))[0].getAttribute('dLckByCurrUsr'));
		if (docLock && !docLockByCurrUsr) {
			showMessage(MSG_DOC_LOCK_BY_OTH_USR, GNR_TIT_WARNING, 'modalWarning');	
		} else {
			var id = encodeURIComponent(getSelectedRows($('tableData'))[0].getRowId());
			return id;
		}
		
	}
}

function dwnDocumentFromDocMonMdl(downloadId) {
	createDownloadIFrame("",DOWNLOADING,URL_REQUEST_AJAX,"download","&id="+encodeURIComponent(downloadId),"","true",null);
}