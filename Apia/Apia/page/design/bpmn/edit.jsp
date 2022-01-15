<%@page import="com.dogma.vo.custom.ProDefinitionVo"%>
<%@page import="biz.statum.apia.web.action.design.BPMNProcessAction"%>
<%@page import="biz.statum.apia.web.bean.design.BPMNProcessBean"%>
<%@page import="biz.statum.apia.web.action.BasicAction"%>
<%@page import="biz.statum.sdk.util.HttpServletRequestResponse"%>
<%@page import="com.dogma.vo.ProcessVo"%>
<%@page import="com.st.util.StringUtil"%>
<%@include file="../../includes/startInc.jsp" %>
<html lang="<%=biz.statum.apia.web.bean.BasicBeanStatic.getUserDataStatic(request).getLangCode()%>">
	<head>
		<%@include file="../../includes/headInclude.jsp" %>
		<link href="<system:util show="context" />/css/base/pages/bpmnProcess/main.css" rel="stylesheet" type="text/css" >
		<script type="text/javascript" src="<system:util show="context" />/page/includes/adminActionsEdition.js"></script>
		<script type="text/javascript" src="<system:util show="context" />/page/includes/campaigns.js"></script>
		<script type="text/javascript" src="<system:util show="context" />/page/design/bpmn/edit.js"></script>
		<system:edit show="ifValue" from="theEdition" field="isBpmn" value="1"> 
			<script type="text/javascript" src="<system:util show="context" />/page/design/bpmn/flash.js"></script>
		</system:edit>
		<system:edit show="ifNotValue" from="theEdition" field="isBpmn" value="1"> 
			<script type="text/javascript" src="<system:util show="context" />/page/design/bpmn/flashDesigner.js"></script>
		</system:edit>
		<!-- SCRIPTS TABS -->
		<script type="text/javascript" src="<system:util show="context" />/page/design/bpmn/tabGenData.js"></script>
		<script type="text/javascript" src="<system:util show="context" />/page/design/bpmn/tabAttributes.js"></script>
		<script type="text/javascript" src="<system:util show="context" />/page/design/bpmn/tabMap.js"></script>
		<script type="text/javascript" src="<system:util show="context" />/page/design/bpmn/tabActions.js"></script>
		<script type="text/javascript" src="<system:util show="context" />/page/design/bpmn/tabMonitor.js"></script>
		<script type="text/javascript" src="<system:util show="context" />/page/design/bpmn/tabAnalyticalQueries.js"></script>
		<script type="text/javascript" src="<system:util show="context" />/page/generic/permissions.js"></script>
		<script type="text/javascript" src="<system:util show="context" />/page/generic/docTypePermitted.js"></script>
		<script type="text/javascript" src="<system:util show="context" />/page/generic/documents.js"></script>
		<!-- SCRIPTS MODALS -->
		<script type="text/javascript" src="<system:util show="context" />/page/modals/images.js"></script>
		<script type="text/javascript" src="<system:util show="context" />/page/modals/calendarsView.js"></script>
		<script type="text/javascript" src="<system:util show="context" />/page/modals/pools.js"></script>
		<script type="text/javascript" src="<system:util show="context" />/page/modals/documents.js"></script>
		<script type="text/javascript" src="<system:util show="context" />/page/modals/users.js"></script>
		<script type="text/javascript" src="<system:util show="context" />/page/design/bpmn/msgNotifications.js"></script>
		<script type="text/javascript" src="<system:util show="context" />/page/modals/forms.js"></script>
		<script type="text/javascript" src="<system:util show="context" />/page/modals/profiles.js"></script>
		<script type="text/javascript" src="<system:util show="context" />/page/modals/entities.js"></script>
		<script type="text/javascript" src="<system:util show="context" />/page/modals/documentType.js"></script>
		<!-- SCRIPTS OTROS -->
		<script type="text/javascript" src="<system:util show="context" />/page/includes/navButtons.js"></script>
		<script type="text/javascript" src="<system:util show="context" />/page/includes/adminFav.js"></script>
		<script type="text/javascript" src="<system:util show="context" />/js/autocomplete/autocompleter.js"></script>
		<script type="text/javascript" src="<system:util show="context" />/js/autocomplete/autocompleter.request.js"></script>
		<script type="text/javascript" src="<system:util show="context" />/js/autocomplete/observer.js"></script>
		
		<!-- DRAG AND DROP BEHAVIOUR -->
		<script type="text/javascript" src="<system:util show="context" />/js/dragAndDrop/Form.MultipleFileInput.js"></script>
		<script type="text/javascript" src="<system:util show="context" />/js/dragAndDrop/Form.Upload.js"></script>
		<script type="text/javascript" src="<system:util show="context" />/js/dragAndDrop/Request.File.js"></script>
		
		<!-- FOLDERS -->
		<script type="text/javascript" src="<system:util show="context" />/page/modals/foldersDocuments.js"></script>
		<script type="text/javascript" src="<system:util show="context" />/page/includes/foldersDisplay.js"></script>
				 
		<script language="vbscript">
			<!--     - 
			// Catch FS Commands in IE, and pass them to the corresponding JavaScript function.
			Sub shell_FSCommand(ByVal command, ByVal args)
    		call shell_DoFSCommand(command,args)
			end sub
			//          -->
		</script>
		
		<system:edit show="ifNotValue" from="theEdition" field="isBpmn" value="1">
			<script language="vbscript">
				Sub shellPrint_FSCommand(ByVal command, ByVal args)
    			call shellPrint_DoFSCommand(command, args)
				end sub
			</script>
		</system:edit>
		
		<script type="text/javascript">
		var CONTEXT 	= '<%=Parameters.ROOT_PATH%>';							
			var URL_REQUEST_AJAX 				= '/apia.design.BPMNProcessAction.run';
			var ADDITIONAL_INFO_IN_TABLE_DATA  	= false;
			var MODE_DISABLED 					= toBoolean('<system:edit show="value" from="theBean" field="modeDisabled" />');
			var MODE_READ_ONLY					= toBoolean('<system:edit show="value" from="theBean" field="modeReadOnly" />');
			var MODE_CREATE						= toBoolean('<system:edit show="value" from="theBean" field="modeCreate" />');
			var MODE_DEBUG						= toBoolean('<system:edit show="value" from="theBean" field="modeDebug" />');
			
			var MSG_ERR_PERM					= '<system:label show="text" label="msgPermError" forScript="true" />';
			
			var HAS_PERMISSIONS					= toBoolean('<system:edit show="value" from="theBean" field="hasPermissions" />');
			
			var IS_PRO_BPMN						= toBoolean('<system:edit show="value" from="theEdition" field="isBpmn" />');
			
			var CONFIRM_PRINT					= '<system:label show="text" label="msgProConfPrint" forHtml="true" forScript="true" />';
			
			var MSG_MUST_SEL_ENTITY				= '<system:label show="text" label="msgMstSelEntForPro" forScript="true" />';
			
			var LBL_GENERIC_ERROR				= '<system:label show="text" label="lblError" forScript="true" />';
			
			var LBL_LEAVE_DOCS_HERE 			= '<system:label show="text" label="lblLveDcsHere" forScript="true"/>';
			var APIA_DATE_FORMAT				="<%=StringUtil.escapeScriptStr(EnvParameters.getEnvParameter(envId,EnvParameters.FMT_DATE))%>";
		</script>
		
		<%	
			BPMNProcessBean dBean = (BPMNProcessBean) BPMNProcessAction.staticRetrieveBean(new HttpServletRequestResponse(request, response));
			ProDefinitionVo proVo = dBean.getProcessVo();
		%>
		
	</head> 

	<body>
		<div id="exec-blocker"></div>
		<div class="header"></div>
		<div class="body" id="bodyDiv">
			<form id="frmData">
				<div class="optionsContainer" id="optionsContainer">
					<div class="fncPanel info noMarginBottomSection">
						<system:campaign inLogin="false" inSplash="false" location="verticalUp" />
						<div class="title">
							<system:label show="text" label="mnuPro" />
							<%@include file="../../includes/adminFav.jsp" %>
						</div>
						<div class="hideThisSection">
							<div class="content divFncDescription">
								<div class="fncDescriptionImage" data-src="<system:edit show="value" from="theBean" field="fncImage"/>"></div>
								<div id="fncDescriptionText"><system:label show="text" label="dscFncProBPMN" /></div>
								<div class="clear"></div>
							</div>
						</div>
					</div>			
	
					<div class="hideThisSection">
						<%@include file="../../includes/adminActionsEdition.jsp" %>
						
						<!-- Options TabGenData -->
						<div class="fncPanel buttons" id="panelOptionsTabGenData">
							<div class="title"><system:label show="text" label="mnuOpc" /></div>
							<div class="content">
							  	<div id="btnViewTemp" class="button extendedSize" title="<system:label show="tooltip" label="lblViewTemp" />"><system:label show="text" label="lblViewTemp" /></div>
							  	<div id="btnViewCal" class="button extendedSize" title="<system:label show="tooltip" label="lblViewCal" />" <system:edit show="ifValue" from="theBean" field="existCalendars" value="false">style="display: none;"</system:edit>><system:label show="text" label="lblViewCal" /></div>
							 	<div id="btnResetImg" class="button extendedSize" title="<system:label show="text" label="btnResetImg" />"><system:label show="text" label="btnResetImg" /></div>
							</div>	
						</div>					
						<system:edit show="ifValue" from="theBean" field="modeDebug" value="false">
							<!-- Options TabMap -->
							<div class="fncPanel buttons" id="panelOptionsTabMap" style="display: none;">
								<div class="title"><system:label show="text" label="mnuOpc" /></div>
								<div class="content">
								  	<div id="btnGenDoc" class="button" title="<system:label show="tooltip" label="btnRTF" />"><system:label show="text" label="btnRTF" /></div>						  	
								</div>	
							</div>
							<!-- Options TabAnalyticalQueries -->
							<div class="fncPanel buttons" id="panelOptionsTabAnalyticalQueries" style="display: none;">
								<div class="title"><system:label show="text" label="mnuOpc" /></div>
								<div class="content">
								  	<div id="btnEstimateLoad" class="button extendedSize" title="<system:label show="tooltip" label="btnEstTime" />"><system:label show="text" label="btnEstTime" /></div>
								</div>	
							</div>
						</system:edit>	
						<!-- Datos Generales -->
						<div class="fncPanel buttons" id="panelGenData" style="display:none;">
							<div class="title"><system:label show="text" label="sbtGenData" /></div>
							<div class="content">
								<span class="infoGenData"><b><system:label show="text" label="lblNom" />:&nbsp;</b></span>
								<span id="dataGenProName" class="infoGenData"><system:edit show="value" from="theEdition" field="proName"/></span>
								<br>
								<span class="infoGenData"><b><system:label show="text" label="docTit" />:&nbsp;</b></span>
								<span id="dataGenProTitle" class="infoGenData"><system:edit show="value" from="theEdition" field="proTitle"/></span>
								<br>
								<span class="infoGenData"><b><system:label show="text" label="lblEntAso" />:&nbsp;</b></span>
								<span id="dataGenEntAso" class="infoGenData"><system:edit show="value" from="theEdition" field="entityProcessName"></system:edit></span>
								<br>
								<span class="infoGenData"><b><system:label show="text" label="lblAccPro" />:&nbsp;</b></span>
								<span id="dataGenProAcc" class="infoGenData"><system:edit show="value" from="theEdition" field="proActionName"/></span>
							</div>	
						</div>
						
						<system:campaign inLogin="false" inSplash="false" location="verticalDown" />
					</div>
				</div>	
				
				<div class="dataContainer" style="height: 100%">
					<div class='tabComponent' id="tabComponent">
						<div class="aTabHeader"><system:campaign inLogin="false" inSplash="false" location="horizontalUp" /></div>
						<%@include file="tabGenData.jsp" %>
						<system:edit show="ifValue" from="theBean" field="modeDebug" value="false">
							<%@include file="tabAttributes.jsp" %>
						</system:edit>																		
						<%@include file="tabMap.jsp" %>																	
						<system:edit show="ifValue" from="theBean" field="modeDebug" value="false">
							<%@include file="tabActions.jsp" %>
							<div class="aTab">
								<div class="tab"><system:label show="text" label="tabDocuments" /></div>
								<div class="contentTab">
									<div class="fieldGroup">
										<div class="title"><system:label show="text" label="sbtDoc" /></div>
									</div>
									<%@include file="../../generic/documents.jsp" %>
									<%@include file="../../generic/docTypePermitted.jsp" %>
									
									<!-- checks to enable/disable documents monitors -->
									<div class="clear"></div>
									<div class="fieldGroup" id="docTypePermittedContent">
										<div class="title"><system:label show="text" label="titDocMdlLookExec" /></div>
<!-- 											<div class="field fieldOneThird"> -->
<%-- 												<label title="<system:label show="tooltip" label="lblAllDocsInSys" />" class="label"><system:label show="text" label="lblAllDocsInSys" />:&nbsp;</label> --%>
<!-- 												<input type="checkbox" id="chckMonDoc" name="chckMonDoc" <system:edit show="ifFlag" from="theEdition" field="18" >checked='checked'</system:edit> onchange="checkMonitorList(this)"> -->
<!-- 											</div> -->
											
											
											
											
											
											<div class="field fieldOneThird" id="hideMeta">
										<label title="<system:label show="tooltip" label="lblHideMeta" />" class="label"><system:label show="text" label="lblHideMeta" />:&nbsp;</label>
										<input type="checkbox" id="chckShowMeta" name="chckShowMeta" <system:edit show="ifFlag" from="theEdition" field="20" >checked='checked'</system:edit>>
									</div>
									
									<div class="field fieldOneThird" id="hidePerms">
										<label title="<system:label show="tooltip" label="lblHidePerms" />" class="label"><system:label show="text" label="lblHidePerms" />:&nbsp;</label>
										<input type="checkbox" id="chckShowPerm" name="chckShowPerm" <system:edit show="ifFlag" from="theEdition" field="19" >checked='checked'</system:edit>>
									</div>
									
									<br>
									
									<div class="field fieldOneThird" id="collapsePerms">
										<label title="<system:label show="tooltip" label="lblShwColPerm" />" class="label"><system:label show="text" label="lblShwColPerm" />:&nbsp;</label>
										<input type="checkbox" id="chckShowColPerm" name="chckShowColPerm" <system:edit show="ifFlag" from="theEdition" field="23" >checked='checked'</system:edit>>
									</div>
									
									<div class="field fieldOneThird" id="collapseFldStrc">
										<label title="<system:label show="tooltip" label="lblShwColFldStrc" />" class="label"><system:label show="text" label="lblShwColFldStrc" />:&nbsp;</label>
										<input type="checkbox" id="chckShowColFldStrc" name="chckShowColFldStrc" <system:edit show="ifFlag" from="theEdition" field="24" >checked='checked'</system:edit>>
									</div>
									
									<div class="field fieldOneThird" id="collapseMeta">
										<label title="<system:label show="tooltip" label="lblShwColMeta" />" class="label"><system:label show="text" label="lblShwColMeta" />:&nbsp;</label>
										<input type="checkbox" id="chckShowColMeta" name="chckShowColMeta" <system:edit show="ifFlag" from="theEdition" field="25" >checked='checked'</system:edit>>
									</div>
									
									<br>									
									
									<div class="field fieldOneThird" id="allowSelDocMonDoc">
										<label title="<system:label show="tooltip" label="lblAllSelDcMonDoc" />" class="label"><system:label show="text" label="lblAllSelDcMonDoc" />:&nbsp;</label>
										<system:util show="prepareComboYesNoGenEnv" saveOn="optionsCombo"></system:util>
										<select id="showMonDoc" name="showMonDoc" onchange="checkMonitorList();">
											<system:edit show="iteration" from="optionsCombo" saveOn="option">
												<system:edit show="saveValue" from="theBean" field="flagStringUseMonDoc" saveOn="optionId"></system:edit>	<!-- VER LOS DEMAS ATRIBUTOS -->
												<option value='<system:edit show="value" from="option" field="value"/>' <system:edit show="ifValue" from="option" field="value" value="with:optionId">selected</system:edit> ><system:edit show="value" from="option" field="text"/></option>
											</system:edit>
										</select>
									</div>
									
									<div class="field fieldOneThird <system:edit show="ifNotFlag" from="theEdition" field="18">hidden</system:edit>" id="cusMonSelect">
										<label title="<system:label show="tooltip" label="lblSelDocMon" />" class="label"><system:label show="text" label="lblSelDocMon" />:&nbsp;</label>
										<system:util show="prepareCustomDocumentMonitors" saveOn="cusDocsMons"></system:util>
										<select id="cusMonSelect" name="cusMonSelect">
											<system:edit show="iteration" from="cusDocsMons" saveOn="monitor">
												<system:edit show="saveValue" from="monitor" field="monDocId" saveOn="monDocId"></system:edit>
												<option value='<system:edit show="value" from="monitor" field="monDocId"/>' <system:edit show="ifValue" from="theEdition" field="cusDocMonId" value="with:monDocId">selected</system:edit> ><system:edit show="value" from="monitor" value="monDocName"/></option>
											</system:edit>
										</select>
									</div>
									
									<br>
									
									<div class="field fieldOneThird" id="allowBttnFldrs">
										<label title="<system:label show="tooltip" label="lblAllSelDcFld" />" class="label"><system:label show="text" label="lblAllSelDcFld" />:&nbsp;</label>
										<system:util show="prepareComboYesNoGenEnv" saveOn="optionsCombo"></system:util>
										<select id="showFldBttn" name="showFldBttn">
											<system:edit show="iteration" from="optionsCombo" saveOn="option">
												<system:edit show="saveValue" from="theBean" field="flagStringFldBttn" saveOn="optionId"></system:edit>	<!-- VER LOS DEMAS ATRIBUTOS -->
												<option value='<system:edit show="value" from="option" field="value"/>' <system:edit show="ifValue" from="option" field="value" value="with:optionId">selected</system:edit> ><system:edit show="value" from="option" field="text"/></option>
											</system:edit>
										</select>
									</div>
									
									<div class="field fieldOneThird" id="allowFldrsStr">
										<label title="<system:label show="tooltip" label="lblAllShwFldStr" />" class="label"><system:label show="text" label="lblAllShwFldStr" />:&nbsp;</label>
										<system:util show="prepareComboYesNoGenEnv" saveOn="optionsCombo"></system:util>
										<select id="showFldStrc" name="showFldStrc">
											<system:edit show="iteration" from="optionsCombo" saveOn="option">
												<system:edit show="saveValue" from="theBean" field="flagStringFldStrc" saveOn="optionId"></system:edit>	<!-- VER LOS DEMAS ATRIBUTOS -->
												<option value='<system:edit show="value" from="option" field="value"/>' <system:edit show="ifValue" from="option" field="value" value="with:optionId">selected</system:edit> ><system:edit show="value" from="option" field="text"/></option>
											</system:edit>
										</select>
									</div>
											
									</div>
									<div class="clear"></div>
								</div>
							</div>	
							<%@include file="tabMonitor.jsp" %>																	
							<div class="aTab">
								<div class="tab"><system:label show="text" label="tabClaPer" /></div>
								<div class="contentTab">
									<%@include file="../../generic/permissions.jsp" %>
								</div>
							</div>
							<%@include file="tabAnalyticalQueries.jsp" %>																	
						</system:edit>
					</div>
										
					<system:campaign inLogin="false" inSplash="false" location="horizontalDown" />	
				</div>			
			</form>
			<div style="display:none" id="divDragDropForm"></div>
		</div>
		
		<!-- MODALS -->
		<%@include file="../../modals/permissions.jsp" %>
		<%@include file="../../modals/images.jsp" %>
		<%@include file="../../modals/calendarsView.jsp" %>
		<%@include file="../../modals/documents.jsp" %>
		<%@include file="../../modals/forms.jsp" %>
		<%@include file="../../modals/pools.jsp" %>
		<%@include file="../../modals/profiles.jsp" %>
		<%@include file="../../modals/entities.jsp" %>
		<%@include file="../../modals/documentType.jsp" %>
		<%@include file="msgNotifications.jsp" %>
		<%@include file="../../includes/footer.jsp" %>
		
		<iframe id="ifrmDow" name="ifrmDow" style="position:absolute;WIDTH:0px;HEIGHT:0px;top:0px;left:0px;display:none;" src=""></iframe>
		
	</body>
</html>
