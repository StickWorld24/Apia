<%@page import="biz.statum.sdk.util.HttpServletRequestResponse"%><%@page import="biz.statum.apia.web.action.monitor.ChatAction"%><%@page import="biz.statum.apia.web.bean.monitor.ChatBean"%><%@include file="../../includes/startInc.jsp" %><html lang="<%=biz.statum.apia.web.bean.BasicBeanStatic.getUserDataStatic(request).getLangCode()%>"><head><%@include file="../../includes/headInclude.jsp" %><script type="text/javascript" src="<system:util show="context" />/page/monitor/chat/list.js"></script><script type="text/javascript" src="<system:util show="context" />/page/includes/adminFav.js"></script><script type="text/javascript" src="<system:util show="context" />/page/includes/adminActions.js"></script><script type="text/javascript" src="<system:util show="context" />/page/includes/navButtons.js"></script><script type="text/javascript" src="<system:util show="context" />/page/includes/campaigns.js"></script><%
String participantsFilter = request.getParameter("txtParticipant");
ChatBean bean = ChatAction.staticRetrieveBean(new HttpServletRequestResponse(request, response));
%><script type="text/javascript">
		var URL_REQUEST_AJAX = '/apia.monitor.ChatAction.run';
		var ADDITIONAL_INFO_IN_TABLE_DATA  = false;
		var CONFIGURATION_OK	= <system:edit show="value" from="theBean" field="chatConfigurationOk" />;
	</script></head><body><div class="body" id="bodyDiv"><div class="optionsContainer" id="optionsContainer"><system:campaign inLogin="false" inSplash="false" location="verticalUp" /><div class="fncPanel info"><div class="title"><span><system:label show="text" label="titMonChat" /></span><span class="panelPinShow" id="panelPinShow">&nbsp;</span><span class="panelPinHidde" id="panelPinHidde">&nbsp;</span><%@include file="../../includes/adminFav.jsp" %></div><div class="content divFncDescription"><div class="fncDescriptionImage" data-src="<system:edit show="value" from="theBean" field="fncImage"/>"></div><div id="fncDescriptionText"><system:label show="text" label="dscFncMonChat"/></div><div class="clear"></div></div></div><div class="fncPanel buttons"><div class="title"><system:label show="text" label="titActions"/></div><div class="content"><div id="btnView" class="button suggestedAction"><system:label show="text" label="btnView" /></div></div></div><div class="fncPanel options lastOptions"><div class="title" title="<system:label show="tooltip" label="titAdmAdtFilter"/>"><system:label show="text" label="titAdmAdtFilter"/></div><div class="content"><div class="filter"><span><system:label show="text" label="lblMonBroadChatSentBetween" />:</span><input id="dateFilterStart" type="text" class="datePicker datePickerChecker filterInputDate"   size="9" maxlength="10" value="<system:filter show="value" filter="0"></system:filter>">
						-
						<input id="dateFilterEnd" type="text" class="datePicker datePickerChecker filterInputDate"   size="9" maxlength="10"   value="<system:filter show="value" filter="1"></system:filter>"></div><system:edit show="ifValue" from="theBean" field="chatIndexActive" value="true"><% if(participantsFilter == null && !bean.getHideParticipants()) { %><div class="filter"><span><system:label show="text" label="lblMonChatFilPart" />:</span><input type="text" id="participantFilter" value="<system:filter show="value" filter="3"></system:filter>"></div><% } %><div class="filter"><span><system:label show="text" label="lblMonChatFilMsg" />:</span><input type="text" id="messageFilter" value="<system:filter show="value" filter="4"></system:filter>"></div></system:edit></div></div><system:campaign inLogin="false" inSplash="false" location="verticalDown" /></div><div class="gridContainer" id="gridContainer"><system:campaign inLogin="false" inSplash="false" location="horizontalUp" /><div class="gridHeader" id="gridHeader"><!-- Cabezal y filtros --><table><thead><tr id="trOrderBy" class="header"><th title="<system:label show="tooltip" label="lblMonChatResStart" />"><div style="width: 150px"><system:label show="text" label="lblMonChatResStart"/></div></th><th title="<system:label show="tooltip" label="lblMonChatResSubject" />"><div style="width: 400px"><system:label show="text" label="lblMonChatResSubject" /></div></th><th title="<system:label show="tooltip" label="lblMonChatResSize" />"><div style="width: 70px"><system:label show="text" label="lblMonChatResSize" /></div></th></tr><system:edit show="ifValue" from="theBean" field="chatIndexActive" value="true"><tr class="filter"><th><div style="width: 150px">&nbsp;</div></th><th title="<system:label show="tooltip" label="lblMonChatResSubject" />"><div style="width: 400px"><input id="subjectFilter" type="text" value="<system:filter show="value" filter="2"></system:filter>"></div></th><th><div style="width: 70px">&nbsp;</div></th></tr></system:edit></thead></table></div><div class="gridBody" id="gridBody"><!-- Cuerpo de la tabla --><table><thead><tr><th width="150px"></th><th width="400px"></th><th width="70px"></th></tr></thead><tbody class="tableData" id="tableData"></tbody></table></div><div class="gridFooter"><%@include file="../../includes/navButtons.jsp" %></div><!-- MESSAGES --><div class="message hidden" id="messageContainer"></div><system:campaign inLogin="false" inSplash="false" location="horizontalDown" /></div></div><%@include file="../../includes/footer.jsp" %></body></html>