<%@ page contentType="text/html; charset=iso-8859-1" language="java"%><%@page import="com.dogma.UserData"%><%@include file="../../components/scripts/server/startInc.jsp" %><%
	UserData usrData = BasicBeanStatic.getUserDataStatic(request);
	Integer ident = usrData.getLangId();
%><% if (ident==1){%><a class="skbServices" href="http://www.statum.org/ATutor/about.php?lang=es" target="_new">Cursos de Apia</a><br><a class="skbServices" href="http://www.processlibrary.biz/" target="_new">Biblioteca de procesos</a><br><a class="skbServices" href="http://www.statum.biz/web/guest/apiaonline1" target="_new">Apia Online</a><br><% }else if (ident==3){%><a class="skbServices" href="http://www.statum.org/ATutor/about.php?lang=en" target="_new">Apia Courses</a><br><a class="skbServices" href="http://www.processlibrary.biz/" target="_new">Processes library</a><br><a class="skbServices" href="http://www.statum.biz/web/guest/apiaonline1" target="_new">Apia Online</a><br><% }else if (ident==2){%><a class="skbServices" href="http://www.statum.org/ATutor/about.php?lang=pt-br" target="_new">Cursos do Apia</a><br><a class="skbServices" href="http://www.processlibrary.biz/" target="_new">Biblioteca de processos</a><br><a class="skbServices" href="http://www.statum.biz/web/guest/apiaonline1" target="_new">Apia Online</a><br><% }%>
