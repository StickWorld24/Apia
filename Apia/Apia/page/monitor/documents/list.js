var firstTimeMsg;

function initPage(){
	sp = new Spinner($('gridBody').getParent(),{message:WAIT_A_SECOND});	
	
	['orderByDisplayDocTypeId','orderByDocTypeId','orderByName','orderBySize','orderByRegUser','orderByRegDate'].each(setAdmOrder);
	['orderByDisplayDocTypeId','orderByDocTypeId','orderByName','orderBySize','orderByRegUser','orderByRegDate'].each(setAdmListTitle);
	if (!MODE_MONITOR && !ABM_EDITION_MODE) {
		['cmbDocTypeId','nameFilter','descFilter','sizeMinFilter','sizeMaxFilter','regUsrFilter','ownerTitleFilter','instFilter','contentFilter'].each(setAdmFilters);
		['txtCreateFrom', 'txtCreateTo'].each(setDateFilters);
	}
	
	
	$('clearFilters').addEvent("click", function(e) {
		if(e) e.stop();
		['cmbDocTypeId','nameFilter','descFilter','sizeMinFilter','sizeMaxFilter','cmbDocOrigin','regUsrFilter','ownerTitleFilter','contentFilter','instFilter'].each(clearFilter);
		if ($('docFolderFilter')) ['docFolderFilter'].each(clearFilter);
		['txtCreateFrom','txtCreateTo'].each(clearFilterDate);		
		removeAllMetadataFilters(true,true);		
		enableDisableFilters($('cmbDocOrigin'));
		if (!MODE_MONITOR && !ABM_EDITION_MODE) $('nameFilter').setFilter();
	}).addEvent('keypress', Generic.enterKeyToClickListener);
	
	enableDisableFilters($('cmbDocOrigin'));
	
	if (MODE_MONITOR){
		//Information
		
		
		$('btnBus').addEvent('click', function(e) {
			if (e) e.stop();
//			setFilter();
			if (allFiltersAreEmpty()) {
				if ($('tableData').getChildren('tr').length == 0) {
					var gridBody = $('gridBody');
					gridBody.noDataMessage.dispose();
					firstTimeMsg = new Element('div', {
						'class': 'noDataMessage', 
						html: MSG_MST_ENTR_FLTR,
						styles: {
							'display': '',
							'width': gridBody.getStyle("width")
						}
					}).inject(gridBody);
					
					firstTimeMsg.position( {
						relativeTo: gridBody,
						position: 'upperLeft'
					});
					gridBody.noDataMessage = firstTimeMsg;
				} else {
					showMessage(MSG_MST_ENTR_FLTR, GNR_TIT_WARNING, 'modalWarning');
				}
			} else if ($('nameFilter').value != '' && $('nameFilter').value.startsWith('.') && $('nameFilter').value.length < 5) {
				showMessage(MSG_NME_TOO_SHORT, GNR_TIT_WARNING, 'modalWarning');
			} else setFilter();
		});
		
		$('btnInfo').addEvent('click', function(e){
			e.stop();
			if (selectionCount($('tableData')) > 1) {
				showMessage(GNR_CHK_ONLY_ONE, GNR_TIT_WARNING, 'modalWarning');
			} else if(selectionCount($('tableData')) == 0) {
				showMessage(GNR_CHK_AT_LEAST_ONE, GNR_TIT_WARNING, 'modalWarning');
			} else {
				var id = getSelectedRows($('tableData'))[0].getRowId();
				showDocInformationModal(encodeURIComponent(id));				
			}
		});
		
		$('btnDwnInfo').addEvent('click', function(e){
			e.stop();
			if (selectionCount($('tableData')) > 1) {
				showMessage(GNR_CHK_ONLY_ONE, GNR_TIT_WARNING, 'modalWarning');
			} else if(selectionCount($('tableData')) == 0) {
				showMessage(GNR_CHK_AT_LEAST_ONE, GNR_TIT_WARNING, 'modalWarning');
			} else {
				var id = getSelectedRows($('tableData'))[0].getRowId();
				showDocDwnInfoModal(encodeURIComponent(id));				
			}
		});
		
		//History
		$('btnHist').addEvent("click", function(e) {
			e.stop();
			if (selectionCount($('tableData')) > 1) {
				showMessage(GNR_CHK_ONLY_ONE, GNR_TIT_WARNING, 'modalWarning');
			} else if(selectionCount($('tableData')) == 0) {
				showMessage(GNR_CHK_AT_LEAST_ONE, GNR_TIT_WARNING, 'modalWarning');
			} else {
				var id = getSelectedRows($('tableData'))[0].getRowId();
				var downloadDocId= getSelectedRows($('tableData'))[0].get("data-downloadDocId");
				showDocVersionsModal(encodeURIComponent(id), encodeURIComponent(downloadDocId));
			}
		});
		
		
		$('btnDown').addEvent('click', function(e){
			e.stop();
			hideMessage();
			
			if (selectionCount($('tableData')) == 0) {
				showMessage(GNR_CHK_AT_LEAST_ONE, GNR_TIT_WARNING, 'modalWarning');
			} else {
				var documentsIds = '';
				if (selectionCount($('tableData')) == 1) {
					var trSelected = getSelectedRows($('tableData'))[0];
					if (trSelected.hasClass('noDown')) {
						showMessage(MSG_NO_PERM, GNR_TIT_WARNING, 'modalWarning');
						return;
					} else {
						documentsIds = '&id=' + encodeURIComponent(trSelected.get("data-downloadDocId"));
					}
				} else {
					var trSelected = getSelectedRows($('tableData'));
					for (index = 0; index < trSelected.length; index++) {
						var rowSelected = trSelected[index];
						if (rowSelected.hasClass('noDown')) {
							continue;
						} else {
							documentsIds += '&id=' + encodeURIComponent(rowSelected.get("data-downloadDocId"));
						}
					}
				}
				
				new Request({
					method: 'post',
					url: CONTEXT + URL_REQUEST_AJAX + '?action=loadDownloadDocument&isAjax=true' + documentsIds + TAB_ID_REQUEST,
					onRequest: function() { SYS_PANELS.showLoading(); },
					onComplete: function(resText, resXml) { customProcessDocModal(resXml, documentsIds); }
				}).send();
			}
		});

		// ABMDocuments
		initAdminActions(false, false, true, false, false, false);
		var btnCreate = $('btnCreate');
		var btnAlter = $('btnUpdate');
		var btnDependency = $('btnDependencies');
		var btnDelete = $('btnDelete');
		
		if (btnCreate) {
			btnCreate.removeEvents('click');
			btnCreate.addEvent('click', function(evt) {
				if (evt) evt.stop();
				
				if ($('tableData').getChildren('tr').length > 0) deleteFirstTimeMssg();
				showDocumentsModal(
					mdlConfirmFunct,
					null,
					{
						'url_aux': URL_REQUEST_AJAX_ABM,
						'action': 'insertDocumentABM',
						'prefix': 'ABM',
					},
				);
				
				
			});
		}
		
		if (btnAlter) {
			btnAlter.removeEvents('click');
			btnAlter.addEvent('click', function(evt) {
				if (evt) evt.stop();
				if (selectionCount($('tableData')) == 0) {
					showMessage(GNR_CHK_AT_LEAST_ONE, GNR_TIT_WARNING, 'modalWarning');
				} else if (selectionCount($('tableData')) > 1) {
					showMessage(GNR_CHK_ONLY_ONE, GNR_TIT_WARNING, 'modalWarning');
				} else {
					var id = getSelectedRows($('tableData'))[0].getRowId();
					var uneditable = getSelectedRows($('tableData'))[0].get('uneditableTr');
					var docLock = toBoolean(getSelectedRows($('tableData'))[0].get('docLock'));
					var docLockByCurrUsr = toBoolean(getSelectedRows($('tableData'))[0].get('dLckByCurrUsr'));
//					var docLockByUsr = toBoolean(getSelectedRows($('tableData'))[0].get('dLckByUsr'));
					if (uneditable && CURRENT_USER !== ADMINISTRATOR_USER) {
						showMessage(CANT_UPDATE_DOCUMENT, GNR_TIT_WARNING, 'modalWarning');	// No tiene permisos para editar el documento
					} else if (docLock && !docLockByCurrUsr) {
						showMessage(MSG_DOC_LOCK_BY_OTH_USR, GNR_TIT_WARNING, 'modalWarning');
					} else {
						if ($('tableData').getChildren('tr').length > 0) deleteFirstTimeMssg();
						showDocumentsModal(
								mdlConfirmFunct,
								encodeURIComponent(id),
								{
									'url_aux': URL_REQUEST_AJAX_ABM,
									'action': 'editABM',
									'prefix': 'ABM',
								},
							);
							new Request({
								method: 'post',
								url: CONTEXT + URL_REQUEST_AJAX_ABM + '?action=getDocumentInfo&isAjax=true&fromABM=true' + TAB_ID_REQUEST,
								onRequest: function() { /*SYS_PANELS.showLoading(); */},
								onComplete: function(resText, resXml) { 
									$('documentModalDocFile').disabled = true;
									$('documentModalDocFile').removeClass("validate['required']");
									$('frmModalDocumentUpload').formChecker.dispose($('documentModalDocFile'));
									showDocumentInfoInModal(resXml, CURRENT_USER === ADMINISTRATOR_USER ? 'ABM' : null);
								}
							}).send('docId=' + encodeURIComponent(id));
							
//							new Request({
//								method: 'post',
//								url: CONTEXT + URL_REQUEST_AJAX_ABM + '?action=getDocumentInfo&isAjax=true&fromABM=true' + TAB_ID_REQUEST,
//								onRequest: function() { SYS_PANELS.showLoading(); },
//								onComplete: function(resText, resXml) { 
//									
//									SYS_PANELS.closeActive();
//									
//									showDocumentsModal(
//											mdlConfirmFunct,
//											null,
//											{
//												'url_aux': URL_REQUEST_AJAX_ABM,
//												'action': 'editABM',
//												'prefix': 'ABM',
//											},
//										);
//									
//									$('documentModalDocFile').disabled = true;
//									$('documentModalDocFile').removeClass("validate['required']");
//									$('frmModalDocumentUpload').formChecker.dispose($('documentModalDocFile'));
//									showDocumentInfoInModal(resXml, CURRENT_USER === ADMINISTRATOR_USER ? 'ABM' : null);
//									
//									
//								}
//							}).send('docId=' + encodeURIComponent(id));
					}
				}
			});
		}
		
		if (btnDependency) {
			btnDependency.removeEvents('click');
			btnDependency.addEvent('click', function(evt) {
				if (evt) evt.stop();
				if (selectionCount($('tableData')) == 0) {
					showMessage(GNR_CHK_AT_LEAST_ONE, GNR_TIT_WARNING, 'modalWarning');
				} else if (selectionCount($('tableData')) > 1) {
					showMessage(GNR_CHK_ONLY_ONE, GNR_TIT_WARNING, 'modalWarning');
				} else {
					var id = encodeURIComponent(getSelectedRows($('tableData'))[0].getRowId());
					new Request({
						method: 'post',
						url: CONTEXT + URL_REQUEST_AJAX_ABM + '?action=loadDeps&isAjax=true' + TAB_ID_REQUEST,
						onRequest: function() { /*SYS_PANELS.showLoading(); */},
						onComplete: function(resText, resXml) { modalProcessXml(resXml);}
					}).send('id=' + id);
				}
			});
		}
		
		if (btnDelete) {
			btnDelete.removeEvents('click');
			btnDelete.addEvent('click', function(evt) {
				if (evt) evt.stop();
				if (selectionCount($('tableData')) == 0) {
					showMessage(GNR_CHK_AT_LEAST_ONE, GNR_TIT_WARNING, 'modalWarning');
				} else {
					SYS_PANELS.newPanel();
					var panel = SYS_PANELS.getActive();
					panel.addClass("modalWarning");
					panel.header.innerHTML = GNR_TIT_WARNING;
					panel.content.innerHTML = LBL_DOCS_WILL_BE_DEL;
													
					panel.footer.innerHTML = "<div class='button' onClick=\"SYS_PANELS.closeAll(); deleteABMDocument();\">" + BTN_CONFIRM + "</div>";	
					SYS_PANELS.addClose(panel);
					SYS_PANELS.refresh();
				}
			});
		}
//	} else {
//		//Unlock
//		
//		//Cambiar valor de opciones para mapear la vista de unlock
//		var opts = $('cmbDocOrigin').getElements('option');
//		for(var i = 0; i < opts.length; i++) {
//			if(opts[i].get('value') == 'EA')
//				opts[i].set('value', 'EIA');
//			else if(opts[i].get('value') == 'PA')
//				opts[i].set('value', 'PIA');
//		}
//		
//		$('btnUnlock').addEvent("click", function(e){
//			e.stop();
//			hideMessage();
//			if(selectionCount($('tableData')) == 0) {
//				showMessage(GNR_CHK_AT_LEAST_ONE, GNR_TIT_WARNING, 'modalWarning');
//			} else {				
//				SYS_PANELS.newPanel();
//				var panel = SYS_PANELS.getActive();
//				panel.addClass("modalWarning");
//				panel.header.innerHTML = GNR_TIT_WARNING;
//				panel.content.innerHTML = UNLOCK_DOC_WARNING;
//												
//				panel.footer.innerHTML = "<div class='button' onClick=\"SYS_PANELS.closeAll(); unlockDocuments();\">" + BTN_CONFIRM + "</div>";	
//				SYS_PANELS.addClose(panel);
//				SYS_PANELS.refresh();
//			}
//		});
//		
//		//['btnUnlock'].each(setTooltip);
	}
	
	if (!MODE_MONITOR || ABM_EDITION_MODE) {
		//Unlock
		
		//Cambiar valor de opciones para mapear la vista de unlock
		var opts = $('cmbDocOrigin').getElements('option');
		for(var i = 0; i < opts.length; i++) {
			if(opts[i].get('value') == 'EA')
				opts[i].set('value', 'EIA');
			else if(opts[i].get('value') == 'PA')
				opts[i].set('value', 'PIA');
		}
		
		$('btnUnlock').addEvent("click", function(e){
			e.stop();
			hideMessage();
			if(selectionCount($('tableData')) == 0) {
				showMessage(GNR_CHK_AT_LEAST_ONE, GNR_TIT_WARNING, 'modalWarning');
			} else {				
				SYS_PANELS.newPanel();
				var panel = SYS_PANELS.getActive();
				panel.addClass("modalWarning");
				panel.header.innerHTML = GNR_TIT_WARNING;
				panel.content.innerHTML = UNLOCK_DOC_WARNING;
												
				panel.footer.innerHTML = "<div class='button' onClick=\"SYS_PANELS.closeAll(); unlockDocuments();\">" + BTN_CONFIRM + "</div>";	
				SYS_PANELS.addClose(panel);
				SYS_PANELS.refresh();
			}
		});
		
		//['btnUnlock'].each(setTooltip);
	}
	
	$('addFreeMetadataFilter').addEvent("click",function(e){
		e.stop();
		addDocFreeMetadataFilter("","");
	});
	
	$$('div.fncDescriptionImage').each(function(e){
		var path = 'url(' + e.get('data-src') + ')'
		e.setStyle('background-image', path);
		e.setStyle('background-repeat', 'no-repeat');
		e.setStyle('width', '64px');
		e.setStyle('height', '64px');
	});
	
	setDatesChecker();
	initDocInformationMdlPage();
	initDocVersionsMdlPage();
	initDocDwnInfoMdlPage();
	initNavButtons();
	initAdminFav();
	initDocumentMdlPage('ABM');
	initUsrMdlPage();
	initPoolMdlPage();

	
	if (!PRE_FILTER && MODE_MONITOR){
		//NO SE EJECUTA LA CONSULTA AL COMENZAR LA FUNCIONALIDAD
		//CAM_11316
		//callNavigate();
		var gridBody = $('gridBody');
		firstTimeMsg = new Element('div', {'class': 'noDataMessage', html: MSG_FIRST_TIME}).inject(gridBody);
		firstTimeMsg.setStyle('display','');
		firstTimeMsg.setStyle("width",gridBody.getStyle("width"));
		firstTimeMsg.position( {
			relativeTo: gridBody,
			position: 'upperLeft'
		});
		gridBody.noDataMessage = firstTimeMsg;
	} else {
		callNavigate();
	}	
	
	initPinGridOptions();
	
	if (ABM_EDITION_MODE) {
		loadFoldersStructure();
	}
}

function allFiltersAreEmpty() {
	var fldFlterEmpty = $('docFolderFilter') ? $('docFolderFilter').selectedIndex == 0 : true;
	return $('cmbDocTypeId').selectedIndex == 0 && $('nameFilter').value == '' &&
		$('descFilter').value == '' && $('sizeMaxFilter').value == '' && $('regUsrFilter').value == '' &&
		$('ownerTitleFilter').value == '' && $('instFilter').value == '' &&
		$('contentFilter').value == '' && $('txtCreateFrom').value == '' &&
		$('txtCreateTo').value == '' && $('cmbDocOrigin').selectedIndex == 0 && fldFlterEmpty;
}

function mdlConfirmFunct() {
	showMessage(MSG_OK_MSSG, '', 'addClass');
	closeDocumentsModal();
//	if (!allFiltersAreEmpty()) $('navRefresh').fireEvent('click');
}

function fncDocumentRemove () {
	$('navRefresh').fireEvent('click');
}

function enableDisableFilters(cmb){
	//Filter Titulo
	if ("" != cmb.value){
		$('ownerTitleFilter').className = "";
		$('ownerTitleFilter').readOnly = false;
	} else {
		$('ownerTitleFilter').className = "readonly";
		$('ownerTitleFilter').readOnly = true;
		$('ownerTitleFilter').value = "";
	}	
	//Filter NroRegistro
	if (INST_PROC == cmb.value || INST_ENT == cmb.value || ATT_INST_PROC == cmb.value || ATT_INST_ENT == cmb.value){
		$('instFilter').className = "";
		$('instFilter').readOnly = false;
	} else {
		$('instFilter').className = "readonly";
		$('instFilter').readOnly = true;
		$('instFilter').value = "";
	}
} 

function documentVersionDownload(docId,docVer){
	createDownloadIFrame("",DOWNLOADING,URL_REQUEST_AJAX,"download","&id="+docId+"&version="+docVer,"","",null);	
}

//establecer un filtro
function setFilter(){
	var docMetadataFilter = createStrDocMetadataFilter();
	var docFreeMetadataFilter = createStrDocFreeMetadataFilter();
	var docFoldIdFilter = ($('docFolderFilter')) ? $('docFolderFilter').value : null; 
	
	if (firstTimeMsg){
		firstTimeMsg.destroy();
		firstTimeMsg = null;
	}
	
	callNavigateFilter({
			txtName: $('nameFilter').value,
			txtDesc: $('descFilter').value,
			txtSizeFrom: $('sizeMinFilter').value,
			txtSizeTo: $('sizeMaxFilter').value,
			selType: $('cmbDocOrigin').value,
			txtUser: $('regUsrFilter').value,
			txtRelTitle: $('ownerTitleFilter').value,
			txtContent: $('contentFilter').value,
			txtInst: $('instFilter').value,
			txtCreateFrom: $('txtCreateFrom').value,
			txtCreateTo: $('txtCreateTo').value,
			txtDocTypeId: $('cmbDocTypeId').value,
			txtFol: docFoldIdFilter,
			strDocMetadata: docMetadataFilter,
			strDocFreeMetadata: docFreeMetadataFilter
		},null);
}

function removeAllMetadataFilters(docMetadata,docFreeMetadata){
	if (docMetadata){
		$('docMetadataFilters').getElement("div.content").innerHTML = "";
		$('docMetadataFilters').setStyle("display","none");
	}
	if (docFreeMetadata){
		$('docFreeMetadataFilters').getElement("div.content").innerHTML = "";
		$('docFreeMetadataFilters').setStyle("display","none");
	}	
}

function loadAllDocMetadataFilters(docTypeId){
	if (docTypeId == null || docTypeId == ""){
		removeAllMetadataFilters(true,true);
		if (!MODE_MONITOR && !ABM_EDITION_MODE) setFilter();
		return;
	}
	
	//remove docMetadata --> no docFreeMetada por si el nuevo tiene metadatos libres
	removeAllMetadataFilters(true,false);
	
	var request = new Request({
		method: 'post',
		url: CONTEXT + URL_REQUEST_AJAX + '?action=loadMetadata&isAjax=true&docTypeId=' + docTypeId + TAB_ID_REQUEST,
		onRequest: function() { },
		onComplete: function(resText, resXml) { processXmlMetadataMonitor(resXml); }
	}).send();	
}

function processXmlMetadataMonitor(resXml){
	
	if (resXml != null) {
		var allMetadata = resXml.getElementsByTagName("allMetadata");
		if (allMetadata != null && allMetadata.length > 0 && allMetadata.item(0) != null) {
			var docMetadata = allMetadata.item(0).getElementsByTagName("docMetadata");
			var docFreeMetadata = allMetadata.item(0).getElementsByTagName("docFreeMetadata");
		
			var docFreeMetadataAvailable = toBoolean(allMetadata.item(0).getAttribute("docFreeMetadataAvailable"));
			
			//DocMetadata
			if (docMetadata != null && docMetadata.length > 0 && docMetadata.item(0) != null) {
				docMetadata = docMetadata.item(0).getElementsByTagName("metadata");
				
				for (var i = 0; i < docMetadata.length; i++){
					var xmlFilter = docMetadata[i];
					var id = xmlFilter.getAttribute("id");
					var title = xmlFilter.getAttribute("title");
					var type = xmlFilter.getAttribute("type");
					var value = xmlFilter.getAttribute("value");
					var value2 = undefined;
					if (type == "D") { value2 = xmlFilter.getAttribute("value2"); }
					addDocMetadataFilter(id,title,type,value,value2);								
				}
			}
			
			//DocFreeMetadata
			if (docFreeMetadataAvailable){
				$('docFreeMetadataFilters').setStyle("display","");
			} else {
				removeAllMetadataFilters(false, true);
			}
			if (docFreeMetadata != null && docFreeMetadata.length > 0 && docFreeMetadata.item(0) != null) {
				docFreeMetadata = docFreeMetadata.item(0).getElementsByTagName("metadata");
					
				for (var i = 0; i < docFreeMetadata.length; i++){
					var xmlFilter = docMetadata[i];
					var title = xmlFilter.getAttribute("title");
					var value = xmlFilter.getAttribute("value");
					addDocFreeMetadataFilter(title, value);
				}
			}	
		} else {
			removeAllMetadataFilters(true, true);
		}
	} else {
		removeAllMetadataFilters(true, true);
	}
	if (!MODE_MONITOR && !ABM_EDITION_MODE) setFilter();
}

function addDocMetadataFilter(id,title,type,value,value2){
	var content = $('docMetadataFilters').getElement("div.content");
	
	var divFilter = new Element("div",{'class':'filter'}).inject(content);
	divFilter.setAttribute("docTypeMetadataId",id);
	divFilter.setAttribute("docTypeMetadataType",type);
	new Element("span",{html:title+':&nbsp;'}).inject(divFilter);
	if (type == "D"){
		var inputValueFrom = new Element('input',{'type':'text','value':value,'class':'datePickerCustom filterInputDate','format':'d/m/Y','maxlength':'10',styles:{'width':'20%'}}).inject(divFilter);
		setAdmDatePicker(inputValueFrom);
		setDateFilters(inputValueFrom);
		
		new Element("span",{html:'&nbsp;&nbsp;-&nbsp;&nbsp;',styles:{'width':'18px'}}).inject(divFilter);
		var inputValueTo = new Element('input',{'type':'text','value':value2,'class':'datePickerCustom filterInputDate','format':'d/m/Y','maxlength':'10',styles:{'width':'20%'}}).inject(divFilter);
		setAdmDatePicker(inputValueTo);
		setDateFilters(inputValueTo);
	} else if (type == "N"){
		var inputValue = new Element('input',{'type':'text','value':value}).inject(divFilter);
		inputValue.addEvent("keypress",function(e){
			if (e.key < '0' || e.key > '9'){
				if (e.key != "delete" && e.key != "tab" && e.key != "backspace" && e.key != "left" && e.key != "right"){
					e.stop();
				}
			} 
		});
		if (!MODE_MONITOR && !ABM_EDITION_MODE) setAdmFilters(inputValue);
	} else {
		var inputValue = new Element("input",{'type':'text','value':value}).inject(divFilter);
		if (!MODE_MONITOR && !ABM_EDITION_MODE) setAdmFilters(inputValue);
	}
	
	$('docMetadataFilters').setStyle("display","");	
}

function addDocFreeMetadataFilter(title,value){
	var content = $('docFreeMetadataFilters').getElement("div.content");
	
	var divFilter = new Element("div",{'class':'filter'}).inject(content);
	var remFilter = new Element("div.addRemoveFilter.removeFilter",{}).inject(divFilter);
	remFilter.addEvent("click",function(e){
		e.stopPropagation();
		var parent = this.getParent("div.filter");
		var inputTit = parent.getElement("input.freeMetFilterTit").value;
		var inputVal = parent.getElement("input.freeMetFilterVal").value;
		this.getParent("div.filter").destroy();
		if (inputTit != "" && inputVal != "") { setFilter(); }
	});
	var inputTitle = new Element("input.freeMetFilterTit",{'type':'text','value':title,'title':LBL_TITLE}).inject(divFilter);
	inputTitle.addClass("autocomplete");
	var inputTitleKey = new Element("input",{'type':'hidden','value':title}).inject(divFilter);
	inputTitle.inputTitleKey = inputTitleKey;
	var inputValue = new Element("input.freeMetFilterVal",{'type':'text','value':value,'title':LBL_VALUE}).inject(divFilter); 
	setDocFreeMetadataFilterEvents(inputTitle, inputValue);
	$('docFreeMetadataFilters').setStyle("display","");
}

function setDocFreeMetadataFilterEvents(inputTitle,inputValue){
	//Titulo
	inputTitle.inputValue = inputValue;
	inputTitle.setFilter = setFilter;
	setAutoCompleteGeneric(inputTitle, inputTitle.inputTitleKey, 'search', 'doc_free_metadata', 'doc_free_metadata_title', 'doc_free_metadata_title', 'doc_free_metadata_title', false, true, false, true, true, null, "", true);
	inputTitle.addEvent('optionNotSelected', function(evt) {
		this.value = "";
		this.inputTitleKey.value = "";
		if (this.inputValue.value != ""){
			setFilter();
		}
	});
	inputTitle.addEvent('optionSelected', function(evt) {
		if (this.inputValue.value != ""){
			setFilter();
		}
	});
	inputTitle.addEvent('change', function(evt) {
		if (this.value == "")
		this.fireEvent("optionNotSelected");
	});	
	
	//Valor
	inputValue.setFilter = setFilter;
	inputValue.oldValue = inputValue.value;
	inputValue.inputTitle = inputTitle;
	inputValue.addEvent("keyup", function(e) {
		if (this.oldValue == this.value) return;
		if (this.inputTitle.inputTitleKey.value == "") return;
		if (this.timmer) $clear(this.timmer);
		this.oldValue = this.value;
		this.timmer = this.setFilter.delay(200, this);
	});
}

function createStrDocMetadataFilter(){ //id�tipo�valor;id�tipo�valor;...
	var str = "";
	$('docMetadataFilters').getElement("div.content").getElements("div.filter").each(function (filter){
		var value = filter.getElement("input").value;
		var type = filter.getAttribute("docTypeMetadataType");
		var id = filter.getAttribute("docTypeMetadataId");
		if (value != null && value != ""){
			if (str != "") str += ";";
			str += id + PRIMARY_SEPARATOR + type + PRIMARY_SEPARATOR + value;
		}
		if (type == "D"){
			value = filter.getElements("input")[2].value;
			if (value != null && value != ""){
				if (str != "") str += ";";
				str += "-" + id + PRIMARY_SEPARATOR + type + PRIMARY_SEPARATOR + value;
			}
		}
	});
	return str;
}

function createStrDocFreeMetadataFilter(){ //titulo�valor;titulo�valor...
	var str = "";
	$('docFreeMetadataFilters').getElement("div.content").getElements("div.filter").each(function (filter){
		var inputs = filter.getElements("input");
		if (inputs.length == 3 && inputs[1].value != "" && inputs[2].value != ""){
			var title = inputs[1].value;
			var value = inputs[2].value;
			if (str != "") str += ";";
			str += title + PRIMARY_SEPARATOR + value;
		}
	});
	return str;
}

function unlockDocuments(){
	var selected = getSelectedRows($('tableData'));
	var selection = "";
	for(i=0; i<selected.length; i++){
		selection+=encodeURIComponent(selected[i].getRowId());
		if(i<selected.length-1){
			selection+=";";
		}
	}
	var request = new Request({
		method: 'post',
		url: CONTEXT + URL_REQUEST_AJAX + '?action=unlock&isAjax=true&unlock=true&id=' + selection + TAB_ID_REQUEST,
		onRequest: function() { SYS_PANELS.showLoading(); },
		onComplete: function(resText, resXml) { modalProcessXml(resXml); }
	}).send();
}

function validateDates(obj){
	if (obj.id.startsWith('txt')) {
		var dteStart = $('txtCreateFrom');
		var dteEnd = $('txtCreateTo');
	} 
	
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

function customProcessDocModal(resXml, documentId) {
	SYS_PANELS.closeAll();
	
	//En caso de error, se procesan							
	if (resXml==null || resXml.getElementsByTagName("sysMessages").length != 0 ||
				resXml.getElementsByTagName('sysExceptions').length>0)							
		modalProcessXml(resXml);
	else
		createDownloadIFrame("", DOWNLOADING,URL_REQUEST_AJAX, "download", "", "", "true", null);
}

function downloadElementDependencies(id) {
	createDownloadIFrame("",DOWNLOADING,URL_REQUEST_AJAX_ABM,"downloadDeps","&id="+id,"","",null);
}

function loadFoldersStructure() {
	Array.from($('docFolderFilter').options).each(function(opt) {
		opt.destroy();
	});
	
	$('docFolderFilter').innerHTML = '';
	new Element('option', {'text':''}).inject($('docFolderFilter'));
	
	new Request({
		method: 'post',
		url: CONTEXT + URL_REQUEST_AJAX_ABM + '?action=loadFolderStructure&isAjax=true' + TAB_ID_REQUEST,
		onRequest: function() { SYS_PANELS.showLoading(); },
		onComplete: function(resText, resXml) {	populateComboWithFolders(resXml); },
	}).send();
}

function populateComboWithFolders(xml) {
	/*
	 * pongo dentro del option dos tags: uno que contiene la identacion y otro que contenga mismo el texto de la opcion
	 * */
	if (xml.getElementsByTagName('folder') != null && xml.getElementsByTagName('folder').length > 0) {	//siempre viene al menos el ROOT
		var auxSelect = $('docFolderFilter');
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
					opt = new Element('option', {'value': value, 'level': level, 'id': value});
					new Element('span', {'text': identation}).inject(opt);
					new Element('span', {'text': name}).inject(opt);
					
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
	}
	
	SYS_PANELS.closeActive();
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

function deleteABMDocument() {
	var docsToDel = '';
	var docCanDel = false;
	Array.from(getSelectedRows($('tableData'))).each(function(row) {
		if (!docsToDel.contains(row.getRowId()))
			docsToDel += '&docId=' + encodeURIComponent(row.getRowId());
		docCanDel = docCanDel || row.get('uneditableTr');
	});
	
	if (docCanDel && CURRENT_USER !== ADMINISTRATOR_USER) {
		showMessage(CANT_DELETE_DOCUMENT, GNR_TIT_WARNING, 'modalWarning');	// No se tienen permisos para eliminar alguno de los documentos
	} else {
		new Request({
			method: 'post',
			url: CONTEXT + URL_REQUEST_AJAX_ABM + '?action=ajaxRemoveDocument&isAjax=true' + TAB_ID_REQUEST,
			onRequest: function() { sp.show()},
			onComplete: function(resText, resXml) { sp.hide(); modalProcessXml(resXml);},
			onSuccess: function() {$('navRefresh').fireEvent('click');}
		}).send(docsToDel);
	}
}

function deleteFirstTimeMssg() {
	if (firstTimeMsg){
		firstTimeMsg.destroy();
		firstTimeMsg = null;
	}
}

function fncABMUploadReturn() {
	SYS_PANELS.closeActive();
	if ($('mdlDocumentContainer').onModalConfirm) $('mdlDocumentContainer').onModalConfirm();
}