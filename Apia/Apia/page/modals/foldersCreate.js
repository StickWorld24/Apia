var FOLDERS_HIDE_OVERFLOW = true; 

function initFoldersModalCreate() {
	var mdlFoldersCreator = $('mdlFoldersCreator');
	if (mdlFoldersCreator && mdlFoldersCreator.initDone) return;
	mdlFoldersCreator.initDone = true;
	
	$('frmModalFolderCreate').formChecker = new FormCheck(
		'frmModalFolderCreate',
		{
			submit:false,
			display : {
				keepFocusOnError : 1,
				tipsPosition: 'left',
				tipsOffsetX: -10
			}
		}
	);
	
	mdlFoldersCreator.blockerModal = new Mask();
	
	var mdlFolderAddPool = $('mdlFolderAddPool');
	var mdlFolderAddUser = $('mdlFolderAddUser');
	var btnCloseFolderCrModal = $('btnCloseFolderCrModal');
	var btnConfirmFolderCrModal = $('btnConfirmFolderCrModal');
	
	if (btnCloseFolderCrModal) {
		btnCloseFolderCrModal.addEvent("click", closeFolderCreateModal);
		btnCloseFolderCrModal.addEvent('keypress', Generic.enterKeyToClickListener);
	}
	
	if (btnConfirmFolderCrModal) {
		btnConfirmFolderCrModal.addEvent('click', function onClick(evt) {
			var form = $('frmModalFolderCreate');
			if(!form.formChecker.isFormValid()){
				return;
			}
			var parameters = processFolderFrm();
			new Request({
				method: 'post',
				url: CONTEXT + URL_REQUEST_AJAX + '?action=confirm&isAjax=true' + TAB_ID_REQUEST,
				onRequest: function() { SYS_PANELS.showLoading(); },
				onComplete: function(resText, resXml) {	processMdlConfirmReturn(resXml); },
			}).send(parameters);
		});
		
		btnConfirmFolderCrModal.addEvent('keypress', Generic.enterKeyToClickListener);
		
		btnConfirmFolderCrModal.addEvent('keydown', function(e) {
			if(!e.shift && e.key == 'tab') {
				e.preventDefault();
				mdlFoldersCreator.focus();
			}
		});
	}
	
	mdlFoldersCreator.addEvent('keydown', function(e) {
		if(e.target == mdlFoldersCreator && e.shift && e.key == 'tab') {
			e.preventDefault();
			btnConfirmFolderCrModal.focus();
		}
	});
}

function loadComboStructure(parentId) {
	Array.from($('cmbFoldChose').options).each(function(opt) {
		opt.destroy();
	});
	
	$('cmbFoldChose').innerHTML = '';
	new Element('option', {'text':''}).inject($('cmbFoldChose'));
	
	new Request({
		method: 'post',
		url: CONTEXT + URL_REQUEST_AJAX + '?action=loadFolderStructure&isAjax=true&forList=true' + TAB_ID_REQUEST,
		onRequest: function() { /*SYS_PANELS.showLoading();*/ },
		onComplete: function(resText, resXml) {	
//			SYS_PANELS.closeActive();
			populateComboWithFolders(resXml, parentId); },
	}).send();
}

function populateComboWithFolders(xml, folderId) {
	/*
	 * pongo dentro del option dos tags: uno que contiene la identacion y otro que contenga mismo el texto de la opcion
	 * */
	if (xml.getElementsByTagName('folder') != null && xml.getElementsByTagName('folder').length > 0) {	//siempre viene al menos el ROOT
		var auxSelect = $('cmbFoldChose');
		var nodesByLevelAndParent = {};
		Array.from(xml.getElementsByTagName('folder')).each(function(folder) {
			var level = folder.getAttribute('level');
			var parent = folder.getAttribute('parent');
			if (level === '') level = 0;
			if (parent === '') parent = 0;
			if (typeof nodesByLevelAndParent[level] === 'undefined') nodesByLevelAndParent[level] = {};
			if (typeof nodesByLevelAndParent[level][parent] === 'undefined') nodesByLevelAndParent[level][parent] = new Array();
			nodesByLevelAndParent[level][parent].push(folder);
		});
		
		for (var level in nodesByLevelAndParent) {
			for (var parent in nodesByLevelAndParent[level]) {
				var sortedNodes = nodesByLevelAndParent[level][parent].sort(function(yiElem, erElem) {
					var yiName = yiElem.getAttribute('name').toLowerCase();
					var erName = erElem.getAttribute('name').toLowerCase();
					return sortFoldersForCombo(yiName, erName);
				});
				
				sortedNodes.each(function(folder) {
					var value = folder.getAttribute('id');
					var name = folder.getAttribute('name');
					var parent = folder.getAttribute('parent');
					var identation = '';
					for (var i = 0; i < level; i++) {
						identation += '- ';
					}
					
					var opt;
					if (folder.getAttribute('edit') === 'false') {
						opt = new Element('optgroup', {'label': identation + name, 'id': value, 'level': level});
					} else {
						opt = new Element('option', {'value': value, 'level': level, 'id': value});
						new Element('span', {'text': identation}).inject(opt);
						new Element('span', {'text': name}).inject(opt);
					}
					
					if (parent != '' && parent.length > 0) {
						var optionParent = auxSelect.querySelector('[id="' + parent + '"]');
						if (optionParent !== null) {
							opt.inject(optionParent, 'after');
						} else {
							opt.inject(auxSelect);
						}
					} else {
						opt.inject(auxSelect);
					}
				});
			}
		}
		
		if (folderId != undefined && folderId != null)
			auxSelect.value = folderId;
	}
}

function sortFoldersForCombo(er, yi) {
    var ax = [], bx = [];

    yi.replace(/(\d+)|(\D+)/g, function(_, $1, $2) { ax.push([$1 || Infinity, $2 || ""]) });
    er.replace(/(\d+)|(\D+)/g, function(_, $1, $2) { bx.push([$1 || Infinity, $2 || ""]) });
    
    while(ax.length && bx.length) {
        var an = ax.shift();
        var bn = bx.shift();
        var nn = (an[0] - bn[0]) || an[1].localeCompare(bn[1]);
        if(nn) return nn;
    }

    return ax.length - bx.length;
}

function showFoldersCreateModal(parentId, retFunction, retFunctionClose) {
	if (FOLDERS_HIDE_OVERFLOW) {
		$(document.body).setStyle('overflow', 'hidden');
	}
	
	loadComboStructure(parentId);
	
	var frmModalFolderCreate = $('frmModalFolderCreate');
	if(frmModalFolderCreate)
		frmModalFolderCreate.reset();
	
	$('dirModalName'),value = '';
	$('dirModalDesc').value = '';
	$('mdlFolderPoolContainter').getElements("span.canRemove").each(function(ele) { ele.dispose(); });
	
	var mdlFoldersCreator = $('mdlFoldersCreator');
	mdlFoldersCreator.addedPools = [];
	mdlFoldersCreator.addedUsers = [];
	mdlFoldersCreator.setStyle('zIndex', SYS_PANELS.getNewZIndex());
	mdlFoldersCreator.onModalConfirm = retFunction;
	mdlFoldersCreator.onModalClose = retFunctionClose;
	mdlFoldersCreator.properties = {
		'parentId': parentId
	};
	
	$('selDocAllPoolPerm').selectedIndex = 0;
	
	addEvents(true, true);
	freeAllFieldsLocks();
	
	mdlFoldersCreator.removeClass('hiddenModal');
	mdlFoldersCreator.position();
	mdlFoldersCreator.blockerModal.show();
	mdlFoldersCreator.setStyle('zIndex', SYS_PANELS.getNewZIndex());
	mdlFoldersCreator.focus();
}

function closeFolderCreateModal(xml, fromConfirm) {
	var mdlFoldersCreator = $('mdlFoldersCreator');
	mdlFoldersCreator.addClass('hiddenModal');
	if(window.frameElement && $(window.frameElement).hasClass('modal-content')) {
		$(window.frameElement).fireEvent('unblock');
	}
	
	if(FOLDERS_HIDE_OVERFLOW) {
		$(document.body).setStyle('overflow', '');
	}
	
	loadComboStructure();
	if(mdlFoldersCreator.onModalClose) mdlFoldersCreator.onModalClose();
	mdlFoldersCreator.blockerModal.hide();
	SYS_PANELS.closeLoading();
}

//--------------------- revisar de aca para abajo

function dirProcessPoolsUsersModalClose() {
	$('mdlFoldersCreator').removeClass('hiddenModal').focus();
}

function dirProcessPoolsModalReturn(ret) {
	ret.each(function(e){
		var text = e.getRowContent()[0];
		var id = e.getRowId();
		
		dirProcessModalReturn(id, text, false, true);
	});
}

function dirProcessUsersModalReturn(ret) {
	ret.each(function(e){
		var text = e.getRowContent()[0];
		var id = e.getRowId();
		
		dirProcessModalReturn(id, text, false, false);
	});
}

function dirProcessModalReturn(id, text, canUpdate, pool, info) {
	var mdlFoldersCreator = $('mdlFoldersCreator');
	
	var checkIn = pool ? mdlFoldersCreator.addedPools : mdlFoldersCreator.addedUsers;
	
	if (!checkIn || checkIn.indexOf(id) != -1) return;
	checkIn.include(id);
	
	var optionClass = pool ? 'optionPool' : 'optionUser';
	var hiddenName = pool ? 'docPoolId' : 'docUserId';
	var hiddenName2 = pool ? 'docPoolName' : 'docUsrLogin';
	
	var span = new Element("span", {'class': 'option canRemove'});
	new Element('div', {'class': optionClass, html: '&nbsp;'}).inject(span);
	new Element('span', {html: text + ' ' + LBL_CAN_UPDATE + ': '}).inject(span);
	new Element('input', {type: 'hidden', name: hiddenName, value: id}).inject(span);
	new Element('input', {type: 'hidden', name: hiddenName2, value: text}).inject(span);
	var option = new Element('input', {type: 'checkbox', name: 'docPermType' + id, value: 'true', checked: canUpdate});
	if (info) option.setAttribute('disabled','');
	option.inject(span);
	
	span.checkIn = checkIn;
	span.idCheckIn = id;
	
	if (!info){
		new Element('div.optionRemove', {tabIndex: ''}).addEvent('click', function(evt) {
			var p = this.getParent();
			p.checkIn.erase(p.idCheckIn);
			p.destroy();
			mdlFoldersCreator.focus();
		}).addEvent('keypress', Generic.enterKeyToClickListener).inject(span);	
	}
 
	var permContainer = $('scrollOptions' + (info? 'Info' : ''));
	
	span.inject(permContainer);
	$('mdlFoldersCreator').position();
}

function processMdlConfirmReturn(xml) {
	modalProcessXml(xml);
	if (!(xml.getElementsByTagName("sysExceptions").length != 0 || xml.getElementsByTagName("exceptions").length != 0 || xml.getElementsByTagName("sysMessages").length != 0)) {
		closeFolderCreateModal(xml, true);
		var folder = xml.getElementsByTagName('folder');
		if (folder != null && folder.length > 0) {
			if (folder[0].getAttribute('action') === 'create') {
				addNewFolder(xml);
			} else if (folder[0].getAttribute('action') === 'modify') {
				$('clearFilters').fireEvent('click');
			}
		}
	}
}

function processFolderFrm() {
	var allParams = '';
	allParams += 'name=' + $('dirModalName').value;
	allParams += '&parent=' + $('cmbFoldChose').value;
	$('mdlFoldersCreator').properties.parentId = $('cmbFoldChose').value;
	
	if ($('dirModalDesc').value !== '') {
		allParams += '&desc=' + $('dirModalDesc').value;  
	}
	allParams += '&allEdit=' + $('selDocAllPoolPerm').value;
	
	var permits = $('scrollOptions').getElementsByClassName('option canRemove');
	if (permits !== null && permits.length > 0) {
		Array.from(permits).each(function(elem) {
			if (elem.childNodes[0].hasClass('optionUser')) {
				var elements = elem.getElementsByTagName('input');
				for (i = 0; i < elements.length; i++) {
					if (elements[i].getAttribute('name') === 'docUserId') {
						var usrId = elements[i].getAttribute('value');
					} else if (elements[i].getAttribute('type') === 'checkbox') {
						var usrCanMod = elements[i].checked;
					}
				}

				allParams += '&user=' + usrId + '&usrCanMod=' + usrCanMod;
			} else {
				var elements = elem.getElementsByTagName('input');
				for (i = 0; i < elements.length; i++) {
					if (elements[i].getAttribute('name') === 'docPoolId') {
						var poolId = elements[i].getAttribute('value');
					} else if (elements[i].getAttribute('type') === 'checkbox') {
						var poolCanMod = elements[i].checked;
					}
				}

				allParams += '&pool=' + poolId + '&poolCanMod=' + poolCanMod;
			}
		});
	}
	
	return allParams;
}

function addEvents(addPool, addUser) {
	var mdlFolderAddPool = $('mdlFolderAddPool');
	var mdlFolderAddUser = $('mdlFolderAddUser');
	
	if (addPool && mdlFolderAddPool) {
		mdlFolderAddPool.addEvent("click", function(e) {
			if(e) e.stop();
			$('mdlFoldersCreator').addClass('hiddenModal');
			POOLMODAL_SHOWAUTOGENERATED = true;
			POOLMODAL_SHOWNOTAUTOGENERATED = true;
			POOLMODAL_SHOWCURRENTENV = true;
			POOLMODAL_SHOWGLOBAL = true;
			showPoolsModal(dirProcessPoolsModalReturn, dirProcessPoolsUsersModalClose);
		});
		mdlFolderAddPool.addEvent('keypress', Generic.enterKeyToClickListener);
	}
	
	if (addUser && mdlFolderAddUser) {
		mdlFolderAddUser.addEvent("click", function(e) {
			if(e) e.stop();
			
			USERMODAL_GLOBAL_AND_ENV = true;
			
			$('mdlFoldersCreator').addClass('hiddenModal');
			showUsersModal(dirProcessUsersModalReturn, dirProcessPoolsUsersModalClose);
		});
		mdlFolderAddUser.addEvent('keypress', Generic.enterKeyToClickListener);
	}
}

function freeAllFieldsLocks() {
	$('dirModalName').disabled = false;
	$('dirModalDesc').disabled = false;
	$('selDocAllPoolPerm').disabled = false;
}