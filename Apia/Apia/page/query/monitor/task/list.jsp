<%@page import="biz.statum.apia.web.bean.query.MonitorTaskBean"%><%@page import="biz.statum.apia.web.action.query.MonitorTaskAction"%><%@page import="biz.statum.sdk.util.HttpServletRequestResponse"%><%@include file="../../../includes/startInc.jsp" %><html lang="<%=biz.statum.apia.web.bean.BasicBeanStatic.getUserDataStatic(request).getLangCode()%>"><head><%@include file="../../../includes/headInclude.jsp" %><script type="text/javascript" src="<system:util show="context" />/page/query/monitor/task/list.js"></script><script type="text/javascript" src="<system:util show="context" />/page/query/common/queryButtons.js"></script><script type="text/javascript" src="<system:util show="context" />/page/includes/adminFav.js"></script><script type="text/javascript" src="<system:util show="context" />/page/includes/campaigns.js"></script><script type="text/javascript" src="<system:util show="context" />/page/includes/navButtons.js"></script><script type="text/javascript" src="<system:util show="context" />/page/query/common/validateDatesFilters.js"></script><script type="text/javascript">
		var URL_REQUEST_AJAX = '/apia.query.MonitorTaskAction.run';
		var ADDITIONAL_INFO_IN_TABLE_DATA  = false;
		
		var MON_DOC_TAB_TITLE 				= '<system:label show="text" label="mnuMonDoc"/>';
		var URL_REQUEST_AJAX_MON_DOCUMENT 	= '/apia.monitor.MonitorDocumentAction.run';
		
		<%
		HttpServletRequestResponse http = new HttpServletRequestResponse(request,response);
		MonitorTaskBean bean = MonitorTaskAction.staticRetrieveBean(http, false);
		%>
		
		var FROM_MINISITE = <%=bean.getUserData(http).isFromMinisite()%>;
	</script></head><body><div class="body" id="bodyDiv"><form id="queryForm" action="<system:util show="context" />/apia.query.MonitorTaskAction.run?<system:util show="tabIdRequest" />" method="post"><input type="hidden" name="action" value="" id="queryFormAction"><div class="optionsContainer" id="optionsContainer" style="position: absolute;"><system:campaign inLogin="false" inSplash="false" location="verticalUp" /><%@include file="../../common/panelInfo.jsp" %><div class="fncPanel options"><div class="title"><system:label show="text" label="titActions"/></div><div class="content"><div id="btnSearch" class="button suggestedAction" title="<system:label show="text" label="btnSearch" />"><system:label show="text" label="btnSearch" /></div><system:query show="ifFlag" from="theQuery" field="0" defaultValue="qryButtons"><div id="btnExport" class="button" title="<system:label show="text" label="btnExport" />"><system:label show="text" label="btnExport" /></div></system:query><system:query show="ifFlag" from="theQuery" field="18" defaultValue="qryButtons"><div id="btnDetails" class="button" title="<system:label show="text" label="btnMonDet" />"><system:label show="text" label="btnMonDet" /></div></system:query><system:query show="ifFlag" from="theQuery" field="19" defaultValue="qryButtons"><div id="btnHistory" class="button" title="<system:label show="text" label="btnMonHis" />"><system:label show="text" label="btnMonHis" /></div></system:query><system:query show="ifFlag" from="theQuery" field="17" defaultValue="qryButtons"><system:query show="ifValue" from="theBean" field="canViewTask" value="true"><div id="btnTasks" class="button" title="<system:label show="text" label="btnMonTsk" />"><system:label show="text" label="btnMonTsk" /></div></system:query></system:query><div id="btnDocuments" class="button" title="<system:label show="tooltip" label="btnViewDocs" />" style="display: inline-block;"><system:label show="text" label="btnViewDocs" /></div><% if(!bean.getUserData(http).isExternalMode()) { %><div id="btnCloseTab" class="button" title="<system:label show="tooltip" label="btnClose" />"><system:label show="text" label="btnClose" /></div><% } %></div></div><system:query show="ifNotFlag" from="theQuery" field="21"><system:query show="ifValue" from="theBean" field="hasFiltersWithType" value="true"><div class="fncPanel options"><div class="title"><system:label show="text" label="titOptions"/></div><div class="content"><div id="btnFilterType" class="button large"><system:label show="text" label="btnFilterType" /></div></div></div></system:query></system:query><%@include file="../../common/additionalFilters.jsp" %><system:campaign inLogin="false" inSplash="false" location="verticalDown" /></div><div class="gridContainer" id="gridContainer"><system:campaign inLogin="false" inSplash="false" location="horizontalUp" /><%@include file="../../common/columnsHeader.jsp" %><%@include file="../../common/columnsValue.jsp" %><%@include file="../../common/navButtons.jsp" %><system:campaign inLogin="false" inSplash="false" location="horizontalDown" /></div></form></div><%@include file="../../../includes/footer.jsp" %></body></html>
