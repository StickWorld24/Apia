<%@ page contentType="text/html; charset=iso-8859-1" language="java"%><%@page import="com.dogma.UserData"%><%@include file="../../components/scripts/server/startInc.jsp" %><%
	UserData usrData = BasicBeanStatic.getUserDataStatic(request);
	Integer ident = usrData.getLangId();
%><% if (ident==1){%><a class="skbServices" href="ViewItemAction.do?action=view&id=1258">Descargue ApiaOnaBox Versi�n 2.4.0 - Virtual</a><br><a class="skbServices" href="ViewItemAction.do?action=view&id=1261">Descargue ApiaOnaBox Versi�n 2.4.0 - Windows</a><br><br><a class="skbServices" href="ViewItemAction.do?action=view&id=1236">Manual de usuario de Apia 2.4</a><br><% }else if (ident==3){%><a class="skbServices" href="ViewItemAction.do?action=view&id=1258">Download ApiaOnaBox Version 2.4.0 - Virtual</a><br><a class="skbServices" href="ViewItemAction.do?action=view&id=1261">Download ApiaOnaBox Version 2.4.0 - Windows</a><br><br><a class="skbServices" href="ViewItemAction.do?action=view&id=1236">Apia's 2.4 user's handbook</a><br><% }else if (ident==2){%><a class="skbServices" href="ViewItemAction.do?action=view&id=1258">Download ApiaOnaBox Vers�o 2.4.0 - Virtual</a><br><a class="skbServices" href="ViewItemAction.do?action=view&id=1261">Download ApiaOnaBox Vers�o 2.4.0 - Windows</a><br><br><a class="skbServices" href="ViewItemAction.do?action=view&id=1236">Manual do usu�rio do Apia 2.4</a><br><% }%>