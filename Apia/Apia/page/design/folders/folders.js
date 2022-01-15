var fldSp;

function initPage(){

	fldSp = new Spinner($('gridBody').getParent(),{message:WAIT_A_SECOND});
	
	initAdminActions();
	
	['filterName', 'filterStDte', 'filterEndDte'].each(setAdmFilters);
	['filterStDte', 'filterEndDte'].each(setDateFilters);
	
	Array.from($('navRefresh').getParents()[1].childNodes).each(function(elem) {
		if (elem.nodeType == Node.ELEMENT_NODE) {
			elem.setStyle('display', 'none');
			if (elem.childNodes.length > 0 && elem.getChildren('div').length > 0 && elem.getChildren('div')[0].hasClass('btnRefresh')) 
				elem.setStyle('display', '');
		}
	});
	
	$('clearFilters').addEvent('click', function(evt) {
		if (evt) evt.stop();
		['filterName'].each(clearFilter);
		['filterStDte', 'filterEndDte'].each(clearFilterDate);
		$('filterOrder').value = 1;
		setFilter();
	}).addEvent('keypress', Generic.enterKeyToClickListener)
	
	$('navRefresh').addEvent('click', function(evt) {
		if (evt) evt.stop();
		setFilter();
	});
	
	var btnCreate = $('btnCreate');
	var btnUpdate = $('btnUpdate');
	var btnDelete = $('btnDelete');
	var btnClon = $('btnClone');
	var btnDependencies = $('btnDependencies');
	var btnClose = $('btnClose');
	
	if (btnCreate) {
		btnCreate.removeEvents('click');
		btnCreate.addEvent('click', function(evt) {
			var selected = $$('span.folderText.selected');
			if (selected.length > 0 && selected[0].getParent('li').hasClass('uneditable')) {
				showMessage(MSG_NO_ENOUGH_PERMS, GNR_TIT_WARNING, 'modalWarning');
			} else {
				var id = selected.length > 0 ? selected[0].getParent('li').getAttribute('id') : 0;
				var request = new Request({
					method: 'post',
					url: CONTEXT + URL_REQUEST_AJAX + '?action=startCreate&isAjax=true' + TAB_ID_REQUEST,
					onRequest: function() { SYS_PANELS.showLoading(); },
					onComplete: function(resText, resXml) { modalProcessXml(resXml); }
				}).send('id=' + id);
			}
		})
	};
	
	if (btnUpdate) {
		btnUpdate.removeEvents('click');
		btnUpdate.addEvent('click', function(evt) {
			var selected = $$('span.folderText.selected');
			if (selected.length == 0) {
				showMessage(GNR_CHK_AT_LEAST_ONE, GNR_TIT_WARNING, 'modalWarning');
			} else {
				var id = selected[0].getParent('li').getAttribute('id');
				var request = new Request({
					method: 'post',
					url: CONTEXT + URL_REQUEST_AJAX + '?action=startUpdate&isAjax=true' + TAB_ID_REQUEST,
					onRequest: function() { SYS_PANELS.showLoading(); },
					onComplete: function(resText, resXml) { modalProcessXml(resXml); }
				}).send('id=' + id);
			}
		});
	}
	
	if (btnDelete) {
		btnDelete.removeEvents('click');
		btnDelete.addEvent('click', function(evt) {
			var selected = $$('span.folderText.selected');
			if (selected.length == 0) {
				showMessage(GNR_CHK_AT_LEAST_ONE, GNR_TIT_WARNING, 'modalWarning');
			} else {
				SYS_PANELS.newPanel();
				var panel = SYS_PANELS.getActive();
				panel.addClass("modalWarning");
				panel.header.innerHTML = GNR_TIT_WARNING;
				panel.content.innerHTML = LBL_FLDS_WILL_BE_DELETED;
												
				panel.footer.innerHTML = "<div class='button' onClick=\"SYS_PANELS.closeAll(); deleteTreeFld();\">" + BTN_CONFIRM + "</div>";	
				SYS_PANELS.addClose(panel);
				SYS_PANELS.refresh();
			}
		});
	}
	
	if (btnClon) {
		btnClon.removeEvents('click');
		btnClon.addEvent("click", function(e) {
			e.stop();
			var selected = $$('span.folderText.selected');
			if (selected.length > 1) {
				showMessage(GNR_CHK_ONLY_ONE, GNR_TIT_WARNING, 'modalWarning');
			} else if (selected.length == 0) {
				showMessage(GNR_CHK_AT_LEAST_ONE, GNR_TIT_WARNING, 'modalWarning');
			} else {
				var id = selected[0].getParent('li').getAttribute('id');
				var request = new Request({
					method : 'post',
					url : CONTEXT + URL_REQUEST_AJAX + '?action=clone&isAjax=true' + TAB_ID_REQUEST,
					onRequest : function() { SYS_PANELS.showLoading(); },
					onComplete : function(resText, resXml) {
						SYS_PANELS.closeAll();
						modalProcessXml(resXml);
					}
				}).send('id=' + id);
			}
		});
	}

	if (btnDependencies) {
		btnDependencies.removeEvents('click');
		btnDependencies.addEvent("click", function(e) {
			e.stop();
			var selected = $$('span.folderText.selected');
			if (selected.length > 1) {
				showMessage(GNR_CHK_ONLY_ONE, GNR_TIT_WARNING, 'modalWarning');
			} else if (selected.length == 0) {
				showMessage(GNR_CHK_AT_LEAST_ONE, GNR_TIT_WARNING, 'modalWarning');
			} else {
				// obtener el usuario seleccionado
				var id = selected[0].getParent('li').getAttribute('id');
				var request = new Request({
					method : 'post',
					url : CONTEXT + URL_REQUEST_AJAX + '?action=loadDeps&isAjax=true&id=' + id + TAB_ID_REQUEST,
					onRequest : function() { SYS_PANELS.showLoading(); },
					onComplete : function(resText, resXml) { modalProcessXml(resXml); }
				}).send();

			}
		});
	}
	
	if ($('collapseStruct')) {
		$('collapseStruct').addEvent('click', function(evt) {
			if (evt) evt.stop();
			collapseAll();
		});
	}
	
	
	initFoldersModalCreate();
	initPoolMdlPage();
	initUsrMdlPage();
	
//	initNavButtons();
	
	loadHtmlStructure(false, 'foldersStruct');
//	
	var gridBody = $('gridBody');
	firstTimeMsg = new Element('div', {'class': 'noDataMessage', html: MSG_NO_ELEMENTS}).inject(gridBody);
	firstTimeMsg.setStyle('display','none');
	firstTimeMsg.setStyle("width",gridBody.getStyle("width"));
	firstTimeMsg.position( {
		relativeTo: gridBody,
		position: 'upperLeft'
	});
	gridBody.noDataMessage = firstTimeMsg;
}

function setFilter() {
	callNavigateFilterFolders({
		txtName: $('filterName').value,
		dteSt: $('filterStDte').value,
		dteEnd: $('filterEndDte').value
	},null);
}

function callNavigateFilterFolders(params) {
	$('gridBody').noDataMessage.setStyle('display','none');
	var request = new Request({
		method: 'post',	
		data: params,
		url: CONTEXT + URL_REQUEST_AJAX + '?action=filterFolders&isAjax=true' + TAB_ID_REQUEST,
		onRequest: function() { SYS_PANELS.showLoading(); },
		onComplete: function(resText, resXml) { 
			customModalDeleteXml(); 
			SYS_PANELS.closeActive(); }
	}).send(params);
}

function endCloneFunction() {
	var sXml = getLastFunctionAjaxCall();
	var xml = sXml.getElementsByTagName('secondXml')[0];

	console.log(sXml);
	console.log(xml);
	
	if (!(xml.getElementsByTagName("sysExceptions").length != 0 || xml.getElementsByTagName("exceptions").length != 0 || xml.getElementsByTagName("sysMessages").length != 0)) {
		SYS_PANELS.closeAll();
	}

	addNewFolder(sXml);
	modalProcessXml(xml);
}


function evaluateStartCreateFolder() {
	SYS_PANELS.closeAll();
	var xml = getLastFunctionAjaxCall();
//	console.log(xml);
//	var id = $$('span.folderText.selected') != null && $$('span.folderText.selected').length > 0 ? $$('span.folderText.selected')[0].getParent('li').getAttribute('id') : 1;
	showFoldersCreateModal(xml.getAttribute('selected'));
}

function customModalDeleteXml(xml) {
	$$('li.folder').each(function(elem) {
		elem.destroy();
	});
	
	$$('ul.directory').each(function(elem) {
		elem.destroy();
	});
	
	$('foldersStruct').innerHTML = '';
	loadHtmlStructure(false, 'foldersStruct');
	
//	if (xml) modalProcessXml(xml);
	
//	SYS_PANELS.closeLoading();
}

function addNewFolder(xml) {
	if (xml.getElementsByTagName('folderContainer') != null && xml.getElementsByTagName('folderContainer').length > 0) {
		
		var dir = xml.getElementsByTagName('folderContainer')[0];
		
		var whereToAdd = $('foldersStruct').getElementById(dir.childNodes[0].getAttribute('parent'));
		var ulToAdd;
		if (whereToAdd == null) {
			ulToAdd = $('foldersStruct');
		} else if (whereToAdd.getElementsByTagName('ul') != null && whereToAdd.getElementsByTagName('ul').length == 0) {
			ulToAdd = new Element('ul', {'class':'directory'});
			ulToAdd.inject(whereToAdd);
			whereToAdd.removeClass('leaf').removeClass('closeFld').addClass('subroot').addClass('openFld');
		} else {
			ulToAdd = whereToAdd.getElementsByTagName('ul')[0];
		}
		
		var toAdd = createFolderInStructure(dir.childNodes[0]);
		toAdd.inject(ulToAdd);
		
		loadEventsToArrays([toAdd.getElementsByClassName('toggler')[0]], [toAdd])
		
		sortViewStructure();
		toAdd.fireEvent('click');
		focusOnFolder(toAdd);
		if ($('chkSwLastModMade').checked) {
			toAdd.getChildren('span.mainSpan')[0].getChildren('span.folderExtraInfo')[0].setStyle('display', '');
		}
		
		if (gridBody && gridBody.noDataMessage) $(gridBody.noDataMessage).setStyle('display','none');
	}
}

function sortViewStructure() {
	var sortProperties = {
			name: false,
			date: false,
			asc: false
		};
		
		switch($('filterOrder').value) {
			case '1':
				sortProperties.name = true;
				sortProperties.asc = true;
				break;
			case '2':
				sortProperties.name = true;
				sortProperties.asc = false;
				break;
			case '3':
				sortProperties.date = true;
				sortProperties.asc = true;
				break;
			case '4':
				sortProperties.date = true;
				sortProperties.asc = false;
				break;
		}
		
		sortStructure($('foldersStruct'), sortProperties.name, sortProperties.date, sortProperties.asc);
		collapseAll();
}

function processUpdateData() {
//	SYS_PANELS.closeActive();
	var xml = getLastFunctionAjaxCall();
	
	processFolderUpdateXml(xml);
}

function processFolderUpdateXml(xml) {
	var parentId = xml.getElementsByTagName('data')[0].getAttribute('parent');
	var name = xml.getElementsByTagName('data')[0].getAttribute('name');
	var modify = xml.getElementsByTagName('data')[0].getAttribute('allEdit');
	var description = xml.getElementsByTagName('data')[0].getAttribute('desc');
		
	showFoldersCreateModal(parentId);
	$('dirModalName').value = name;
	$('dirModalDesc').value = description;
	$('selDocAllPoolPerm').value = modify;
	
	var permsExisting = $('scrollOptions').getElementsByClassName('option canRemove');
	if (permsExisting && permsExisting.length > 0) {
		permsExisting[0].getElementsByClassName('optionRemove')[0].fireEvent('click');
	}
	
	var newPerms = xml.getElementsByTagName('permissions');
	if (newPerms && newPerms.length > 0) {
		var userPerms = newPerms[0].getElementsByTagName('userPerm');
		var poolPerms = newPerms[0].getElementsByTagName('poolPerm');
		if (userPerms && userPerms.length > 0) {
			Array.from(userPerms).each(function(elem) {
				dirProcessModalReturn(elem.getAttribute('login'), elem.getAttribute('usrId'), elem.getAttribute('edit') === 'M', false);
			});
		}
		if (poolPerms && poolPerms.length > 0) {
			Array.from(poolPerms).each(function(elem) {
				dirProcessModalReturn(elem.getAttribute('poolId'), elem.getAttribute('poolName'), elem.getAttribute('edit') === 'M', true);
			});
		}
	}
	
	var selected = $$('span.folderText.selected');
	if (selected[0].getParent('li').hasClass('uneditable')) {
		$('dirModalName').disabled = true;
		$('dirModalDesc').disabled = true;
		$('selDocAllPoolPerm').disabled = true;
		$('cmbFoldChose').disabled = true;
		
		$('mdlFolderAddPool').removeEvents('click');
		$('mdlFolderAddUser').removeEvents('click');
		
		if ($('scrollOptions').getElementsByClassName('option canRemove').length > 0) {
			Array.from($('scrollOptions').getElementsByClassName('option canRemove')).each(function (prm) {
				prm.getElementsByClassName('optionRemove')[0].setStyle('display', 'none');
				prm.getElementsByTagName('input')[2].disabled = true;
			});
		}
	}
	
	SYS_PANELS.closeActive();
}

function showHideDate(chk) {
	$$('span.folderExtraInfo').each(function(elem){
		elem.setStyle('display', chk.checked ? '' : 'none');
	});
}

function focusOnFolder(liElem) {
	openFolderTree(liElem);
	liElem.fireEvent('click');
	liElem.scrollIntoView(false);
}

function openFolderTree(from) {
	var liParent = from.getParent('li');
	if (liParent != null && liParent != undefined && liParent.hasClass('subroot')) {
		liParent.fireEvent('dblclick');
		openFolderTree(liParent);
	}
}

function deleteTreeFld() {
	var id = $$('span.folderText.selected')[0].getParent('li').getAttribute('id');
	var request = new Request({
		method: 'post',
		url: CONTEXT + URL_REQUEST_AJAX + '?action=delete&isAjax=true' + TAB_ID_REQUEST,
		onRequest: function() { SYS_PANELS.showLoading(); },
		onComplete: function(resText, resXml) { /*customModalDeleteXml(resXml);*/ modalProcessXml(resXml); }
	}).send('id=' + id);
}

