<%@include file="../../includes/startInc.jsp" %><html lang="<%=biz.statum.apia.web.bean.BasicBeanStatic.getUserDataStatic(request).getLangCode()%>"><head><%@include file="../../includes/headInclude.jsp" %><system:query show="saveAValue" value="true" saveOn="modalQuery" /><script type="text/javascript" src="<system:util show="context" />/page/query/modal/list.js"></script><script type="text/javascript" src="<system:util show="context" />/page/query/common/queryButtons.js"></script><script type="text/javascript" src="<system:util show="context" />/page/includes/adminFav.js"></script><script type="text/javascript" src="<system:util show="context" />/page/includes/campaigns.js"></script><script type="text/javascript" src="<system:util show="context" />/page/includes/navButtons.js"></script><script type="text/javascript">
		var URL_REQUEST_AJAX = '/apia.query.ModalAction.run';
		var ADDITIONAL_INFO_IN_TABLE_DATA  = false;
		var OPEN_FILTER_ON_LOAD = toBoolean('<system:query show="flagValue" from="theQuery" field="15"/>');
		var EXECUTED_FILTER = toBoolean('<system:query show="value" from="theBean" field="executedForFilter" />');
		var MODAL_HIDE_OVERFLOW = true; //Flag para que modalController cambie el tama�o del iframe		
	</script></head><body style="height: auto !important;"><div class="body queryModal" id="bodyDiv"><form id="queryForm" action="<system:util show="context" />/apia.query.ModalAction.run?<system:util show="tabIdRequest" />" method="post"><input type="hidden" name="action" value="" id="queryFormAction"><div class="optionsContainer" id="optionsContainer"><%@include file="../common/panelInfoModal.jsp" %><%@include file="../common/additionalFilters.jsp" %><system:query show="ifNotFlag" from="theQuery" field="21"><system:query show="ifValue" from="theBean" field="hasFiltersWithType" value="true"><div class="fncPanel options" style="margin-top: -15px; display: initial;"><div class="title"><system:label show="text" label="titOptions"/></div><div class="content"><div id="btnFilterType" class="button large"><system:label show="text" label="btnFilterType" /></div></div></div></system:query></system:query></div><div class="gridContainer" id="gridContainer"><%@include file="../common/columnsHeader.jsp" %><%@include file="../common/columnsValue.jsp" %><%@include file="../common/navButtonsModal.jsp" %></div><input type="text" style="display: none;"></form></div></body></html>
