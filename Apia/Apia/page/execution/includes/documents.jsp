<%@ taglib uri='/WEB-INF/regions.tld' prefix='region' %><%@ taglib prefix="system"	uri="/WEB-INF/system-tags.tld" %><div class="tabContent"><div class="fieldGroup"><div class="title"><%if("E".equals(request.getParameter("frmParent"))){ %><system:label show="text" label="sbtEjeDocEnt" /><%} else { %><system:label show="text" label="sbtEjeDocPro" /><%}%></div><%@include file="../../generic/documents.jsp"%></div></div>