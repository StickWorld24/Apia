<%@page import="com.dogma.Configuration"%>
<%@page import="biz.statum.apia.framework.splash.panels.PanelExecutionClass.Device"%>
<%@page import="com.dogma.controller.ThreadData"%>
<%@page import="biz.statum.apia.web.action.BasicAction"%>
<%@page import="biz.statum.sdk.util.BooleanUtils"%>
<%@page import="com.dogma.Parameters"%>
<%
boolean externalMode = BooleanUtils.isTrue(request.getParameter("external"));

if (!Parameters.LOGIN_USE_DASHBOARD || externalMode) {%>
	<%@include file="classic/login.jsp" %>
<%} else { %> 
	<%@include file="portal/portal.jsp" %>
<%}%>