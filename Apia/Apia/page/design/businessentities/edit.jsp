<%@page import="com.dogma.util.DogmaUtil"%>
<%@page import="biz.statum.apia.web.bean.design.BusEntitiesBean"%>
<%@page import="biz.statum.apia.web.action.design.BusinessEntitiesAction"%>
<%@page import="com.st.util.labels.LabelManager"%>
<%@page import="biz.statum.apia.web.action.BasicAction"%>
<%@page import="biz.statum.sdk.util.HttpServletRequestResponse"%>
<%@page import="com.dogma.vo.BusClassVo"%>
<%@include file="../../includes/startInc.jsp" %>
<html lang="<%=biz.statum.apia.web.bean.BasicBeanStatic.getUserDataStatic(request).getLangCode()%>">
<head>
	<%@include file="../../includes/headInclude.jsp" %>
	<script type="text/javascript" src="<system:util show="context" />/page/design/businessentities/edit.js"></script>	
	<script type="text/javascript" src="<system:util show="context" />/page/includes/navButtons.js"></script>
	<script type="text/javascript" src="<system:util show="context" />/page/includes/adminActionsEdition.js"></script>
	<script type="text/javascript" src="<system:util show="context" />/page/modals/images.js"></script>
	<script type="text/javascript" src="<system:util show="context" />/page/modals/status.js"></script>
	<script type="text/javascript" src="<system:util show="context" />/page/modals/pools.js"></script>
	<script type="text/javascript" src="<system:util show="context" />/page/generic/permissions.js"></script>
	<script type="text/javascript" src="<system:util show="context" />/page/generic/docTypePermitted.js"></script>
	<script type="text/javascript" src="<system:util show="context" />/page/modals/processes.js"></script>
	<script type="text/javascript" src="<system:util show="context" />/page/modals/documentType.js"></script>
	<script type="text/javascript" src="<system:util show="context" />/page/modals/forms.js"></script>
	<script type="text/javascript" src="<system:util show="context" />/page/modals/documents.js"></script>
	<script type="text/javascript" src="<system:util show="context" />/page/generic/documents.js"></script>
	<script type="text/javascript" src="<system:util show="context" />/page/modals/users.js"></script>
	<script type="text/javascript" src='<system:util show="context" />/page/design/businessentities/dimensions.js'></script>
	<script type="text/javascript" src='<system:util show="context" />/page/design/businessentities/measures.js'></script>
	<script type="text/javascript" src="<system:util show="context" />/page/modals/profiles.js"></script>
	<script type="text/javascript" src="<system:util show="context" />/page/includes/campaigns.js"></script>
	<script type="text/javascript" src="<system:util show="context" />/page/design/businessentities/tabEvents.js"></script>
	
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
	
	<link href="<system:util show="context" />/page/design/forms/formsDesigner/designer.css" rel="stylesheet" type="text/css" >
	 
	<script language="vbscript">
<!--     - 
// Catch FS Commands in IE, and pass them to the corresponding JavaScript function.
Sub shell_FSCommand(ByVal command, ByVal args)
    call shell_DoFSCommand(command,args)
end sub
//          -->
	</script>
	<script type="text/javascript">
		var URL_REQUEST_AJAX = '/apia.design.BusinessEntitiesAction.run';
		var ADDITIONAL_INFO_IN_TABLE_DATA  = false;
 		var GNR_PER_DAT_ING = '<system:label show="text" label="msgPerDatIng" forScript="true" />';
		var MSG_USE_PROY_PERMS = '<system:label show="text" label="msgUseProyPerms" forScript="true" />';
		var ADMIN_PROCESS = '<system:edit show="constant" from="com.dogma.vo.BusEntityVo" field="ADMIN_PROCESS" />';
		var ADMIN_FUNCT = '<system:edit show="constant" from="com.dogma.vo.BusEntityVo" field="ADMIN_FUNCT" />';
		var USRCREATION_FORM_ID = '<system:edit show="constant" from="com.dogma.vo.FormVo" field="USRCREATION_FORM_ID" />';
		var USRCREATION_FORM_NAME = '<system:edit show="constant" from="com.dogma.vo.FormVo" field="USRCREATION_FORM_NAME" />';
		var MSG_FOR_NO_BOR = '<system:label show="text" label="msgForNoBorr" forScript="true" />';
		var MSG_USED_FORMS = '<system:label show="text" label="msgEntUsedForms" forScript="true" />';
		var LBL_SHOW_FOR = '<system:label show="text" label="lblShowFor" forScript="true" />';
		var MSG_DELETE_CUBE_CONFIRM = '<system:label show="text" label="msgDelCbeConfirm" forScript="true" />';
		var MSG_CBE_IN_USE_BY_CUBE = '<system:label show="text" label="msgCbeInUseByCube" forScript="true" />';
		var MSG_CBE_IN_USE_BY_WIDGET = '<system:label show="text" label="msgCbeInUseByWidget" forScript="true" />';
		var ENTITY_ID_LABEL = '<system:label show="text" label="lblEjeIdeEnt" forScript="true" />';
		var ENTITY_STATUS_LABEL = '<system:label show="text" label="lblEjeStaEnt" forScript="true" />';
		var ENTITY_CREATOR_LABEL = '<system:label show="text" label="lblEjeUsuCreEnt" forScript="true" />';
		var ENTITY_CRE_DATE_LABEL = '<system:label show="text" label="lblEjeFecCreEnt" forScript="true" />';
		var MAP_ENTITY = '<system:label show="text" label="lblMapEntity" forScript="true" />';
		var LBL_SEL_MAP_ENTITY = '<system:label show="text" label="lblCliSelMapEntity" forScript="true" />';		
		var LBL_YEAR = '<system:label show="text" label="lblYear" forScript="true" />';
		var LBL_SEMESTER = '<system:label show="text" label="lblSemester" forScript="true" />';
		var LBL_TRIMESTER = '<system:label show="text" label="lblTrimester" forScript="true" />';
		var LBL_MONTH = '<system:label show="text" label="lblMonth" forScript="true" />';
		var LBL_WEEKDAY = '<system:label show="text" label="lblWeekDay" forScript="true" />';
		var LBL_DAY = '<system:label show="text" label="lblBIDay" forScript="true" />';
		var LBL_HOUR = '<system:label show="text" label="lblBIHour" forScript="true" />';
		var LBL_MINUTE = '<system:label show="text" label="lblMinute" forScript="true" />';
		var LBL_SECOND = '<system:label show="text" label="lblSecond" forScript="true" />';
		var LBL_DEL_MAP_ENTITY = '<system:label show="text" label="lblDelMapEntity" forScript="true" />';
		var HAS_CUBE = '<system:edit show="value" from="theBean" field="hasCube"  />';
		var IMG_MODIFY = CONTEXT+"/css/base/img/modify2.gif";
		var IMG_ERASER = CONTEXT+"/css/base/img/eraser.gif"
		var OK = '<system:edit show="value" from="theBean" field="biMessage" />'; 
		var MSG_CBE_NAME_MISS = '<system:label show="text" label="msgCbeNameMiss" forScript="true" />';
		var MSG_MUST_ENT_CBE_NAME = '<system:label show="text" label="msgMustEntCbeName" forScript="true" />';
		var MSG_CUBE_NAME_ALREADY_EXIST = '<system:label show="text" label="msgCubExi" forScript="true" />';
		var MSG_MUST_ENT_ONE_DIM = '<system:label show="text" label="msgMustEntOneDimension" forScript="true" />';
		var MSG_DIM_NAME_UNIQUE = '<system:label show="text" label="msgDimNameUnique" forScript="true" />';
		var MSG_MIS_DIM_ATT = '<system:label show="text" label="msgMisDimAttribute" forScript="true"  />';
		var MSG_WRG_DIM_NAME = '<system:label show="text" label="msgWrgDimName" forScript="true" />';
		var MSG_MUST_ENT_ONE_MEAS = '<system:label show="text" label="msgMustEntOneMeasure" forScript="true" />';
		var MSG_MEASURE_NAME_UNIQUE = '<system:label show="text" label="msgMeasureNameUnique" forScript="true" />';
		var MSG_WRG_MEA_NAME = '<system:label show="text" label="msgWrgMeaName" forScript="true" />';
		var MSG_MIS_MEA_ATT = '<system:label show="text" label="msgMisMeaAttribute" forScript="true" />';
		var MSG_ATLEAST_ONE_MEAS_VISIBLE = '<system:label show="text" label="msgAtLeastOneMeasVisible" forScript="true" />';
		var MSG_PRF_NO_ACC_DELETED = '<system:label show="text" label="msgPrfNoAccDeleted" forScript="true" />';
		var MSG_PRFS_NO_ACC_DELETED = '<system:label show="text" label="msgPrfsNoAccDeleted" forScript="true" />';
		var MSG_CUBE_NAME_INVALID = '<system:label show="text" label="msgCbeNamInv" forScript="true" />';
		var MSG_MUST_ENTER_FORMULA = '<system:label show="text" label="msgMustEntFormula" forScript="true" />';
		var MSG_MEAS_OP1_NAME_INVALID = '<system:label show="text" label="msgMeasOp1NameInvalid" forScript="true" />';
		var MSG_MEAS_OP2_NAME_INVALID = '<system:label show="text" label="msgMeasOp2NameInvalid" forScript="true" />';
		var MSG_OP_INVALID = '<system:label show="text" label="msgOpInvalid" forScript="true" />';
		var MSG_MEAS_NAME_LOOP_INVALID = '<system:label show="text" label="msgMeasNameLoopInvalid" forScript="true" />';
		var MSG_MUST_ENT_TWO_DIMS = '<system:label show="text" label="msgMustEntTwoDimensions" forScript="true" />';
		var MSG_PERM_WILL_BE_LOST = '<system:label show="text" label="msgPermDefWillBeLost" forScript="true" />';
		var IS_CUSTOM_TEMPLATE = toBoolean('<system:edit show="value" from="theBean" field="customTemplate" />');
		var MSG_ERR_LENGTH = '<system:label show="text" label="msgMaxPer" forScript="true" />';
		var MSG_VW_WILL_BE_ERASED = '<system:label show="text" label="msgVwWillBeDeleted" forScript="true" />';
		var hasCubeBefore = '<system:edit show="value" from="theEdition" field="cubeId"/>'; 
		var CODER_ATT_NAME = "A_CODIGUERA_VALUE";
		var CODER_ATT_ID = 13;
		var CODER_FRM_NAME = "CARGA_AUTOMATICA";
		var CODER_FRM_ID = 2;
		
		var TREE_ATT_NAME = "A_TREE_NODE_PARENT";
		var TREE_ATT_ID = 15;
		var TREE_FRM_NAME = "TREE_NODE_DEFINITION";
		var TREE_FRM_ID = 5;
		
		var LOGIN_ATT_NAME = '<system:edit show="constant" from="com.dogma.vo.AttributeVo" field="LOGIN_ATT_NAME" />';
		var LOGIN_ATT_ID = '<system:edit show="constant" from="com.dogma.vo.AttributeVo" field="LOGIN_ATT_ID" />';
		
		var POOL_DEFAULT_IMAGE = "<system:edit show="constant" from="com.dogma.vo.ImagesVo" field="DEFAULT_IMG_ENT" />";
		var PATH_IMG				= '<system:edit show="value" from="theBean" field="imgPath" />';
		
		var ENT_TEMPLATE_PAGE		= '<system:util show="context"/>/page/design/businessentities/entTemplates.jsp';
		var MSG_ADD_TEMPLATE		= '<system:label show="text" label="msgAddTemplate" forScript="true" />';
		
		var SHOW_TYPE_FUNCIONALITY 	= toBoolean('<system:edit show="value" from="theBean" field="showTypeFuncionality" />');
		
		var LBL_ATT_UC	= '<system:label show="tooltip" label="lblAttUC" forHtml="true" />';
		
		var TIT_WARNING 			= '<system:label show="text" label="titWarning" forScript="true" />';
		var BPMN_DEL_WARNING		= '<system:label show="text" label="msgBpmnDelete" forScript="true" />';
		
		var ONLY_VIEW	= toBoolean('<system:edit show="value" from="theBean" field="onlyView" />');
		
		var CONDITION_MODAL	= '<system:util show="context"/>/page/design/forms/formsDesigner/modals/busClaCondModal.jsp';
		var PARAMS_MODAL	= '<system:util show="context"/>/page/design/businessentities/modals/busClaParamModal.jsp';
		
		var TIME_FORMAT	= "<%=DogmaUtil.getHTMLTimeMask()%>";
		
		var LBL_CLOSE = '<system:label show="text" label="lblCloseWindow" forScript="true" />';
		var LBL_YES	 = '<system:label show="text" label="lblYes" forScript="true" />';
		var LBL_NO	 = '<system:label show="text" label="lblNo" forScript="true" />';
		var LBL_UP 	 = '<system:label show="text" label="btnUp" forScript="true" />';
		var LBL_DOWN = '<system:label show="text" label="btnDown" forScript="true" />';
		var LBL_ADD	 = '<system:label show="text" label="btnAgr" forScript="true" />';
		var LBL_DEL	 = '<system:label show="text" label="btnDel" forScript="true" />';
		var LBL_LEAVE_DOCS_HERE = '<system:label show="text" label="lblLveDcsHere" forScript="true"/>';
		
		var MSG_EXISTS_STATE = '<system:label show="text" label="msgStaExi" forScript="true" />';
		
	</script>
	<style type="text/css">
		.modalOptionsContainer .option input[type=text] {
			margin-top: 1px;
		}
	</style>
</head> 

<body>
	<div id="exec-blocker"></div>
	<div class="body" id="bodyDiv">
		<form id="frmData">
			<div class="optionsContainer">
				<div class="fncPanel info">
					<system:campaign inLogin="false" inSplash="false" location="verticalUp" />
					<div class="title">
						<system:label show="text" label="mnuEnt" />
					</div>
					<div class="content divFncDescription">
						<div class="fncDescriptionImage" data-src="<system:edit show="value" from="theBean" field="fncImage"/>"></div>
						<div id="fncDescriptionText"><system:label show="text" label="dscFncAdmEnt" /></div>
						<div class="clear"></div>
					</div>
				</div>			

				<div id="divAdminActEdit" class="fncPanel buttons">
					<div class="title"><system:label show="text" label="titActions"/></div>
					<div class="content">
						<system:edit show="ifValue" from="theBean" field="onlyView" value="false">
							<div id="btnConfi" class="button suggestedAction" title="<system:label show="tooltip" label="btnCon" />"><system:label show="text" label="btnCon" /></div>
						</system:edit>
						<div id="btnBackToList" class="button" title="<system:label show="tooltip" label="btnVol" />"><system:label show="text" label="btnVol" /></div>
					</div>
				</div>
				
				<div class="fncPanel options" id="panelOptions">
					<div class="title"><system:label show="text" label="mnuOpc" /></div>
					<div class="content">
						<div id="btnResetImage" class="button extendedSize" title="<system:label show="tooltip" label="btnResetImg" />"><system:label show="text" label="btnResetImg" /></div>
						<div id="btnView" class="button extendedSize" <system:label show="tooltip" label="btnViewTmpl" />><system:label show="text" label="btnViewTmpl" /></div>
						<div id="btnEstTime" class="button extendedSize" style='display:none' <system:label show="tooltip" label="btnEstTime" />><system:label show="text" label="btnEstTime" /></div>
						<div class="clear"></div>
					</div>
					<div class="clear"></div>
				</div>
				<system:campaign inLogin="false" inSplash="false" location="verticalDown" />
			</div>	
			
			<div class="dataContainer">
				<div class='tabComponent' id="tabComponent">
					<div class="aTabHeader"><system:campaign inLogin="false" inSplash="false" location="horizontalUp" /></div>
					<div class="aTab">
						<div class="tab" id="generalTab"><system:label show="text" label="tabDatEntNeg" /></div>
						<div class="contentTab">							
							<div class="fieldGroup">
								<div class="title"><system:label show="text" label="tabDatEntNeg" /></div>
								
								<div class="field fieldTwoFifths required">
									<label title="<system:label show="tooltip" label="lblNom" />"><system:label show="text" label="lblNom" />:&nbsp;</label>
									<input type="text" name="txtName" id="txtName"  maxlength="50" class="validate['required','~validName']" value="<system:edit show="value" from="theEdition" field="busEntName"/>">
								</div>
								
								<div class="field fieldTwoFifths required">
									<label title="<system:label show="tooltip" label="lblTit" />"><system:label show="text" label="lblTit" />:&nbsp;</label>
									<input type="text" name="txtTitle" id="txtTitle" maxlength="255"  class="validate['required']" value="<system:edit show="value" from="theEdition" field="busEntTitle"/>">
								</div>
								
								<div class="field fieldOneFifths fieldLast">
									<label title="<system:label show="tooltip" label="titPrj" />"><system:label show="text" label="titPrj" />:&nbsp;</label>
									<select name="selPrj" id="cmbProject"  onchange='cmbPrjChange(this)' >
										<system:util show="prepareProjects" saveOn="projects" />
										<system:edit show="iteration" from="projects" saveOn="project">
											<system:edit show="saveValue" from="project" field="prjId" saveOn="prjId"/>
											<option value="<system:edit show="value" from="project" field="prjId"/>" data-prefix="<system:edit show="value" from="project" field="prjPrefix"/>" <system:edit show="ifValue" from="theEdition" field="prjId" value="with:prjId">selected</system:edit>><system:edit show="value" from="project" field="prjTitle"/></option>
										</system:edit>				   										   					
				   					</select>
								</div>
								
								<div class="field fieldFull">
									<label title="<system:label show="tooltip" label="lblDes" />"><system:label show="text" label="lblDes" />:&nbsp;</label>
									<textarea name="txtDesc" id="txtDesc" maxlength="255" cols=80 rows=3><system:edit show="value" from="theEdition" field="busEntDesc"/></textarea>
								</div>
							
								<br/>
								<br/>
							
								<div class="field fieldOneThird required">
									<label title="<system:label show="tooltip" label="lblTipAdmEnt" />"><system:label show="text" label="lblTipAdmEnt" />:&nbsp;</label>
									<select name="cmbType" id="cmbType" class="validate['required']" onchange="showMoreOptions(this.value)">										
										<system:util show="prepareTypeAdmEntities" saveOn="types" />
										<system:edit show="iteration" from="types" saveOn="type_save">
										<system:edit show="saveValue" from="type_save" field="type" saveOn="type"/>
											<option value="<system:edit show="value" from="type_save" field="type"/>" <system:edit show="ifValue" from="theEdition" field="busEntAdminType" value="with:type">selected</system:edit>><system:edit show="value" from="type_save" field="typeName"/></option>
										</system:edit>	
				   					</select>
								</div>
								
								<div class="field fieldOneThird">
									<label title="<system:label show="tooltip" label="lblTem" />" class="label"><system:label show="text" label="lblTem" />:&nbsp;</label>
									<select name="txtTemplate" id="txtTemplate">
										<system:util show="showPrepareEntTemplates" saveOn="templates" />
										<system:edit show="iteration" from="templates" saveOn="template">
											<system:edit show="saveValue" from="template" field="name" saveOn="name"/>
											<option value="<system:edit show="value" from="template" field="name"/>" <system:edit show="ifValue" from="theEdition" field="busEntExeTemplate" value="with:name">selected</system:edit>><system:edit show="value" from="template" field="location"/></option>
										</system:edit>	
										<option value="<CUSTOM>"><system:label show="text" label="lblTemCustom" /></option>
			   						</select>
								</div>		
								<div class="field fieldOneThird" id="divCustomTemplate" style='display:none'>
									<div>&nbsp;</div>
									<input type="text" id="customTemplate" name="txtCusTemplate"  <system:edit show="ifValue" from="theBean" field="customTemplate" value="false" >disabled</system:edit> value="<system:edit show="ifValue" from="theBean" field="customTemplate" value="true"><system:edit show="value" from="theEdition" field="busEntExeTemplate"/></system:edit>" />
								</div>
								
								<br/>
								
								<div class="field fieldOneThird">
									<label title="<system:label show="tooltip" label="lblAllowUpdEnt" />"><system:label show="text" label="lblAllowUpdEnt" />:&nbsp;</label>										
									<select id="cmbAllowUpd" name="cmbAllowUpd">
										<system:util show="showPrepareModifInstance" saveOn="options" />
										<system:edit show="iteration" from="options" saveOn="options_save">
											<system:edit show="saveValue" from="options_save" field="value" saveOn="value"/>
											<option value="<system:edit show="value" from="options_save" field="value"/>" <system:edit show="ifValue" from="theEdition" field="busEntAllowUpdInst" value="with:value">selected</system:edit>><system:edit show="value" from="options_save" field="name"/></option>
										</system:edit>				   										   					
									</select>
								</div>
							
								<div class="field fieldOneThird">
									<label title="<system:label show="tooltip" label="lblGenMonEntFnc" />" class="label"><system:label show="text" label="lblGenMonEntFnc" />:&nbsp;</label>
									<input type="checkbox" id="chkGenMonEntFnc" name="chkGenMonEntFnc" <system:edit show="ifFlag" from="theEdition" field="5" >checked='checked'</system:edit>>
								</div>	
							
								<div class="field fieldOneThird">
									<label title="<system:label show="tooltip" label="lblAllowInit" />" class="label"><system:label show="text" label="lblAllowInit" />:&nbsp;</label>
									<input type="checkbox" id="chkInit" name="chkInit" <system:edit show="ifFlag" from="theEdition" field="4" >checked='checked'</system:edit> >
								</div>
								
								<div id="moreEntOptions">
									<div class="field fieldOneThird">
										<label title="<system:label show="tooltip" label="lblDntCrInst" />" class="label"><system:label show="text" label="lblDntCrInst" />:&nbsp;</label>
										<input type="checkbox" id="chckInst" name="chckInst" <system:edit show="ifFlag" from="theEdition" field="9" >checked='checked'</system:edit> >
									</div>	
									
									<div class="field fieldOneThird">
										<label title="<system:label show="tooltip" label="lblDntEditInst" />" class="label"><system:label show="text" label="lblDntEditInst" />:&nbsp;</label>
										<input type="checkbox" id="chckInstAlt" name="chckInstAlt" <system:edit show="ifFlag" from="theEdition" field="10" >checked='checked'</system:edit> >
									</div>
									
									<div class="field fieldOneThird">
										<label title="<system:label show="tooltip" label="lblDntDelInst" />" class="label"><system:label show="text" label="lblDntDelInst" />:&nbsp;</label>
										<input type="checkbox" id="chckInstDel" name="chckInstDel" <system:edit show="ifFlag" from="theEdition" field="11" >checked='checked'</system:edit> >
									</div>
									
								</div>
								<!--div class="hrDiv"></div-->
							</div>
							
							<%
							BusEntitiesBean eBean = (BusEntitiesBean) BusinessEntitiesAction.staticRetrieveBean(new HttpServletRequestResponse(request, response));
							%>
							
							<div class="fieldGroup">
								<div class="field fieldOneThird">
									<label title="<system:label show="tooltip" label="lblEmbedSignature" />" class="label"><system:label show="text" label="lblEmbedSignature" />:&nbsp;</label>
									<select name="flagEmbedSignature" id="flagEmbedSignature">
										<option value="" <%=eBean.getBusinessEntityVo().getFlagValue(7) ? "" : "selected"%>></option>
										<option value="1" <%=eBean.getBusinessEntityVo().getFlagValue(7) && eBean.getBusinessEntityVo().getFlagValue(8) ? "selected" : ""%>><system:label show="text" label="lblYes" /></option>
										<option value="2" <%=eBean.getBusinessEntityVo().getFlagValue(7) && !eBean.getBusinessEntityVo().getFlagValue(8) ? "selected" : ""%>><system:label show="text" label="lblNo" /></option>
									</select>	
								</div>
								
								<div class="field fieldOneThird">
									<label title="<system:label show="tooltip" label="lblUseCache" />" class="label"><system:label show="text" label="lblUseCache" />:&nbsp;</label>
									<select name="cmbUseCache" id="cmbUseCache">
										<option value="0" <%=eBean.getBusinessEntityVo().getBusEntCache()==null ? "selected" : ""%>  ><system:label show="text" label="lblNo" /></option>
										<option value="1" <%=eBean.getBusinessEntityVo().getBusEntCache()!=null ? "selected" : ""%>><system:label show="text" label="lblYes" /></option>
									</select>
								</div>
								
								<div class="field fieldOneThird">
									<label title="<system:label show="tooltip" label="lblCacheTime" />" class="label"><system:label show="text" label="lblCacheTime" />:&nbsp;</label>
									<input name="txtBusEntCache" id="txtBusEntCache" class="validate['digit','~checkLen99999']" maxlength="5" value="<%=eBean.getBusinessEntityVo().getBusEntCache()==null?"":eBean.getBusinessEntityVo().getBusEntCache()%>">
								</div>
							</div>
							
							<div class="fieldGroup splitOneThirdImg">							
								<div class="field" >
									<label title="<system:label show="tooltip" label="prpImg" />" class="label"><system:label show="text" label="prpImg" />:&nbsp;</label>
								</div>
								<div class="field fieldImg">										
									<div class="imagePicker" style="background-image:url(<system:edit show="value" from="theBean" field="imgFullPath" />)" id="changeImg">
										<input type="hidden" name="txtProjImg" id="txtProjImg" value="<system:edit show="value" from="theEdition" field="imgPath" />" >
									</div>
								</div>
							</div>
							
							<div class="fieldGroup splitTwoThird">
								
									<div class="field fieldFull" >
										<label title="<system:label show="tooltip" label="lblExternalUrlAccess" />" class="label"><system:label show="text" label="lblExternalUrlAccess" />:&nbsp;</label>
										<system:edit show="ifValue" from="theBean" field="modeCreate" value="false">
											<br><span><system:edit show="value" from="theBean" field="generateBusEntityUrl" /></span>
										</system:edit>										
									</div>
								
								<div class="field" >
									<label title="<system:label show="tooltip" label="lblBusEntDashboard" />" class="label"><system:label show="text" label="lblBusEntDashboard" />:&nbsp;</label>
									<br>
									<select name="dsh" id="dsh">
										<option value=""></option>
										<system:util show="showDashboards" saveOn="dashboards" />
										<system:edit show="iteration" from="dashboards" saveOn="dashboard">
											<system:edit show="saveValue" from="dashboard" field="dashboardId" saveOn="dashboardId"/>
											<option value="<system:edit show="value" from="dashboard" field="dashboardId"/>" <system:edit show="ifValue" from="theEdition" field="dshId" value="with:dashboardId">selected</system:edit>><system:edit show="value" from="dashboard" field="dashboardName"/></option>
										</system:edit>
									</select>
								</div>
							</div>
								
							<div class="clear"></div><br>
							<div class="fieldGroup">	
								<div class="title"><system:label show="text" label="sbtDefIde" /></div>
							
								<div class="defBlock splitOneThird">
									<div class="defLbl">
										<label title="<system:label show="tooltip" label="lblPre" />" class="label"><system:label show="text" label="lblPre" />:&nbsp;</label>
									</div>
									<br><br>
									<div class="oneLineRadio">
										<input type="radio" name="radIdePre" id="radIdePreNo" onclick="changeIdePre(true);" value="<system:edit show="constant" from="com.dogma.vo.BusEntityVo" field="IDENTIFIER_TXT_NOT_USE" />" <system:edit show="value" from="theBean" field="radIdePreNoChecked" /> <system:edit show="value" from="theBean" field="radIdePreNoDisabled" />>
										<label title="<system:label show="tooltip" label="lblNoUsa" />" for="radIdePreNo" class="label"><system:label show="text" label="lblNoUsa" /></label>
									</div>
									<div>&nbsp;</div>
									<div class="oneLineRadio"> 	
										<input type="radio" name="radIdePre" id="radIdePreAll" onclick="changeIdePre(true);" value="<system:edit show="constant" from="com.dogma.vo.BusEntityVo" field="IDENTIFIER_TXT_WRITE" />" <system:edit show="value" from="theBean" field="radIdePreAllChecked" /> <system:edit show="value" from="theBean" field="radIdePreAllDisabled" /> >
										<label title="<system:label show="tooltip" label="lblPerIng" />" for="radIdePreAll" class="label"><system:label show="text" label="lblPerIng" /></label>
									</div>
									<div>&nbsp;</div>	
									<div class="oneLineRadio">
										<input type="radio" name="radIdePre" id="radIdePreFix" onclick="changeIdePre(false);" value="<system:edit show="constant" from="com.dogma.vo.BusEntityVo" field="IDENTIFIER_TXT_FIXED" />" <system:edit show="value" from="theBean" field="radIdePreFixChecked" /> <system:edit show="value" from="theBean" field="radIdePreFixDisabled" />>
										<label title="<system:label show="tooltip" label="lblFij" />" for="radIdePreFix" class="label"><system:label show="text" label="lblFij" /></label>
										<input type=text size=6 maxlength=50 name="txtIdePre" id="txtIdePre" value="<system:edit show="value" from="theEdition" field="busEntIdePreFix" />" <system:edit show="ifNotValue" from="theBean" field="radIdePreFixChecked" value="checked">readonly class="readonly"</system:edit> <system:edit show="value" from="theBean" field="radIdePreFixDisabled" />   /> 
									</div>	
								</div>
								<div class="defBlock splitOneThird">
									<div class="defLbl">
										<label title="<system:label show="tooltip" label="lblNumero" />" class="label"><system:label show="text" label="lblNumero" />:&nbsp;</label>
									</div>
									<br><br>
									<div class="oneLineRadio">
										<input type="radio" name="radIdeNum" id="radIdeNumAuto" value="<system:edit show="constant" from="com.dogma.vo.BusEntityVo" field="IDENTIFIER_NUM_AUTO" />" <system:edit show="value" from="theBean" field="radIdeNumAuto" />>
										<label title="<system:label show="tooltip" label="lblAutNum" />" for="radIdeNumAuto" class="label"><system:label show="text" label="lblAutNum" /></label>
									</div>
									<div>&nbsp;</div>
									<div class="oneLineRadio"> 	
										<input type="radio" name="radIdeNum" id="radIdeNumReq" value="<system:edit show="constant" from="com.dogma.vo.BusEntityVo" field="IDENTIFIER_NUM_WRITE" />" <system:edit show="value" from="theBean" field="radIdeNumReq" /> >
										<label title="<system:label show="tooltip" label="lblExiIng" />" for="radIdeNumReq" class="label"><system:label show="text" label="lblExiIng" /></label>
									</div>
									<div>&nbsp;</div>	
									<div class="oneLineRadio">
										<input type="radio" name="radIdeNum" id="radIdeNumBoth" value="<system:edit show="constant" from="com.dogma.vo.BusEntityVo" field="IDENTIFIER_NUM_BOTH" />" <system:edit show="value" from="theBean" field="radIdeNumBoth" /> >
										<label title="<system:label show="tooltip" label="lblAmbos" />"  for="radIdeNumBoth" class="label"><system:label show="text" label="lblAmbos" /></label>
									</div>
									<div>&nbsp;</div>
									<div class="oneLineRadio">
										<input type="radio" name="radIdeNum" id="radIdeNumSame" value="<system:edit show="constant" from="com.dogma.vo.BusEntityVo" field="IDENTIFIER_NUM_SAME_PROCESS" />" <system:edit show="value" from="theBean" field="radIdeNumSame" /> >
										<label title="<system:label show="tooltip" label="lblSameProc" />"  for="radIdeNumSame" class="label"><system:label show="text" label="lblSameProc" /></label>
									</div>	
								</div>	
								<div class="defBlock splitOneThird">
									<div class="defLbl">
										<label title="<system:label show="tooltip" label="lblSuf" />" class="label"><system:label show="text" label="lblSuf" />:&nbsp;</label>
									</div>
									<br><br>
									<div class="oneLineRadio">
										<input type="radio" name="radIdePos" id="radIdePosNo" onclick="changeIdePos(true);" value="<system:edit show="constant" from="com.dogma.vo.BusEntityVo" field="IDENTIFIER_TXT_NOT_USE" />" <system:edit show="value" from="theBean" field="radIdePosNoChecked" /> <system:edit show="value" from="theBean" field="radIdePosNoDisabled" />>
										<label title="<system:label show="tooltip" label="lblNoUsa" />" for="radIdePosNo" class="label"><system:label show="text" label="lblNoUsa" /></label>
									</div>
									<div>&nbsp;</div>
									<div class="oneLineRadio"> 	
										<input type="radio" name="radIdePos" id="radIdePosAll" onclick="changeIdePos(true);" value="<system:edit show="constant" from="com.dogma.vo.BusEntityVo" field="IDENTIFIER_TXT_WRITE" />" <system:edit show="value" from="theBean" field="radIdePosAllChecked" /> <system:edit show="value" from="theBean" field="radIdePosAllDisabled" />>
										<label title="<system:label show="tooltip" label="lblPerIng" />" for="radIdePosAll" class="label"><system:label show="text" label="lblPerIng" /></label>
									</div>
									<div>&nbsp;</div>	
									<div class="oneLineRadio">											
											<input type="radio" name="radIdePos" id="radIdePosFix" onclick="changeIdePos(false);" value="<system:edit show="constant" from="com.dogma.vo.BusEntityVo" field="IDENTIFIER_TXT_FIXED" />" <system:edit show="value" from="theBean" field="radIdePosFixChecked" /> <system:edit show="value" from="theBean" field="radIdePosFixDisabled" />>
											<label title="<system:label show="tooltip" label="lblFij" />" for="radIdePosFix" class="label"><system:label show="text" label="lblFij" /></label>
										<input type=text size=6 maxlength=50 name="txtIdePos" id="txtIdePos" value="<system:edit show="value" from="theEdition" field="busEntIdePosFix" />" <system:edit show="ifNotValue" from="theBean" field="radIdePosFixChecked" value="checked">readonly class="readonly"</system:edit> <system:edit show="value" from="theBean" field="radIdePosFixDisabled" /> />		
									</div>	
								</div>
							</div>
							<div class="clear"></div><br/><br/>
							<div class="fieldGroup">
								<div class="title"><system:label show="text" label="lblSta" /></div>	
								<div class="modalOptionsContainer" id="statusContainer">										
									 <div class="element" id="addStatus" data-helper="true">
										<div class="option optionAdd"><system:label show="text" label="btnAgr" /></div>
									</div>
								</div>																			
							</div>									
						</div>				
					</div>
					<div class="aTab">
						<div class="tab" id="tabDefIde"><system:label show="text" label="tabEntProFor" /></div>
						<div class="contentTab">
							<div class="fieldGroup">
								<div class="title"><system:label show="text" label="sbtForEnt" /></div>
								<%@include file="forment.jsp" %>
								<div class="clearLeft sep"></div>
								<div class="title"><system:label show="text" label="sbtMonForEnt" /></div>
								<%@include file="formmonent.jsp" %>
								<div class="clearLeft sep"></div>
								<div class="title" title="<system:label show="tooltip" label="sbtPanelForEnt" />"><system:label show="text" label="sbtPanelForEnt" /></div>
								<%@include file="formpanelent.jsp" %>
								<div class="clearLeft sep"></div>
								<div class="title" id="titleEntPro" <system:edit show="ifValue" from="theEdition" field="busEntAdminType" value="F">style='display:none'</system:edit>><system:label show="text" label="sbtProEnt" /></div>
								<div class="modalOptionsContainer" id="processContainer" <system:edit show="ifValue" from="theEdition" field="busEntAdminType" value="F">style='display:none'</system:edit>>										
									 <div class="element" id="addProcess" data-helper="true">
										<div class="option optionAdd" id="divAddProcess"><system:label show="text" label="btnAgr" /></div>
									</div>
								</div>	
							</div>
						</div>
					</div>
					<div class="aTab">
						<div class="tab" id="attTab"><system:label show="text" label="tabAttEntNeg" /></div>
						<div class="contentTab">
							<div class="fieldGroup" id="att-container">
								<div class="field fieldOneThird" style="margin-right: 1%;">
									<div class="title"><system:label show="text" label="sbtBusEntAttString" /></div>
									<div class="modalOptionsContainer largerOption">
										<div class="option optionRemove" id="optAttId1" style="width: 100%; padding-right: 42px; box-sizing: border-box; -moz-box-sizing: border-box;"><input type="hidden" name="hidAttId1"  id="hidAttId1"  value="<system:edit show="value" from="theEdition" field="attId1" />"><input name="txtAttName1"  id="txtAttName1"  attPosition="0" value="<system:edit show="value" from="theEdition" field="attName1"  />" type="text" class="autocomplete"><input name="chkAttId1"  id="chkAttId1"  type="checkbox" <system:edit show="ifNotExistsValue" from="theEdition" field="attId1" >disabled</system:edit> <system:edit show="ifFlag" from="theEdition" field="0" defaultValue="attUcsFlags">checked='checked'</system:edit> style="float: right; margin-right: -22px;"></div>
										<div class="option optionRemove" id="optAttId2" style="width: 100%; padding-right: 42px; box-sizing: border-box; -moz-box-sizing: border-box;"><input type="hidden" name="hidAttId2"  id="hidAttId2"  value="<system:edit show="value" from="theEdition" field="attId2" />"><input name="txtAttName2"  id="txtAttName2"  attPosition="1" value="<system:edit show="value" from="theEdition" field="attName2"  />" type="text" class="autocomplete"><input name="chkAttId2"  id="chkAttId2"  type="checkbox" <system:edit show="ifNotExistsValue" from="theEdition" field="attId2" >disabled</system:edit> <system:edit show="ifFlag" from="theEdition" field="1" defaultValue="attUcsFlags">checked='checked'</system:edit> style="float: right; margin-right: -22px;"></div>
										<div class="option optionRemove" id="optAttId3" style="width: 100%; padding-right: 42px; box-sizing: border-box; -moz-box-sizing: border-box;"><input type="hidden" name="hidAttId3"  id="hidAttId3"  value="<system:edit show="value" from="theEdition" field="attId3" />"><input name="txtAttName3"  id="txtAttName3"  attPosition="2" value="<system:edit show="value" from="theEdition" field="attName3"  />" type="text" class="autocomplete"><input name="chkAttId3"  id="chkAttId3"  type="checkbox" <system:edit show="ifNotExistsValue" from="theEdition" field="attId3" >disabled</system:edit> <system:edit show="ifFlag" from="theEdition" field="2" defaultValue="attUcsFlags">checked='checked'</system:edit> style="float: right; margin-right: -22px;"></div>
										<div class="option optionRemove" id="optAttId4" style="width: 100%; padding-right: 42px; box-sizing: border-box; -moz-box-sizing: border-box;"><input type="hidden" name="hidAttId4"  id="hidAttId4"  value="<system:edit show="value" from="theEdition" field="attId4" />"><input name="txtAttName4"  id="txtAttName4"  attPosition="3" value="<system:edit show="value" from="theEdition" field="attName4"  />" type="text" class="autocomplete"><input name="chkAttId4"  id="chkAttId4"  type="checkbox" <system:edit show="ifNotExistsValue" from="theEdition" field="attId4" >disabled</system:edit> <system:edit show="ifFlag" from="theEdition" field="3" defaultValue="attUcsFlags">checked='checked'</system:edit> style="float: right; margin-right: -22px;"></div>
										<div class="option optionRemove" id="optAttId5" style="width: 100%; padding-right: 42px; box-sizing: border-box; -moz-box-sizing: border-box;"><input type="hidden" name="hidAttId5"  id="hidAttId5"  value="<system:edit show="value" from="theEdition" field="attId5" />"><input name="txtAttName5"  id="txtAttName5"  attPosition="4" value="<system:edit show="value" from="theEdition" field="attName5"  />" type="text" class="autocomplete"><input name="chkAttId5"  id="chkAttId5"  type="checkbox" <system:edit show="ifNotExistsValue" from="theEdition" field="attId5" >disabled</system:edit> <system:edit show="ifFlag" from="theEdition" field="4" defaultValue="attUcsFlags">checked='checked'</system:edit> style="float: right; margin-right: -22px;"></div>
										<div class="option optionRemove" id="optAttId6" style="width: 100%; padding-right: 42px; box-sizing: border-box; -moz-box-sizing: border-box;"><input type="hidden" name="hidAttId6"  id="hidAttId6"  value="<system:edit show="value" from="theEdition" field="attId6" />"><input name="txtAttName6"  id="txtAttName6"  attPosition="5" value="<system:edit show="value" from="theEdition" field="attName6"  />" type="text" class="autocomplete"><input name="chkAttId6"  id="chkAttId6"  type="checkbox" <system:edit show="ifNotExistsValue" from="theEdition" field="attId6" >disabled</system:edit> <system:edit show="ifFlag" from="theEdition" field="5" defaultValue="attUcsFlags">checked='checked'</system:edit> style="float: right; margin-right: -22px;"></div>
										<div class="option optionRemove" id="optAttId7" style="width: 100%; padding-right: 42px; box-sizing: border-box; -moz-box-sizing: border-box;"><input type="hidden" name="hidAttId7"  id="hidAttId7"  value="<system:edit show="value" from="theEdition" field="attId7" />"><input name="txtAttName7"  id="txtAttName7"  attPosition="6" value="<system:edit show="value" from="theEdition" field="attName7"  />" type="text" class="autocomplete"><input name="chkAttId7"  id="chkAttId7"  type="checkbox" <system:edit show="ifNotExistsValue" from="theEdition" field="attId7" >disabled</system:edit> <system:edit show="ifFlag" from="theEdition" field="6" defaultValue="attUcsFlags">checked='checked'</system:edit> style="float: right; margin-right: -22px;"></div>
										<div class="option optionRemove" id="optAttId8" style="width: 100%; padding-right: 42px; box-sizing: border-box; -moz-box-sizing: border-box;"><input type="hidden" name="hidAttId8"  id="hidAttId8"  value="<system:edit show="value" from="theEdition" field="attId8" />"><input name="txtAttName8"  id="txtAttName8"  attPosition="7" value="<system:edit show="value" from="theEdition" field="attName8"  />" type="text" class="autocomplete"><input name="chkAttId8"  id="chkAttId8"  type="checkbox" <system:edit show="ifNotExistsValue" from="theEdition" field="attId8" >disabled</system:edit> <system:edit show="ifFlag" from="theEdition" field="7" defaultValue="attUcsFlags">checked='checked'</system:edit> style="float: right; margin-right: -22px;"></div>
										<div class="option optionRemove" id="optAttId9" style="width: 100%; padding-right: 42px; box-sizing: border-box; -moz-box-sizing: border-box;"><input type="hidden" name="hidAttId9"  id="hidAttId9"  value="<system:edit show="value" from="theEdition" field="attId9" />"><input name="txtAttName9"  id="txtAttName9"  attPosition="8" value="<system:edit show="value" from="theEdition" field="attName9"  />" type="text" class="autocomplete"><input name="chkAttId9"  id="chkAttId9"  type="checkbox" <system:edit show="ifNotExistsValue" from="theEdition" field="attId9" >disabled</system:edit> <system:edit show="ifFlag" from="theEdition" field="8" defaultValue="attUcsFlags">checked='checked'</system:edit> style="float: right; margin-right: -22px;"></div>
										<div class="option optionRemove" id="optAttId10" style="width: 100%; padding-right: 42px; box-sizing: border-box; -moz-box-sizing: border-box;"><input type="hidden" name="hidAttId10" id="hidAttId10" value="<system:edit show="value" from="theEdition" field="attId10"/>"><input name="txtAttName10" id="txtAttName10" attPosition="9" value="<system:edit show="value" from="theEdition" field="attName10" />" type="text" class="autocomplete"><input name="chkAttId10" id="chkAttId10" type="checkbox" <system:edit show="ifNotExistsValue" from="theEdition" field="attId10">disabled</system:edit> <system:edit show="ifFlag" from="theEdition" field="9" defaultValue="attUcsFlags">checked='checked'</system:edit> style="float: right; margin-right: -22px;"></div>
									</div>
								</div>
								<div class="field fieldOneThird fieldLast" style="float:right">
									<div class="title"><system:label show="text" label="sbtBusEntAttDate" /></div>
									<div class="modalOptionsContainer largerOption">
										<div class="option optionRemove" id="optAttIdDte1" style="width: 100%; padding-right: 42px; box-sizing: border-box; -moz-box-sizing: border-box;"><input type="hidden" name="hidAttIdDte1" id="hidAttIdDte1" value="<system:edit show="value" from="theEdition" field="attIdDte1"/>"><input name="txtAttNameDte1" id="txtAttNameDte1" attPosition="18" value="<system:edit show="value" from="theEdition" field="attNameDte1" />" type="text" class="autocomplete"><input name="chkAttIdDte1" id="chkAttIdDte1" type="checkbox" <system:edit show="ifNotExistsValue" from="theEdition" field="attIdDte1" >disabled</system:edit> <system:edit show="ifFlag" from="theEdition" field="18" defaultValue="attUcsFlags">checked='checked'</system:edit> style="float: right; margin-right: -22px;"></div>
										<div class="option optionRemove" id="optAttIdDte2" style="width: 100%; padding-right: 42px; box-sizing: border-box; -moz-box-sizing: border-box;"><input type="hidden" name="hidAttIdDte2" id="hidAttIdDte2" value="<system:edit show="value" from="theEdition" field="attIdDte2"/>"><input name="txtAttNameDte2" id="txtAttNameDte2" attPosition="19" value="<system:edit show="value" from="theEdition" field="attNameDte2" />" type="text" class="autocomplete"><input name="chkAttIdDte2" id="chkAttIdDte2" type="checkbox" <system:edit show="ifNotExistsValue" from="theEdition" field="attIdDte2" >disabled</system:edit> <system:edit show="ifFlag" from="theEdition" field="19" defaultValue="attUcsFlags">checked='checked'</system:edit> style="float: right; margin-right: -22px;"></div>
										<div class="option optionRemove" id="optAttIdDte3" style="width: 100%; padding-right: 42px; box-sizing: border-box; -moz-box-sizing: border-box;"><input type="hidden" name="hidAttIdDte3" id="hidAttIdDte3" value="<system:edit show="value" from="theEdition" field="attIdDte3"/>"><input name="txtAttNameDte3" id="txtAttNameDte3" attPosition="20" value="<system:edit show="value" from="theEdition" field="attNameDte3" />" type="text" class="autocomplete"><input name="chkAttIdDte3" id="chkAttIdDte3" type="checkbox" <system:edit show="ifNotExistsValue" from="theEdition" field="attIdDte3" >disabled</system:edit> <system:edit show="ifFlag" from="theEdition" field="20" defaultValue="attUcsFlags">checked='checked'</system:edit> style="float: right; margin-right: -22px;"></div>
										<div class="option optionRemove" id="optAttIdDte4" style="width: 100%; padding-right: 42px; box-sizing: border-box; -moz-box-sizing: border-box;"><input type="hidden" name="hidAttIdDte4" id="hidAttIdDte4" value="<system:edit show="value" from="theEdition" field="attIdDte4"/>"><input name="txtAttNameDte4" id="txtAttNameDte4" attPosition="21" value="<system:edit show="value" from="theEdition" field="attNameDte4" />" type="text" class="autocomplete"><input name="chkAttIdDte4" id="chkAttIdDte4" type="checkbox" <system:edit show="ifNotExistsValue" from="theEdition" field="attIdDte4" >disabled</system:edit> <system:edit show="ifFlag" from="theEdition" field="21" defaultValue="attUcsFlags">checked='checked'</system:edit> style="float: right; margin-right: -22px;"></div>
										<div class="option optionRemove" id="optAttIdDte5" style="width: 100%; padding-right: 42px; box-sizing: border-box; -moz-box-sizing: border-box;"><input type="hidden" name="hidAttIdDte5" id="hidAttIdDte5" value="<system:edit show="value" from="theEdition" field="attIdDte5"/>"><input name="txtAttNameDte5" id="txtAttNameDte5" attPosition="22" value="<system:edit show="value" from="theEdition" field="attNameDte5" />" type="text" class="autocomplete"><input name="chkAttIdDte5" id="chkAttIdDte5" type="checkbox" <system:edit show="ifNotExistsValue" from="theEdition" field="attIdDte5" >disabled</system:edit> <system:edit show="ifFlag" from="theEdition" field="22" defaultValue="attUcsFlags">checked='checked'</system:edit> style="float: right; margin-right: -22px;"></div>
										<div class="option optionRemove" id="optAttIdDte6" style="width: 100%; padding-right: 42px; box-sizing: border-box; -moz-box-sizing: border-box;"><input type="hidden" name="hidAttIdDte6" id="hidAttIdDte6" value="<system:edit show="value" from="theEdition" field="attIdDte6"/>"><input name="txtAttNameDte6" id="txtAttNameDte6" attPosition="23" value="<system:edit show="value" from="theEdition" field="attNameDte6" />" type="text" class="autocomplete"><input name="chkAttIdDte6" id="chkAttIdDte6" type="checkbox" <system:edit show="ifNotExistsValue" from="theEdition" field="attIdDte6" >disabled</system:edit> <system:edit show="ifFlag" from="theEdition" field="23" defaultValue="attUcsFlags">checked='checked'</system:edit> style="float: right; margin-right: -22px;"></div>
									</div>
									
									<div class="title"><system:label show="text" label="sbtEntAttTitle" /></div>
									<div class="modalOptionsContainer  largerOption">
										<div class="option optionRemove" id="optAttIdTitle" style="width: 100%; padding-right: 42px; box-sizing: border-box; -moz-box-sizing: border-box;"><input type="hidden" name="hidAttIdTitle" id="hidAttIdTitle"   value="<system:edit show="value" from="theEdition" field="attItemTitle"/>"><input name="txtAttNameTitle" id="txtAttNameTitle"  value="<system:edit show="value" from="theEdition" field="attItemTitleName" />"  type="text" class="autocomplete"> <input name="chkAttIdTitle" id="chkAttIdTitle" type="checkbox"  style="float: right; margin-right: -22px; display:none">  </div>
										
									</div>
									<div class="title"><system:label show="text" label="sbtEntAttDesc" /></div>
									<div class="modalOptionsContainer  largerOption">
										<div class="option optionRemove" id="optAttIdDesc"  style="width: 100%; padding-right: 42px; box-sizing: border-box; -moz-box-sizing: border-box;"><input type="hidden" name="hidAttIdDesc" id="hidAttIdDesc"     value="<system:edit show="value" from="theEdition" field="attItemDesc"/>"><input name="txtAttNameDesc"   id="txtAttNameDesc"   value="<system:edit show="value" from="theEdition" field="attItemDescName" />"   type="text" class="autocomplete"> <input name="chkAttIdDesc"  id="chkAttIdDesc" type="checkbox"  style="float: right; margin-right: -22px; display:none"></div>
									</div>
									
								</div>
								<div class="field fieldOneThird" style="margin-right: 2%; float:right">
									<div class="title"><system:label show="text" label="sbtBusEntAttNumber" /></div>
									<div class="modalOptionsContainer  largerOption">
										<div class="option optionRemove" id="optAttIdNum1" style="width: 100%; padding-right: 42px; box-sizing: border-box; -moz-box-sizing: border-box;"><input type="hidden" name="hidAttIdNum1" id="hidAttIdNum1" value="<system:edit show="value" from="theEdition" field="attIdNum1"/>"><input name="txtAttNameNum1" id="txtAttNameNum1" attPosition="10" value="<system:edit show="value" from="theEdition" field="attNameNum1" />" type="text" class="autocomplete"><input name="chkAttIdNum1" id="chkAttIdNum1" type="checkbox" <system:edit show="ifNotExistsValue" from="theEdition" field="attIdNum1" >disabled</system:edit> <system:edit show="ifFlag" from="theEdition" field="10" defaultValue="attUcsFlags">checked='checked'</system:edit> style="float: right; margin-right: -22px;"></div>
										<div class="option optionRemove" id="optAttIdNum2" style="width: 100%; padding-right: 42px; box-sizing: border-box; -moz-box-sizing: border-box;"><input type="hidden" name="hidAttIdNum2" id="hidAttIdNum2" value="<system:edit show="value" from="theEdition" field="attIdNum2"/>"><input name="txtAttNameNum2" id="txtAttNameNum2" attPosition="11" value="<system:edit show="value" from="theEdition" field="attNameNum2" />" type="text" class="autocomplete"><input name="chkAttIdNum2" id="chkAttIdNum2" type="checkbox" <system:edit show="ifNotExistsValue" from="theEdition" field="attIdNum2" >disabled</system:edit> <system:edit show="ifFlag" from="theEdition" field="11" defaultValue="attUcsFlags">checked='checked'</system:edit> style="float: right; margin-right: -22px;"></div>
										<div class="option optionRemove" id="optAttIdNum3" style="width: 100%; padding-right: 42px; box-sizing: border-box; -moz-box-sizing: border-box;"><input type="hidden" name="hidAttIdNum3" id="hidAttIdNum3" value="<system:edit show="value" from="theEdition" field="attIdNum3"/>"><input name="txtAttNameNum3" id="txtAttNameNum3" attPosition="12" value="<system:edit show="value" from="theEdition" field="attNameNum3" />" type="text" class="autocomplete"><input name="chkAttIdNum3" id="chkAttIdNum3" type="checkbox" <system:edit show="ifNotExistsValue" from="theEdition" field="attIdNum3" >disabled</system:edit> <system:edit show="ifFlag" from="theEdition" field="12" defaultValue="attUcsFlags">checked='checked'</system:edit> style="float: right; margin-right: -22px;"></div>
										<div class="option optionRemove" id="optAttIdNum4" style="width: 100%; padding-right: 42px; box-sizing: border-box; -moz-box-sizing: border-box;"><input type="hidden" name="hidAttIdNum4" id="hidAttIdNum4" value="<system:edit show="value" from="theEdition" field="attIdNum4"/>"><input name="txtAttNameNum4" id="txtAttNameNum4" attPosition="13" value="<system:edit show="value" from="theEdition" field="attNameNum4" />" type="text" class="autocomplete"><input name="chkAttIdNum4" id="chkAttIdNum4" type="checkbox" <system:edit show="ifNotExistsValue" from="theEdition" field="attIdNum4" >disabled</system:edit> <system:edit show="ifFlag" from="theEdition" field="13" defaultValue="attUcsFlags">checked='checked'</system:edit> style="float: right; margin-right: -22px;"></div>
										<div class="option optionRemove" id="optAttIdNum5" style="width: 100%; padding-right: 42px; box-sizing: border-box; -moz-box-sizing: border-box;"><input type="hidden" name="hidAttIdNum5" id="hidAttIdNum5" value="<system:edit show="value" from="theEdition" field="attIdNum5"/>"><input name="txtAttNameNum5" id="txtAttNameNum5" attPosition="14" value="<system:edit show="value" from="theEdition" field="attNameNum5" />" type="text" class="autocomplete"><input name="chkAttIdNum5" id="chkAttIdNum5" type="checkbox" <system:edit show="ifNotExistsValue" from="theEdition" field="attIdNum5" >disabled</system:edit> <system:edit show="ifFlag" from="theEdition" field="14" defaultValue="attUcsFlags">checked='checked'</system:edit> style="float: right; margin-right: -22px;"></div>
										<div class="option optionRemove" id="optAttIdNum6" style="width: 100%; padding-right: 42px; box-sizing: border-box; -moz-box-sizing: border-box;"><input type="hidden" name="hidAttIdNum6" id="hidAttIdNum6" value="<system:edit show="value" from="theEdition" field="attIdNum6"/>"><input name="txtAttNameNum6" id="txtAttNameNum6" attPosition="15" value="<system:edit show="value" from="theEdition" field="attNameNum6" />" type="text" class="autocomplete"><input name="chkAttIdNum6" id="chkAttIdNum6" type="checkbox" <system:edit show="ifNotExistsValue" from="theEdition" field="attIdNum6" >disabled</system:edit> <system:edit show="ifFlag" from="theEdition" field="15" defaultValue="attUcsFlags">checked='checked'</system:edit> style="float: right; margin-right: -22px;"></div>
										<div class="option optionRemove" id="optAttIdNum7" style="width: 100%; padding-right: 42px; box-sizing: border-box; -moz-box-sizing: border-box;"><input type="hidden" name="hidAttIdNum7" id="hidAttIdNum7" value="<system:edit show="value" from="theEdition" field="attIdNum7"/>"><input name="txtAttNameNum7" id="txtAttNameNum7" attPosition="16" value="<system:edit show="value" from="theEdition" field="attNameNum7" />" type="text" class="autocomplete"><input name="chkAttIdNum7" id="chkAttIdNum7" type="checkbox" <system:edit show="ifNotExistsValue" from="theEdition" field="attIdNum7" >disabled</system:edit> <system:edit show="ifFlag" from="theEdition" field="16" defaultValue="attUcsFlags">checked='checked'</system:edit> style="float: right; margin-right: -22px;"></div>
										<div class="option optionRemove" id="optAttIdNum8" style="width: 100%; padding-right: 42px; box-sizing: border-box; -moz-box-sizing: border-box;"><input type="hidden" name="hidAttIdNum8" id="hidAttIdNum8" value="<system:edit show="value" from="theEdition" field="attIdNum8"/>"><input name="txtAttNameNum8" id="txtAttNameNum8" attPosition="17" value="<system:edit show="value" from="theEdition" field="attNameNum8" />" type="text" class="autocomplete"><input name="chkAttIdNum8" id="chkAttIdNum8" type="checkbox" <system:edit show="ifNotExistsValue" from="theEdition" field="attIdNum8" >disabled</system:edit> <system:edit show="ifFlag" from="theEdition" field="17" defaultValue="attUcsFlags">checked='checked'</system:edit> style="float: right; margin-right: -22px;"></div>
									</div>
								</div>
							</div>
							
							<div class="fieldGroup">
								<div class="title"><system:label show="text" label="sbtBusEntBehaviour" /></div>
								<div class="field extendedSize">
									<label><system:label show="text" label="lblAttTxtCmbEntNeg" />:&nbsp;</label>
									<select name="cmbAttText" id="cmbAttText" mustBeSelected="<system:edit show="value" from="theEdition" field="busEntAttCmb"/>"></select>
								</div>
							</div>
							<div class="fieldGroup splitTable">
								<div class="field">
									<label><system:label show="text" label="lblBusEntQryMod" />:&nbsp;</label>
									<input type="checkbox" id="chkQryMod" name="chkQryMod" <system:edit show="ifFlag" from="theEdition" field="0" >checked='checked'</system:edit> <system:edit show="ifValue" from="theEdition" field="modalDependency" value="true">disabled="disabled"</system:edit>>
								</div>
								<div class="field">
									<label><system:label show="text" label="lblBusEntAutQry" />:&nbsp;</label>
									<input type="checkbox" id="chkAutQry" name="chkAutQry" <system:edit show="ifFlag" from="theEdition" field="2" >checked='checked'</system:edit>>
								</div>
								<div class="field">
									<label><system:label show="text" label="lblBusEntGenTree" />:</label>
									<input type="checkbox" id="chkTreeEnt" name="chkTreeEnt" <system:edit show="ifFlag" from="theEdition" field="6" >checked='checked'</system:edit>>
								</div>
							</div>
							<div class="fieldGroup splitTable" style="width: 48% !important">	
								<div class="field">
									<label><system:label show="text" label="lblBusEntCod" />:&nbsp;</label>
									<input type="checkbox" id="chkCod" name="chkCod" <system:edit show="ifFlag" from="theEdition" field="3" >checked='checked'</system:edit>>
								</div>
								<div class="field">
									<label title="<system:label show="tooltip" label="lblUsrAdm" />" class="label" style="width: 145px !important;"><system:label show="text" label="lblUsrAdm" />:&nbsp;</label>
									<input type="checkbox" id="txtUsrAdm" name="txtUsrAdm" <system:edit show="ifFlag" from="theEdition" field="1" >checked='checked'</system:edit>>
								</div>
								<div class="field">
									<label title="<system:label show="tooltip" label="lblFncHidFun" />" class="label" style="width: 145px !important;"><system:label show="text" label="lblFncHidFun" />:&nbsp;</label>
									<input type="checkbox" id="flagShowFunc" name="flagShowFunc" <system:edit show="ifFlag" from="theEdition" field="12" >checked='checked'</system:edit>>
								</div>
							</div>
							<div class="fieldGroup" style="width: 100% !important;">
								<div class="gridContainer" style="margin-right: 0px !important; height: 250px;">
									<div class="fieldGroup">
										<div class="title"><system:label show="text" label="sbtAttMapEnt" /></div>
										<%@include file="attentrelation.jsp" %>
									</div>
								</div>
							</div>
						</div>
					</div>

					<div class="aTab">
						<div class="tab" id="envEvtTab"><system:label show="text" label="tabEntEvt" /></div>
						<div class="contentTab">
							<div class="fieldGroup">
								<div class="title"><system:label show="text" label="flaEve" /></div>
							</div>
							<%@include file="tabEntEvents.jsp" %>
							
							<div class="clear"></div>
							<div class="fieldGroup">
								<div class="title"><system:label show="text" label="titSta" /></div>
							</div>
							<%@include file="tabEntStates.jsp" %>
							
							<textarea cols='80' rows='10' id="txtMap" name="txtMap" style="display:none"><system:edit show="value" from="theBean" field="entDefinitionXML"></system:edit></textarea>
							<textarea cols='80' rows='10' id="txtEntityStateXML" name="txtEntityStateXML" style="display:none"><system:edit show="value" from="theBean" field="entStaDefinitionXML"></system:edit></textarea>
						</div>
					</div>
					
					
					<div class="aTab">
						<div class="tab" id="tabDoc"><system:label show="text" label="tabDoc" /></div>
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
<!-- 									<div class="field fieldOneThird"> -->
<%-- 										<label title="<system:label show="tooltip" label="lblAllDocsInSys" />" class="label"><system:label show="text" label="lblAllDocsInSys" />:&nbsp;</label> --%>
<!-- 										<input type="checkbox" id="chckMonDoc" name="chckMonDoc" <system:edit show="ifFlag" from="theEdition" field="13" >checked='checked'</system:edit> onchange="checkSelMonOpt(this)"> -->
<!-- 									</div> -->
									
									<div class="field fieldOneThird" id="hideMeta">
										<label title="<system:label show="tooltip" label="lblHideMeta" />" class="label"><system:label show="text" label="lblHideMeta" />:&nbsp;</label>
										<input type="checkbox" id="chckShowMeta" name="chckShowMeta" <system:edit show="ifFlag" from="theEdition" field="15" >checked='checked'</system:edit>>
									</div>
									
									<div class="field fieldOneThird" id="hidePerms">
										<label title="<system:label show="tooltip" label="lblHidePerms" />" class="label"><system:label show="text" label="lblHidePerms" />:&nbsp;</label>
										<input type="checkbox" id="chckShowPerm" name="chckShowPerm" <system:edit show="ifFlag" from="theEdition" field="14" >checked='checked'</system:edit>>
									</div>
									
									<br>
									
									<div class="field fieldOneThird" id="collapsePerms">
										<label title="<system:label show="tooltip" label="lblShwColPerm" />" class="label"><system:label show="text" label="lblShwColPerm" />:&nbsp;</label>
										<input type="checkbox" id="chckShowColPerm" name="chckShowColPerm" <system:edit show="ifFlag" from="theEdition" field="18" >checked='checked'</system:edit>>
									</div>
									
									<div class="field fieldOneThird" id="collapseFldStrc">
										<label title="<system:label show="tooltip" label="lblShwColFldStrc" />" class="label"><system:label show="text" label="lblShwColFldStrc" />:&nbsp;</label>
										<input type="checkbox" id="chckShowColFldStrc" name="chckShowColFldStrc" <system:edit show="ifFlag" from="theEdition" field="19" >checked='checked'</system:edit>>
									</div>
									
									<div class="field fieldOneThird" id="collapseMeta">
										<label title="<system:label show="tooltip" label="lblShwColMeta" />" class="label"><system:label show="text" label="lblShwColMeta" />:&nbsp;</label>
										<input type="checkbox" id="chckShowColMeta" name="chckShowColMeta" <system:edit show="ifFlag" from="theEdition" field="20" >checked='checked'</system:edit>>
									</div>
									
									<br>									
									
									<div class="field fieldOneThird" id="allowSelDocMonDoc">
										<label title="<system:label show="tooltip" label="lblAllSelDcMonDoc" />" class="label"><system:label show="text" label="lblAllSelDcMonDoc" />:&nbsp;</label>
										<system:util show="prepareComboYesNoGenEnv" saveOn="optionsCombo"></system:util>
										<select id="showMonDoc" name="showMonDoc" onchange="checkSelMonOpt();">
											<system:edit show="iteration" from="optionsCombo" saveOn="option">
												<system:edit show="saveValue" from="theBean" field="flagStringUseMonDoc" saveOn="optionId"></system:edit>	<!-- VER LOS DEMAS ATRIBUTOS -->
												<option value='<system:edit show="value" from="option" field="value"/>' <system:edit show="ifValue" from="option" field="value" value="with:optionId">selected</system:edit> ><system:edit show="value" from="option" field="text"/></option>
											</system:edit>
										</select>
									</div>
									
									
									<div class="field fieldOneThird <system:edit show="ifNotFlag" from="theEdition" field="13" >hidden</system:edit>" id="selDocMon">
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
					<div class="aTab">
						<div class="tab" id="tabRel"><system:label show="text" label="tabEntRel" /></div>
						<div class="contentTab">
							<div class="fieldGroup" style="width: 100% !important;">
								<div class="gridContainer" style="margin-right: 0px !important;">
									<div class="fieldGroup">
										<div class="title"><system:label show="text" label="sbtEjeEntVinDes" /></div>
										<%@include file="descendants.jsp" %>
										<div class="clearLeft sep"></div>
										<div class="title"><system:label show="text" label="sbtEjeEntVinAnc" /></div>
										<%@include file="ancestors.jsp" %>
									</div>
								</div>
							</div>			
						</div>
					</div>	
					<!-- if bi -->
					<system:edit show="ifExistsValue" from="theBean" field="biMessage">
							<div class="aTab">
								<div class="tab" id="biTab"><system:label show="text" label="tabDwQry" /></div>
								<div class="contentTab">							
									<system:edit show="ifValue" from="theBean" field="biMessage" value="ok">
										<div class="gridContainer" style="margin: 0px">
											<div class="fieldGroup">
												<div class="title"><system:label show="text" label="txtAnaGenData" /></div>
												<div class="field">
													<div class="field oneLineChbox">
														<label title="<system:label show="tooltip" label="lblDwCreCube" />" for="chkCreateCbe" class="label"><system:label show="text" label="lblDwCreCube" />:&nbsp;
														<input type="checkbox" id="chkCreateCbe" name="chkCreateCbe" <system:edit show="ifValue" from="theBean" field="hasCube" value="true" >checked='checked'</system:edit> /></label>
														<input type="hidden" name="hidCbeChanged" id="hidCbeChanged" value="false">
													</div>
												</div>
												<div class="clearLeft"></div>
												<div class="field <system:edit show="ifValue" from="theBean" field="hasCube" value="false" >required</system:edit>">
													<label title="<system:label show="tooltip" label="lblNom" />"><system:label show="text" label="lblNom" />:&nbsp;</label>
													<input type="text" name="txtCbeName" id="txtCbeName"  <system:edit show="ifValue" from="theBean" field="hasCube" value="true" >class="validate['required']"</system:edit> value="<system:edit show="ifValue" from="theBean" field="hasCube" value="true" ><system:edit show="value" from="theBean" field="cubeName"/></system:edit>" <system:edit show="ifValue" from="theBean" field="hasCube" value="false" >disabled='disabled'</system:edit>>
												</div>
												<div class="field <system:edit show="ifValue" from="theBean" field="hasCube" value="false" >required</system:edit>">
													<label title="<system:label show="tooltip" label="lblTit" />"><system:label show="text" label="lblTit" />:&nbsp;</label>
													<input type="text" name="txtCbeTitle" id="txtCbeTitle"  <system:edit show="ifValue" from="theBean" field="hasCube" value="true" >class="validate['required']"</system:edit> value="<system:edit show="ifValue" from="theBean" field="hasCube" value="true" ><system:edit show="value" from="theBean" field="cubeTitle"/></system:edit>" <system:edit show="ifValue" from="theBean" field="hasCube" value="false" >disabled='disabled'</system:edit>>
												</div>
												<div class="field">
													<label title="<system:label show="tooltip" label="lblDesc" />"><system:label show="text" label="lblDesc" />:&nbsp;</label>
													<input type="text" name="txtCbeDesc" id="txtCbeDesc"  value="<system:edit show="ifValue" from="theBean" field="hasCube" value="true" ><system:edit show="value" from="theBean" field="cubeDesc"/></system:edit>" <system:edit show="ifValue" from="theBean" field="hasCube" value="false" >disabled='disabled'</system:edit>>
												</div>												
												<div class="clearLeft sep"></div>
												<div class="title"><system:label show="text" label="lblDwDimensions" /></div>
												<%@include file="dimensions.jsp" %>
												<div class="clearLeft sep"></div>
												<div class="title"><system:label show="text" label="lblMeasures" /></div>
												<%@include file="measures.jsp" %>
											</div>
											<div class="clearLeft sep"></div>
											<div class="fieldGroup split">																									
												<div class="title"><system:label show="text" label="lblPrfAccCube" /></div>
												<div class="modalOptionsContainer" id="divProfiles" >										
													 <div class="element" id="addProfile" data-helper="true">
														<div class="option optionAdd" id="divAddProfile" ><system:label show="text" label="btnAgr" /></div>
													</div>
												</div>
											</div>
											<div class="fieldGroup split">												
												<div class="title"><system:label show="text" label="sbtPerNoAcc" /></div>
												<div class="modalOptionsContainer" id="divNoAccProfiles" >										
													 <div class="element" id="addProfile" data-helper="true">
														<div class="option optionAdd" id="divAddNoAccProfile" ><system:label show="text" label="btnAgr" /></div>
													</div>
												</div>
											</div>			
											<div class="clearLeft sep"></div>
											<div class="fieldGroup">												
												<div class="title"><system:label show="text" label="lblDataLoad" /></div>
												<div class="field extendedSize">
													<div class="oneLineRadio">														
														<label title="<system:label show="tooltip" label="lblLoadOnConfirm"/>" style="width: 100%" for="dataLoad1" class="label"><input type="radio" name="dataLoad" id="dataLoad1" onclick="changeRadFact(1)" checked='checked' <system:edit show="ifValue" from="theBean" field="hasCube" value="false" >disabled='disabled'</system:edit>><system:label show="text" label="lblLoadOnConfirm" /></label>
													</div>														
												</div>		
												<div class="clearLeft"></div>
												<div class="field extendedSize">
													<div class="oneLineRadio">														
														<label title="<system:label show="tooltip" label="lblSchedLoad"/>" style="width: 100%" for="dataLoad2" class="label"><input type="radio" name="dataLoad" id="dataLoad2" onclick="changeRadFact(2)" <system:edit show="ifValue" from="theBean" field="hasCube" value="false" >disabled='disabled'</system:edit> /><system:label show="text" label="lblSchedLoad" /></label>
													</div>														
												</div>	
												<div class="field extendedSize">
													<div class="oneLineDate">
														<label title="<system:label show="tooltip" label="lblFchIni" />" for="txtFchIni" class="label"><system:label show="text" label="lblFchIni" />:&nbsp;<input id="txtFchIni" name="txtFchIni" type="text" class="datePicker filterInputDate" value="" disabled='disabled'></label>
													</div>
												</div>
												<div class="clearLeft"></div>
												<div class="field extendedSize">&nbsp;</div>													
												<div class="field extendedSize">
													<div class="oneLineInput">
														<label title="<system:label show="tooltip" label="lblHorIni" />" for="txtHorIni" class="label"><system:label show="text" label="lblHorIni" />:&nbsp;&nbsp;&nbsp;<input type="text" name="txtHorIni" id="txtHorIni" class="validate['required','~validateHours']" disabled='disabled'/></label>
													</div>
												</div>
												<div class="clearLeft sep"><input name="radSelected" id="radSelected" type="hidden" value="1"></div>														
												<div class="clearLeft sep"></div>
											</div>
										</div>		
									</system:edit>
									<system:edit show="ifNotValue" from="theBean" field="biMessage" value="ok">
										<system:edit show="value" from="theBean" field="biMessage"></system:edit>
									</system:edit>											
								</div>
							</div>
					</system:edit>
					<!-- end if bi -->
					<div class="aTab">
						<div class="tab" id="tabBusEntPer"><system:label show="text" label="tabBusEntPer" /></div>
						<div class="contentTab">
							<%@include file="../../generic/permissions.jsp" %>							
						</div>
					</div>	
					
					<br><br><br><br><br><br><br>
										
				</div>
				<system:campaign inLogin="false" inSplash="false" location="horizontalDown" />	
			</div>			
		</form>
		<div style="display:none" id="divDragDropForm"></div>
	</div>
	<!-- MODALS -->
	<%@include file="../../modals/permissions.jsp" %>
	<%@include file="../../modals/images.jsp" %>
	<%@include file="../../modals/status.jsp" %>
	<%@include file="../../modals/processes.jsp" %>
	<%@include file="../../modals/forms.jsp" %>
	<%@include file="../../modals/documents.jsp" %>
	<%@include file="../../modals/profiles.jsp" %>
	<%@include file="../../modals/entities.jsp" %>
	<%@include file="../../modals/documentType.jsp" %>
	<%@include file="../../includes/footer.jsp" %>
</body>
</html>

