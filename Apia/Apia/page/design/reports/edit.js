function initPage() {
	
	//crear spinner de espere un momento
	sp = new Spinner(document.body,{message:WAIT_A_SECOND});
	
	//$('mdlPoolContainer').blockerModal = new Mask();
	
	loadPermissions();
	
	if ($('btnConf')) $('btnConf').style.display = '';
	$('btnCloseTab').style.display = '';
	$('btnBackToList').style.display = '';
	$('divAdminActEdit').style.display = '';
	
	
	if ($('btnCloseTab')) {
		$('btnCloseTab').addEvent('click', closeCurrentTab);
	}
	
	initAdminFav();
	
	$('fileName').set('readOnly', true);
	
	initPoolMdlPage();
	
	var btnUpdCons = $('btnUpdateCons');
	
	if (btnUpdCons) {
		btnUpdCons.addEvent("click", function(e) {
			e.stop();
			updateConnections();
		});
	}
	
	var btnTstSql = $('btnTest');
	if (btnTstSql) {
		btnTstSql.addEvent("click", function(e) {
			e.stop();
			
			var form = $('frmData');
			
			var nameValidation = form.formChecker.manageError($('repQryName'),'testonly');
			var fieldValidation = form.formChecker.manageError($('repQuery'),'testonly');
			
			if (!nameValidation){
				return;
			}
			if (!fieldValidation) {
				return;
			}
			
			var value = $('cmbSrc').value;
			if (value == SRC_PENTAHO){
				testSqlView();
			} else if (value == SRC_BUS_CLASS){
				var repBusClaExec = $('repBusClaExec');
				if (repBusClaExec.value == ''){
					showMessage(MSG_ADD_EXEC, GNR_TIT_WARNING, 'modalWarning');
				} else {
					var request = new Request({
						method : 'post',
						url : CONTEXT + URL_REQUEST_AJAX + '?action=testBusClaExec&isAjax=true&busClaExec=' + repBusClaExec.value + TAB_ID_REQUEST,
						onRequest : function() { SYS_PANELS.showLoading(); },
						onComplete : function(resText, resXml) { modalProcessXml(resXml); }
					}).send();
				}
			}			
		});
	}
	
	$('selConn').addEvent('change', function() {
		if (!this.isVisible()) return;
		
		if (Number.from($('selConn').get('value'))==0) {
			$('repQryName').set('disabled', true);
			$('repQryName').set('value', '');
			$('repQuery').set('disabled', true);
			$('repQuery').set('value', '');
			$('divQryNom').removeClass('required');
			$('divQuery').removeClass('required');
			
			$('repQryName').set('readonly', true);
			$('repQuery').set('readonly', true);
			
			$('repQryName').addClass('readonly');
			$('repQuery').addClass('readonly');
			
			frmData.formChecker.dispose($('repQryName'));
			frmData.formChecker.dispose($('repQuery'));
		}else {
			$('repQryName').set('disabled', false);
			$('repQuery').set('disabled', false);
			$('divQryNom').addClass('required');
			$('divQuery').addClass('required');
			
			$('repQryName').set('readonly', false);
			$('repQuery').set('readonly', false);
			
			$('repQuery').removeClass('readonly');
			$('repQryName').removeClass('readonly');
			
			frmData.formChecker.register($('repQryName'));
			frmData.formChecker.register($('repQuery'));
		}
	});
	
//	if ($('selConn').get('value')==0){
//		$('repQryName').set('disabled', true);
//		$('repQryName').set('value', '');
//		$('repQuery').set('disabled', true);
//		$('repQuery').set('value', '');
//		$('divQryNom').removeClass('required');
//		$('divQuery').removeClass('required');
//		frmData.formChecker.dispose($('repQryName'));
//		frmData.formChecker.dispose($('repQuery'));
//	}
	
	if ($('prmAddPool')) {
		$('prmAddPool').addEvent("click", function(e) {
			e.stop();
			//setear variables de configuracion del modal de grupos
			POOLMODAL_SHOWAUTOGENERATED = true;
			POOLMODAL_SHOWNOTAUTOGENERATED = true;
			POOLMODAL_SHOWGLOBAL = true;
			POOLMODAL_SHOWCURRENTENV = true;
			ADDITIONAL_INFO_IN_TABLE_DATA = false;
			//abrir modal
			showPoolsModal(prmProcessPoolsModalReturn);
		});
	}
	
	$('optionUpload').addEvent("click", function(e){
		e.stop();
		
		var value = $('cmbSrc').value;
		if (value == SRC_PENTAHO){
			upload(false);			
		} else if (value == SRC_BUS_CLASS){
			var repBusClaExec = $('repBusClaExec');
			if (repBusClaExec.value == ''){
				showMessage(MSG_ADD_EXEC, GNR_TIT_WARNING, 'modalWarning');
				return;
			} else {
				//verificar si existe la clase para alerta de sobreescribir
				checkIfExecAlreadyExist(repBusClaExec.value);
			}
		}							
	});
	
	
	if(Browser.ie)
		$('optionDownload').addEvent("click", function(evt) {
			evt.target.getParent('a').click();
		});
	
	setParamsGridButtons();
	loadParams();
	
	/************************************************************************************************
	 * El siguiente c�digo se extrajo de adminActionEdition.jsp, del metodo initAdminActionsEdition()
	 * Ya que se desea testear la sql antes de realizar el submit
	 ************************************************************************************************/
	
	$('frmData').formChecker = new FormCheck(
			'frmData',
			{
				submit:false,
				display : {
					keepFocusOnError : 1,
					tipsPosition: 'left',
					tipsOffsetY: -12,
					tipsOffsetX: -10
				},
				validateDisabled: true
			}
		);
	
	if ($('btnConf')){
		$('btnConf').addEvent("click", function(e) {
			e.stop();
			
			var form = $('frmData');
			if(!form.formChecker.isFormValid()){
				return;
			}
			
			
			
			var value = $('cmbSrc').value;
			if (value == SRC_PENTAHO){
				//testear sql
				testSqlView(true); //Testeamos la sql, y si esta bien realizamos el submit
			} else if (value == SRC_BUS_CLASS){
				var params = getFormParametersToSend($('frmData'));
				var request = new Request({
					method : 'post',
					url : CONTEXT + URL_REQUEST_AJAX + '?action=confirm&isAjax=true&processHttp=true' + TAB_ID_REQUEST,
					onRequest : function() { SYS_PANELS.showLoading(); },
					onComplete : function(resText, resXml) { modalProcessXml(resXml); }
				}).send(params);
			}
		});
	}

	$('btnBackToList').addEvent("click", function(e) {
		e.stop();
		
		var btnConf = $('btnConf');
		
		var avoidContainers;
		if ($('cmbSrc').value == SRC_PENTAHO){
			avoidContainers = ['divRepBusClaExec'];
		} else {
			avoidContainers = ['divParameters', 'divSelConn', 'divQryNom', 'divQuery'];
		}
		
		if (btnConf && isAnyElementModified(avoidContainers)){
			SYS_PANELS.newPanel();
			var panel = SYS_PANELS.getActive();
			panel.addClass("modalWarning");
			panel.content.innerHTML = GNR_PER_DAT_ING;
			panel.footer.innerHTML = "<div class='button' onClick=\"SYS_PANELS.closeAll(); clickGoBack();\">" + BTN_CONFIRM + "</div>";
			SYS_PANELS.addClose(panel);
			SYS_PANELS.refresh();
		} else {
			clickGoBack();
		}
	});
	
	$$('div.fncDescriptionImage').each(function(e){
		var path = 'url(' + e.get('data-src') + ')'
		e.setStyle('background-image', path);
		e.setStyle('background-repeat', 'no-repeat');
		e.setStyle('width', '64px');
		e.setStyle('height', '64px');
	});
	
	//['btnConf','btnBackToList','btnCloseTab','btnUpdateCons','btnTest','optionUpload','optionDownload'].each(setTooltip);
	
	/************************************************************************************************
	 * Fin de codigo extraido de adminActionEdition.jsp
	 ************************************************************************************************/
	
	getBodyController().canRemoveTab = function() { return ! AT_LEAST_ON_FIELD_INPUT_CHANGED; };
	
	var gridParams = $('gridParams');
	var gridHeader = $('gridHeaderHeader');
	gridParams.getParent('div').addEvent('custom_scroll', function(move) {
		gridHeader.setStyle('left', move);
	});
	addScrollTable(gridParams);
	
	
	onChangeCmbSrc($('cmbSrc'));
	$('selConn').fireEvent('change');
	
	
	var changeImg = $('changeImg');
	if (changeImg){
		changeImg.addEvent("click",function(e){
			e.stop();
			showImagesModal(processImg);
		});
	}
	initImgMdlPage();
	
	var btnResetImg = $('btnResetImg');
	if (btnResetImg){
		btnResetImg.addEvent("click",function(e){
			e.stop();
			var txtImgPath = $('txtImgPath');
			var changeImg = $('changeImg'); 
			changeImg.style.backgroundImage = "url('"+CONTEXT + PATH_IMG + DEFAULT_IMG+"')";
			txtImgPath.value = DEFAULT_IMG;
			changeImg.fireEvent('change');
		});
	}
	
	initAdminFieldOnChangeHighlight(false, false, false, null , true);
}

function clickGoBack(){
	sp.show(true);
	window.location = CONTEXT + URL_REQUEST_AJAX + '?action=list' + TAB_ID_REQUEST;	
}

function setParamsGridButtons() {
	var btnAddParam = $('btnAddParam');
	if (btnAddParam){
		btnAddParam.addEvent("click",function(e){
			e.stop();
			fncAddParam();
		});
	}
	
	var btnDeleteParam = $('btnDeleteParam');
	if (btnDeleteParam){
		btnDeleteParam.addEvent("click",function(e){
			e.stop();
			var count = selectionCount($('gridParams'));
			if(count==0) {
				showMessage(GNR_CHK_AT_LEAST_ONE, GNR_TIT_WARNING, 'modalWarning');
			} else if (count>1){
				showMessage(GNR_CHK_ONLY_ONE, GNR_TIT_WARNING, 'modalWarning');
			}else{
				btnDelParam_click();
			} 
		});
	}
}

function upload(busClasExec){
	if (busClasExec == undefined){ busClasExec = false; }
	hideMessage();
	var request = new Request({
		method: 'post',
		url: CONTEXT + URL_REQUEST_AJAX+'?action=uploadFile&isAjax=true&isBusClaExec=' + busClasExec + TAB_ID_REQUEST,
		onRequest: function() { SYS_PANELS.showLoading(); },
		onComplete: function(resText, resXml) { modalProcessXml(resXml);}
	}).send();
}

function updateConnections() {
	var request = new Request({
		method: 'post',
		url: CONTEXT + URL_REQUEST_AJAX + '?action=updateCons&isAjax=true' + TAB_ID_REQUEST,
		onRequest: function() {},
		onComplete: function(resText, resXml) {processXMLCons(resXml);}
	});
	
	request.send();
}

function updateFileName() {
	var request = new Request({
		method: 'post',
		url: CONTEXT + URL_REQUEST_AJAX + '?action=getFileName&isAjax=true' + TAB_ID_REQUEST,
		onRequest: function() {},
		onComplete: function(resText, resXml) {processXMLFileName(resXml);}
	});
	
	request.send();
}

function processXMLFileName(ajaxCallXml){
	if (ajaxCallXml != null) {
		 
		var result = ajaxCallXml.getElementsByTagName("upload_result");
		var fileName = "";
		
		if (result != null && result.length > 0 && result.item(0) != null) {
			fileName = result.item(0).getAttribute("file_name");
		}else {
			 showMessage(MSG_SRV_CONN_LOST, GNR_TIT_WARNING, 'modalWarning');
		}
		
		if ("prpt" == fileName.substring(fileName.indexOf(".") + 1)){
			$('fileName').set('value',fileName);
			$('fileName').fireEvent('change');
		}else {
			showMessage(MSG_WRONG_FORMAT_FILE, GNR_TIT_WARNING, 'modalWarning');
		}
	}
}

function processXMLCons(ajaxCallXml){
	if (ajaxCallXml != null) {
		//Vaciamos el combo de conexiones
		var selConx = $('selConn');
		while(selConx.options.length>0){
			selConx.removeChild(selConx.options[0]);
		}
		 
		var atts = ajaxCallXml.getElementsByTagName("conns");
		if (atts != null && atts.length > 0 && atts.item(0) != null) {
			atts = atts.item(0).getElementsByTagName("conn");
			for(var i = 0; i < atts.length; i++) {
				var att = atts.item(i);
				var text = att.getAttribute("conn_name");
				var id = att.getAttribute("conn_id");
				
				addConnsToContainer(text,id);
			}
		}
		
		//habilitamos nombre consulta y text area
		document.getElementById("repQuery").disabled = false;
		document.getElementById("repQryName").disabled = false;
		setRequiredField(document.getElementById("repQuery"));
		document.getElementById("btnTestSql").disabled = false;
		setRequiredField(document.getElementById("repQryName"));
	}
}

function addConnsToContainer(conxName, conxId) {
	var opt = new Element('option', {
		html: conxName,
		value: conxId
	});
	
	var selConx = $('selConn');	
	selConx.appendChild(opt);
	
}

function testSqlView(onConfirm){
	var sql = $('repQuery').value;
	var nombre = $('repQueryName');
	// primero veo si tienen contenido
	
	//Nos fijamos si contiene par�metros
	if (!onConfirm && sql.indexOf("${")>0){
		showMessage(LBL_REP_QRY_TST_PARAMS, GNR_TIT_WARNING, 'modalWarning');
	}else{
		SYS_PANELS.showLoading();
		var params = getFormParametersToSend($('frmData'));
		var dbConId = $('selConn').value;
		var sql = $('repQuery').value;
		var request = new Request({
			method: 'post',
			url: CONTEXT + URL_REQUEST_AJAX + '?action=sqlTest&isAjax=true' + TAB_ID_REQUEST + '&onConfirm=' + onConfirm,
			onRequest: function() {},
			onComplete: function(resText, resXml) {modalProcessXml(resXml); }
		});
		
		request.send(params);
	}
}

function processXMLTestResult(ajaxCallXml, onConfirm){
	if (ajaxCallXml != null) {
		var result = ajaxCallXml.getElementsByTagName("test_result");
		var testResult = "";
		
		if (result != null && result.length > 0 && result.item(0) != null) {
			testResult = result.item(0).getAttribute("test_result");
		}else {
			 showMessage(MSG_SRV_CONN_LOST, GNR_TIT_WARNING, 'modalWarning');
		}

		if(testResult != "OK" && testResult != "WP"){
			 if (!onConfirm){ //Si no estamos confirmando
				 showMessage("SQL ERROR: " + testResult, GNR_TIT_WARNING, 'modalWarning');
			 }else {
				 var msg = confirm(MSG_QUERY_WITH_ERRORS);
				 if (msg) {
					 	//REALIZAMOS SUBMIT
			        	doSubmit();  
				 }else{
					    return false;
				 }
			 }
	    } else { //SQL IS OK
	        if (!onConfirm){ //Si no estamos confirmando
	        	showMessage("SQL OK!", GNR_TIT_WARNING, 'modalWarning');
	        } else {
	        	//REALIZAMOS SUBMIT
	        	doSubmit();  	
	        }
	    }
	}else {
		showMessage(MSG_SRV_CONN_LOST, GNR_TIT_WARNING, 'modalWarning');
		return false;
	}
}

function doSubmit(){
//	var params = getFormParametersToSend($('frmData'));
	var request = new Request({
		method: 'post',
		url: CONTEXT + URL_REQUEST_AJAX + '?action=confirm&isAjax=true' + TAB_ID_REQUEST,
		onRequest: function() { SYS_PANELS.showLoading(); },
		onComplete: function(resText, resXml) { modalProcessXml(resXml); }
	}).send(); 
}

var param_titles;


function fncAddParam(par_name, par_desc, par_type, par_def_val, par_def_sel, par_req){
	var parent = $('gridParams').getParent();
	$('gridParams').selectOnlyOne = false; 
	var thead = parent.getFirst("thead");
	var theadTr = thead ? thead.getFirst("tr") : null;
	var headers = theadTr ? thead.getElements("th") : null;
	var tdWidths = headers ? new Array(headers.length) : null;
	if (headers) {
		for (var i = 0; i < headers.length; i++) {
			tdWidths[i] = headers[i].getStyle('width');
			if (! tdWidths[i]) tdWidths[i] = headers[i].get('width');
		}
	}
	
	var oTd0 = new Element("TD"); //nombre
	var oTd1 = new Element("TD"); //desc
	var oTd2 = new Element("TD"); //tipo
	var oTd3 = new Element("TD"); //valor por defecto
	var oTd4 = new Element("TD"); //requerido
	
	//Nombre
	div = new Element('div', {styles: {width: tdWidths[0], overflow: 'hidden', 'white-space': 'pre','text-align':'center'}});
	var input = new Element('input',{type:'text',name:'par_name'});
	input.set('value',par_name);
	input.setStyle('width', tdWidths[0]);
	input.setStyle('width',  Number.from(tdWidths[0]) - 5);
	input.inject(div);
	div.inject(oTd0);
	
	//Descripcion
	div = new Element('div', {styles: {width: tdWidths[1], overflow: 'hidden', 'white-space': 'pre','text-align':'center'}});
	input = new Element('input',{type:'text',name:'par_desc'});
	input.set('value', par_desc);
	input.setStyle('width',  Number.from(tdWidths[1]) - 5);
	input.inject(div);
	div.inject(oTd1);
	
	//Tipo
	if (par_type != "N" && par_type != "S"  && par_type != "D" && par_type != "I") par_type = "E";
	
	div = new Element('div', {styles: {width: tdWidths[2], overflow: 'hidden', 'white-space': 'pre','text-align':'center'}});
	var tdWidth = tdWidths[2].substring(0, tdWidths[2].indexOf('px')) - 5;
	selector = new Element('select',{name:'par_type'}).setStyle('width', tdWidth);
	
	var optionDOM = new Element('option');
	optionDOM.set('value', 'E');
	if (par_type=='E') optionDOM.set('selected','selected');
	optionDOM.inject(selector);
	
	optionDOM = new Element('option');
	optionDOM.set('value', 'S');
	optionDOM.appendText(LBL_STRING);
	if (par_type =='S') optionDOM.set('selected','selected');
	optionDOM.inject(selector);
	
	optionDOM = new Element('option');
	optionDOM.set('value', 'N');
	optionDOM.appendText(LBL_NUMERIC);
	if (par_type =='N') optionDOM.set('selected','selected');
	optionDOM.inject(selector);
	
	optionDOM = new Element('option');
	optionDOM.set('value', 'D');
	optionDOM.appendText(LBL_FECHA);
	if (par_type =='D') optionDOM.set('selected','selected');
	optionDOM.inject(selector);
	
	optionDOM = new Element('option');
	optionDOM.set('value', 'I');
	optionDOM.appendText(LBL_INTEGER);
	if (par_type =='I') optionDOM.set('selected','selected');
	optionDOM.inject(selector);
	
	selector.inject(div);
	div.inject(oTd2);
		
	//////// VALOR POR DEFECTO SELECT
	div = new Element('div', {styles: {width: tdWidths[3], overflow: 'hidden', 'white-space': 'pre','text-align':'center'}});

	//div = new Element('div', {styles: {width: tdWidths[2], overflow: 'hidden', 'white-space': 'pre','text-align':'center'}});
	var tdWidth = 180;
	selector = new Element('select',{
		name: 'par_def_sel_value', 
		title: LBL_SEL_DEF_VALUE
	}).setStyle('width', tdWidth).addEvent('change', changeDefValueSel);
	
	if (par_def_sel != REP_DEF_VALUE_TYPE_FIXED && par_def_sel != REP_DEF_VALUE_TYPE_USER_ID && par_def_sel != REP_DEF_VALUE_TYPE_USER_NAME 
			&& par_def_sel != REP_DEF_VALUE_TYPE_ENV_ID && par_def_sel != REP_DEF_VALUE_TYPE_ENV_NAME) par_def_sel = REP_DEF_VALUE_TYPE_VARIABLE;
	
	var optionDOM = new Element('option');
	optionDOM.set('value',REP_DEF_VALUE_TYPE_VARIABLE);
	if (par_def_sel == "" || par_def_sel == REP_DEF_VALUE_TYPE_VARIABLE) optionDOM.set('selected','selected');
	optionDOM.inject(selector);
	
	optionDOM = new Element('option');
	optionDOM.set('value', REP_DEF_VALUE_TYPE_FIXED);
	optionDOM.appendText(LBL_ENT_DEF_VALUE);
	if (par_def_sel == REP_DEF_VALUE_TYPE_FIXED) optionDOM.set('selected','selected');
	optionDOM.inject(selector);
	
	optionDOM = new Element('option');
	optionDOM.set('value', REP_DEF_VALUE_TYPE_USER_ID);
	optionDOM.appendText(LBL_USER_ID);
	if (par_def_sel == REP_DEF_VALUE_TYPE_USER_ID) optionDOM.set('selected','selected');
	optionDOM.inject(selector);
	
	optionDOM = new Element('option');
	optionDOM.set('value', REP_DEF_VALUE_TYPE_USER_NAME);
	optionDOM.appendText(LBL_USER_NAME);
	if (par_def_sel == REP_DEF_VALUE_TYPE_USER_NAME) optionDOM.set('selected','selected');
	optionDOM.inject(selector);
	
	optionDOM = new Element('option');
	optionDOM.set('value', REP_DEF_VALUE_TYPE_ENV_ID);
	optionDOM.appendText(LBL_ENV_ID);
	if (par_def_sel == REP_DEF_VALUE_TYPE_ENV_ID) optionDOM.set('selected','selected');
	optionDOM.inject(selector);
	
	optionDOM = new Element('option');
	optionDOM.set('value', REP_DEF_VALUE_TYPE_ENV_NAME);
	optionDOM.appendText(LBL_ENV_NAME);
	if (par_def_sel == REP_DEF_VALUE_TYPE_ENV_NAME) optionDOM.set('selected','selected');
	optionDOM.inject(selector);
	
	selector.inject(div);
	div.inject(oTd3).setStyle('display', 'inline-block');
	
/////// VALOR POR DEFECTO
	var input = new Element('input',{type:'text', name:'par_default_value'});
	input.set('value', par_def_val);
	input.setStyles({
		width: Number.from(tdWidths[3]) - 5 - 190,
		marginLeft: 5
	});
	input.inject(div);
	if (par_def_sel == "" || par_def_sel == REP_DEF_VALUE_TYPE_VARIABLE) input.set('disabled','disabled');
	
	div.inject(oTd3).setStyle('display', 'inline-block');

	//Requerido
	div = new Element('div', {styles: {width: tdWidths[4], overflow: 'hidden', 'white-space': 'pre','text-align':'center'}});
	input = new Element('input',{type:'checkbox', name:'par_req', checked:par_req == "1"}).addEvent('click', setRequired);		
	if (par_def_sel != REP_DEF_VALUE_TYPE_VARIABLE) {
		input.set('disabled', 'disabled');
	}
	input.inject(div);
	input = new Element('input', {
		type: 'hidden',
		name: 'par_req_hid'
	}).set('value', par_req != undefined ? par_req : '0').setStyle('display', 'none').inject(div);
	div.inject(oTd4);
	
	var oTr = new Element("TR");
	
	oTd0.inject(oTr);
	oTd1.inject(oTr);
	oTd2.inject(oTr);
	oTd3.inject(oTr);
	oTd4.inject(oTr);
	
	oTr.addClass("selectableTR");
	oTr.getRowId = function () { return this.getAttribute("rowId"); };
	oTr.setRowId = function (a) { this.set("rowId",a); };
	oTr.set("rowId", $('gridParams').rows.length);
	
	oTr.addEvent("click",function(e){myToggle(this)}); 
	
	if($('gridParams').rows.length%2==0){
		oTr.addClass("trOdd");
	}
	
	oTr.inject($('gridParams'));	
	
	initAdminFieldOnChangeHighlight(false, false, false, oTr);
	
//	var rowIndx = oTr.rowIndex - 1;
//	input.set('value',rowIndx);
	
	//Habilitaci�n o deshabilitacion de objetos seg�n tipo de valor seleccionado
	
//	if (par_def_sel=="" || par_def_sel==REP_DEF_VALUE_TYPE_VARIABLE){ //En la creaci�n o esta seleccionado la opcion nula
//		eleDefVal.set('disabled', 'true');
//	} else if (par_def_sel==REP_DEF_VALUE_TYPE_FIXED){ //Ingrese un valor por defecto
//		//eleType.set('disabled','true');
//		eleDefVal.erase('disabled');
//		eleReq.set('disabled','true');
//	} else { //Las demas opciones
//		eleType.set('disabled','true');
//		eleDefVal.set('disabled','true');
//		eleReq.set('disabled','true');
//	}
}

function setRequired(e) {
	var req_checkbox_hid = e.target.getNext('input');
	if (e.target.checked) {
		req_checkbox_hid.set('value', 1);
	}else {
		req_checkbox_hid.set('value', 0);
	}
		
}

function changeDefValueSel(e){
	
	var def_value_select = e.target;
	var type_select = e.target.getParent('td').getPrevious('td').getElement('select');
	var def_value_input = e.target.getNext('input');
	var inputs = e.target.getParent('td').getNext('td').getElements('input');
	var req_checkbox = inputs[0];
	var req_checkbox_hid = inputs[1];
	
	if (def_value_select.value==REP_DEF_VALUE_TYPE_VARIABLE){
		type_select.erase('disabled');//Habilitamos combo para seleccionar tipo
		//type_select.set('value','E');
		def_value_input.set('disabled','true'); //Deshabilitamos input para ingresar valor por defecto
		req_checkbox.erase('disabled');//Habilitamos checkbox
	}else if (def_value_select.value==REP_DEF_VALUE_TYPE_FIXED){ //Si selecciono ingresar valor por defecto
		def_value_input.erase('disabled'); //habilitamos input para ingresar valor por defecto
		type_select.erase('disabled');
		//type_select.set('value','E');
		req_checkbox.erase('checked');
		req_checkbox.set('disabled','true'); //Deshabilitamos checkbox
	}else {
		def_value_input.set('value','');
		def_value_input.set('disabled','true'); //Deshabilitamos input para ingresar valor por defecto
		//type_select.set('value','E');
		type_select.set('disabled','true');
		req_checkbox.erase('checked');
		req_checkbox.set('disabled','true'); //Deshabilitamos checkbox
		req_checkbox_hid.set('value', 0);
	}
}

//btn: Eliminar parametro
function btnDelParam_click() {
	var selected = new Array(getSelectedRows($('gridParams'))[0]);
	deleteRowsFromGrid(selected,'gridParams');
}	

function myToggle(oTr){
	if (oTr.getParent().selectOnlyOne) {
		var parent = oTr.getParent();
		if (parent.lastSelected) parent.lastSelected.toggleClass("selectedTR");
		parent.lastSelected = oTr;
	}
	oTr.toggleClass("selectedTR"); 
}

//Metodo generico para borrar las filas seleccionadas de una grilla
function deleteRowsFromGrid(selection,tblName) {
	var table = $(tblName);
	for (var i=0;i<selection.length;i++){
		selection[i].dispose();	
	}
	
	for (var i=0;i<table.rows.length;i++){
		table.rows[i].setRowId(i);
		if (i%2==0){
			table.rows[i].addClass("trOdd");
		}else{
			table.rows[i].removeClass("trOdd");
		}
	}
}

function prmProcessPoolsModalReturn(ret) {
	ret.each(function(e){
		var poolName = e.getRowContent()[0];
		var poolId = e.getRowId();
		
		addPermissionToContainer(poolName, poolId);
	});
}

function addPermissionToContainer(poolName, poolId, perms) {
	//var content = addActionElement($('prmPoolContainter'),poolName, poolId, "hidPerPoolId");
	var content;
	
	if(poolId == -1)
		content = addActionElementAdmin($('prmPoolContainter'), poolName, poolId, "false", false, "hidPerPoolId");
	else
		content = addActionElement($('prmPoolContainter'),poolName, poolId, "hidPerPoolId");
	
	
	if (content == null) return;
	
	var noPerm = "";
	var readPerm = "";
	var writePerm = "";
	
	if (perms=="R") {
		readPerm = "selected";
	} else if (perms=="RW") {
		writePerm = "selected";
	} else {
		noPerm = "selected";
	}
	
	var ele2 = new Element('select', {
		name:'selPerPoolPermRW', 
		id: 'selPerPoolPermRW',		
		html: '<option value="0"' + noPerm + '>' + LBL_ACCESS_DENIED + '</option><option value="1"' + readPerm + '>' + 'Leer' + '</option><option value="2"' + writePerm + '>' + 'Leer y modificar' + '</option>'
	}).setStyles({'width': 150, 'margin-left': 10}).addEvent('click', function (e) {
		e.stopPropagation();
	});
	ele2.addClass("validate['~validatePerms']");
	ele2.inject(content);
	
	$('frmData').formChecker.register(ele2,1);
		
}

function validateFile(el){
	var fileName = $('fileName').get('text');
	if (fileName == "") {
		el.errors.push(MSG_MUST_HAVE_FILE);
	    return false;
	}
	return true;
}

function loadPermissions() {
	var request = new Request({
		method: 'post',
		url: CONTEXT + URL_REQUEST_AJAX + '?action=loadRepPermissions&isAjax=true' + TAB_ID_REQUEST,
		onRequest: function() { },
		onComplete: function(resText, resXml) { 
			processXMLPerms(resXml); 
			
			initAdminModalHandlerOnChangeHighlight($('prmPoolContainter'));
		}
	}).send();
}

function processXMLPerms(ajaxCallXml){
	if (ajaxCallXml != null) {
		var atts = ajaxCallXml.getElementsByTagName("perms");
		if (atts != null && atts.length > 0 && atts.item(0) != null) {
			atts = atts.item(0).getElementsByTagName("perm");
			for(var i = 0; i < atts.length; i++) {
				var att = atts.item(i);
				
				var pool_id = att.getAttribute("pool_id");
				var pool_name = att.getAttribute("pool_name");
				var perms = att.getAttribute("perms");
			
				addPermissionToContainer(pool_name, pool_id, perms);
			}
		}
	}
}

function loadParams() {
	var request = new Request({
		method: 'post',
		url: CONTEXT + URL_REQUEST_AJAX + '?action=loadRepParams&isAjax=true' + TAB_ID_REQUEST,
		onRequest: function() { },
		onComplete: function(resText, resXml) { processXMLParams(resXml); }
	}).send();
}

function processXMLParams(ajaxCallXml){
	if (ajaxCallXml != null) {
		var atts = ajaxCallXml.getElementsByTagName("params");
		if (atts != null && atts.length > 0 && atts.item(0) != null) {
			atts = atts.item(0).getElementsByTagName("param");
			for(var i = 0; i < atts.length; i++) {
				var att = atts.item(i);
				
				var par_name = att.getAttribute("par_name");
				var par_desc = att.getAttribute("par_desc");
				var par_type = att.getAttribute("par_type");
				var par_def_val = att.getAttribute("par_def_val");
				var par_def_sel = att.getAttribute("par_def_sel");
				var par_req = att.getAttribute("par_req");
			
				fncAddParam(par_name, par_desc, par_type, par_def_val, par_def_sel, par_req);
			}
			
			var table = $('gridParams');
			var footer = table.getParent('.fieldGroup').getElement('.listAddDelRight');
			var notification = new Element('div', {id : 'editionNot'}); 
			footer.grab(notification, "top");
			
			initAdminModalHandlerOnChangeHighlight(table, true, false, notification);
		}
	}
}

//Validaci�n de permisos
function validatePerms(el){ //Al menos un usuario debe tener permiso de modificacion en el reporte
	var container = $('prmPoolContainter');
	
	for (var i = 0; i < container.getElementsByTagName("select").length; i=i+1){
		var sel = container.getElementsByTagName("select")[i];
		if (sel.value > 1) return true;
	}

	el.errors.push(MSG_REP_PRIV_ERRORS);
    return false;

}

//Validaci�n de parametros
function validateParamName(el){ 
	if (el.get('value') != '') return true;

	el.errors.push(MSG_REP_PARAM_NAME_REQ);
    return false;
}

function onChangeCmbSrc(cmbSrc){
	//Pentaho
	var fileName = $('fileName');
	var selConn = $('selConn');
	var repQryName = $('repQryName');
	var repQuery = $('repQuery');
	var divSelConn = $('divSelConn');
	var divQryNom = $('divQryNom');
	var divQuery = $('divQuery').getParent(); //div fieldGroup
	var divParameters = $('divParameters');
	var divFileName = $('divFileName');
	var btnUpdateCons = $('btnUpdateCons');
	var optionDownload = $('optionDownload').getParent();
	
	//BusClass
	var repBusClaExec = $('repBusClaExec');
	var divRepBusClaExec = $('divRepBusClaExec');
		
	var frmData = $('frmData');
	
	if (cmbSrc.value == SRC_PENTAHO){
		frmData.formChecker.register(selConn);
		frmData.formChecker.register(repQryName);
		frmData.formChecker.register(repQuery);
		frmData.formChecker.register(fileName);
		
		repBusClaExec.value = '';
		frmData.formChecker.dispose(repBusClaExec);
		
		divSelConn.setStyle("display","");
		divQryNom.setStyle("display","");
		divQuery.setStyle("display","");
		divParameters.setStyle("display","");
		divFileName.setStyle("display","");
		btnUpdateCons.setStyle("display","");
		optionDownload.setStyle("display","");
		
		divRepBusClaExec.setStyle("display","none");
		
	} else if (cmbSrc.value == SRC_BUS_CLASS){
		fileName.value = '';
		frmData.formChecker.dispose(fileName);
		selConn.selectedIndex = 0;
		frmData.formChecker.dispose(selConn);
		repQryName.value = '';
		frmData.formChecker.dispose(repQryName);
		repQuery.value = '';
		frmData.formChecker.dispose(repQuery);
		
		frmData.formChecker.register(repBusClaExec);		
		
		divSelConn.setStyle("display","none");
		divQryNom.setStyle("display","none");
		divQuery.setStyle("display","none");
		divParameters.setStyle("display","none");
		divFileName.setStyle("display","none");
		btnUpdateCons.setStyle("display","none");
		optionDownload.setStyle("display","none");
		
		divRepBusClaExec.setStyle("display","");
	}
}

function checkIfExecAlreadyExist(classExec){
	var request = new Request({
		method: 'post',
		url: CONTEXT + URL_REQUEST_AJAX + '?action=checkIfExecExist&isAjax=true&busClaExec=' + classExec + TAB_ID_REQUEST,
		onRequest: function() { },
		onComplete: function(resText, resXml) { modalProcessXml(resXml); }
	}).send();
}

function processCheckIfExecAlreadyExist(showConf){
	SYS_PANELS.closeAll();
	if (showConf){
		showConfirm(MSG_EXEC_EXIST, GNR_TIT_WARNING, 
				function(ret){
					if (ret){ //confirma eliminar
						upload(true);
					} else {
						SYS_PANELS.closeAll();
					}
				}
			, 'modalWarning');
	} else {
		upload(true);
	}
}

function processImg(ret){
	if (ret != null){
		$('changeImg').style.backgroundImage = "url('"+ret.path+"')";
		$('changeImg').fireEvent('change');
		$('txtImgPath').value=ret.id;
	}
}