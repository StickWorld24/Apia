<%@ page language="java" contentType="text/html; charset=ISO-8859-1" pageEncoding="ISO-8859-1"%><%@page import="java.util.Date"%><%@page import="com.dogma.UserData"%><%@include file="../../components/scripts/server/startInc.jsp" %><%
	UserData usrData = BasicBeanStatic.getUserDataStatic(request);
	Integer ident = usrData.getLangId();
%><% if (ident==1){%><a class="skbServices" href="ViewItemAction.do?action=view&id=1459">Distribuci�n de clases de negocio</a><br><a class="skbServices" href="ViewItemAction.do?action=view&id=485">Manual del Programador</a><br><a class="skbServices" href="ViewItemAction.do?action=view&id=495">JavaDoc de la API de Apia</a><br><a class="skbServices" href="ViewItemAction.do?action=view&id=439">Manual de Arquitectura de Apia</a><br><a class="skbServices" href="ViewItemAction.do?action=view&id=1048">Apia Framework</a><br><a class="skbServices" href="ViewItemAction.do?action=view&id=1082">Convenciones de codificaci�n para Proyectos Apia</a><br><a class="skbServices" href="ViewItemAction.do?action=view&id=1252">Configuraci�n de entornos de trabajo para Apia en Eclipse IDE</a><% }else if (ident==3){%><a class="skbServices" href="ViewItemAction.do?action=view&id=1459">Business classes distribution</a><br><a class="skbServices" href="ViewItemAction.do?action=view&id=485">Apia's Programmer's handbook</a><br><a class="skbServices" href="ViewItemAction.do?action=view&id=495">JavaDoc of the API of Apia</a><br><a class="skbServices" href="ViewItemAction.do?action=view&id=439">Apia's architecture handbook</a><br><a class="skbServices" href="ViewItemAction.do?action=view&id=1048">Apia Framework</a><br><a class="skbServices" href="ViewItemAction.do?action=view&id=1082">Convenciones de codificaci�n para Proyectos Apia</a><br><a class="skbServices" href="ViewItemAction.do?action=view&id=1252">Setting working environments for Apia in Eclipse IDE</a><br><% }else if (ident==2){%><a class="skbServices" href="ViewItemAction.do?action=view&id=1459">Distribui��o de classes de neg�cio</a><br><a class="skbServices" href="ViewItemAction.do?action=view&id=485">Manual do programador do Apia</a><br><a class="skbServices" href="ViewItemAction.do?action=view&id=495">JavaDoc do API do Apia</a><br><a class="skbServices" href="ViewItemAction.do?action=view&id=439">Manual de arquitetura do Apia</a><br><a class="skbServices" href="ViewItemAction.do?action=view&id=1048">Apia Framework</a><br><a class="skbServices" href="ViewItemAction.do?action=view&id=1082">Conven��es de codifica��o para Projetos Apia</a><br><a class="skbServices" href="ViewItemAction.do?action=view&id=1252">Configura��o de ambientes de trabalho para o Apia em Eclipse IDE</a><br><% }%>

