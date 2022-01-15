function initPage(){
	getTabContainerController().changeTabState(TAB_ID, false); 
	
	//crear spinner de espere un momento
	sp = new Spinner($('gridBody').getParent(),{message:WAIT_A_SECOND});

	['orderByName','orderByTitle','orderByDesc','orderByRegUser','orderByRegDate'].each(setAdmOrder);
	['orderByName','orderByTitle','orderByDesc','orderByRegUser','orderByRegDate'].each(setAdmListTitle);
	['nameFilter','titleFilter','descFilter','regUsrFilter','regUsrFilter'].each(setAdmFilters);
	['regDateFilter'].each(setDateFilters);
	
	$('clearFilters').addEvent("click", function(e) {
		if(e) e.stop();
		['nameFilter','titleFilter','descFilter','regUsrFilter'].each(clearFilter);
		['regDateFilter'].each(clearFilterDate);
		$('nameFilter').setFilter();
	}).addEvent('keypress', Generic.enterKeyToClickListener);
	
	initAdminActions(null,null,null,true,null, null, funcBeforeDelete);
	initNavButtons();
	
	$('btnCustomDelete').addEvent('click', funcBeforeDelete);
	
	callNavigate();
}

//establecer un filtro
function setFilter(){
	callNavigateFilter({
			txtName: $('nameFilter').value,
			txtTitle: $('titleFilter').value,
			txtDesc: $('descFilter').value,
			txtRegUser: $('regUsrFilter').value,
			txtRegDate: $('regDateFilter').value
		},null);
}

function funcBeforeDelete(e){
	if (e) e.stop();
	
	var selected = getSelectedRows($('tableData'));
	var selection = "";
	for (i = 0; i < selected.length; i++) {
		selection += selected[i].getRowId();
		if (i < selected.length - 1) {
			selection += ";";
		}
	}
	if(PRIMARY_SEPARATOR_IN_BODY) {
		new Request({
			method : 'post',
			url : CONTEXT + URL_REQUEST_AJAX + '?action=haveTranslations&isAjax=true' + TAB_ID_REQUEST,			
			onComplete : processBeforeDeleteAction
		}).send('id=' + selection);
	} else {
		new Request({
			method : 'post',
			url : CONTEXT + URL_REQUEST_AJAX + '?action=haveTranslations&isAjax=true&id=' + selection + TAB_ID_REQUEST,			
			onComplete : processBeforeDeleteAction
		}).send();
	}
}

function processBeforeDeleteAction(resText, resXml){
	try {
		var haveTranslations = toBoolean(resXml.getElementsByTagName('data')[0].getAttribute('haveTranslations'));
		if (haveTranslations){
			showConfirm(LABEL_CONFIRM_DEL_WITH_TRANS, GNR_TIT_WARNING, 
				function(ret){ if (ret) btnDeleteClickConfirm(); }, 'modalWarning');
			return;			
		}
	} catch (err){}
	
	$('btnDelete').click();	
}