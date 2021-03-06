var currentClassE = "";
var currentClassP = "";
var ACTION_CONFIRM = 0;
var ACTION_SAVE = 1;
var lastAction = -1;

var executionEntForms = new Array();
var executionProForms = new Array();

var IN_EXECUTION = false;
var docTypePerEntId;
var docTypePerProId;

function getTabContainerController() {
	var inIframe = window.parent != null && window.parent.document != null;
	var result = document.getElementById("tabContainer");
	if (result == null && inIframe) result = window.parent.document.getElementById("tabContainer");
	return result;
}

function initPage() {
	
	if(window.customInitPage)
		customInitPage();
		
	var tabController = getTabContainerController() ;
	if ((fromAlterProcess || fromCancelProcess) && tabController) {
		TAB_ID = tabController.activeTab.tabId;
		if (TSK_TITLE) tabController.changeTabTitle(TAB_ID, TSK_TITLE);
		if ($('btnBackToInstAltList')) {
			$('btnBackToInstAltList').style.display = 'none';
		}
		if ($('btnBackToInstCanList')) {
			$('btnBackToInstCanList').style.display = 'none'
		}
	} else if(!isMonitor && tabController){
		if (TSK_TITLE) tabController.changeTabTitle(TAB_ID, TSK_TITLE);
		
		var xCloseTab = tabController.getTabByID(TAB_ID).getElement('.remover');
		xCloseTab.removeEvents('click').addEvent('click', closeTabAction);
	}
	
	//detectar si hay algun tab marcado para resaltar
	if($('tabComments') && commentsMarked){
		$('tabComments').addClass('marked');
	}

	var frmData = $('frmData');
	
	var frmDataDisplay = {
		keepFocusOnError : 0,
		tipsPosition: 'left',
		tipsOffsetY: -12,
		tipsOffsetX: -10
	};
	
	if(window.frmCheckerDisplay) {
		for(var frmCheckerDisplayKey in frmCheckerDisplay) {
			frmDataDisplay[frmCheckerDisplayKey] = frmCheckerDisplay[frmCheckerDisplayKey];
		}
	}
	
	frmData.formChecker = new FormCheck(
			'frmData',
			{
				submit:false,
				display : frmDataDisplay
			}
		);
	
	var current_form_tab = null; 
	var current_form_tab_E = null;
	var current_form_tab_P = null;
	
	//disparar el cargado de los formularios
	$$('div.formContainer').each(function (frm) {
		//parse each form...
		var form = new Form(frm);
		
		if(form.frmType == "E") {
			executionEntForms.push(form);
			if(current_form_tab_E == null) {
				current_form_tab_E = frm.getParent().getParent()
				Form.addCollapseFunctions(current_form_tab_E);
			}
			form.parseXML(current_form_tab_E);
			if(form.tabContent)
				current_form_tab_E = form;
		} else {
			executionProForms.push(form);
			if(current_form_tab_P == null) {
				current_form_tab_P = frm.getParent().getParent()
				Form.addCollapseFunctions(current_form_tab_P);
			}
			form.parseXML(current_form_tab_P);
			if(form.tabContent)
				current_form_tab_P = form;
		}
	});
	
	$$("input.datePicker").each(setAdmDatePicker);
	datePickersLoaded = true;	
	checkErrors();
	
	if(currentTab!=-1){
		$('tabComponent').changeTo(currentTab);
	}
	
	
	
	frmData.addEvent('submit', function(e) {
		if(!window.preventScroll) {
			if(window.getScrollTop) {
				$(window.frameElement).set('data-scrollTo', getScrollTop());
			} else {
				$(window.frameElement).set('data-scrollTo', window.scrollY);
			}
		}
		
		if(frmData.captchas) {
			for(var i = 0; i < frmData.captchas.length; i++ ) {
				frmData.captchas[i].processSubmit(frmData);
			}
		}
		
		this.submit();
	}); 
	
	var btnConf = $('btnConf');
	var btnNext = $('btnNext');
	var btnLast = $('btnLast');
	var btnSave = $('btnSave');
	var btnFree = $('btnFree');
	var btnDelegate = $('btnDelegate');
	var btnBackToMinisite = $('btnBackToMinisite');
	var btnBackToInstAltList = $('btnBackToInstAltList');
	var btnBackToInstCanList = $('btnBackToInstCanList');
	var btnViewDocs = $('btnViewDocs');
	var btnPrintFrm = $('btnPrintFrm');
	var btnViewCal = $("btnViewCal");
	var btnCloseTab = $('btnCloseTab');
	
	if (btnConf) {
		btnConf.addEvent('click', function(e) {
			
			if(e && e.stop)
				e.stop();
			
			if(this.getElement('button') && this.getElement('button').get('disabled'))
				return;
			
			if(btnConf.getProperty('btnDisabled') != 'true'){
				
				if(!frmData.formChecker.isFormValid()){
					return;
				}
				
				if(forceConfirm) {
					
					if(!fireFormSubmitEvents()) {
						SYS_PANELS.closeLoading();
						return;
					}
										
					//Se ejecutaron las clases js onSubmit
					if(!frmData.formChecker.isFormValid()) {
						SYS_PANELS.closeLoading();
						return;
					}
					
					if(frmData.captchas) {
						for(var i = 0; i < frmData.captchas.length; i++ ) {
							frmData.captchas[i].processSubmit(frmData);
						}
					}
					
					confirmFunction();
					
				} else {
					SynchronizeFields.syncJAVAexec(checkWebDavDocumentsLocks);
				}
			}
		});
	}
	
	if (btnSave) {
		btnSave.addEvent('click', function(e) {
		
			e.stop();
			
			if(this.getElement('button') && this.getElement('button').get('disabled'))
				return;
			
			if(btnSave.getProperty('btnDisabled') != 'true') {
				
				if($('schedContainer')) {
					showConfirm(LBL_MSG_NOT_SAVE_SCHED, LBL_TIT_SAVE_TASK, function(res) {
						if(res) {
							checkWebDavDocumentsLocks(true/*saving*/);
						}
					});
				} else {
					checkWebDavDocumentsLocks(true/*saving*/);
				}
			}
		});
	}
	
	if(btnNext){
		btnNext.addEvent('click', function(e) {
			e.stop();
			if(this.getElement('button') && this.getElement('button').get('disabled'))
				return;
			
			if(btnNext.getProperty('btnDisabled') != 'true') {
				
				if(!frmData.formChecker.isFormValid()){
					return;
				}
				
				//TODO: Consultar al servidor por formularios para firmar
				
					SynchronizeFields.syncJAVAexec(function() {
						var request = new Request({
							method: 'post',
							url: 'apia.execution.TaskAction.run?action=hasSignableForms&appletToken=' + appletToken + TAB_ID_REQUEST,
							onComplete: function(resText, resultXml) {
									
								if(resultXml && resultXml.childNodes) {
									
									var resXml;
									
									if(Browser.ie && Browser.version < 10)
										resXml = resultXml.childNodes[1];
									else
										resXml = resultXml.childNodes[0];
									
									if(resXml.getAttribute("sign") == "true") {
										
										SYS_PANELS.closeLoading();
										
										//Tiene formularios firmables y/o documentos marcados para firmar
										
										var data = {};
										data.url = CONTEXT + '/page/generic/empty.jsp?' + TAB_ID_REQUEST;
										data.content = new Element('div.fieldGroup.signature');
										
										var t = new Element('table').setStyle('width', '100%');
										
										var addTitle = true;
										
										for(var i = 0; i < resXml.childNodes.length; i++) {
												
											if(resXml.childNodes[i].nodeName == 'form') {
												
												if(addTitle) {
													new Element('div.title', {html: TIT_SING_MODAL_LBL}).inject(data.content);
													addTitle = false;
												}
												
												var f = {
													i: resXml.childNodes[i].getAttribute('i'),
													t: resXml.childNodes[i].getAttribute('t'),
													p: resXml.childNodes[i].getAttribute('p'),
													m: resXml.childNodes[i].getAttribute('m'),
													r: resXml.childNodes[i].getAttribute('r')
												};
																					
												var tr = new Element('tr');
												var check = new Element('input', {type: 'checkbox'}).inject(new Element('td').setStyle('width', 30).inject(tr));
												
												if(f.m) {
													check.checked = true;
													check.store('SIGNED', 'true');
												} else {
													check.store('SIGNED', 'false');
												}
												
												if(f.r) {
													check.set('disabled', 'true');
												} else {
													check.f_object = f;
													if(f.p == 'E') {
														for(var j = 0; j < executionEntForms.length; j++) {
															if(executionEntForms[j].id == 'E_' + f.i) {
																check.current_form = executionEntForms[j]; break;
															}
														}
													} else {
														for(var j = 0; j < executionProForms.length; j++) {
															if(executionProForms[j].id == 'P_' + f.i) {
																check.current_form = executionProForms[j]; break;
															}
														}
													}
													check.addEvent('change', function() {
														//Si el elemento est??? en pantalla, simular click sobre el
														if(this.current_form) {
															this.current_form.buttonSign.fireEvent('click');
															if(this.retrieve('SIGNED') == "true")
																this.store('SIGNED', 'false');
															else
																this.store('SIGNED', 'true');
														} else {
															//Sino lanzar ajax f.p, f.i
															var sign = this.retrieve('SIGNED') == 'true' ? 'false' : 'true';
															var curr_check = this;
															/****/
															new Request({
																url: 'apia.execution.FormAction.run?action=markFormToSign&frmId=' +  this.f_object.i + '&frmParent=' + this.f_object.p + '&sign=' + sign + TAB_ID_REQUEST,
															    
																onSuccess: function(responseText, responseXML) {
															    	
																	//TODO: parsearErrores y mensajes
																	if(responseXML && responseXML.childNodes && responseXML.childNodes.length){
																		if(responseXML.childNodes[0].tagName == 'result') {
																			if(responseXML.childNodes[0].getAttribute('success') == 'true') {
																				if(curr_check.retrieve('SIGNED') == "true")
																					curr_check.store('SIGNED', 'false');
																				else
																					curr_check.store('SIGNED', 'true');
																			}
																		} else if(responseXML.childNodes[1].tagName == 'result') {
																			//IE friendly
																			if(responseXML.childNodes[1].getAttribute('success') == 'true') {
																				if(curr_check.retrieve('SIGNED') == "true")
																					curr_check.store('SIGNED', 'false');
																				else
																					curr_check.store('SIGNED', 'true');
																			}
																		}
																	}
															    }
															}).send();
														}
													});
												}
												new Element('td', {html: f.t}).inject(tr);
												tr.inject(t);
											} else {
												break;
											}
										}
										
										t.inject(data.content);
										
										//Archivos
										
										var files = {};
										var filesWithoutFrm = [];
										for(; i < resXml.childNodes.length; i++) {
											if(resXml.childNodes[i].nodeName == 'file') {
												
												var frmTitle = resXml.childNodes[i].getAttribute('f');
												var f = {
													i: resXml.childNodes[i].getAttribute('i'),
													t: resXml.childNodes[i].getAttribute('t'),
													p: resXml.childNodes[i].getAttribute('p'),
													l: resXml.childNodes[i].getAttribute('l')
												};
												if(frmTitle) {
													if(!files[frmTitle])
														files[frmTitle] = [];
													files[frmTitle].push(f);
												} else {
													filesWithoutFrm.push(f);
												}
											} else {
												break;
											}
										}
										
										var t = new Element('table.sign');
										
										addTitle = true;
										firstSubTitle = true;
										for(frmTitle in files) {
											
											if(addTitle) {
												new Element('div.title', {html: TIT_SING_DOCS_MODAL_LBL}).inject(data.content);
												addTitle = false;
											}
											
											var subTitle = new Element('div.subtitle', {text: frmTitle}).inject(new Element('td', {colspan: 2}).inject(new Element('tr').inject(t)));
											
											if(firstSubTitle) {
												firstSubTitle = false;
											} else {
												subTitle.addClass('notFirst');
											}
											
											for(var j = 0; j < files[frmTitle].length; j++) {
												var f = files[frmTitle][j];
												
												var tr = new Element('tr');
												var check = new Element('input', {type: 'checkbox'}).inject(new Element('td').setStyle('width', 30).inject(tr));
												
												check.checked = true;
												
												check.f_object = f;
												
												check.set('disabled', 'true');
												
												new Element('td', {html: f.l ? f.l + ' - ' + f.t : f.t}).inject(tr);
												tr.inject(t);
											}
										}
										
										if(filesWithoutFrm.length) {
											
											if(addTitle) {
												new Element('div.title', {html: TIT_SING_DOCS_MODAL_LBL}).inject(data.content);
												addTitle = false;
											}
											
											if(!firstSubTitle) {
												var subTitle = new Element('div.subtitle.notFirst', {text: LBL_OTHER_DOCS}).inject(new Element('td', {colspan: 2}).inject(new Element('tr').inject(t)));
											}
											
											for(var j = 0; j < filesWithoutFrm.length; j++) {
												var f = filesWithoutFrm[j];
												
												var tr = new Element('tr');
												var check = new Element('input', {type: 'checkbox'}).inject(new Element('td').setStyle('width', 30).inject(tr));
												
												check.checked = true;
												
												check.f_object = f;
												
												check.set('disabled', 'true');
												
												new Element('td', {html: f.l ? f.l + ' - ' + f.t : f.t}).inject(tr);
												tr.inject(t);
											}
										}
										
										t.inject(data.content);
										
										ModalController.openContentModal(data).addEvent('confirm', function() {
											
											if(!fireFormSubmitEvents()) {
												SYS_PANELS.closeLoading();
												return;
											}
																
											//Se ejecutaron las clases js onSubmit
											if(!frmData.formChecker.isFormValid()) {
												SYS_PANELS.closeLoading();
												return;
											}
											
											SYS_PANELS.showLoading();
											SynchronizeFields.syncJAVAexec(function() {
												window.preventScroll = true;
												frmData.setProperty('action', 'apia.execution.TaskAction.run?action=gotoNextStep' + TAB_ID_REQUEST + '&currentTab=' + $('tabComponent').getActiveTabId());
												frmData.fireEvent('submit');
											});
										});
									} else {
										//Confirmar tarea
										if(fireFormSubmitEvents()) {
											//Se ejecutaron las clases js onSubmit
											
											if(!frmData.formChecker.isFormValid()) {
													SYS_PANELS.closeLoading();
												return;
											}
											
											//TODO: Pasar al siguiente step
											
											SynchronizeFields.syncJAVAexec(function() {
												window.preventScroll = true;
												frmData.setProperty('action', 'apia.execution.TaskAction.run?action=gotoNextStep' + TAB_ID_REQUEST + '&currentTab=' + $('tabComponent').getActiveTabId());
												frmData.fireEvent('submit');
											});
											
										} else {
											//Una clase de negocio retorno false
												SYS_PANELS.closeLoading();
										}
									}
								}
							}
						}).send();
					});
				
			}
		});
	}

	if(btnLast) {
		btnLast.addEvent('click', function(e) {
			
			if(this.getElement('button') && this.getElement('button').get('disabled')) {
				e.stop();
			} else if(btnLast.getProperty('btnDisabled') != 'true') {
				SYS_PANELS.showLoading();
				SynchronizeFields.syncJAVAexec(function() { 
					frmData.set('data-disabledCheck','true');
					window.preventScroll = true;
					frmData.setProperty('action', 'apia.execution.TaskAction.run?action=gotoPrevStep' + TAB_ID_REQUEST + '&currentTab=' + $('tabComponent').getActiveTabId());
					frmData.fireEvent('submit');
				});
			}
		});
	}
	
	if(btnFree) {
		btnFree.addEvent('click', function(e) {
			if(this.getElement('button') && this.getElement('button').get('disabled')) {
				e.stop();
			} else {
				SYS_PANELS.showLoading();
				var submitUrl = 'apia.execution.TaskAction.run?action=release&' + TAB_ID_REQUEST;
				var request = new Request({
					method: 'post',
					url: submitUrl,
					onRequest: function() { SYS_PANELS.showLoading(); },
					onComplete: function(resText, resXml) { modalProcessXml(resXml); }
				}).send();
			}
		});
	}
	
	if(btnViewDocs) {
		btnViewDocs.addEvent('click', function(e){
			if(this.getElement('button') && this.getElement('button').get('disabled'))
				e.stop();
			else
				showExecutionDocuments(btnViewDocs.getElement('button'));
		});
	}
	
	if(btnPrintFrm) {
		btnPrintFrm.addEvent('click', function(e) {
			if(this.getElement('button') && this.getElement('button').get('disabled'))
				e.stop();
			else
				printForms(btnPrintFrm.getElement('button'));
		});
	}
	
	if(btnViewCal) {
		initCalendarViewMdlPage();
		btnViewCal.addEvent('click', function(e) {
			var selCalValue = $("selCal").get('value');
			if(selCalValue != "0") {
				var calId = selCalValue;
				showCalendarViewModal(calId);
			}
		})
	}
	
	if(btnBackToMinisite) {
		btnBackToMinisite.addEvent('click', function(e) {
			window.parent.location = 'apia.security.LoginAction.run?action=gotoMinisite' + TAB_ID_REQUEST;
		});
	}
	
	if(btnBackToInstAltList) {
		btnBackToInstAltList.addEvent('click', function(e) {
			if(CLOSE_ON_RETURN){
				closeTabAction();
			} else {
				window.location = 'execution.ProStartAction.do?action=initAlter' + URL_PRO_BUS_ENT_IDS + '&goBackToListAlt=true' + TAB_ID_REQUEST;
			}
		});
	}
	
	if (btnBackToInstCanList) {
		btnBackToInstCanList.addEvent('click', function(evt) {
			window.location = 'execution.ProStartAction.do?action=initCancel' + URL_PRO_BUS_ENT_IDS + '&goBackToListCancel=true' + TAB_ID_REQUEST;
		});
	}
	
	if (btnDelegate) {
		btnDelegate.addEvent("click", function(e) {
			if(this.getElement('button') && this.getElement('button').get('disabled')) {
				e.stop();
			} else {
				showConfirm(MSG_NO_GUA,GNR_TIT_WARNING, function(ret) {  
						if (ret) {
							SYS_PANELS.closeAll();
							SYS_PANELS.showLoading();
							var request = new Request({
								method: 'post',
								url: 'apia.execution.TaskAction.run?action=startDelegate' + TAB_ID_REQUEST,
								onRequest: function() { SYS_PANELS.showLoading(); },
								onComplete: function(resText, resXml) { modalProcessXml(resXml); }
							}).send();
						} 
					}, 
					"modalWarning"
				);
			}
		});
	}
	
	if (btnCloseTab) {
		btnCloseTab.addEvent('click', closeTabAction);
	}
	
	if($('progressStepBar') != null){
		drawProgStepBar();
		
	}else{
		drawStepsGraph();
	}
	
	initPinOptions();
	
	if (IN_EXECUTION) {
		initDocuments("E",null,{
			use: true,
			objId: docTypePerEntId,
			objType: 'E'
		}, true, false);
		initDocuments("P",null,{
			use: true,
			objId: docTypePerProId,
			objType: 'P'
		}, true, false);
		initDroppedDocsFunctions('apia.execution.TaskAction.run?', 'P', 'dropAreaP', true, true, false, 'frmOut=true', 
			{
				ajaxUploadStartAction: null,
				docTypePermitted : {
					use: true,
					objId: docTypePerProId,
					objType: 'P'
				}, 
				allowSign: true, 
				dontAllowEdition: false
			});
		initDroppedDocsFunctions('apia.execution.TaskAction.run?', 'E', 'dropAreaE', true, true, false, 'frmOut=true',
			{
				ajaxUploadStartAction: null,
				docTypePermitted : {
					use: true,
					objId: docTypePerEntId,
					objType: 'E'
				}, 
				allowSign: true, 
				dontAllowEdition: false
			});
	} else {
		initDocuments("E");
		initDocuments("P");
		initDroppedDocsFunctions('apia.execution.TaskAction.run?', 'E', 'dropAreaE', true, true, false, 'frmOut=true');
		initDroppedDocsFunctions('apia.execution.TaskAction.run?', 'P', 'dropAreaP', true, true, false, 'frmOut=true');
		
	}
	
	initDocumentMdlPage();
	
	
	
	var scrollToY = $(window.frameElement).get('data-scrollTo');
	if(scrollToY) {
		window.scrollTo(0, scrollToY);
		$(window.frameElement).erase('data-scrollTo');
	}
	
	try{
		frmOnloadE();
	} catch(e){
		if(currentClassE!=""){
			showMessage(Generic.formatMsg(ERR_EXEC_BUS_CLASS, currentClassE));
		}
	}
	try{
		frmOnloadP();
	} catch(e){
		if(currentClassP!=""){
			showMessage(Generic.formatMsg(ERR_EXEC_BUS_CLASS, currentClassP));
		}
	}
	
	var tabMonitor = $('tabMonitor');
	if(tabMonitor) {
		tabMonitor.addEvent('click', function() {
			addScrollTable($('tableDataFormEnt'));
		});
		
		var gridBodyFormEntHeader = $('gridBodyFormEntHeader')
		if(gridBodyFormEntHeader) {
			$('gridBodyFormEnt').addEvent('custom_scroll', function(left) {			
				gridBodyFormEntHeader.setStyle('left', left);
			});
		}
	}
	
	//APIA SOCIAL
	if (APIA_SOCIAL_ACTIVE && window.APIA_SOCIAL_RENDERED) {
		initTaskReadPanel();
		loadCurrentChannels();
		loadApiaSocialCurrentMessages();		
	}
	
	if(idNumWrite) {
		if ($('txtProNum'))
			frmData.formChecker.register($('txtProNum').addClass('validate["required"]'));
	}
	
	//Prevenir submit onKeypress==enter
	new Element('input').set('type', 'text').set('title', 'Prevent Submit').setStyle('display', 'none').inject(frmData);
	
	var image = $('busEntInstImage');
	if (image){
		image.src = CONTEXT + "/getEntInstanceImage.run?height=75&width=75" + TAB_ID_REQUEST;
		image.set('initialValue', image.src);
		
		if (!isMonitor){ 
			image.addEvent('click',function(e){
				e.stop();
				
				var request = new Request({
					method: 'post',
					url: CONTEXT + URL_REQUEST_AJAX + '?action=ajaxUploadStartImage&isAjax=true&' + TAB_ID_REQUEST,
					onRequest: function() { SYS_PANELS.showLoading(); },
					onComplete: function(resText, resXml) { modalProcessXml(resXml); }
				}).send();			
			})
		} else {
			image.getParent().setStyle('cursor','auto');
		}
	}

	
	
	if(window.customEndInitPage)
		customEndInitPage();
	
	
//	window.addEvent('domready', function() {
//		 (function() {
//		  window.fireEvent('resize');
//		 }).delay(100);
//		});

}

function saveTask(){
	 if(fireFormSubmitEvents()){
		 SynchronizeFields.syncJAVAexec(function() {
				var submitUrl = 'apia.execution.TaskAction.run?action=saveTask&' + TAB_ID_REQUEST;
				var params = getFormParametersToSend($('frmData'));
				lastAction=ACTION_SAVE;
				var request = new Request({
					method: 'post',
					url: submitUrl,
					onRequest: function() { },
					onComplete: function(resText, resXml) { modalProcessXml(resXml); }
				}).send(params);
			});		 
	 }
}

function fireFormSubmitEvents(){
	if (window['submitFormsData_E']!=null && !submitFormsData_E()) {
		return false;
	}
	
	if (window['submitFormsData_P']!=null && !submitFormsData_P()) {
		return false;
	}
	
	return true;
}

function drawStepsGraph(){
	
	var container = $('stepsGraph');
	if (container) {
		for(i=0;i<stepQty;i++){
			var selected = "";
			if((i+1)==currentStep){
				selected = " selected";
			}
			var div = new Element("div", {html: '', 'class': 'stepElement' + selected });
			div.set('title','Step ' + (i+1));
			div.set('id', 'stepNum-' + (i+1));
			setTooltip(div);
			div.inject(container);
			
			if(window.addStepsName)
				new Element('span', {text: 'Step ' + (i+1)}).inject(div);
		}
	}
}

function drawProgStepBar (){
	var container = $('stepsGraph');
	if (container) {
		var pBarContainer = $('progressStepBar');
		var progressBar = new Element('ul').set('class','progressBar');
		progressBar.inject(pBarContainer);
		var stepWidth = 100 / stepQty;
		for(i=0;i<stepQty;i++){
			var stepLiTag = new Element('li').set('style',"width:" + stepWidth +"%;").inject(progressBar);
			if ((i+1) == currentStep){
				stepLiTag.addClass('active');			
			}
			if ((i+1) < currentStep){
				stepLiTag.addClass('complete');
			}
			var stepATag = new Element('a').set('tabindex','-1').set('class','centerElementContainer').inject(stepLiTag);
			var stepNumSpan = new Element('div').set('id','stepNum-'+ (i+1)).set('class','stepTitle centerElement').set('html',(i+1)).inject(stepATag);
//			var stepTitle = new Element('span').set('class', 'stepTitle').inject(stepATag);	
		}
		$('divAdminActSteps').setStyle('display','none');
	}
}

function checkErrors(){
	
	var xmlDoc;
	if (window.DOMParser) {
		parser = new DOMParser();
		xmlDoc = parser.parseFromString(new String($('execErrors').value),"text/xml");
	} else {
		// Internet Explorer
		xmlDoc = new ActiveXObject("Microsoft.XMLDOM");
		xmlDoc.async = false;
		xmlDoc.loadXML(new String($('execErrors').value)); 
	}
	
	var xml;
	if(Browser.ie) {
		for(var iter_e = xmlDoc.childNodes.length - 1; iter_e >= 0; iter_e--) {
			if(xmlDoc.childNodes[iter_e].nodeType != 3) {
				xml = xmlDoc.childNodes[iter_e];
				break;
			}
		}
	} else {
		xml = xmlDoc.childNodes[0];
	}
	
	var hasErrors = false;
	var hasExceptions = false;
	if(xml && xml.childNodes) {
		for(var i = 0; i < xml.childNodes.length; i++) {
			if (xml.childNodes[i].tagName == "sysExceptions") {
				processXmlExceptions(xml.childNodes[i], true);
				hasErrors = true;
				hasExceptions = true;
			}
			
			if (xml.childNodes[i].tagName == "sysMessages" && !hasExceptions) {
				processXmlMessages(xml.childNodes[i], true);
				hasErrors = true;
			}
		}
	}
	$('execErrors').value  = "<?xml version='1.0' encoding='iso-8859-1'?><data onClose='' />";
	
	return hasErrors;
}

///-------Funciones para el confirmOK
function confirmOkOnClose(){
	SYS_PANELS.showLoading();
	var params = "";
	//ir al server a verificar si hay wizzard
	var request = new Request({
		method: 'post',
		url: 'apia.execution.TaskAction.run?action=checkWizzard' + TAB_ID_REQUEST,
		onRequest: function() {  },
		onComplete: function(resText, resXml) { processCheckWizzard(resXml); }
	}).send(params);
}

function confirmOkOnSave() {
	SYS_PANELS.closeActive();
}

function confirmOkOnCloseSplash(){
	var tabContainer = window.parent.document.getElementById('tabContainer');
	if(tabContainer) {
		tabContainer.removeTab(tabContainer.activeTab);
	} else {
		if(onFinish=="2") {
			window.parent.location.reload();
		}
	}
}

function clearEvalPath(){

	SYS_PANELS.showLoading();
	var params = "";
	var request = new Request({
		method: 'post',
		url: 'apia.execution.TaskAction.run?action=clearEvalPath' + TAB_ID_REQUEST,
		onRequest: function() {  },
		onComplete: function(resText, resXml) { SYS_PANELS.closeAll(); }
	}).send(params);
	
}

function confirmOkOnSaveSplash() {
	confirmOkOnSave();
	confirmOkOnCloseSplash();
}

function releaseOkOnClose(){
	checkActionRedirect();
}

function delegateOkOnClose(){
	checkActionRedirect();
}

function processCheckWizzard(resXml){
	//si es de wizzard se redirige, sino se pregunta al usuario que desea hacer.
	if (resXml != null) {
		var url;
		if(resXml.firstChild.nextSibling != null){
			url = resXml.firstChild.nextSibling.getAttribute('url')
		}	else {
			url = resXml.firstChild.getAttribute('url');
		}	
		
		if(url!=null){
			SYS_PANELS.showLoading();
			
			var tabContainer = parent.tabContainer;
			if(tabContainer && tabContainer.tabs && tabContainer.tabs.length) {
				for(var i = 0; i < tabContainer.tabs.length; i++) {
					var tab = tabContainer.tabs[i];
					if(tab.content.get('id') == frameElement.get('id')) {
						var tabId_strIndex = url.indexOf('&fromWizzard');
						if(tabId_strIndex)
							tab.newUrl = url.substring(0, tabId_strIndex);
						else
							tab.newUrl = url;
						break;
					}
				}
			}
			
			document.location.href = url; 
		} else {
			if(lastAction==ACTION_SAVE){
				SYS_PANELS.showLoading();
				$('frmData').setProperty('action', 'apia.execution.TaskAction.run?action=refreshStep' + '&currentTab=' + $('tabComponent').getActiveTabId() + TAB_ID_REQUEST);
				$('frmData').set('data-disabledCheck','true');
				$('frmData').fireEvent('submit');
			} else if(lastAction==ACTION_CONFIRM){
				checkActionRedirect();
			} else {
				showMessage(LBL_ERROR);
				if(window.console && console.log) console.log("sin valor en lastAction");
			}
						
		}
	}

}

function checkActionRedirect(){
	
	if(EXTERNAL_ACCESS=="true"){
		if (IS_MINISITE=="true") {
			window.parent.location = 'apia.security.LoginAction.run?action=gotoMinisite' + TAB_ID_REQUEST;
		}
		if(onFinish=="1"){
			window.parent.parent.close();
		} else if(onFinish=="2"){
			window.parent.location.reload();
		} else if(onFinish=="3") {
			//deprecated
		} else if(onFinish=="5") {
			window.parent.location = onFinishURL;
		} else if(onFinish=="100") {
			//llama a funcion del contenedor si es que fue definida
			if(parent.parent && parent.parent.customOnFinish){
				parent.parent.customOnFinish();
			}
		} else if(onFinish=="101") {
			XD.postMessage("custom_close_tab", "*", parent.parent)	
		} else {
			//keepBlocking
			new Element('div.modalBlocker').setStyles({
				width: "100%",
				height: "100%",
				position: "fixed",
				top: "0px",
				left: "0px",
				zIndex: currentZIndex
			}).inject(document.body);
		}
	} else {
		//close tab
		var tabContainer = window.parent.document.getElementById('tabContainer');
		if(tabContainer==null){
			tabContainer = window.top.document.getElementById('tabContainer');
		}
		//tabContainer.removeTab(tabContainer.activeTab);
		tabContainer.removeTabByID(TAB_ID);
	}
}

///-------Funciones para el selectPool


///-------Funciones para el selectPath
function pathOnload(){
	enableFirstColumn($("trPath").getElementsByTagName("TD")[0].getElementsByTagName("TBODY")[0]);
}



function enableFirstColumn(obj) {
	var j;
	for (j=0;j<obj.rows.length;j++) {
		if (obj.rows[j].cells[0].getElementsByTagName("INPUT")[0]) {
			obj.rows[j].cells[0].getElementsByTagName("INPUT")[0].disabled=false;
			if (obj.rows[j].cells[0].getElementsByTagName("INPUT")[0].checked) {
				obj.rows[j].cells[1].style.color="black";
			}
		} else {
			obj.rows[j].cells[0].style.color="black";
			obj.rows[j].cells[1].style.color="black";
			if (rowHasTable(obj.rows[j])) {
				enableFirstColumn(getTable(obj.rows[j]));
			}
		}
	}
}

function getTable(objTr) {
	if (objTr.cells.length == 3) {
		return objTr.cells[2].getElementsByTagName("TABLE")[0];
	} else {
		return objTr.cells[1].getElementsByTagName("TABLE")[0];
	}
}
function checkRadio(obj) {
	if (obj.checked) {
		table = obj.parentNode.parentNode.parentNode.parentNode;
		tdIndex = obj.parentNode.cellIndex;
		trIndex = obj.parentNode.parentNode.rowIndex;
		for (i=0;i<table.rows.length;i++) {
			if (i != trIndex) {
				table.rows[i].cells[tdIndex].getElementsByTagName("INPUT")[0].checked=false;
				table.rows[i].cells[tdIndex+1].style.color="gray";
				if (rowHasTable(table.rows[i])) {
					disableTree(getTable(table.rows[i]));
				}
			}		
		}
		table.rows[trIndex].cells[tdIndex+1].style.color="black";
		if (rowHasTable(table.rows[trIndex])) {
			enableFirstColumn(getTable(table.rows[trIndex]));
		}
	} 
}

function checkCheckbox(obj) {

	table = obj.parentNode.parentNode.parentNode.parentNode;
	tdIndex = obj.parentNode.cellIndex;
	trIndex = obj.parentNode.parentNode.rowIndex;
	if (rowHasTable(table.rows[trIndex])) {
		if (obj.checked) {
			enableFirstColumn(getTable(table.rows[trIndex]));
		} else {
			disableTree(getTable(table.rows[trIndex]));
		}	
	}
	
	if (obj.checked) {
		table.rows[trIndex].cells[tdIndex+1].style.color="black";
	} else {
		table.rows[trIndex].cells[tdIndex+1].style.color="gray";
	}
}

function rowHasTable(objTr) {
	return objTr.cells.length == 3 || 
		   (objTr.cells[1].childNodes.length > 0 && 
		   	objTr.cells[1].getElementsByTagName("TABLE")[0]);
}

function checkSelection() {
	var inpCol = document.getElementsByTagName("INPUT");
	for (i=0;i<inpCol.length;i++) {
		if (!inpCol[i].disabled && (inpCol[i].type=="radio" || inpCol[i].type=="checkbox")) {
			if (!checkSingleSelection(inpCol[i])) {
				return false;
			}
		}
	}
	return true;
}

function checkSingleSelection(obj) {
	table = obj.parentNode.parentNode.parentNode;
	tdIndex = obj.parentNode.cellIndex;
	trIndex = obj.parentNode.parentNode.rowIndex;
	for (j=0;j<table.rows.length;j++) {
		if (table.rows[j].cells[tdIndex].getElementsByTagName("INPUT")[0].checked) {
			return true;
		}		
	}
	return false;
}


function disableTree(obj) {
	var j;
	for (j=0;j<obj.rows.length;j++) {
		if (obj.rows[j].cells[0].childNodes[0].tagName == "INPUT") {
			obj.rows[j].cells[0].childNodes[0].disabled=true;
			obj.rows[j].cells[1].style.color="gray";
		} else {
			obj.rows[j].cells[0].style.color="gray";
			obj.rows[j].cells[1].style.color="gray";
		} 

		if (rowHasTable(obj.rows[j])) {
			disableTree(getTable(obj.rows[j]));
		}
	}
}


///-------FIN Funciones para el selectPath


var appletToken = "";
var forceConfirm = false;

///Firma digital
function appletConfirmer(result, tkn){
	signedOK = result;
	appletToken = tkn;
	
	$('btnConf').fireEvent('click', new Event({
		type: 'click',
		target: $('btnConf')
	}));
	hideAppletModal();
}

function forceAppletConfirmer() {
	forceConfirm = true;
	$('btnConf').fireEvent('click', new Event({
		type: 'click',
		target: $('btnConf')
	}));
	forceConfirm = false;
	hideAppletModal();
}

function appletCloser(result, tkn) {
	signedOK = result;
	
	if(tkn) {
		var request = new Request({
			method: 'post',
			url: 'apia.execution.TaskAction.run?action=unSign&appletToken=' + tkn + TAB_ID_REQUEST,
			onComplete: function(resText, resXml) { 
			}
		}).send();
	} else {
	}
	
	hideAppletModal();
}

function appletNextStepConfirmer(result, tkn){
	 signedOK = result;
	 appletToken = tkn;
	 
	 $('btnNext').fireEvent('click', new Event({
	  type: 'click',
	  target: $('btnNext')
	 }));
	 hideAppletModal();
}


///FIN FIRMA DIGITAL

//--modal de docs
function showExecutionDocuments(source){
	var modal = ModalController.openWinModal(CONTEXT + "/page/generic/docExecutionModal.jsp?isProcessMonitor="+IN_MONITOR_PROCESS+"&isTaskMonitor="+IN_MONITOR_TASK+"&isTask=true" + TAB_ID_REQUEST , 700, 400, null, null, true,true,false);
	modal.addEvent("close", function() {
		source.focus();
	});
}

function forceSubmit() {
	$('frmData').set('action', 'apia.execution.FormAction.run?action=refresh&' + TAB_ID_REQUEST).fireEvent('submit');
}

function confirmFunction() {
	SynchronizeFields.syncJAVAexec(function() {
		var submitUrl = 'apia.execution.TaskAction.run?action=confirm&appletToken=' + appletToken + TAB_ID_REQUEST;
		var params = getFormParametersToSend(frmData);
		lastAction = ACTION_CONFIRM;
		var request = new Request({
			method: 'post',
			url: submitUrl,
			onComplete: function(resText, resultXml) {
				//No tenia nada firmable, se confirm??? la tarea
				modalProcessXml(resultXml);
				
				if(frmData.captchas) {
					for(var i = 0; i < frmData.captchas.length; i++ ) {
						frmData.captchas[i].reloadContent();
					}
				}
			}
		}).send(params);
	});
}

function successWebDavLockFunction(){
	SynchronizeFields.syncJAVAexec(function() {
		var request = new Request({
			method: 'post',
			url: 'apia.execution.TaskAction.run?action=hasSignableForms&prevSteps=true&appletToken=' + appletToken + TAB_ID_REQUEST,
			onComplete: function(resText, resultXml) {
					
				if(resultXml && resultXml.childNodes) {
					
					var resXml;
					
					if(Browser.ie && Browser.version < 10)
						resXml = resultXml.childNodes[1];
					else
						resXml = resultXml.childNodes[0];
					
					if(resXml.getAttribute("sign") == "true") {
						
						SYS_PANELS.closeLoading();
						
						//Tiene formularios firmables y/o documentos marcados para firmar
						
						var data = {};
						data.url = CONTEXT + '/page/generic/empty.jsp?' + TAB_ID_REQUEST;
						data.content = new Element('div.fieldGroup.signature');
						
						var t = new Element('table').setStyle('width', '100%');
						
						var addTitle = true;
						
						for(var i = 0; i < resXml.childNodes.length; i++) {
								
							if(resXml.childNodes[i].nodeName == 'form') {
								
								if(addTitle) {
									new Element('div.title', {html: TIT_SING_MODAL_LBL}).inject(data.content);
									addTitle = false;
								}
								
								var f = {
									i: resXml.childNodes[i].getAttribute('i'),
									t: resXml.childNodes[i].getAttribute('t'),
									p: resXml.childNodes[i].getAttribute('p'),
									m: resXml.childNodes[i].getAttribute('m'),
									r: resXml.childNodes[i].getAttribute('r')
								};
																	
								var tr = new Element('tr');
								var check = new Element('input', {type: 'checkbox'}).inject(new Element('td').setStyle('width', 30).inject(tr));
								
								if(f.m) {
									check.checked = true;
									check.store('SIGNED', 'true');
								} else {
									check.store('SIGNED', 'false');
								}
								
								if(f.r) {
									check.set('disabled', 'true');
								} else {
									check.f_object = f;
									if(f.p == 'E') {
										for(var j = 0; j < executionEntForms.length; j++) {
											if(executionEntForms[j].id == 'E_' + f.i) {
												check.current_form = executionEntForms[j]; break;
											}
										}
									} else {
										for(var j = 0; j < executionProForms.length; j++) {
											if(executionProForms[j].id == 'P_' + f.i) {
												check.current_form = executionProForms[j]; break;
											}
										}
									}
									check.addEvent('change', function() {
										//Si el elemento est??? en pantalla, simular click sobre el
										if(this.current_form) {
											this.current_form.buttonSign.fireEvent('click');
											if(this.retrieve('SIGNED') == "true")
												this.store('SIGNED', 'false');
											else
												this.store('SIGNED', 'true');
										} else {
											//Sino lanzar ajax f.p, f.i
											var sign = this.retrieve('SIGNED') == 'true' ? 'false' : 'true';
											var curr_check = this;
											/****/
											new Request({
												url: 'apia.execution.FormAction.run?action=markFormToSign&frmId=' +  this.f_object.i + '&frmParent=' + this.f_object.p + '&sign=' + sign + TAB_ID_REQUEST,
											    
												onSuccess: function(responseText, responseXML) {
											    	
													//TODO: parsearErrores y mensajes
													if(responseXML && responseXML.childNodes && responseXML.childNodes.length){
														if(responseXML.childNodes[0].tagName == 'result') {
															if(responseXML.childNodes[0].getAttribute('success') == 'true') {
																if(curr_check.retrieve('SIGNED') == "true")
																	curr_check.store('SIGNED', 'false');
																else
																	curr_check.store('SIGNED', 'true');
															}
														} else if(responseXML.childNodes[1].tagName == 'result') {
															//IE friendly
															if(responseXML.childNodes[1].getAttribute('success') == 'true') {
																if(curr_check.retrieve('SIGNED') == "true")
																	curr_check.store('SIGNED', 'false');
																else
																	curr_check.store('SIGNED', 'true');
															}
														}
													}
											    }
											}).send();
										}
									});
								}
								new Element('td', {html: f.t}).inject(tr);
								tr.inject(t);
							} else {
								break;
							}
						}
						
						t.inject(data.content);
						
						//Steps anteriores
						var t = new Element('table').setStyle('width', '100%');
						addTitle = true;
						
						for(; i < resXml.childNodes.length; i++) {
							
							if(resXml.childNodes[i].nodeName == 'form_prev') {
								
								if(addTitle) {
									new Element('div.title', {html: TIT_SING_MODAL_PREV_LBL}).inject(data.content);
									addTitle = false;
								}
								
								var tr = new Element('tr');
								var check = new Element('input', {type: 'checkbox'}).inject(new Element('td').setStyle('width', 30).inject(tr));
								
								check.checked = true;
								
								check.set('disabled', 'true');
								
								new Element('td', {html: resXml.childNodes[i].getAttribute('t')}).inject(tr);
								tr.inject(t);
							} else {
								break;
							}
						}
						
						if(!addTitle)
							t.inject(data.content);
						
						
						//Archivos
						
						var files = {};
						var filesWithoutFrm = [];
						for(; i < resXml.childNodes.length; i++) {
							if(resXml.childNodes[i].nodeName == 'file') {
								
								var frmTitle = resXml.childNodes[i].getAttribute('f');
								var f = {
									i: resXml.childNodes[i].getAttribute('i'),
									t: resXml.childNodes[i].getAttribute('t'),
									p: resXml.childNodes[i].getAttribute('p'),
									l: resXml.childNodes[i].getAttribute('l')
								};
								if(frmTitle) {
									if(!files[frmTitle])
										files[frmTitle] = [];
									files[frmTitle].push(f);
								} else {
									filesWithoutFrm.push(f);
								}
							} else {
								break;
							}
						}
						
						var t = new Element('table.sign');
						
						addTitle = true;
						firstSubTitle = true;
						
						for(frmTitle in files) {
							
							if(addTitle) {
								new Element('div.title', {html: TIT_SING_DOCS_MODAL_LBL}).inject(data.content);
								addTitle = false;
							}
							
							var subTitle = new Element('div.subtitle', {text: frmTitle}).inject(new Element('td', {colspan: 2}).inject(new Element('tr').inject(t)));
							
							if(firstSubTitle) {
								firstSubTitle = false;
							} else {
								subTitle.addClass('notFirst');
							}
							
							for(var j = 0; j < files[frmTitle].length; j++) {
								var f = files[frmTitle][j];
								
								var tr = new Element('tr');
								var check = new Element('input', {type: 'checkbox'}).inject(new Element('td').setStyle('width', 30).inject(tr));
								
								check.checked = true;
								
								check.f_object = f;
								
								check.set('disabled', 'true');
								
								new Element('td', {html: f.l ? f.l + ' - ' + f.t : f.t}).inject(tr);
								tr.inject(t);
							}
						}
						
						if(filesWithoutFrm.length) {
							
							if(addTitle) {
								new Element('div.title', {html: TIT_SING_DOCS_MODAL_LBL}).inject(data.content);
								addTitle = false;
							}
							
							if(!firstSubTitle) {
								var subTitle = new Element('div.subtitle.notFirst', {text: LBL_OTHER_DOCS}).inject(new Element('td', {colspan: 2}).inject(new Element('tr').inject(t)));
							}
							
							for(var j = 0; j < filesWithoutFrm.length; j++) {
								var f = filesWithoutFrm[j];
								
								var tr = new Element('tr');
								var check = new Element('input', {type: 'checkbox'}).inject(new Element('td').setStyle('width', 30).inject(tr));
								
								check.checked = true;
								
								check.f_object = f;
								
								check.set('disabled', 'true');
								
								new Element('td', {html: f.l ? f.l + ' - ' + f.t : f.t}).inject(tr);
								tr.inject(t);
							}
						}

						t.inject(data.content);
						
						ModalController.openContentModal(data).addEvent('confirm', function() {
							SynchronizeFields.syncJAVAexec(function() {
								new Request({
									method: 'post',
									url: 'apia.execution.TaskAction.run?action=sign&' + TAB_ID_REQUEST,
									onRequest: function() { SYS_PANELS.showLoading(); },
									onComplete: function(resText, resXml) { 
										modalProcessXml(resXml);
									}
								}).send();
							});
						});
					} else {
						//Confirmar tarea
						if(fireFormSubmitEvents()) {
							//Se ejecutaron las clases js onSubmit
							
							if(!frmData.formChecker.isFormValid()) {
								if(appletToken) {
									var request = new Request({
										method: 'post',
										url: 'apia.execution.TaskAction.run?action=unSign&appletToken=' + appletToken + TAB_ID_REQUEST,
										onComplete: function(resText, resXml) { 
											SYS_PANELS.closeLoading();
										}
									}).send();
								} else {
									SYS_PANELS.closeLoading();
								}
								return;
							}
							
							if(frmData.captchas) {
								for(var i = 0; i < frmData.captchas.length; i++ ) {
									frmData.captchas[i].processSubmit(frmData);
								}
							}
							
							confirmFunction();
							
						} else {
							//Una clase de negocio retorno false
							if(appletToken) {
								var request = new Request({
									method: 'post',
									url: 'apia.execution.TaskAction.run?action=unSign&appletToken=' + appletToken + TAB_ID_REQUEST,
									onComplete: function(resText, resXml) { 
										SYS_PANELS.closeLoading();
									}
								}).send();
							} else {
								SYS_PANELS.closeLoading();
							}
						}
					}
				}
			}
		}).send();
	});
}

function closeTabAction(){
	if (ON_CLOSE_TASK_MSG){
		showConfirm(ON_CLOSE_TASK_MSG, '', function(res) {
			if(res)
				try{
					getTabContainerController().removeActiveTab();
				}catch(err){
					parent.parent.getTabContainerController().removeActiveTab();
				}

		}, 'modalWarning');	
	} else {
		try{
			getTabContainerController().removeActiveTab();
		}catch(err){
			parent.parent.getTabContainerController().removeActiveTab();
		}

	}
}

//---image methods
function ajaxUploadCallStatusUrlImage() {
	new Request({
		method: 'post',
		url: CONTEXT + URL_REQUEST_AJAX + "?action=ajaxUploadFileStatusImage&isAjax=true" + TAB_ID_REQUEST,
		onComplete: function(resText, resXml) {
			modalProcessXml(resXml); }
		}).send();
}

function setFileName(){
	 var ajaxCallXml = getLastFunctionAjaxCall();
	 if (ajaxCallXml != null) {
		 var messages = ajaxCallXml.getElementsByTagName("messages");
		 if (messages != null && messages.length > 0 && messages.item(0) != null) {
			 messages = messages.item(0).getElementsByTagName("message");
			 var message = messages.item(0);
			 if (message.firstChild != null) text = message.firstChild.nodeValue;
			 var id = text;
			 $('busEntInstImage').src = CONTEXT + "/getEntInstanceImage.run?path=" + id + "&height=75&width=75";
		 }
	 }
	 SYS_PANELS.closeAll();
}

function resetEntInstaceImage(){	
	var image = $('busEntInstImage');
	if (image) {
		image.src = CONTEXT + "/getEntInstanceImage.run?&height=75&width=75";
		image.set('initialValue', image.src);
		
		var request = new Request({
			method: 'post',
			url: CONTEXT + URL_REQUEST_AJAX + '?action=deleteEntInstanceImage&isAjax=true&' + TAB_ID_REQUEST
		}).send();
	}
}

function checkWebDavDocumentsLocks(isSaving){	
	/*
	 * onComplete && !isSaving con ??xito ejecuta funci??n successWebDavLockFunction()
	 * onComplete && isSaving con ??xito ejecuta funci??n processSaveFunction()
	 */
	var submitUrl = 'apia.execution.TaskAction.run?action=checkWebDavDocumentsLocks' + (isSaving? '&saveAction=true' : '') + TAB_ID_REQUEST;
	var request = new Request({
		method: 'post',
		url: submitUrl,
		onRequest: function() { SYS_PANELS.showLoading(); },
		onComplete: function(resText, resXml) { SYS_PANELS.closeAll(); modalProcessXml(resXml); }
	}).send();	
}

function processSaveFunction(){
	saving = true;
	saveTask();
	saving = false;
}