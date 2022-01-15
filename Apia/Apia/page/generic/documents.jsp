<%@page import="biz.statum.apia.web.bean.BasicBeanStatic"%><%@page import="com.dogma.UserData"%><%@page import="com.dogma.EnvParameters"%><%@page import="com.dogma.vo.LanguageVo"%><%@page import="java.util.Collection"%><%@page import="com.dogma.Parameters"%><%@page import="com.st.util.labels.LabelManager"%><%
UserData userData = BasicBeanStatic.getUserDataStatic(request);
String prefix = "";
if(request.getParameter("frmParent") != null ){
	prefix = request.getParameter("frmParent");
}

Collection<LanguageVo> langs = null;
Object tskLangs = request.getAttribute("tskTradLang");
if(tskLangs != null)
	langs = (Collection<LanguageVo>)tskLangs;

%><!--

//--></script><script type="text/javascript">
	var MSG_CONFIG_DELETE_DOCUMENT	= '<system:label show="text" label="msgConfDelDoc" forScript="true" />';
	var LBL_DOWN_FILE	= '<system:label show="text" label="lblDownFile" forScript="true" />';
	var LBL_UPLOAD_FILE	= '<system:label show="text" label="lblUploadFile" forScript="true" />';
	var BTN_LOC			= '<system:label show="text" label="btnLoc" forScript="true" />';
	var LBL_INFO		= '<system:label show="text" label="lblInfo" forScript="true" forHtml="true"/>';
// 	var LBL_LIST_FILE	= '<system:label show="text" label="lblFileListMode" forScript="true" />';
// 	var LBL_BLOCK_FILE	= '<system:label show="text" label="lblFileBlockMode" forScript="true" />';
	var BTN_SIGN		= '<system:label show="text" label="prpSign" forScript="true" />';
	var BTN_VERIF_SIGN	= '<system:label show="text" label="prpVerify" forScript="true" />';
	var BTN_DELETE		= '<system:label show="text" label="btnDel" forScript="true" />';
	var BTN_TRAD		= '<system:label show="text" label="lblTranslations" forScript="true" />';
	var BTN_FILE_ERASE_LBL	= '<system:label show="text" label="prpErase" forScript="true"/>';
	
	var MSG_WAIT_SYNC_DOCUMENT	= '<system:label show="text" label="msgWaitSyncDoc" forScript="true" />';
	var MSG_FAIL_SYNC_DOCUMENT	= '<system:label show="text" label="msgFailSyncDoc" forScript="true" />';
	
	var IS_EDITION_ALLOWED	= toBoolean('<%=Parameters.DOCUMENT_ALLOW_WEBDAV_EDITION%>');
	
	var MSG_DEL_FILE_TRANS = "<system:label show='text' label='msgDelFileTrans' forHtml='true'/>";
	
	var REPEATED_FILES_NOT_ADDED_MSG = "<system:label show='text' label='msgDocNamAlrExists' forHtml='true'/>";
	var DOCUMENTS_ADDED_TITLE = "<system:label show='text' label='lblDocuments' forHtml='true'/>";
	var FILES_EXCEED_MAX_SIZE = "<system:label show='text' label='lblDocNotAddMxSzExc' forHtml='true'/>";
	
	var GLOBAL_PARAM_ALLOW_REUSE_DOC_SV	= "<system:edit show="constant" from="com.dogma.Parameters" field="DOCUMENT_ALLW_SEL_DOC_FRM_DOC_MON"/>";
	var ENV_PARAM_ALLOW_REUSE_DOC_SV	= <%= EnvParameters.getEnvParameter(userData.getEnvironmentId(), EnvParameters.ENV_ALLOW_DOC_MONITOR) %>;
	var ENV_PARAM_DOC_MON_ID_SV			= <%= EnvParameters.getEnvParameter(userData.getEnvironmentId(), EnvParameters.ENV_SEL_DOC_IN_SYSTEM) %>;
	
	<%
	out.write("var DOC_LANGS		= {");
	if(langs != null) {
		String str_langs = "";
		for(LanguageVo lang : langs) {
			if(str_langs.length() > 0)
				str_langs += ", " + lang.getLangId() + ": '" + lang.getLangName() + "'";
			else
				str_langs += lang.getLangId() + ": '" + lang.getLangName() + "'";
		}
		out.write(str_langs + "};");
	} else {
		out.write("};");
	}
	%>
	
	window.addEvent("domready", function() {
		var docContainer = $("docContent<%=prefix%>");
		
		var listBtn = docContainer.getElement('div').getElement('div');//$('file-order-list');
		var blockBtn = docContainer.getElement('div').getElements('div')[1];//$('file-order-block');
		var divAdder = docContainer.getChildren('div')[1];
		listBtn.addEvent("click", function() {
			listBtn.addClass('file-mode-selected');
			blockBtn.removeClass('file-mode-selected');
			Cookie.write('fileOrder', 'list');
			divAdder.addClass('asList');
		});
		blockBtn.addEvent("click", function() {
			blockBtn.addClass('file-mode-selected');
			listBtn.removeClass('file-mode-selected');
			Cookie.write('fileOrder', 'block');
			divAdder.removeClass('asList');
		});
		
		var mode = Cookie.read("fileOrder");
		if(mode == "list") {
			divAdder.addClass('asList');
			listBtn.addClass('file-mode-selected');
			blockBtn.removeClass('file-mode-selected');
		}
	});
</script><div class="fieldGroup" id="docContent<%=prefix%>"><div style="height: 20px;"><div class="file-order-list" title="<system:label show="text" label="lblFileListMode" forHtml="true" />"></div><div class="file-mode-selected file-order-block" title="<system:label show="text" label="lblFileBlockMode" forHtml="true" />"></div></div><div class="divAdder"><div class="modalOptionsContainer" id="prmDocumentContainter<%= prefix %>"><%if(!"true".equals(request.getAttribute("isMonitor"))){ %><div class="element docAddDocument" id="docAddDocument<%= prefix %>" data-helper="true" tabIndex="0"><div class="option optionAdd" title="<system:label show="text" label="btnAgr" />"><system:label show="text" label="btnAgr" /></div></div><div class="element hidden" id="dropArea<%= prefix%>" data-helper="true" tabIndex="0" style="width: 100%;"><div class="option optionAdd dropIcon" title="<system:label show="text" label="lblDropFilesHere" />"><!-- <system:label show="text" label="lblDropFilesHere" /> --></div></div><%} else { %><span id="docAddDocument<%= prefix %>" data-helper="true"></span><%} %></div><div style="display: none;" id="tradDocContainter<%= prefix %>"></div></div><div class="clear"></div></div><iframe id="uploadPackageTarget" name="uploadPackageTarget" class="hidden" style="display:none" title="UploadTarget<%= prefix %>"></iframe>

