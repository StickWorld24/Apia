<%@ taglib uri='/WEB-INF/regions.tld' prefix='region' %><%@page import="com.dogma.vo.*"%><%@page import="com.dogma.bean.execution.*"%><%@page import="java.util.*"%><%@include file="../../../components/scripts/server/startInc.jsp" %><region:render template='/templates/resultTemplate.jsp'><region:put section='title'><%=" "%></region:put><region:put section='message'><%=" "%></region:put><region:put section='navigate'>true</region:put><region:put section='closeAutomatically'>true</region:put><region:put section='nextUrl'>/administration.BPMNAction.do?action=backToListWOk<%if(request.getParameter("windowId")!=null){%>&windowId=<%=request.getParameter("windowId")%><%}%></region:put><region:put section='btnSalir'>false</region:put></region:render><%@include file="../../../components/scripts/server/endInc.jsp" %>

