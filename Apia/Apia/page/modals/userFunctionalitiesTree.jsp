<system:edit show="ifModalNotLoaded" field="userFunctionalitiesTree.jsp"><system:edit show="markModalAsLoaded" field="userFunctionalitiesTree.jsp" /><script type="text/javascript">
		var URL_REQUEST_AJAX_TREE_FNC = '/apia.modals.FunctionalitiesAction.run';
		var MSG_NO_ITEMS = '<system:label show="text" label="msgNoItems" forScript="true" />';
	</script><div id="mdlUsrTreeFncsContainer" class="mdlContainer hiddenModal"><div class="mdlHeader"><system:label show="text" label="titUsrFncTree" /></div><div class="mdlBody"><div class="modalOptionsContainer" style="min-height: 150px;"><div class="optionUserEnvFunc"><span><system:label show="text" label="sbtUsuEnv" />:</span><select name="userEnvs" id="userEnvs" onchange="updateEnvUsrTreeFunc()"></select></div><div class="optionFunctionalities forceMaxHeight" id="mdlUsrTreeFncBody"><ul id="usrFncsContainerTreeMdl" class="fncContainer modal"></ul></div></div></div><div class="mdlFooter"><div class="close" id="closeUsrTreeFncMdl"><system:label show="text" label="btnCer" /></div></div></div></system:edit>