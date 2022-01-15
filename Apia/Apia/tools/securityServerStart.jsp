<%@page import="java.util.Date"%><%@page import="com.dogma.security.info.SecurityInformation"%><%@page import="biz.statum.sdk.util.DateUtil"%><%@page import="com.dogma.Configuration"%><%@page import="com.dogma.security.client.SecurityClient"%><%@page import="com.dogma.util.DogmaUtil"%><%@page import="biz.statum.sdk.util.StringUtil"%><%@page import="com.st.db.dataAccess.DBConnection"%><%@page import="com.dogma.security.manager.ServerStart"%><%@page import="com.dogma.dataAccess.DBManagerUtil"%><%
boolean onlyErrorCode = "true".equals(request.getParameter("onlyErrorCode"));
boolean onlyData = "true".equals(request.getParameter("onlyData"));

DBConnection dbConn = null;
boolean serverStarted = false;
String exceptionStackTrace = null;
String licensedTo = "UNREACHABLE LICENSE INFORMATION";
String licensedExpireAt = StringUtil.EMPTY_STRING;
try {
	dbConn = DBManagerUtil.getApiaConnection();
	
	if (onlyData) {
		SecurityClient client = DogmaUtil.getSecurityClient(dbConn, request.getSession());
		client.login(Configuration.SECURITY_MANAGER_APP, "startup", "-1", request.getServerName(), request.getServerPort(), request.getSession().getId());
		client.logout(Configuration.SECURITY_MANAGER_APP, "startup", "-1", request.getServerName(), request.getServerPort(), request.getSession().getId());
		SecurityInformation secInfo = client.getSecurityInformation(Configuration.SECURITY_MANAGER_APP);
		client.cleanConnection();
		if (secInfo != null) {
			licensedTo = secInfo.getCompany();
			licensedExpireAt = DateUtil.formatDateTime(secInfo.getExpirationDate(), DateUtil.FMT_PARAMETER_DATE);
			if(com.st.util.DateUtil.dateDiffDays(secInfo.getExpirationDate(), new Date()) <= 30){
				licensedExpireAt  += " - days left " + com.st.util.DateUtil.dateDiffDays(secInfo.getExpirationDate(), new Date());
			}
		}
		
	} else {
		ServerStart.start(dbConn);
		serverStarted = true;
	}
} catch (Exception e) {
	exceptionStackTrace = StringUtil.toString(e, true);
} finally {
	DBManagerUtil.close(dbConn);
}

if (onlyErrorCode) {
	if (onlyData) {
		%><%= licensedTo + " (exp: " + licensedExpireAt + ")" %><%
	} else {
		response.sendError(serverStarted ? 200 : 500, serverStarted ? "Security Server Running" : "Security Server NOT Running" );
	}
} else { %>
<html>
<head>
	<title>Security Server Start</title>
	<style type="text/css">
		body		{ font-family: verdana; font-size: 10px; }
		a			{ text-decoration: none; color: blue; }
	</style>
</head>

<body>
	<% if (onlyData) { %>
		License to: <%= licensedTo %><br>
		Expiration date: <%= licensedExpireAt %><br>
		<a href="?onlyData=true">Refresh</a><%
	} else {
		if (serverStarted) { %>
			Server is running.
		<% } else { %>
			Server is not running.
			<% if (StringUtil.notEmpty(exceptionStackTrace)) { %>
				<%= exceptionStackTrace %>
			<% } %>
		<% } %>
		<br>
		<a href="?">Refresh</a><%
	} %>
</body>
</html><%
} %>