<%@page import="biz.statum.apia.web.action.query.ProcessCancelationAction"%><%@page import="biz.statum.apia.web.bean.query.ProcessCancelationBean"%><%@page import="biz.statum.sdk.util.HttpServletRequestResponse"%><%@include file="../../../includes/startInc.jsp" %><html lang="<%=biz.statum.apia.web.bean.BasicBeanStatic.getUserDataStatic(request).getLangCode()%>"><head><%@include file="../../../includes/headInclude.jsp" %><system:query show="saveAValue" value="false" saveOn="modalQuery" /><script type="text/javascript" src="<system:util show="context" />/page/query/process/cancelation/list.js"></script><script type="text/javascript" src="<system:util show="context" />/page/query/common/queryButtons.js"></script><script type="text/javascript" src="<system:util show="context" />/page/includes/adminFav.js"></script><script type="text/javascript" src="<system:util show="context" />/page/includes/campaigns.js"></script><script type="text/javascript" src="<system:util show="context" />/page/includes/navButtons.js"></script><script type="text/javascript" src="<system:util show="context" />/page/query/common/validateDatesFilters.js"></script><script type="text/javascript">
		var URL_REQUEST_AJAX = '/apia.query.ProcessCancelationAction.run';
		var ADDITIONAL_INFO_IN_TABLE_DATA  = false;
		var PRO_ID = <system:edit show="value" from="theBean" field="proId"/>;
		
		<%
		HttpServletRequestResponse http = new HttpServletRequestResponse(request,response);
		ProcessCancelationBean bean = ProcessCancelationAction.staticRetrieveBean(http, false);
		%>
		
		var FROM_MINISITE = <%=bean.getUserData(http).isFromMinisite()%>;
	</script></head><body><div class="body" id="bodyDiv"><form id="queryForm" action="<system:util show="context" />/apia.query.ProcessCancelationAction.run?<system:util show="tabIdRequest" />" method="post"><input type="hidden" name="action" value="" id="queryFormAction"><div class="optionsContainer" id="optionsContainer" style="position: absolute;"><system:campaign inLogin="false" inSplash="false" location="verticalUp" /><div class="fncPanel info"><div class="title"><span><system:edit show="value" from="theBean" field="cancelProcessTitle"/></span><span class="panelPinShow" id="panelPinShow">&nbsp;</span><span class="panelPinHidde" id="panelPinHidde">&nbsp;</span><%@include file="../../../includes/adminFavQuery.jsp" %></div><div class="content divFncDescription"><div class="fncDescriptionImgUsers" style="background-image: url('<system:edit show="value" from="theBean" field="cancelProcessImg"/>');"></div><div id="fncDescriptionText"><system:edit show="value" from="theBean" field="cancelProcessDesc"/></div><div class="clear"></div></div></div><div class="fncPanel options"><div class="title"><system:label show="text" label="titActions"/></div><div class="content"><div id="btnSearch" class="button suggestedAction"><system:label show="text" label="btnSearch" /></div><system:query show="ifFlag" from="theQuery" field="16" defaultValue="qryButtons"><div id="btnCancel" class="button"><system:label show="text" label="btnCancel" /></div></system:query><system:query show="ifFlag" from="theQuery" field="0" defaultValue="qryButtons"><div id="btnExport" class="button"><system:label show="text" label="btnExport" /></div></system:query><% if(!bean.getUserData(http).isExternalMode()) { %><div id="btnCloseTab" class="button" title="<system:label show="tooltip" label="btnClose" />"><system:label show="text" label="btnClose" /></div><% } %></div></div><system:query show="ifNotFlag" from="theQuery" field="21"><system:query show="ifValue" from="theBean" field="hasFiltersWithType" value="true"><div class="fncPanel options lastOptions"><div class="title"><system:label show="text" label="titOptions"/></div><div class="content"><div id="btnFilterType" class="button large"><system:label show="text" label="btnFilterType" /></div></div></div></system:query></system:query><%@include file="../../common/additionalFilters.jsp" %><system:campaign inLogin="false" inSplash="false" location="verticalDown" /></div><div class="gridContainer" id="gridContainer"><system:campaign inLogin="false" inSplash="false" location="horizontalUp" /><%@include file="../../common/columnsHeader.jsp" %><%@include file="../../common/columnsValue.jsp" %><%@include file="../../common/navButtons.jsp" %><system:campaign inLogin="false" inSplash="false" location="horizontalDown" /></div></form></div><%@include file="../../../includes/footer.jsp" %></body></html>
