<%@page import="biz.statum.apia.web.bean.query.QueryExecutionBean"%><%@page import="biz.statum.apia.web.action.query.QueryExecutionAction"%><%@include file="../../includes/startInc.jsp" %><html lang="<%=biz.statum.apia.web.bean.BasicBeanStatic.getUserDataStatic(request).getLangCode()%>"><%
QueryExecutionBean qBean = QueryExecutionAction.getBean(request,response); 
%><head><%@include file="../../includes/headInclude.jsp" %><% if (qBean!=null && qBean.isFromModal()) { %><system:query show="saveAValue" value="true" saveOn="modalQuery" /><% } %><script type="text/javascript" src="<system:util show="context" />/page/query/user/list.js"></script><script type="text/javascript" src="<system:util show="context" />/page/includes/adminFav.js"></script><script type="text/javascript" src="<system:util show="context" />/page/includes/campaigns.js"></script><script type="text/javascript" src="<system:util show="context" />/page/query/common/queryButtons.js"></script><script type="text/javascript">
		var URL_REQUEST_AJAX = '/apia.query.UserAction.run';
		var ADDITIONAL_INFO_IN_TABLE_DATA  = false;
	</script></head><body><div class="header"></div><div class="body" id="bodyDiv"><div class="optionsContainer"><system:campaign inLogin="false" inSplash="false" location="verticalUp" /><system:campaign inLogin="false" inSplash="false" location="verticalDown" /></div><div class="gridContainer" id="gridErrMsgs"><system:campaign inLogin="false" inSplash="false" location="horizontalUp" /><system:query show="iteration" from="theBean" field="messagesToShow" saveOn="message"><system:edit show="value" from="message" /></system:query><system:campaign inLogin="false" inSplash="false" location="horizontalDown" /></div></div></body></html>