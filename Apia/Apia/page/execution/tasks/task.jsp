<%@page import="biz.statum.apia.web.bean.BasicBean"%>
<%@page import="com.dogma.Configuration"%>
<%@page import="com.dogma.vo.TskLanguagesVo"%>
<%@page import="java.util.ArrayList"%>
<%@page import="biz.statum.sdk.util.BooleanUtils"%>
<%@page import="biz.statum.apia.web.action.execution.TaskAction"%>
<%@page import="com.dogma.vo.LanguageVo"%>
<%@ taglib uri='/WEB-INF/regions.tld' prefix='region' %>
<%@ taglib prefix="system"	uri="/WEB-INF/system-tags.tld" %>
<%@page import="biz.statum.apia.web.bean.execution.ProInstanceBean"%>
<%@page import="biz.statum.apia.web.bean.execution.EntInstanceBean"%>
<%@page import="biz.statum.apia.web.bean.execution.TaskBean"%>
<%@page import="biz.statum.apia.web.bean.execution.ExecutionBean"%>
<%@page import="com.dogma.vo.ProInstanceVo"%>
<%@page import="com.dogma.vo.ProcessVo"%>
<%@page import="com.dogma.vo.TaskVo"%>
<%@page import="com.dogma.vo.BusEntityVo"%>
<%@page import="com.dogma.vo.BusEntStatusVo"%>
<%@page import="com.dogma.vo.BusEntInstanceVo"%>
<%@page import="com.dogma.vo.CalendarVo"%>
<%@page import="com.dogma.vo.ProInstCommentVo"%>
<%@page import="biz.statum.apia.web.bean.execution.InitTaskBean"%>
<%@page import="biz.statum.apia.web.action.BasicAction"%>
<%@page import="biz.statum.apia.web.bean.execution.TaskBean"%>
<%@page import="com.dogma.Parameters"%>
<%@page import="com.dogma.EnvParameters"%>
<%@page import="biz.statum.apia.web.bean.BeanUtils"%>
<%@page import="com.st.util.translator.TranslationManager"%>
<%@page import="java.util.Iterator"%>
<%@page import="java.util.Collection"%>
<%@page import="com.st.util.labels.LabelManager" %>
<%@page import="java.util.ArrayList"%>
<%@page import="biz.statum.sdk.util.StringUtil"%>
<%response.setCharacterEncoding(com.dogma.Parameters.APP_ENCODING);%>
<%

request.setAttribute("isTask","true"); 

TaskBean dBean = TaskAction.getBean(request,response); //(TaskBean) session.getAttribute(BasicAction.BEAN_EXEC_NAME);
boolean isFirstTask = dBean instanceof InitTaskBean;

int stepCount = dBean.getStepQty();
int currentStepNumber = dBean.getCurrentStep();


boolean isActionAlteration = dBean.getProInstanceBean().getProcess().getProAction().equals(ProcessVo.PROCESS_ACTION_ALTERATION);
boolean isActionCancel = dBean.getProInstanceBean().getProcess().getProAction().equals(ProcessVo.PROCESS_ACTION_CANCEL);

BusEntInstanceVo beInstVo = dBean.getEntInstanceBean().getEntity();
BusEntityVo beVo = dBean.getEntInstanceBean().getEntityType();

TaskVo taskVo = dBean.getTaskVo();
ProcessVo proVo =  dBean.getProInstanceBean().getProcess();
ProInstanceVo proInstVo = dBean.getProInstanceBean().getProcInstance();

EntInstanceBean entityBean = dBean.getEntInstanceBean();
ProInstanceBean processBean = dBean.getProInstanceBean();

String template = "/page/templates/taskDefault.jsp";
if (proVo.getProExeTemplate() != null && !proVo.getProExeTemplate().equals("")) {
	template = proVo.getProExeTemplate();
}
if (dBean.getTaskVo().getTskExeTemplate() != null && !dBean.getTaskVo().getTskExeTemplate().equals("")) {
	template = dBean.getTaskVo().getTskExeTemplate();
}

UserData uData = BasicBeanStatic.getUserDataStatic(request);

//--si se accede desde el minisitio... colocar el template de minisitio
if(uData.isFromMinisite()){
	template = "/page/templates/taskDefaultMinisite.jsp";
}

boolean commentsMarked = false;

Collection<LanguageVo> tskTradLang = null;
if(taskVo != null && taskVo.getTskLanguages() != null) {
	tskTradLang = new ArrayList<LanguageVo>();
	for(TskLanguagesVo lang : taskVo.getTskLanguages()) {
		LanguageVo langVo = new LanguageVo();
		langVo.setLangId(lang.getLangId());
		langVo.setLangName(lang.getLangName());
		tskTradLang.add(langVo);
	}
}

request.setAttribute("tskTradLang", tskTradLang);

BasicBean taskBasicBean = BasicAction.staticRetrieveBean(request, response, BasicAction.BEAN_EXEC_NAME);

ExecutionBean aBean = null;

if(taskBasicBean instanceof biz.statum.apia.web.bean.execution.EntInstanceListBean){
	aBean = ((biz.statum.apia.web.bean.execution.EntInstanceListBean)taskBasicBean).getEntInstanceBean();
	
} else if (taskBasicBean instanceof biz.statum.apia.web.bean.execution.TaskBean){
	aBean = (biz.statum.apia.web.bean.execution.TaskBean)taskBasicBean;
	
} else if (taskBasicBean instanceof biz.statum.apia.web.bean.monitor.EntitiesBean){
	aBean = (biz.statum.apia.web.bean.monitor.EntitiesBean)taskBasicBean;
} else if (taskBasicBean instanceof biz.statum.apia.web.bean.monitor.BusinessBean){
	aBean = (biz.statum.apia.web.bean.monitor.BusinessBean)taskBasicBean;
}

aBean.processForm(request, response, EntInstanceBean.BEAN_TYPE_ENTITY, "");
aBean.processForm(request, response, ProInstanceBean.BEAN_TYPE_PROCESS, "");


out.clear();
%>
<region:render template='<%=template%>'>
		<region:put section='title'>
			<span class="titImage">
			<%if(proInstVo.getProPriority() != null && proInstVo.getProPriority().intValue() == com.dogma.vo.ProInstanceVo.PRO_PRIORITY_LOW){ %>
				<img title="<system:label show="text" label="lblEjeTitPriPro1"/>" alt="<system:label show="text" label="lblEjeTitPriPro1"/>" src="<system:util show="context" />/css/base/img/priority1.gif" >
			<%}else if(proInstVo.getProPriority() != null && proInstVo.getProPriority().intValue() == com.dogma.vo.ProInstanceVo.PRO_PRIORITY_HIGH){ %>
				<img title="<system:label show="text" label="lblEjeTitPriPro3"/>" alt="<system:label show="text" label="lblEjeTitPriPro3"/>" src="<system:util show="context" />/css/base/img/priority3.gif" >
			<%}else if(proInstVo.getProPriority() != null && proInstVo.getProPriority().intValue() == com.dogma.vo.ProInstanceVo.PRO_PRIORITY_URGENT){%>
				<img title="<system:label show="text" label="lblEjeTitPriPro4"/>" alt="<system:label show="text" label="lblEjeTitPriPro4"/>" src="<system:util show="context" />/css/base/img/priority4.gif" >
			<%}else if(proInstVo.getProPriority() != null && proInstVo.getProPriority().intValue() == com.dogma.vo.ProInstanceVo.PRO_PRIORITY_NORMAL){%>
				<img title="<system:label show="text" label="lblEjeTitPriPro2"/>" alt="<system:label show="text" label="lblEjeTitPriPro2"/>" src="<system:util show="context" />/css/base/img/priority2.gif" >
			<%}else {%>
				<img title="<system:label show="text" label="lblEjeTitPriPro2"/>" alt="<system:label show="text" label="lblEjeTitPriPro2"/>" src="<system:util show="context" />/css/base/img/priority2.gif" >
			<%}%>
			</span>
			<%= "<span class='proTitle'>" + BeanUtils.fmtHTML(TranslationManager.getProcTitle(proVo.getProName(), proVo.getProTitle(), uData.getEnvironmentId(), uData.getLangId())) + "</span><span class='execTitleSeparator'>&gt;</span><span class='taskTitle'>" + BeanUtils.fmtHTML(TranslationManager.getTaskTitle(dBean.getCurrentElement(), uData.getEnvironmentId(), uData.getLangId())) + "</span>"%>
			
		</region:put>
		
		<region:put section="tskDescription">
			<%=BeanUtils.fmtHTML(TranslationManager.getTaskDescription(dBean.getTaskVo().getTskName(), dBean.getTaskVo().getTskDesc(), uData.getEnvironmentId(), uData.getLangId())) %>
		</region:put>
		
		<region:put section="taskImage">
			<%if(dBean.getTaskVo().getImgPath()!=null){%>
			<div class="fncDescriptionImgUsers" style="background-image: url('images/uploaded/<%=dBean.getTaskVo().getImgPath()%>');"></div>
			<%} else {%>
			<div class="fncDescriptionImgUsers" style="background-image: url('css/base/img/functionalities/Tareas.gif');"></div>
			<%} %>
		</region:put>
	
		<region:put section="apiaSocial">
			<system:edit show="ifParameter" field="APIASOCIAL_ACTIVE" value="true">
				<% if(!proVo.getFlagValue(ProcessVo.FLAG_DISABLE_SOCIAL) && !dBean.getTaskVo().getFlagValue(TaskVo.POS_FLAG_DISABLE_SOCIAL)) { %>
				<%@include file="../../social/taskReadPanel.jsp" %>
				<% } %>
			</system:edit>
		</region:put>
	
		<region:put section='entityMain'><%@include file="../includes/entityMain.jsp" %></region:put>
		<region:put section='entityDocuments' content="/page/execution/includes/documents.jsp?frmParent=E"/>
		<region:put section='processMain'><%@include file="../includes/processMain.jsp" %></region:put>
		<region:put section='processDocuments' content="/page/execution/includes/documents.jsp?frmParent=P"/>
		<region:put section='entityForms'>
			<div class="tabContent">
			<%
				String strFormsHTML_E = (String)request.getAttribute("FRM_HTML_E");
				if(strFormsHTML_E!=null){
					out.println(strFormsHTML_E);
				}
			%>
			<label for="hidFocusE">&nbsp;</label>
			<input id="hidFocusE" tabindex="-1" style="height: 0px; width: 0px; border:none;">
			</div>
		</region:put>
		<region:put section='processForms'>
			<div class="tabContent">
			<%
				String strFormsHTML_P = (String)request.getAttribute("FRM_HTML_P");
				if(strFormsHTML_P!=null){
					out.println(strFormsHTML_P);
				}
			%>
			<label for="hidFocusP">&nbsp;</label>
			<input id="hidFocusP" tabindex="-1" style="height: 0px; width: 0px; border:none;">
			</div>
		</region:put>
		<region:put section='taskComments'><%@include file="../includes/taskComments.jsp" %></region:put>
		<region:put section='taskMonitor'><%@include file="../includes/taskMonitor.jsp" %></region:put>
		
		<region:put section='scripts_include'>			
			<script type="text/javascript" src="<system:util show="context" />/page/execution/tasks/task.js" <%=(request.getHeader("User-Agent").indexOf("MSIE")>=0)?" defer=\"defer\"":"" %>></script>
			
			<script type="text/javascript" src="<system:util show="context" />/js/synchronize-fields.js"></script>
			<script type="text/javascript" src="<system:util show="context" />/js/masked-input.js"></script>
			
			<!-- JS Objects -->
			<script type="text/javascript" src="<system:util show="context" />/page/execution/scripts/classes/form.js"></script>
			<script type="text/javascript" src="<system:util show="context" />/page/execution/scripts/classes/field.js"></script>
			<script type="text/javascript" src="<system:util show="context" />/page/execution/scripts/classes/fieldTypes/input.js"></script>
			<script type="text/javascript" src="<system:util show="context" />/page/execution/scripts/classes/fieldTypes/select.js"></script>
			<script type="text/javascript" src="<system:util show="context" />/page/execution/scripts/classes/fieldTypes/area.js"></script>
			<script type="text/javascript" src="<system:util show="context" />/page/execution/scripts/classes/fieldTypes/button.js"></script>
			<script type="text/javascript" src="<system:util show="context" />/page/execution/scripts/classes/fieldTypes/check.js"></script>
			<script type="text/javascript" src="<system:util show="context" />/page/execution/scripts/classes/fieldTypes/editor.js"></script>
			<script type="text/javascript" src="<system:util show="context" />/page/execution/scripts/classes/fieldTypes/grid.js"></script>
			<script type="text/javascript" src="<system:util show="context" />/page/execution/scripts/classes/fieldTypes/hidden.js"></script>
			<script type="text/javascript" src="<system:util show="context" />/page/execution/scripts/classes/fieldTypes/href.js"></script>
			<script type="text/javascript" src="<system:util show="context" />/page/execution/scripts/classes/fieldTypes/image.js"></script>
			<script type="text/javascript" src="<system:util show="context" />/page/execution/scripts/classes/fieldTypes/label.js"></script>
			<script type="text/javascript" src="<system:util show="context" />/page/execution/scripts/classes/fieldTypes/multiple.js"></script>
			<script type="text/javascript" src="<system:util show="context" />/page/execution/scripts/classes/fieldTypes/password.js"></script>
			<script type="text/javascript" src="<system:util show="context" />/page/execution/scripts/classes/fieldTypes/radio.js"></script>
			<script type="text/javascript" src="<system:util show="context" />/page/execution/scripts/classes/fieldTypes/title.js"></script>
			<script type="text/javascript" src="<system:util show="context" />/page/execution/scripts/classes/fieldTypes/fileinput.js"></script>
			<script type="text/javascript" src="<system:util show="context" />/page/execution/scripts/classes/fieldTypes/tree.js"></script>
			<script type="text/javascript" src="<system:util show="context" />/page/execution/scripts/classes/fieldTypes/captcha.js"></script>
			<script type="text/javascript" src="<system:util show="context" />/js/contextmenu.js"></script>
			<script type="text/javascript" src="<system:util show="context" />/js/print.js"></script>
			
			<!-- WEBDAV JS Client -->
			<script type="text/javascript" src="<system:util show="context" />/js/ITHitWebDav/ITHitWebDAVClient.js"></script>
			
			<!-- API JS -->
			<script type="text/javascript" src="<system:util show="context" />/page/execution/scripts/API/apiaFunctions.js"></script>
			<script type="text/javascript" src="<system:util show="context" />/page/execution/scripts/API/apiaField.js"></script>
			
			<!-- documents -->
			<script type="text/javascript" src="<system:util show="context" />/page/modals/documents.js"></script>
			<script type="text/javascript" src="<system:util show="context" />/page/generic/documents.js"></script>
			
			<!-- modals  -->
			<script type="text/javascript" src="<system:util show="context" />/page/modals/pools.js"></script>
			<script type="text/javascript" src="<system:util show="context" />/page/modals/users.js"></script>
			<script type="text/javascript" src="<system:util show="context" />/page/modals/calendarsView.js"></script>
			<script type="text/javascript" src="<system:util show="context" />/page/modals/foldersDocuments.js"></script>
			<script type="text/javascript" src="<system:util show="context" />/page/includes/foldersDisplay.js"></script>
			
		
			<script type="text/javascript" src="<system:util show="context" />/page/includes/navButtons.js"></script>
			
			<!-- social -->
			<script type="text/javascript" src="<system:util show="context" />/page/social/taskReadPanel.js"></script>			
			<script type="text/javascript" src="<system:util show="context" />/page/social/socialShareMdl.js"></script>
			<script type="text/javascript" src="<system:util show="context" />/page/social/socialReadChannelMdl.js"></script>
			
			<!-- DRAG AND DROP BEHAVIOUR -->
			<script type="text/javascript" src="<system:util show="context" />/js/dragAndDrop/Form.MultipleFileInput.js"></script>
			<script type="text/javascript" src="<system:util show="context" />/js/dragAndDrop/Form.Upload.js"></script>
			<script type="text/javascript" src="<system:util show="context" />/js/dragAndDrop/Request.File.js"></script>
			
			<%@include file="/page/includes/tinymce.editor.jsp" %>
			
			<script type="text/javascript">
				var URL_REQUEST_AJAX = '/apia.execution.TaskAction.run';	
				var CLOSE_ON_RETURN = <%=dBean.isCloseOnReturn()%>;			
				<%
				String escapedCurrentTab = com.st.util.StringUtil.escapeStr(com.st.util.StringUtil.escapeHTML(request.getParameter("currentTab")));
				%>
				
				var commentsMarked 	= <%=commentsMarked%>;
				var currentTab 		= <%=escapedCurrentTab!=null?escapedCurrentTab:"-1"%>;
				
				var currentStep		= <%=dBean.getCurrentStep().intValue()%>;
				var stepQty 		= <%=dBean.getStepQty().intValue()%>;
				var CURRENT_TASK_NAME = "<%=taskVo.getTskName()%>";
				var CURRENT_PROCESS_NAME = "<%=proVo.getProName()%>";
				var ADDITIONAL_INFO_IN_TABLE_DATA = false;
				
				var signedOK = "false";
				var MSG_REQ_SIGNATURE_FORM = "<system:label show='text' label='lblReqSigForm'/>";
				
				var TSK_TITLE = "<%= BeanUtils.fmtHTML(TranslationManager.getTaskTitle(dBean.getCurrentElement(), uData.getEnvironmentId(), uData.getLangId())) %>";
				var TAB_ID	= "<system:util show="tabId"  />";
				
				var IN_MONITOR = false;
				var IN_MONITOR_PROCESS = false;
				var IN_MONITOR_TASK	   = false;
				var EXTERNAL_ACCESS = "<%=(uData.isExternalMode() || uData.isFromMinisite())%>";
				var IS_MINISITE		= "<%=uData.isFromMinisite()%>";
				var onFinish 		= "<%=(uData.getOnFinish())%>";
				var onFinishURL		= "<%=(uData.getOnFinishURL())%>";
				var URL_PRO_BUS_ENT_IDS = "<%= "&txtProId=" + proVo.getProId() + "&txtBusEntId=" + beVo.getBusEntId() %>";
				var BTN_FILE_UPLOAD_LBL = "<system:label show='text' label='prpUpload' forHtml='true'/>";
				var BTN_FILE_DOWNLOAD_LBL = "<system:label show='text' label='prpDownload' forHtml='true'/>";
				var BTN_FILE_INFO_LBL = "<system:label show='text' label='lblInfo' forHtml='true'/>";
				var BTN_FILE_LOCK_LBL = "<system:label show='text' label='prpLock' forHtml='true'/>";
				var BTN_FILE_ERASE_LBL = "<system:label show='text' label='prpErase' forHtml='true'/>";
				var BTN_FILE_SIGN_LBL = "<system:label show='text' label='prpSign' forHtml='true'/>";
				var BTN_FILE_VERIFY_LBL = "<system:label show='text' label='prpVerify' forHtml='true'/>";
				var BTN_FILE_TRADUC_LBL = "<system:label show='text' label='lblTranslations' forHtml='true'/>";
				var MSG_CONFIG_DELETE_DOCUMENT_FILE_INPUT        = '<system:label show="text" label="msgConfDelDoc" forScript="true" />';
				var TIT_SING_MODAL_LBL = "<system:label show='text' label='titFormsToSign' forHtml='true'/>";
				var TIT_SING_MODAL_PREV_LBL = "<system:label show='text' label='titPrevFormsToSign' forHtml='true'/>";
				var TIT_SING_DOCS_MODAL_LBL = "<system:label show='text' label='titDocsToSign' forHtml='true'/>";
				var DROP_FILES_HERE_LBL				= '<system:label show="text" label="lblDropFilesHere" forScript="true" />';
				var BTN_FILE_DROP_LBL	= '<system:label show="text" label="btnFileDrop" forScript="true" />';
				
				var ERR_EXEC_BUS_CLASS = "<system:label show='text' label='errExecBusClass' forHtml='true'/>";
				var LBL_ERROR 		= "<system:label show='text' label='lblError' forHtml='true'/>";
				var MSG_VAL_NOT_FOUND 	= "<system:label show='text' label='msgValNotFound' forHtml='true'/>";
				var ERR_EXEC_BINDING 	= "<system:label show='text' label='errExecBinding' forHtml='true'/>";
				
				var TIT_TRANSLTATION = "<system:label show='text' label='titTra' forHtml='true'/>";
				
				var MSG_DEL_FILE_TRANS = "<system:label show='text' label='msgDelFileTrans' forHtml='true'/>";
				var TIT_DEL_FILE = "<system:label show='text' label='titDelFile' forHtml='true'/>";
				
				var LBL_OTHER_DOCS	= "<system:label show='text' label='sbtOtherDocs' forHtml='true'/>";
				
				var LBL_FROM = "<system:label show='text' label='lblFrom' forHtml='true'/>";
				var LBL_EDIT = '<system:label show="text" label="lblEdit" forScript="true" forHtml="true"/>';
				
				var LBL_LEAVE_DOCS_HERE = '<system:label show="text" label="lblLveDcsHere" forScript="true"/>';
				
				var GLOBAL_PARAMS		= [
						toBoolean('<system:edit show="constant" from="com.dogma.Parameters" field="DOCUMENT_ALLW_SEL_DOC_FRM_DOC_MON"/>'),	
						toBoolean('<system:edit show="constant" from="com.dogma.Parameters" field="DOCUMENT_ALLW_SEL_DOC_FRM_FLD_STRCT"/>'),
						toBoolean('<system:edit show="constant" from="com.dogma.Parameters" field="DOCUMENT_ALLOW_FLD_STRCT_VIEW"/>')
				];
				
				var ENVIRONMENT_PARAMS	= [
						<%= EnvParameters.getEnvParameter(uData.getEnvironmentId(), EnvParameters.ENV_ALLOW_DOC_MONITOR) %>,
						<%= EnvParameters.getEnvParameter(uData.getEnvironmentId(), EnvParameters.ENV_ALLOW_FLD_STR_DOC_SEL) %>,
						<%= EnvParameters.getEnvParameter(uData.getEnvironmentId(), EnvParameters.ENV_ALLOW_FLD_STR_VIEW) %>
				];
				
				
				/******************************** PROCESS **************************************/
				var PRO_DEF_PARAMS 		= [
						<%= proVo.getFlagStringValue(ProcessVo.FLAG_ALLOW_MONITOR_DOCUMENT) %>,
						<%= proVo.getFlagStringValue(ProcessVo.FLAG_SHOW_FOLDER_STRUCTURE) %>,
						<%= proVo.getFlagStringValue(ProcessVo.FLAG_SHOW_FOLDER_BUTTON) %>,
				];
				
				/*
					VARIABLES DEL ARRAY:
						1. OCULTAR PERMISOS
						2. OCULTAR METADATA
						3. COLAPSAR PERMISOS
						4. COLAPSAR ESTRUCTURA DE DIRECTORIOS
						5. COLAPSAR METADATOS
						6. PERMITIR SELECCIONAR DOCUMENTOS DE MONITOR
						7. ID DEL MONITOR
						8. MOSTRAR ESTRUCTURA DE DIRECTORIOS
						9. PERMITIR SELECCIONAR DOCUMENTOS DE UN DIRECTORIO
				*/
				var PRO_PARAMS_FOR_DOC_MODAL = [
					<%= proVo.getFlagValue(ProcessVo.FLAG_HIDE_PERMISSIONS) %>,
					<%= proVo.getFlagValue(ProcessVo.FLAG_HIDE_METADATA) %>,
					<%= proVo.getFlagValue(ProcessVo.FLAG_COLLAPSE_PERMITS) %>,
					<%= proVo.getFlagValue(ProcessVo.FLAG_COLLAPSE_FLD_STRUCTURE) %>,
					<%= proVo.getFlagValue(ProcessVo.FLAG_COLLAPSE_METADATA) %>
				];
				
				var ENV_PARAM_DOC_MON_ID 	= <%= EnvParameters.getEnvParameter(uData.getEnvironmentId(), EnvParameters.ENV_SEL_DOC_IN_SYSTEM) %>;
				var ENT_DOC_MON_ID 			= <%= beVo.getCusDocMonId() %>;
				var PRO_DOC_MON_ID			= <%= proVo.getCusDocMonId() %>;
				
				if (parseInt(PRO_DEF_PARAMS[0]) != 0) {
					PRO_PARAMS_FOR_DOC_MODAL.push(parseInt(PRO_DEF_PARAMS[0]) == 1 
							|| (parseInt(PRO_DEF_PARAMS[0]) == 2 && GLOBAL_PARAMS[0]) || (parseInt(PRO_DEF_PARAMS[0]) == 3 && ENVIRONMENT_PARAMS[0])); 
					PRO_PARAMS_FOR_DOC_MODAL.push(parseInt(PRO_DEF_PARAMS[0]) == 1 ? PRO_DOC_MON_ID
							: (parseInt(PRO_DEF_PARAMS[0]) == 2 && GLOBAL_PARAMS[0]) ? 1
							: (parseInt(PRO_DEF_PARAMS[0]) == 3 && ENVIRONMENT_PARAMS[0]) ? ENV_PARAM_DOC_MON_ID : null);
				} else {
					PRO_PARAMS_FOR_DOC_MODAL.push(false);
					PRO_PARAMS_FOR_DOC_MODAL.push(0);
				}
				
				if (parseInt(PRO_DEF_PARAMS[1]) != 0) {
					PRO_PARAMS_FOR_DOC_MODAL.push(parseInt(PRO_DEF_PARAMS[1]) == 1 
							|| (parseInt(PRO_DEF_PARAMS[1]) == 2 && GLOBAL_PARAMS[2]) || (parseInt(PRO_DEF_PARAMS[1]) == 3 && ENVIRONMENT_PARAMS[2]));
				} else PRO_PARAMS_FOR_DOC_MODAL.push(false);
				
				if (parseInt(PRO_DEF_PARAMS[2]) != 0) {
					PRO_PARAMS_FOR_DOC_MODAL.push(parseInt(PRO_DEF_PARAMS[2]) == 1 
							|| (parseInt(PRO_DEF_PARAMS[2]) == 2 && GLOBAL_PARAMS[1]) || (parseInt(PRO_DEF_PARAMS[2]) == 3 && ENVIRONMENT_PARAMS[1]));
				} else PRO_PARAMS_FOR_DOC_MODAL.push(false);
				
				
				/****************************** ENTITY **************************************/
				var ENT_DEF_PARAMS 				= [
						<%= beVo.getFlagStringValue(BusEntityVo.FLAG_ALLOW_MONITOR_DOCUMENT) %>,
						<%= beVo.getFlagStringValue(BusEntityVo.FLAG_SHOW_FOLDER_STRUCTURE) %>,
						<%= beVo.getFlagStringValue(BusEntityVo.FLAG_SHOW_FOLDER_BUTTON) %>,
				];
				
				/*
					VARIABLES DEL ARRAY:
						1. OCULTAR PERMISOS
						2. OCULTAR METADATA
						3. COLAPSAR PERMISOS
						4. COLAPSAR ESTRUCTURA DE DIRECTORIOS
						5. COLAPSAR METADATOS
						6. PERMITIR SELECCIONAR DOCUMENTOS DE MONITOR
						7. ID DEL MONITOR
						8. MOSTRAR ESTRUCTURA DE DIRECTORIOS
						9. PERMITIR SELECCIONAR DOCUMENTOS DE UN DIRECTORIO
				*/
				var BUS_ENT_PARAMS_FOR_DOC_MODAL = [
					<%= beVo.getFlagValue(BusEntityVo.FLAG_HIDE_PERMISSIONS) %>,
					<%= beVo.getFlagValue(BusEntityVo.FLAG_HIDE_METADATA) %>,
					<%= beVo.getFlagValue(BusEntityVo.FLAG_COLLAPSE_PERMITS) %>,
					<%= beVo.getFlagValue(BusEntityVo.FLAG_COLLAPSE_FLD_STRUCTURE) %>,
					<%= beVo.getFlagValue(BusEntityVo.FLAG_COLLAPSE_METADATA) %>
				];
				
				if (parseInt(ENT_DEF_PARAMS[0]) != 0) {
					BUS_ENT_PARAMS_FOR_DOC_MODAL.push(parseInt(ENT_DEF_PARAMS[0]) == 1 
							|| (parseInt(ENT_DEF_PARAMS[0]) == 2 && GLOBAL_PARAMS[0]) || (parseInt(ENT_DEF_PARAMS[0]) == 3 && ENVIRONMENT_PARAMS[0])); 
					BUS_ENT_PARAMS_FOR_DOC_MODAL.push(parseInt(ENT_DEF_PARAMS[0]) == 1 ? ENT_DOC_MON_ID
							: (parseInt(ENT_DEF_PARAMS[0]) == 2 && GLOBAL_PARAMS[0]) ? 1
							: (parseInt(ENT_DEF_PARAMS[0]) == 3 && ENVIRONMENT_PARAMS[0]) ? ENV_PARAM_DOC_MON_ID : null);
				} else {
					BUS_ENT_PARAMS_FOR_DOC_MODAL.push(false);
					BUS_ENT_PARAMS_FOR_DOC_MODAL.push(0);
				}
				
				if (parseInt(ENT_DEF_PARAMS[1]) != 0) {
					BUS_ENT_PARAMS_FOR_DOC_MODAL.push(parseInt(ENT_DEF_PARAMS[1]) == 1 
							|| (parseInt(ENT_DEF_PARAMS[1]) == 2 && GLOBAL_PARAMS[2]) || (parseInt(ENT_DEF_PARAMS[1]) == 3 && ENVIRONMENT_PARAMS[2]));
				} else BUS_ENT_PARAMS_FOR_DOC_MODAL.push(false);
				
				if (parseInt(ENT_DEF_PARAMS[2]) != 0) {
					BUS_ENT_PARAMS_FOR_DOC_MODAL.push(parseInt(ENT_DEF_PARAMS[2]) == 1 
							|| (parseInt(ENT_DEF_PARAMS[2]) == 2 && GLOBAL_PARAMS[1]) || (parseInt(ENT_DEF_PARAMS[2]) == 3 && ENVIRONMENT_PARAMS[1]));
				} else BUS_ENT_PARAMS_FOR_DOC_MODAL.push(false);
				
				
				
				<% if (dBean.getOnCloseTaskMsg()!=null) { %>
				var ON_CLOSE_TASK_MSG = '<%=dBean.getOnCloseTaskMsg()%>';
				<% } else {%>
				var ON_CLOSE_TASK_MSG = null;
				<% } %>
				
				<%if(!"true".equals(request.getAttribute("isMonitor"))){ %>
					var isMonitor = false;
				<%} else {%>
					var isMonitor = true;
				<%}%>
				
				<%if("true".equals(request.getAttribute("fromProAlter")) && "true".equals(request.getAttribute("alterOp"))){ %>
					var fromAlterProcess = true;
				<%} else {%>
					var fromAlterProcess = false;
				<%}%>
				
				<%if("true".equals(request.getAttribute("fromProCancel")) && "true".equals(request.getAttribute("cancelOp"))){ %>
					var fromCancelProcess = true;
				<%} else {%>
					var fromCancelProcess = false;
				<%}%>
				
				//Social
				var APIA_SOCIAL_ACTIVE			= toBoolean('<system:edit show="constant" from="com.dogma.Parameters" field="APIASOCIAL_ACTIVE"/>');
				
				<%if(ProcessVo.IDENTIFIER_NUM_WRITE.equals(proVo.getProIdeNum())) {%>
				var idNumWrite = true;
				<%} else {%>
				var idNumWrite = false;<%}%>
				
				var currentContentTab = null;
				
				var MSG_NO_GUA = "<system:label show='text' label='msgNoGua' forHtml='true'/>";
				
				function customInitPage() {
					IN_EXECUTION = true;
					docTypePerEntId = <%=dBean.getEntInstanceBean().getEntity().getBusEntId()%>;
					docTypePerProId = <%=dBean.getProInstanceBean().getProcess().getProId()%>;
				}
								
				<!-- Agendas  -->
				
				var TSK_DAY_MON = '<system:label show="text" label="lblTskDayMon"/>';
				var TSK_DAY_TUE = '<system:label show="text" label="lblTskDayTue"/>';
				var TSK_DAY_WED = '<system:label show="text" label="lblTskDayWed"/>';
				var TSK_DAY_THU = '<system:label show="text" label="lblTskDayThu"/>';
				var TSK_DAY_FRI = '<system:label show="text" label="lblTskDayFri"/>';
				var TSK_DAY_SAT = '<system:label show="text" label="lblTskDaySat"/>';
				var TSK_DAY_SUN = '<system:label show="text" label="lblTskDaySun"/>';
				
				var TSK_MONT_JAN = '<system:label show="text" label="lblEnero"/>';
				var TSK_MONT_FEB = '<system:label show="text" label="lblFebrero"/>';
				var TSK_MONT_MAR = '<system:label show="text" label="lblMarzo"/>';
				var TSK_MONT_APR = '<system:label show="text" label="lblAbril"/>';
				var TSK_MONT_MAY = '<system:label show="text" label="lblMayo"/>';
				var TSK_MONT_JUN = '<system:label show="text" label="lblJunio"/>';
				var TSK_MONT_JUL = '<system:label show="text" label="lblJulio"/>';
				var TSK_MONT_AUG = '<system:label show="text" label="lblAgosto"/>';
				var TSK_MONT_SEP = '<system:label show="text" label="lblSetiembre"/>';
				var TSK_MONT_OCT = '<system:label show="text" label="lblOctubre"/>';
				var TSK_MONT_NOV = '<system:label show="text" label="lblNoviembre"/>';
				var TSK_MONT_DEC = '<system:label show="text" label="lblDiciembre"/>';
				
				var LBL_TODAY = '<system:label show="text" label="lblToday"/>';
				var LBL_SCHED_FORM_TITLE = '<system:label show="text" label="titTabSchTask"/>';
				
				var LBL_SCHED_OF = '<system:label show="text" label="lblTskSchedOf"/>';
				var LBL_SCHED_WEEK_NOT_CONFIGURED = '<system:label show="text" label="msgTskSchWeekNotConfig"/>';
				
				var LBL_TIT_SAVE_TASK = '<system:label show="text" label="titSaveTask"/>';
				var LBL_MSG_NOT_SAVE_SCHED = '<system:label show="text" label="msgSaveTaskSched"/>';
				
				var WEBDAV_PROTOCOL_INSTALLER = ITHit.WebDAV.Client.DocManager.GetInstallFileName();
				<%
				out.write("var MSG_NO_DOC_EDIT_PROTOCOL	= '");	
				Collection<String> toks = new ArrayList<String>();
				toks.add("<a href=\"plugins/webdav/'+WEBDAV_PROTOCOL_INSTALLER+'\" download>");
				toks.add("</a>");
				out.write(StringUtil.parseMessage(LabelManager.getName(uData,"msgNoDocEdiProto"), toks) + "';");
				%>
				
			</script>
			<link href="<system:util show="context" />/css/base/modules/schedulerExec.css" rel="stylesheet" type="text/css" >
			<script type="text/javascript" src="<system:util show="context" />/page/includes/tskSchedulerExecution.js"></script>
			
			<%
				String strScript = (String)request.getAttribute("FRM_SCRIPT");
				if(strScript!=null){
					out.println(strScript);
				}
			%>
			
			<% if (proVo.getCustomCSSPath() != null){ %>
			<!-- custom process style  -->
			<link href="<system:util show="context" />/<%=proVo.getCustomCSSPath()%>" rel="stylesheet" type="text/css" >
			<% } %>
			<% if (taskVo.getCustomCSSPath() != null){ %>
			<!-- custom task style  -->
			<link href="<system:util show="context" />/<%=taskVo.getCustomCSSPath()%>" rel="stylesheet" type="text/css" >
			<% } %>
			
		</region:put>
		
		<region:put section='buttons'>

			<div id="divAdminActEdit" class="fncPanel buttons">
				<div class="title"><system:label show='text' label='titActions'/></div>
				<div class="content">
				
				
					<%if(currentStepNumber==stepCount){ %>
					<div id="btnConf"  <%if (dBean.getStepQty().intValue() == dBean.getCurrentStep().intValue()) {%>class="button submit suggestedAction validate['submit']" <%}else{%>class="button btnDisabled" btnDisabled="true" <%}%> title="<system:label show="tooltip" label="btnCon" />"><system:label show="text" label="btnCon" /></div>
					<%} %>
					<%if(currentStepNumber < stepCount){ %>
					<div id="btnNext" <%if (dBean.getStepQty().intValue() > dBean.getCurrentStep().intValue()) {%>class="button suggestedAction" <%}else{%>class="button btnDisabled" btnDisabled="true" <%}%> title="<system:label show="tooltip" label="btnSig"/>"><system:label show="text" label="btnSig"/></div>					
					<%} %>
					<%if(currentStepNumber>1){ %>
					<div id="btnLast" <%if (dBean.getCurrentStep().intValue() > 1) {%>class="button secondaryAction " <%} else {%>class="button secondaryAction btnDisabled" btnDisabled="true" <%}%>title="<system:label show="tooltip" label="btnAnt"/>"><system:label show="text" label="btnAnt"/></div>
					<%} %>
					<%if (!isFirstTask) {%>
						<div id="btnSave" class="button secondaryAction" title="<system:label show="tooltip" label="btnGua"/>"><system:label show="text" label="btnGua"/></div>
						<div id="btnFree" class="button secondaryAction" title="<system:label show="tooltip" label="btnEjeLib"/>"><system:label show="text" label="btnEjeLib"/></div>
						<%if (taskVo.getFlagValue(TaskVo.POS_FLAG_DELEGATE) && proVo.getFlagValue(ProcessVo.FLAG_DELEGATE) && "true".equals(EnvParameters.getEnvParameter(uData.getEnvironmentId(),EnvParameters.ENV_USES_HIERARCHY))) {%>
						<div id="btnDelegate" class="button secondaryAction" title="<system:label show="tooltip" label="lblExeDelegar"/>"><system:label show="text" label="lblExeDelegar"/></div>
						<%}%>
					<%} %>
					
					<%if (BooleanUtils.isTrue(Parameters.APIASOCIAL_ACTIVE)) {%>
						<div id="btnSocialShare" class="button secondaryAction" title="<system:label show="tooltip" label="lblShareMsg" />"><system:label show="text" label="lblShareMsg" /></div>
					<%}%>			
					
					<%if(uData.isFromMinisite()){ %>
					<div id="btnBackToMinisite" class="button secondaryAction" title="<system:label show="tooltip" label="btnVol" />"><system:label show="text" label="btnVol" /></div>
					<%} %>
					
					<%if (isActionAlteration && isFirstTask) { %>
						<div id="btnBackToInstAltList" class="button secondaryAction" title="<system:label show="tooltip" label="btnVol" />"><system:label show="text" label="btnVol" /></div>
					<%} %>
					
					<%if (isActionCancel && isFirstTask) { %>
						<div id="btnBackToInstCanList" class="button secondaryAction" title="<system:label show="tooltip" label="btnVol" />"><system:label show="text" label="btnVol" /></div>
					<%} %>
					
					<%if(!uData.isExternalMode()){%>
					<div id="btnCloseTab" class="button secondaryAction" title="<system:label show="tooltip" label="btnClose" />"><system:label show="text" label="btnClose" /></div>
					<%} %>
				</div>
			</div>
			
			<%if(stepCount>1){ %>
			<div id="divAdminActSteps" class="fncPanel buttons clear">
				<div class="title"><system:label show='text' label='titSteps'/></div>
				<div id="stepsGraph" class="stepsGraph"></div>
			</div>
			<%} %>
			
		</region:put>		
		
		<region:put section="helpDocuments">
			<div class="title"><system:label show="text" label="mnuOpc"/></div>
			<div class="content">
				<div id="btnViewDocs" class="button" title="<system:label show="tooltip" label="sbtEjeDoc" />"><system:label show="text" label="sbtEjeDoc" /></div>
				<div id="btnPrintFrm" class="button" title="<system:label show="tooltip" label="btnStaPri" />"><system:label show="text" label="btnStaPri" /></div>
			</div>
				
		</region:put>
		
		<region:put section="imageOptions">
			<div class="content">
				<div id="btnResetImage" class="button extendedSize" style="display:block;" title="<system:label show="tooltip" label="btnResetImg" />" onclick="resetEntInstaceImage()"><system:label show="text" label="btnResetImg" /></div>
			</div>
		</region:put>
		
		<region:put section="signature">
			<%@include file="../includes/digitalSign.jsp" %>
			<div class="divDelApplet" id='divDigitalSign'>
				<iframe id="ifrApplet" title="<system:label show="text" label="lblAppletTitle" />" <%= request.getHeader("user-agent").contains("MSIE 8.0") ? "frameBorder=0" : ""%> style="width: 430px;height: 210px; border: 0px;">
				</iframe>
			</div>
		</region:put>
</region:render>