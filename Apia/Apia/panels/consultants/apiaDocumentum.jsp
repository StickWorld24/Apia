<%@page import="biz.statum.apia.web.tag.TagUtils"%><%@page import="biz.statum.sdk.util.HttpServletRequestResponse"%><%@ page contentType="text/html; charset=iso-8859-1" language="java"%><%@page import="com.dogma.UserData"%><%@include file="../../components/scripts/server/startInc.jsp" %><%
	UserData usrData = BasicBeanStatic.getUserDataStatic(request);
	Integer ident = usrData.getLangId();
%><table border="0" width="100%"><tr><td valign="top"><% if (ident==1){%><a class="skbServices" href="/item/apia/ADF00057">Presentaci�n para usuarios de ApiaDocumentum</a><br><a class="skbServices" href="/item/apia/ADF00059">Folleto de ApiaDocumentum</a><br><a class="skbServices" href="/item/apia/ADF00056">Manual de usuario de Resoluciones de Directorio (anexo ApiaDocumentum)</a><br><a class="skbServices" href="/item/apia/ADF00055">Manual de usuarios de ApiaDocumentum</a><br><a class="skbServices" href="/item/apia/ADF00063">Presentaci�n para administradores de ApiaDocumentum</a><br><a class="skbServices" href="/item/apia/ADF00062">Manual de administradores de ApiaDocumentum</a><br><% }else if (ident==3){%><a class="skbServices" href="/item/apia/ADF00057">Presentation of Apia Documentum</a><br><a class="skbServices" href="/item/apia/ADF00059">ApiaDocumentum brochure</a><br><a class="skbServices" href="/item/apia/ADF00056">Board resolutions user's handbook (annexe ApiaDocumentum) </a><br><a class="skbServices" href="/item/apia/ADF00055">ApiaDocumentum user's handbook</a><br><a class="skbServices" href="/item/apia/ADF00063">Presentation for ApiaDocumentum's administrators</a><br><a class="skbServices" href="/item/apia/ADF00062">ApiaDocumentum administrators' handbook</a><br><% }else if (ident==2){%><a class="skbServices" href="/item/apia/ADF00057">Apresenta��o do ApiaDocumentum</a><br><a class="skbServices" href="/item/apia/ADF00059">Folheto do ApiaDocumentum</a><br><a class="skbServices" href="/item/apia/ADF00056">Manual de usu�rio de Resolu��es de Diret�rio (anexo ApiaDocumentum)</a><br><a class="skbServices" href="/item/apia/ADF00055">Manual do usu�rio do ApiaDocumentum</a><br><a class="skbServices" href="/item/apia/ADF00063">Apresenta��o para administradores do ApiaDocumentum</a><br><a class="skbServices" href="/item/apia/ADF00062">Manual dos administradores do ApiaDocumentum</a><br><% }%><br><% if (ident==1){%><a class="skbServices" href="http://www.statum.org/ATutor/about.php?lang=es" target="_blank">Curso de ApiaDocumentum</a><br><% }else if (ident==3){%><a class="skbServices" href="http://www.statum.org/ATutor/about.php?lang=en" target="_blank">ApiaDocumentum courses</a><br><% }else if (ident==2){%><a class="skbServices" href="http://www.statum.org/ATutor/about.php?lang=pt-br" target="_blank">Curso do ApiaDocumentum</a><br><% }%></td><td valign="top" align="right"><%String img_src = TagUtils.getContext(new HttpServletRequestResponse(request, response)) + "/panels/consultants/apiaDocumentum.jpg"; %><img src=<%=img_src%>></td></tr></table>