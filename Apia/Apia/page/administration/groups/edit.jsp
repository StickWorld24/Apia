<%@include file="../../includes/startInc.jsp" %><html lang="<%=biz.statum.apia.web.bean.BasicBeanStatic.getUserDataStatic(request).getLangCode()%>"><head><%@include file="../../includes/headInclude.jsp" %><script type="text/javascript" src="<system:util show="context" />/page/administration/groups/edit.js"></script><script type="text/javascript" src="<system:util show="context" />/page/includes/adminActionsEdition.js"></script><script type="text/javascript" src="<system:util show="context" />/page/modals/environments.js"></script><script type="text/javascript" src="<system:util show="context" />/page/modals/images.js"></script><script type="text/javascript" src="<system:util show="context" />/page/includes/adminFav.js"></script><script type="text/javascript" src="<system:util show="context" />/page/includes/navButtons.js"></script><script type="text/javascript" src="<system:util show="context" />/page/generic/permissions.js"></script><script type="text/javascript" src="<system:util show="context" />/page/includes/campaigns.js"></script><script type="text/javascript">
		var URL_REQUEST_AJAX = '/apia.administration.GroupsAction.run';
		var isAllEnvs = "true";
		var isGlobal = "<system:edit show="value" from="theBean" field="modeGlobal"/>";

		var ADDITIONAL_INFO_IN_TABLE_DATA  = false;
		var MSG_USE_PROY_PERMS = '<system:label show="text" label="msgUseProyPerms" forScript="true" />';
		var MSG_PERM_WILL_BE_LOST = '<system:label show="text" label="msgPermDefWillBeLost" forScript="true" />';
		var POOL_DEFAULT_IMAGE = "<system:edit show="constant" from="com.dogma.vo.ImagesVo" field="DEFAULT_IMG_POOL" />";
	</script></head><body><div id="exec-blocker"></div><div class="body" id="bodyDiv"><form id="frmData"><div class="optionsContainer"><system:campaign inLogin="false" inSplash="false" location="verticalUp" /><div class="fncPanel info"><div class="title"><!-- GLOBAL --><system:edit show="ifValue" from="theBean" field="modeGlobal" value="true"><system:label show="text" label="mnuGru" /></system:edit><!-- ENVIRONMENT --><system:edit show="ifValue" from="theBean" field="modeGlobal" value="false"><system:label show="text" label="mnuAmbGro" /></system:edit><%@include file="../../includes/adminFav.jsp" %></div><div class="content divFncDescription"><div class="fncDescriptionImage" data-src="<system:edit show="value" from="theBean" field="fncImage"/>"></div><!-- GLOBAL --><system:edit show="ifValue" from="theBean" field="modeGlobal" value="true"><div id="fncDescriptionText"><system:label show="text" label="dscFncGroups"/></div></system:edit><!-- ENVIRONMENT --><system:edit show="ifValue" from="theBean" field="modeGlobal" value="false"><div id="fncDescriptionText"><system:label show="text" label="dscFncEnvGroups"/></div></system:edit><div class="clear"></div></div></div><%@include file="../../includes/adminActionsEdition.jsp" %><div id="divAdminActEdit" class="fncPanel buttons"><div class="title"><system:label show="text" label="mnuOpc" /></div><div class="content"><div id="btnResetImage" class="button extendedSize" title="<system:label show="tooltip" label="btnResetImg" />"><system:label show="text" label="btnResetImg" /></div></div></div><system:campaign inLogin="false" inSplash="false" location="verticalDown" /></div><div class="dataContainer"><div class='tabComponent' id="tabComponent"><div class="aTabHeader"><system:campaign inLogin="false" inSplash="false" location="horizontalUp" /></div><div class="aTab"><div class="tab"><system:label show="text" label="tabDatGen" /></div><div class="contentTab"><div class="fieldGroup"><div class="field fieldTwoFifths required"><label title="<system:label show="tooltip" label="lblNom" />"><system:label show="text" label="lblNom" />:</label><input type="text" name="poolName" id="poolName" maxlength="50" class="validate['required','~validName']"  value="<system:edit show="value" from="theEdition" field="poolName"/>"></div><div class="field fieldFull"><label title="<system:label show="tooltip" label="lblDesc" />"><system:label show="text" label="lblDesc" />:</label><textarea name="poolDesc" id="poolDesc" maxlength = "255" cols=80 rows=3><system:edit show="value" from="theEdition" field="poolDesc"/></textarea></div><br/></div><div class="fieldGroup splitOneThirdImg"><div class="field"><label style="text-align: start;" title="<system:label show="tooltip" label="lblImage" />"><system:label show="text" label="lblImage" />:</label></div><div class="fieldImg"><div id="poolImage" class="imagePicker" style="background-image: url('<system:util show="context" />/images/uploaded/<system:edit show="value" from="theEdition" field="imgPath"/>')"><input type="hidden" id="imgPath" name="imgId" value="<system:edit show="value" from="theEdition" field="imgPath"/>"></div></div></div><div class="fieldGroup" style="display: inline !important;"><div class="field fieldOneThird"><label title="<system:label show="tooltip" label="lblPubRSSPool" />" class="label"><system:label show="text" label="lblPubRSSPool" />:&nbsp;</label><input type="checkbox" id="flagPubRSS" name="flagPubRSS" <system:edit show="ifFlag" from="theEdition" field="0">checked</system:edit> /></div></div><div class="fieldGroup" style="display: inline !important;"><div class="field fieldOneThird"><label title="<system:label show="tooltip" label="lblAvoidChat" />" class="label"><system:label show="text" label="lblAvoidChat" />:&nbsp;</label><input type="checkbox" id="flagAvoidChat" name="flagAvoidChat" <system:edit show="ifFlag" from="theEdition" field="1">checked</system:edit> /></div></div><!-- Si es global --><system:edit show="ifValue" from="theBean" field="modeGlobal" value="true"><br/><br/><div class="fieldGroup"><div class="field fieldExtended"><label title="<system:label show="tooltip" label="sbtEnv" />"><system:label show="text" label="sbtEnv" />:</label><div id="envContainter" class="modalOptionsContainer"><div id="envContainterAll" class="option" data-helper="true"><system:label show="text" label="lblTodAmb" /></div><div data-helper="true" id="addEnvironment" class="element docAddDocument"><div class="option optionAdd"><system:label show="text" label="btnAgr" /></div></div></div><div class="clear"></div></div></div></system:edit></div></div><div class="aTab"><div class="tab"><system:label show="text" label="sbtSimData" /></div><div class="contentTab"><div class="fieldGroup"><div class="field fieldOneFifths"><label title="<system:label show="tooltip" label="lblSimPoolType" />"><system:label show="text" label="lblSimPoolType" />:</label><select name="simType"><option></option><option value="<system:edit show="constant" from="com.dogma.vo.PoolVo" field="SIM_TYPE_HUMAN" />" <system:edit show="ifConstant" from="theEdition" field="poolSimType" value="com.dogma.vo.PoolVo.SIM_TYPE_HUMAN">selected</system:edit>><system:label show="text" label="lblSimPoolTypeH" /></option><option value="<system:edit show="constant" from="com.dogma.vo.PoolVo" field="SIM_TYPE_AUTOMATIC" />" <system:edit show="ifConstant" from="theEdition" field="poolSimType" value="com.dogma.vo.PoolVo.SIM_TYPE_AUTOMATIC">selected</system:edit>><system:label show="text" label="lblSimPoolTypeA" /></option></select></div><div class="field fieldTwoFifths"><label title="<system:label show="tooltip" label="lblSimPoolCal" />"><system:label show="text" label="lblSimPoolCal" />:</label><select name="simCalId" id="simCalId"><option></option><system:util show="prepareCalendars" saveOn="calendars" /><system:edit show="iteration" from="calendars" saveOn="calendar"><system:edit show="saveValue" from="calendar" field="calendarId" saveOn="calId"/><option value="<system:edit show="value" from="calendar" field="calendarId"/>" <system:edit show="ifValue" from="theEdition" field="poolSimCalId" value="with:calId">selected</system:edit> ><system:edit show="value" from="calendar" field="calendarName"/></option></system:edit></select></div><br/><br/><div class="field fieldOneFifths"><label title="<system:label show="tooltip" label="lblSimPoolCostH" />"><system:label show="text" label="lblSimPoolCostH" />:</label><input type="text" name="simCostH" id="simCostH" value="<system:edit show="value" from="theEdition" field="poolSimCostHour"/>"></div><div class="field fieldOneFifths"><label title="<system:label show="tooltip" label="lblSimPoolCostF" />"><system:label show="text" label="lblSimPoolCostF" />:</label><input type="text" name="simCostF" id="simCostF" value="<system:edit show="value" from="theEdition" field="poolSimCostFixed"/>"></div></div></div></div></div><system:campaign inLogin="false" inSplash="false" location="horizontalDown" /></div><!-- MODALS --><%@include file="../../modals/environments.jsp" %><%@include file="../../modals/images.jsp" %></form></div><%@include file="../../includes/footer.jsp" %></body></html>

