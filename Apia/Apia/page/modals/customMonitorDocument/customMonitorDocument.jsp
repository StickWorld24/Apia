<%@include file="../../includes/startInc.jsp" %><html lang="<%=biz.statum.apia.web.bean.BasicBeanStatic.getUserDataStatic(request).getLangCode()%>"><head><%@include file="../../includes/headInclude.jsp" %><script type="text/javascript" src="<system:util show="context" />/page/modals/customMonitorDocument/customMonitorDocument.js"></script><script type="text/javascript" src="<system:util show="context" />/page/monitor/documents/custom/list.js"></script><script type="text/javascript" src="<system:util show="context" />/page/includes/navButtons.js"></script><script type="text/javascript" src="<system:util show="context" />/page/includes/adminFav.js"></script><script type="text/javascript" src="<system:util show="context" />/page/includes/campaigns.js"></script><script type="text/javascript" src="<system:util show="context" />/js/autocomplete/autocompleter.js"></script><script type="text/javascript" src="<system:util show="context" />/js/autocomplete/autocompleter.request.js"></script><script type="text/javascript" src="<system:util show="context" />/js/autocomplete/observer.js"></script><script type="text/javascript">
		var MODAL_HIDE_OVERFLOW = true; //Flag para que modalController cambie el tamaño del iframe
		
		
		var URL_REQUEST_AJAX 				= '/apia.execution.CustMonDocumentAction.run';
		var ADDITIONAL_INFO_IN_TABLE_DATA  	= toBoolean('<system:edit show="value" from="theBean" field="adtInfo" />');	
		var SELECTED_INDEX					= '<system:edit show="value" from="theBean" field="selIndex" />';
		var DOC_INDEX 						= toBoolean('<system:edit show="constant" from="com.dogma.Parameters" field="DOC_INDEX_SELECTED"/>'); 
		
		var DOC_TYPE_TASK					= '<system:edit show="constant" from="com.dogma.vo.DocumentVo" field="DOC_TYPE_TASK"/>';	
		var DOC_TYPE_PROCESS 				= '<system:edit show="constant" from="com.dogma.vo.DocumentVo" field="DOC_TYPE_PROCESS"/>';	
		var DOC_TYPE_PROCESS_INST 			= '<system:edit show="constant" from="com.dogma.vo.DocumentVo" field="DOC_TYPE_PROCESS_INST"/>';	
		var DOC_TYPE_BUS_ENT 				= '<system:edit show="constant" from="com.dogma.vo.DocumentVo" field="DOC_TYPE_BUS_ENT"/>';	
		var DOC_TYPE_BUS_ENT_INST			= '<system:edit show="constant" from="com.dogma.vo.DocumentVo" field="DOC_TYPE_BUS_ENT_INST"/>';	
		var DOC_TYPE_FORM 					= '<system:edit show="constant" from="com.dogma.vo.DocumentVo" field="DOC_TYPE_FORM"/>';	
		var DOC_TYPE_BUS_ENT_INST_ATTRIBUTE	= '<system:edit show="constant" from="com.dogma.vo.DocumentVo" field="DOC_TYPE_BUS_ENT_INST_ATTRIBUTE"/>';	
		var DOC_TYPE_PRO_INST_ATTRIBUTE		= '<system:edit show="constant" from="com.dogma.vo.DocumentVo" field="DOC_TYPE_PRO_INST_ATTRIBUTE"/>';	
		var DOC_TYPE_ENVIRONMENT			= '<system:edit show="constant" from="com.dogma.vo.DocumentVo" field="DOC_TYPE_ENVIRONMENT"/>';	
		
		var LBL_TITLE 						= '<system:label show="text" label="lblTitle" forScript="true" forHtml="true"/>';
		var LBL_VALUE 						= '<system:label show="text" label="lblVal" forScript="true" forHtml="true"/>';
		
		var SHOW_PERMISSIONS				= toBoolean('<system:edit show="value" from="theBean" field="showMdlInfoPerm" />');
		var SHOW_METADATA					= toBoolean('<system:edit show="value" from="theBean" field="showMdlInfoMet" />');
		var MSG_DOC_LOCK_BY_OTH_USR 		= '<system:label show="text" label="msgDocLocOthUsr" forScript="true" forHtml="true"/>';
		
		var FIL_METADATA					= toBoolean('<system:edit show="value" from="theBean" field="filtersMetadata" />');
		
		var MSG_NO_PERM 					= '<system:label show="text" label="msgDocNoPer" forScript="true" forHtml="true"/>';
		
		var ONLY_ONE_DOC_TYPE_PRE_FILTER	= toBoolean('<system:edit show="value" from="theBean" field="onlyOneDocTypePreFilterAndNoFilter" />');
		var FIRST_DOC_TYPE_ID_PRE_FILTER	= '<system:edit show="value" from="theBean" field="firstDocTypeIdPreFilter" />';
		var PRIMARY_SEPARATOR				= new Element('div').set('html', '<system:edit show="constant" from="com.st.util.StringUtil" field="PRIMARY_SEPARATOR"/>').get('text');
		
		var FROM_CUSTOM_DOC_MON_MDL			= true;
		
		var NEW_TAB_ID 						= new Date().getTime(); 
		
		var ALL_PARAMS = {
			objType: '<%= request.getParameter("objType") %>',
			objId: <%= request.getParameter("objId")  %>,
			frmParent: '<%= request.getParameter("frmParent") %>',
			frmId: <%= request.getParameter("frmId") %>,
			frmAttId: <%= request.getParameter("attId") %>,
			frmIndex: <%= request.getParameter("index") %>
		};
		
	</script></head><body style="height: auto !important;"><div class="body queryModal" id="bodyDiv"><form id="queryForm" action="<system:util show="context" />/apia.execution.CustMonDocumentAction.run?forCusDocMonMdl=true&tabId=8<system:util show="tokenIdRequest"/>"  method="post"><input type="hidden" name="action" value="" id="queryFormAction"><%@include file="includes/table.jsp" %><input type="text" style="display: none;"></form></div></body></html>