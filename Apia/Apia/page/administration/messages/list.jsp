<%@include file="../../includes/startInc.jsp" %><html lang="<%=biz.statum.apia.web.bean.BasicBeanStatic.getUserDataStatic(request).getLangCode()%>"><head><%@include file="../../includes/headInclude.jsp" %><script type="text/javascript" src="<system:util show="context" />/page/administration/messages/list.js"></script><script type="text/javascript" src="<system:util show="context" />/page/includes/adminFav.js"></script><script type="text/javascript" src="<system:util show="context" />/page/includes/adminActions.js"></script><script type="text/javascript" src="<system:util show="context" />/page/includes/navButtons.js"></script><script type="text/javascript" src="<system:util show="context" />/page/includes/campaigns.js"></script><script type="text/javascript">
		var URL_REQUEST_AJAX = '/apia.administration.MessagesAction.run';
		var ADDITIONAL_INFO_IN_TABLE_DATA  = false;
		var MSG_INIT_MSG	= '<system:label show="text" label="msgIniMsg" forScript="true" />';
		var BTN_CONFIRM	= '<system:label show="text" label="btnCon" forScript="true" />';
	</script></head><body><div class="body" id="bodyDiv"><div class="optionsContainer"><system:campaign inLogin="false" inSplash="false" location="verticalUp" /><div class="fncPanel info"><div class="title"><system:edit show="ifValue" from="theBean" field="modeGlobal" value="true"><system:label show="text" label="mnuMen" /></system:edit><system:edit show="ifValue" from="theBean" field="modeGlobal" value="false"><system:label show="text" label="mnuMenAmb" /></system:edit><%@include file="../../includes/adminFav.jsp" %></div><div class="content divFncDescription"><div class="fncDescriptionImage" data-src="<system:edit show="value" from="theBean" field="fncImage"/>"></div><div id="fncDescriptionText"><system:label show="text" label="dscFncAdmNot" /></div><div class="clear"></div></div></div><div class="fncPanel buttons"><div class="title"><system:label show="text" label="sbtQryAct" /></div><div class="content"><div id="btnCreate" class="button suggestedAction" title="<system:label show="text" label="btnCre" />"><system:label show="text" label="btnCre" /></div><div id="btnUpdate" class="button" title="<system:label show="text" label="btnMod" />"><system:label show="text" label="btnMod" /></div><div id="btnDelete" class="button" title="<system:label show="text" label="btnEli" />"><system:label show="text" label="btnEli" /></div><div id="btnInit" class="button" title="<system:label show="text" label="btnIni" />"><system:label show="text" label="btnIni" /></div><div id="btnCloseTab" class="button" title="<system:label show="tooltip" label="btnClose" />"><system:label show="text" label="btnClose" /></div></div></div><system:campaign inLogin="false" inSplash="false" location="verticalDown" /></div><div class="gridContainer"><system:campaign inLogin="false" inSplash="false" location="horizontalUp" /><div class="gridHeader" id="gridHeader"><!-- Cabezal y filtros --><table><thead><tr id="trOrderBy" class="header"><system:edit show="ifValue" from="theBean" field="modeGlobal" value="true"><th id="orderByEnv" class="allowSort sort<system:filter show="sortStyle" from="com.dogma.vo.filter.MessageFilterVo" field="ORDER_ENVIRONMENT"/>" data-sortBy="<system:edit show="constant" from="com.dogma.vo.filter.MessageFilterVo" field="ORDER_ENVIRONMENT"/>" title="<system:label show="tooltip" label="lblAmb" />"><div style="width: 150px"><system:label show="text" label="lblAmb" /></div></th></system:edit><th id="orderByDteFrom" class="allowSort sort<system:filter show="sortStyle" from="com.dogma.vo.filter.MessageFilterVo" field="ORDER_DATE_START"/>" data-sortBy="<system:edit show="constant" from="com.dogma.vo.filter.MessageFilterVo" field="ORDER_DATE_START"/>" title="<system:label show="tooltip" label="lblEjeFchDes" />"><div style="width: 100px"><system:label show="text" label="lblEjeFchDes" /></div></th><th id="orderByDteTo" class="allowSort sort<system:filter show="sortStyle" from="com.dogma.vo.filter.MessageFilterVo" field="ORDER_DATE_END"/>" data-sortBy="<system:edit show="constant" from="com.dogma.vo.filter.MessageFilterVo" field="ORDER_DATE_END"/>" title="<system:label show="tooltip" label="lblEjeFchHas" />"><div style="width: 100px"><system:label show="text" label="lblEjeFchHas" /></div></th><th id="orderByMessage" class="allowSort sort<system:filter show="sortStyle" from="com.dogma.vo.filter.MessageFilterVo" field="ORDER_MESSAGE"/>" data-sortBy="<system:edit show="constant" from="com.dogma.vo.filter.MessageFilterVo" field="ORDER_MESSAGE"/>" title="<system:label show="tooltip" label="lblTexMen" />"><div style="width: 220px"><system:label show="text" label="lblTexMen" /></div></th><th id="orderByRegUser" class="allowSort sort<system:filter show="sortStyle" from="com.dogma.vo.filter.MessageFilterVo" field="ORDER_USER"/>" data-sortBy="<system:edit show="constant" from="com.dogma.vo.filter.MessageFilterVo" field="ORDER_USER"/>" title="<system:label show="tooltip" label="lblLastUsrName" />"><div style="width: 100px"><system:label show="text" label="lblLastUsrName" /></div></th><th id="orderByRegDate" class="allowSort sort<system:filter show="sortStyle" from="com.dogma.vo.filter.MessageFilterVo" field="ORDER_DATE"/>" data-sortBy="<system:edit show="constant" from="com.dogma.vo.filter.MessageFilterVo" field="ORDER_DATE"/>" title="<system:label show="tooltip" label="lblLastActDate" />"><div style="width: 100px"><system:label show="text" label="lblLastActDate" /></div></th></tr><tr class="filter"><system:edit show="ifValue" from="theBean" field="modeGlobal" value="true"><th title="<system:label show="tooltip" label="lblAmb" />"><div style="width: 150px"><select id="cmbEnvFilter" onchange="setFilter()" name="cmbEnvFilter" value="<system:filter show="value" filter="0"></system:filter>"><option></option><system:util show="prepareEnvironments" saveOn="environments" /><system:edit show="iteration" from="environments" saveOn="environment"><option value="<system:edit show="value" from="environment" field="envId"/>"><system:edit show="value" from="environment" field="envTitle"/></option></system:edit></select></div></th></system:edit><th title="<system:label show="tooltip" label="lblEjeFchDes" />"><div style="width: 100px"><input id="dteFromFilter" type="text" class="datePicker datePickerChecker filterInputDate"  value="<system:filter show="value" filter="1"></system:filter>"></div></th><th title="<system:label show="tooltip" label="lblEjeFchHas" />"><div style="width: 100px"><input id="dteToFilter" type="text" class="datePicker datePickerChecker filterInputDate"  value="<system:filter show="value" filter="2"></system:filter>"></div></th><th title="<system:label show="tooltip" label="lblTexMen" />"><div style="width: 220px"><input id="msgFilter" type="text" value="<system:filter show="value" filter="3"></system:filter>"></div></th><th title="<system:label show="tooltip" label="lblLastUsrName" />"><div style="width: 100px"><input id="regUsrFilter" type="text" value="<system:filter show="value" filter="4"></system:filter>"></div></th><th title="<system:label show="tooltip" label="lblLastActDate" />"><div style="width: 100px"><input id="regDateFilter" type="text" class="datePicker filterInputDate"  value="<system:filter show="value" filter="5"></system:filter>"></div></th></tr></thead></table></div><div class="gridBody" id="gridBody"><!-- Cuerpo de la tabla --><table><thead><tr><system:edit show="ifValue" from="theBean" field="modeGlobal" value="true"><th width="150px"></th></system:edit><th width="100px"></th><th width="100px"></th><th width="220px"></th><th width="100px"></th><th width="100px"></th></tr></thead><tbody class="tableData" id="tableData"></tbody></table></div><div class="gridFooter"><%@include file="../../includes/navButtons.jsp" %></div><!-- MESSAGES --><div class="message hidden" id="messageContainer"></div><system:campaign inLogin="false" inSplash="false" location="horizontalDown" /></div></div><%@include file="../../includes/footer.jsp" %></body></html>