<%@include file="../../includes/startInc.jsp" %><html lang="<%=biz.statum.apia.web.bean.BasicBeanStatic.getUserDataStatic(request).getLangCode()%>"><head><%@include file="../../includes/headInclude.jsp" %><script type="text/javascript" src="<system:util show="context" />/page/includes/adminActionsEdition.js"></script><script type="text/javascript" src="<system:util show="context" />/page/design/scenario/simResultConf.js"></script><script type="text/javascript">
		var URL_REQUEST_AJAX = '/apia.design.ScenarioAction.run';	
	</script></head><body><div class="body" id="bodyDiv"><form id="frmData" method="post"><div class="optionsContainer"><system:campaign inLogin="false" inSplash="false" location="verticalUp" /><div class="fncPanel info"><div class="title"><system:label show="text" label="titScenarios" /></div><div class="content divFncDescription"><div class="fncDescriptionImage" data-src="<system:edit show="value" from="theBean" field="fncImage"/>"></div><div id="fncDescriptionText"><system:label show="text" label="dscFncAdmSimScenario"/></div><div class="clear"></div></div></div><div id="divAdminActEdit" class="fncPanel buttons"><div class="title"><system:label show="text" label="titActions" /></div><div class="content"><div id="btnExecute" class="button suggestedAction submit validate['submit']" title="<system:label show="tooltip" label="btnCon" />"><system:label show="text" label="btnCon" /></div><div id="btnBackToList" class="button" title="<system:label show="tooltip" label="btnVol" />"><system:label show="text" label="btnVol" /></div></div></div><system:campaign inLogin="false" inSplash="false" location="verticalDown" /></div><div class="dataContainer" id="container_data"><system:campaign inLogin="false" inSplash="false" location="horizontalUp" /><div class="fieldGroup"><div class="title"><system:label show="text" label="lblSimShowSec" /></div></div><div class="fieldGroup"><system:edit show="value" from="theBean" field="timeControlReachedMsg" /><div class="field fieldFull inOneLine"><input type="checkbox" id="showGeneralInformation" name="showGeneralInformation"  checked/>&nbsp;<label  for="showGeneralInformation" class="label2"><system:label show="text" label="sbtSimInfoGen" /></label></div></div><div class="fieldGroup"><div class="field fieldFull inOneLine"><input type="checkbox" id="showEscenarioInformation" name="showEscenarioInformation"  checked onclick="sectionChecked(this);"/>&nbsp;<label  for="showEscenarioInformation" class="label2"><system:label show="text" label="titSimRestEsc" /></label></div><div style="margin-left: 20px" id="showEscenarioInformationSection"><div class="field fieldFull inOneLine"><input type="checkbox" id="showEscenarioInformationPool" name="showEscenarioInformationPool"  checked/>&nbsp;<label  for="showEscenarioInformationPool" class="label2"><system:label show="text" label="sbtSimRestPool" /></label></div><div class="field fieldFull inOneLine"><input type="checkbox" id="showEscenarioInformationProcess" name="showEscenarioInformationProcess"  checked/>&nbsp;<label  for="showEscenarioInformationProcess" class="label2"><system:label show="text" label="sbtSimRestProcess" /></label></div><div class="field fieldFull inOneLine"><input type="checkbox" id="showEscenarioInformationTareas" name="showEscenarioInformationTareas"  checked/>&nbsp;<label  for="showEscenarioInformationTareas" class="label2"><system:label show="text" label="sbtSimRestTask" /></label></div></div></div><div class="fieldGroup"><div class="field fieldFull inOneLine"><input type="checkbox" id="showSimulationResult" name="showSimulationResult"  checked onclick="sectionChecked(this);"/>&nbsp;<label  for="showSimulationResult" class="label2"><system:label show="text" label="titSimInfoEsc" /></label></div><div style="margin-left: 20px" id="showSimulationResultSection"><div class="field fieldFull inOneLine"><input type="checkbox" id="showSimulationResultProcess" name="showSimulationResultProcess"  checked onclick="sectionChecked(this);"/>&nbsp;<label  for="showSimulationResultProcess" class="label2"><system:label show="text" label="sbtSimRestProcess" /></label></div><div style="margin-left: 20px" id="showSimulationResultProcessSection"><div class="field fieldFull inOneLine"><input type="checkbox" id="showSimulationResultProcessTimes" name="showSimulationResultProcessTimes"  checked onclick="sectionChecked(this);"/>&nbsp;<label  for="showSimulationResultProcessTimes" class="label2"><system:label show="text" label="sbtSimTimes" /></label></div><div style="margin-left: 20px" id="showSimulationResultProcessTimesSection"><div class="field fieldFull inOneLine"><input type="checkbox" id="showSimulationResultProcessTimesTable" name="showSimulationResultProcessTimesTable"  checked/>&nbsp;<label  for="showSimulationResultProcessTimesTable" class="label2"><system:label show="text" label="sbtSimTimesTable" /></label></div><div class="field fieldFull inOneLine"><input type="checkbox" id="showSimulationResultProcessTimesChart1" name="showSimulationResultProcessTimesChart1"  checked/>&nbsp;<label  for="showSimulationResultProcessTimesChart1" class="label2"><system:label show="text" label="sbtSimTimesChart1" /></label></div><div class="field fieldFull inOneLine"><input type="checkbox" id="showSimulationResultProcessTimesChart2" name="showSimulationResultProcessTimesChart2"  checked/>&nbsp;<label  for="showSimulationResultProcessTimesChart2" class="label2"><system:label show="text" label="sbtSimTimesChart2" /></label></div></div><div class="field fieldFull inOneLine"><input type="checkbox" id="showSimulationResultProcessCostos" name="showSimulationResultProcessCostos"  checked onclick="sectionChecked(this);"/>&nbsp;<label  for="showSimulationResultProcessCostos" class="label2"><system:label show="text" label="sbtSimRestCosts" /></label></div><div style="margin-left: 20px" id="showSimulationResultProcessCostosSection"><div class="field fieldFull inOneLine"><input type="checkbox" id="showSimulationResultProcessCostosTable" name="showSimulationResultProcessCostosTable"  checked/>&nbsp;<label  for="showSimulationResultProcessCostosTable" class="label2"><system:label show="text" label="sbtSimCostosTable" /></label></div><div class="field fieldFull inOneLine"><input type="checkbox" id="showSimulationResultProcessCostosChart" name="showSimulationResultProcessCostosChart"  checked/>&nbsp;<label  for="showSimulationResultProcessCostosChart" class="label2"><system:label show="text" label="sbtSimCostosChart1" /></label></div></div></div><div class="fieldGroup"><div class="field fieldFull inOneLine"><input type="checkbox" id="showSimulationResultPool" name="showSimulationResultPool"  checked onclick="sectionChecked(this);"/>&nbsp;<label  for="showSimulationResultPool" class="label2"><system:label show="text" label="sbtSimRestPool" /></label></div><div style="margin-left: 20px" id="showSimulationResultPoolSection"><div class="field fieldFull inOneLine"><input type="checkbox" id="showSimulationResultPoolQueue" name="showSimulationResultPoolQueue"  checked onclick="sectionChecked(this);"/>&nbsp;<label  for="showSimulationResultPoolQueue" class="label2"><system:label show="text" label="sbtSimRestQueue" /></label></div><div style="margin-left: 20px" id="showSimulationResultPoolQueueSection"><div class="field fieldFull inOneLine"><input type="checkbox" id="showSimulationResultPoolQueueTable" name="showSimulationResultPoolQueueTable"  checked/>&nbsp;<label  for="showSimulationResultPoolQueueTable" class="label2"><system:label show="text" label="lblSimPoolQueueTable" /></label></div><div class="field fieldFull inOneLine"><input type="checkbox" id="showSimulationResultPoolQueueChart1" name="showSimulationResultPoolQueueChart1"  checked/>&nbsp;<label  for="showSimulationResultPoolQueueChart1" class="label2"><system:label show="text" label="lblSimPoolQueueChart1" /></label></div><div class="field fieldFull inOneLine"><input type="checkbox" id="showSimulationResultPoolQueueChart2" name="showSimulationResultPoolQueueChart2"  checked/>&nbsp;<label  for="showSimulationResultPoolQueueChart2" class="label2"><system:label show="text" label="lblSimPoolQueueChart2" /></label></div></div><div class="field fieldFull inOneLine"><input type="checkbox" id="showSimulationResultPoolWork" name="showSimulationResultPoolWork"  checked onclick="sectionChecked(this);"/>&nbsp;<label  for="showSimulationResultPoolWork" class="label2"><system:label show="text" label="sbtSimRestWork" /></label></div><div style="margin-left: 20px" id="showSimulationResultPoolWorkSection"><div class="field fieldFull inOneLine"><input type="checkbox" id="showSimulationResultPoolWorkTable" name="showSimulationResultPoolWorkTable"  checked/>&nbsp;<label  for="showSimulationResultPoolWorkTable" class="label2"><system:label show="text" label="lblSimPoolWorkTable" /></label></div><div class="field fieldFull inOneLine"><input type="checkbox" id="showSimulationResultPoolWorkChart1" name="showSimulationResultPoolWorkChart1"  checked/>&nbsp;<label  for="showSimulationResultPoolWorkChart1" class="label2"><system:label show="text" label="lblSimPoolWorkChart1" /></label></div><div class="field fieldFull inOneLine"><input type="checkbox" id="showSimulationResultPoolWorkChart2" name="showSimulationResultPoolWorkChart2"  checked/>&nbsp;<label  for="showSimulationResultPoolWorkChart2" class="label2"><system:label show="text" label="lblSimPoolWorkChart2" /></label></div></div><div class="field fieldFull inOneLine"><input type="checkbox" id="showSimulationResultPoolCost" name="showSimulationResultPoolCost"  checked onclick="sectionChecked(this);"/>&nbsp;<label  for="showSimulationResultPoolCost" class="label2"><system:label show="text" label="sbtSimRestCost" /></label></div><div style="margin-left: 20px" id="showSimulationResultPoolCostSection"><div class="field fieldFull inOneLine"><input type="checkbox" id="showSimulationResultPoolCostTable" name="showSimulationResultPoolCostTable"  checked/>&nbsp;<label  for="showSimulationResultPoolCostTable" class="label2"><system:label show="text" label="lblSimPoolCostTable" /></label></div><div class="field fieldFull inOneLine"><input type="checkbox" id="showSimulationResultPoolCostChart" name="showSimulationResultPoolCostChart"  checked/>&nbsp;<label  for="showSimulationResultPoolCostChart" class="label2"><system:label show="text" label="lblSimPoolCostChart" /></label></div></div></div></div><div class="fieldGroup"><div class="field fieldFull inOneLine"><input type="checkbox" id="showSimulationResultTask" name="showSimulationResultTask"  checked onclick="sectionChecked(this);"/>&nbsp;<label  for="showSimulationResultTask" class="label2"><system:label show="text" label="sbtSimRestTask" /></label></div><div style="margin-left: 20px" id="showSimulationResultTaskSection"><div class="field fieldFull inOneLine"><input type="checkbox" id="showSimulationResultTaskQueue" name="showSimulationResultTaskQueue"  checked onclick="sectionChecked(this);"/>&nbsp;<label  for="showSimulationResultTaskQueue" class="label2"><system:label show="text" label="sbtSimRestQueue" /></label></div><div style="margin-left: 20px" id="showSimulationResultTaskQueueSection"><div class="field fieldFull inOneLine"><input type="checkbox" id="showSimulationResultTaskQueueTable1" name="showSimulationResultTaskQueueTable1"  checked/>&nbsp;<label  for="showSimulationResultTaskQueueTable1" class="label2"><system:label show="text" label="lblSimTskQueueTable1" /></label></div><div class="field fieldFull inOneLine"><input type="checkbox" id="showSimulationResultTaskQueueChart1" name="showSimulationResultTaskQueueChart1"  checked/>&nbsp;<label  for="showSimulationResultTaskQueueChart1" class="label2"><system:label show="text" label="lblSimTskQueueChart1" /></label></div><div class="field fieldFull inOneLine"><input type="checkbox" id="showSimulationResultTaskQueueChart2" name="showSimulationResultTaskQueueChart2"  checked/>&nbsp;<label  for="showSimulationResultTaskQueueChart2" class="label2"><system:label show="text" label="lblSimTskQueueChart2" /></label></div><div class="field fieldFull inOneLine"><input type="checkbox" id="showSimulationResultTaskQueueTable2" name="showSimulationResultTaskQueueTable2"  checked/>&nbsp;<label  for="showSimulationResultTaskQueueTable2" class="label2"><system:label show="text" label="lblSimTskQueueTable2" /></label></div><div class="field fieldFull inOneLine"><input type="checkbox" id="showSimulationResultTaskQueueChart3" name="showSimulationResultTaskQueueChart3"  checked/>&nbsp;<label  for="showSimulationResultTaskQueueChart3" class="label2"><system:label show="text" label="lblSimTskQueueChart3" /></label></div></div><div class="field fieldFull inOneLine"><input type="checkbox" id="showSimulationResultTaskWork" name="showSimulationResultTaskWork"  checked onclick="sectionChecked(this);"/>&nbsp;<label  for="showSimulationResultTaskWork" class="label2"><system:label show="text" label="sbtSimRestWorkTime" /></label></div><div style="margin-left: 20px" id="showSimulationResultTaskWorkSection"><div class="field fieldFull inOneLine"><input type="checkbox" id="showSimulationResultTaskWorkTable1" name="showSimulationResultTaskWorkTable1"  checked/>&nbsp;<label  for="showSimulationResultTaskWorkTable1" class="label2"><system:label show="text" label="lblSimTskWorkTable1" /></label></div><div class="field fieldFull inOneLine"><input type="checkbox" id="showSimulationResultTaskWorkChart1" name="showSimulationResultTaskWorkChart1"  checked/>&nbsp;<label  for="showSimulationResultTaskWorkChart1" class="label2"><system:label show="text" label="lblSimTskWorkChart1" /></label></div><div class="field fieldFull inOneLine"><input type="checkbox" id="showSimulationResultTaskWorkTable2" name="showSimulationResultTaskWorkTable2"  checked/>&nbsp;<label  for="showSimulationResultTaskWorkTable2" class="label2"><system:label show="text" label="lblSimTskWorkTable2" /></label></div><div class="field fieldFull inOneLine"><input type="checkbox" id="showSimulationResultTaskWorkChart2" name="showSimulationResultTaskWorkChart2"  checked/>&nbsp;<label  for="showSimulationResultTaskWorkChart2" class="label2"><system:label show="text" label="lblSimTskWorkChart2" /></label></div><div class="field fieldFull inOneLine"><input type="checkbox" id="showSimulationResultTaskWorkTable3" name="showSimulationResultTaskWorkTable3"  checked/>&nbsp;<label  for="showSimulationResultTaskWorkTable3" class="label2"><system:label show="text" label="lblSimTskWorkTable3" /></label></div><div class="field fieldFull inOneLine"><input type="checkbox" id="showSimulationResultTaskWorkChart3" name="showSimulationResultTaskWorkChart3"  checked/>&nbsp;<label  for="showSimulationResultTaskWorkChart3" class="label2"><system:label show="text" label="lblSimTskWorkChart3" /></label></div></div><div class="field fieldFull inOneLine"><input type="checkbox" id="showSimulationResultTaskCost" name="showSimulationResultTaskCost"  checked onclick="sectionChecked(this);"/>&nbsp;<label  for="showSimulationResultTaskCost" class="label2"><system:label show="text" label="sbtSimRestCosts" />:&nbsp;<system:label show="text" label="sbtSimRestCost" /></label></div><div style="margin-left: 20px" id="showSimulationResultTaskCostSection"><div class="field fieldFull inOneLine"><input type="checkbox" id="showSimulationResultTaskCostTable" name="showSimulationResultTaskCostTable"  checked/>&nbsp;<label  for="showSimulationResultTaskCostTable" class="label2"><system:label show="text" label="lblSimTskCostTable" /></label></div><div class="field fieldFull inOneLine"><input type="checkbox" id="showSimulationResultTaskCostChart" name="showSimulationResultTaskCostChart"  checked/>&nbsp;<label  for="showSimulationResultTaskCostChart" class="label2"><system:label show="text" label="lblSimTskCostChart" /></label></div></div></div></div></div></div></div></form></div><%@include file="../../includes/footer.jsp" %></body></html>
