<%@page import="biz.statum.apia.web.action.BasicAction"%><%@page import="biz.statum.sdk.util.HttpServletRequestResponse"%><%@page import="com.dogma.vo.BusClassVo"%><%@include file="../../includes/startInc.jsp" %><html lang="<%=biz.statum.apia.web.bean.BasicBeanStatic.getUserDataStatic(request).getLangCode()%>"><head><%@include file="../../includes/headInclude.jsp" %><link href="<system:util show="context" />/js/codemirror/lib/codemirror.css" rel="stylesheet"><link href="<system:util show="context" />/js/codemirror/addon/dialog/dialog.css" rel="stylesheet"><link href="<system:util show="context" />/js/codemirror/addon/hint/show-hint.css" rel="stylesheet"><link href="<system:util show="context" />/js/codemirror/addon/tern/tern.css" rel="stylesheet"><link href="<system:util show="context" />/js/codemirror/theme/eclipse.css" rel="stylesheet"><script type="text/javascript" src="<system:util show="context" />/page/design/businessclasses/edit.js"></script><script type="text/javascript" src="<system:util show="context" />/page/includes/adminActionsEdition.js"></script><script type="text/javascript" src="<system:util show="context" />/page/includes/navButtons.js"></script><script type="text/javascript" src="<system:util show="context" />/page/modals/pools.js"></script><script type="text/javascript" src="<system:util show="context" />/page/generic/permissions.js"></script><script type="text/javascript" src="<system:util show="context" />/page/includes/campaigns.js"></script><script type="text/javascript" src="<system:util show="context" />/js/codemirror/lib/codemirror.js"></script><script type="text/javascript" src="<system:util show="context" />/js/codemirror/addon/edit/matchbrackets.js"></script><script type="text/javascript" src="<system:util show="context" />/js/codemirror/addon/comment/continuecomment.js"></script><script type="text/javascript" src="<system:util show="context" />/js/codemirror/addon/comment/comment.js"></script><script type="text/javascript" src="<system:util show="context" />/js/codemirror/addon/hint/show-hint.js"></script><script type="text/javascript" src="<system:util show="context" />/js/codemirror/addon/hint/apia-hint.js"></script><script type="text/javascript" src="<system:util show="context" />/js/codemirror/addon/dialog/dialog.js"></script><script type="text/javascript" src="<system:util show="context" />/js/codemirror/addon/search/searchcursor.js"></script><script type="text/javascript" src="<system:util show="context" />/js/codemirror/addon/search/search.js"></script><script type="text/javascript" src="<system:util show="context" />/js/codemirror/addon/tern/tern.js"></script><script type="text/javascript" src="<system:util show="context" />/js/codemirror/mode/javascript/javascript.js"></script><script type="text/javascript" src="<system:util show="context" />/js/tern/acorn/acorn.js"></script><script type="text/javascript" src="<system:util show="context" />/js/tern/acorn/acorn_loose.js"></script><script type="text/javascript" src="<system:util show="context" />/js/tern/acorn/util/walk.js"></script><script type="text/javascript" src="<system:util show="context" />/js/tern/lib/signal.js"></script><script type="text/javascript" src="<system:util show="context" />/js/tern/lib/tern.js"></script><script type="text/javascript" src="<system:util show="context" />/js/tern/lib/def.js"></script><script type="text/javascript" src="<system:util show="context" />/js/tern/lib/comment.js"></script><script type="text/javascript" src="<system:util show="context" />/js/tern/lib/infer.js"></script><script type="text/javascript" src="<system:util show="context" />/js/tern/plugin/doc_comment.js"></script><!--script type="text/javascript" src="<system:util show="context" />/page/execution/scripts/API/apiaFunctions.js"></script--><script type="text/javascript">
		var URL_REQUEST_AJAX = '/apia.design.BusinessClassesAction.run';
		var MSG_PERMISSIONS_ERROR = '<system:label show="text" label="msgPermError" forScript="true" />';
		var MSG_MUST_SEL_ONE = '<system:label show="text" label="msgDebSelUno" forScript="true" />';
		var MSG_PERM_WILL_BE_LOST = '<system:label show="text" label="msgPermDefWillBeLost" forScript="true" />';
		var TYPE_SELECTED = '<system:edit show="value" from="theEdition" field="busClaType"/>'
// 		var GNR_PER_DAT_ING = '<system:label show="text" label="msgPerDatIng" forScript="true" />';
		var canExplore = '<system:edit show="value" from="theBean" field="canExplore"/>';
		var WSDLUrl = '<system:edit show="value" from="theEdition" field="busClaUrl"/>';
		var ADDITIONAL_INFO_IN_TABLE_DATA  = false;
		var BUS_CLA_NAME = '<system:edit show="value" from="theEdition" field="busClaName"/>';
		var TYPE_QRY_FIL = '<system:edit show="constant" from="com.dogma.vo.BusClassVo" field="TYPE_QRY_FILTER" />';
		var TYPE_JAV = '<system:edit show="constant" from="com.dogma.vo.BusClassVo" field="TYPE_JAVA_PROGRAMMING" />';
		var IS_DATABASE_CLASS = '<system:edit show="ifValue" from="theEdition" field="databaseClass" value="true" >true</system:edit>';	
		var TYPE_WS_SOA = '<system:edit show="constant" from="com.dogma.vo.BusClassVo" field="TYPE_COMPLEX_WEB_SERVICE" />';
		var TYPE_WS_REST = '<system:edit show="constant" from="com.dogma.vo.BusClassVo" field="TYPE_REST_WEB_SERVICE" />';
		var LBL_NUMERIC = '<system:label show="text" label="lblNum" forScript="true" forHtml="true" />';
		var LBL_STRING = '<system:label show="text" label="lblStr" forScript="true" forHtml="true"/>';
		var LBL_DATE = '<system:label show="text" label="lblFec" forScript="true" forHtml="true"/>';
		var LBL_INT = '<system:label show="text" label="lblInt" forScript="true" forHtml="true"/>';
		var LBL_IN = '<system:label show="text" label="lblIn" forScript="true" />';
		var LBL_OUT = '<system:label show="text" label="lblOut" forScript="true" />';
		var LBL_INOUT = '<system:label show="text" label="lblInOut" forScript="true" />';
		var TYPE_SCR = '<system:edit show="constant" from="com.dogma.vo.BusClassVo" field="TYPE_JSCPT_PROGRAMMING" />';
		var TYPE_DB  = '<system:edit show="constant" from="com.dogma.vo.BusClassVo" field="TYPE_DATA_BASE" />';
		var TYPE_DB_PROC = '<system:edit show="constant" from="com.dogma.vo.BusClassVo" field="TYPE_DATA_BASE_PROC" />';
		var BUS_CLA_ID = '<system:edit show="value" from="theEdition" field="busClaId"/>'
		var SEL_WS_METHOD =  '<system:edit show="value" from="theBean" field="wsMethod" />';
		var MSG_USE_PROY_PERMS = '<system:label show="text" label="msgUseProyPerms" forScript="true" />';
		
		var MODE_CREATE	= toBoolean('<system:edit show="value" from="theBean" field="modeCreate" />');
		
		
		/*var ECMA_URL = '<system:util show="context" />/js/codemirror/addon/tern/ecma5.jsp?busClaId=' + BUS_CLA_ID + TAB_ID_REQUEST;*/
		var ECMA_URL = '<system:util show="context" />/js/codemirror/addon/tern/ecma5.json?' + TAB_ID_REQUEST;
		
		var currentEnvironmentName = '<system:util show="currentEnvironmentName" />';
		var JS_EXECUTABLE = '<system:edit show="value" from="theBean" field="strExe"/>';
		
		var REST_TEST_MODAL	= '<system:util show="context"/>/page/design/businessclasses/testRestService.jsp';
		var LBL_JSON_PATH = '<system:label show="text" label="lblJsonPath" forScript="true" />';
		var LBL_XPATH = '<system:label show="text" label="lblXPath" forScript="true" />';
		var LBL_CLOSE = '<system:label show="text" label="lblCloseWindow" forScript="true" />';
	</script></head><body><div id="exec-blocker"></div><div class="header"></div><div class="body" id="bodyDiv"><form id="frmData"><div class="optionsContainer"><system:campaign inLogin="false" inSplash="false" location="verticalUp" /><div class="fncPanel info"><div class="title"><system:label show="text" label="mnuClaNeg" /></div><div class="content divFncDescription"><div class="fncDescriptionImage" data-src="<system:edit show="value" from="theBean" field="fncImage"/>"></div><div id="fncDescriptionText"><system:label show="text" label="dscFncAdmBusCla" /></div><div class="clear"></div></div></div><%@include file="../../includes/adminActionsEdition.jsp" %><div class="fncPanel options" id="panelOptions" style='display:none'><div class="title"><system:label show="text" label="mnuOpc" /></div><div class="content"><div id="optionUpload" class="button" <system:label show="tooltip" label="btnUpl" />><system:label show="text" label="btnUpl" /></div><div id="btnTest"  class="button" title="<system:label show="text" label="btnTest" />"><system:label show="text" label="btnTest" /></div><div id="btnTestQuery"  class="button" title="<system:label show="text" label="btnTest" />"><system:label show="text" label="btnTest" /></div><div id="btnTestBR"  class="button" title="<system:label show="text" label="btnTest" />"><system:label show="text" label="btnTest" /></div><div id="btnExplore" class="button" disabled="true" title="<system:label show="tooltip" label="btnExp" />"><system:label show="text" label="btnExp" /></div><div id="btnAct" class="button"  title="<system:label show="tooltip" label="btnAct" />" ><system:label show="text" label="btnAct" /></div><div id="btnTestRest" class="button" <system:label show="tooltip" label="btnTest" />><system:label show="text" label="btnTest" /></div><system:edit show="ifValue" from="theBean" field="modeCreate" value="false"><div id="btnShowExInfo"  class="button" title="<system:label show="text" label="btnShowExInfo" />"><system:label show="text" label="btnShowExInfo" /></div></system:edit><div class="clear"></div></div><div class="clear"></div></div><div class="fncPanel options" id="panelShortcuts"><div class="title"><system:label show="text" label="lblShortcuts" /></div><div class="content"><div class="filter"><span class="infoGenData"><b>Ctrl + <system:label show="text" label="lblSpace" />: </b></span><system:label show="text" label="lblCodeCompletition" /><br><span class="infoGenData"><b>Ctrl + F: </b></span><system:label show="text" label="lblSearch" /><br><span class="infoGenData"><b>Ctrl + G: </b></span><system:label show="text" label="lblSearchNext" /><br><span class="infoGenData"><b>Ctrl + Shift + G: </b></span><system:label show="text" label="lblSearchPrevious" /><br><span class="infoGenData"><b>Ctrl + Shift + F: </b></span><system:label show="text" label="lblReplace" /><br><span class="infoGenData"><b>Ctrl + Shift + R: </b></span><system:label show="text" label="lblNoAskReplace" /><br><span class="infoGenData"><b>Ctrl + Z: </b></span><system:label show="text" label="lblUndo" /><br><span class="infoGenData"><b>Ctrl + Y: </b></span><system:label show="text" label="lblRedo" /><br><span class="infoGenData"><b>Ctrl + I: </b></span><system:label show="text" label="lblVarType" /><br><span class="infoGenData"><b>Alt + .: </b></span><system:label show="text" label="lblVarDef" /><br><span class="infoGenData"><b>Alt + ,: </b></span><system:label show="text" label="lblPrevPos" /><br></div></div></div><system:campaign inLogin="false" inSplash="false" location="verticalDown" /></div><div class="dataContainer"><div class='tabComponent' id="tabComponent"><div class="aTabHeader"><system:campaign inLogin="false" inSplash="false" location="horizontalUp" /></div><div class="aTab"><div class="tab" id="datGen"><system:label show="text" label="tabBusClaGen" /></div><div class="contentTab"><div class="fieldGroup"><div class="title"><system:label show="text" label="sbtDatBusCla" /></div><div class="field required fieldTwoFifths"><label title="<system:label show="tooltip" label="lblNom" />"><system:label show="text" label="lblNom" />:&nbsp;</label><input type="text" name="bcName" id="bcName" maxlength="50" class="validate['required','~validName']" value="<system:edit show="value" from="theEdition" field="busClaName"/>"></div><system:edit show="ifNotExistsValue" from="theEdition" field="busClaId" ><div class="field required fieldTwoFifths"><label title="<system:label show="tooltip" label="lblTipDat" />"><system:label show="text" label="lblTipDat" />:</label><select name="cmbType" id="busType" onchange="showType(this.value)" class="validate['required']"><system:util show="prepareTypeBusinessClasses" saveOn="types" /><system:edit show="iteration" from="types" saveOn="type_save"><system:edit show="saveValue" from="type_save" field="type" saveOn="type"/><option value="<system:edit show="value" from="type_save" field="type"/>" <system:edit show="ifValue" from="theEdition" field="busClaType" value="with:type" >selected</system:edit>><system:edit show="value" from="type_save" field="typeName"/></option></system:edit></select></div></system:edit><system:edit show="ifExistsValue" from="theEdition" field="busClaId" ><div class="field fieldTwoFifths"><label title="<system:label show="tooltip" label="lblTipDat" />"><system:label show="text" label="lblTipDat" />:&nbsp;</label><br><span><system:edit show="value" from="theBean" field="name"/></span><input type="hidden" value="<system:edit show="value" from="theEdition" field="busClaType"/>" name="cmbType"/></div></system:edit><div class="field fieldOneFifths fieldLast"><label title="<system:label show="tooltip" label="titPrj" />"><system:label show="text" label="titPrj" />:&nbsp;</label><select name="selPrj" id="cmbProject" onchange='cmbPrjChange(this)' ><system:util show="prepareProjects" saveOn="projects" /><system:edit show="iteration" from="projects" saveOn="project"><system:edit show="saveValue" from="project" field="prjId" saveOn="prjId"/><option value="<system:edit show="value" from="project" field="prjId"/>"  data-prefix="<system:edit show="value" from="project" field="prjPrefix"/>"  <system:edit show="ifValue" from="theEdition" field="prjId" value="with:prjId">selected</system:edit>><system:edit show="value" from="project" field="prjTitle"/></option></system:edit></select></div><div class="clearLeft"></div><div class="field fieldFull"><label title="<system:label show="tooltip" label="lblDes" />"><system:label show="text" label="lblDes" />:&nbsp;</label><textarea name="txtDesc" id="txtDesc" maxlength="255" cols=80 rows=3><system:edit show="value" from="theEdition" field="busClaDesc"/></textarea></div><div class="clearLeft"></div><div class="field"><label title="<system:label show="tooltip" label="lblSchStaDis" />" for="chkEnaDis" class="label"><system:label show="text" label="lblSchStaDis" />:&nbsp;</label><input type="checkbox" id="chkEnaDis" name="chkDisabled" value="true" <system:edit show="ifFlag" from="theEdition" field="0" >checked</system:edit> /></div></div><br/><div class="fieldGroup" id="specific"><div class="title"><system:label show="text" label="sbtDatEspBusCla" /></div><div class="field required fieldOneFifths" id="divConn" style='display:none'><label title="<system:label show="tooltip" label="lblCon" />"><system:label show="text" label="lblCon" />:&nbsp;</label><select name="connectionsCombo" id="connectionsCombo" onchange="populateCombo()" ><option value="-1"  <system:edit show="ifValue" from="theEdition" field="dbConId" value="-1">selected</system:edit> ><system:label show="text" label="lblLocalDbNom" /></option><system:util show="prepareConnectionsList" saveOn="conns" /><system:edit show="iteration" from="conns" saveOn="connection"><system:edit show="saveValue" from="connection" field="dbConId" saveOn="dbConId"/><option value="<system:edit show="value" from="connection" field="idSepName"/>" <system:edit show="ifValue" from="theEdition" field="dbConId" value="with:dbConId">selected</system:edit>><system:edit show="value" from="connection" field="dbConName"/></option></system:edit></select></div><div  class="field fieldTwoFifths" id="divB" style='display:none'><div class="field required fieldFull"><label title="<system:label show="tooltip" label="lblVis" />"><system:label show="text" label="lblVis" />:&nbsp;</label><div class='cmbDbTableContainer' id='cmbDbTableContainer'></div></div></div><div  class="field fieldTwoFifths" id="divD" style='display:none'><div class="field required fieldFull"><label title="<system:label show="tooltip" label="lblProAlm" />"><system:label show="text" label="lblProAlm" />:&nbsp;</label><div class='cmbProcTableContainer' id='cmbProcTableContainer'></div><label title="<system:label show="tooltip" label="lblProAlmExe" />" style='font-weight:normal'><system:label show="text" label="lblProAlmExe" /></label></div></div><div id="divP" style='display:none'><!-- Java --><div class="fieldGroup"><div class="field fieldExtended required"><label title="<system:label show="tooltip" label="lblEje" />"><system:label show="text" label="lblEje" />:&nbsp;</label><input id="txtExeJava" name="txtExeJava" type="text"   value="<system:edit show="value" from="theEdition" field="busClaExecutable"/>" /></div></div><div class="fieldGroup"><div class="field"><label title="<system:label show="tooltip" label="lblPubWs" />" for="chkPubWs" class="label"><system:label show="text" label="lblPubWs" /><input type="checkbox" id="chkPubWs" value="true" name="chkPubWs"  <system:edit show="ifExistsValue" from="theEdition" field="wsPublicationVo" >checked</system:edit>/></label></div></div><div class="fieldGroup"><div class="field extendedSize"><label title="<system:label show="tooltip" label="lblNamePubWs" />" for="txtWsName"><system:label show="text" label="lblNamePubWs" />:&nbsp;</label><input id="txtWsName" name="txtWsName" value="<system:edit show="value" from="theEdition" field="wsPublicationVoName"/>"  <system:edit show="ifNotExistsValue" from="theEdition" field="wsPublicationVo" >disabled='disabled'</system:edit> /></div></div><div class="fieldGroup"><div class="field"><label title="<system:label show="tooltip" label="lblExecByAjax" />" for="chkExecByAjax" class="label"><system:label show="text" label="lblExecByAjax" /><input type="checkbox" id="chkExecByAjax" value="true" name="chkExecByAjax" <system:edit show="ifFlag" from="theEdition" field="7" >checked</system:edit>/></label></div></div><!-- End Java --></div><div id="divT" style='display:none'><!-- Script --><div class="fieldGroup"><div class="field required fieldExtended"><label title="<system:label show="tooltip" label="lblEje" />"><system:label show="text" label="lblEje" />:&nbsp;</label><input id="txtExeScript" name="txtExeScript" type="text"   value="<system:edit show="value" from="theBean" field="strExe"/>" /></div></div><div class="fieldGroup"><div class="field fieldExtended" style="display:block; width: 100%; height: 300px"><label></label><textarea id="txtJS" name="txtJS" rows='18' style="width: 300px; height: 300px;"><system:edit show="value" from="theBean" field="script"/></textarea></div><br><br><div class="field fieldExtended"><label><system:label show="text" label="lblAyuClaNeg1" /></label><ul><li><system:label show="text" label="lblAyuClaNeg2" /></li><li><system:label show="text" label="lblAyuClaNeg3" /></li></ul></div><div class="clear"></div></div><!-- End script --></div><div id="divC" style='display:none'><!-- WebService SOA --><div class="fieldGroup"><div class="field fieldTwoFifths required"><label title="<system:label show="tooltip" label="lblWSDLUrl" />"><system:label show="text" label="lblWSDLUrl" />:&nbsp;</label><input id="txtUrl" name="txtUrl" type="text" value="<system:edit show="value" from="theEdition" field="busClaUrl"/>" <system:edit show="ifValue" from="theBean" field="canExplore" value="true">onchange="enableExplore()"</system:edit>/></div><div class="field extendedSize" id="divWSOpeName" style="display: <system:edit show="value" from="theBean" field="styleByModeInput"/>"><label title="<system:label show="tooltip" label="lblOpeName" />"><system:label show="text" label="lblOpeName" />:&nbsp;</label><br><span><system:edit show="value" from="theBean" field="wsMethod" /></span><input type="hidden" id="WSMethodName" name="WSMethodName" value="<system:edit show="value" from="theBean" field="wsMethod" />" /></div><div class="field fieldTwoFifths" id="divCmbMethod" style="display: <system:edit show="value" from="theBean" field="styleByModeCmb"/>"><label title="<system:label show="tooltip" label="lblOpeName" />"><system:label show="text" label="lblOpeName" />:&nbsp;</label><div id="divMethods" style="width: 100%"><select name="cmbMetName" id="cmbMetName" style="width: 100%;"><option value=""></option></select></div></div></div><div class="fieldGroup"><div class="field"><label title="<system:label show="tooltip" label="lblBasAuth" />" for="chkBasicAuth" class="label"><system:label show="text" label="lblBasAuth" />:&nbsp;</label><input type="checkbox" id="chkBasicAuth" name="chkBasicAuth" onclick="changeAuthBasic()" <system:edit show="ifFlag" from="theEdition" field="1" >checked</system:edit>/></div><div class="field fieldOneThird"><label title="<system:label show="tooltip" label="lblUsu" />"><system:label show="text" label="lblUsu" />:&nbsp;</label><input type="text" name="txtAuthUsr" id="txtAuthUsr"   value="<system:edit show="value" from="theEdition" field="busClaAuthUsr"/>" <system:edit show="ifNotFlag" from="theEdition" field="1" >disabled='disabled'</system:edit>></div><div class="field fieldOneThird"><label title="<system:label show="tooltip" label="lblPwd" />"><system:label show="text" label="lblPwd" />:&nbsp;</label><input type="password" name="txtAuthPwd" id="txtAuthPwd"   value="<system:edit show="value" from="theEdition" field="busClaAuthPwd"/>" <system:edit show="ifNotFlag" from="theEdition" field="1" >disabled='disabled'</system:edit>></div></div><div class="fieldGroup"><div class="field"><label title="<system:label show="tooltip" label="lblWSSUT" />" for="chkWssUT" class="label"><system:label show="text" label="lblWSSUT" />:&nbsp;</label><input type="checkbox" name="chkWssUT" id="chkWssUT" value="true" onclick="changeWssUT()"  <system:edit show="ifFlag" from="theEdition" field="2" >checked='checked'</system:edit>></div><div class="field fieldOneThird"><label title="<system:label show="tooltip" label="lblUsu" />"><system:label show="text" label="lblUsu" />:&nbsp;</label><input type="text" name="txtWssUTUsr" id="txtWssUTUsr"   value="<system:edit show="value" from="theEdition" field="busClaWssUtUsr"/>" <system:edit show="ifNotFlag" from="theEdition" field="2" >disabled='disabled'</system:edit>></div><div class="field fieldOneThird"><label title="<system:label show="tooltip" label="lblPwd" />"><system:label show="text" label="lblPwd" />:&nbsp;</label><input type="password" name="txtWssUTPwd" id="txtWssUTPwd"   value="<system:edit show="value" from="theEdition" field="busClaWssUtPwd"/>" <system:edit show="ifNotFlag" from="theEdition" field="2" >disabled='disabled'</system:edit>></div></div><br/><br/><div class="fieldGroup"><div class="field fieldOneThird"><label title="<system:label show="tooltip" label="lblWSSendStrTag" />"><system:label show="text" label="lblWSSendStrTag" />:&nbsp;</label><select name="cmbWSStrTag" id="cmbWSStrTag"><system:util show="prepareWebServiceSendTags" saveOn="types" /><system:edit show="iteration" from="types" saveOn="type_save"><system:edit show="saveValue" from="type_save" field="type" saveOn="type"/><option value="<system:edit show="value" from="type_save" field="type"/>" <system:edit show="ifValue" from="theEdition" field="busClaWsStrTag" value="with:type" >selected</system:edit>><system:edit show="value" from="type_save" field="typeName"/></option></system:edit></select></div><div class="field fieldOneThird"><label title="<system:label show="tooltip" label="lblWSSendNumTag" />"><system:label show="text" label="lblWSSendNumTag" />:&nbsp;</label><select name="cmbWSNumTag" id="cmbWSNumTag"><system:util show="prepareWebServiceSendTags" saveOn="types" /><system:edit show="iteration" from="types" saveOn="type_save"><system:edit show="saveValue" from="type_save" field="type" saveOn="type"/><option value="<system:edit show="value" from="type_save" field="type"/>" <system:edit show="ifValue" from="theEdition" field="busClaWsNumTag" value="with:type" >selected</system:edit>><system:edit show="value" from="type_save" field="typeName"/></option></system:edit></select></div><div class="field fieldOneThird"><label title="<system:label show="tooltip" label="lblWSSendDteTag" />"><system:label show="text" label="lblWSSendDteTag" />:&nbsp;</label><select name="cmbWSDteTag" id="cmbWSDteTag"><system:util show="prepareWebServiceSendTags" saveOn="types" /><system:edit show="iteration" from="types" saveOn="type_save"><system:edit show="saveValue" from="type_save" field="type" saveOn="type"/><option value="<system:edit show="value" from="type_save" field="type"/>" <system:edit show="ifValue" from="theEdition" field="busClaWsDteTag" value="with:type" >selected</system:edit>><system:edit show="value" from="type_save" field="typeName"/></option></system:edit></select></div></div><!-- Comentado: pedido de gferrari
										
										<div class="fieldGroup"><div class="field"><label title="<system:label show="tooltip" label="lblWSAddressing" />" for="lblWSAddressing" class="label"><system:label show="text" label="lblWSAddressing" />:&nbsp;
												<input type="checkbox" name="chkWsAddressing" id="chkWsAddressing" value="true" onclick="changeWsAddressing()"  <system:edit show="ifFlag" from="theEdition" field="4" >checked='checked'</system:edit>></label></div><div class="field"><label title="<system:label show="tooltip" label="lblWsAddTo" />"><system:label show="text" label="lblWsAddTo" />:&nbsp;</label><input type="text" name="txtWsAddTo" id="txtWsAddTo"   value="<system:edit show="value" from="theEdition" field="wsStsVo.wsaddressingTo"/>" <system:edit show="ifNotFlag" from="theEdition" field="4" >disabled='disabled'</system:edit>></div><div class="field"><label title="<system:label show="tooltip" label="lblWsAddAction" />"><system:label show="text" label="lblWsAddAction" />:&nbsp;</label><input type="password" name="txtWsAddAction" id="txtWsAddAction"   value="<system:edit show="value" from="theEdition" field="wsStsVo.wsaddressingAction"/>" <system:edit show="ifNotFlag" from="theEdition" field="4" >disabled='disabled'</system:edit>></div></div><div class="fieldGroup"><div class="field"><label title="<system:label show="tooltip" label="lblWS_STS" />" for="lblWS_STS" class="label"><system:label show="text" label="lblWS_STS" />:&nbsp;
												<input type="checkbox" name="chkWsSTS" id="chkWsSTS" value="true" onclick="changechkWsSTS()"  <system:edit show="ifFlag" from="theEdition" field="5" >checked='checked'</system:edit>></label></div><div class="field"><label title="<system:label show="tooltip" label="lblWsSTSUrl" />"><system:label show="text" label="lblWsSTSUrl" />:&nbsp;</label><input type="text" name="txtWsSTSUrl" id="txtWsSTSUrl" value="<system:edit show="value" from="theEdition" field="wsStsVo.url"/>" <system:edit show="ifNotFlag" from="theEdition" field="5" >disabled='disabled'</system:edit>></div><div class="field"><label title="<system:label show="tooltip" label="lblWsSTSIssuer" />"><system:label show="text" label="lblWsSTSIssuer" />:&nbsp;</label><input type="text" name="txtWsSTSIssuer" id="txtWsSTSIssuer" value="<system:edit show="value" from="theEdition" field="wsStsVo.issuer"/>" <system:edit show="ifNotFlag" from="theEdition" field="5" >disabled='disabled'</system:edit>></div><div class="field"><label title="<system:label show="tooltip" label="lblWsSTSPolicyName" />"><system:label show="text" label="lblWsSTSPolicyName" />:&nbsp;</label><input type="text" name="txtWsSTSPolicy" id="txtWsSTSPolicy" value="<system:edit show="value" from="theEdition" field="wsStsVo.policyname"/>" <system:edit show="ifNotFlag" from="theEdition" field="5" >disabled='disabled'</system:edit>></div><div class="field"><label title="<system:label show="tooltip" label="lblWsSTSRole" />"><system:label show="text" label="lblWsSTSRole" />:&nbsp;</label><input type="text" name="txtWsSTSRole" id="txtWsSTSRole" value="<system:edit show="value" from="theEdition" field="wsStsVo.roleName"/>" <system:edit show="ifNotFlag" from="theEdition" field="5" >disabled='disabled'</system:edit>></div><div class="field"><label title="<system:label show="tooltip" label="lblWsSTSUserName" />"><system:label show="text" label="lblWsSTSUserName" />:&nbsp;</label><input type="text" name="txtWsSTSUserName" id="txtWsSTSUserName" value="<system:edit show="value" from="theEdition" field="wsStsVo.username"/>" <system:edit show="ifNotFlag" from="theEdition" field="5" >disabled='disabled'</system:edit>></div><div class="field"><label title="<system:label show="tooltip" label="lblWsSTSService" />"><system:label show="text" label="lblWsSTSService" />:&nbsp;</label><input type="text" name="txtWsSTSService" id="txtWsSTSService" value="<system:edit show="value" from="theEdition" field="wsStsVo.service"/>" <system:edit show="ifNotFlag" from="theEdition" field="5" >disabled='disabled'</system:edit>></div><div class="field"><label title="<system:label show="tooltip" label="lblWsSTSAlias" />"><system:label show="text" label="lblWsSTSAlias" />:&nbsp;</label><input type="text" name="txtWsSTSAlias" id="txtWsSTSAlias" value="<system:edit show="value" from="theEdition" field="wsStsVo.keystoreAlias"/>" <system:edit show="ifNotFlag" from="theEdition" field="5" >disabled='disabled'</system:edit>></div><div class="field"><label title="<system:label show="tooltip" label="lblWsSTSKeyStorePath" />"><system:label show="text" label="lblWsSTSKeyStorePath" />:&nbsp;</label><input type="text" name="txtWsSTSKSPath" id="txtWsSTSKSPath" value="<system:edit show="value" from="theEdition" field="wsStsVo.keystorePath"/>" <system:edit show="ifNotFlag" from="theEdition" field="5" >disabled='disabled'</system:edit>></div><div class="field"><label title="<system:label show="tooltip" label="lblWsSTSKeyStorePwd" />"><system:label show="text" label="lblWsSTSKeyStorePwd" />:&nbsp;</label><input type="password" name="txtWsSTSKSPwd" id="txtWsSTSKSPwd" value="<system:edit show="value" from="theEdition" field="wsStsVo.keystorePwd"/>" <system:edit show="ifNotFlag" from="theEdition" field="5" >disabled='disabled'</system:edit>></div><div class="field"><label title="<system:label show="tooltip" label="lblWsSTSTrustStorePath" />"><system:label show="text" label="lblWsSTSTrustStorePath" />:&nbsp;</label><input type="text" name="txtWsSTSTSPath" id="txtWsSTSTSPath" value="<system:edit show="value" from="theEdition" field="wsStsVo.truststorePath"/>" <system:edit show="ifNotFlag" from="theEdition" field="5" >disabled='disabled'</system:edit>></div><div class="field"><label title="<system:label show="tooltip" label="lblWsSTSTrustStorePwd" />"><system:label show="text" label="lblWsSTSTrustStorePwd" />:&nbsp;</label><input type="password" name="txtWsSTSTSPwd" id="txtWsSTSTSPwd" value="<system:edit show="value" from="theEdition" field="wsStsVo.truststorePwd"/>" <system:edit show="ifNotFlag" from="theEdition" field="5" >disabled='disabled'</system:edit>></div></div><!-- End WebService SOA --></div><div id="divF" style='display:none' class="feldGroup"><!-- Query filter --><div class="field fieldExtended required"><label title="<system:label show="tooltip" label="lblEje" />"><system:label show="text" label="lblEje" />:&nbsp;</label><input id="txtExeQuery" name="txtExeQuery" type="text"  value="<system:edit show="value" from="theEdition" field="busClaExecutable"/>" /></div><!-- End query filter --></div><div id="divR" style='display:none'><div class="fieldGroup"><!-- Business Rules --><div class="field"><label title="<system:label show="tooltip" label="lblRuleEngine" />"><system:label show="text" label="lblRuleEngine" />:&nbsp;</label><select id="cmbRuleEngine" name="cmbRuleEngine"><option value="<system:edit show="constant" from="com.dogma.vo.BusClassVo" field="RULE_ENGINE_DROOLS" />">DROOLS</option></select></div></div><div class="fieldGroup"><div class="field fieldExtended required"><label title="<system:label show="tooltip" label="lblRulePath" />"><system:label show="text" label="lblRulePath" />:&nbsp;</label><input id="txtRulePath" name="txtRulePath" type="text"   value="<system:edit show="value" from="theEdition" field="busClaRulesRulePath"/>" /></div><div class="field fieldExtended required"><label title="<system:label show="tooltip" label="lblRuleInput" />"><system:label show="text" label="lblRuleInput" />:&nbsp;</label><input id="txtRuleInput" name="txtRuleInput" type="text"  value="<system:edit show="value" from="theEdition" field="busClaRulesInput"/>" /></div><div class="field fieldExtended required"><label title="<system:label show="tooltip" label="lblRuleOutput" />"><system:label show="text" label="lblRuleOutput" />:&nbsp;</label><input id="txtRuleOutput" name="txtRuleOutput" type="text"  value="<system:edit show="value" from="theEdition" field="busClaRulesOutput"/>" /></div></div><!-- End Business Rules --></div><div id="divH" style='display:none'><!-- WebService REST --><div class="fieldGroup"><div class="field fieldTwoFifths required"><label title="<system:label show="tooltip" label="lblUri" />"><system:label show="text" label="lblUri" />:&nbsp;</label><input id="txtUri" name="txtUri" type="text" value="<system:edit show="value" from="theEdition" field="busClaUrl"/>"/></div><div class="field fieldOneFifths" id="divCmbRestMethod"><label title="<system:label show="tooltip" label="lblHttpMet" />"><system:label show="text" label="lblHttpMet" />:&nbsp;</label><div id="divHttpMethods" style="width: 100%"><select name="cmbRestHttpMetTag" id="cmbRestHttpMetTag"><system:util show="prepareHttpMethodsTags" saveOn="types" /><system:edit show="iteration" from="types" saveOn="type_save"><system:edit show="saveValue" from="type_save" field="type" saveOn="type"/><option value="<system:edit show="value" from="type_save" field="type"/>" <system:edit show="ifValue" from="theEdition" field="restHTTPMethod" value="with:type" >selected</system:edit>><system:edit show="value" from="type_save" field="typeName"/></option></system:edit></select></div></div><div class="field fieldOneFifths fieldLast" id="divCmbRestType"><label title="<system:label show="tooltip" label="lblRetType" />"><system:label show="text" label="lblRetType" />:&nbsp;</label><div id="divRestMediaTypes" style="width: 100%"><select name="cmbRestTypeTag" id="cmbRestTypeTag"><system:util show="prepareRestMediaTypeTags" saveOn="types" /><system:edit show="iteration" from="types" saveOn="type_save"><system:edit show="saveValue" from="type_save" field="type" saveOn="type"/><option value="<system:edit show="value" from="type_save" field="type"/>" <system:edit show="ifValue" from="theEdition" field="restMediaType" value="with:type" >selected</system:edit>><system:edit show="value" from="type_save" field="typeName"/></option></system:edit></select></div></div></div><!-- End WebService REST --></div></div></div></div><div class="aTab"><div class="tab" id="tabParam"><system:label show="text" label="tabPar" /></div><div class="contentTab"><%@include file="params.jsp" %></div></div><div class="aTab"><div class="tab"><system:label show="text" label="tabPer" /></div><div class="contentTab"><%@include file="../../generic/permissions.jsp" %></div></div></div><system:campaign inLogin="false" inSplash="false" location="horizontalDown" /></div></form></div><%@include file="../../modals/permissions.jsp" %><%@include file="../../includes/footer.jsp" %></body></html>

