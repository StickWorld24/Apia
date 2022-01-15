//var droppedFilesNames = '';
//var prefx = '';
//var urlProps = '';
//var urlAcc = '';
//var ur = '';

function initDroppedDocsFunctions(urlAccess, prefix, divId, multipleUpload, filterTypesOnDrop, docTypeId, urlProperties, docProperties, auxContent) {
	createFormForDrop(prefix);
	
	var filesForm = $('uploadPckageForm' + prefix);
	if (filesForm) {
		var mdlContainer = $('mdlDocumentContainer');
		var elemId = mdlContainer.extraProperties && mdlContainer.extraProperties.addTo ? mdlContainer.extraProperties.addTo : divId;
		var props = mdlContainer.extraProperties && mdlContainer.extraProperties.params ? mdlContainer.extraProperties.params : '';
		filesForm.action = urlAccess + 'action=saveDroppedFiles&elemType=' + 
					prefix + '&elemId=' + elemId + (urlProperties && urlProperties != '' ? '&' + urlProperties : '') + props + TAB_ID_REQUEST;
	}
	
	if ($(divId) || (auxContent && auxContent.getElementById(divId))) {
		var divElem = $(divId) ? $(divId) : auxContent.getElementById(divId);  
		if (typeof isMonitor !== 'undefined' && isMonitor === true) {
			divElem.style.display = 'none';
			if ($('dropProgress' + prefix)) 
				$('dropProgress' + prefix).style.display = 'none';
		} else {
			divElem.style.display = '';
			if (prefix === 'P' || prefix === 'E') {
				if ($('docAddDocument' + prefix).getChildren('div') != null && $('docAddDocument' + prefix).getChildren('div').length > 0) {
					$('docAddDocument' + prefix).getChildren('div')[0].addClass('moreSize');
				}
			}
			divElem.removeClass('hidden');
			initializeDragDropArea(urlAccess, prefix, divElem, multipleUpload, filterTypesOnDrop, docTypeId, urlProperties, docProperties, $('mdlDocumentContainer').extraProperties);
		}
	}
}

function createFormForDrop(prefix) {
	// creates necessary form to submit dragged documents
	var outerDiv = $('divDragDropForm');
	var form = $('uploadPckageForm' + prefix);
	if (!form) {
		form = new Element('form', {
			'method': 'post',
			'enctype': 'multipart/form-data',
			'id': 'uploadPckageForm' + prefix,
			'target': 'uploadPackageTarget'// + prefix
		});
		
		var innerDiv = new Element('div', {
			'class': 'wrapper-block hidden',
			'id': 'mobileUpload' + prefix  ////
		});
		var label = new Element('label',{
			'for': 'fileRepository' + prefix,
			'style': 'display: none;',
			'html':  '&nbsp;'////
		})
//		var span = new Element('span')
		var input = new Element('input', {
			'type': 'file',
			'name': 'fileRepository',
			'id': 'fileRepository' + prefix,
		});
		
		//total validator: form must have submit button
		var button = new Element('input', {
			'type': 'submit',
			'value': 'submit',
			'style': 'display: none;'
		});
		
		label.inject(innerDiv);
		input.inject(innerDiv);
		button.inject(innerDiv);
		innerDiv.inject(form);
		form.inject(outerDiv);
	}
	
}

function initializeDragDropArea(urlAccess, prefix, divElem, multipleUpload, filterTypesOnDrop, docTypeId, urlProperties, docProperties, modalProperties) {
	// retrieve docType allowed (only in case of form because its only one)
	var permittedDocumentTypes = {};
	var dcTypePerm = '';
	if ($('mdlDocumentContainer') && $('mdlDocumentContainer').extraProperties && $('mdlDocumentContainer').extraProperties.docTypePermitted) {
		permittedDocumentTypes = $('mdlDocumentContainer').extraProperties.docTypePermitted;
	} else {
		if (prefix == 'E' || prefix == 'P') {
			if (docProperties && docProperties.docTypePermitted) {
				dcTypePerm += '&useDocTypePermitted=true&docTypePermittedObjId=' + (prefix == 'E' ? docTypePerEntId : docTypePerProId) + '&docTypePermittedObjType=' + prefix;
			}
		}
		
		if (filterTypesOnDrop) {
			var request = new Request({
				method: 'post',
				async: false,
				url: CONTEXT + '/' + urlAccess +  'action=getDocTypeInformation&elemType=' + prefix  + (urlProperties && urlProperties != '' ? '&' + urlProperties : '') + TAB_ID_REQUEST,
				onComplete: function(resText, resXml) { permittedDocumentTypes = fncProcessDocsTypesAllowed(resXml);  }
			}).send('&docTypeId=' + docTypeId + '&forDropElem=true' + dcTypePerm);
		}
	}
	
	var docMonitor = checkDocMonitorUse(prefix);
	
	// start drag&drop area
	var filePackage = $('fileRepository' + prefix);

	var url = '';
	if (prefix == 'E' || prefix == 'P') {
		var url = '&useDocTypePermitted=true&docTypePermittedObjId=' + (prefix == 'E' ? docTypePerEntId : docTypePerProId) + '&docTypePermittedObjType=' + prefix;
	}
	
	if (!docProperties) docProperties = {};
	
	var documentProps = { };
	if (Object.keys(docProperties) != 0) {
		if (prefix == 'E' || prefix == 'P') {
			documentProps = {
				prefix: prefix,
				addTo: 'prmDocumentContainter' + prefix, 
				buttonAdd: 'docAddDocument' + prefix, 
				allowMultiple: true,
				allowSign: docProperties.allowSign,
				allowEdition: docProperties.dontAllowEdition == undefined ? false : !docProperties.dontAllowEdition,
				allowLock: true,
				action: docProperties.ajaxUploadStartAction,
				docTypePermitted: docProperties.docTypePermitted,
				cusMonDoc: docMonitor.id,
				defMonDoc: docMonitor.use
			}
		} else {
			documentProps = docProperties;
		}
	}
	
	
	if (filePackage) filePackage.fileFormUpload = new Form.Upload('fileRepository' + prefix, { 
		fireAtOnce: true, 
		avoidDetectInputChange: true, 
		resetOnDrop: true,
		useList: false, 
		filterFileTypes: filterTypesOnDrop,	/* boolean */
		allowedFileTypes: permittedDocumentTypes.permitted,	/* dictionary */
		forbiddenFileTypes: permittedDocumentTypes.forbidden,	/* dictionary */
		allowMultiple: multipleUpload,	/* boolean */
		disableAfterDrop: false, /* boolean */
		docOptions: documentProps,
		elemId: prefix,
		domDrop: divElem, 
//		modalProperties: documentProps,

		onRequest: function(evt) {
			SYS_PANELS.showLoading();
		},
		
		onComplete: function(evt) {  
			SYS_PANELS.closeActive();
			
			var droppedFilesNames = '';
			if ($('mdlDocumentContainer').droppedFiles.length > 0) {
				for (var i = 0; i < $('mdlDocumentContainer').droppedFiles.length; i++) {
					var name = $('mdlDocumentContainer').droppedFiles[i].name;
					var type = $('mdlDocumentContainer').droppedFiles[i].type;
					if (name && name != '' && type && type != '')
						droppedFilesNames += '&dropped=' + encodeURIComponent($('mdlDocumentContainer').droppedFiles[i].name); 
				}
				
//				$('mdlDocumentContainer').droppedFiles = [];
			}
			
			var droppedElements = {
					droppedNames: droppedFilesNames,
					prefijo: prefix,
					propsUrl: urlProperties,
					accessUrl: urlAccess,
					callUrl: url,
			}
			
			$('mdlDocumentContainer').extraProperties.dropProps = droppedElements;
			
//			
//			prefx = prefix;
//			urlProps = urlProperties;
//			urlAcc = urlAccess;
//			ur = url;
			
//			var request = new Request({
//				method: 'post',
//				url: CONTEXT + '/' + urlAccess + 'action=processDroppedFiles&elemType=' + prefix  + (urlProperties && urlProperties != '' ? '&' + urlProperties : '') + TAB_ID_REQUEST,
//				onRequest: function() {  },
//				onComplete: function(resText, resXml) { modalProcessXml(resXml);  }
//			}).send(url + droppedFilesNames);
		}
	});
}

function fncProceedDocumentProcessing() {
	var xml = getLastFunctionAjaxCall();
	
//	console.log($('mdlDocumentContainer').extraProperties.dropProps);
	var droppedAttrs = $('mdlDocumentContainer').extraProperties.dropProps;
	var props = $('mdlDocumentContainer').extraProperties;
	if (props && props.params) $('mdlDocumentContainer').extraProperties.params = props.params.replace('&delayForDrop=true', '');
	
	var shownFiles = '';
	if ($('docsNamesContainer').getChildren('span') && $('docsNamesContainer').getChildren('span').length > 0) {
		for (var i = 0; i < $('docsNamesContainer').getChildren('span').length; i++) {
			var span = $('docsNamesContainer').getChildren('span')[i];
			shownFiles += '&shown=' + encodeURIComponent(span.getChildren('div')[0].getChildren('span')[0].title);
		}
	}
	
	if (xml.getElementsByTagName('message').length > 0) return;
	if (xml.getElementsByTagName('dropLastMessage').length > 0) return;
	
	var request = new Request({
		method: 'post',
		url: CONTEXT + '/' + droppedAttrs.accessUrl + 'action=processDroppedFiles&elemType=' + droppedAttrs.prefijo + (droppedAttrs.propsUrl && droppedAttrs.propsUrl != '' ? '&' + droppedAttrs.propsUrl : '') + TAB_ID_REQUEST,
		onRequest: function() {  },
		onComplete: function(resText, resXml) { modalProcessXml(resXml);  }
	}).send(droppedAttrs.callUrl + droppedAttrs.droppedNames + shownFiles);
}

// loads data type and size to ban documents onAdd
function fncProcessDocsTypesAllowed(xml) {
	var bothElements = {
		permitted: {},
		forbidden: {}
	};
	
	var permittedTypes = {};
	if (xml) {
		var allowed = xml.getElementsByTagName('typeAllowed');
		var notAllowed = xml.getElementsByTagName('typeForbidden');
		if (allowed && allowed.length > 0) {
			for (i = 0; i < allowed.length; i++) {
				var type = allowed[i];
				bothElements.permitted[type.getAttribute('docType')] = type.getAttribute('realSize');
			}
		}

		if (notAllowed && notAllowed.length > 0) {
			for (i = 0; i < notAllowed.length; i++) {
				var type = notAllowed[i];
				bothElements.forbidden[type.getAttribute('docType')] = type.getAttribute('realSize');
			}
		}
	}
	
	return bothElements;
}

// opens documents modal
function fncProcessCmbMetaDocs() {
	// primero abro el modal de documentos para luego modificar el modal de documentos
	
	var xml = getLastFunctionAjaxCall();
	
	var noInfo = xml.getElementsByTagName('nothingToShow');
	if (!noInfo || noInfo.length == 0) {
		var elemInfo = xml.getElementsByTagName('elemInfo');
		var elemType = '';
		var elemId = '';
		if (elemInfo && elemInfo.length > 0) {
			elemType = elemInfo[0].getAttribute('elemType');
			elemId = elemInfo[0].getAttribute('elemId');
		}
		
		var forForm = xml.getElementsByTagName('processForForm');
		if (forForm != null && forForm.length > 0) {
			if ($('mdlDocumentContainer').isVisible() === false) {
				var divFld = $(elemType);
				var uplIcon = divFld.getParent().getElementsByClassName('docIcon docUploadIcon')[0];
				var file = divFld.getParent().retrieve(Field.STORE_KEY_FIELD);
				if (!file) file = divFld.getParent().getParent().getParent().retrieve(Field.STORE_KEY_FIELD);	// caso de grilla
				
				
				if (file) {
					file.uploadDocument(file, uplIcon.getParent(), file.index);
				}
			}
			
			$('mdlDocumentContainer').extraProperties.showForDrop = false;

			styleModalForDroppedBehaviour();
			fncPrepareModalFormView();
			
			$('mdlDocumentContainer').extraProperties.action = 'confirmDropModal';
//			$('mdlDocumentContainer').getElementById('docsNamesContainer').style.height = '42px';
			$('mdlDocumentContainer').focus();
		} else {
			$('mdlDocumentContainer').setAttribute('current_elem_type', elemType);
			
			var extraProps = $('mdlDocumentContainer').extraProperties;
			
			if ($('mdlDocumentContainer').isVisible() === false) {
				$('mdlDocumentContainer').extraProperties.showForDrop = false;
				showDocumentsModal(/*fncConfirmMdlDroppedDocs*/ $('mdlDocumentContainer').onModalConfirm, null, $('mdlDocumentContainer').extraProperties, null, false, false, fncCloseMdlDroppedDocs);
			}
			$('mdlDocumentContainer').extraProperties.showForDrop = true;
			deleteAllDocumentsPreviews(true);
			$('mdlDocumentContainer').extraProperties.action = 'confirmDropModal';
		}
		
		$('btnConfirmDocumentModal').removeEvents('click');
		registerOnClickActionModal();
		disableFileSystemUpload();
		
		populateFileTable(xml);
		$('mdlDocumentContainer').position();
//	} else {
//		showMessage(LBL_DROP_FILE_ERR, GNR_TIT_WARNING, 'modalWarning');
	}
	
//	var mdlDocumentContainer = $('mdlDocumentContainer');
//	var deletedDocsWarning = '';
//	var repeatedDocsWarning = '';
//	if (Object.keys(mdlDocumentContainer.deletedDocuments).length > 0) {
//		for (var iter = 0; iter < mdlDocumentContainer.deletedDocuments.length; iter++) {
//			deletedDocsWarning += mdlDocumentContainer.deletedDocuments[iter] + '<br>';
//		}
//	} 
//	
//	if (Object.keys(mdlDocumentContainer.repeatedDocuments).length > 0) {
//		for (var iter = 0; iter < mdlDocumentContainer.repeatedDocuments.length; iter++) {
//			repeatedDocsWarning += mdlDocumentContainer.repeatedDocuments[iter] + '<br>';
//		}
//	}
//	
//	mdlDocumentContainer.deletedDocuments = [];
//	mdlDocumentContainer.repeatedDocuments = [];
//	
//	SYS_PANELS.closeActive();
//	
//	if (deletedDocsWarning != '' || repeatedDocsWarning != '') 
//		showMessage((deletedDocsWarning != '' ? '<b>' + LBL_DROP_FILE_DELETED + ' :</b><br>' + deletedDocsWarning : '') + (repeatedDocsWarning != '' ? '<b>' + LBL_DROP_FILE_REPEATED + ' :</b><br>' + repeatedDocsWarning : ''), GNR_TIT_WARNING, 'modalWarning');
}

function populateFileTable(xml) {
	if ($('documentInfoContainer').isVisible() === false) $('documentInfoContainer').setStyle('display', '');

	showDocumentsPreviews();
	var files = xml.getElementsByTagName('docInfo');
	if (files != null && files.length > 0) {
		var containerDiv;
		for (i = 0; i < files.length; i++) {
			var file = files[i];
			var dataType = file.getAttribute('docInfoType'); // extension
			var fullName = file.getAttribute('docInfoName'); // file name
			var tmpDocId = file.getAttribute('docInfoTmpId'); // server id (memory)
			var docSize  = file.getAttribute('docInfoSize');
			addDocumentPreview(dataType, fullName, tmpDocId, docSize, false, 'drop', FROM_DR);
		}
	}
//	$('mdlDocumentContainer').deleteFileByExtension = 0;
//	$('mdlDocumentContainer').deleteFileBySize = 0;
//	$('mdlDocumentContainer').deleteFileByNotMatchingNames = 0;
//	
//	var str = '';
//	if ($('mdlDocumentContainer').deleteFileByExtension > 0) str += 'Documentos eliminados por extension'; 
}

function populateComboFileTypes(xml) {
	var docsTypes = xml.getElementsByTagName('docTypes');
	if (docsTypes && docsTypes.length > 0) {
		var cmbDocType = $('cmbDocType');
		cmbDocType.innerHTML = '';
		var option;
		var selected = '';
		for (i = 0; i < docsTypes.length; i++) {
			var fullOpt = docsTypes[i];
			option = new Element('option', {
				'value': fullOpt.getAttribute('docTypeId'),
				'text': fullOpt.getAttribute('docTypeName'),
				'data-maxValueAllowed': fullOpt.getAttribute('docTypeMaxSize'),
				'data-extensions': fullOpt.getAttribute('docTypeExtensions'),
				'data-free': fullOpt.getAttribute('data-free')
			});
			
			if (fullOpt.getAttribute('selected')) {
				selected = fullOpt.getAttribute('docTypeId');
			}
			
			cmbDocType.appendChild(option);
			if (docsTypes.length == 1) {
				cmbDocType.setAttribute('disabled', true);
			}
			cmbDocType.style.display = '';
		}
		
		if (selected != '') {
			cmbDocType.value = selected;
		}
	}
}

function fncCloseMdlDroppedDocs() {
	mdlCloseCommonOperations();
}

function fncConfirmMdlDroppedDocs() {
}

function showOrHideDocuments(docsTypes, docSize) {
	var docsToDelete = $('mdlDocumentContainer').filesToDelete;
	var spanElemsDocs = $('docsNamesContainer').getElementsByClassName('option');
	var cantDocsHidden = 0;
	var cantDocsToShow = 0;
	if (spanElemsDocs && spanElemsDocs.length > 0) {
		for (i = 0; i < spanElemsDocs.length; i++) {
			var obj = spanElemsDocs[i];
			var objSize = obj.getAttribute('docSize');
			var documentType = obj.getAttribute('data-type');
			if ((docsTypes && !docsTypes.contains(documentType)) || 
					(docsTypes && docsTypes.contains(documentType) && objSize && parseInt(objSize) > parseInt(docSize))) {
				if (docsToDelete.indexOf(obj.getAttribute('docId')) == -1) {
					docsToDelete.push(obj.getAttribute('docId'));
					obj.style.display = 'none';
					cantDocsHidden++;
				}
			} else {
				if (docsToDelete.indexOf(obj.getAttribute('docId')) != -1) {
					docsToDelete.splice(docsToDelete.indexOf(obj.getAttribute('docId')), 1);
					obj.style.display = '';
					cantDocsToShow++;
					
				}
			}
		}
		
		if (parseInt(cantDocsHidden) == parseInt(spanElemsDocs.length)) {
			$('docsNamesContainer').getParent('div').setStyle('display', 'none');
			var selIndex = $('cmbDocType').selectedIndex;
			
			var frmModalDocumentUpload = $('frmModalDocumentUpload');
			if(frmModalDocumentUpload)
				frmModalDocumentUpload.reset();
			
			$('cmbDocType').selectedIndex = selIndex;
			enableFileSystemUpload();
		}
		
		if (parseInt(cantDocsToShow) > 0) {
			$('docsNamesContainer').getParent('div').setStyle('display', '');
			disableFileSystemUpload();
		}
	}
}

function mdlCloseCommonOperations() {
	// destroy documents information
	deleteAllDocumentsPreviews(true);
	
	// register default onChange event for documents types combo
	$('cmbDocType').removeEvents('change');
	registerCmbDocTypeEvent(false);
	
	// restore modal to default configuration
	// restore modal appearance
	var frmModalDocumentUpload = $('frmModalDocumentUpload');
	frmModalDocumentUpload.setAttribute('target', 'documentIframeUpload');
	frmModalDocumentUpload.setAttribute('enctype', 'multipart/form-data');
	frmModalDocumentUpload.setAttribute('method', 'post');
	frmModalDocumentUpload.action = '#';
	if ($('documentModalDocFile'))
		$('documentModalDocFile').getParent().getParent().style.display = '';
	$('documentInfoContainer').style.display = 'none';
	$('documentModalDocFile').addClass("validate['required']");
	$('frmModalDocumentUpload').formChecker.register($('documentModalDocFile'));
	
	//if portal Form Template have errors
	if ($('errorlist') && ($('errorlist').get('name') == "portalFormTemplate")){
		onClosePortalFormModal();
	}
}

function fncDocumentsDroppedProcess() {
	
	SYS_PANELS.closeActive();
	
	var xml = getLastFunctionAjaxCall();
	var mdlDocumentContainer = $('mdlDocumentContainer');
	if (mdlDocumentContainer /*&& mdlDocumentContainer.onModalConfirm*/) {
		var xmlGenerals = xml.getElementsByTagName('general');
		if (xmlGenerals /* && xmlGenerals.length > 0*/) {
			for (var i = 0; i < xmlGenerals.length; i++) {
				var xmlGeneral = xmlGenerals[i];
				var docId = xmlGeneral.getAttribute("docId");
				var downloadDocId = xmlGeneral.getAttribute("downloadDocId");
				var docName = xmlGeneral.getAttribute("docName");
				var docSize = xmlGeneral.getAttribute("docSize");
				var docLock = xmlGeneral.getAttribute("locked");
				var docUserLocking = xmlGeneral.getAttribute("userLocking");
				var onlyInformation = xmlGeneral.getAttribute("onlyInformation");
				var docTypeId = xmlGeneral.getAttribute("docTypeId");
				var docTypeLabel = xmlGeneral.getAttribute("docTypeLabel");
				var docTypeFreeMetadata = toBoolean(xmlGeneral.getAttribute("docTypeFreeMetadata"));
				var docDescription = xmlGeneral.getAttribute("docDescription");
				
				var docLang = xmlGeneral.getAttribute("docLang");
				var docLangGroup = xmlGeneral.getAttribute("docLangGroup");
				
				var markedToSign = xmlGeneral.getAttribute("markedToSign") == "true";
				
				onlyInformation = onlyInformation == "true" || onlyInformation == true || window.forceDocOnlyInformation == true;

				if (docLock == "true" || docLock == true) {
					docLock = true;
				} else if (docLock == "false" || docLock == false) {
					docLock = false;
				} else {
					docLock = false;
				}
				
				var elemType = $('mdlDocumentContainer').extraProperties.prefix;
				if (elemType == null) elemType = $('mdlDocumentContainer').getAttribute('current_elem_type');
					//$('mdlDocumentContainer').getAttribute('current_elem_type');
				
				var paramsToModal = {
					docId: docId,
					downloadDocId:downloadDocId,
					docName: docName,
					docSize: docSize,
					docLock: docLock,
					docUserLocking: docUserLocking,
					onlyInformation: onlyInformation,
					docTypeId: docTypeId,
					docTypeLabel: docTypeLabel,
					docTypeFreeMetadata: docTypeFreeMetadata,
					markedToSign: markedToSign,
					docLang: docLang,
					docLangGroup: docLangGroup,
					docDescription: docDescription
				};
				
				
				var fromFrm = xml.getElementsByTagName('fromForm');
				if (fromFrm != null && fromFrm.length > 0) {
					var mdlDocumentContainer = $('mdlDocumentContainer');
					
					if (mdlDocumentContainer.onModalConfirm) {
						mdlDocumentContainer.onModalConfirm (
							mdlDocumentContainer.extraProperties,
							paramsToModal
						)
					} else {
						fncDocumentCreateDocument({
								prefix: elemType,
								addTo: 'prmDocumentContainter' + elemType, 
								buttonAdd: 'docAddDocument' + elemType, 
								allowMultiple: true,
								allowSign: true,
								allowEdition: true,
								allowLock: true,
								readOnly: window.isMonitor ? false : IS_READONLY, 
							},
							paramsToModal
						);
					}
					
					
					
				} else {
					fncDocumentCreateDocument(
							{
								prefix: elemType,
								addTo: 'prmDocumentContainter' + elemType, 
								buttonAdd: 'docAddDocument' + elemType, 
								allowMultiple: true,
								allowSign: true,
								allowEdition: true,
								allowLock: true,
								readOnly: window.isMonitor ? false : IS_READONLY, 
							},
							paramsToModal
						);
				}
			}
		}
	}
	
	/*
	 * si se agregan documentos que ya existian en el objeto, se alerta de ello.
	 * Si algun documento supera el tamaño maximo del tipo de dato seleccionado, se alerta de ello tambien
	 * */

	var docsMessage = '';
	
	var docsAlreadyExist = xml.getElementsByTagName('docAlreadyExists');
	var docsExceedMaxSize = xml.getElementsByTagName('notAllowedFile');
	if (docsAlreadyExist && docsAlreadyExist.length > 0) {
		var mssgToShow = '';//DOCS_NOT_ADDED_ALREADY_EXIST;
		for (i = 0; i < docsAlreadyExist.length; i++) {
			if (mssgToShow != '') {
				mssgToShow += ', ';
			}
			mssgToShow += docsAlreadyExist[i].getAttribute('docName');
		}
		
		mssgToShow = REPEATED_FILES_NOT_ADDED_MSG.replace('<TOK1>', mssgToShow);
		docsMessage += mssgToShow;
	}
	
	if (docsExceedMaxSize && docsExceedMaxSize.length > 0) {
		var mssgExceed = '';
		for (i = 0; i < docsExceedMaxSize.length; i++) {
			if (mssgExceed != '') {
				mssgExceed += ', ';
			}
			mssgExceed += docsExceedMaxSize[i].getAttribute('docName');
		}
		
		mssgExceed = FILES_EXCEED_MAX_SIZE.replace('<TOK1>', mssgExceed);
		if (docsMessage != '') {
			docsMessage += '<br>';
		}
		docsMessage += mssgExceed;
	}
	
	if (docsMessage != '') {
//		modalProcessXml(xml);
		showMessage(docsMessage, DOCUMENTS_ADDED_TITLE, '');
//		SYS_PANELS.closeAll();
	} 
	
	leaveModalInFirstState();
		
}

function fncPrepareModalFormView() {
	// agregar funcion onchange a 
	var type = {'id':null, 'free':null};
	registerCmbDocTypeEvent(true, type);
}

function deleteChangesToDocModal() {
	mdlCloseCommonOperations();
	$('mdlDocumentContainer').blockerModal.hide();
	
	if(DOCUMENTMODAL_HIDE_OVERFLOW) {
		$(document.body).setStyle('overflow', '');
	}
}

function checkDocMonitorUse(prefix) {
	var useDocumentMonitor = toBoolean(GLOBAL_PARAM_ALLOW_MON_DOCUMENT) || toBoolean(ENV_PARAM_ALLOW_MON_DOCUMENT);
	var documentMonitorId = ENV_PARAM_DOC_MON_ID;
	
	/* CHECK IF FUNCTIONALITY/ELEMENT OPEN/EXECUTED HAS PERMISSION TO REUSE DOCUMENTS */
	
	if ( prefix == 'E' && typeof BUS_ENT_PARAMS_FOR_DOC_MODAL !== 'undefined' 
			&& BUS_ENT_PARAMS_FOR_DOC_MODAL[5] && BUS_ENT_PARAMS_FOR_DOC_MODAL[6] > 0) {
		useDocumentMonitor = BUS_ENT_PARAMS_FOR_DOC_MODAL[5];
		documentMonitorId = BUS_ENT_PARAMS_FOR_DOC_MODAL[6];
	} 
	
	if (prefix == 'P' && typeof PRO_PARAMS_FOR_DOC_MODAL !== 'undefined' 
			&& PRO_PARAMS_FOR_DOC_MODAL[5] && BUS_ENT_PARAMS_FOR_DOC_MODAL[6] > 0) {
		useDocumentMonitor = PRO_PARAMS_FOR_DOC_MODAL[5];
		documentMonitorId = PRO_PARAMS_FOR_DOC_MODAL[6];
	}
	
//	if (typeof ENT_DEF_ALLOW_SELECT_EXISTING_FILES !== 'undefined' && typeof ENT_DEF_MONITOR_DOCUMENT_ID !== 'undefined') {
//		useDocumentMonitor = ENT_DEF_ALLOW_SELECT_EXISTING_FILES;
//		documentMonitorId = ENT_DEF_MONITOR_DOCUMENT_ID;
//	}
//	
//	if (typeof FRM_DEF_ALLOW_SELECT_EXISTING_FILES !== 'undefined' && typeof FRM_DEF_MONITOR_DOCUMENT_ID !== 'undefined') {
//		useDocumentMonitor = FRM_DEF_ALLOW_SELECT_EXISTING_FILES;
//		documentMonitorId = FRM_DEF_MONITOR_DOCUMENT_ID;
//	}
//	
//	if (typeof PRO_DEF_ALLOW_SELECT_EXISTING_FILES !== 'undefined' && typeof PRO_DEF_MONITOR_DOCUMENT_ID !== 'undefined') {
//		useDocumentMonitor = PRO_DEF_ALLOW_SELECT_EXISTING_FILES;
//		documentMonitorId = PRO_DEF_MONITOR_DOCUMENT_ID;
//	}
//	
//	if (typeof TSK_DEF_ALLOW_SELECT_EXISTING_FILES !== 'undefined' && typeof TSK_DEF_MONITOR_DOCUMENT_ID !== 'undefined') {
//		useDocumentMonitor = TSK_DEF_ALLOW_SELECT_EXISTING_FILES;
//		documentMonitorId = TSK_DEF_MONITOR_DOCUMENT_ID;
//	}
//	
//	if (typeof ENV_ALLOW_SELECT_EXISTING_FILES !== 'undefined' && typeof ENV_MONITOR_DOCUMENT_ID !== 'undefined') {
//		useDocumentMonitor = ENV_ALLOW_SELECT_EXISTING_FILES;
//		documentMonitorId = ENV_MONITOR_DOCUMENT_ID;
//	}
	
	return {use: useDocumentMonitor, id: documentMonitorId};
}


