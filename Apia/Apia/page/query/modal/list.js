function initPage(){
	//Se verifica si existe algún error
	if ($('gridErrMsgs')) return;
	
	
	initQueryButtons();

	var btnActions = $('btnActions');
	var btnGoBack = $('btnGoBack');
	
	if (btnActions) {
		btnActions.addEvent('click', function(evt){
			var tableData = $('tableData');
			
			if (selectionCount(tableData) > 1) {
				showMessage(GNR_CHK_ONLY_ONE, GNR_TIT_WARNING, 'modalWarning');
			} else if (selectionCount($('tableData')) == 0) {
				showMessage(GNR_CHK_AT_LEAST_ONE, GNR_TIT_WARNING, 'modalWarning');
			} else {
				var id = getSelectedRows($('tableData'))[0].getRowId();
				var request = new Request({
					method: 'post',
					url: CONTEXT + URL_REQUEST_AJAX + "?action=viewActions" + TAB_ID_REQUEST,
					onRequest: function() { /* ADMIN_SPINNER.show(true); */ },
					onComplete: function(resText, resXml) { modalProcessXml(resXml); }
				}).send('id=' + id);

			}
			
		});
	}
	
	if (btnGoBack) {
		btnGoBack.addEvent('click', function(evt){
			SYS_PANELS.showLoading();
			document.location = CONTEXT + URL_REQUEST_AJAX + "?action=returnAction"  + TAB_ID_REQUEST;
		});
	}
	
	$('modalAccessFilters').addEvent('click', function(ele) {
		$('optionsContainer').toggleClass('open');
	}).addEvent('keypress', Generic.enterKeyToClickListener);
	
	initNavButtons();
	customizeRefresh();

	//Se agrega evento doble-click usado en modal de consultas
	var tableData = $('tableData');
	if (tableData){
		tableData.getParent().addEvent("dblclick", function(e){
			$(window.frameElement).fireEvent('confirmModal');
		});
	}
	
	setDatesChecker();
	callNavigateRefresh();
	
	if(OPEN_FILTER_ON_LOAD && !EXECUTED_FILTER) {
		$('optionsContainer').addClass('open');
	}
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
		var id = getSelectedRows($('tableData'))[0].getRowId();
		return id;
	}
}

function validateDates(obj){
	var dates = $('optionsContainer').getElements('input.datePicker[id^=filter]');
	var currId = obj.id;
	var numberDate;
	if (currId.endsWith('i')) {
		numberDate = Number.parseInt(currId.substring(currId.length - 2, currId.length - 1));
	} else {
		numberDate = Number.parseInt(currId.substring(currId.length - 1, currId.length));
	}

	var dteStart = dates[numberDate*2 - 2];
	var dteEnd = dates[numberDate*2 - 1];
	
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

