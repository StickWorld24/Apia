var table; 
var addNewDoc;
var docType;
var newDoc;
	
var DOCUMENTMODAL_HIDE_OVERFLOW = true;
var MODAL_FOR_ENVIRONMENT_FUNCT = false;

var INDEX = 0;

var FROM_FS = 'F';	// FS
var FROM_EX	= 'E';	// existing
var FROM_TR = 'T';	// tree
var FROM_DR = 'D';	// drop


function initDocumentMdlPage(prefix) {
	var mdlDocumentContainer = $('mdlDocumentContainer');
	if (mdlDocumentContainer.initDone) return;
	mdlDocumentContainer.initDone = true;
	
	$('frmModalDocumentUpload').formChecker = new FormCheck(
		'frmModalDocumentUpload',
		{
			submit:false,
			display : {
				keepFocusOnError : 1,
				tipsPosition: 'left',
				tipsOffsetX: -10
			}
		}
	);
	
	$$("input.datePickerCustom").each(function(datepicker) {
		datepicker.set('data-hasDatepicker', true);
		var img = new Element("img", {src: CONTEXT+"/css/base/img/calendar.png"});
		img.set('alt','datepicker');
		img.inject(datepicker,"after");

		var format = (datepicker.getAttribute("format") == null) ? DATE_FORMAT : datepicker.getAttribute("format");
		
		var datepicker_opts = { 
				pickerClass: 'datepicker_vista', 
				allowEmpty: true, 
				format: format, 
				inputOutputFormat: format, 
				toggleElements: img,
				toggleElementsDontAvoid: true,
				onClose: function(o){ validateDateDocModal(o); }
			};
		
		if(window.LBL_DAYS) {
			datepicker_opts.days = window.LBL_DAYS;
		}
		if(window.LBL_MONTHS) {
			datepicker_opts.months = window.LBL_MONTHS;
		}
		
		new DatePicker(datepicker, datepicker_opts);
	});
	
	var mdlInfoBttn = $('mdlInfoDocType'); 
	
	if (mdlInfoBttn) {
		$('mdlInfoDocType').addEvent('mouseleave', function(evt) {
			if (evt) evt.stop();
			$('mdlTmpDivDocInfo').style.display = 'none';
		});
		
		$('mdlInfoDocType').addEvent('mouseenter', function(evt) {
			if (evt) evt.stop();

			var value = $('cmbDocType').value;
			var xml;
			var extra = $('mdlDocumentContainer').extraProperties;
			var extra_params = "";
			if(extra && extra.params)
				extra_params = extra.params;
			
			var url = (extra && extra.url_aux) ? extra.url_aux : URL_REQUEST_AJAX;
			
			new Request({
				method: 'post',
//				async: false,
				url: CONTEXT + url + "?action=getDocTypeInformation" + "&isAjax=true" + TAB_ID_REQUEST,
				onComplete: function(resText, resXml) { 
					var xml = resXml;
					var allowedFiles = LBL_ACCEPTED_DC_TYPE + ': ';	
					var forbiddenFiles = LBL_NOT_ACCEP_DC_TYPE + ': ';
					var allowedTypes = xml.getElementsByTagName('typeAllowed');
					var forbiddenTypes = xml.getElementsByTagName('typeForbidden');
					if (allowedTypes && allowedTypes.length > 0) {
						var someAdded = false;
						for (i = 0; i < allowedTypes.length; i++) {
							if (allowedTypes.length == 1 && allowedTypes[i].getAttribute('docType') == 'all') {
								allowedFiles += MSG_ALL_DC_TYPE_ACCEPTED; 	
							} else {
								var docType = allowedTypes[i].getAttribute('docType').toLowerCase();
								var docMaxSize = allowedTypes[i].getAttribute('docMaxSize');
								var docMaxSizeType = allowedTypes[i].getAttribute('docMaxSizeType');
								if (docType && docType.length > 0) {
									allowedFiles += '<br>&nbsp;';
									allowedFiles += docType.toUpperCase();
									if (parseFloat(docMaxSize) && parseFloat(docMaxSize) > 0) 
										allowedFiles += '. ' + LBL_MAX_SIZE + ': ' + docMaxSize + ' ' + docMaxSizeType.toUpperCase();
									someAdded = true;
								}
							}
						}
					}
					
					var extraParams = $('mdlDocumentContainer').extraProperties && $('mdlDocumentContainer').extraProperties.params 
										? $('mdlDocumentContainer').extraProperties.params : '';
									
					if (forbiddenTypes && forbiddenTypes.length > 0 && extraParams.contains('frmId')) {
						var someAdded = false;
						for (i = 0; i < forbiddenTypes.length; i++) {
							forbiddenFiles += (someAdded == true ? ',' : '');
							if (forbiddenTypes.length == 1 && forbiddenTypes[0].getAttribute('docType') == 'none')
								forbiddenFiles += MSG_NO_ARE_FORBIDDEN_DC_TYPES;	// no hay extensiones prohibidas
							else {
								var type = forbiddenTypes[i].getAttribute('docType');
								forbiddenFiles += (type && type.length > 0 ? type.toUpperCase() : '');
								someAdded = true;
							}
						}
					}
					
					var div = $('mdlTmpDivDocInfo');
					div.removeClass('hidden');
					div.innerHTML = allowedFiles + (extraParams.contains('frmId') ? '<br>' + forbiddenFiles : '');
					div.position({
						relativeTo: 'mdlInfoDocType',
						position: 'centerRight',
						edge: 'bottomLeft'
					});

					// se muestra el div con la información de los tipos de datos
					div.style.width = 'auto';
					div.style.border = '1px solid black';
					div.style.height = 'auto';
					div.style.display = '';
					
					div.setStyle('zIndex', SYS_PANELS.getNewZIndex());
					div.addClass('mdlMiniInfo');
				}
			}).send('docTypeId=' + value + extra_params);
		})	
			
	}
	
	mdlDocumentContainer.blockerModal = new Mask();
	
	var mdlDocumentInfo = $('mdlDocumentInfo');
	mdlDocumentInfo.blockerModal = new Mask();
	
	var mdlDocumentAddPool = $('mdlDocumentAddPool');
	var mdlDocumentAddUser = $('mdlDocumentAddUser');
	var btnCloseDocumentModal = $('btnCloseDocumentModal');
	var btnCloseDocumentModalInfo = $('btnCloseDocumentInfo');
	var btnConfirmDocumentModal = $('btnConfirmDocumentModal');
	
	docType = {'id':null,'free':null};
	
	registerCmbDocTypeEvent(false, docType);
	
	var btnAddMeta = $('btnAddMeta');
	if (btnAddMeta){
		btnAddMeta.addEvent("click",function(e){
			if (e) e.stop();
			if (docType && docType.free){
				addMetadata(null, null, "S", true, "", "", true, null);				
				fixTableMetadata();
			}			
		});
	}
	
	var btnDeleteMeta = $('btnDeleteMeta');
	if (btnDeleteMeta){
		btnDeleteMeta.addEvent("click",function(e){
			e.stop();
			if (docType && docType.free){
				if (selectionCount(table) == 0) {
					showMessage(GNR_CHK_AT_LEAST_ONE, GNR_TIT_WARNING, 'modalWarning');
				} else {
					var selecteds = getSelectedRows(table);
					for (var i = 0; i < selecteds.length; i++){
						deleteRowMetadata(selecteds[i]);
					}				
					fixTableMetadata();
				}
			}
		});
	}
	
	if (mdlDocumentAddPool) {
		mdlDocumentAddPool.addEvent("click", function(e) {
			if(e) e.stop();
			//setear variables de configuracion del modal de grupos
			//POOLMODAL_SHOWAUTOGENERATED = true;
			//abrir modal
			$('mdlDocumentContainer').addClass('hiddenModal');
			showPoolsModal(docProcessPoolsModalReturn, docProcessPoolsUsersModalClose);
		});
		mdlDocumentAddPool.addEvent('keypress', Generic.enterKeyToClickListener);
	}
	
	if (mdlDocumentAddUser) {
		mdlDocumentAddUser.addEvent("click", function(e) {
			if(e) e.stop();
			
			USERMODAL_GLOBAL_AND_ENV = true;
			
			$('mdlDocumentContainer').addClass('hiddenModal');
			showUsersModal(docProcessUsersModalReturn, docProcessPoolsUsersModalClose);
		});
		mdlDocumentAddUser.addEvent('keypress', Generic.enterKeyToClickListener);
	}
	
	if (btnCloseDocumentModal) {
		btnCloseDocumentModal.addEvent("click", closeDocumentsModal);
		btnCloseDocumentModal.addEvent('keypress', Generic.enterKeyToClickListener);
	}
	if(btnCloseDocumentModalInfo){
		btnCloseDocumentModalInfo.addEvent("click", closeDocumentModalInfo);
	}
	
	if (btnConfirmDocumentModal) {
		
		btnConfirmDocumentModal.progressMessages		= $("documentProgressMessages");
		btnConfirmDocumentModal.progressBar				= $("documentProgressBar");
		btnConfirmDocumentModal.progressBarContainer	= $("documentProgressBarContainer");
		btnConfirmDocumentModal.prefix = prefix;
		btnConfirmDocumentModal.showProgressBar = function() {
			if (this.progressMessages) this.progressMessages.empty();
			if (this.progressBar) this.progressBar.style.width = "0px";
		};
		
		btnConfirmDocumentModal.callUpdateStatus = function (){
			var extra = $('mdlDocumentContainer').extraProperties;
			var extra_params = "";
			if(extra && extra.params)
				extra_params = extra.params;
			
			var url = (extra && extra.url_aux) ? extra.url_aux : URL_REQUEST_AJAX;
			var action = (extra && extra.action == 'associateExistingFile') ? 'associateExistingFile' : 'ajaxUploadFileStatus';  
			
			new Request({
				method: 'post',
				url: CONTEXT + url + "?action=" + action + extra_params + "&isAjax=true" + TAB_ID_REQUEST + "&prefix=" + $('mdlDocumentContainer').get("data-prefix"),
				onComplete: function(resText, resXml) { modalProcessXml(resXml);  }
			}).send();
		}
		
		registerOnClickActionModal();
		
		btnConfirmDocumentModal.addEvent('keypress', Generic.enterKeyToClickListener);
		
		btnConfirmDocumentModal.addEvent('keydown', function(e) {
			if(!e.shift && e.key == 'tab') {
				e.preventDefault();
				mdlDocumentContainer.focus();
			}
		});
	}
	
	mdlDocumentContainer.addEvent('keydown', function(e) {
		
		if(e.target == mdlDocumentContainer && e.shift && e.key == 'tab') {
			e.preventDefault();
			btnConfirmDocumentModal.focus();
		}
	});
	
	$('documentModalDocFile').addEvent('change', function(evt) {
		if (evt) evt.stop();
		processDocAddedFromFS(this.value);
	});
	
	if ($('btnOpenDocFldMdl')) {
		$('btnOpenDocFldMdl').addEvent('click', function(evt) {
			$('mdlDocumentContainer').addClass('hiddenModal');
			TREEDCSFLD_MODAL_SHOW_DOCUMENTS_ON_FLD_CLICK = true;
			showTreeDocsFldsModal(cnfDocFldModal, closeFldModalRet, 
			{
				'root': $('mdlDocumentContainer').extraProperties.rootFolderId, 
				'docTypePermitted' : $('mdlDocumentContainer').extraProperties.docTypePermitted
			});
		});
	}
	
//	initTreeDocsFldsMdlPage();
	
	window.addEvent('resize', function(evt) {
		if ($('mdlDocumentContainer').isVisible()) {
			$('mdlDocumentContainer').position();
//			$('mdlDocumentContainer').resizeModal();
		}
	});	
	
	var arrOpenClose = $$('div.collapseMdlDocSection');
	arrOpenClose.append($$('div.expandPermission'));
	
	arrOpenClose.each(function(elem) {
		elem.addEvent('click', function(evt) {
			if (evt) evt.stop();
			if (this.hasClass('collapseMdlDocSection') || this.hasClass('expandMdlDocSection')) this.toggleClass('expandMdlDocSection').toggleClass('collapseMdlDocSection');
			else if (this.hasClass('collapsePermission') || this.hasClass('expandPermission')) this.toggleClass('expandPermission').toggleClass('collapsePermission');
			if (this.hasClass('collapseMdlDocSection') || this.hasClass('collapsePermission')) this.getNext().getNext().setStyle('display', '');
			else this.getNext().getNext().setStyle('display', 'none');
			
			if (this.getParent('div').id == 'metadata') {
				table = $('tableMetadata');
				fixTableMetadata();
			}
			
			$('mdlDocumentContainer').position();
		});
		if (elem.getParent('div').id != 'documentInfoContainer') elem.fireEvent('click');
//		elem.toggleClass('expandMdlDocSection').toggleClass('collapseMdlDocSection');
	});
}

function validateDateDocModal(date) {
	var currentDate = new Date();
	currentDate = currentDate.getDate() + '/' + + (currentDate.getMonth() + 1) + "/" + currentDate.getFullYear();
	var dteElem = new Element('span', {'value': currentDate});
	
	var inputDate = date.value;
	if (!verifyDates(dteElem, date)) {
		date.getNext().value = '';
		showMessage(MSG_ERROR_DATE, GNR_TIT_WARNING, 'modalWarning');
	}
	
}

function closeFldModalRet() {
//	closeDocsFldModal();
	$('mdlDocumentContainer').removeClass('hiddenModal');
	$('mdlDocumentContainer').position();
}

function cnfDocFldModal(docId) {
//	cnfirmMonDocsRet(docId, true);
//	$('mdlDocumentContainer').droppedFiles = [];
//	disableFileSystemUpload();
	
	$('mdlDocumentContainer').removeClass('hiddenModal');
	$('mdlDocumentContainer').position();
	
	cnfirmMonDocsRet(docId, true);
	$('mdlDocumentContainer').droppedFiles = [];
	disableFileSystemUpload();
}

function registerCmbDocTypeEvent(forDroppedDocsModal, docType, fromDocumentReuse) {
	var cmbDocType = $('cmbDocType');
	if (cmbDocType){
		cmbDocType.addEvent("change",function(e){
			if (e) e.stop();
			
			if (!docType) {
				docType = {'id':null,'free':null};
			}
			
			docType.id = this.value;
			docType.free = toBoolean(this.options[this.selectedIndex] != undefined ? this.options[this.selectedIndex].get("data-free") : false);

			var strMetadata = "";
			table.getElements("tr").each(function(tr){
				if (!tr.getRowFree()){
					if (strMetadata != "") strMetadata += ";";
					strMetadata += tr.getRowName() + AUXILIAR_SEPARATOR + tr.getRowType() + AUXILIAR_SEPARATOR + tr.getRowValue();					
				}
			});
			
			var extra = $('mdlDocumentContainer').extraProperties;
			var url = (extra && extra.url_aux) ? extra.url_aux : URL_REQUEST_AJAX;
			
			// dropped documents
			if (this.selectedOptions != undefined) {
				if ($('documentModalDocFile') && $('documentModalDocFile').value != '') {
					var previews = $('docsNamesContainer').getChildren('span');
					if (previews != null && previews.size > 0) {
						var addedDocType = previews[0].getChildren('div')[0].getChildren('div')[0].getAttribute('data-type');
						var docsTypes = this.selectedOptions[0].getAttribute('data-extensions');
						var docSize = this.selectedOptions[0].getAttribute('data-maxValueAllowed');
						if (!docsTypes.contains(addedDocType)) {
							deleteAllDocumentsPreviews(false);
						}
					}
				} else {
					var docsTypes = this.selectedOptions[0].getAttribute('data-extensions');
					var docSize = this.selectedOptions[0].getAttribute('data-maxValueAllowed');
					
					showOrHideDocuments(docsTypes, docSize);
				}
				
			}
			
			//reuse docs params
			if (typeof fromDocumentReuse !== 'undefined' && fromDocumentReuse === true) {
				fncOnChngCmb();
			}

			var docId;
			var forReuse = ($('documentInfoContainer').isVisible() && $('docsNamesContainer').getElementsByClassName('option canRemove')) 
					&& (typeof $('btnOpenMonDoc') !== 'undefined' || typeof $('btnOpenCusMonDoc') !== 'undefined');
			if (forReuse) {
				docId = $('docsNamesContainer').getElementsByClassName('option canRemove')[0].getAttribute('docid');
			}
			
			var customParams = '';
			if (extra && extra.restoreDoc)	customParams += '&restoreDoc=' + extra.restoreDoc;
			if (extra && extra.docId) customParams += '&docId=' + extra.docId;
			if (extra && extra.newElem) customParams += '&newElem=' + extra.newElem;
			if (forReuse) customParams += '&docReuse=true';
			if (extra && extra.reuseDocAdded) {
				customParams += '&firstTime=' + extra.reuseDocAdded;
				$('mdlDocumentContainer').extraProperties.reuseDocAdded = 'false';
			}
			
			// abm documents
			var forAbm = $('btnConfirmDocumentModal').prefix === 'ABM';
			if (forAbm) customParams += '&forAbm=' + true;
			
			if(PRIMARY_SEPARATOR_IN_BODY) {
				new Request({
					method: 'post',
					url: CONTEXT + url + '?action=reloadMetadata&isAjax=true&docTypeId=' + docType.id + customParams /*(forReuse ? '&docId=' + docId : '')*/  + TAB_ID_REQUEST + ((extra && extra.params) ? '&' + extra.params : '') + "&prefix=" + $('mdlDocumentContainer').get("data-prefix"),
					onRequest: function() { SYS_PANELS.showLoading(); },
					onComplete: function(resText, resXml) {
						processXmlMetadata(resXml); 
					}
				}).send('metadata=' + strMetadata);
			} else {
				new Request({
					method: 'post',
					url: CONTEXT + url + '?action=reloadMetadata&isAjax=true&docTypeId=' + docType.id + customParams /*(forReuse ? '&docId=' + docId  + '&docReuse=true': '')*/ + '&metadata=' + encodeURIComponent(strMetadata) + TAB_ID_REQUEST + ((extra && extra.params) ? '&' + extra.params : '') +  "&prefix=" + $('mdlDocumentContainer').get("data-prefix"),
					onRequest: function() { SYS_PANELS.showLoading(); },
					onComplete: function(resText, resXml) { 
						processXmlMetadata(resXml); 
					}
				}).send();
			}
		});
	}
}

function registerOnClickActionModal() {
	$('btnConfirmDocumentModal').addEvent('click', function(evt){
		//validar datos del formulario
		var form = $('frmModalDocumentUpload');
		if(!form.formChecker.isFormValid() || !validFreeMetadataTitles()){
			if ($('tableMetadata').getChildren('tr').length > 0) {
				if ($('metadata').getChildren('div')[0].hasClass('expandMdlDocSection')) {
					$('metadata').getChildren('div')[0].fireEvent('click');
				}
			}
			return;
		}			
		
		var extra = $('mdlDocumentContainer').extraProperties;
		var extra_params = "";
		if(extra && extra.params) {
			extra_params = extra.params;
			extra_params = extra_params.replace('&delayForDrop=true', '');
		}
			
		
		var url = (extra && extra.url_aux) ? extra.url_aux : URL_REQUEST_AJAX;
		
		var txtMetadata = ""; //id�type�value;id�type�value...
		var txtFreeMetadata = ""; //title�value;title�value...
		
		$('tableMetadata').getElements("tr").each(function (tr){ 
			if (tr.getRowValue() != ""){ //no se guardan los que no tienen valor
				
				if (!tr.getRowFree()){ //fijo
					if (txtMetadata != "") txtMetadata += ";";
					txtMetadata += tr.getRowId() + AUXILIAR_SEPARATOR + tr.getRowType() + AUXILIAR_SEPARATOR + tr.getRowValue();
					
				} else { //free
					if (txtFreeMetadata != "") txtFreeMetadata += ";";
					var inputTitle = tr.getRowInputTitle();
					txtFreeMetadata += inputTitle.value + AUXILIAR_SEPARATOR + tr.getRowValue();
				}
				
			}
		});
		
//		extra_params += '&docFolder=' + $$('li.folder.selected')[0].id;
		
		var docFolderId = '';
		
		if ($$('li.folder.selected').length > 0) {
			docFolderId = /*'&docFolder=' +*/ $$('li.folder.selected')[0].id.substring(0, $$('li.folder.selected')[0].id.indexOf('_'));
		}
		else if ($('mdlDocumentContainer').extraProperties && $('mdlDocumentContainer').extraProperties.defaultFolderId) {
			docFolderId = /*'&docFolder=' + */ $('mdlDocumentContainer').extraProperties.defaultFolderId;
		}
		
//		extra_params += '&docExpDate=' + $('docExpDate').value;
		
		if(PRIMARY_SEPARATOR_IN_BODY) {
			var frmModalDocumentUpload = $('frmModalDocumentUpload');
			frmModalDocumentUpload.action = CONTEXT + url + "?action=ajaxUploadFile" + extra_params + "&isAjax=true" + TAB_ID_REQUEST + "&prefix=" + $('mdlDocumentContainer').get("data-prefix");
			
			var txtMetadataAux = $('txtMetadataAux');
			if(txtMetadataAux)
				txtMetadataAux.destroy();
			
			var txtFreeMetadataAux = $('txtFreeMetadataAux');
			if(txtFreeMetadataAux)
				txtFreeMetadataAux.destroy();
			
			frmModalDocumentUpload.grab(new Element('input', {
				id: 'txtMetadataAux',
				name: 'txtMetadata',
				type: 'hidden'
			}).set('value', txtMetadata));		// todo esto que esta en los inputs ocultos no lo esta tomando!!
			
			frmModalDocumentUpload.grab(new Element('input', {
				id: 'txtFreeMetadataAux',
				name: 'txtFreeMetadata',
				type: 'hidden'
			}).set('value', txtFreeMetadata));
			
			var txtLangId = $('txtLangId');
			if(txtLangId) txtLangId.destroy();
			
			var txtLangGroup = $('txtLangGroup');
			if(txtLangGroup) txtLangGroup.destroy();
			
			frmModalDocumentUpload.grab(new Element('input', {
				id: 'txtLangId',
				name: 'txtLangId',
				type: 'hidden'
			}).set('value', extra.langId));
			
			frmModalDocumentUpload.grab(new Element('input', {
				id: 'txtLangGroup',
				name: 'txtLangGroup',
				type: 'hidden'
			}).set('value', extra.docLangGroup));
			
			frmModalDocumentUpload.grab(new Element('input', {
				id: 'docFolder',
				name: 'docFolder',
				type: 'hidden'
			}).set('value', docFolderId));
			
		} else {
			if(extra.langId)
				extra_params += '&txtLangId=' + extra.langId;
			
			if(extra.docLangGroup)
				extra_params += '&txtLangGroup=' + extra.docLangGroup;
			
			$('frmModalDocumentUpload').action = CONTEXT + url + "?action=ajaxUploadFile" + extra_params + "&isAjax=true" 
				+ TAB_ID_REQUEST + "&prefix=" + $('mdlDocumentContainer').get("data-prefix") 
				+ "&txtMetadata=" + txtMetadata  + "&txtFreeMetadata=" + txtFreeMetadata + '&docFolder=' + docFolderId;
		}
		
		extra_params += '&docExpDate=' + $('docExpDate').value;
		if(extra.langId) extra_params += '&txtLangId=' + extra.langId;
		if(extra.docLangGroup) extra_params += '&txtLangGroup=' + extra.docLangGroup;
		
		if (extra.action == 'confirmDropModal') {
			var params = processMdlFrm(); 
			var elemType = extra.prefix;
			
			var droppedDocumentNames = '';
			if ($('mdlDocumentContainer').droppedFiles.length > 0) {
				for (i = 0; i < $('mdlDocumentContainer').droppedFiles.length; i++) {
					droppedDocumentNames += '&dropped=' + encodeURIComponent($('mdlDocumentContainer').droppedFiles[i].name);
				}
			}
			
			var request = new Request({
				method: 'post',
				url: CONTEXT + '/' + url + '?action=confirmDropModal&elemType=' + elemType + extra_params + "&fromForm=true" + TAB_ID_REQUEST,
				onRequest: function() { SYS_PANELS.showLoading(); },
				onComplete: function(resText, resXml) { processModalFromDrop(resXml);  },
				onSuccess: function() {
//					console.log(lastFunctionAjaxCall);
//					SYS_PANELS.closeActive();
//					if ($('mdlDocumentContainer').extraProperties.prefix && $('mdlDocumentContainer').extraProperties.prefix == 'ABM') {
//						$('mdlDocumentContainer').onModalConfirm();
//					}
				}
			}).send(params + droppedDocumentNames);
			
			console.log(lastFunctionAjaxCall);
			
//			$('mdlDocumentContainer').addClass('hiddenModal');
//			$('mdlDocumentContainer').blockerModal.hide();
//			deleteAllPerms();
			
		} else if (extra.action === 'confirmExistingDocuments') {
			var mdlDocumentContainer = $('mdlDocumentContainer');
			var params = processMdlFrm(); 
			if (mdlDocumentContainer.extraProperties && mdlDocumentContainer.extraProperties.prefix) {
				params += '&elemType=' +  mdlDocumentContainer.extraProperties.prefix;
			}
			var request = new Request({
				method: 'post',
				url: CONTEXT + '/' + url + '?action=associateExistingFile' + (typeof extra_params !== 'undefined' && extra_params !== null ? extra_params : '') + "&fromForm=true&fromReuse=true" + TAB_ID_REQUEST+"&uploadDocument=false",
				onRequest: function() {  },
				onComplete: function(resText, resXml) {
					var sysMessages = resXml.getElementsByTagName('sysMessages');
					if (sysMessages.length > 0) {
						modalProcessXml(resXml);
					} else {
						
						modalProcessXml(resXml);
						mdlDocumentContainer.blockerModal.hide();
						mdlDocumentContainer.addClass('hiddenModal');
						deleteAllPerms();
					}
				}
			}).send(params);
		} else {
			$('frmModalDocumentUpload').submit();
			this.showProgressBar();
			this.callUpdateStatus.delay(200);
		}
	});
}

function processModalFromDrop(xml) {
	var sysMessages = [];
	if (xml.getElementsByTagName('sysExceptions')) sysMessages.append(xml.getElementsByTagName('sysExceptions'));
	if (xml.getElementsByTagName('sysMessages')) sysMessages.append(xml.getElementsByTagName('sysMessages'));
	modalProcessXml(xml);
	if (!sysMessages || sysMessages.length == 0) {
//		SYS_PANELS.closeActive();
		$('mdlDocumentContainer').addClass('hiddenModal');
		$('mdlDocumentContainer').blockerModal.hide();
		deleteAllPerms();
	}
}

function ajaxUploadUpdateStatus() {
	var doCall = false;
	var doClose = true;
	var ajaxCallXml = getLastFunctionAjaxCall();
	if (ajaxCallXml != null) {
		var messages = ajaxCallXml.getElementsByTagName("messages");
		
		if (messages != null && messages.length > 0 && messages.item(0) != null) {
			messages = messages.item(0).getElementsByTagName("message");
			
			var status		= null;
			var totalRead	= 0;
			var totalSize	= 1;
			var theMessage	= "";
			
			for(var i = 0; i < messages.length; i++) {
				var message = messages.item(i);
				var param	= message.getAttribute("name");
				var text 	= "";
				
				if (message.firstChild != null) text = message.firstChild.nodeValue;
				
				if ("status" == param) {
					status = text;
				
				} else if ("totalRead" == param) {
					totalRead = text;
				
				} else if ("totalSize" == param) {
					totalSize = text;
					
				} else if ("message" == param) {
					theMessage = text;
				}
			}

			var progressMessages		= $("documentProgressMessages");
			var progressBar				= $("documentProgressBar");
			var progressBarContainer	= $("documentProgressBarContainer");

			if (progressBar != null && progressBarContainer != null)	{
				progressBar.style.width = parseInt((totalRead / totalSize) * 100) + "%";
			};
			
			if (progressMessages != null) {
				if(status == 3){
					progressBar.style.width = "0px";
					showMessage(theMessage, "Error", "modalError");
				} else if (theMessage != '') {
					if (!$('mdlDocumentContainer').isVisible()) showMessage(theMessage, GNR_TIT_WARNING, 'modalWarning');
					else progressMessages.innerHTML = theMessage;
				}
			}
			
			doCall = status == -1 || status == 1;
			doClose = (theMessage == null || theMessage == "") && ! doCall;
		}
	}
	
	if (doCall) { 
		var funCall = ajaxCallXml.getAttribute("funCall");
		if (funCall!=null){
			setTimeout(funCall,200);
		}else{
			$('btnConfirmDocumentModal').callUpdateStatus.delay(200);
		}
	} else if (doClose) {
		SYS_PANELS.closeAll();
	}
	
	return true;
}

function docProcessPoolsUsersModalClose() {
	$('mdlDocumentContainer').removeClass('hiddenModal').focus();
}

function docProcessPoolsModalReturn(ret) {
	ret.each(function(e){
		var text = e.getRowContent()[0];
		var id = e.getRowId();
		
		docProcessModalReturn(id, text, false, true);
	});
}

function docProcessUsersModalReturn(ret) {
	ret.each(function(e){
		var text = e.getRowContent()[0];
		var id = e.getRowId();
		
		docProcessModalReturn(id, text, false, false);
	});
}

function docProcessModalReturn(id, text, canUpdate, pool, info) {
	var mdlDocumentContainer = $('mdlDocumentContainer');
	
	var checkIn = pool ? mdlDocumentContainer.addedPools : mdlDocumentContainer.addedUsers;
	
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
			mdlDocumentContainer.focus();
		}).addEvent('keypress', Generic.enterKeyToClickListener).inject(span);	
	}

	var permContainer = $('scrollOptions' + (info? 'Info' : ''));
	
	span.inject(permContainer);
	$('mdlDocumentContainer').position();
}


function showDocumentsModal(retFunction, docId, extra, docInfo, hidePermissiosn, hideMetadata, retFunctionClose){
	$('mdlDocumentContainer').set("data-prefix", extra.prefix);
	
	if (extra && extra.prefix == 'ABM' && extra.action == 'editABM') {
		$('documentModalDocFile').getParent('tr').setStyle('display', 'none');
		$('mdlDropArea').getParent('tr').setStyle('display', 'none');
		$('cmbDocType').getParent('td').setStyle('width', '100%');
	}
	
	if(DOCUMENTMODAL_HIDE_OVERFLOW) {
		$(document.body).setStyle('overflow', 'hidden');
	}
	
	$(document.body).setStyle('overflow', '');
	
	table = $('tableMetadata');
	addNewDoc = true;
	
	var frmModalDocumentUpload = $('frmModalDocumentUpload');
	if(frmModalDocumentUpload)
		frmModalDocumentUpload.reset();
	
	var hidePermission = hidePermissiosn;
	if (typeof BUS_ENT_PARAMS_FOR_DOC_MODAL != undefined && extra.prefix == 'E') hidePermission = hidePermission || BUS_ENT_PARAMS_FOR_DOC_MODAL[0];
	if (typeof PRO_PARAMS_FOR_DOC_MODAL != undefined && extra.prefix == 'P') hidePermission = hidePermission || PRO_PARAMS_FOR_DOC_MODAL[0];
	
	var hideMeta = hideMetadata;
	if (typeof BUS_ENT_PARAMS_FOR_DOC_MODAL != undefined && extra.prefix == 'E') hideMeta = hideMeta || BUS_ENT_PARAMS_FOR_DOC_MODAL[1];
	if (typeof PRO_PARAMS_FOR_DOC_MODAL != undefined && extra.prefix == 'P') hideMeta = hideMeta || PRO_PARAMS_FOR_DOC_MODAL[1];
	
	
	if(hidePermission)
		$('permission').setStyle('display', 'none');
	else
		$('permission').setStyle('display', '');
	
	if(hideMeta)
		$('metadata').setStyle('display', 'none').set('data-hideMetadata', 'true');
	else
		$('metadata').setStyle('display', '').set('data-hideMetadata', 'false');
	
	$('documentModalDocFile').value = '';
	$('documentModalDocDesc').value = '';
	$('mdlDocumentPoolContainter').getElements("span.canRemove").each(function(ele) { ele.dispose(); });
	$("documentProgressMessages").innerHTML = "";
	$('documentProgressBar').style.width = '0px';
	
	var mdlDocumentContainer = $('mdlDocumentContainer');
	mdlDocumentContainer.addedPools = [];
	mdlDocumentContainer.addedUsers = [];
	mdlDocumentContainer.setStyle('zIndex', SYS_PANELS.getNewZIndex());
	mdlDocumentContainer.onModalConfirm = retFunction;
	mdlDocumentContainer.onModalClose = retFunctionClose;
	mdlDocumentContainer.extraProperties = extra;
	mdlDocumentContainer.filesToDelete = [];
	
	$('btnConfirmDocumentModal').removeEvents('click');
	if (mdlDocumentContainer.droppedFiles == undefined || mdlDocumentContainer.droppedFiles.length == 0) mdlDocumentContainer.droppedFiles = [];
	
	if(DOCUMENT_EVERYONE_PERMISSION=="false") {
		$('selDocAllPoolPerm').selectedIndex = 2;
		docProcessModalReturn(CURRENT_USER_LOGIN, CURRENT_USER_LOGIN, true, false);
	} else {
		$('selDocAllPoolPerm').selectedIndex = 0;
	}
	
	if(DOCUMENT_OWNER_PRIVILEGES=="true"){
		docProcessModalReturn(CURRENT_USER_LOGIN, CURRENT_USER_LOGIN, true, false);
	}
	
	var frmData = $('frmData');
	if(frmData)
		frmData.formChecker.reinitialize('forced');
	
	// the first part evaluates for process and entity instances; second part evaluates for file inputs
	var showFldBttn = false;
	if (extra && extra.prefix && (extra.prefix == 'E' || extra.prefix == 'P')) {
		if (extra.prefix == 'E') showFldBttn = (typeof BUS_ENT_PARAMS_FOR_DOC_MODAL != undefined && BUS_ENT_PARAMS_FOR_DOC_MODAL[8]) 
									&& (docId == null || docId == '' || docId == undefined) && (extra.langId == undefined || extra.langId == null);
		else showFldBttn = (typeof PRO_PARAMS_FOR_DOC_MODAL != undefined && PRO_PARAMS_FOR_DOC_MODAL[8]) 
									&& (docId == null || docId == '' || docId == undefined);
	} else if (extra && toBoolean(extra.openedForForm)) {
		if (parseInt(extra.langId) > 0) showFldBttn = false;
		else showFldBttn = true;
	} else {
		if (toBoolean(MODAL_FOR_ENVIRONMENT_FUNCT)) showFldBttn = MODAL_FOR_ENVIRONMENT_FUNCT && (toBoolean(GLOBAL_PARAM_ALLOW_FLD_STRC_DOC) || toBoolean(ENV_PARAM_ALLOW_FLD_STRC_DOC));
		else showFldBttn = toBoolean(GLOBAL_PARAM_ALLOW_FLD_STRC_DOC) || toBoolean(ENV_PARAM_ALLOW_FLD_STRC_DOC);
	}
	
//	if (showFldBttn && extra && extra.prefix != 'ABM') {
//		$('btnOpenDocFldMdl').getParent('tr').setStyle('display', '');
//	} else {
//		$('btnOpenDocFldMdl').getParent('tr').setStyle('display', 'none');
//	}
	
	if (extra && (extra.showFoldersTreeBtn || extra.showFoldersTreeBtn == undefined) && !MODAL_FOR_ENVIRONMENT_FUNCT && extra.prefix != 'ABM' && showFldBttn) {
		$('btnOpenDocFldMdl').getParent('tr').setStyle('display', '');
	} else {
		$('btnOpenDocFldMdl').getParent('tr').setStyle('display', 'none');
	}
	
	var showFldTree = !MODAL_FOR_ENVIRONMENT_FUNCT && (GLOBAL_PARAM_ALLOW_FLD_STRC_VW || ENV_PARAM_ALLOW_FLD_STRC_VW);
	if (typeof BUS_ENT_PARAMS_FOR_DOC_MODAL != undefined && extra.prefix == 'E') showFldTree =  BUS_ENT_PARAMS_FOR_DOC_MODAL[7];
	if (typeof PRO_PARAMS_FOR_DOC_MODAL != undefined && extra.prefix == 'P') showFldTree =  PRO_PARAMS_FOR_DOC_MODAL[7];
	if (extra && extra.openedForForm) showFldTree = extra.showFoldersTreeStr;
	
	if (showFldTree) {
		$('foldersStruct').getParent('div').getParent('div').setStyle('display', '');
		if (extra && extra.rootFolderId) loadHtmlStructure(true, 'foldersStruct', extra.rootFolderId);
		else loadHtmlStructure(true, 'foldersStruct');
	}
	
	if (extra && (extra.docExpDateAllow || extra.docExpDateAllow == undefined)) {
		$('docExpDate').getParent('tr').setStyle('display', '');
	} else {
		$('docExpDate').getParent('tr').setStyle('display', 'none');
	}
	
//	if ($('mdlDocumentContainer').extraProperties && $('mdlDocumentContainer').extraProperties.showForDrop && $('mdlDocumentContainer').extraProperties.showForDrop === true ) {
//		console.log('<------------------------- SHOW FOR DROP PROPERTY ---------------------->');
//		styleModalForDroppedBehaviour();
//		
//		$('cmbDocType').removeEvents('change');
//		registerCmbDocTypeEvent();
//		
//		var strParamsDocTypePermitted = '';
//		mdlDocumentContainer.blockerModal.show();
//		mdlDocumentContainer.removeClass('hiddenModal');
//	} else {

		registerOnClickActionModal();
		
		if (! docId) docId = "";
		if (! extra) extra = {};
		if (! docInfo) docInfo = {};
		var action = 'ajaxUploadStart';//(extra && extra.avoidAjaxCall ? "" : 'ajaxUploadStart');
		if (extra.action!=null && extra.prefix !== 'ABM'){
			action = extra.action; 
		}
		
		if(extra.params) {
			action += extra.params;
		}
		
		var strParamsDocTypePermitted = '';
		
		if (docId == ""){ //subir archivo nuevo
			$('cmbDocType').value = DEFAULT_DOC_TYPE_ID; //DEFAULT
			$('cmbDocType').setStyle("display","");
			$('spanDocType').innerHTML = "";
			$('spanDocType').setStyle("display","none");		
			docType.id = DEFAULT_DOC_TYPE_ID;
			docType.free = false;
			newDoc = true;		
			if (extra.docTypePermitted){
				var useDocTypePermitted = extra.docTypePermitted.use;
				var docTypePermittedObjType = extra.docTypePermitted.objType;
				var docTypePermittedObjId = extra.docTypePermitted.objId;
				strParamsDocTypePermitted = '&useDocTypePermitted=' + useDocTypePermitted + '&docTypePermittedObjType=' + docTypePermittedObjType + '&docTypePermittedObjId=' + docTypePermittedObjId
			}
		} else { //subir version nueva
			$('cmbDocType').value = docInfo.docTypeId;
			$('cmbDocType').setStyle("display","none");
			$('spanDocType').innerHTML = docInfo.docTypeLabel;
			$('spanDocType').setStyle("display","");
			docType.id = docInfo.docTypeId;
			docType.free = toBoolean(docInfo.docTypeFreeMetadata);
			newDoc = false;		
		}		
		
		var url = (extra && extra.url_aux) ? extra.url_aux : URL_REQUEST_AJAX;
		
		
		
		if (extra && !extra.avoidAjaxCall) {
			
			var useMonitorDocument = false;
			var documentMonitorId = 1;
			
			if (extra && extra.prefix != 'ABM') {
				if (toBoolean(GLOBAL_PARAM_ALLOW_MON_DOCUMENT)) {
					useMonitorDocument = true;
//					documentMonitorId = 1;
				}
				
				if (toBoolean(ENV_PARAM_ALLOW_MON_DOCUMENT)) {
					useMonitorDocument = true;
					documentMonitorId = ENV_PARAM_DOC_MON_ID;
				}
				
				if (!MODAL_FOR_ENVIRONMENT_FUNCT && (toBoolean(ENV_PARAM_ALLOW_MON_DOCUMENT) || toBoolean(GLOBAL_PARAM_ALLOW_MON_DOCUMENT))) {
					useMonitorDocument = true;
				} else if (MODAL_FOR_ENVIRONMENT_FUNCT) {
					useMonitorDocument = false;
				}
				
				if (extra && extra.prefix && (extra.prefix == 'E' || extra.prefix == 'P')) {
					if (extra.prefix == 'E' && (typeof BUS_ENT_PARAMS_FOR_DOC_MODAL != undefined && BUS_ENT_PARAMS_FOR_DOC_MODAL[5]) 
								&& (docId == null || docId == '' || docId == undefined) && (extra.langId == undefined || extra.langId == null)) {
						useMonitorDocument = true;
						documentMonitorId = BUS_ENT_PARAMS_FOR_DOC_MODAL[6];
					} else if (extra.prefix == 'P' && (typeof PRO_PARAMS_FOR_DOC_MODAL != undefined && PRO_PARAMS_FOR_DOC_MODAL[5]) 
								&& (docId == null || docId == '' || docId == undefined)) {
						useMonitorDocument = true;
						documentMonitorId = PRO_PARAMS_FOR_DOC_MODAL[6];
					} else {
						useMonitorDocument = false;
					}
				} else if (extra && toBoolean(extra.openedForForm)) {
					
					if (parseInt(extra.langId) > 0) useMonitorDocument = false;
					else if (parseInt(docId) > 0) useMonitorDocument = false;
					else if (!toBoolean(extra.docDocMonForbid)) {
						if (extra.cusMonDoc != '') {
							useMonitorDocument = true;
							documentMonitorId = extra.cusMonDoc; 
						} else if (toBoolean(extra.defMonDoc)) {
							useMonitorDocument = true;
							documentMonitorId = 1;
						} 
					} else {
						useMonitorDocument = false;
					}
				}
			}
			
			if (useMonitorDocument) {
				if (documentMonitorId == 1 || documentMonitorId==null) $('btnOpenMonDoc').getParent('tr').setStyle('display', '');
				else $('btnOpenCusMonDoc').getParent('tr').setStyle('display', '');
			} else {
				$('btnOpenMonDoc').getParent('tr').setStyle('display', 'none');
				$('btnOpenCusMonDoc').getParent('tr').setStyle('display', 'none');
			}
			
			new Request({
				method: 'post',
				url: CONTEXT + url + "?action="+action+"&isAjax=true&docId=" + docId + TAB_ID_REQUEST + "&prefix=" + extra.prefix + "&docTypeId=" + docType.id + "&newDoc=" + newDoc + strParamsDocTypePermitted,
				onComplete: function(resText, resXml) { modalProcessXml(resXml); },
				onSuccess: function() {initExistingDocumentChose(useMonitorDocument, documentMonitorId,  toBoolean(extra.defMonDoc) === true); }
			}).send(extra);
		}
//	}
	
	if (!(extra && extra.avoidDrop == true)) {
		if ($('mdlDropArea')) {
			Array.from($('mdlDropArea').getParent().getElementsByTagName('span')).each(function(child) {
				if (child.id !== 'mdlDropArea') child.destroy();
			});
			
			var moreInfo = null;
			if (extra && extra.prefix != null) var moreInfo = extra.prefix;
			else if (extra && extra.params){
				var formParams = extra.params.split('&');
				if (formParams && formParams.length > 0) {
					moreInfo = '';
					formParams.each(function(elem) {
						if (elem != '' && elem.length > 0) {
							var attr = elem.split('=');
							if (attr != null && attr.length > 0 && attr[0] != 'docId') {
								moreInfo += (moreInfo != '' ? '_' : '') + attr[1];
							}
						} 
					});
				}
			}
			
			moreInfo += '_Mdl';
			
			var parent = $('mdlDropArea').getParent();
			var elem = $('mdlDropArea').clone();
			elem.id = $('mdlDropArea').id + moreInfo;
			elem.setStyle('display', '');
			
			if (moreInfo == '') {
				$('mdlDropArea').destroy();
				elem.inject(parent)
			} else {
				elem.inject($('mdlDropArea'), 'after');
			}
			
			var url = extra && extra.url_aux ? extra.url_aux : URL_REQUEST_AJAX;
			
			if (extra && extra.prefix != null) initDroppedDocsFunctions(url.substring(1) + '?', moreInfo, 'mdlDropArea' + moreInfo, docId == null || docId == undefined || docId.length == 0, true, false, 'frmOut=false' + (docId != null && docId != undefined && parseInt(docId) > 0 ? '&docId=' + docId : ''), extra);
			else {
				if (extra && !extra.dontAllowDragAndDrop) {
					var fromForm = extra && toBoolean(extra.openedForForm);
					initDroppedDocsFunctions(url.substring(1) + '?', moreInfo, 'mdlDropArea' + moreInfo, false, false, false, extra.params + '&frmOut=false' + (fromForm ? '&fromFormElem=true' : ''), extra);
				} else {
					elem.setStyle('display', 'none');
				}
			} 
		}
	} 
	
	initTreeDocsFldsMdlPage();
	
	// acomodo el modal según los elementos visibles / ocultos
	
	var cantButtons = 1; // al menos esta el nuevo documento
	var isDropAreaAvailable = false;
	
	if ($('btnOpenMonDoc').getParent('tr').getStyle('display') != 'none') cantButtons++;
	if ($('btnOpenCusMonDoc').getParent('tr').getStyle('display') != 'none') cantButtons++;
	if ($('btnOpenDocFldMdl').getParent('tr').getStyle('display') != 'none') cantButtons++;
	if ($('mdlDropArea').getNext() && $('mdlDropArea').getNext().getStyle('display') != 'none') {
		cantButtons++;
		isDropAreaAvailable = true;
	}
	
	if (cantButtons == 2) {
		if (isDropAreaAvailable) {
			$('mdlDocumentAddNewDc').getChildren('span')[0].setStyles({
				'height': '25px',
				'line-height': '2',
				'width': '150px'
			});
			$('mdlDropArea').getNext().setStyle('height', '25px');
			$('mdlDropArea').getNext().setStyle('width', '150px');
			$('mdlDropArea').getNext().getParent('td').removeAttribute('rowspan');
		}
	} else if (cantButtons == 3) {
		if (isDropAreaAvailable) {
			var buttons = [];
			buttons.push($('mdlDocumentAddNewDc').getChildren('span')[0]);
			if ($('btnOpenMonDoc').getParent('tr').getStyle('display') != 'none') buttons.push($('btnOpenMonDoc').getChildren('span')[0]);
			if ($('btnOpenCusMonDoc').getParent('tr').getStyle('display') != 'none') buttons.push($('btnOpenCusMonDoc').getChildren('span')[0]);
			if ($('btnOpenDocFldMdl').getParent('tr').getStyle('display') != 'none') buttons.push($('btnOpenDocFldMdl').getChildren('span')[0]);
			
			for (var i = 0; i < buttons.length; i++) {
				buttons[i].setStyles({
					'height': '20px',
					'line-height': '2',
					'width': '150px'
				});
			}
			
			$('mdlDropArea').getParent('td').setAttribute('rowspan', '2');
		}
	}
	
	if (!isDropAreaAvailable) {
		$('mdlDocumentAddNewDc').getChildren('span')[0].setStyle('width', '315px');
		if ($('btnOpenMonDoc').getParent('tr').getStyle('display') != 'none')
			$('btnOpenMonDoc').getChildren('span')[0].setStyle('width', '315px');
		if ($('btnOpenCusMonDoc').getParent('tr').getStyle('display') != 'none') 
			$('btnOpenCusMonDoc').getChildren('span')[0].setStyle('width', '315px');
		if ($('btnOpenDocFldMdl').getParent('tr').getStyle('display') != 'none') 
			$('btnOpenDocFldMdl').getChildren('span')[0].setStyle('width', '315px');
	}
	
	$$('div.expandPermission').each(function(elem) {
//		elem.removeClass('expandPermission').addClass('collapsePermission');
		elem.fireEvent('click');
	});
	
	
	$$('div.expandMdlDocSection').each(function(elem) {
		if (extra.prefix == 'E' && typeof BUS_ENT_PARAMS_FOR_DOC_MODAL != undefined) {
			if (elem.getParent('div').id == 'permission' && !BUS_ENT_PARAMS_FOR_DOC_MODAL[2]) elem.fireEvent('click'); 
			if (elem.getParent('div').id == 'folders' && !BUS_ENT_PARAMS_FOR_DOC_MODAL[3]) elem.fireEvent('click');
			if (elem.getParent('div').id == 'metadata' && !BUS_ENT_PARAMS_FOR_DOC_MODAL[4]) elem.fireEvent('click');
		} else if (extra.prefix == 'P' && typeof PRO_PARAMS_FOR_DOC_MODAL != undefined) {
			if (elem.getParent('div').id == 'permission' && !PRO_PARAMS_FOR_DOC_MODAL[2]) elem.fireEvent('click'); 
			if (elem.getParent('div').id == 'folders' && !PRO_PARAMS_FOR_DOC_MODAL[3]) elem.fireEvent('click');
			if (elem.getParent('div').id == 'metadata' && !PRO_PARAMS_FOR_DOC_MODAL[4]) elem.fireEvent('click');
		} else if (extra.openedForForm) {
			if (elem.getParent('div').id == 'permission' && !extra.collapsePerm) elem.fireEvent('click'); 
			if (elem.getParent('div').id == 'folders' && !extra.collapseMeta) elem.fireEvent('click');
			if (elem.getParent('div').id == 'metadata' && !extra.collapseFldStrc) elem.fireEvent('click');
		}
	});
	
	$$('div.collapseMdlDocSection').each(function(elem) {
		if (extra.prefix == 'E' && typeof BUS_ENT_PARAMS_FOR_DOC_MODAL != undefined) {
			if (elem.getParent('div').id == 'permission' && BUS_ENT_PARAMS_FOR_DOC_MODAL[2]) elem.fireEvent('click'); 
			if (elem.getParent('div').id == 'folders' && BUS_ENT_PARAMS_FOR_DOC_MODAL[3]) elem.fireEvent('click');
			if (elem.getParent('div').id == 'metadata' && BUS_ENT_PARAMS_FOR_DOC_MODAL[4]) elem.fireEvent('click');
		} else if (extra.prefix == 'P' && typeof PRO_PARAMS_FOR_DOC_MODAL != undefined) {
			if (elem.getParent('div').id == 'permission' && PRO_PARAMS_FOR_DOC_MODAL[2]) elem.fireEvent('click'); 
			if (elem.getParent('div').id == 'folders' && PRO_PARAMS_FOR_DOC_MODAL[3]) elem.fireEvent('click');
			if (elem.getParent('div').id == 'metadata' && PRO_PARAMS_FOR_DOC_MODAL[4]) elem.fireEvent('click');
		} else if (extra.openedForForm) {
			if (elem.getParent('div').id == 'permission' && extra.collapsePerm) elem.fireEvent('click'); 
			if (elem.getParent('div').id == 'folders' && extra.collapseMeta) elem.fireEvent('click');
			if (elem.getParent('div').id == 'metadata' && extra.collapseFldStrc) elem.fireEvent('click');
		}
	});
	
	
}

function styleModalForDroppedBehaviour() {
	deleteAllDocumentsPreviews(false);
	
	var selIndex = $('cmbDocType').selectedIndex;
	
//	var frmModalDocumentUpload = $('frmModalDocumentUpload');
//	if(frmModalDocumentUpload)
//		frmModalDocumentUpload.reset();
	
	$('cmbDocType').selectedIndex = selIndex;
	
	disableFileSystemUpload();
	
	$('documentInfoContainer').style.display = 'initial';
	
}

function showDocumentInfo(docInfo, extra, hideMetadata, avoidDownload){
	table = $('tableMetadataInfo');
	addNewDoc = false;
	
	if(hideMetadata)
		$('metadataInfo').setStyle('display', 'none');
	else
		$('metadataInfo').setStyle('display', '');
	
	docType.id = docInfo.docTypeId;
	docType.free = toBoolean(docInfo.docTypeFreeMetadata);
	docType.avoidDownload = avoidDownload;
	
	var mdlDocumentContainer = $('mdlDocumentContainer');
	mdlDocumentContainer.addedPools = [];
	mdlDocumentContainer.addedUsers = [];
		
	$('mdlDocumentPoolContainterInfo').getElements("span.canRemove").each(function(ele) { ele.dispose(); });
	
	new Request({
		method: 'post',
		url: CONTEXT + URL_REQUEST_AJAX + "?action=getDocumentInfo&isAjax=true&docId=" + docInfo.docId + TAB_ID_REQUEST + "&prefix=" + extra.prefix,
		onComplete: function(resText, resXml) { 
			modalProcessXml(resXml); 
		
			//Se actualiza posición del modal
			var mdlDocumentInfo = $('mdlDocumentInfo');
			mdlDocumentInfo.position();
			mdlDocumentInfo.blockerModal.show();
			mdlDocumentInfo.setStyle('zIndex', SYS_PANELS.getNewZIndex());
		
		}
	}).send();
	
	$('mdlDocumentInfo').removeClass('hiddenModal');
}

/**
 * Esta funcion se ejecuta al presionar el boton lock/unlock luego de volver del servidor
 */
function lockDocument(){
	var ajaxCallXml = getLastFunctionAjaxCall();
	//docLockIconUnlocked
	//docLockIconLocked
	var xmlGenerals = ajaxCallXml.getElementsByTagName('general');
	if (xmlGenerals != null) {
		for (var i = 0; i < xmlGenerals.length; i++) {
			var xmlGeneral = xmlGenerals[i];
			var locked = xmlGeneral.getAttribute("locked");
			var docId = xmlGeneral.getAttribute("docId");
			var prefix = xmlGeneral.getAttribute("prefix");
			var usrLocking = xmlGeneral.getAttribute("userLocking");
			if(locked=='true' || usrLocking==CURRENT_USER_LOGIN){
				$('lck'+docId+prefix).removeClass('docLockIconUnlocked');
				$('lck'+docId+prefix).removeClass('docLockIconLockedOther');
				$('lck'+docId+prefix).parentElement.docInfo.docLock = true;
				$('lck'+docId+prefix).parentElement.docInfo.docUserLocking = usrLocking;
				$('lck'+docId+prefix).addClass('docLockIconLocked');
			} else if (locked=='false' || usrLocking=='') {
				$('lck'+docId+prefix).removeClass('docLockIconLocked');
				$('lck'+docId+prefix).removeClass('docLockIconLockedOther');
				$('lck'+docId+prefix).parentElement.docInfo.docLock = false;
				$('lck'+docId+prefix).parentElement.docInfo.docUserLocking = usrLocking;
				$('lck'+docId+prefix).addClass('docLockIconUnlocked');
			} else {
				$('lck'+docId+prefix).removeClass('docLockIconUnlocked');
				$('lck'+docId+prefix).removeClass('docLockIconLocked');
				$('lck'+docId+prefix).parentElement.docInfo.docLock = false;
				$('lck'+docId+prefix).parentElement.docInfo.docUserLocking = usrLocking;
				$('lck'+docId+prefix).addClass('docLockIconLockedOther');
				$('lck'+docId+prefix).set('title', locked);
			}
			
		}			
	}
	
}

/**
 * Esta funcion carga el modal de informacion adicional de un documento
 */
function populateDocInfo(){
	var ajaxCallXml = getLastFunctionAjaxCall();
	//var xmlGenerals = ajaxCallXml.getChildren(0).getChildren('general');
	var xmlGenerals = ajaxCallXml.childNodes[0].getElementsByTagName('general');
	if (xmlGenerals != null) {
		for (var i = 0; i < xmlGenerals.length; i++) {
			var xmlGeneral = xmlGenerals[i];
			var docId = xmlGeneral.getAttribute("docId");
			var downloadDocId = xmlGeneral.getAttribute("downloadDocId");
			var docName = xmlGeneral.getAttribute("docName");
			var docDesc = xmlGeneral.getAttribute("docDesc");
			var prefix = xmlGeneral.getAttribute("prefix");
			var docTypeLabel = xmlGeneral.getAttribute("docTypeLabel");
			var docAllPoolPerm = xmlGeneral.getAttribute("docAllPoolPerm");
			var docDownloadUrl = xmlGeneral.getAttribute("docDwnExternal");
			var docExpDate = xmlGeneral.getAttribute('docExpDate');
		 
			$('lblNom').innerHTML = docName;
			$('docDesc').innerHTML = docDesc;
			$('docTypeLabel').innerHTML = docTypeLabel;
			$('docExpDateInfo').innerHTML = docExpDate;
			
			switch (docAllPoolPerm){
				case 'M' 	:	$('selDocAllPoolPermInfo').selectedIndex = 0; break;
				case 'R'	:	$('selDocAllPoolPermInfo').selectedIndex = 1; break;
				default		: 	$('selDocAllPoolPermInfo').selectedIndex = 2; break;
			}
		}
	}
	
	var xmlPermisions = ajaxCallXml.getElementsByTagName('permissions'); //IE Friendly
	if (xmlPermisions != null && xmlPermisions.length) {
		
		xmlPermisions = xmlPermisions[0];
		
		var xmlUsers = xmlPermisions.getElementsByTagName('user');
		var xmlPools = xmlPermisions.getElementsByTagName('pool');
		
		if (xmlUsers != null) {
			for (var i = 0; i < xmlUsers.length; i++) {
				var xml = xmlUsers[i];
				var permType = xml.getAttribute("permType");
				var id = xml.getAttribute("id");
				var name = xml.getAttribute("name");
				
				docProcessModalReturn(id, name, permType=='M', false, true);
			}
		}
		
		if (xmlPools != null) {
			for (var i = 0; i < xmlPools.length; i++) {
				var xml = xmlPools[i];
				var permType = xml.getAttribute("permType");
				var id = xml.getAttribute("id");
				var name = xml.getAttribute("name");
				
				docProcessModalReturn(id, name, permType=='M', true, true);
			}
		}
	}
	
	
	//tblDocHistory
	//var xmlVersions = ajaxCallXml.getChildren(0).getChildren('versions')[0].getChildren('version')[0];
	var xmlVersions = ajaxCallXml.childNodes[0].getElementsByTagName('version');
	if (xmlVersions != null) {
		var object = $('tblDocHistory');
		var newBody = new Element("tbody");
		newBody.id = object.id;
		var parent = object.getParent();
		object.dispose();
		newBody.inject(parent);
		object = newBody;
		
		for (var i = 0; i < xmlVersions.length; i++) {
			var xmlVersion = xmlVersions[i];
			var verNumber = xmlVersion.getAttribute('verNumber');
			var verDate = xmlVersion.getAttribute('verDate');
			var verUser = xmlVersion.getAttribute('verUser');
			
			var tr = new Element('tr');
			var td1 = new Element('td');
			var td2 = new Element('td', {html: verUser});
			var td3 = new Element('td', {html: verDate});
			
			if (!docType.avoidDownload){
				var downloadIcon = new Element('a', {html: verNumber, 'href':CONTEXT + URL_REQUEST_AJAX + "?action=downloadDocument&docId=" +  encodeURIComponent(downloadDocId) + "&version="+ verNumber +"&prefix=" + prefix + TAB_ID_REQUEST});
				downloadIcon.inject(td1);
				if (i == xmlVersions.length - 1) {
					$('docDwn').innerHTML = docDownloadUrl;
				}
			} else {
				td1.innerHTML = verNumber;
			}
			
			td1.inject(tr);
			td2.inject(tr);
			td3.inject(tr);
			tr.inject(newBody);
		}
		
	}
	
	//var metadatas = ajaxCallXml.getElement("metadatas");
	var metadatas = ajaxCallXml.getElementsByTagName("metadatas");
	if(metadatas)
		metadatas = metadatas[0];
	processXmlMetadata(metadatas, true);

}

function initCurrentDocuments(retFunction, extra) {
	var mdlDocumentContainer = $('mdlDocumentContainer');
	mdlDocumentContainer.onModalConfirm = retFunction;
	mdlDocumentContainer.extraProperties = extra;
	
	var url = (extra && extra.url_aux) ? extra.url_aux : URL_REQUEST_AJAX;
	
	new Request({
		method: 'post',
		url: CONTEXT + url + "?action=ajaxLoadCurrent&isAjax=true" + TAB_ID_REQUEST + "&prefix=" + extra.prefix + "&allowMultiple=" + extra.allowMultiple + "&allowSign=" + extra.allowSign + "&allowLock=" + extra.allowLock + "&readOnly=" + extra.readOnly,
		onComplete: function(resText, resXml) { modalProcessXml(resXml);  }
	}).send();
}

function closeDocumentsModal(){
	var mdlDocumentContainer = $('mdlDocumentContainer');
	

	//reorganize modal as original
	
	$('mdlDocumentAddNewDc').getChildren('span')[0].removeAttribute('style');
	$('btnOpenMonDoc').getChildren('span')[0].removeAttribute('style');
	$('btnOpenCusMonDoc').getChildren('span')[0].removeAttribute('style');
	$('btnOpenDocFldMdl').getChildren('span')[0].removeAttribute('style');
	$('mdlDocumentAddNewDc').getParent('td').removeAttribute('rowspan');
	$('mdlDropArea').getParent('td').setAttribute('rowspan', '3');
	var dropArea = $('mdlDropArea').getNext();
	if (dropArea) {
		dropArea.removeAttribute('style');
		dropArea.getParent('td').setAttribute('rowspan', '3');
	}
	
	
//	$('permission').inject($('rightBodyTable'));
//	$('metadata').inject($$('div.rightSectDocMdl')[0]);
//	$('folders').inject($$('div.leftSectDocMdl')[0]);
//	$$('div.rightSectDocMdl')[0].setStyle('display', '');
	$('mdlDocumentContainer').removeClass('landingMdl');
	
	mdlDocumentContainer.addClass('hiddenModal');
	if(window.frameElement && $(window.frameElement).hasClass('modal-content')) {
		$(window.frameElement).fireEvent('unblock');
	}
	
	if ($('btnOpenMonDoc') || $('btnOpenCusMonDoc')) {
		leaveModalInFirstState();
		closeDocumentsChoseModal();
	}
	
	$('foldersStruct').getParent('div').getParent('div').setStyle('display', 'none');
	$('btnOpenDocFldMdl').getParent('tr').setStyle('display', 'none');
	
	deleteAllPerms();
	$('cmbDocType').disabled = false;
	
	if(DOCUMENTMODAL_HIDE_OVERFLOW) {
		$(document.body).setStyle('overflow', '');
	}
	
//	leaveModalInFirstState()
//	closeDocumentsChoseModal();
	
	
	//if portal Form Template have errors
	if ($('errorlist') && ($('errorlist').get('name') == "portalFormTemplate")){
		onClosePortalFormModal();
	}
	
	$('mdlDocumentContainer').droppedFiles = [];
	
	if ($('documentModalDocFile')) $('documentModalDocFile').getParent('tr').setStyle('display', '');
	if ($('mdlDropArea')) $('mdlDropArea').getParent('tr').setStyle('display', '');
	if ($('cmbDocType')) $('cmbDocType').getParent('td').erase('style');
	
	if(mdlDocumentContainer.onModalClose) mdlDocumentContainer.onModalClose();
	mdlDocumentContainer.blockerModal.hide();
}

function closeDocumentModalInfo(){
	var mdlDocumentInfo = $('mdlDocumentInfo');
	mdlDocumentInfo.addClass('hiddenModal');
	mdlDocumentInfo.blockerModal.hide();
}

function fncDocumentLoadAll() {
	var mdlDocumentContainer = $('mdlDocumentContainer');
	if (mdlDocumentContainer.onModalConfirm) {
		var ajaxCallXml = getLastFunctionAjaxCall();
		var xmlGenerals = ajaxCallXml.getElementsByTagName('general');
		
		if (xmlGenerals != null) {
			
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
				
				var prefix = xmlGeneral.getAttribute("prefix");
				if(prefix!=null){
//					mdlDocumentContainer.extraProperties.prefix = prefix;
					//cambiar tambien si tienen, el prefijo de: buttonAdd y addTo
					//Verificar que funciones bien el String.endsWidth
					//if(endsWith(mdlDocumentContainer.extraProperties.buttonAdd,"P") || endsWith(mdlDocumentContainer.extraProperties.buttonAdd,"E")){
					if(mdlDocumentContainer.extraProperties.buttonAdd.endsWith("P") || mdlDocumentContainer.extraProperties.buttonAdd.endsWith("E")){
						mdlDocumentContainer.extraProperties.buttonAdd = mdlDocumentContainer.extraProperties.buttonAdd.substr(0,mdlDocumentContainer.extraProperties.buttonAdd.length-1) + prefix;
						mdlDocumentContainer.extraProperties.addTo = mdlDocumentContainer.extraProperties.addTo.substr(0,mdlDocumentContainer.extraProperties.addTo.length-1) + prefix;
						mdlDocumentContainer.extraProperties.prefix = prefix;
					}
				}
				
				mdlDocumentContainer.onModalConfirm(
					mdlDocumentContainer.extraProperties,
					{
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
						docLangGroup: docLangGroup
					}
				);
			}
			
			if (xmlGenerals.length > 0){
				var tabDocs = $('tabDocs');
				if (tabDocs){
					tabDocs.addClass("docsMarked");
				}
			}
		}
	}
}

function fncDocumentLoadInformation() { 
	var ajaxCallXml = getLastFunctionAjaxCall();

	//var xmlGeneral = ajaxCallXml.getChildren('general')[0];
	var xmlGeneral = ajaxCallXml.childNodes[0]; //IE Friendly

	var createMode = xmlGeneral.getAttribute("createMode");
	var allowAllType = xmlGeneral.getAttribute("allowAllType");
	var isDocTypeDisabled = toBoolean(xmlGeneral.getAttribute("isDocTypeDisabled"));
	
	var selDocAllPoolPerm = $('selDocAllPoolPerm');
	
	for (var i = 0; i < selDocAllPoolPerm.options.length; i++) {
		if (createMode=="false" && selDocAllPoolPerm.options[i].value == allowAllType) {
			selDocAllPoolPerm.selectedIndex = i;
			break;
		}
	}

	//IE friendly
	var xmlMetadata;
	var xmlDocType;
	for (var i = 0; i < ajaxCallXml.childNodes.length; i++) {
		if(ajaxCallXml.childNodes[i].nodeName == 'metadatas')
			xmlMetadata = ajaxCallXml.childNodes[i];
		else if(ajaxCallXml.childNodes[i].nodeName == 'docTypes')
			xmlDocType = ajaxCallXml.childNodes[i];
	}
	processXmlMetadata(xmlMetadata,true);
	processXmlDocTypes(xmlDocType);
	
	
	if (isDocTypeDisabled){
		closeDocumentsModal();
		
		SYS_PANELS.newPanel();
		var panel = SYS_PANELS.getActive();
		panel.addClass("modalWarning");
		panel.content.innerHTML = MSG_NO_UP_DOC_TYPE_DIS;
		panel.footer.innerHTML = "";
		SYS_PANELS.addClose(panel);
		SYS_PANELS.refresh();		
	}
	
	$('mdlDocumentContainer').focus();
}

function fncDocumentProcessUpload() {
	var ajaxCallXml = getLastFunctionAjaxCall();
	

	var xmlGeneral = ajaxCallXml.childNodes[0]; //IE Friendly
	if(xmlGeneral){
		var docId = xmlGeneral.getAttribute("docId");
		var downloadDocId = xmlGeneral.getAttribute("downloadDocId");
		var docName = xmlGeneral.getAttribute("docName");
		var docSize = xmlGeneral.getAttribute("docSize");
		
		var docTypeId = xmlGeneral.getAttribute("docTypeId");
		var docTypeLabel = xmlGeneral.getAttribute("docTypeLabel");
		var docTypeFreeMetadata = toBoolean(xmlGeneral.getAttribute("docTypeFreeMetadata"));
		var docDescription = xmlGeneral.getAttribute("docDescription");
		
		var docLang = xmlGeneral.getAttribute("docLang");
		var docLangGroup = xmlGeneral.getAttribute("docLangGroup");
			
		var mdlDocumentContainer = $('mdlDocumentContainer');
		
		if (mdlDocumentContainer.onModalConfirm) {
			mdlDocumentContainer.onModalConfirm(
				mdlDocumentContainer.extraProperties,
				{
					docId: docId,
					downloadDocId: downloadDocId,
					docName: docName,
					docSize: docSize,
					docLock: false,
					docTypeId: docTypeId,
					docTypeLabel: docTypeLabel,
					docTypeFreeMetadata: docTypeFreeMetadata,
					docLang: docLang,
					docLangGroup: docLangGroup,
					docDescription: docDescription
//					allowSign: allowSign
				}
			);
		} else {
			
		}
		closeDocumentsModal();
	}
}

function processXmlMetadata(resXml,fromShow){
	
	destroyTableMetadata(false);
//	if (addNewDoc){
//		destroyTableMetadata(false);
//	} else {
//		destroyTableMetadata(false);
//	}	
	
	if (resXml){
		if (!fromShow && checkErrorsDoc(resXml)) return;
		
		if (!fromShow){
			var metadata = resXml.getElementsByTagName("metadatas");
				
			if (metadata != null && metadata.length > 0 && metadata.item(0) != null) {
				metadata = metadata.item(0).getElementsByTagName("metadata");
			} else {
				metadata = null;
			}
		} else {
			var metadata = resXml.getElementsByTagName("metadata");
		}
		
		var hasRequired = false;
		
		if (metadata != null){
			var trs = table.getElements("tr");
			var after = trs.length > 0 ? trs[0] : null;
		
			for (var i = metadata.length-1; i >= 0; i--){
				var xmlMetadata = metadata[i];
				
				var id = xmlMetadata.getAttribute("id");
				var name = xmlMetadata.getAttribute("name");
				var type = xmlMetadata.getAttribute("type");
				var required = "Y" == xmlMetadata.getAttribute("required");
				var title = xmlMetadata.getAttribute("title");
				var value = xmlMetadata.getAttribute("value");
				var free = "Y" == xmlMetadata.getAttribute("free");
				after = addMetadata(id,name,type,required,title,value,free,after);
				
				hasRequired = hasRequired || required;
			}
		}
		
		var _metadata = $('metadata');
		if(_metadata.get('data-hideMetadata') == 'true') {
			if(hasRequired) 
				_metadata.setStyle('display', '');
			else
				_metadata.setStyle('display', 'none');
		}
	}
	
	// check if selecting uploaded document and free metadata
	var showMetaButtons = (($('cmbDocType') && $('cmbDocType').options[$('cmbDocType').selectedIndex] 
								&& toBoolean($('cmbDocType').options[$('cmbDocType').selectedIndex].get("data-free"))) &&
							($('btnOpenMonDoc').isVisible() || $('btnOpenCusMonDoc').isVisible()));
	
	var abmHideButtns = $('documentModalDocDesc').disabled;
	$('buttonsMetadata').setStyle("display", ((docType.free && addNewDoc) || showMetaButtons) && !abmHideButtns ? "" : "none");
	
	fixTableMetadata();
	
	var mdlDocumentContainer = $('mdlDocumentContainer');
	mdlDocumentContainer.position();
	
	SYS_PANELS.closeLoading();
	
	if(Browser.ie8) {
		setTimeout(function() {
			mdlDocumentContainer.focus();
		}, 1000);
	} else {
		mdlDocumentContainer.focus();
	}
	
}

function addMetadata(id,name,type,required,title,value,free,objAfter){
	var tableMetadata = table;
	
	var tr = new Element("tr",{'class': free ? 'selectableTR' : ''});
	if (objAfter){
		tr.inject(objAfter,"before");
	} else {
		tr.inject(table);
	}
	
	tr.setAttribute("data-rowId",id);
	tr.setAttribute("data-rowName",name);
	tr.setAttribute("data-rowFree",free);
	tr.setAttribute("data-rowRequired",required);
	tr.setAttribute("data-rowType",type);
	tr.setAttribute("data-rowTitle",title);
	
	tr.getRowId = function () { return this.getAttribute("data-rowId"); }
	tr.getRowName = function () { return this.getAttribute("data-rowName"); }
	tr.getRowFree = function () { return toBoolean(this.getAttribute("data-rowFree")); }
	tr.getRowRequired = function () { return toBoolean(this.getAttribute("data-rowRequired")); }
	tr.getRowType = function () { return this.getAttribute("data-rowType"); }
	tr.getRowTitle = function () { return this.getAttribute("data-rowTitle"); }
	tr.getRowInputTitle = function () { return this.getRowFree() ? this.getElements("td")[0].getElement("div").getElement("input") : null; }
	tr.getRowValue = function () { return this.getElements("td")[1].getElement("div").getElement("input").value; }
	tr.getRowInput = function () { return this.getElements("td")[1].getElement("div").getElement("input"); }
	
	required = required && addNewDoc;
	free = free && addNewDoc;
	
	if (free) tr.addEvent("click", function(evt) { this.toggleClass("selectedTR"); evt.stopPropagation(); });				
	
	var td1 = new Element("td", {styles:{'width':'49%'}}).inject(tr);
	td1.setAttribute('headers', 'tableMetadataCol1');
	td1.setAttribute("title", title);
	var div1 = new Element('div', {styles: {width: '100%', overflow: 'hidden', 'white-space': 'pre', 'margin': '4px 0px', 'text-align': 'center'}}).inject(td1);
	if (!free){ //no free
		var span1 = new Element('span').inject(div1);
		var label = new Element('label',{html: (required ? '* ' : '') + title }).inject(span1);
		label.setAttribute("for", tr.getRowName() + "_" + tr.getRowId());
		if (div1.scrollWidth > div1.offsetWidth) {
			td1.title = title;
			td1.addClass("titiled");
		}
	} else { //free
		new Element("span",{html: '*&nbsp;',styles:{'float':'left'}}).inject(div1);
		var input1 = new Element('input',{'type':'text','value':title, 'class': "validate['required']", styles: {width: '95%'}, 'disabled': $('documentModalDocDesc').disabled === true}).inject(div1);
		input1.addEvent("change",function(e){ this.getParent("tr").setAttribute("rowTitle",this.value); });
		$('frmModalDocumentUpload').formChecker.register(input1);
	}

	var td2 = new Element("td", { styles:{'width':'49%'}}).inject(tr);
	td2.setAttribute("title", value);
	td2.setAttribute('headers', 'tableMetadataCol2');
	var div2 = new Element('div', {styles: {width: '100%', overflow: 'hidden', 'white-space': 'pre', 'margin': '4px 0px'}}).inject(td2);
	
	if (addNewDoc){
		var input2;
		if (type == "D"){ //Date
			input2 = new Element('input',{'type':'text','value':value,'class':'datePickerCustom filterInputDate','format':'d/m/Y', styles: {width: '83%'}, 'disabled': $('documentModalDocDesc').disabled === true}).inject(div2);
			input2.setAttribute("title", value);
			setAdmDatePicker(input2);
		} else if (type == "N") { //Numeric
			input2 = new Element('input',{'type':'text','value':value, 'class': '', styles: {width: '90%'}, 'disabled': $('documentModalDocDesc').disabled === true}).inject(div2);
			input2.addEvent("keypress",function(e){
				if (e.key < '0' || e.key > '9'){
					if (e.key != "delete" && e.key != "tab" && e.key != "backspace" && e.key != "left" && e.key != "right"){
						e.stop();
					}
				} 
			});
		} else { //String
			input2 = new Element('input',{'type':'text','value':value, 'class': '', styles: {width: '90%'}, 'disabled': $('documentModalDocDesc').disabled === true}).inject(div2);
		}	
		input2.setAttribute("id",tr.getRowName() + "_" + tr.getRowId());
		input2.setAttribute("title", value);
		if (required){
			new Element("span",{html: '*&nbsp;',styles:{'float':'left'}}).inject(input2,"before");
			input2.setStyle("padding-left","10px");
			input2.addClass("validate['required']");
			$('frmModalDocumentUpload').formChecker.register(input2);
		}
	} else {
		var span2 = new Element('span',{html: value }).inject(div2);
		if (div2.scrollWidth > div2.offsetWidth) {
			td2.title = value;
			td2.addClass("titiled");
		}
	}
	
//	tr.getRowId = function () { return this.getAttribute("data-rowId"); }
//	tr.getRowName = function () { return this.getAttribute("data-rowName"); }
//	tr.getRowFree = function () { return toBoolean(this.getAttribute("data-rowFree")); }
//	tr.getRowRequired = function () { return toBoolean(this.getAttribute("data-rowRequired")); }
//	tr.getRowType = function () { return this.getAttribute("data-rowType"); }
//	tr.getRowTitle = function () { return this.getAttribute("data-rowTitle"); }
//	tr.getRowInputTitle = function () { return this.getRowFree() ? this.getElements("td")[0].getElement("div").getElement("input") : null; }
//	tr.getRowValue = function () { return this.getElements("td")[1].getElement("div").getElement("input").value; }
//	tr.getRowInput = function () { return this.getElements("td")[1].getElement("div").getElement("input"); }
	
	return tr;
}

function destroyTableMetadata(onlyNoFree){
	if (table) {
		table.getElements("tr").each(function (tr){
			if (onlyNoFree && tr.getRowFree && tr.getRowFree()) {
				return;
			}
			deleteRowMetadata(tr);		
		});
	}
}

function deleteRowMetadata(row){
	if (row){
		if (row.getRowRequired && row.getRowRequired()){
			var input = row.getRowInput();
			if (input) $('frmModalDocumentUpload').formChecker.dispose(input);
		}
		if (row.getRowFree && row.getRowFree()){
			var input = row.getRowInputTitle();
			if (input) $('frmModalDocumentUpload').formChecker.dispose(input);
		}
		row.destroy();
	}
}

function fixTableMetadata(){
	var tableMetadata = table;
	var trs = tableMetadata.getElements("tr");
	
	for (var i = 0; i < trs.length; i++){
		var tr = trs[i];
		if (i % 2 == 0) tr.addClass("trOdd"); else tr.removeClass("trOdd");
		if (i == trs.length-1) tr.addClass("lastTr"); else tr.removeClass("lastTr");		
	}
	
	addScrollTable(tableMetadata);
}

function checkErrorsDoc(resXml){
	if (resXml == null) return false;
	//verifico si hubo errores
	var data = resXml.getElementsByTagName("data");
	if (data != null && data.length > 0 && data.item(0) != null) {
		//hubo error --> proceso errores
		modalProcessXml(resXml);
		return true;
	}
	return false;
}


function processXmlDocTypes(resXml){
	if (!addNewDoc) return;
	
	var cmbDocType = $('cmbDocType');
	cmbDocType.innerHTML = "";
		
	if (checkErrorsDoc(resXml)) return;
	
	var docTypes = resXml.getElementsByTagName("docType");
		
	for (var i = 0; i < docTypes.length; i++){
		var xmlDocType = docTypes[i];
		
		var option = new Element('option');
		option.set("text", xmlDocType.getAttribute("title"));
		option.set("value", xmlDocType.getAttribute("id"));
		option.set("data-free", toBoolean(xmlDocType.getAttribute("free")));
		option.set("data-extensions", xmlDocType.getAttribute("docExts"));
		option.set("data-maxvalueallowed", xmlDocType.getAttribute('maxSize'));
//		cmbDocType.options[i] = option;
		option.inject(cmbDocType);
		if (toBoolean(xmlDocType.getAttribute("selected"))){
			cmbDocType.selectedIndex = i;
			cmbDocType.value = xmlDocType.getAttribute("id");
			var spanDocType = $('spanDocType');
			if(spanDocType) spanDocType.set('html', xmlDocType.getAttribute("title"))
		}
	}
	
	if (docTypes.length<=1){
		$('cmbDocType').setStyle("display","none");
		$('spanDocType').setStyle("display","");	
	}
	
	if (newDoc){
		docType.id = cmbDocType.value;
		docType.free = toBoolean(cmbDocType.options[cmbDocType.selectedIndex].get("data-free"));
		cmbDocType.fireEvent("change");
	} else {
		setTimeout(function() {
			fixTableMetadata();
			$('mdlDocumentContainer').position();
		}, 100);
	}
	
	/*
	 * Antes del if siguiente tengo que decidir sobre:
	 * 1. permisos para todos y el usuario actual (si el parametro global esta para todos != permitir 
	 * 		y no hay configuracion para el usuario actual, hay problema)
	 * 2. metadatos requeridos (en caso que se muestren los metadatos)
	 * 
	 * Ver si hay algun caso mas
	 * */
	
	/******************************/
//	if(hideMetadata)
//		$('metadata').setStyle('display', 'none').set('data-hideMetadata', 'true');
//	else
//		$('metadata').setStyle('display', '').set('data-hideMetadata', 'false');
	var requiredMetadata = false;
	var documentDropped = false;
	var correctPermission = true;
	
	/* check required metadata */
	if (!toBoolean($('metadata').getAttribute('data-hideMetadata'))) {
		var metaNodes = $('tableMetadata').childNodes;
		for (var i = 0; i < metaNodes.length; i++) {
			if (metaNodes[i].tagName && metaNodes[i].tagName.toLowerCase() == 'tr' && toBoolean(metaNodes[i].getAttribute('data-rowrequired'))) {
				requiredMetadata = true;
				break;
			}
		}
	}
	
	/* check if element was dropped */
	if ($('docsNamesContainer')) {
		var docNodes = $('docsNamesContainer').childNodes;
		for (var i = 0; i < docNodes.length; i++) {
			if (docNodes[i].tagName && docNodes[i].tagName.toLowerCase() == 'span') {
				documentDropped = true;
				break;
			}
		}
	}
	
	/* check if permissions are correct */
	if ($('mdlDocumentPoolContainer')) {
		correctPermission = $('selDocAllPoolPerm').value == 'M' || ($('selDocAllPoolPerm').value != 'M' && !DOCUMENT_OWNER_PRIVILEGES); 
	}
	/******************************/
	
	
	var mdlDocumentContainer = $('mdlDocumentContainer');
	if (requiredMetadata 
			|| !documentDropped
//			|| (mdlDocumentContainer.extraProperties && !mdlDocumentContainer.extraProperties.dontShowModalOnDrop && )
			|| (mdlDocumentContainer.extraProperties && (mdlDocumentContainer.extraProperties.dontShowModalOnDrop == undefined))
			|| (mdlDocumentContainer.extraProperties && !mdlDocumentContainer.extraProperties.dontShowModalOnDrop && documentDropped && !correctPermission)
			|| (mdlDocumentContainer.extraProperties && !mdlDocumentContainer.extraProperties.dontShowModalOnDrop)
		){
			
		mdlDocumentContainer.position();
		mdlDocumentContainer.blockerModal.show();
		if(window.frameElement && $(window.frameElement).hasClass('modal-content')) {
			$(window.frameElement).fireEvent('block');
		}
		mdlDocumentContainer.removeClass('hiddenModal');
	} else {
		
		if(DOCUMENT_EVERYONE_PERMISSION=="false") {
			$('selDocAllPoolPerm').selectedIndex = 2;
			docProcessModalReturn(CURRENT_USER_LOGIN, CURRENT_USER_LOGIN, true, false);
		} else {
			$('selDocAllPoolPerm').selectedIndex = 0;
		}
		
		if(DOCUMENT_OWNER_PRIVILEGES=="true"){
			docProcessModalReturn(CURRENT_USER_LOGIN, CURRENT_USER_LOGIN, true, false);
		}
		
		var params = processMdlFrm(); 
		var elemType = mdlDocumentContainer.extraProperties;
		
		var droppedDocumentNames = '';
		if ($('mdlDocumentContainer').droppedFiles.length > 0) {
			for (i = 0; i < $('mdlDocumentContainer').droppedFiles.length; i++) {
				droppedDocumentNames += '&dropped=' + encodeURIComponent($('mdlDocumentContainer').droppedFiles[i].name);
			}
		}
		
		var request = new Request({
			method: 'post',
			url: CONTEXT + mdlDocumentContainer.extraProperties.url_aux + '?action=confirmDropModal&elemType=' + elemType.prefix + mdlDocumentContainer.extraProperties.params + "&fromForm=true" + TAB_ID_REQUEST,
			onRequest: function() {  },
			onComplete: function(resText, resXml) { modalProcessXml(resXml);  }
		}).send(params + droppedDocumentNames);
	}
}

function validFreeMetadataTitles(){
	var trs = $('tableMetadata').getElements("tr");
	var ok = true;
	var arrayTitles = new Array();
	
	for (var i = 0; i < trs.length && ok; i++){
		var tr = trs[i];
		if (tr.getRowFree()){
			var title = tr.getRowInputTitle().value.toUpperCase();
			ok = !arrayContain(arrayTitles, title);
			arrayTitles[arrayTitles.length] = title;
		} else {
			var title = tr.getRowTitle().toUpperCase();
			ok = !arrayContain(arrayTitles, title);
			arrayTitles[arrayTitles.length] = title;
		}
	}
	
	if (!ok){
		showMessage(MSG_METADATA_TITLE_UNIQUE, GNR_TIT_WARNING, 'modalWarning');		
	}
	
	return ok;
}

function arrayContain(array,element){
	var contain = false;
	if (array != null && array.length > 0){
		var i = 0;
		while (i < array.length && !contain){
			contain = (array[i] == element);
			i++;
		}
	}
	return contain;	
}

function fncDocumentShowMsgNoDocTypes(){
	showMessage(MSG_NO_EXI_DOC_TYPE_ENA_AND_PER, GNR_TIT_WARNING, 'modalWarning');	
}

/**** APIA 3.1.0.8 DOCUMENTS CHANGES ****/

function addDocumentPreview(dataType, fullName, docId, docSize, usrCanModify, action) {
	var span = new Element('span', {
		'class':'option canRemove',
		'docSize': docSize,
		'docId': docId,
		'data-type': dataType,
		'elem-type': action == 'drop' ? 'dp' : 'up',
		styles:{'vertical-align':'middle', 'width': '93%', }
		
	});
	
	var div = new Element('div').inject(span);
	new Element('div', {'class':'file-icon file-icon-sm', 'data-type': dataType}).inject(div);
	var choppedName = fullName.length > 54 ? fullName.substring(0, 54) + '...' : fullName;
	new Element('span', {html: '&nbsp;' + choppedName, title: fullName}).inject(div);

	new Element('div.optionRemove', {tabIndex: ''}).addEvent('click', function(evt) {
		var docElem = this.getParent().getParent();
		docElem.destroy();
		$('mdlDocumentContainer').focus();
		if (action == 'drop') {
			documentDeleted(fullName);
			var moreDocs = $('docsNamesContainer').getElementsByClassName('option canRemove');
			if (!moreDocs || moreDocs.length == 0) {
				var extra = $('mdlDocumentContainer').extraProperties;
				leaveModalInFirstState();
				$('cmbDocType').disabled = false;
				$('cmbDocType').fireEvent('change');
				
			}
		} else if (action == 'upload') {
			var selIndex = $('cmbDocType').selectedIndex;
			
			var frmModalDocumentUpload = $('frmModalDocumentUpload');
			var inputs = frmModalDocumentUpload.getElementsByTagName('INPUT');
			for(i=0; i<inputs.lenght;i++){
			    if (inputs[i].id!='documentModalDocFile'){
			    	inputs[i].value="";
			    }
			}
			
			$('cmbDocType').selectedIndex = selIndex;
		
			leaveModalInFirstState();
			$('cmbDocType').disabled = false;
			$('cmbDocType').fireEvent('change');
		}
		
	}).addEvent('keypress', Generic.enterKeyToClickListener).inject(div);
	
	span.inject($('docsNamesContainer'));
	if (action === 'drop' && usrCanModify) $('mdlDocumentContainer').filesToDelete.push(docId);
	
	$('mdlDocumentContainer').position();
}

function documentDeleted(docName) {
	var validDocuments = [];
	if (Object.keys($('mdlDocumentContainer').droppedFiles).length != 0) {
		for (var i = 0; i < $('mdlDocumentContainer').droppedFiles.length; i++) {
			if ($('mdlDocumentContainer').droppedFiles[i].name != docName) {
				validDocuments.push($('mdlDocumentContainer').droppedFiles[i]);
			}
		}
		
		$('mdlDocumentContainer').droppedFiles = validDocuments;
	}
}

function removeDroppedDocFromCollection(document) {
	var auxArrayDroppedFiles = [];
	if ($('mdlDocumentContainer').isVisible() && $('mdlDocumentContainer').droppedFiles != null && $('mdlDocumentContainer').droppedFiles.length > 0) {
		for (var i = 0; i < $('mdlDocumentContainer').droppedFiles.length; i++) {
			var file = $('mdlDocumentContainer').droppedFiles[0]; 
			if (file.name != document) auxArrayDroppedFiles.push(file);
		}
		
		$('mdlDocumentContainer').droppedFiles = auxArrayDroppedFiles; 
	}
}

function cnfirmMonDocsRet(elems, boolean) {
	deleteAllDocumentsPreviews(false);
	showDocumentsPreviews();
	new Request({
		method: 'post',
		async: false,
		url: CONTEXT + URL_REQUEST_AJAX + "?action=getDocumentInfo" + "&isAjax=true&docReuse=true&newElem=true" + TAB_ID_REQUEST,
		onComplete: function(resText, resXml) {
			showDocumentInfoInModal(resXml, null);
		}
	}).send('docId=' + (boolean === true ? elems : elems[0].getRowId()));
};

function prepareForMonDocToShow() {
	deleteAllDocumentsPreviews(false);
	
//	var frmModalDocumentUpload = $('frmModalDocumentUpload');
//	if(frmModalDocumentUpload)
//		frmModalDocumentUpload.reset();
	
}

function fncOnChngCmb() {
	docType = {'id': $('cmbDocType').value, 'free': /*$('cmbDocType').options[$('cmbDocType').selectedIndex].hasAttribute('data-free')*/false};
	if ($('docsNamesContainer') && $('docsNamesContainer').isVisible()) {
		var mdlDoc = $('docsNamesContainer').getElementsByClassName('option canRemove')[0];
		var docType = mdlDoc.getAttribute('data-type');
		if (docType.startsWith('.')) {
			docType = docType.replace('.', '');
		}

		var docSize = mdlDoc.getAttribute('docsize');
		var cmbDocType = $('cmbDocType').childNodes[$('cmbDocType').selectedIndex].getAttribute('extensions');
		var cmbDocSize = $('cmbDocType').childNodes[$('cmbDocType').selectedIndex].getAttribute('maxsizeallowed');
		if ($('documentModalDocDesc').disabled === true || 
				(cmbDocType !== null && cmbDocType.length > 0 &&
						(!cmbDocType.contains(docType) || cmbDocType.contains(docType) && parseInt(docSize) > parseInt(cmbDocSize)))) {
			leaveModalInFirstState();
			$('cmbDocType').fireEvent('change');
		}
	}
}

function initExistingDocumentChose(allowSelectFiles, cusMonDocId, defaultDocMon) {
	if (allowSelectFiles) {
		// common modifications to current document's modal
		
		var tabId = TAB_ID_REQUEST;
		if (typeof NEW_TAB_ID !== 'undefined' && NEW_TAB_ID !== null) {
			tabId = NEW_TOKEN_ID + '&tabId=' + NEW_TAB_ID;
		}
		
		var monDocIdToUse = cusMonDocId > 0 ? cusMonDocId :  (cusMonDocId == null || defaultDocMon === true ? 1 : '');
		if (monDocIdToUse != '' && parseInt(monDocIdToUse) > 0) {
			var btnMonDoc = parseInt(monDocIdToUse) > 1 ? $('btnOpenCusMonDoc') : $('btnOpenMonDoc'); 
			btnMonDoc.getParent().getParent().setStyle('display', '');
			btnMonDoc.addClass('selDocument');
			
			btnMonDoc.removeEvents('click');
			btnMonDoc.addEvent('click', function(evt) {
				var parameters = '';
				parameters += '&monDocId=' + monDocIdToUse;	
				parameters += '&forCusDocMonMdl=true';
				parameters += '&docTypeIdSel=' + $('cmbDocType').value;
				for (var i = 0; i < $('cmbDocType').options.length; i++) {
					parameters += '&docTypeId=' + $('cmbDocType').options[i].value;
				}
				var modal = ModalController.openWinModal(CONTEXT + '/apia.execution.CustMonDocumentAction.run?action=init&txtDocTypeIndxSel=' + ($('cmbDocType').selectedIndex + 1) + parameters + tabId, 700, 462, null, null, true, false, false, null,
						function(evt) {$('mdlDocumentContainer').addClass('hiddenModal')}, 
						function(evt) {$('mdlDocumentContainer').removeClass('hiddenModal')});
				modal.addEvent('confirm', function(sel_mdl_index) {
					cnfirmMonDocsRet(sel_mdl_index, true);
					$('mdlDocumentContainer').droppedFiles = [];
					disableFileSystemUpload();
				});
				modal.addEvent('close', function() {
				});
			});
		}
	}
}

function endExitingDocumentsChose() {
	var btnMonDoc = $('btnOpenMonDoc');
	if (btnMonDoc) {
		btnMonDoc.removeEvents('click');
		btnMonDoc.getParent().getParent().setStyle('display', 'none');
	}

	var btnCusDoc = $('btnOpenCusMonDoc');
	if (btnCusDoc) {
		btnCusDoc.removeEvents('click');
		btnCusDoc.getParent().getParent().setStyle('display', 'none');
	}
}

function leaveModalInFirstState() {
	//properties
	$('mdlDocumentContainer').extraProperties.action = 'ajaxUploadStart';
	
	// document chose
	$('documentModalDocFile').disabled = false;
	$('documentModalDocFile').addClass("validate['required']");
	$('frmModalDocumentUpload').formChecker.register($('documentModalDocFile'));
	$('documentModalDocDesc').value = '';
	deleteAllDocumentsPreviews(false);
	hideDocumentsPreviews();
	deleteAllPerms();
	
	Array.from($('tableMetadata').getElementsByClassName('option')).each(function(elem) {
		elem.destroy();
	});
	
	addUsrBttnEvent();
	addPoolBtnEvent();
	$('documentModalDocDesc').disabled = false;
	$('selDocAllPoolPerm').disabled = false;
	if ($('docExpDate')) $('docExpDate').getNext().value = '';
	if ($$('li.folder.selected').length > 0) {
		$$('li.folder.selected')[0].getChildren('span.folderText.selected').removeClass('selected');
		if ($$('li.folder.selected')[0].hasClass('hasRemover'))$$('li.folder.selected')[0].getElements('span.optionRemove')[0].setStyle('display', 'none');
		$$('li.folder.selected')[0].removeClass('selected');
		collapseAll();
	}
	
	$$('div.expandPermission').each(function(elem) {
		elem.removeClass('expandPermission').addClass('collapsePermission');
		elem.fireEvent('click');
	}) ;
	
	//restore abm buttons to upload files
	var extra = $('mdlDocumentContainer').extraProperties;
	if (extra && extra.prefix == 'ABM') {
		$('documentModalDocFile').getParent('tr').setStyle('display', '');
		$('mdlDropArea').getParent('tr').setStyle('display', '');
		$('cmbDocType').getParent('td').setStyle('width', '100%');
	}
	
	destroyTableMetadata(false);
	$('mdlDocumentContainer').focus();
	
	enableFileSystemUpload();
}

function closeDocumentsChoseModal() {
	if ($('btnOpenMonDoc')) {
		$('btnOpenMonDoc').removeEvents('click');
		$('btnOpenMonDoc').getParent('tr').setStyle('display', 'none');
	}
	
	if ($('btnOpenCusMonDoc')) {
		$('btnOpenCusMonDoc').removeEvents('click');
		$('btnOpenCusMonDoc').getParent('tr').setStyle('display', 'none');
	}
}

function leaveOnlyCurrentUser() {
	var perms = $('scrollOptions').getElementsByClassName('option canRemove');
	if (perms != null && perms.length > 0) {
		Array.from(perms).each(function(elem) {
			elem.getElementsByClassName('optionRemove')[0].fireEvent('click');
		});
	}
}

function addUsrBttnEvent() {
	var mdlDocumentAddUser = $('mdlDocumentAddUser');
	if (mdlDocumentAddUser) {
		mdlDocumentAddUser.removeEvents('click');
		mdlDocumentAddUser.addEvent("click", function(e) {
			if(e) e.stop();
			
			USERMODAL_GLOBAL_AND_ENV = true;
			
			$('mdlDocumentContainer').addClass('hiddenModal');
			showUsersModal(docProcessUsersModalReturn, docProcessPoolsUsersModalClose);
		});
		mdlDocumentAddUser.addEvent('keypress', Generic.enterKeyToClickListener);
	}
}

function addPoolBtnEvent() {
	var mdlDocumentAddPool = $('mdlDocumentAddPool');
	if (mdlDocumentAddPool) {
		mdlDocumentAddPool.removeEvents('click');
		mdlDocumentAddPool.addEvent("click", function(e) {
			if(e) e.stop();
			$('mdlDocumentContainer').addClass('hiddenModal');
			showPoolsModal(docProcessPoolsModalReturn, docProcessPoolsUsersModalClose);
		});
		mdlDocumentAddPool.addEvent('keypress', Generic.enterKeyToClickListener);
	}
}

function showDocumentInfoInModal(resXml, forceEdit) {
	$('documentInfoContainer').setStyle('display', 'initial');
//	$('documentInfoContainer').setStyle('height', '42px');
	
	var canModify = toBoolean(resXml.getElementsByTagName('currentUsrPems')[0].getAttribute('usrCanModify'));
	
	leaveOnlyCurrentUser();
	var docName = resXml.getElementsByTagName('general')[0].getAttribute('docName');
//	var docExtension = "";
//	var docTypeExtensions = $('cmbDocType').option($('cmbDocType').selectedIndex).getAttribute('data-extensions');
//	if (docName != null && docName != '') docExtension = docName.substring(docName.lastIndexOf('.') + 1);
//	if (docExtension == '') return 'E';
//	if (docTypeExtensions != '' && !docTypeExtensions.contains(docExtension)) return 'N';
	
	var docId = resXml.getElementsByTagName('general')[0].getAttribute('docId');
	var docSize = resXml.getElementsByTagName('general')[0].getAttribute('docSize');
	var docDate = resXml.getElementsByTagName('general')[0].getAttribute('docExpDate');
	
	selDocAllPoolPerm.value = resXml.getElementsByTagName('general')[0].getAttribute('docAllPoolPerm');
	
	addDocumentPreview(docName.substring(docName.lastIndexOf('.') + 1), docName, docId, docSize, canModify, 'upload');
	if (docDate) {
		$('docExpDate').value = docDate;
		$('docExpDate').getNext().value = docDate;
	}
	
	$('mdlDocumentContainer').extraProperties.docId = encodeURIComponent(docId);
	
	var currentUserPerms = null;
	if (resXml.getElementsByTagName('permissions') && resXml.getElementsByTagName('permissions').length > 0) {
		Array.from(resXml.getElementsByTagName('permissions')[0].childNodes).each(function(elem) {
			docProcessModalReturn(elem.getAttribute('id'), elem.getAttribute('name'), 
					elem.getAttribute('permType') === 'M', elem.tagName === 'pool');
			if (elem.getAttribute('id') === CURRENT_USR_ID) {
				currentUserPerms = elem.getAttribute('permType'); 
			}
		});
	}
	
	// modify modal fields
	$('documentModalDocDesc').value = resXml.getElementsByTagName('general')[0].getAttribute('docDesc');
	$('cmbDocType').value = resXml.getElementsByTagName('general')[0].getAttribute('docTypeId');
//	$('spanDocType').innerHTML = $('cmbDocType').options[$('cmbDocType').selectedIndex].innerHTML;
//	$('spanDocType').setStyle('display', '');
//	$('cmbDocType').setStyle('display', 'none');
	
//	if ($('mdlDocumentContainer').extraProperties) $('mdlDocumentContainer').extraProperties.action = 'confirmExistingDocuments';
	
	
	var freeMeta = false;
	if ($('cmbDocType').options[$('cmbDocType').selectedIndex]) freeMeta = toBoolean($('cmbDocType').options[$('cmbDocType').selectedIndex].getAttribute('data-free'));
	else if ($('cmbDocType').options.length > 0) freeMeta = toBoolean($('cmbDocType').childNodes[0].getAttribute('data-free'));
	
	docType = {'id': $('cmbDocType').value, 'free': freeMeta};
	$('cmbDocType').removeEvents('change');
	registerCmbDocTypeEvent(false, docType, true);
//	$('mdlDocumentContainer').extraProperties.restoreDoc = 'false';
//	$('mdlDocumentContainer').extraProperties.newElem = 'true';
	
	// aca le agrego un valor al modal
//	$('mdlDocumentContainer').extraProperties.reuseDocAdded = 'true';
	$('cmbDocType').fireEvent('change');
	
	if (resXml.getElementsByTagName('general')[0].getAttribute('docFolder')) {
		if ($('folders').isVisible()) {
			var liElem = $$('li#' + resXml.getElementsByTagName('general')[0].getAttribute('docFolder') + '_mdl.folder');
			if (liElem) {
				focusOnFolder(liElem[0]);
				liElem[0].scrollIntoView();
			}
		}
	}
	
	if ((forceEdit === null && forceEdit !== 'ABM') && !canModify) {
		$('documentModalDocDesc').disabled = true;
		$('selDocAllPoolPerm').disabled = true;
		var perms = $('scrollOptions').getElementsByClassName('option canRemove');
		if (perms != null && perms.length > 0) {
			Array.from(perms).each(function(elem) {
				elem.querySelectorAll('input[type=checkbox]')[0].disabled = true;
				elem.getElementsByClassName('optionRemove')[0].setStyle('display', 'none');
			});
		}
		
		$('mdlDocumentAddPool').removeEvents('click');
		$('mdlDocumentAddUser').removeEvents('click');
	}
	
	$('cmbDocType').disabled = true;
	var docs = $('docsNamesContainer').getElementsByClassName('option canRemove');
	

	if(USERMODAL_HIDE_OVERFLOW) {
		$(document.body).setStyle('overflow', '');
	}
	
	
	
	$('mdlDocumentContainer').extraProperties.docId = encodeURIComponent(docId);
	if ($('mdlDocumentContainer').extraProperties) $('mdlDocumentContainer').extraProperties.action = 'confirmExistingDocuments';
	$('mdlDocumentContainer').extraProperties.reuseDocAdded = 'true';
	$('mdlDocumentContainer').extraProperties.restoreDoc = 'false';
	$('mdlDocumentContainer').extraProperties.newElem = 'true';
	
	
	
	$('mdlDocumentContainer').position();
}

function processMdlFrm() {
	// selected cmb value
	var selectedCmb = '&cmbDocType=' + $('cmbDocType').value;
	var description = '&docDesc=' + $('documentModalDocDesc').value;
	var selectedCmbPerms = '&docAllowAllType=' + $('selDocAllPoolPerm').value;
	var tmpDocUsrPerm = '';
	var tmpDocGroPerm = '';
	var tmpDocsIds = '';
	var docMdlPermission = $('scrollOptions');
	var permsSetted = docMdlPermission.getElementsByClassName('option canRemove');
	if (permsSetted && permsSetted.length > 0) {
		for (i = 0; i < permsSetted.length; i++) {
			var option = permsSetted[i];
			var hiddenInput = option.querySelectorAll('input[type=hidden]');
			var checkInput = option.querySelector('input[type=checkbox]');
			var tmpString = '&' + hiddenInput[0].getAttribute('name') + '=' + hiddenInput[0].getAttribute('value');
			tmpString += '&' + hiddenInput[1].getAttribute('name') + '=' + hiddenInput[1].getAttribute('value');
			tmpString += '&' + checkInput.getAttribute('name') + '=' + checkInput.checked;
			if (hiddenInput[0].getAttribute('name') == 'docUserId') {
				tmpDocUsrPerm += tmpString;
			} else {
				tmpDocGroPerm += tmpString;
			}
		}
	}
	
	// retrieve documents selected
	var tmpDocsIdNotUpload = '';
	var docsToDelete = $('mdlDocumentContainer').filesToDelete;
	if (docsToDelete.length > 0) {
		for (i = 0; i < docsToDelete.length; i++) {
			tmpDocsIdNotUpload += '&tmpDocToDel=' + docsToDelete[i];
		}
	}
	
	var documents = $('documentInfoContainer').getElementsByClassName('option canRemove');
	if (documents !== null && documents.length === 1) {
		if ($('mdlDocumentContainer').extraProperties && $('mdlDocumentContainer').extraProperties.action == 'confirmExistingDocuments') 
			tmpDocsIds += '&docId=' + encodeURIComponent(documents[0].getAttribute('docid'));
		else tmpDocsIds += '&docId=' + documents[0].getAttribute('docid');
	}
	
	$('mdlDocumentContainer').filesToDelete = [];
	
	//retrieve metadata
	var freeMetadata = '';
	var nonFreeMetadata = '';
	$('tableMetadata').getElements('tr').each(function(tr) {
		if (tr.getRowValue() != '') {
			if (!tr.getRowFree()){ //fijo
				if (nonFreeMetadata != '') nonFreeMetadata += ";";
				nonFreeMetadata += tr.getRowId() + AUXILIAR_SEPARATOR + tr.getRowType() + AUXILIAR_SEPARATOR + tr.getRowValue();
				
			} else { //free
				if (freeMetadata != '') freeMetadata += ";";
				var inputTitle = tr.getRowInputTitle();
				freeMetadata += inputTitle.value + AUXILIAR_SEPARATOR + tr.getRowValue();
			}
		}
	});
	
	// get selected folder
	var folder = '';
	if ($$('li.folder.selected').length > 0) folder = $$('li.folder.selected')[0].id.substring(0, $$('li.folder.selected')[0].id.indexOf('_'));
	else if ($('mdlDocumentContainer').extraProperties && $('mdlDocumentContainer').extraProperties.defaultFolderId) 
		folder = $('mdlDocumentContainer').extraProperties.defaultFolderId;
	
	var expDate = $('docExpDate').value;
	return selectedCmb + tmpDocsIds + description + selectedCmbPerms + /* selectedFolder + */ tmpDocUsrPerm + '&docFolder=' + folder
			+ '&docExpDate=' + expDate + tmpDocGroPerm + tmpDocsIdNotUpload + '&txtMetadata=' + nonFreeMetadata + '&txtFreeMetadata=' + freeMetadata 
			+ ($('mdlDocumentContainer').extraProperties.langId ? '&txtLangId=' + $('mdlDocumentContainer').extraProperties.langId : '')
			+ ($('mdlDocumentContainer').extraProperties.docLangGroup ? '&txtLangGroup=' + $('mdlDocumentContainer').extraProperties.docLangGroup : '');
}

function processDocAddedFromFS(fullDocName) {
	if (fullDocName != null && fullDocName.length > 0) {
		deleteAllDocumentsPreviews(false);
		showDocumentsPreviews();
		var docName = (fullDocName.includes('\\') ? fullDocName.replace(/\\/g, '/') : fullDocName);
		addDocumentPreview(docName.substring(docName.lastIndexOf('.') + 1), docName.substring(docName.lastIndexOf('/') + 1), '', '', true, 'upload');
		
		
		$('mdlDocumentContainer').extraProperties.docId = null;
		$('mdlDocumentContainer').droppedFiles = [];
	}
}

// utils
function showDocumentsPreviews() {
	$('documentInfoContainer').setStyle('display', 'initial');
//	$('documentInfoContainer').setStyle('height', '42px');
}

function hideDocumentsPreviews() {
	$('documentInfoContainer').setStyle('display', 'none');
}

function deleteAllDocumentsPreviews(keepDroppedDocs) {
	Array.from($('docsNamesContainer').getElementsByClassName('option canRemove')).each(function(docPrev) {
		if (keepDroppedDocs == false)
			docPrev.getElementsByClassName('optionRemove')[0].fireEvent('click');
		else if (docPrev.getAttribute('elem-type') == 'up') {
			docPrev.getElementsByClassName('optionRemove')[0].fireEvent('click');
		}
	});
	hideDocumentsPreviews();
}

function deleteAllPerms() {
	Array.from($('scrollOptions').getElementsByClassName('option canRemove')).each(function(perm) {
		perm.getElementsByClassName('optionRemove')[0].fireEvent('click');
	});
	
	if(DOCUMENT_EVERYONE_PERMISSION=="false") {
		$('selDocAllPoolPerm').selectedIndex = 2;
		docProcessModalReturn(CURRENT_USER_LOGIN, CURRENT_USER_LOGIN, true, false);
	} else {
		$('selDocAllPoolPerm').selectedIndex = 0;
	}
}

function hideAllUploadModes() {
	disableFileSystemUpload();
	Array.from($$('tr.btnSelDocToHide')).each(function(trElem) {
		trElem.setStyle('display', 'none');
	});
}

function displayAllUploadModes() {
	enableFileSystemUpload();
	Array.from($$('tr.btnSelDocToHide')).each(function(trElem) {
		trElem.setStyle('display', '');
	});
}

function disableFileSystemUpload() {
	$('frmModalDocumentUpload').removeAttribute('target');
	$('frmModalDocumentUpload').removeAttribute('enctype');
	$('frmModalDocumentUpload').removeAttribute('action');
	
	$('documentModalDocFile').removeClass("validate['required']");
	$('frmModalDocumentUpload').formChecker.dispose($('documentModalDocFile'));
}

function enableFileSystemUpload() {
	$('frmModalDocumentUpload').setAttribute('target', 'documentIframeUpload');
	$('frmModalDocumentUpload').setAttribute('enctype', 'multipart/form-data');
	
	$('documentModalDocFile').addClass("validate['required']");
	$('frmModalDocumentUpload').formChecker.register($('documentModalDocFile'));
}

function focusOnFolder(liElem) {
	openFolderTree(liElem);
	liElem.fireEvent('click');
	//cuando esta readonly (por permisos) no hay evento click, se debe seleccionar a mano
	if(liElem.hasClass('uneditableFldTree')) {
		liElem.addClass('selected');
	}
}

function openFolderTree(from) {
	var liParent = from.getParent('li');
	if (liParent != null && liParent != undefined && liParent.hasClass('subroot')) {
		liParent.fireEvent('dblclick');
		openFolderTree(liParent);
	}
}

function getPageWidth() {
	return Math.max(
		document.body.scrollWidth,
	    document.documentElement.scrollWidth,
	    document.body.offsetWidth,
	    document.documentElement.offsetWidth,
	    document.documentElement.clientWidth
	);
}

