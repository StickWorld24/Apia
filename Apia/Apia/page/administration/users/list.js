function initPage(){
	getTabContainerController().changeTabState(TAB_ID, false); 
	
	//crear spinner de espere un momento
	sp = new Spinner($('gridBody').getParent(),{message:WAIT_A_SECOND});
	

	['orderByLogin','orderByLongLogin','orderByName','orderByEmail','orderByRegUser','orderByRegDate'].each(setAdmOrder);
	['orderByLogin','orderByLongLogin','orderByName','orderByEmail','orderByRegUser','orderByRegDate'].each(setAdmListTitle);
	['loginFilter','longLoginFilter','nameFilter','emailFilter','regUsrFilter','regUsrFilter'].each(setAdmFilters);
	['regDateFilter'].each(setDateFilters);
	
	$('clearFilters').addEvent("click", function(e) {
		if(e) e.stop();
		['loginFilter','longLoginFilter','nameFilter','emailFilter','regUsrFilter'].each(clearFilter);		
		['regDateFilter'].each(clearFilterDate);
		$('loginFilter').setFilter();
	}).addEvent('keypress', Generic.enterKeyToClickListener);
	
	initAdminActions();
	initNavButtons();
	
	//eventos para opciones
	$('optionLock').addEvent("click", function(e) {
		e.stop();

		if (selectionCount($('tableData')) == 0) {
			showMessage(GNR_CHK_AT_LEAST_ONE, GNR_TIT_WARNING, 'modalWarning');
		} else {
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
				url: CONTEXT + '/apia.administration.UsersAction.run?action=startUserLock&isAjax=true&id='+selection+ TAB_ID_REQUEST,
				onRequest: function() { SYS_PANELS.showLoading(); },
				onComplete: function(resText, resXml) { modalProcessXml(resXml); }
			}).send();
		}
	});
	
	$('optionUnlock').addEvent("click", function(e) {
		e.stop();
		hideMessage();
		if (selectionCount($('tableData')) == 0) {
			showMessage(GNR_CHK_AT_LEAST_ONE, GNR_TIT_WARNING, 'modalWarning');
		} else {
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
				url: CONTEXT + '/apia.administration.UsersAction.run?action=unlockUsers&isAjax=true&id='+selection + TAB_ID_REQUEST,
				onRequest: function() { SYS_PANELS.showLoading(); },
				onComplete: function(resText, resXml) { modalProcessXml(resXml); }
			}).send();
		}
	});
	
	$('optionDownload').addEvent("click", function(e){
		e.stop();
		$('downloadIframe').set('src', CONTEXT + URL_REQUEST_AJAX + '?action=downloadExcel' + TAB_ID_REQUEST);
		Generic.showWaitingForDownload();
	});
	
	$('optionUpload').addEvent("click", function(e){
		e.stop();
		hideMessage();
		
		var request = new Request({
			method: 'post',
			url: CONTEXT + '/apia.administration.UsersAction.run?action=ajaxUploadStart&isAjax=true&' + TAB_ID_REQUEST,
			onRequest: function() { SYS_PANELS.showLoading(); },
			onComplete: function(resText, resXml) { modalProcessXml(resXml); }
		}).send();
	});
	
	
	$('optionUserTreeFunc').addEvent("click", function(e) {
		e.stop();
		hideMessage();
		// verificar que solo un usuario este seleccionado
		if (selectionCount($('tableData')) > 1) {
			showMessage(GNR_CHK_ONLY_ONE, GNR_TIT_WARNING, 'modalWarning');
		} else if (selectionCount($('tableData')) == 0) {
			showMessage(GNR_CHK_AT_LEAST_ONE, GNR_TIT_WARNING, 'modalWarning');
		} else {
			var selectedUser = getSelectedRows($('tableData'))[0].getAttribute('data-id');
			showUserTreeFncsModal(selectedUser, CURRENT_ENVIRONMENT);
		}
	});
	
	initUserFncTreeMdlPage();
	
	callNavigate();
 
}

//establecer un filtro
function setFilter(){
	callNavigateFilter({
			txtLogin: $('loginFilter').value,
			txtLongLogin: $('longLoginFilter').value,
			txtName: $('nameFilter').value,
			txtEmail: $('emailFilter').value,
			txtRegUser: $('regUsrFilter').value,
			txtRegDate: $('regDateFilter').value
		},null);
}


function fncLdapModal(){
	hideFirst = false;
	USERMODAL_EXTERNAL = true;
	USERMODAL_SELECTONLYONE	= true;
	initUsrMdlPage();
	showUsersModal(processUsersModalReturn);
}

function processUsersModalReturn(ret){
	hideFirst = true;
	ret.each(function(e){
		var login = e.getRowContent()[0];
		var name = e.getRowContent()[1];
		var mail = e.getRowContent()[2];
		$('usrLogin').value = login;
		$('usrName').value = name;
		$('usrEmail').value = mail;
		$('usrPwd').value = login;
		
	});
}