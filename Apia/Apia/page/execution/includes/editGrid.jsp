<%@page import="biz.statum.apia.web.bean.execution.TaskBean"%><%@page import="biz.statum.apia.web.action.execution.TaskAction"%><%@page import="biz.statum.apia.web.bean.execution.EntInstanceListBean"%><%@page import="biz.statum.apia.web.action.execution.EntInstanceListAction"%><%@page import="biz.statum.apia.web.bean.execution.EntInstanceBean"%><%@include file="../../includes/startInc.jsp" %><html lang="<%=biz.statum.apia.web.bean.BasicBeanStatic.getUserDataStatic(request).getLangCode()%>"><head><%if("true".equals(request.getParameter("portalFormMode"))){
		request.setAttribute("mode", "portal");
	%><link href="<system:util show="context" />/css/base/portalForm.css" rel="stylesheet" type="text/css"><%} %><%@include file="../../includes/headInclude.jsp" %><!-- documents --><script type="text/javascript" src="<system:util show="context" />/page/modals/documents.js"></script><script type="text/javascript" src="<system:util show="context" />/page/generic/documents.js"></script><!-- FOLDERS --><script type="text/javascript" src="<system:util show="context" />/page/modals/foldersDocuments.js"></script><script type="text/javascript" src="<system:util show="context" />/page/includes/foldersDisplay.js"></script><script type="text/javascript" src="<system:util show="context" />/page/modals/pools.js"></script><script type="text/javascript" src="<system:util show="context" />/page/modals/users.js"></script><script type="text/javascript" src="<system:util show="context" />/page/includes/navButtons.js"></script><script type="text/javascript" src="<system:util show="context" />/js/synchronize-fields.js"></script><script type="text/javascript" src="<system:util show="context" />/js/masked-input.js"></script><script type="text/javascript" src="<system:util show="context" />/page/execution/scripts/classes/form.js"></script><script type="text/javascript" src="<system:util show="context" />/page/execution/scripts/classes/field.js"></script><script type="text/javascript" src="<system:util show="context" />/page/execution/scripts/classes/fieldTypes/input.js"></script><script type="text/javascript" src="<system:util show="context" />/page/execution/scripts/classes/fieldTypes/select.js"></script><script type="text/javascript" src="<system:util show="context" />/page/execution/scripts/classes/fieldTypes/area.js"></script><script type="text/javascript" src="<system:util show="context" />/page/execution/scripts/classes/fieldTypes/button.js"></script><script type="text/javascript" src="<system:util show="context" />/page/execution/scripts/classes/fieldTypes/check.js"></script><script type="text/javascript" src="<system:util show="context" />/page/execution/scripts/classes/fieldTypes/editor.js"></script><script type="text/javascript" src="<system:util show="context" />/page/execution/scripts/classes/fieldTypes/grid.js"></script><script type="text/javascript" src="<system:util show="context" />/page/execution/scripts/classes/fieldTypes/hidden.js"></script><script type="text/javascript" src="<system:util show="context" />/page/execution/scripts/classes/fieldTypes/href.js"></script><script type="text/javascript" src="<system:util show="context" />/page/execution/scripts/classes/fieldTypes/image.js"></script><script type="text/javascript" src="<system:util show="context" />/page/execution/scripts/classes/fieldTypes/label.js"></script><script type="text/javascript" src="<system:util show="context" />/page/execution/scripts/classes/fieldTypes/multiple.js"></script><script type="text/javascript" src="<system:util show="context" />/page/execution/scripts/classes/fieldTypes/password.js"></script><script type="text/javascript" src="<system:util show="context" />/page/execution/scripts/classes/fieldTypes/radio.js"></script><script type="text/javascript" src="<system:util show="context" />/page/execution/scripts/classes/fieldTypes/title.js"></script><script type="text/javascript" src="<system:util show="context" />/page/execution/scripts/classes/fieldTypes/fileinput.js"></script><script type="text/javascript" src="<system:util show="context" />/page/execution/scripts/classes/fieldTypes/tree.js"></script><script type="text/javascript" src="<system:util show="context" />/page/execution/scripts/classes/fieldTypes/captcha.js"></script><script type="text/javascript" src="<system:util show="context" />/js/contextmenu.js"></script><script type="text/javascript" src="<system:util show="context" />/page/execution/scripts/API/apiaFunctions.js"></script><script type="text/javascript" src="<system:util show="context" />/page/execution/scripts/API/apiaField.js"></script><!-- DRAG AND DROP BEHAVIOUR --><script type="text/javascript" src="<system:util show="context" />/js/dragAndDrop/Form.MultipleFileInput.js"></script><script type="text/javascript" src="<system:util show="context" />/js/dragAndDrop/Form.Upload.js"></script><script type="text/javascript" src="<system:util show="context" />/js/dragAndDrop/Request.File.js"></script><script type="text/javascript">
	
	var executionEntForms = new Array();
	var executionProForms = new Array();
	
	var currentClassE = "";
	var currentClassP = "";
	
	var editionMode = true;
	
	function initPage() {
		
		$('frmData').formChecker = new FormCheck(
			'frmData', {
				submit:false,
				display : {
					keepFocusOnError : 1,
					tipsPosition: 'left',
					tipsOffsetY: -12,
					tipsOffsetX: -10
				}
			}
		);
		
		//disparar el cargado de los formularios
		$$('div.formContainer').each(function (frm) {
			
			//parse each form...
			var form = new Form(frm);
			
			 //Se agregan antes de ser procesados para que lo encuentre la API
			if(form.frmType == "E")
				executionEntForms.push(form);
			else
				executionProForms.push(form);
					
			form.parseXML(null);
		});
		
		checkErrors();
		
		<% if("E".equals(request.getParameter("frmParent"))) { %>
			try {
				frmOnloadE();
			} catch (e) {
				if(currentClassE != "") {
// 					showMessage("Error in business class '" + currentClassE + "', contact system administrator");
					showMessage(Generic.formatMsg(ERR_EXEC_BUS_CLASS, currentClassE));
				}
			}
		<% } else { %>
			try{
				frmOnloadP();
			} catch(e){
				if(currentClassP!=""){
// 					showMessage("Error in business class " + currentClassP + "', contact system administrator");
					showMessage(Generic.formatMsg(ERR_EXEC_BUS_CLASS, currentClassP));
				}
			}
		<% } %>
		
		$('frmData').addEvent('submit', function(e) {
			$(window.frameElement).set('data-scrollTo', window.scrollY);
			this.submit();
		});
		
		initDocumentMdlPage();
	}
	
	function getModalReturnValue() {
		if($('frmData').formChecker.isFormValid())
			return true;
		
		return;
	}
	
	function checkErrors() {
		
		var xmlDoc;
		var execErrors = $('execErrors');
		if (window.DOMParser) {
			parser = new DOMParser();
			xmlDoc = parser.parseFromString(new String(execErrors.value),"text/xml");
		} else {
			// Internet Explorer
			xmlDoc = new ActiveXObject("Microsoft.XMLDOM");
			xmlDoc.async = false;
			xmlDoc.loadXML(new String(execErrors.value)); 
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
		
		if(xml && xml.childNodes) {
			for(var i = 0; i < xml.childNodes.length; i++) {
				if (xml.childNodes[i].tagName == "sysExceptions") {
					processXmlExceptions(xml.childNodes[i], true);
					hasErrors = true;
				}
				
				if (xml.childNodes[i].tagName == "sysMessages") {
					processXmlMessages(xml.childNodes[i], true);
					hasErrors = true;
				}
			}
		}
		
		execErrors.value  = "<?xml version='1.0' encoding='iso-8859-1'?><data onClose='' />";
		
		return hasErrors;
	}
	
	<% if("true".equals(request.getParameter("isTask"))) { %>
		var URL_REQUEST_AJAX = '/apia.execution.TaskAction.run';
	<% } else { %>
		var URL_REQUEST_AJAX = '/apia.execution.EntInstanceListAction.run';
	<% } %>
	
	var ADDITIONAL_INFO_IN_TABLE_DATA = false;
	var signedOK = "false";
	var currentTab = <%=request.getParameter("currentTab") != null ? request.getParameter("currentTab") : "-1"%>;
	var currentStep = 1;
	var MSG_REQ_SIGNATURE_FORM = '<system:label show="text" label="lblReqSigForm" forScript="true" />';
	var EXTERNAL_ACCESS = "<%=(uData.isExternalMode() || uData.isFromMinisite())%>";
	
	var BTN_FILE_UPLOAD_LBL = '<system:label show="text" label="prpUpload" forHtml="true" forScript="true" />';
	var BTN_FILE_DOWNLOAD_LBL = '<system:label show="text" label="prpDownload" forHtml="true" forScript="true" />';
	var BTN_FILE_INFO_LBL = '<system:label show="text" label="lblInfo" forHtml="true" forScript="true" />';
	var BTN_FILE_LOCK_LBL = '<system:label show="text" label="prpLock" forHtml="true" forScript="true" />';
	var BTN_FILE_SIGN_LBL = '<system:label show="text" label="prpSign" forHtml="true" forScript="true" />';
	var BTN_FILE_VERIFY_LBL = '<system:label show="text" label="prpVerify" forHtml="true" forScript="true" />';
	var BTN_FILE_ERASE_LBL = '<system:label show="text" label="prpErase" forHtml="true" forScript="true" />';
	var DROP_FILES_HERE_LBL	= '<system:label show="text" label="lblDropFilesHere" forScript="true" />';
	var BTN_FILE_DROP_LBL	= '<system:label show="text" label="btnFileDrop" forScript="true" />';
	var MSG_CONFIG_DELETE_DOCUMENT_FILE_INPUT        = '<system:label show="text" label="msgConfDelDoc" forScript="true" />';
	var MSG_DEL_FILE_TRANS = "<system:label show='text' label='msgDelFileTrans' forHtml='true'/>";
	var TIT_DEL_FILE = "<system:label show='text' label='titDelFile' forHtml='true'/>";
	
	var TIT_SING_MODAL_LBL = '<system:label show="text" label="titFormsToSign" forHtml="true"/>';
	
	var ERR_EXEC_BUS_CLASS 	= "<system:label show='text' label='errExecBusClass' forHtml='true'/>";
	var LBL_ERROR 			= "<system:label show='text' label='lblError' forHtml='true'/>";
	var MSG_VAL_NOT_FOUND 	= "<system:label show='text' label='msgValNotFound' forHtml='true'/>";
	var ERR_EXEC_BINDING 	= "<system:label show='text' label='errExecBinding' forHtml='true'/>";
	var LBL_EDIT 			= '<system:label show="text" label="lblEdit" forScript="true" forHtml="true"/>';
	
	<% if (!"true".equals(request.getAttribute("isMonitor"))) { %>
		var isMonitor = false;
		var IN_MONITOR = false;
	<% } else { %>
		var isMonitor = true;
		var IN_MONITOR = true;
	<% } %>
	
	
	
	
	var indexError = 0;
	var firstTime= true;
	var portalFormTemplate = true;
	var frmCheckerDisplay = {
		addClassErrorToField : 1,
		errorsLocation : 3,	
		listErrorsAtTop : true, 
		indicateErrors : 2, 
		scrollToFirst : false, 
		showErrors: 0 
	}
	var oldErrorList = [];
	var removeBoxError = true; //marca si hay que borrar el modal con que contiene "siguiente" y "anterior" 

	//modal con "siguiente" y "anterior" error
	var errorModal = new Element('div').set('id','box-error').set('class', 'box-error').set('html','<span class="box-error-title">Error 2 de 2</span>'+
			'<ul><li><a style="cursor: pointer;" class="floatIzq" href="#" onclick="showError(this,\'prev\');return false;">&lt;&lt; ' + BTN_ANTERIOR +'</a>'+
			'</li><li><a style="cursor: pointer;" class="floatDer" href="#" onclick="showError(this,\'next\');return false;">'+ BTN_SIGUIENTE + ' &gt;&gt;</a>'+
			'</li></ul>');

	function setErrorModalMsg(modal,msg){
		var span = modal.getElementsByTagName("span");
		span = span[0].innerHTML = msg;
	}

	window.addEvent('load', function() {	
		//re design captcha
		$$('div.captcha-container').each(function (item){
			item.getParent().getParent().set('style','height: 100px;');
			$$(item.getParent().getElementsByTagName('input')).each(function (itemInput){
				itemInput.addClass('captchaInput');
				});
		});
		$$('div.wasTr div.wasTd div.exec_field.monitor_field').each(function (captcha){
			captcha.set('style', 'height: 130px;');		
		}); 
		
		//render radio buttons
		var list = null;
		if(divsInsteadOfTable){
			list = $$(".wasTd>div>label")
		} else{
			list = $$("td>div>label")
		}
		list.each(function(item){
			if (item.hasClass('optionLabel')) 
				item.set('style','color:black;');
		});

		//render Documents	
		$$(".asLabelFileinput").each(function(item){
			var parent = item.getParent();
			parent.getParent().set('style', 'padding-bottom: 20px!important');
			var divWasTd = parent;
			while (!divWasTd.getParent().hasClass('wasTr')){
				divWasTd = divWasTd.getParent();
			}
			if (!divWasTd.hasClass('wasTd')){
				divWasTd.addClass('wasTd');
			}
		});
		$$('.document').filter(function(item){
			return !item.hasClass('grid_document')
		}).each(function(item) {
			item.addClass('no_grid_document');	
		});
		
		//render textAreas
		var listOfTextArea = $$(document.getElementsByTagName('textarea'));
		for(var iter = 0; iter < listOfTextArea.length; iter++){
			var div = listOfTextArea[iter].getParent();
			var td = listOfTextArea[iter].getParent().getParent();
			if ((div != undefined) && (td != undefined) && (td.hasClass('wasTd') || td.get('tag')=='td') && (div.get('tag')=='div')){
				listOfTextArea[iter] = listOfTextArea[iter].set('style', 'width: 30%');
				var span = div.getElementsByTagName('span');
				span[0].set('style','vertical-align: top;');
				
			}
		}
		
		//prepare checkbox style
		var listOfCheckbox = $$("input[type=checkbox]");
		for (var iter = 0; iter < listOfCheckbox.length; iter++){
			if (listOfCheckbox[iter] !== undefined){
				var label = listOfCheckbox[iter].getParent();
				$$(label.getElementsByTagName('span')).set('class','asLabel');
			}
		}
		
		if(typeof divsInsteadOfTable == 'undefined'){
			//clean and render forms
			var forms = $$('div.formContainer');
			for(let i = 0; i < forms.length; i++){
				var table = forms[i].getElementsByTagName('table');
		
				table = table[0].getChildren();
				if (table != null){
					removeFormColGroup(table);
					removeFormTHead(table);
					removeTdDivStyle(table);
				}
			}
		}
	});

	function removeFormColGroup(table){	
		var colgroup = table[0].getChildren();
		for(let i = 1; i < Array.from(colgroup).length; i++){
			colgroup[i].setAttribute("style","width: 0;");
		}
		colgroup[0].setAttribute("style","width: 90%;");
	}
	function removeFormTHead(table){
		var thead = table[1].getChildren();
		var tr = thead[0].getChildren();
		for(let i = 1; i < Array.from(tr).length; i++){
			tr[i].setAttribute("style","width: 0;");
		}
		tr[0].setAttribute("style","width: 90%;");
	}
	function removeTdDivStyle(table){
		var divs = table[2].getElementsByTagName("div");
		for (let i = 0; i < divs.length; i++ ){
			divs[i].style.removeProperty('width');
		}
	}


	function removeErrors(){
		var x = document.getElementsByClassName("fc-field-error");
		for (i = 0; i < x.length; i++) {
			
			var y = document.getElementsByClassName("err-num-" + i);
			for (j = 0; j < y.length; j++) {			
				y[j].removeClass("err-num-" + i);					 	
			}
							 	
		}	
		
		var x = document.getElementsByClassName("campo-error-perso");
		for (i = 0; i < x.length; i++) {
			x[i].removeClass("campo-error-perso");					 									 	
		}
		
	}

	//ir al error correspondiente luego de hacer click en la lista de errores en la 
	//parte superior de la pantalla
	function goToError(element){
		// create and set message
		var errorList = $('errorlist').getChildren();//error List as array
		var cantError = errorList.length - 1;
		var msg = insertParamsToTag(ERROR_NUMBER,[element.get('data-errornumber'), cantError]);
		setErrorModalMsg(errorModal,msg);
		
		var error = $$('.wasTd[data-ordernumber='+element.get('data-ordernumber') + '], td[data-ordernumber='+element.get('data-ordernumber') + ']');
		if(typeof divsInsteadOfTable === 'undefined'){
			error = $$('td[data-ordernumber='+element.get('data-ordernumber') + ']');
		}
		error = error[0];
		new Fx.Scroll(window).toElementCenter(error);
	//  injectar el modal que tiene "siguiente" y "anterior" errores
		errorModal.inject(error);
		removeBoxError = false;
		$('box-error').set('style', 'display: block;')
	}

	//mError = modalError
	function showError(mError, nextPrev){
		if($('errorlist')){
			var tdCurrentError = mError.getParent();
			while (!tdCurrentError.hasClass('wasTd') && tdCurrentError.get('tag') != ('td')){
				tdCurrentError = tdCurrentError.getParent();
			};
			
			//error List as array
			var errorList = $('errorlist').getChildren();
			
			//tail of errorList
			errorList = errorList.slice(1);
			var cantError = errorList.length;
			
			var currentErrorAtList = errorList.filter(function (errorItem){
				return (tdCurrentError.get('data-ordernumber') === errorItem.get('data-ordernumber'))
			});
			if (currentErrorAtList[0] == undefined){
				currentErrorAtList[0] = errorList[0];
			}
			var currentErrorAtListInt = parseInt(currentErrorAtList[0].get('data-errornumber'));
		
			if(nextPrev == "next"){
				currentErrorAtListInt++;
			}
			else currentErrorAtListInt--;
			
			//get new index
			//currentErrorAtList is in [1..cantError] newIndex is in [0..cantError-1]
			var newIndex = (currentErrorAtListInt - 1); 
			newIndex = (newIndex + cantError);		
			newIndex = newIndex % (cantError); 
			
			// go back to currentErrorAtList
			currentErrorAtListInt = newIndex+1;
			
			var errorToShow = errorList.filter(function (errorItem){ 
				var errorItemNumber = (parseInt(errorItem.get('data-errornumber')));
				return (errorItemNumber == currentErrorAtListInt); 
				});
			goToError(errorToShow[0]);
		} else {
			$('box-error').set('style', 'display: none;');
		}
	}

	function sortElementAtTopListError(){
		
		var errorNumber = 0;
		
		if($('errorlist')!=null){
			$('errorlist')
			.getChildren()
			.filter(function (item){
				return item.get('data-errorNumber')!= null			
			})
			.sort(function(a,b) {//custom compare function
				var aOrderNumber = parseInt(a.get('data-ordernumber'));
				var bOrderNumber = parseInt(b.get('data-ordernumber'));
				if (aOrderNumber > bOrderNumber) 
					return 1;
				else 
					return -1;
				})
			.each(function (item) {
				item.set('data-errorNumber', ++errorNumber);
				var errorDescription = item.getChildren()
					.filter(function (item){
						return item.hasClass("leftErrorSpan");	
					})
					.get('html')[0];
				
				errorDescription =  errorDescription.substring(errorDescription.indexOf("."));
				errorDescription = errorNumber + errorDescription;
				item.getChildren()
					.filter(function (item){
						return item.hasClass("leftErrorSpan")
						
					})
					.set('html', errorDescription);
		
				item.inject($('errorlist'));
				});
		}
	}

	//Este método debe ser ejecutado luego de que se cierre un modal en el que se 
	//inicialicen los errores, con el objetivo de volver a dibujar los errores
	function onClosePortalFormModal(){
		frmData.formChecker.isFormValid();
		errorModal.set('style','display: none;');
	}
	var divsInsteadOfTable = true;
	var ERROR_NUMBER = '<system:label show="text" label="lblErrorNum"/>';			
	var BTN_ANTERIOR = '<system:label show="text" label="btnAnt"/>';
	var BTN_SIGUIENTE = '<system:label show="text" label="btnSig"/>';
	</script><%
	String strScriptLoad = "";
	
	biz.statum.apia.web.bean.BasicBean bBean = null;
	boolean isTaskMode = "true".equals(request.getParameter("isTask"));
	if(!isTaskMode) {
		bBean = biz.statum.apia.web.action.BasicAction.staticRetrieveBean(request, response, biz.statum.apia.web.action.BasicAction.BEAN_ADMIN_NAME);
	}else{
		bBean = biz.statum.apia.web.action.BasicAction.staticRetrieveBean(request, response, biz.statum.apia.web.action.BasicAction.BEAN_EXEC_NAME);
		if(bBean==null){
			bBean = biz.statum.apia.web.action.BasicAction.staticRetrieveBean(request, response, biz.statum.apia.web.action.BasicAction.BEAN_ADMIN_NAME);
		}
	}

	biz.statum.apia.web.bean.execution.ExecutionBean exeBean = null;

	if(bBean instanceof biz.statum.apia.web.bean.execution.EntInstanceListBean){
		exeBean = ((biz.statum.apia.web.bean.execution.EntInstanceListBean)bBean).getEntInstanceBean();
	} else if (bBean instanceof biz.statum.apia.web.bean.execution.TaskBean){
		exeBean = (biz.statum.apia.web.bean.execution.TaskBean)bBean;
	} else if (bBean instanceof biz.statum.apia.web.bean.monitor.ProcessesBean){
		if("E".equals(request.getParameter("frmParent"))) {
			exeBean = ((biz.statum.apia.web.bean.monitor.ProcessesBean)bBean).getEntInstanceBean();
		} else {
			exeBean = ((biz.statum.apia.web.bean.monitor.ProcessesBean)bBean).getProInstanceBean();
		}
	}

	biz.statum.apia.web.bean.execution.FormBean fBean = exeBean.getCurrentEditionBean();

	String divId = request.getParameter("frmParent") + "_" + fBean.getFormDefinition().getFrmId();
	String xml = fBean.getFullXMLforModal(request,response,Integer.parseInt(request.getParameter("index")));
	
	
	if(fBean.hasOnload && fBean.firstLoad)
		strScriptLoad +=  fBean.getOnLoadName() + ";\n";
	
	if(fBean.hasOnReload && !fBean.firstLoad)
		strScriptLoad +=  fBean.getOnReloadName() + ";\n";	
	
	fBean.firstLoad = false;
	
	String strScript = fBean.getScript();

	if(strScript == null)
		strScript="";
	
	StringBuffer strBuf = new StringBuffer(strScript);

	strBuf.append("\n<script language=\"javascript\" DEFER>\n");
	strBuf.append("\nvar saving = false;\n");
	if("E".equals(request.getParameter("frmParent"))) {
		strBuf.append("function frmOnloadE(){\n");
	} else {
		strBuf.append("function frmOnloadP(){\n");
	}
	strBuf.append(strScriptLoad);
	strBuf.append("}\n");
	strBuf.append("</script>\n");

	String strScriptEdit = strBuf.toString();
	if(strScriptEdit != null) {
		out.println(strScriptEdit);
	}
	%></head><body><div id="exec-blocker"></div><div class="body" id="bodyDiv"><form id="frmData" action="dummy" method="post"><input type="submit" disabled style="display:none"><div id="<%=divId%>" class="formContainer" data-xml="<%out.print(xml);%>"></div></form><div style="display:none" id="divDragDropForm"></div></div><div class="footer"></div><%@include file="../../modals/documents.jsp" %><%@include file="endInclude.jsp" %></body></html>