<%@include file="../../includes/startInc.jsp" %><html lang="<%=biz.statum.apia.web.bean.BasicBeanStatic.getUserDataStatic(request).getLangCode()%>"><head><%@include file="../../includes/headInclude.jsp" %><script type="text/javascript" src="<system:util show="context" />/page/execution/proStart/listAlter.js"></script><script type="text/javascript" src="<system:util show="context" />/page/includes/adminFav.js"></script><script type="text/javascript" src="<system:util show="context" />/page/includes/navButtons.js"></script><script type="text/javascript">
		var URL_REQUEST_AJAX = '/apia.execution.EntInstanceListAction.run';
		var ADDITIONAL_INFO_IN_TABLE_DATA  = true;
		var PRO_ID = <system:edit show="value" from="theBean" field="alterProcessId"/>;
		var MSG_FIRST_TIME	= '<system:label show="text" label="msgSelAtLeastOne" forScript="true" forHtml="true"/>';
	</script></head><body><div class="body" id="bodyDiv"><div class="optionsContainer" id="optionsContainer"><div class="fncPanel info"><div class="title"><system:edit show="value" from="theBean" field="alterProcessTitle"/><%@include file="../../includes/adminFav.jsp" %></div><div class="content divFncDescription"><div class="fncDescriptionImgUsers" style="background-image: url('<system:edit show="value" from="theBean" field="alterProcessImg"/>');"></div><div id="fncDescriptionText"><system:edit show="value" from="theBean" field="alterProcessDesc"/></div><div class="clear"></div></div></div><div class="fncPanel buttons options"><div class="title"><system:label show="text" label="titActions"/></div><div class="content"><div id="btnStart" class="button"><system:label show="text" label="btnAlt" /></div></div></div><div class="fncPanel options"><div class="title" title="<system:label show="tooltip" label="titAdmAdtFilter"/>"><system:label show="text" label="titAdmAdtFilter"/></div><div class="content"><system:edit show="iteration" from="theBean" field="columnsLabels" saveOn="column"><system:edit show="ifValue" from="column" field="canBeAditionalFilter" value="true"><div class="filter"><span><system:edit show="value" from="column" field="name" />:</span><input name="<system:edit show="value" from="column" field="filterName"  />" type="text" size="9" maxlength="10" class="allowFilter datePicker datePickerChecker filterInputDate"  value="<system:edit show="value" from="column" field="filterValue"  />"> - 
								<input name="<system:edit show="value" from="column" field="filterName2" />" type="text" size="9" maxlength="10" class="allowFilter datePicker datePickerChecker filterInputDate"  value="<system:edit show="value" from="column" field="filterValue2" />"></div></system:edit></system:edit><div class="filter"><span><system:label show="text" label="lblStaFec"/>:</span><input id="fecCreStartFilter" type="text" size="9" maxlength="10" class="datePicker datePickerChecker filterInputDate"  value="<system:filter show="value" filter="4"></system:filter>"> - <input id="fecCreEndFilter" type="text" size="9" maxlength="10" class="datePicker datePickerChecker filterInputDate"  value="<system:filter show="value" filter="5"></system:filter>"></div></div></div></div><div class="gridContainer" id="gridContainer"><div class="gridHeader" id="gridHeader"><!-- Cabezal y filtros --><table><thead><tr id="trOrderBy" class="header"><th id="orderById" class="allowSort sort<system:filter show="sortStyle" from="com.dogma.vo.filter.BusEntInstFilterVo" field="ORDER_ID"/>" data-sortBy="<system:edit show="constant" from="com.dogma.vo.filter.BusEntInstFilterVo" field="ORDER_ID"/>" title="<system:label show="tooltip" label="lblEjeIdeEnt" />"><div style="width: 100px"><system:label show="text" label="lblEjeIdeEnt"/></div></th><system:edit show="iteration" from="theBean" field="columnsLabels" saveOn="column"><th class="allowSort sort<system:edit show="value" from="column" field="sortStyle" />" data-sortBy="<system:edit show="value" from="column" field="sortBy" />" title="<system:edit show="value" from="column" field="title" />"><div style="width: 150px"><system:edit show="value" from="column" field="name" /></div></th></system:edit><th id="orderByStatus" class="allowSort sort<system:filter show="sortStyle" from="com.dogma.vo.filter.BusEntInstFilterVo" field="ORDER_STATUS"/>" data-sortBy="<system:edit show="constant" from="com.dogma.vo.filter.BusEntInstFilterVo" field="ORDER_STATUS"/>" title="<system:label show="tooltip" label="lblEjeStaEnt" />"><div style="width: 100px"><system:label show="text" label="lblEjeStaEnt" /></div></th><th id="orderByCreateDate" class="allowSort sort<system:filter show="sortStyle" from="com.dogma.vo.filter.BusEntInstFilterVo" field="ORDER_CREATE_DATE"/>" data-sortBy="<system:edit show="constant" from="com.dogma.vo.filter.BusEntInstFilterVo" field="ORDER_CREATE_DATE"/>" title="<system:label show="tooltip" label="lblEjeFchCre" />"><div style="width: 120px"><system:label show="text" label="lblEjeFchCre" /></div></th><th id="orderByCreateUser" class="allowSort sort<system:filter show="sortStyle" from="com.dogma.vo.filter.BusEntInstFilterVo" field="ORDER_CREATE_USER"/>" data-sortBy="<system:edit show="constant" from="com.dogma.vo.filter.BusEntInstFilterVo" field="ORDER_CREATE_USER"/>" title="<system:label show="tooltip" label="lblEjeUsuCre" />"><div style="width: 100px"><system:label show="text" label="lblEjeUsuCre" /></div></th></tr><tr class="filter"><th title="<system:label show="tooltip" label="lblEjeIdeEnt" />"><div style="width: 100px"><input id="idFilter" type="text" value="<system:filter show="value" filter="0"></system:filter>"></div></th><system:edit show="iteration" from="theBean" field="columnsLabels" saveOn="column"><th title="<system:edit show="value" from="column" field="title" />"><div style="width: 150px"><system:edit show="ifValue" from="column" field="canBeColumnFilter" value="true"><input name="<system:edit show="value" from="column" field="filterName" />" type="text" class="allowFilter" value="<system:edit show="value" from="column" field="filterValue" />"></system:edit></div></th></system:edit><th title="<system:label show="tooltip" label="lblEjeStaEnt" />"><div style="width: 100px"><input id="statusFilter" type="text" value="<system:filter show="value" filter="2"></system:filter>"></div></th><th title="<system:label show="tooltip" label="lblEjeFchCre" />"><div style="width: 120px"></div></th><th title="<system:label show="tooltip" label="lblEjeUsuCre" />"><div style="width: 100px"><input id="createUserFilter" type="text" value="<system:filter show="value" filter="3"></system:filter>"></div></th></tr></thead></table></div><div class="gridBody" id="gridBody"><!-- Cuerpo de la tabla --><table><thead><tr><th width="100px"></th><system:edit show="iteration" from="theBean" field="columnsLabels" saveOn="column"><th width="150px"></th></system:edit><th width="100px"></th><th width="120px"></th><th width="100px"></th></tr></thead><tbody class="tableData" id="tableData"></tbody></table></div><div class="gridFooter"><!-- Botonera --><%@include file="../../includes/navButtons.jsp" %></div><!-- MESSAGES --><div class="message hidden" id="messageContainer"></div></div></div><%@include file="../../includes/footer.jsp" %></body></html>
