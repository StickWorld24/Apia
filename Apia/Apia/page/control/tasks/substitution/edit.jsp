<%@page import="com.st.util.labels.LabelManager"%><%@include file="../../../includes/startInc.jsp" %><html lang="<%=biz.statum.apia.web.bean.BasicBeanStatic.getUserDataStatic(request).getLangCode()%>"><head><%@include file="../../../includes/headInclude.jsp" %><script type="text/javascript" src="<system:util show="context" />/page/control/tasks/substitution/edit.js"></script><script type="text/javascript" src="<system:util show="context" />/page/modals/users.js"></script><script type="text/javascript" src="<system:util show="context" />/page/modals/profiles.js"></script><script type="text/javascript" src="<system:util show="context" />/page/includes/adminActionsEdition.js"></script><script type="text/javascript" src="<system:util show="context" />/page/includes/navButtons.js"></script><script type="text/javascript" src="<system:util show="context" />/js/autocomplete/autocompleter.js"></script><script type="text/javascript" src="<system:util show="context" />/js/autocomplete/autocompleter.request.js"></script><script type="text/javascript" src="<system:util show="context" />/js/autocomplete/observer.js"></script><script type="text/javascript" src="<system:util show="context" />/page/includes/campaigns.js"></script><script type="text/javascript">
		var URL_REQUEST_AJAX = '/apia.control.UsersSubstituteAction.run';
		var HIERARCHY = <%=request.getParameter("hierarchy")%>;
		var FNC_DESCRIPTION = "Esta funcionalidad sirve para sadsdsadsadas dasdsa sd dsa das da sd s sdcfdaf dsf sdf sdf sdfsd f dsfadsfewf qd";
		var BTN_ADD = '<system:label show="text" label="btnAgr" forScript="true" />';
		var MSGSUBTALREADYEXIST = '<system:label show="text" label="msgSubtAlreadyExist" forScript="true" />';
		var MSGUSERMUSTHAVESUST = '<system:label show="text" label="msgUserMustHaveSust" forScript="true" />';
		var IS_FINISHED	= toBoolean('<system:edit show="value" from="theBean" field="finished" />');
		var ENV_ID = '<system:edit show="value" from="theBean" field="envId" />';
		var MSG_CHANGE_DATE = '<system:label show="text" label="msgSubtAlreadyExist" forScript="true" />';
				
		var POOLS_IN_HIERARCHY = '<system:edit show="value" from="theBean" field="poolsHierarchy"/>';
	</script></head><body><div class="body" id="bodyDiv"><form id="frmData"><div class="optionsContainer"><system:campaign inLogin="false" inSplash="false" location="verticalUp" /><div class="fncPanel info"><div class="title"><system:label show="text" label="titLeave" /><%@include file="../../../includes/adminFav.jsp" %></div><div class="content divFncDescription"><div class="fncDescriptionImage" data-src="<system:edit show="value" from="theBean" field="fncImage"/>"></div><div id="fncDescriptionText"><system:label show="text" label="dscFncAdmLeave"/></div><div class="clear"></div></div></div><%@include file="../../../includes/adminActionsEdition.jsp" %><div class="fncPanel options" id="panelInfo"><div class="title"><system:label show="text" label="mnuOpc"/></div><div id="opcBtns" class="content hidden"><div id="addAllSust" class="button extendedSize" title="<system:label show="tooltip" label="btnSustAllGrps" />"><system:label show="text" label="btnSustAllGrps" /></div><div id="addAllProfSust" class="button extendedSize" title="<system:label show="tooltip" label="btnProfAllGrps" />"><system:label show="text" label="btnProfAllGrps" /></div></div></div><system:campaign inLogin="false" inSplash="false" location="verticalDown" /></div><div class="dataContainer"><div class='tabComponent' id="tabComponent"><div class="aTabHeader"><system:campaign inLogin="false" inSplash="false" location="horizontalUp" /></div><div class="aTab"><div class="tab"><system:label show="text" label="tabBusClaGen" /></div><div class="contentTab"><div class="fieldGroup"><div class="title"><system:label show="text" label="sbtSetUsrSub" /></div><div class="field required"><label title="<system:label show="tooltip" label="lblLog" />"><system:label show="text" label="lblLog" />:</label><input type="text" name="usrLogin" id="usrLogin" class="validate['required'] autocomplete" value=""></div><div class="field"><label title="<system:label show="tooltip" label="lblNom" />"><system:label show="text" label="lblNom" />:</label><div><span id="usrName"></span></div></div><div class="field"><label title="<system:label show="tooltip" label="lblEma" />"><system:label show="text" label="lblEma" />:</label><div><span id="usrEmail"></span></div></div><div class="field required"><label title="<system:label show="tooltip" label="lblDteFrom" />"><system:label show="text" label="lblDteFrom" />:</label><input type="text" name="dteFrom" id="dteFrom" class="datePickerCustom filterInputDate validate['required']" style="width:120px"></div><div class="field"><label title="<system:label show="tooltip" label="lblDteTo" />"><system:label show="text" label="lblDteTo" />: </label><input type="text" name="dteTo" id="dteTo" class="datePickerCustom filterInputDate"  style="width:120px"></div></div><div class="fieldGroup"><div class="title"><system:label show="text" label="sbtSetUsrSub" /></div><div class="gridContainer" style="margin: 0px"><div class="gridHeader"><!-- Cabezal--><table><thead><tr class="header"><th title="<system:label show="tooltip" label="titGru" />" style="width: 20%;"><div style="width: 100%;"><system:label show="text" label="titGru" /></div></th><th title="<system:label show="tooltip" label="lblUsuSub" />" style="width: 40%;"><div style="width: 100%;"><system:label show="text" label="lblUsuSub" /></div></th><th title="<system:label show="tooltip" label="lblPrf" />" style="width: 40%;"><div style="width: 100%;"><system:label show="text" label="lblPrf" /></div></th></tr></thead></table></div><div class="gridBody" id="gridTableBody"><!-- Cuerpo de la tabla --><table id="table"><thead><tr><th width="20%"></th><th width="40%"></th><th width="40%"></th></tr></thead><tbody class="tableData" id="tableData"></tbody></table></div><div class="clear"></div></div></div></div></div></div><system:campaign inLogin="false" inSplash="false" location="horizontalDown" /></div><!-- MODALS --><%@include file="../../../modals/users.jsp" %><%@include file="../../../modals/profiles.jsp" %></form></div><%@include file="../../../includes/footer.jsp" %></body></html>

