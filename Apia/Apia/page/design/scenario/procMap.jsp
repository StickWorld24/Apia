<%@page import="com.dogma.Parameters"%><%@page import="biz.statum.apia.web.bean.design.ScenarioBean"%><%@page import="biz.statum.apia.web.action.design.ScenarioAction"%><%@page import="biz.statum.sdk.util.HttpServletRequestResponse"%><%@page import="com.st.util.StringUtil"%><%@include file="../../includes/startInc.jsp" %><html lang="<%=biz.statum.apia.web.bean.BasicBeanStatic.getUserDataStatic(request).getLangCode()%>"><head><%@include file="../../includes/headInclude.jsp" %><script type="text/javascript" src="<system:util show="context" />/page/design/scenario/procMap.js"></script><script type="text/javascript" src="<system:util show="context" />/page/design/bpmn/flash.js"></script></head><%
	String tabId = "&tabId=" + request.getParameter("tabId") + "&tokenId=" + uData.getTokenId();
	ScenarioBean dBean = (ScenarioBean)ScenarioAction.staticRetrieveBean(new HttpServletRequestResponse(request, response));	
%><script type="text/javascript">
	var URL_REQUEST_AJAX = '/apia.design.ScenarioAction.run';
</script><div id="pDesignerContainer" style="width: 100%"><object classid="clsid:d27cdb6e-ae6d-11cf-96b8-444553540000"  id="Designer" codebase="http://fpdownload.macromedia.com/pub/shockwave/cabs/flash/swflash.cab#version=10,0,0,0" WIDTH="98%" HEIGHT="500px" style="/*border:1px solid blue*/" ALIGN="center" VALIGN="middle"><param name="allowScriptAccess" value="allways" /><param name="movie" value="<%=Parameters.ROOT_PATH%>/flash/BPMN/Simulator.swf" /><param name="FlashVars" value="elementAtts=<%=Parameters.ROOT_PATH%>/flash/BPMN/simulatorElementAttributes.jsp?tabId=<system:util show="tabId" />%26tokenId=<system:util show="tokenId" />&urlBase=<%=Parameters.ROOT_PATH%>/flash/BPMN/"/><param name="quality" value="high" /><param name="menu" value="false"><param name="bgcolor" value="#EFEFEF" /><param name="WMODE" value="transparent" /><embed wmode="transparent" id="Designer" name="Designer" menu="false" allowScriptAccess="allways" src="<%=Parameters.ROOT_PATH%>/flash/BPMN/Simulator.swf" flashVars="elementAtts=<%=Parameters.ROOT_PATH%>/flash/BPMN/simulatorElementAttributes.jsp?tabId=<system:util show="tabId" />%26tokenId=<system:util show="tokenId" />&urlBase=<%=Parameters.ROOT_PATH%>/flash/BPMN/" quality="high" bgcolor="#efefef" width="98%" height="450" swLiveConnect="true"   align="middle" type="application/x-shockwave-flash" pluginspage="http://www.macromedia.com/go/getflashplayer" /></object><div width=100% style="display: none;"><TEXTAREA p_required="true" name="txtMap" id="txtMap" cols="100" rows="30"><%=StringUtil.replace(dBean.getProcessXml(), "&", "&amp;")%></TEXTAREA><TEXTAREA p_required="true" name="txtSimulation" id="txtSimulation" cols="100" rows="30"><%=StringUtil.replace(dBean.getSimulatorXml(), "&", "&amp;")%></TEXTAREA><input type=hidden name="txtProId" value="<%=dBean.getActualProId()%>"></div></div>					