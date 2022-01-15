
var spModalOpts;

var containerForModal = null;

function initOptionsMdlPage(){
	var mdlOptionsContainer = $('mdlOptionsContainer');
	if (mdlOptionsContainer.initDone) return;
	mdlOptionsContainer.initDone = true;

	mdlOptionsContainer.blockerModal = new Mask();
	
	spModalOpts = new Spinner($('mdlBodyOpts'),{message:WAIT_A_SECOND});
	
	$('closeOptionsModal').addEvent("click", function(e) {
		e.stop();
		closeOptionsModal();
	});
	
	$('btnConfirmOptionsModal').addEvent('click', function(evt){
		var mdlOptionsContainer = $('mdlOptionsContainer');
		
		var objPanel = mdlOptionsContainer.objPanel;
		var lastPos = objPanel.getAttribute("pnlPosition");
		var newPos = $("selPosition").value;			
		
		objPanel.setAttribute("pnlPosition",newPos);
		objPanel.setAttribute("pnlOpRemove",$("chkRem").checked ? "true" : "false");
		objPanel.setAttribute("pnlOpVisible",$("chkVis").checked ? "true" : "false");
		objPanel.setAttribute("pnlOpEdit",$("chkEdi").checked ? "true" : "false");
		objPanel.setAttribute("pnlOpVisibleInSitemap",$("chkVisInSitemap").checked ? "true" : "false");
		
		var parameters = objPanel.retrieve('parameters');
		$('tableDataParams').getElements("tr").each(function (trParam){
			var trContent = trParam.getContentStr(); //format: [pnlParamId,value]
			var i = 0;
			while (parameters[i].id != trContent[0]){ i++; }
			parameters[i].value = trContent[1];
			
			if (parameters[i].viewType == PNL_PARAM_VIEW_TYPE_MDL_ENV || parameters[i].viewType == PNL_PARAM_VIEW_TYPE_MDL_PRO || 
					parameters[i].viewType == PNL_PARAM_VIEW_TYPE_MDL_ENT || parameters[i].viewType == PNL_PARAM_VIEW_TYPE_MDL_CAT || 
					parameters[i].viewType == PNL_PARAM_VIEW_TYPE_MDL_TSK || parameters[i].viewType == PNL_PARAM_VIEW_TYPE_MDL_DSH  ||
					parameters[i].viewType == PNL_PARAM_VIEW_TYPE_MDL_ATT || parameters[i].viewType == PNL_PARAM_VIEW_TYPE_MDL_POOL ||
					parameters[i].viewType == PNL_PARAM_VIEW_TYPE_MDL_PRF || parameters[i].viewType == PNL_PARAM_VIEW_TYPE_MDL_IMG ||
					parameters[i].viewType == PNL_PARAM_VIEW_TYPE_MDL_SCH || parameters[i].viewType == PNL_PARAM_VIEW_TYPE_MDL_FLD 
					){
				parameters[i].posValues = trParam.getPosValuesForModal();
			}
			
		});
		objPanel.store('parameters',parameters);
		
		var pools = new Array();
		$$('div.poolCanViewClass').each(function(pool){
			var p = {'id': pool.getAttribute("poolId"),'name': pool.getAttribute("poolName")};
			pools.push(p);
		});
		objPanel.store('pools',pools);
		
		if (mdlOptionsContainer.onModalConfirm){
			jsCaller(mdlOptionsContainer.onModalConfirm,{'lastPos': lastPos,'newPos':newPos});
		}			
		closeModalAction();
		 	
	});
	
	$('poolAdd').addEvent("click",function(e){
		e.stop();
		POOLMODAL_SHOWAUTOGENERATED = true;
		POOLMODAL_SHOWNOTAUTOGENERATED = true;
		POOLMODAL_SHOWGLOBAL = true;
		POOLMODAL_SELECTONLYONE	= false;
		POOLMODAL_FOR_HIERARCHY = false;
		POOLMODAL_ONLY_IN_HIERARCHY = false;
		POOLMODAL_ONLY_OUTSIDE_HIERARCHY = false;
		showPoolsModal(processRetPoolModal);		
	});
}

function showOptionsModal(objPanel, positions, retFunction){
	if(PANEL_OPTIONS_MODAL_HIDE_OVERFLOW) {
		$(document.body).setStyle('overflow', 'hidden');
	}
	
	var mdlOptionsContainer = $('mdlOptionsContainer');
	mdlOptionsContainer.removeClass('hiddenModal');
	mdlOptionsContainer.blockerModal.show();
	mdlOptionsContainer.setStyle('zIndex', SYS_PANELS.getNewZIndex());
	mdlOptionsContainer.onModalConfirm = retFunction;
	mdlOptionsContainer.onModalClose = null;
	mdlOptionsContainer.objPanel = objPanel;
			
	spModalOpts.show(true);
	cleanModal();
	setModal(positions);	
	spModalOpts.hide(true);
	
	mdlOptionsContainer.position();	
	mdlOptionsContainer.focus();
	
	resetChangeHighlight(mdlOptionsContainer);
	initAdminFieldOnChangeHighlight(false, false, false);
}

function cleanModal(){
	$("pnlName").getElements("span").each(function(span){ span.destroy(); });
	$("pnlDesc").getElements("span").each(function(span){ span.destroy(); });
	$("pnlSection").getElements("span").each(function(span){ span.destroy(); });
	if ($("selPosition")) { $("selPosition").destroy(); }
	$("chkVis").checked = false;
	$("chkEdi").checked = false;
	$("chkRem").checked = false;
	$("chkVisInSitemap").checked = false;
	$('tableDataParams').getElements("tr").each(function(tr){ tr.dispose(); });	
	$$('div.poolCanViewClass').each(function(pool){ pool.destroy(); });
	$('allPoolsCanView').setStyle("display","");	
}

function setModal(positions){
	var mdlOptionsContainer = $('mdlOptionsContainer');
	var objPanel = mdlOptionsContainer.objPanel;
	if (objPanel){
		//Datos generales
		var spanName = new Element("span",{html: objPanel.getAttribute("pnlName")}).inject($("pnlName"));
		var pnlName = spanName.textContent;
		var spanDesc = new Element("span", {html: objPanel.getAttribute("pnlDesc")}).inject($("pnlDesc"));
		var spanSection = new Element("span",{html: objPanel.getAttribute("pnlSection")}).inject($("pnlSection"));
		var select = new Element("select",{'id':'selPosition',style:{'width':'40px !important'}}).inject($("pnlPosition"));
		if (positions){
			for (var i = 1; i < positions.length; i++){
				new Element('option', {'value': i, html: i, 'disabled': !positions[i], 'class': positions[i]?'enabled':'disabled'}).inject(select);
			}
			select.value = objPanel.getAttribute("pnlPosition");
		}
		
		//Opciones
		$("chkVis").checked = toBoolean(objPanel.getAttribute("pnlOpVisible"));
		$("chkEdi").checked = toBoolean(objPanel.getAttribute("pnlOpEdit"));
		$("chkRem").checked = toBoolean(objPanel.getAttribute("pnlOpRemove"));
		$("chkVisInSitemap").checked = toBoolean(objPanel.getAttribute("pnlOpVisibleInSitemap"));
		
		
		//Parametros
		var parameters = objPanel.retrieve('parameters');
		var tableDataParams = $('tableDataParams');
		if (parameters != null && parameters.length > 0){
			$('divParameters').style.display = "";
			$('divNoParameters').style.display = "none";

			for (var i = 0; i < parameters.length; i++){
				var param = parameters[i];
				
				var tr = new Element("tr",{}).inject(tableDataParams);
				if (i % 2 == 0) { tr.addClass("trOdd"); }
				if (i == parameters.length-1) { tr.addClass("lastTr"); }
				tr.setAttribute("rowId",param.id);
				tr.set("viewType",param.viewType);
				
				//td1 NOMBRE
				var td1 = new Element("td", {}).inject(tr);
				td1.setAttribute("title", param.description);
				var div1 = new Element('div', {styles: {width: '200px', overflow: 'hidden', 'white-space': 'pre', 'margin': '4px 0px'}}).inject(td1);
				var spanName = new Element('span',{html: param.name}).inject(div1);
				if (div1.scrollWidth > div1.offsetWidth) {
					td1.title = param.name;
					td1.addClass("titiled");
				}
					
				//td2 TIPO
				var td2 = new Element("td", {}).inject(tr);
				var div2 = new Element('div', {styles: {width: '50px', overflow: 'hidden', 'white-space': 'pre', 'margin': '4px 0px'}}).inject(td2);
				var spanType = new Element('span',{html: getLblType(param.type)}).inject(div2);
				
				//td3 VALOR
				var td3 = new Element("td", {}).inject(tr);
				var div3 = new Element('div', {styles: {width: '260px', overflow: 'hidden', 'margin': '4px 0px'}}).inject(td3);
				
				var inputValue;
				if (param.viewType == PNL_PARAM_VIEW_TYPE_CHECKBOX){
					inputValue = new Element('input',{'type':'checkbox','checked':toBoolean(param.value),'class':'parameterString'}).inject(div3);
				
				} else if (param.viewType == PNL_PARAM_VIEW_TYPE_COMBOBOX){
					inputValue = new Element('select',{'value':param.value, 'class': 'parameterString', styles:{'width':'95%'}}).inject(div3);
					var arrPosVal = param.posValues;
					if (arrPosVal != null && arrPosVal.length > 0){
						for (var j = 0; j < arrPosVal.length; j++){
							var pv = arrPosVal[j];
							new Element('option', {'value': pv.value, html: pv.text, 'selected': pv.value == param.value }).inject(inputValue);
						}
					}
					
				} else if (param.viewType == PNL_PARAM_VIEW_TYPE_MDL_ENV || param.viewType == PNL_PARAM_VIEW_TYPE_MDL_PRO || 
							param.viewType == PNL_PARAM_VIEW_TYPE_MDL_ENT || param.viewType == PNL_PARAM_VIEW_TYPE_MDL_CAT || 
							param.viewType == PNL_PARAM_VIEW_TYPE_MDL_TSK || param.viewType == PNL_PARAM_VIEW_TYPE_MDL_DSH ||
							param.viewType == PNL_PARAM_VIEW_TYPE_MDL_ATT || param.viewType == PNL_PARAM_VIEW_TYPE_MDL_POOL ||
							param.viewType == PNL_PARAM_VIEW_TYPE_MDL_PRF || param.viewType == PNL_PARAM_VIEW_TYPE_MDL_IMG ||
							param.viewType == PNL_PARAM_VIEW_TYPE_MDL_SCH || param.viewType == PNL_PARAM_VIEW_TYPE_MDL_FLD){
					inputValue = new Element('input',{'type':'hidden','value':param.value,'class':'parameterString'}).inject(div3);
					
					div3.addClass("modalOptionsContainer");
					
					
					var selectOnlyOne = false;
					if (param.viewType == PNL_PARAM_VIEW_TYPE_MDL_ENT){
						selectOnlyOne = (pnlName == 'Links');
					} else if (param.viewType == PNL_PARAM_VIEW_TYPE_MDL_DSH){
						selectOnlyOne = (pnlName == 'LIST_TEMPLATES' || pnlName == 'TREE_CATEGORIES');
					} else if (param.viewType == PNL_PARAM_VIEW_TYPE_MDL_ATT){
						selectOnlyOne = (pnlName == 'Links');
					} else if (param.viewType == PNL_PARAM_VIEW_TYPE_MDL_IMG){
						selectOnlyOne = true;
					}
					
									
					var newAddBtn = true;
					var arrPosVal = param.posValues;
					if (arrPosVal != null && arrPosVal.length > 0){
						for (var j = 0; j < arrPosVal.length; j++){
							var pv = arrPosVal[j];
							var div = new Element("div.option").inject(div3);
							div.setAttribute("strId",pv.value);
							div.setAttribute("strText",pv.text);
							
							if (param.viewType == PNL_PARAM_VIEW_TYPE_MDL_IMG){
								div.setAttribute("strPath",pv.path);
								div.setStyle("width", "50%");
								var divImg = new Element("div.imgContainer").inject(div);
								divImg.setStyle('background-image', 'url(' + pv.path + ')');
							}
							else {
								div.innerText = pv.text;
							}
							
							//div.addEvent("click",function(e){ e.stop(); this.destroy(); });
							new Element('div.optionRemove').addEvent('click', function() { destroyOption(this); }).inject(div);
						}
						
						newAddBtn = !selectOnlyOne;					
					}
					
					
					var divAddButContainer = new Element('div.optionAddContainer', {"selectOnlyOne" : selectOnlyOne}).inject(div3);
					new Element("div.option.optionAdd",{html: LBL_ADD, styles:{'height':'20px'}}).inject(divAddButContainer);
					
					
					//En caso que ya existe un valor elegido y solo se permite uno se oculta bot�n
					if (!newAddBtn) divAddButContainer.hide();
					
					divAddButContainer.addEvent("click",function(e){
						e.stop();
						var viewType = this.getParent("tr").getAttribute("viewType");
						containerForModal = this.getParent("div"); //div3
						if (viewType == PNL_PARAM_VIEW_TYPE_MDL_ENV){
							ENVIRONMENTMODAL_SELECTONLYONE = false;
							ENVIRONMENTMODAL_HIDE_OVERFLOW = false;
							showEnvironmentsModal(processMdlEnvironmentsRet);
						} else if (viewType == PNL_PARAM_VIEW_TYPE_MDL_PRO){
							PROCESSMODAL_SHOWGLOBAL = false;
							PROCESSMODAL_SELECTONLYONE = false;
							PROCESSMODAL_IS_SCENARIO = false;
							PROCESSMODAL_SHOW_ALL = false;
							PROCESSMODAL_HIDE_OVERFLOW = false;
							showProcessModal(processMdlProcessRet);
						} else if (viewType == PNL_PARAM_VIEW_TYPE_MDL_TSK){
							TASKMODAL_SELECTONLYONE = false;
							TASKMODAL_HIDE_OVERFLOW = false;
							showTaskModal(processMdlTaskRet);
						} else if (viewType == PNL_PARAM_VIEW_TYPE_MDL_SCH) {
							SCHMODAL_SELECTONLYONE = false;
							SCHMODAL_HIDE_OVERFLOW = false;
							showSchModal(processMdlSchRet);
						} else if (viewType == PNL_PARAM_VIEW_TYPE_MDL_ENT){
							ENTITIESMODAL_SHOWGLOBAL = false;
							ENTITIESMODAL_SELECTONLYONE = selectOnlyOne;
							ENTITIESMODAL_HIDE_OVERFLOW = false;
							showEntitiesModal(processMdlBusEntityRet);
						} else if (viewType == PNL_PARAM_VIEW_TYPE_MDL_CAT){
							CATEGORIESMODAL_SHOWGLOBAL = false;
							CATEGORIESMODAL_SELECTONLYONE = false;
							CATEGORIESMODAL_HIDE_OVERFLOW = false;
							showCategoriesModal(processMdlBusEntityRet);
						} else if (viewType == PNL_PARAM_VIEW_TYPE_MDL_DSH){
							DASHBOARD_ENVIRONMENT = CURRENT_ENVIRONMENT;
							//CAM_13512
							//DASHBOARD_ONLY_LANDING_PAGE = true;							
							DASHBOARDSMODAL_SELECTONLYONE = selectOnlyOne;
							DASHBOARDSMODAL_HIDE_OVERFLOW = false;
							showDashboardsModal(processMdlDshboardRet);
						} else if (viewType == PNL_PARAM_VIEW_TYPE_MDL_ATT){							
							ATTRIBUTEMODAL_SELECTONLYONE = selectOnlyOne;
							ATTRIBUTEMODAL_HIDE_OVERFLOW = false;
							showAttributesModal(processMdlBusEntityRet);							
						} else if (viewType == PNL_PARAM_VIEW_TYPE_MDL_POOL){
							POOLMODAL_SHOWGLOBAL = true;
							POOLMODAL_HIDE_OVERFLOW = false;
							showPoolsModal(processMdlBusEntityRet);							
						} else if (viewType == PNL_PARAM_VIEW_TYPE_MDL_PRF){
							PROFILEMODAL_HIDE_OVERFLOW = false;
							showProfilesModal(processMdlBusEntityRet);							
						} else if (viewType == PNL_PARAM_VIEW_TYPE_MDL_IMG){
							IMAGEMODAL_HIDE_OVERFLOW = false;
							showImagesModal(processMdlImageRet);							
						} else if (viewType == PNL_PARAM_VIEW_TYPE_MDL_FLD) {
							TREEDCSFLD_MODAL_SHOW_DOCUMENTS_ON_FLD_CLICK = false;
							showTreeDocsFldsModal(processMdlFldRet);
						}
					});
					
				} else {
					if (param.type == PNL_PARAM_TYPE_DTE){ //Date
						inputValue = new Element('input',{'type':'text','value':param.value,'class':'parameterDate datePickerCustom filterInputDate','format':'d/m/Y'}).inject(div3);
						setAdmDatePicker(inputValue);
					} else if (param.type == PNL_PARAM_TYPE_NUM) { //Numeric
						inputValue = new Element('input',{'type':'text','value':param.value, 'class': 'parameterNumeric'}).inject(div3);
						inputValue.addEvent("keypress",function(e){
							if (e.key < '0' || e.key > '9'){
								if (e.key != "delete" && e.key != "tab" && e.key != "backspace" && e.key != "left" && e.key != "right"){
									e.stop();
								}
							} 
						});
					} else { //String
						inputValue = new Element('input',{'type':'text','value':param.value, 'class': 'parameterString'}).inject(div3);
					}
				}
				
				inputValue.set("paramType", param.type);
				
				
				tr.getContentStr = function (){ //format: [pnlParamId,value]
					var pnlParId = this.getAttribute("rowId");
					var inputValue;
					var viewType = this.getAttribute("viewType");
					
					if (viewType == PNL_PARAM_VIEW_TYPE_COMBOBOX){
						inputValue = this.getElements("td")[2].getElements("div")[0].getElements("select")[0];
						
					} else if (viewType == PNL_PARAM_VIEW_TYPE_MDL_ENV || viewType == PNL_PARAM_VIEW_TYPE_MDL_PRO || 
								viewType == PNL_PARAM_VIEW_TYPE_MDL_ENT || viewType == PNL_PARAM_VIEW_TYPE_MDL_CAT || 
								viewType == PNL_PARAM_VIEW_TYPE_MDL_TSK || viewType == PNL_PARAM_VIEW_TYPE_MDL_DSH  ||
								viewType == PNL_PARAM_VIEW_TYPE_MDL_ATT || viewType == PNL_PARAM_VIEW_TYPE_MDL_POOL ||
								viewType == PNL_PARAM_VIEW_TYPE_MDL_PRF || viewType == PNL_PARAM_VIEW_TYPE_MDL_IMG ||
								viewType == PNL_PARAM_VIEW_TYPE_MDL_SCH || viewType == PNL_PARAM_VIEW_TYPE_MDL_FLD){
						
						var strNewValue = "";
						var div = this.getElements("td")[2].getElements("div")[0];
						var mdlValues = div.getElements("div.optionRemove");
						mdlValues.each(function(mdlVal){
							if (strNewValue != '') strNewValue += STR_PARA_SEPARATOR;
							strNewValue += mdlVal.getParent().getAttribute("strId");
						});
						inputValue = div.getElements("input")[0];
						inputValue.value = strNewValue;
						
					} else {
						inputValue = this.getElements("td")[2].getElements("div")[0].getElements("input")[0];
					}	
					
					var value = inputValue.value;
					
					if (this.getAttribute("viewType") == PNL_PARAM_VIEW_TYPE_CHECKBOX){
						if (value != null && value != ""){
							if (inputValue.getAttribute("paramType") == PNL_PARAM_TYPE_NUM){
								value = inputValue.checked ? "1" : "0"; 
							} else if (inputValue.getAttribute("paramType") == PNL_PARAM_TYPE_STR){
								value = inputValue.checked ? "true" : "false";
							}
						}
					}
					
					var ret = new Array();
					ret.push(pnlParId);
					ret.push(value);
					return ret;
				}
				
				tr.getPosValuesForModal = function (){ //retorna array
					var ret = new Array();
					
					this.getElements("td")[2].getElement("div").getElements("div.optionRemove").each(function(posVal){
						var obj = {
							value : posVal.getParent().getAttribute("strId"),
							text  : posVal.getParent().getAttribute("strText"),
							path  : posVal.getParent().getAttribute("strPath")
					     }
						ret.push(obj)
					});
					return ret;
				}
			}
			
			tableDataParams.getElements('.modalOptionsContainer').each(function(ele){
				initAdminModalHandlerOnChangeHighlight(ele);
			})
			
		} else {
			$('divParameters').style.display = "none";
			$('divNoParameters').style.display = "";
		}	
		
		//Grupos
		var pools = objPanel.retrieve('pools');
		if (pools != null && pools.length > 0){
			for (var i = 0; i < pools.length; i++){
				createPool(pools[i].id, pools[i].name);
			}
		}
		initAdminModalHandlerOnChangeHighlight($('poolsCanView'));
	}
	
	addScrollTable(tableDataParams);
}

function closeOptionsModal(){
	if (!checkParamsUpdate()) return;
	
	closeModalAction();
}

function closeModalAction(){
    var mdlOptionsContainer = $('mdlOptionsContainer');
    mdlOptionsContainer.addClass('hiddenModal');
    mdlOptionsContainer.blockerModal.hide();
    
    if(PANEL_OPTIONS_MODAL_HIDE_OVERFLOW) {
		$(document.body).setStyle('overflow', '');
	}
    
    //Se limpia información de modal
    $('mdlOptionsContainer').getElements('*.highlighted').each(function(ele) { 
		ele.removeClass('highlighted');
	});
}

function checkParamsUpdate(){
	var modElements = $('mdlOptionsContainer').getElements('*.highlighted');
	if (modElements.length>0){		
		SYS_PANELS.newPanel();
		var panel = SYS_PANELS.getActive();
		panel.addClass("modalWarning");
		panel.content.innerHTML = GNR_PER_DAT_ING;
		panel.footer.innerHTML = "<div class='button' onClick=\"SYS_PANELS.closeAll(); closeModalAction();\">" + BTN_CONFIRM + "</div>";
		SYS_PANELS.addClose(panel);

		SYS_PANELS.refresh();
		return false;
	}
	return true;
}

function getLblType(type){
	if (type == PNL_PARAM_TYPE_DTE){ //Fecha
		return LBL_DATE;
	} else if (type == PNL_PARAM_TYPE_NUM){ //Numerico
		return LBL_NUMERIC;
	} else { //String
		return LBL_STRING;
	}
}

function processMdlEnvironmentsRet(ret){
	var doScroll = false;
	if (ret){
		for (var i = 0; i < ret.length; i++){
			var exist = false;
			var all = containerForModal.getElements("div.optionRemove");
			for (var j = 0; j < all.length && !exist; j++){
				exist = all[j].getParent().getAttribute("strId") == ret[i].getRowId();
			}
			if (!exist){
				var content = ret[i].getRowContent();
				var div = new Element("div.option",{html: content[0]}).inject(containerForModal.getElement("div.optionAddContainer"),"before");
				div.setAttribute("strId",ret[i].getRowId());
				div.setAttribute("strText",content[0]);
				//div.addEvent("click",function(e){ e.stop(); this.destroy(); });
				new Element('div.optionRemove').addEvent("click", function(e){ destroyOption(this); }).inject(div);
				doScroll = true;
			}
		}
	}
	
	if (doScroll){ addScrollTable($('tableDataParams')); }
}

function processMdlProcessRet(ret){
	var doScroll = false;
	if (ret){
		for (var i = 0; i < ret.length; i++){
			var exist = false;
			var all = containerForModal.getElements("div.optionRemove");
			for (var j = 0; j < all.length && !exist; j++){
				exist = all[j].getParent().getAttribute("strId") == ret[i].getRowId();
			}
			if (!exist){
				var content = ret[i].getRowContent();
				var div = new Element("div.option",{html: content[0]}).inject(containerForModal.getElement("div.optionAddContainer"),"before");
				div.setAttribute("strId",ret[i].getRowId());
				div.setAttribute("strText",content[0]);
				//div.addEvent("click",function(e){ e.stop(); this.destroy(); });
				new Element('div.optionRemove').addEvent("click", function(e) { destroyOption(this); }).inject(div);
				doScroll = true;
			}
		}
	}
	
	if (doScroll){ addScrollTable($('tableDataParams')); }
}

function processMdlBusEntityRet(ret){
	var doScroll = false;
	if (ret){
		var addContainer = containerForModal.getElement("div.optionAddContainer");
		for (var i = 0; i < ret.length; i++){
			var exist = false;
			var all = containerForModal.getElements("div.optionRemove");
			for (var j = 0; j < all.length && !exist; j++){
				exist = all[j].getParent().getAttribute("strId") == ret[i].getRowId();
			}
			if (!exist){
				var content = ret[i].getRowContent();
				var div = new Element("div.option",{html: content[0]}).inject(addContainer,"before");
				div.setAttribute("strId",ret[i].getRowId());
				div.setAttribute("strText",content[0]);
//				div.addEvent("click",function(e){ e.stop(); this.destroy(); });
				new Element('div.optionRemove').addEvent("click", function(e) { destroyOption(this, addContainer); }).inject(div);
				doScroll = true;
			}
		}
		
		if (addContainer && addContainer.getAttribute("selectOnlyOne")=="true"){
			addContainer.hide();					
		}
	}
	
	if (doScroll){ addScrollTable($('tableDataParams')); }
}

function processMdlSchRet(ret){
	var doScroll = false;
	if (ret){
		for (var i = 0; i < ret.length; i++){
			var exist = false;
			var all = containerForModal.getElements("div.optionRemove");
			for (var j = 0; j < all.length && !exist; j++){
				exist = all[j].getParent().getAttribute("strId") == ret[i].getRowId();
			}
			if (!exist){
				var content = ret[i].getRowContent();
				var div = new Element("div.option",{html: content[0]}).inject(containerForModal.getElement("div.optionAddContainer"),"before");
				div.setAttribute("strId",ret[i].getRowId());
				div.setAttribute("strText",content[0]);
//				div.addEvent("click",function(e){ e.stop(); this.destroy(); });
				new Element('div.optionRemove').addEvent("click", function(e) { destroyOption(this); }).inject(div);
				doScroll = true;
			}
		}
	}
	
	if (doScroll){ addScrollTable($('tableDataParams')); }
}

function processMdlTaskRet(ret){
	var doScroll = false;
	if (ret){
		for (var i = 0; i < ret.length; i++){
			var exist = false;
			var all = containerForModal.getElements("div.optionRemove");
			for (var j = 0; j < all.length && !exist; j++){
				exist = all[j].getParent().getAttribute("strId") == ret[i].getRowId();
			}
			if (!exist){
				var content = ret[i].getRowContent();
				var div = new Element("div.option",{html: content[0]}).inject(containerForModal.getElement("div.optionAddContainer"),"before");
				div.setAttribute("strId",ret[i].getRowId());
				div.setAttribute("strText",content[0]);
//				div.addEvent("click",function(e){ e.stop(); this.destroy(); });
				new Element('div.optionRemove').addEvent("click", function(e) { destroyOption(this); }).inject(div);
				doScroll = true;
			}
		}
	}
	
	if (doScroll){ addScrollTable($('tableDataParams')); }
}

function processRetPoolModal(ret){
	ret.each(function(pool){
		var poolId = pool.getRowId();
		if (!$('p_'+poolId)){
			var poolName = pool.getRowContent()[0];
			createPool(poolId, poolName);
		}
	});
}

function createPool(poolId, poolName){
	var obj = new Element("div.option.poolCanViewClass", {
		html: poolName,
		id: 'p_' + poolId,
		poolId: poolId,
		poolName: poolName
	});
	obj.inject($('poolAdd'),"before");
	
	new Element('div.optionRemove').addEvent("click", function(e){
		if ($$('div.poolCanViewClass').length == 1){
			$('allPoolsCanView').setStyle("display","");
		}
		this.getParent().destroy();		
	}).inject(obj);
	
	$('allPoolsCanView').setStyle("display","none");
}

function processMdlDshboardRet(ret){
	var doScroll = false;
	if (ret){
		var addContainer = containerForModal.getElement("div.optionAddContainer");
		for (var i = 0; i < ret.length; i++){
			var exist = false;
			var all = containerForModal.getElements("div.optionRemove");
			for (var j = 0; j < all.length && !exist; j++){
				exist = all[j].getParent().getAttribute("strId") == ret[i].getRowId();
			}
			if (!exist){
				var content = ret[i].getRowContent();
				var div = new Element("div.option",{html: content[0]}).inject(addContainer,"before");
				div.setAttribute("strId",ret[i].getRowId());
				div.setAttribute("strText",content[0]);
//				div.addEvent("click",function(e){ e.stop(); this.destroy(); });
				new Element('div.optionRemove').addEvent("click", function (e) { destroyOption(this, addContainer); } ).inject(div);
				doScroll = true;
			}
			
			if (addContainer && addContainer.getAttribute("selectOnlyOne")=="true"){
				addContainer.hide();					
			}
		}
	}
	
	if (doScroll){ addScrollTable($('tableDataParams')); }
}

function processMdlImageRet(ret){
	var doScroll = false;
	if (ret){
		var addContainer = containerForModal.getElement("div.optionAddContainer");
		var div = new Element("div.option", {style : "width : 50%;"}).inject(addContainer,"before");
		div.setAttribute("strId",ret.id);
		div.setAttribute("strText",ret.name);
		div.setAttribute("strPath",ret.path);
		
		var divImg = new Element("div.imgContainer").inject(div);
		divImg.setStyle('background-image', 'url(' + ret.path + ')');	
		
		new Element('div.optionRemove').addEvent("click", function (e) { destroyOption(this, addContainer); } ).inject(div);
		
		doScroll = true;		
		
		if (addContainer && addContainer.getAttribute("selectOnlyOne")=="true"){
			addContainer.hide();					
		}		
	}
	
	if (doScroll){ addScrollTable($('tableDataParams')); }
}

function processMdlFldRet(ret) {
	var doScroll = false;
	if (ret){
		for (var i = 0; i < ret.length; i++){
			var exist = false;
			var all = containerForModal.getElements("div.optionRemove");
			for (var j = 0; j < all.length && !exist; j++){
				exist = all[j].getParent().getAttribute("strId") == ret[i].id;
			}
			if (!exist){
//				var content = ret[i];
				var div = new Element("div.option", {'text': ret[i].name}).inject(containerForModal.getElement("div.optionAddContainer"),"before");
				div.setAttribute("strId",ret[i].id);
				div.setAttribute("strText",ret[i].name);
				//div.addEvent("click",function(e){ e.stop(); this.destroy(); });
				new Element('div.optionRemove').addEvent("click", function(e) { destroyOption(this); }).inject(div);
				doScroll = true;
			}
		}
	}
	
	if (doScroll){ addScrollTable($('tableDataParams')); }
}

function destroyOption(ele, addContainer){	
	if (ele && ele.getParent()){
		//Se actualiza contenedor de elementos
		containerForModal = ele.getParent('.modalOptionsContainer');
		
		ele.getParent().destroy(); 
		
		//Si es necesario se vuelva a agregar bot�n para Agregar
		if (containerForModal){
			var addContainer = addContainer? addContainer : containerForModal.getElement("div.optionAddContainer");
			if (addContainer && addContainer.getAttribute("selectOnlyOne")=="true")
				addContainer.show();
		}
		
		//Se actualiza scroll
		addScrollTable($('tableDataParams'));	
	}
}
