<%@page import="biz.statum.apia.web.action.BasicAction"%><%@include file="../../includes/startInc.jsp" %><html lang="<%=biz.statum.apia.web.bean.BasicBeanStatic.getUserDataStatic(request).getLangCode()%>"><head><%@include file="../../includes/headInclude.jsp" %><script type="text/javascript" src="<system:util show="context" />/page/administration/profiles/edit.js"></script><script type="text/javascript" src="<system:util show="context" />/page/includes/adminFav.js"></script><script type="text/javascript" src="<system:util show="context" />/page/includes/adminActionsEdition.js"></script><script type="text/javascript" src="<system:util show="context" />/page/includes/navButtons.js"></script><script type="text/javascript" src="<system:util show="context" />/page/modals/environments.js"></script><script type="text/javascript" src="<system:util show="context" />/page/modals/dashboards.js"></script><script type="text/javascript" src="<system:util show="context" />/page/modals/functionalitiesTree.js"></script><script type="text/javascript" src="<system:util show="context" />/page/includes/campaigns.js"></script><script type="text/javascript">
			var URL_REQUEST_AJAX 	= '/apia.administration.ProfilesAction.run';
			var FNCS				= '<system:label show="text" label="sbtFncs" forScript="true" />';
			var DASH				= '<system:label show="text" label="sbtDash" forScript="true" />';
			var NO_FNCS_SEL			= '<system:label show="text" label="msgNoFncsSel" forScript="true" />';
		</script></head><body><div id="exec-blocker"></div><div class="body" id="bodyDiv"><form id="frmData"><div class="optionsContainer"><system:campaign inLogin="false" inSplash="false" location="verticalUp" /><div class="fncPanel info"><div class="title"><!-- GLOBAL --><system:edit show="ifValue" from="theBean" field="modeGlobal" value="true"><system:label show="text" label="mnuPer" /></system:edit><!-- ENVIRONMENT --><system:edit show="ifValue" from="theBean" field="modeGlobal" value="false"><system:label show="text" label="mnuAmbPer" /></system:edit><%@include file="../../includes/adminFav.jsp" %></div><div class="content divFncDescription"><div class="fncDescriptionImage" data-src="<system:edit show="value" from="theBean" field="fncImage"/>"></div><!-- GLOBAL --><system:edit show="ifValue" from="theBean" field="modeGlobal" value="true"><div id="fncDescriptionText"><system:label show="text" label="dscFncAdmPer"/></div></system:edit><!-- ENVIRONMENT --><system:edit show="ifValue" from="theBean" field="modeGlobal" value="false"><div id="fncDescriptionText"><system:label show="text" label="dscFncAdmEnvPer"/></div></system:edit><div class="clear"></div></div></div><%@include file="../../includes/adminActionsEdition.jsp" %><system:campaign inLogin="false" inSplash="false" location="verticalDown" /></div><div class="dataContainer"><div class='tabComponent' id="tabComponent"><div class="aTabHeader"><system:campaign inLogin="false" inSplash="false" location="horizontalUp" /></div><div class="aTab"><div class="tab"><system:label show="text" label="tabDatGen" /></div><div class="contentTab"><div class="fieldGroup"><div class="title"><system:label show="text" label="sbtDatPer" /></div><div class="field fieldTwoFifths required"><label title="<system:label show="tooltip" label="lblName" />"><system:label show="text" label="lblName" />:</label><input type="text" name="proName" id="proName" class="validate['required','~validName']" maxlength="50" value="<system:edit show="value" from="theEdition" field="prfName"/>"></div><div class="field fieldFull"><label title="<system:label show="tooltip" label="lblDesc" />"><system:label show="text" label="lblDesc" />:</label><textarea name="proDesc" id="proDesc" maxlength="255" cols=80 rows=3><system:edit show="value" from="theEdition" field="prfDesc"/></textarea></div></div><div class="fieldGroup split"><div style="height:100px"><input type="hidden" id="envs" name="envs" value=""><div class="title"><system:label show="text" label="sbtEnv" /></div><div class="modalOptionsContainer" id="envsContainer"><!-- GLOBAL --><system:edit show="ifValue" from="theBean" field="modeGlobal" value="true"><div class="element" data-helper="true" id="addEnv"><div class="option optionAdd" data-helper="true"><system:label show="text" label="btnAgr" /></div></div></system:edit></div></div></div><div class="fieldGroup split"><div class="profileFunctionalitiesContainer"><div class="title"><span id="tFunc"><system:label show="text" label="sbtFncs" /></span></div><div class="modalOptionsContainer" id="divFunctionalities"><div class="optionFunctionalities"><ul id="fncsContainer" style="visibility: hidden;"></ul></div><div class="clear"></div><div class="option optionAdd" id="addFnc" data-helper="true" style="visibility: hidden;"><system:label show="text" label="btnAgr" /></div></div></div><div id="divDash" style="margin-top: 40px;"><div class="title"><span id="tDash"><system:label show="text" label="sbtDash" /></span></div><div class="modalOptionsContainer" id="dashContainer"><div class="element" id="addDsh" data-helper="true"><div class="option optionAdd" data-helper="true"><system:label show="text" label="btnAgr" /></div></div></div></div></div></div></div></div><system:campaign inLogin="false" inSplash="false" location="horizontalDown" /></div></form></div><!-- MODALS --><%@include file="../../modals/environments.jsp" %><%@include file="../../modals/functionalitiesTree.jsp" %><%@include file="../../modals/dashboards.jsp" %><%@include file="../../includes/footer.jsp" %></body></html>
