<%@include file="../../includes/startInc.jsp" %><html lang="<%=biz.statum.apia.web.bean.BasicBeanStatic.getUserDataStatic(request).getLangCode()%>"><head><%@include file="../../includes/headInclude.jsp" %><script type="text/javascript" src="<system:util show="context" />/page/monitor/entities/list.js"></script><script type="text/javascript" src="<system:util show="context" />/page/includes/navButtons.js"></script><script type="text/javascript" src="<system:util show="context" />/page/includes/adminFav.js"></script><script type="text/javascript" src="<system:util show="context" />/page/includes/campaigns.js"></script><script type="text/javascript">
		var URL_REQUEST_AJAX = '/apia.monitor.EntitiesAction.run';
		var ADDITIONAL_INFO_IN_TABLE_DATA  = true;		
		var NO_RESULT = '<system:label show="tooltip" label="lblNoRet" forScript="true" />';
		var RESET = '<system:edit show="value" from="theRequest" field="reset" />';
		var GNR_REQUIRED	= '<system:label show="text" label="msgReq" forScript="true" />';
		var ENT_NUM = '<system:label show="tooltip" label="lblEjeTip" forScript="true" />';
		var MODIFIED_DATE_FROM = '<system:label show="tooltip" label="lblMonEntFilActFrom" forScript="true" />';
		var GNR_NUMERIC = '<system:label show="text" label="msgNum" forScript="true" />';
		
		var MON_DOC_TAB_TITLE 				= '<system:label show="text" label="mnuMonDoc"/>';
		var URL_REQUEST_AJAX_MON_DOCUMENT 	= '/apia.monitor.MonitorDocumentAction.run';
	</script></head><body><div class="body" id="bodyDiv"><div class="optionsContainer" id="optionsContainer"><system:campaign inLogin="false" inSplash="false" location="verticalUp" /><div class="fncPanel info"><div class="title"><span><system:label show="text" label="titMonEnt" /></span><span class="panelPinShow" id="panelPinShow">&nbsp;</span><span class="panelPinHidde" id="panelPinHidde">&nbsp;</span><%@include file="../../includes/adminFav.jsp" %></div><div class="content divFncDescription"><div class="fncDescriptionImage" data-src="<system:edit show="value" from="theBean" field="fncImage"/>"></div><div id="fncDescriptionText"><system:label show="text" label="dscFncProcEnt"/></div><div class="clear"></div></div></div><div class="fncPanel options"><div class="title"><system:label show="text" label="titActions"/></div><div class="content"><div id="btnView" class="button suggestedAction" title="<system:label show="tooltip" label="btnView" />"><system:label show="text" label="btnView" /></div><div id="btnDocuments" class="button" title="<system:label show="tooltip" label="btnViewDocs" />"><system:label show="text" label="btnViewDocs" /></div></div></div><div class="fncPanel options lastOptions"><div class="title" title="<system:label show="tooltip" label="titAdmAdtFilter"/>"><system:label show="text" label="titAdmAdtFilter"/></div><div class="content"><div class="filter"><span><system:label show="text" label="lblMonEntFilUsuAct" />:</span><input type="text" id="usrLoginFilter" value="<system:filter show="value" filter="39"></system:filter>"></div><div class="filter filterRequired"><span><system:label show="text" label="lblMonEntFilActFrom" />:</span><input id="modifiedDateFilterStart" type="text" class="datePicker datePickerChecker filterInputDate" size="9" maxlength="10" value="<system:filter show="value" filter="36"></system:filter>"></div><div class="filter"><span><system:label show="text" label="lblMonEntFiLActTo" />:</span><input id="modifiedDateFilterEnd" type="text" class="datePicker datePickerChecker filterInputDate" size="9" maxlength="10"   value="<system:filter show="value" filter="37"></system:filter>"></div><div class="filter"><span><system:label show="text" label="lblMonEntFilCreFrom" />:</span><input id="createDateFilterStart" type="text" class="datePicker datePickerChecker filterInputDate" size="9" maxlength="10" value="<system:filter show="value" filter="34"></system:filter>"></div><div class="filter"><span><system:label show="text" label="lblMonEntFilCreTo" />:</span><input id="createDateFilterEnd" type="text" class="datePicker datePickerChecker filterInputDate" size="9" maxlength="10" value="<system:filter show="value" filter="35"></system:filter>"></div><div id="filterDiv"></div></div></div><system:campaign inLogin="false" inSplash="false" location="verticalDown" /></div><div class="gridContainer" id="gridContainer"><system:campaign inLogin="false" inSplash="false" location="horizontalUp" /><div class="gridHeader" id="gridHeader"><!-- Cabezal y filtros --><table><thead><tr id="trOrderBy" class="header"><th id="orderByEntityId" class="allowSort sort<system:filter show="sortStyle" from="com.dogma.vo.filter.MonitorEntityFilterVo" field="ORDER_ID"/>" data-sortBy="<system:edit show="constant" from="com.dogma.vo.filter.MonitorEntityFilterVo" field="ORDER_ID"/>" title="<system:label show="tooltip" label="lblEjeIdeEnt" />"><div style="width: 150px"><system:label show="text" label="lblEjeIdeEnt" /></div></th><th id="orderByEntityNum" class="allowSort required sort<system:filter show="sortStyle" from="com.dogma.vo.filter.MonitorEntityFilterVo" field="ORDER_TYPE"/>" data-sortBy="<system:edit show="constant" from="com.dogma.vo.filter.MonitorEntityFilterVo" field="ORDER_TYPE"/>" title="<system:label show="tooltip" label="lblEjeTip" />"><div style="width: 200px"><system:label show="text" label="lblEjeTip" /></div></th><th id="orderByUser" class="allowSort sort<system:filter show="sortStyle" from="com.dogma.vo.filter.MonitorEntityFilterVo" field="ORDER_CREATE_USER"/>" data-sortBy="<system:edit show="constant" from="com.dogma.vo.filter.MonitorEntityFilterVo" field="ORDER_CREATE_USER"/>" title="<system:label show="tooltip" label="lblEjeUsuCre" />"><div style="width: 150px"><system:label show="text" label="lblEjeUsuCre" /></div></th></tr><tr class="filter"><th title="<system:label show="tooltip" label="lblEjeIdeEnt" />"><div style="width: 150px"><input id="entIdFilter" type="text" value="<system:filter show="value" filter="40"></system:filter>"></div></th><th title="<system:label show="tooltip" label="lblEjeTip" />"><div style="width: 200px"><select name="entNumFilter" id="entNumFilter" onchange="setFilter()" ><option></option><system:util show="prepareEntitiesTitle" saveOn="types" /><system:edit show="iteration" from="types" saveOn="type_save"><system:edit show="saveValue" from="type_save" field="vTitle" saveOn="type"/><option value="<system:edit show="value" from="type_save" field="vTitle"/>" <system:filter show="ifValue" filter="3" value="page:type">selected</system:filter>><system:edit show="value" from="type_save" field="tTitleName"/></option></system:edit></select></div></th><th title="<system:label show="text" label="lblMonInstProCreUsu" />"><div style="width: 150px"><input id="userFilter" type="text" value="<system:filter show="value" filter="38"></system:filter>"></div></th></tr></thead></table></div><div class="gridBody" id="gridBody"><!-- Cuerpo de la tabla --><table><thead><tr><th width="150px"></th><th width="200px"></th><th width="150px"></th></tr></thead><tbody class="tableData" id="tableData"></tbody></table></div><div class="gridFooter"><%@include file="../../includes/navButtons.jsp" %></div><!-- MESSAGES --><div class="message hidden" id="messageContainer"></div><system:campaign inLogin="false" inSplash="false" location="horizontalDown" /></div></div><%@include file="../../includes/footer.jsp" %></body></html>
