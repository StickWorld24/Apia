<%@include file="../../includes/startInc.jsp" %><html lang="<%=biz.statum.apia.web.bean.BasicBeanStatic.getUserDataStatic(request).getLangCode()%>"><head><%@include file="../../includes/headInclude.jsp" %><script type="text/javascript" src="<system:util show="context" />/page/execution/entities/list.js"></script><script type="text/javascript" src="<system:util show="context" />/page/includes/adminFav.js"></script><script type="text/javascript" src="<system:util show="context" />/page/includes/adminActions.js"></script><script type="text/javascript" src="<system:util show="context" />/page/includes/navButtons.js"></script><script type="text/javascript">
		var URL_REQUEST_AJAX = '/apia.execution.EntInstanceListAction.run';
		var ADDITIONAL_INFO_IN_TABLE_DATA  = true;
		var ENT_LIST_TITLE_TAB = '<system:label show="text" label="mnuManEntGlo" forScript="true" />';
		var MSG_CANT_UPDATE_INSTANCE = '<system:label show="text" label="msgCantModInst" forScript="true" />';
		var MSG_CANT_DELETE_INSTANCE = '<system:label show="text" label="msgCantDelInst" forScript="true" />';
		var SHOW_CREATE_BUTTON = toBoolean('<system:edit show="value" from="theBean" field="showCreateButton" />');
		var SHOW_DELETE_BUTTON = toBoolean('<system:edit show="value" from="theBean" field="showDeleteButton" />');
		var SHOW_UPDATE_BUTTON = toBoolean('<system:edit show="value" from="theBean" field="showUpdateButton" />');
		var GLOBAL_ADMIN = toBoolean('<system:edit show="value" from="theBean" field="globalAdministration" />');
		var fncTAbName = '<system:edit show="value" from="theBean" field="fncTabName" />';
		var MSG_FIRST_TIME	= '<system:label show="text" label="msgSelAtLeastOne" forScript="true" forHtml="true"/>';
	</script></head><body><div class="body" id="bodyDiv"><div class="optionsContainer"><system:campaign inLogin="false" inSplash="false" location="verticalUp" /><div class="fncPanel info"><div class="title"><system:edit show="ifValue" from="theBean" field="globalAdministration" value="true"><system:label show="text" label="mnuManEntGlo" /></system:edit><system:edit show="ifValue" from="theBean" field="globalAdministration" value="false"><system:edit show="value" from="theBean" field="busEntityVo.busEntTitle" /></system:edit><%@include file="../../includes/adminFav.jsp" %></div><div class="content divFncDescription"><div class="fncDescriptionImage" data-src="<system:edit show="value" from="theBean" field="fncImage"/>"></div><system:edit show="ifValue" from="theBean" field="globalAdministration" value="false"><div id="fncDescriptionText"><system:edit show="value" from="theBean" field="busEntityVo.busEntDesc" /></div></system:edit><system:edit show="ifValue" from="theBean" field="globalAdministration" value="true"><div id="fncDescriptionText"><system:label show="text" label="dscFncAdmGloEnt" /></div></system:edit><div class="clear"></div></div></div><%@include file="../../includes/adminActions.jsp" %><div class="fncPanel options lastOptions"><div class="title" title="<system:label show="tooltip" label="titAdmAdtFilter"/>"><system:label show="text" label="titAdmAdtFilter"/></div><div class="content"><system:edit show="iteration" from="theBean" field="columnsLabels" saveOn="column"><system:edit show="ifValue" from="column" field="canBeAditionalFilter" value="true"><div class="filter"><span><system:edit show="value" from="column" field="name" />:</span><input name="<system:edit show="value" from="column" field="filterName"  />" type="text" size="9" maxlength="10" class="allowFilter datePicker filterInputDate"  value="<system:edit show="value" from="column" field="filterValue"  />"> - 
								<input name="<system:edit show="value" from="column" field="filterName2" />" type="text" size="9" maxlength="10" class="allowFilter datePicker filterInputDate"  value="<system:edit show="value" from="column" field="filterValue2" />"></div></system:edit></system:edit><div class="filter"><span><system:label show="text" label="lblStaFec"/>:</span><input id="fecCreStartFilter" type="text" size="9" maxlength="10" class="datePicker datePickerChecker filterInputDate" value="<system:filter show="value" filter="4"></system:filter>">
						- 
						<input id="fecCreEndFilter" type="text" size="9" maxlength="10" class="datePicker datePickerChecker filterInputDate"  value="<system:filter show="value" filter="5"></system:filter>"></div></div></div><system:campaign inLogin="false" inSplash="false" location="verticalDown" /></div><div class="gridContainer"><system:campaign inLogin="false" inSplash="false" location="horizontalUp" /><div class="gridHeader" id="gridHeader"><!-- Cabezal y filtros --><table><thead><tr id="trOrderBy" class="header"><th id="orderById" class="allowSort sort<system:filter show="sortStyle" from="com.dogma.vo.filter.BusEntInstFilterVo" field="ORDER_ID"/>" data-sortBy="<system:edit show="constant" from="com.dogma.vo.filter.BusEntInstFilterVo" field="ORDER_ID"/>" title="<system:label show="tooltip" label="lblEjeIdeEnt" />"><div style="width: 120px"><system:label show="text" label="lblEjeIdeEnt"/></div></th><system:edit show="ifValue" from="theBean" field="globalAdministration" value="true"><th id="orderByType" class="allowSort sort<system:filter show="sortStyle" from="com.dogma.vo.filter.BusEntInstFilterVo" field="ORDER_NAME"/>" data-sortBy="<system:edit show="constant" from="com.dogma.vo.filter.BusEntInstFilterVo" field="ORDER_TYPE"/>" title="<system:label show="tooltip" label="lblEjeTip" />"><div style="width: 200px"><system:label show="text" label="lblEjeTip" /></div></th></system:edit><system:edit show="iteration" from="theBean" field="columnsLabels" saveOn="column"><th class="allowSort sort<system:edit show="value" from="column" field="sortStyle" />" data-sortBy="<system:edit show="value" from="column" field="sortBy" />" title="<system:edit show="value" from="column" field="title" />"><div style="width: 150px"><system:edit show="value" from="column" field="name" /></div></th></system:edit><th id="orderByStatus" class="allowSort sort<system:filter show="sortStyle" from="com.dogma.vo.filter.BusEntInstFilterVo" field="ORDER_STATUS"/>" data-sortBy="<system:edit show="constant" from="com.dogma.vo.filter.BusEntInstFilterVo" field="ORDER_STATUS"/>" title="<system:label show="tooltip" label="lblEjeStaEnt" />"><div style="width: 100px"><system:label show="text" label="lblEjeStaEnt" /></div></th><th id="orderByCreateUser" class="allowSort sort<system:filter show="sortStyle" from="com.dogma.vo.filter.BusEntInstFilterVo" field="ORDER_CREATE_USER"/>" data-sortBy="<system:edit show="constant" from="com.dogma.vo.filter.BusEntInstFilterVo" field="ORDER_CREATE_USER"/>" title="<system:label show="tooltip" label="lblEjeUsuCre" />"><div style="width: 120px"><system:label show="text" label="lblEjeUsuCre" /></div></th><th id="orderByCreateDate" class="allowSort sort<system:filter show="sortStyle" from="com.dogma.vo.filter.BusEntInstFilterVo" field="ORDER_CREATE_DATE"/>" data-sortBy="<system:edit show="constant" from="com.dogma.vo.filter.BusEntInstFilterVo" field="ORDER_CREATE_DATE"/>" title="<system:label show="tooltip" label="lblEjeFchCre" />"><div style="width: 150px"><system:label show="text" label="lblEjeFchCre" /></div></th></tr><tr class="filter"><th title="<system:label show="tooltip" label="lblEjeIdeEnt" />"><div style="width: 120px"><input id="idFilter" type="text" value="<system:filter show="value" filter="0"></system:filter>"></div></th><system:edit show="ifValue" from="theBean" field="globalAdministration" value="true"><th title="<system:label show="tooltip" label="lblEjeTip" />"><div style="width: 200px"><!--  
											<input id="typeFilter" type="text" value="<system:filter show="value" filter="1"></system:filter>">
											--><select name="filBusEntId" id="filBusEntId" onchange="setFilter()"><option></option><system:util show="prepareBusEntities" saveOn="entitiesCol" /><system:edit show="iteration" from="entitiesCol" saveOn="entity"><system:edit show="saveValue" from="entity" field="busEntId" saveOn="vId"/><option value="<system:edit show="value" from="entity" field="busEntId"/>" <system:filter show="ifValue" filter="6" value="page:vId">selected</system:filter>><system:edit show="value" from="entity" field="busEntTitle"/></option></system:edit></select></div></th></system:edit><system:edit show="ifValue" from="theBean" field="globalAdministration" value="false"><input type="hidden" name="filBusEntId" id="filBusEntId" value="<system:edit show="value" from="theBean" field="busEntityVo.busEntId" />"></system:edit><system:edit show="iteration" from="theBean" field="columnsLabels" saveOn="column"><th title="<system:edit show="value" from="column" field="title" />"><div style="width: 150px"><system:edit show="ifValue" from="column" field="canBeColumnFilter" value="true"><input name="<system:edit show="value" from="column" field="filterName" />" type="text" class="allowFilter" value="<system:edit show="value" from="column" field="filterValue" />"></system:edit></div></th></system:edit><th title="<system:label show="tooltip" label="lblEjeStaEnt" />"><div style="width: 100px"><select name="statusFilter" id="statusFilter" onchange="setFilter()"><option></option><system:util show="prepareBusEntStatus" saveOn="statusCol" /><system:edit show="iteration" from="statusCol" saveOn="status"><system:edit show="saveValue" from="status" field="entStaId" saveOn="vId"/><option value="<system:edit show="value" from="status" field="entStaId"/>" <system:filter show="ifValue" filter="2" value="page:vId">selected</system:filter>><system:edit show="value" from="status" field="entStaTitle"/></option></system:edit></select></div></th><th title="<system:label show="tooltip" label="lblEjeUsuCre" />"><div style="width: 120px"><input id="createUserFilter" type="text" value="<system:filter show="value" filter="3"></system:filter>"></div></th><th title="<system:label show="tooltip" label="lblEjeFchCre" />"><div style="width: 150px"></div></th></tr></thead></table></div><div class="gridBody" id="gridBody"><!-- Cuerpo de la tabla --><table><thead><tr><th style="width: 120px;"></th><system:edit show="ifValue" from="theBean" field="globalAdministration" value="true"><th width="200px"></th></system:edit><system:edit show="iteration" from="theBean" field="columnsLabels" saveOn="column"><th width="150px"></th></system:edit><th style="width: 100px;"></th><th style="width: 120px;"></th><th style="width: 150px;"></th></tr></thead><tbody class="tableData" id="tableData"></tbody></table></div><div class="gridFooter"><!-- Botonera --><%@include file="../../includes/navButtons.jsp" %></div><!-- MESSAGES --><div class="message hidden" id="messageContainer"></div><system:campaign inLogin="false" inSplash="false" location="horizontalDown" /></div></div><%@include file="../../includes/footer.jsp" %></body></html>
