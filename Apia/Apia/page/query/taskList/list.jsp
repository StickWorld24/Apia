<%@page import="com.dogma.vo.QueryVo"%><%@page import="biz.statum.apia.web.bean.query.TaskListContainerBean"%><%@page import="biz.statum.apia.web.action.query.TaskListAction"%><%@page import="biz.statum.sdk.util.HttpServletRequestResponse"%><%@include file="../../includes/startInc.jsp" %><html lang="<%=biz.statum.apia.web.bean.BasicBeanStatic.getUserDataStatic(request).getLangCode()%>"><head><%@include file="../../includes/headInclude.jsp" %><system:query show="saveValue" from="theBean" field="workingMode" sendHttp="true" saveOn="beanPrefix" /><script type="text/javascript" src="<system:util show="context" />/page/query/taskList/list.js"></script><script type="text/javascript" src="<system:util show="context" />/page/query/common/queryButtons.js"></script><script type="text/javascript" src="<system:util show="context" />/page/includes/adminFav.js"></script><script type="text/javascript" src="<system:util show="context" />/page/includes/campaigns.js"></script><script type="text/javascript" src="<system:util show="context" />/page/includes/navButtons.js"></script><script type="text/javascript" src="<system:util show="context" />/page/query/taskList/columns.js"></script><script type="text/javascript" src="<system:util show="context" />/page/query/common/validateDatesFilters.js"></script><script type="text/javascript">
		var URL_REQUEST_AJAX = '/apia.query.TaskListAction.run';
		var ADDITIONAL_INFO_IN_TABLE_DATA  = false;
		var WORKING_MODE = '<system:query show="value" from="theBean" field="workingMode" />';
		var PRIMARY_SEPARATOR		= new Element('div').set('html', '<system:edit show="constant" from="com.st.util.StringUtil" field="PRIMARY_SEPARATOR"/>').get('text');
	
		<%
		HttpServletRequestResponse http = new HttpServletRequestResponse(request,response);
		TaskListContainerBean bean = TaskListAction.staticRetrieveBean(http, false);
		%>
		
		var FROM_MINISITE = <%=bean.getUserData(http).isFromMinisite()%>;
	</script></head><body class="taskListQry" style="height: auto;"><div class="body" id="bodyDiv"><form id="queryForm" action="<system:util show="context" />/apia.query.TaskListAction.run?<system:util show="tabIdRequest" />&workingMode=<system:query show="value" from="theBean" field="workingMode" />" method="post"><input type="hidden" name="action" value="" id="queryFormAction"><div class="optionsContainer" id="optionsContainer" style="position: absolute;"><system:campaign inLogin="false" inSplash="false" location="verticalUp" /><%@include file="../common/panelInfo.jsp" %><!-- ACTIONS --><div class="fncPanel options"><div class="title"><system:label show="text" label="titActions"/></div><div class="content"><div id="btnSearch" class="button suggestedAction"><system:label show="text" label="btnSearch" /></div><!-- WORKING_MODE_INPROCESS (MIS TAREAS) --><system:query show="ifValue" from="theBean" field="workingMode" value="I"><system:query show="ifFlag" from="theQuery" field="12" defaultValue="qryButtons"><div id="btnWork" class="button"><system:label show="text" label="btnEjeTra" /></div></system:query><system:query show="ifFlag" from="theQuery" field="8" defaultValue="qryButtons"><div id="btnRelease" class="button"><system:label show="text" label="btnEjeLib" /></div></system:query><system:query show="ifFlag" from="theQuery" field="0" defaultValue="qryButtons"><div id="btnExport" class="button"><system:label show="text" label="btnExport" /></div></system:query><system:query show="ifFlag" from="theQuery" field="14" defaultValue="qryButtons"><div id="btnRefresh" class="button"><system:label show="text" label="btnRef" /></div></system:query></system:query><!-- WORKING_MODE_READY (LIBRES) --><system:query show="ifValue" from="theBean" field="workingMode" value="R"><system:query show="ifFlag" from="theQuery" field="13" defaultValue="qryButtons"><div id="btnWork" class="button"><system:label show="text" label="btnEjeTra" /></div></system:query><system:query show="ifFlag" from="theQuery" field="9" defaultValue="qryButtons"><div id="btnAcquire" class="button"><system:label show="text" label="btnEjeCap" /></div></system:query><system:query show="ifFlag" from="theQuery" field="20" defaultValue="qryButtons"><div id="btnExport" class="button"><system:label show="text" label="btnExport" /></div></system:query><system:query show="ifFlag" from="theQuery" field="15" defaultValue="qryButtons"><div id="btnRefresh" class="button"><system:label show="text" label="btnRef" /></div></system:query></system:query><% if(!bean.getUserData(http).isExternalMode()) { %><div id="btnCloseTab" class="button" title="<system:label show="tooltip" label="btnClose" />"><system:label show="text" label="btnClose" /></div><% } %></div></div><!-- OPTIONS --><div class="fncPanel options"><div class="title"><system:label show="text" label="titOptions"/></div><div class="content"><!-- WORKING_MODE_INPROCESS (MIS TAREAS) --><system:query show="ifValue" from="theBean" field="workingMode" value="I"><system:query show="ifFlag" from="theQuery" field="7" defaultValue="qryButtons"><div id="btnColumns" class="button extendedSize"><system:label show="text" label="btnEjeCol" /></div></system:query></system:query><!-- WORKING_MODE_READY (LIBRES) --><system:query show="ifValue" from="theBean" field="workingMode" value="R"><system:query show="ifFlag" from="theQuery" field="11" defaultValue="qryButtons"><div id="btnColumns" class="button"><system:label show="text" label="btnEjeCol" /></div></system:query></system:query><!-- ALL MODE --><system:query show="ifNotFlag" from="theQuery" field="21"><system:query show="ifValue" from="theBean" field="hasFiltersWithType" value="true"><div id="btnFilterType" class="button extendedSize"><system:label show="text" label="btnFilterType" /></div></system:query></system:query><% if (!bean.getQueryVo().getButtonValue(QueryVo.FLAG_SHOW_BUTTON_ONLY_MY_TASKS)) { %><system:query show="ifValue" from="theBean" field="workingMode" value="I"><div><span><system:label show="tooltip" label="lblview"/>:</span><select name="cmbTskQnt" id="cmbTskQnt" onchange="setFilter()" value="<system:query show="ifValue" from="theBean" field="isShowOnlyMyTasks" value="true">0</system:query>><system:query show="ifValue" from="theBean" field="isShowOnlyMyTasks" value="false">1</system:query>" ><option value="0" <system:query show="ifValue" from="theBean" field="isShowOnlyMyTasks" value="true">selected</system:query>><system:label show="text" label="lblOnlyMyTasks"/></option><option value="1" <system:query show="ifValue" from="theBean" field="isShowOnlyMyTasks" value="false">selected</system:query>><system:label show="text" label="lblCmpAllTsk"/></option></select></div></system:query><% } %></div></div><%@include file="../common/additionalFilters.jsp" %><system:campaign inLogin="false" inSplash="false" location="verticalDown" /></div><div class="gridContainer" id="gridContainer" style="margin-top: 30px;"><system:campaign inLogin="false" inSplash="false" location="horizontalUp" /><%@include file="../common/columnsHeader.jsp" %><%@include file="../common/columnsValue.jsp" %><%@include file="../common/navButtons.jsp" %><system:campaign inLogin="false" inSplash="false" location="horizontalDown" /></div></form><!-- MODALS --><%@include file="columns.jsp" %></div></body></html>
