var TREEDCSFLD_MODAL_HIDE_OVERFLOW	= true;

var TREEDCSFLD_MODAL_SHOW_DOCUMENTS_ON_FLD_CLICK = true;

function initTreeDocsFldsMdlPage() {
	var mdlDcsFldsTreeContainer = $('mdlDcsFldsTreeContainer');
	if (mdlDcsFldsTreeContainer.initDone) return;
	mdlDcsFldsTreeContainer.initDone = true;

	mdlDcsFldsTreeContainer.blockerModal = new Mask(); 
	
	$('btnCloseTreeDcsFldMdl').addEvent("click", function(e) {
		if (e) e.stop();
		if (mdlDcsFldsTreeContainer.onModalClose) jsCaller(mdlDcsFldsTreeContainer.onModalClose);
		closeDocsFldModal();
	});
	
	$('btnConfTreeDcsFldMdl').addEvent("click", function(e) {
		var mdlDcsFldsTreeContainer = $('mdlDcsFldsTreeContainer');
		if (mdlDcsFldsTreeContainer.onModalConfirm) jsCaller(mdlDcsFldsTreeContainer.onModalConfirm, getSelectedElement());
		closeDocsFldModal();
	});
}

function showTreeDocsFldsModal(retFunction, closeFunction, extra, hideDocumentsModal){
	
	if(TREEDCSFLD_MODAL_HIDE_OVERFLOW) {
		$(document.body).setStyle('overflow', 'hidden');
	}
	
	loadDocsFldTree(extra && extra.root ? extra.root : '');
	
	var mdlDcsFldsTreeContainer = $('mdlDcsFldsTreeContainer');
	mdlDcsFldsTreeContainer.removeClass('hiddenModal');
	mdlDcsFldsTreeContainer.position();
	
	
	mdlDcsFldsTreeContainer.setStyle('zIndex', SYS_PANELS.getNewZIndex());
	mdlDcsFldsTreeContainer.blockerModal.show();
	mdlDcsFldsTreeContainer.onModalConfirm = retFunction;
	mdlDcsFldsTreeContainer.onModalClose = closeFunction;
	mdlDcsFldsTreeContainer.extraProperties = extra;
	mdlDcsFldsTreeContainer.loadedFolders = [];
	
	
	mdlDcsFldsTreeContainer.position();
	
//	resetChangeHighlight(mdlDcsFldsTreeContainer);
//	initAdminFieldOnChangeHighlight(false, false, false);
}

function loadDocsFldTree(root) {
	
	
	var docTypePermitted = '';
	var mdlDocumentContainer = $('mdlDocumentContainer');
	if (mdlDocumentContainer && mdlDocumentContainer.extraProperties && mdlDocumentContainer.extraProperties.docTypePermitted) {
		var permitted = mdlDocumentContainer.extraProperties.docTypePermitted;
		docTypePermitted += '&useDocTypePermitted=' + permitted.use + '&docTypePermittedObjId=' + permitted.objId + '&docTypePermittedObjType=' + permitted.objType;
	} else if (mdlDocumentContainer && mdlDocumentContainer.extraProperties && mdlDocumentContainer && mdlDocumentContainer.extraProperties.params) {
		if (mdlDocumentContainer.extraProperties.params.contains('frmId') && mdlDocumentContainer.extraProperties.params.contains('forceDocTypeId')) {
			var frmProps = mdlDocumentContainer.extraProperties.params.split('&');
			for (var i = 0; i < frmProps.length; i++) {
				if (frmProps[i].contains('forceDocTypeId')) {
					docTypePermitted += '&useDocTypePermitted=true&docTypeForcedId=' + frmProps[i].split('=')[1]; 
				}
			}
		}
	}
	
	
	$('dcsFldsTreeMdl').innerHTML = '';
	var request = new Request({
		method : 'post',
		url : CONTEXT + URL_REQUEST_AJAX_DOCS_FOLDERS_TREE + '?action=loadFileSystemStructureTree&isAjax=true' + (root && root != null ? '&rootFld=' + root : '') + TAB_ID_REQUEST,
		onRequest : function() { SYS_PANELS.showLoading() },
		onComplete : function(resText, resXml) { processXmlDocsFolders(resXml); }
	}).send(docTypePermitted);
}

function processXmlDocsFolders(resXml) {
	var allNodesByParent = {};
	
	if (resXml.getElementsByTagName('folder') && resXml.getElementsByTagName('folder').length > 0) {
		var gridBody  = $('mdlDcsFldTreeBody').getChildren('div.gridBody')[0]; 
		if (gridBody.noDataMessage) gridBody.noDataMessage.dispose();
		Array.from(resXml.getElementsByTagName('folder')).each(function(elem) {
			var id = elem.getAttribute('id');
			var parent = elem.getAttribute('parent');
			var level = elem.getAttribute('level');
			
			if (typeof allNodesByParent[level] === 'undefined') {
				allNodesByParent[level] = new Array();
			}
			allNodesByParent[level].push(elem);
		});
		
		var mainStructure = $('dcsFldsTreeMdl');
		for (var key in allNodesByParent) {
			var folder;
			var nodeList = allNodesByParent[key];
			for (var i = 0; i < nodeList.length; i++) {
				if (key == 0) {
	    			addFolderToStructure(allNodesByParent[key][i]).inject(mainStructure);
	    		} else {
	    			var parent = nodeList[i].getAttribute('parent');
	        		var parentEle = mainStructure.getElementById(parent + 'mdl');
	        		if (parentEle != null) {
	        			var parentUl = parentEle.getElementsByTagName('ul');
	        			if (parentUl == null || parentUl.length == 0) {
	    	    			parentUl = new Element('ul', {'class':'directory'});
	    	    			parentUl.inject(parentEle);
	    	    			parentEle.removeClass('leaf').removeClass('closeFld').addClass('subroot').addClass('openFld');
	    	    		} else {
	    	    			parentUl = parentUl[0];
	    	    		}
	        			
	        			addFolderToStructure(allNodesByParent[key][i]).inject(parentUl);
	        		}
	    		}
			}
		}
		
		sortStructure($('dcsFldsTreeMdl'), true, false, true);
		
		loadEventsToDocsAndFolders();
		collapseAll();
	} else {
		var gridBody = $('mdlDcsFldTreeBody').getChildren('div.gridBody')[0];
		gridBody.noDataMessage = new Element('div', {'class': 'noDataMessage', html: GNR_MORE_RECORDS}).inject(gridBody);
		gridBody.noDataMessage.setStyle('display','');
		gridBody.noDataMessage.position( {
			relativeTo: gridBody,
			position: 'upperLeft'
		});
//		$('mdlDcsFldTreeBody').noDataMessage = 
	}
	
	
	SYS_PANELS.closeActive();
	
}

function addFolderToStructure(xml) {
	var list = new Element('li', {'id': xml.getAttribute('id') + 'mdl', 'class':'folder closeFld ', 'title': xml.getAttribute('desc')});
	if (toBoolean(xml.getAttribute('addToggler'))) list.addClass('docFolder subroot'); else list.addClass('leaf'); 
	var main = new Element('span', {'class':'mainSpan'}).inject(list);
	new Element('span', {'class': 'toggler document'}).inject(main);
	new Element('span', {'class': 'emptySpace'}).inject(main);
	new Element('span', {'class': 'icon'}).inject(main);
	new Element('span', {'class': 'folderText', 'text': xml.getAttribute('name')}).inject(main);
	
	list.addClass((toBoolean(xml.getAttribute('edit')) === false ? 'uneditable' : ''));
	return list
}

function addDocumentToFolder(xml) {
	var item = new Element('li', {'id': xml.getAttribute('id'), 'class': 'document leaf'});
	var main = new Element('span', {'class':'mainSpan'}).inject(item);
	new Element('span', {'class': 'docEmpty'}).inject(main);
	new Element('span', {'class': 'emptySpace'}).inject(main);
	new Element('input', {'type': 'checkbox', 'onchange': 'checkOnlyThis(this)', 'id': xml.getAttribute('id'), 'class': 'docCheck'}).inject(main);
	new Element('span', {'class': 'folderText', 'text': xml.getAttribute('name')}).inject(main);
	
	return item;
}

function addDocumentsLoader(xml) {
	var item = new Element('li', {'class': 'docLoader', 'styles': {'text-align' : 'center'}});
	var button = new Element('span', {'class': 'option optionAdd', 'styles': {'width': '50%','float':'none'}}).inject(item);
	button.innerHTML = LOAD_MORE_DOCUMENTS;
	
	item.addEvent('click', function(evt) {
		if (evt) evt.stop();
		setMdlFldFilter(this,false);
	});
	return item;
}

function loadEventsToDocsAndFolders() {
	if (TREEDCSFLD_MODAL_SHOW_DOCUMENTS_ON_FLD_CLICK) {
		$$("span.toggler.document").each(function(ele) { 
			ele.addEvent('click', function(evt) {
				ele.getParent("li").toggleClass("openFld"); ele.getParent("li").toggleClass("closeFld");
				var folderId = ele.getParent('li').id;
				if (!$('mdlDcsFldsTreeContainer').loadedFolders.contains(folderId.substring(0, folderId.length - 3))) {
					setMdlFldFilter(ele,true);
					$('mdlDcsFldsTreeContainer').loadedFolders.push(folderId.substring(0, folderId.length - 3));
				}
			});
		});
		
		$$('li.folder.docFolder').each(function(ele) {
			ele.addEvent('dblclick', function(evt) {
				if (evt) evt.stop();
				ele.getElementsByClassName('toggler')[0].fireEvent('click');
			});
		});
	} else {
		$$("span.toggler.document").each(function(ele) { 
			ele.addEvent('click', function(evt) {
				if (evt) evt.stop();
				ele.getParent("li").toggleClass("openFld"); ele.getParent("li").toggleClass("closeFld");
			});
		});
		
		$$('li.folder.docFolder').each(function(ele) {
			ele.addEvent('click', function(evt) {
				if (!evt.event.ctrlKey) {
					
					$$('span.folderText').each(function(elem) {
						elem.removeClass('selected');
					});
					
					$$('li.selected').each(function(elem) {
						elem.toggleClass('selected');
					});
				}
				
				if (evt) evt.stop();
				
				ele.toggleClass('selected');
			});
			
			ele.addEvent('dblclick', function(evt) {
				if (evt) evt.stop();
				ele.getElementsByClassName('toggler')[0].fireEvent('click');
			});
		});
	}
}

function closeDocsFldModal() {
	var mdlDcsFldsTreeContainer = $('mdlDcsFldsTreeContainer');
	mdlDcsFldsTreeContainer.addClass('hiddenModal');
	mdlDcsFldsTreeContainer.blockerModal.hide();
}

function checkOnlyThis(chk) {
	var currentChkId = chk.getParent('li').id;
	Array.from($$('input.docCheck')).each(function(check) {
		if (check.getParent('li').id != currentChkId) 
			check.checked = false;
	});
}

function getSelectedElement() {
	if (TREEDCSFLD_MODAL_SHOW_DOCUMENTS_ON_FLD_CLICK) {
		return getSelectedDocument();
	} else {
		return getSelectedFolders();
	}
}

function getSelectedDocument() {
	var docId = 0;
	Array.from($$('input.docCheck')).each(function(check) {
		if (check.checked) docId = encodeURIComponent(check.getParent('li').id);
	});
	
	return docId;
}

function getSelectedFolders() {
	var folderIds = [];
	Array.from($('mdlDcsFldsTreeContainer').querySelectorAll("[id$='mdl']")).each(function(elem) {
		if (elem.hasClass('selected')) {
			var fldName = elem.childNodes[0].getElementsByClassName('folderText')[0].innerHTML;
			var fldId;
			if (folderIds == '') fldId = elem.id.replace('mdl', '');
			else fldId = elem.id.replace('mdl', '');
			folderIds.push({id: fldId, name: fldName});
		}
	});
	return folderIds;
}

function setMdlFldFilter(element,resetCant) {
	var cantLoadedDocs = 0;
	if(!resetCant){
		Array.from(element.getParent('ul').childNodes).each(function(node) {
			if (node.hasClass('document') && node.hasClass('leaf')) cantLoadedDocs += 1;
		});
	}
	callNavigateFilterDocsForFolders({
		'txtFld': element.getParent('li').id.substring(0, element.getParent('li').id.length - 3),
		'txtCantDoc': cantLoadedDocs
	}, null);
}

function callNavigateFilterDocsForFolders(params) {
	var docTypePermitted = '';
	var mdlDocumentContainer = $('mdlDocumentContainer');
	if (mdlDocumentContainer && mdlDocumentContainer.extraProperties && mdlDocumentContainer.extraProperties.docTypePermitted) {
		var permitted = mdlDocumentContainer.extraProperties.docTypePermitted;
		docTypePermitted += '&useDocTypePermitted=' + permitted.use + '&docTypePermittedObjId=' + permitted.objId + '&docTypePermittedObjType=' + permitted.objType;
	} else if (mdlDocumentContainer && mdlDocumentContainer.extraProperties && mdlDocumentContainer && mdlDocumentContainer.extraProperties.params) {
		if (mdlDocumentContainer.extraProperties.params.contains('frmId') && mdlDocumentContainer.extraProperties.params.contains('forceDocTypeId')) {
			var frmProps = mdlDocumentContainer.extraProperties.params.split('&');
			for (var i = 0; i < frmProps.length; i++) {
				if (frmProps[i].contains('forceDocTypeId')) {
					docTypePermitted += '&useDocTypePermitted=true&docTypeForcedId=' + frmProps[i].split('=')[1]; 
				}
			}
		}
	}
	
	var request = new Request({
		method: 'post',	
//		data: params,
		url: CONTEXT + URL_REQUEST_AJAX_DOCS_FOLDERS_TREE + '?action=loadFilesForFolder&isAjax=true' + TAB_ID_REQUEST,
		onRequest: function() { SYS_PANELS.showLoading(); },
		onComplete: function(resText, resXml) { processXmlDocumentsFolder(resXml); }
	}).send(docTypePermitted + '&txtFld=' + params.txtFld + '&txtCantDoc=' + params.txtCantDoc);
}

function processXmlDocumentsFolder(xml) {
	var allDocumentsByFolder = {};
	Array.from(xml.getElementsByTagName('document')).each(function(doc) {
		var id = doc.getAttribute('id');
		var folder = doc.getAttribute('folder');
		
		if (typeof allDocumentsByFolder[folder] === 'undefined') {
			allDocumentsByFolder[folder] = new Array();
		}
		
		allDocumentsByFolder[folder].push(doc);
	});
	
	var mainStructure = $('dcsFldsTreeMdl');
	for (var key in allDocumentsByFolder) {
		var documents = allDocumentsByFolder[key];
		for (var i = 0; i < documents.length; i++) {
			var folderId = documents[i].getAttribute('folder');
			var parentEle = mainStructure.getElementById(folderId + 'mdl');
			var parentUl = parentEle.getElementsByTagName('ul');
			if (parentUl == null || parentUl.length == 0) {
    			parentUl = new Element('ul', {'class':'directory'});
    			parentUl.inject(parentEle);
    			parentEle.removeClass('leaf').removeClass('closeFld').addClass('subroot').addClass('openFld');
    		} else {
    			parentUl = parentUl[0];
    		}
    		
			addDocumentToFolder(documents[i]).inject(parentUl);
		}
	}
	
	var xmlInfo = xml.getElementsByTagName('documentInfo')[0];
	var folderId = xmlInfo.getAttribute('folder');
	var parentEle = mainStructure.getElementById(folderId + 'mdl');
	var parentUl = parentEle.getElementsByTagName('ul')[0];
	
	if (parentUl != undefined) {
		if (parentUl.getElementsByClassName('docLoader').length > 0) parentUl.getElementsByClassName('docLoader')[0].destroy();
		
		if (parseInt(xmlInfo.getAttribute('moreDocs')) > 0) {
			addDocumentsLoader(xmlInfo).inject(parentUl);
		}
	}
	
	
	SYS_PANELS.closeActive();
}