<%@page import="biz.statum.apia.web.bean.execution.EntInstanceBean"%><%@page import="biz.statum.apia.web.bean.execution.ExecutionBean"%><%@page import="biz.statum.apia.web.action.BasicAction"%><%@page import="biz.statum.apia.web.bean.BasicBean"%><%@page import="com.dogma.vo.LanguageVo"%><%@page import="com.st.util.labels.LabelManager"%><%@page import="com.dogma.vo.ProInstanceVo"%><%@include file="../../includes/startInc.jsp" %><html lang="<%=biz.statum.apia.web.bean.BasicBeanStatic.getUserDataStatic(request).getLangCode()%>"><head><%@include file="../../includes/headInclude.jsp" %><script type="text/javascript" src="<system:util show="context" />/page/monitor/entities/view.js"></script><script type="text/javascript" src="<system:util show="context" />/page/includes/navButtons.js"></script><script type="text/javascript" src="<system:util show="context" />/page/includes/campaigns.js"></script><!-- JS Objects --><script type="text/javascript" src="<system:util show="context" />/page/execution/scripts/classes/form.js"></script><script type="text/javascript" src="<system:util show="context" />/page/execution/scripts/classes/field.js"></script><script type="text/javascript" src="<system:util show="context" />/page/execution/scripts/classes/fieldTypes/input.js"></script><script type="text/javascript" src="<system:util show="context" />/page/execution/scripts/classes/fieldTypes/select.js"></script><script type="text/javascript" src="<system:util show="context" />/page/execution/scripts/classes/fieldTypes/area.js"></script><script type="text/javascript" src="<system:util show="context" />/page/execution/scripts/classes/fieldTypes/button.js"></script><script type="text/javascript" src="<system:util show="context" />/page/execution/scripts/classes/fieldTypes/check.js"></script><script type="text/javascript" src="<system:util show="context" />/page/execution/scripts/classes/fieldTypes/editor.js"></script><script type="text/javascript" src="<system:util show="context" />/page/execution/scripts/classes/fieldTypes/grid.js"></script><script type="text/javascript" src="<system:util show="context" />/page/execution/scripts/classes/fieldTypes/hidden.js"></script><script type="text/javascript" src="<system:util show="context" />/page/execution/scripts/classes/fieldTypes/href.js"></script><script type="text/javascript" src="<system:util show="context" />/page/execution/scripts/classes/fieldTypes/image.js"></script><script type="text/javascript" src="<system:util show="context" />/page/execution/scripts/classes/fieldTypes/label.js"></script><script type="text/javascript" src="<system:util show="context" />/page/execution/scripts/classes/fieldTypes/multiple.js"></script><script type="text/javascript" src="<system:util show="context" />/page/execution/scripts/classes/fieldTypes/password.js"></script><script type="text/javascript" src="<system:util show="context" />/page/execution/scripts/classes/fieldTypes/radio.js"></script><script type="text/javascript" src="<system:util show="context" />/page/execution/scripts/classes/fieldTypes/title.js"></script><script type="text/javascript" src="<system:util show="context" />/page/execution/scripts/classes/fieldTypes/fileinput.js"></script><script type="text/javascript" src="<system:util show="context" />/page/execution/scripts/classes/fieldTypes/tree.js"></script><script type="text/javascript" src="<system:util show="context" />/page/execution/scripts/classes/fieldTypes/captcha.js"></script><script type="text/javascript" src="<system:util show="context" />/js/contextmenu.js"></script><!-- API JS --><script type="text/javascript" src="<system:util show="context" />/page/execution/scripts/API/apiaFunctions.js"></script><script type="text/javascript" src="<system:util show="context" />/page/execution/scripts/API/apiaField.js"></script><!-- documents --><script type="text/javascript" src="<system:util show="context" />/page/modals/documents.js"></script><script type="text/javascript" src="<system:util show="context" />/page/generic/documents.js"></script><!-- FOLDERS --><script type="text/javascript" src="<system:util show="context" />/page/modals/foldersDocuments.js"></script><script type="text/javascript" src="<system:util show="context" />/page/includes/foldersDisplay.js"></script><%@include file="/page/includes/tinymce.editor.jsp" %><script type="text/javascript">
		var URL_REQUEST_AJAX = '/apia.monitor.EntitiesAction.run';
		var ADDITIONAL_INFO_IN_TABLE_DATA  = false;
		var URL_REQUEST_AJAX_MONITOR_TASKS = '/apia.monitor.ProcessesAction.run';
		var LABEL_MONITOR_PROCESS = '<system:label show="text" label="titMon" forScript="true" />';
		var LABEL_FILTER_ALL = '<system:label show="text" label="btnClearFilter" forScript="true" />';
		var BTN_FILE_UPLOAD_LBL = '<system:label show="text" label="prpUpload" forHtml="true" forScript="true" />';
		var BTN_FILE_DOWNLOAD_LBL = '<system:label show="text" label="prpDownload" forHtml="true" forScript="true" />';
		var BTN_FILE_INFO_LBL = '<system:label show="text" label="lblInfo" forHtml="true" forScript="true" />';
		var BTN_FILE_LOCK_LBL = '<system:label show="text" label="prpLock" forHtml="true" forScript="true" />';
		var BTN_FILE_SIGN_LBL = '<system:label show="text" label="prpSign" forHtml="true" forScript="true" />';
		var BTN_FILE_VERIFY_LBL = '<system:label show="text" label="prpVerify" forHtml="true" forScript="true" />';
		var BTN_FILE_ERASE_LBL = '<system:label show="text" label="prpErase" forHtml="true" forScript="true" />';
		var TIT_SING_MODAL_LBL = "<system:label show='text' label='titFormsToSign' forHtml='true'/>";
		var LBL_EDIT		= '<system:label show="text" label="lblEdit" forScript="true" forHtml="true"/>';
		var BTN_FILE_DROP_LBL	= '<system:label show="text" label="btnFileDrop" forScript="true" />';
		
		var isMonitor = true;
		var hideSignVerification = true;	
	</script><%
	
	BasicBean entBasicBean = BasicAction.staticRetrieveBean(request, response, BasicAction.BEAN_ADMIN_NAME);

	ExecutionBean aBean = null;

	if(entBasicBean instanceof biz.statum.apia.web.bean.execution.EntInstanceListBean){
		aBean = ((biz.statum.apia.web.bean.execution.EntInstanceListBean)entBasicBean).getEntInstanceBean();
		
	} else if (entBasicBean instanceof biz.statum.apia.web.bean.execution.TaskBean){
		aBean = (biz.statum.apia.web.bean.execution.TaskBean)entBasicBean;
		
	} else if (entBasicBean instanceof biz.statum.apia.web.bean.monitor.EntitiesBean){
		aBean = (biz.statum.apia.web.bean.monitor.EntitiesBean)entBasicBean;
	} else if (entBasicBean instanceof biz.statum.apia.web.bean.monitor.BusinessBean){
		aBean = (biz.statum.apia.web.bean.monitor.BusinessBean)entBasicBean;
	}

	aBean.processForm(request, response, EntInstanceBean.BEAN_TYPE_ENTITY, "before");
	String frmBefore = (String)request.getAttribute("FRM_HTML_" + EntInstanceBean.BEAN_TYPE_ENTITY);
	
	aBean.processForm(request, response, EntInstanceBean.BEAN_TYPE_ENTITY, "after");
	String frmAfter = (String)request.getAttribute("FRM_HTML_" + EntInstanceBean.BEAN_TYPE_ENTITY);
	%></head><body><div class="body" id="bodyDiv"><div class="optionsContainer"><system:campaign inLogin="false" inSplash="false" location="verticalUp" /><div class="fncPanel info"><div class="title"><system:label show="text" label="titMonEnt" />: <system:edit show="value" from="theBean" field="consultVoTitle"/><%@include file="../../includes/adminFav.jsp" %></div><div class="content divFncDescription"><div class="fncDescriptionImage" data-src="<system:edit show="value" from="theBean" field="fncImage"/>"></div><div id="fncDescriptionText"><system:label show="text" label="dscFncProcEnt"/></div><div class="clear"></div></div></div><div class="fncPanel buttons"><div class="title"><system:label show="text" label="titActions"/></div><div class="content"><div id="btnBack" class="button suggestedAction"><system:label show="text" label="btnVol" /></div><div id="btnTasks" class="button hidden"><system:label show="text" label="btnMonTsk" /></div></div></div><div class="fncPanel options hidden" id="pnlOptions" ><div class="title"><system:label show="text" label="titOptions"/></div><div class="content"><div id="filterDiv" style="max-height: 300px; overflow: auto;" ></div></div></div><system:campaign inLogin="false" inSplash="false" location="verticalDown" /></div><div class="dataContainer"><div class='tabComponent' id="tabComponent" data-changeEvent="fncChange()"><div class="aTab"><div class="tab"><system:label show="text" label="tabMonEntBefore" /></div><div class="contentTab"><div class="tabContent"><%=frmBefore%></div></div></div><div class="aTab"><div class="tab"><system:label show="text" label="tabMonEntHistory" /></div><div class="contentTab"><div class="gridHeader"><!-- Cabezal y filtros --><table><thead><tr id="trOrderBy" class="header"><th width="150px" id="orderMonEntDate" class="allowSort sortDown" data-sortBy="<system:edit show="constant" from="com.dogma.vo.filter.MonitorEntityFilterVo" field="HISTORY_ORDER_BY_DATE"/>" ><div><system:label show="text" label="lblMonEntDate" /></div></th><th width="100px" id="orderMonEntUser" ><system:label show="text" label="lblMonEntUser" /></th><th width="100px" id="orderMonEntOpe" class=""><div><system:label show="text" label="lblMonEntOpe" /></div></th><th width="150px" id="orderMonEntAtt" class="allowSort" data-sortBy="<system:edit show="constant" from="com.dogma.vo.filter.MonitorEntityFilterVo" field="HISTORY_ORDER_BY_ATTRIBUTE"/>"><div><system:label show="text" label="lblMonEntAtt" /></div></th><th width="70px" id="orderMonEntIndex"><system:label show="text" label="lblMonEntIndex" /></th><th width="150px" id="orderMonEntValue"><system:label show="text" label="lblMonEntValue" /></th></tr></thead></table></div><div class="gridBody" id="gridBody"><!-- Cuerpo de la tabla --><table><thead><tr><th width="150px"></th><th width="100px"></th><th width="100px"></th><th width="150px"></th><th width="70px"></th><th width="150px"></th></tr></thead><tbody class="tableData" id="tableData"></tbody></table></div><div class="gridFooter"><%@include file="../../includes/navButtons.jsp" %></div><!-- MESSAGES --><div class="message hidden" id="messageContainer"></div></div></div><div class="aTab"><div class="tab"><system:label show="text" label="tabMonEntAfter" /></div><div class="contentTab"><div class="tabContent"><%=frmAfter%></div></div></div><div class="aTab"><div class="tab"><system:label show="text" label="tabMonEntProInst" /></div><div class="contentTab"><div class="gridHeader"><!-- Cabezal y filtros --><table><thead><tr id="trOrderBy" class="header"><th width="100px" id="orderMonInstProNroReg" ><system:label show="text" label="lblMonInstProNroReg" /></th><th width="200px" id="orderProTit" ><system:label show="text" label="lblProTit" /></th><th width="100px" id="orderMonInstProSta"  ><system:label show="text" label="lblMonInstProSta" /></th><th width="100px" id="orderMonInstProCreUsu"><system:label show="text" label="lblMonInstProCreUsu" /></th><th width="110px" id="orderMonInstProCreDat"><system:label show="text" label="lblMonInstProCreDat" /></th><th width="110px" id="orderMonInstProEndDat"><system:label show="text" label="lblMonInstProEndDat" /></th></tr></thead></table></div><div class="gridBody" id="gridBody"><!-- Cuerpo de la tabla --><table><thead><tr><th width="100px"></th><th width="200px"></th><th width="100px"></th><th width="100px"></th><th width="110px"></th><th width="110px"></th></tr></thead><tbody class="tableData" id="tableDataInstance"></tbody></table></div></div></div></div><!-- fin tabComponent --><system:campaign inLogin="false" inSplash="false" location="horizontalDown" /></div><%@include file="../../includes/footer.jsp" %><%@include file="../../modals/documents.jsp" %><%@include file="../../execution/includes/endInclude.jsp" %></body></html>
