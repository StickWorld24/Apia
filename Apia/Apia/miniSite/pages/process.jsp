<%@ taglib prefix="system"	uri="/WEB-INF/system-tags.tld" %><%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%><!DOCTYPE html><html><head><title>Apia</title><%@include file="../common/headInclude.jsp" %><!-- Script --><script type="text/javascript" src="<system:util show="context" />/miniSite/pages/process.js"></script><!-- CSS --><link rel="stylesheet" href="<system:util show="context" />/miniSite/css/default/process.css"><link rel="stylesheet" href="<system:util show="context" />/miniSite/css/default/back.css"><script type="text/javascript">
		var CONTEXT					= "<system:util show="context" />";
		var WAIT_A_SECOND			= "<system:label show="text" label="lblEspUnMom" />";
		var ENV_ID 					= "<system:util show="currentEnvId" />";
		var TOKENID					= "<system:util show="tokenId" />";
	</script></head><body><div class="header"><div class="logo"></div></div><div class="message hidden" id="messageContainer"></div><div class="content"><div class="title"><system:label show="text" label="mnuIniPro" /></div><% pageContext.setAttribute("beanName", "viewBean");%><ul><system:edit show="iteration" from="theBean" field="processesForMiniSite" saveOn="processes" ><li><div class="item" onclick="work('<system:edit show="value" from="processes" field="proId" avoidHtmlConvert="true"/>','<system:edit show="value" from="processes" field="entityProcessVo.busEntId" avoidHtmlConvert="true"/>')"><system:edit show="value" from="processes" field="proTitle" avoidHtmlConvert="true"/></div></li></system:edit></ul></div><div class="back" onclick="btnBack_click()"></div></body></html>