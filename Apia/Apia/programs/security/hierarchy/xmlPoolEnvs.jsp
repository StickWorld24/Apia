<%@page import="com.dogma.XMLTags"%><%@page import="com.dogma.bean.*"%><%@page import="com.dogma.vo.*"%><%@page import="com.dogma.*"%><%@page import="java.util.*"%><%@page import="com.st.util.StringUtil"%><jsp:useBean id="dBean" scope="session" class="com.dogma.bean.security.GroupHierarchyBean"><%dBean.addMessage(new DogmaException(DogmaException.USR_NOT_LOGGED));%></jsp:useBean><%
response.setHeader("Pragma","no-cache");
response.setHeader("Cache-Control","no-store");
response.setDateHeader("Expires",-1); 
if (!dBean.hasMessages()) {
	String xml = "";
	xml = dBean.getPoolEnvsXML(request.getParameter("poolId"));
	out.clear();
	out.print(xml);
} else {
	out.print(dBean.getMessagesAsXml(request));
	dBean.clearMessages();
}
%>