<%@page import="com.dogma.vo.ProcessVo"%>
<%@page import="com.st.util.labels.LabelManager"%>
<%@page import="com.dogma.vo.AttributeVo"%>
<%@include file="../../includes/startInc.jsp" %>
<html lang="<%=biz.statum.apia.web.bean.BasicBeanStatic.getUserDataStatic(request).getLangCode()%>">
<head>
	<%@include file="../../includes/headInclude.jsp" %>
	<script type="text/javascript" src="<system:util show="context" />/page/design/bpmn/list.js"></script>
	<script type="text/javascript" src="<system:util show="context" />/page/design/bpmn/processVersions.js"></script>
	<script type="text/javascript" src="<system:util show="context" />/page/includes/adminFav.js"></script>
	<script type="text/javascript" src="<system:util show="context" />/page/includes/adminActions.js"></script>
	<script type="text/javascript" src="<system:util show="context" />/page/includes/navButtons.js"></script>
	<script type="text/javascript" src="<system:util show="context" />/page/includes/campaigns.js"></script>

	<script type="text/javascript">
		var URL_REQUEST_AJAX 				= '/apia.design.BPMNProcessAction.run';
		var ADDITIONAL_INFO_IN_TABLE_DATA  	= true;
		var GNR_INIT_RECORD 				= '<system:label show="text" label="msgIniRec" forScript="true" />';
		var MSG_REG_CUBE 					= '<system:label show="text" label="msgConfRegCube" forScript="true" />';
		var MSG_SEL_BPMN_DEBUG 				= '<system:label show="text" label="msgBpmnDebug" forScript="true" />';
		var MSG_SEL_BPMN_CLONE				= '<system:label show="text" label="msgBpmnClone" forScript="true" />';
		var MSG_INIT_DEL_BUS_ENT_INST		= '<system:label show="text" label="msgBpmnDelBusEntInst" forScript="true" />';
	</script>
</head>
<body>	
	<div class="body" id="bodyDiv">
	<div class="optionsContainer">
			<system:campaign inLogin="false" inSplash="false" location="verticalUp" />
			<div class="fncPanel info">			
				<div class="title">
					<system:label show="text" label="mnuPro" />
					<%@include file="../../includes/adminFav.jsp" %>
				</div>	
				<div class="content divFncDescription">
					<div class="fncDescriptionImage" data-src="<system:edit show="value" from="theBean" field="fncImage"/>"></div>
					<div id="fncDescriptionText"><system:label show="text" label="dscFncProBPMN"/></div>
					<div class="clear"></div>
				</div>
			</div>			
			
			<%@include file="../../includes/adminActions.jsp" %>
			
			<div class="fncPanel buttons">
				<div class="title"><system:label show="text" label="mnuOpc" /></div>
				<div class="content">
				  	<div id="optionInit" class="button" title="<system:label show="tooltip" label="btnIniEnt" />"><system:label show="text" label="btnIniEnt" /></div>
				  	<div id="optionVersions" class="button" title="<system:label show="tooltip" label="btnVers" />"><system:label show="text" label="btnVers" /></div>
					<div id="optionDebug" class="button" title="<system:label show="text" label="btnDebug" />"><system:label show="text" label="btnDebug" /></div>
					<div id="optionLock" class="button extendedSize" title="<system:label show="tooltip" label="btnLocProc" />"><system:label show="text" label="btnLocProc" /></div>
					<div id="optionImport" class="button extendedSize" title="<system:label show="tooltip" label="btnImportXPDL" />"><system:label show="text" label="btnImportXPDL" /></div>
					<div id="optionRegCube" class="button extendedSize" title="<system:label show="tooltip" label="btnRegCube" />"><system:label show="text" label="btnRegCube" /></div>					
					<div id="optionRegConds" class="button extendedSize" title="<system:label show="tooltip" label="btnProReGenCond" />"><system:label show="text" label="btnProReGenCond" /></div>
															
				</div>	
			</div>
			
			<div class="fncPanel options lastOptions">
				<div class="title" title="<system:label show="tooltip" label="titAdmAdtFilter"/>"><system:label show="text" label="titAdmAdtFilter"/></div>
				<div class="content">
					<div class="filter">
						<span><system:label show="text" label="titPrj" />:</span>
						<select name="projectFilter" id="projectFilter" onchange="setFilter()" value="<system:filter show="value" filter="12"></system:filter>" >
							<option></option>
							<system:util show="prepareProjects" saveOn="projects" />
							<system:edit show="iteration" from="projects" saveOn="project">
								<system:edit show="saveValue" from="project" field="prjId" saveOn="projectsave"/>
								<option value="<system:edit show="value" from="project" field="prjId"/>" <system:filter show="ifValue" filter="12" value="page:projectsave">selected</system:filter>><system:edit show="value" from="project" field="prjTitle"/></option>
							</system:edit>				
	   					</select>
					</div>
					<div class="clear"></div>
					<div class="filter">
						<span><system:label show="text" label="lblAccPro" />:</span> 
						<select name="actionFilter" id="actionFilter" onchange="setFilter()">
							<option></option>
							<system:util show="prepareProcessAction" saveOn="types" />
							<system:edit show="iteration" from="types" saveOn="type_save">
							<system:edit show="saveValue" from="type_save" field="type" saveOn="type"/>
								<option value="<system:edit show="value" from="type_save" field="type"/>" <system:filter show="ifValue" filter="6" value="page:type">selected</system:filter>><system:edit show="value" from="type_save" field="typeName"/></option>
							</system:edit>	
	   					</select>
					</div>
					<div class="clear"></div>
					<div class="filter">
						<span><system:label show="text" label="lblCube" />:</span> 
						<select name="cubeFilter" id="cubeFilter" onchange="setFilter()">
							<option></option>
							<system:util show="prepareTypeHasCube" saveOn="types" />
							<system:edit show="iteration" from="types" saveOn="type_save">
							<system:edit show="saveValue" from="type_save" field="type" saveOn="type"/>
								<option value="<system:edit show="value" from="type_save" field="type"/>" <system:filter show="ifValue" filter="7" value="page:type">selected</system:filter>><system:edit show="value" from="type_save" field="typeName"/></option>
							</system:edit>						   					
	   					</select>	   					
			   		</div>
			   		<div class="clear"></div>
			   		
			   		<div class="filter" <system:edit show="ifValue" from="theBean" field="bothProcesses" value="false">style="display: none;"</system:edit>>
						<span><system:label show="text" label="titBPMN" />:</span> 
						<select name="proBPMNFilter" id="proBPMNFilter" onchange="setFilter();">
							<option></option>
							<system:util show="showPrepareYesNoInt" saveOn="options" />
							<system:edit show="iteration" from="options" saveOn="options_save">
								<system:edit show="saveValue" from="options_save" field="value" saveOn="value"/>
								<option value="<system:edit show="value" from="options_save" field="value"/>" <system:filter show="ifValue" filter="11" value="page:value">selected</system:filter> ><system:edit show="value" from="options_save" field="name"/></option>
							</system:edit>						   					
	   					</select>	   					
			   		</div>
			   		<div class="clear"></div>
			   		<div class="filter">
						<span><system:label show="text" label="lblLock" />:</span> 
						<select name="lockFilter" id="lockFilter" onchange="onChangeCmbLockFilter(this,true)" value="<system:filter show="value" filter="9"></system:filter>">
							<option value=""></option>
							<system:util show="prepareLockProcess" saveOn="options" />
							<system:edit show="iteration" from="options" saveOn="option">
								<option value="<system:edit show="value" from="option" field="value"/>"><system:edit show="value" from="option" field="name"/></option>
							</system:edit>				   										   					
						</select>
					</div>
					<div class="filter" id="divLockByUstFilter" style="display: none">	
						<span></span>
						<input type="text" id="lockByUsrFilter" value="<system:filter show="value" filter="10"></system:filter>">
			   		</div>
			   	</div>
			</div>
			<system:campaign inLogin="false" inSplash="false" location="verticalDown" />			
		</div>	
		
		<div class="gridContainer">
				<system:campaign inLogin="false" inSplash="false" location="horizontalUp" />
				<div class="gridHeader" id="gridHeader">
					<!-- Cabezal y filtros -->
					<table>
						<thead>
							<tr id="trOrderBy" class="header">								
								<th id="orderByLock" class="allowSort sort<system:filter show="sortStyle" from="com.dogma.vo.filter.ProcessFilterVo" field="ORDER_LOCK"/>" data-sortBy="<system:edit show="constant" from="com.dogma.vo.filter.ProcessFilterVo" field="ORDER_LOCK"/>" title="<system:label show="tooltip" label="lblLock" />"><div style="width: 30px">&nbsp;</div></th>
								<th id="orderByPerm" title="<system:label show="tooltip" label="lblPerm" />"><div style="width: 20px">&nbsp;</div></th>
								<th id="orderByName" class="allowSort sort<system:filter show="sortStyle" from="com.dogma.vo.filter.ProcessFilterVo" field="ORDER_NAME"/>" data-sortBy="<system:edit show="constant" from="com.dogma.vo.filter.ProcessFilterVo" field="ORDER_NAME"/>" title="<system:label show="tooltip" label="lblNom" />"><div style="width: 200px"><system:label show="text" label="lblNom"/></div></th>
								<th id="orderByTitle" class="allowSort sort<system:filter show="sortStyle" from="com.dogma.vo.filter.ProcessFilterVo" field="ORDER_TITLE"/>" data-sortBy="<system:edit show="constant" from="com.dogma.vo.filter.ProcessFilterVo" field="ORDER_TITLE"/>" title="<system:label show="tooltip" label="lblTit" />"><div style="width: 200px"><system:label show="text" label="lblTit" /></div></th>
								<th id="orderByDesc" class="allowSort sort<system:filter show="sortStyle" from="com.dogma.vo.filter.ProcessFilterVo" field="ORDER_DESC"/>" data-sortBy="<system:edit show="constant" from="com.dogma.vo.filter.ProcessFilterVo" field="ORDER_DESC"/>" title="<system:label show="tooltip" label="lblDesc" />"><div style="width: 200px"><system:label show="text" label="lblDesc" /></div></th>
								<th id="orderByRegUser" class="allowSort sort<system:filter show="sortStyle" from="com.dogma.vo.filter.ProcessFilterVo" field="ORDER_USER"/>" data-sortBy="<system:edit show="constant" from="com.dogma.vo.filter.ProcessFilterVo" field="ORDER_USER"/>" title="<system:label show="tooltip" label="lblLastUsrName" />"><div style="width: 100px"><system:label show="text" label="lblLastUsrName" /></div></th>
								<th id="orderByRegDate" class="allowSort sort<system:filter show="sortStyle" from="com.dogma.vo.filter.ProcessFilterVo" field="ORDER_DATE"/>" data-sortBy="<system:edit show="constant" from="com.dogma.vo.filter.ProcessFilterVo" field="ORDER_DATE"/>" title="<system:label show="tooltip" label="lblLastActDate" />"><div style="width: 100px"><system:label show="text" label="lblLastActDate" /></div></th>
							</tr>
							<tr class="filter">
								<th title="<system:label show="tooltip" label="lblLock" />"><div style="width: 30px"></div></th>								
								<th title="<system:label show="tooltip" label="lblPerm" />"><div style="width: 20px"></div></th>
								<th title="<system:label show="tooltip" label="lblNom" />"><div style="width: 200px"><input id="nameFilter" type="text" value="<system:filter show="value" filter="0"></system:filter>"></div></th>
								<th title="<system:label show="tooltip" label="lblTit" />"><div style="width: 200px"><input id="titleFilter" type="text" value="<system:filter show="value" filter="1"></system:filter>"></div></th>
								<th title="<system:label show="tooltip" label="lblDesc" />"><div style="width: 200px"><input id="descFilter" type="text" value="<system:filter show="value" filter="2"></system:filter>"></div></th>														
								<th title="<system:label show="tooltip" label="lblLastUsrName" />"><div style="width: 100px"><input id="regUsrFilter" type="text" value="<system:filter show="value" filter="3"></system:filter>"></div></th>
								<th title="<system:label show="tooltip" label="lblLastActDate" />"><div style="width: 100px"><input id="regDateFilter" type="text" class="datePicker filterInputDate" value="<system:filter show="value" filter="4"></system:filter>"></div></th>
							</tr>
						</thead>
					</table>
				</div>
				<div class="gridBody" id="gridBody">
					<!-- Cuerpo de la tabla -->
					<table>
						<thead>
							<tr>
								<th width="30px"></th>
								<th width="20px"></th>
								<th width="200px"></th>
								<th width="200px"></th>
								<th width="200px"></th>								
								<th width="100px"></th>								
								<th width="100px"></th>
							</tr>
						</thead>
						<tbody class="tableData" id="tableData">
							
						</tbody>
					</table>
				</div>
				
				<div class="gridFooter">	
					<%@include file="../../includes/navButtons.jsp" %>
				</div>
				<system:campaign inLogin="false" inSplash="false" location="horizontalDown" />	
				<!-- MESSAGES -->
				<div class="message hidden" id="messageContainer">
					
				</div>
		</div>
	</div>
	
	<%@include file="../../includes/footer.jsp" %>
	
	<!-- MODALS -->
	<%@include file="processVersions.jsp" %>

</body>

</html>
