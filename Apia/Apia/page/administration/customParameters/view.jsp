<%@include file="../../includes/startInc.jsp" %><html lang="<%=biz.statum.apia.web.bean.BasicBeanStatic.getUserDataStatic(request).getLangCode()%>"><head><%@include file="../../includes/headInclude.jsp" %><script type="text/javascript" src="<system:util show="context" />/page/administration/customParameters/view.js"></script><script type="text/javascript" src="<system:util show="context" />/page/includes/adminActionsEdition.js"></script><script type="text/javascript" src="<system:util show="context" />/page/includes/adminFav.js"></script><script type="text/javascript" src="<system:util show="context" />/page/includes/navButtons.js"></script><script type="text/javascript" src="<system:util show="context" />/page/includes/campaigns.js"></script><script type="text/javascript">
		var URL_REQUEST_AJAX	= '/apia.administration.CustomParametersAction.run';	
		var TYPE_STRING			= '<system:edit show="constant" from="com.dogma.vo.CustomParametersVo" field="CUS_PAR_STRING"/>';		
		var TYPE_INTEGER		= '<system:edit show="constant" from="com.dogma.vo.CustomParametersVo" field="CUS_PAR_INTEGER"/>';
		var TYPE_DATE			= '<system:edit show="constant" from="com.dogma.vo.CustomParametersVo" field="CUS_PAR_DATE"/>';
		var TYPE_BOOL_COMBO		= '<system:edit show="constant" from="com.dogma.vo.CustomParametersVo" field="CUS_PAR_BOOL_CMB"/>';
		var TYPE_CHECKBOX		= '<system:edit show="constant" from="com.dogma.vo.CustomParametersVo" field="CUS_PAR_CHECKBOX"/>';
		var msgOpOk				= '<system:label show="text" label="msgOpOk" />';
		var lblSi				= '<system:label show="text" label="lblSi" />';
		var lblNo				= '<system:label show="text" label="lblNo" />';
		var MODE_SERVER 		= toBoolean('<system:edit show="constant" from="com.dogma.Configuration" field="SERVER_MODE"/>');
		
		var lastMemoryUpdate = '<system:edit show="value" from="theBean" field="lastMemoryUpdate" />';
		var lastDBUpdate = '<system:edit show="value" from="theBean" field="lastDBUpdate" />';
		var synchronizedParameters = <system:edit show="value" from="theBean" field="synchronizedParameters"/>;
		
		var LABEL_CONFIRM_UPDATE = '<system:label show="text" label="msgUpdateParameter" forHtml="true" forScript="true" />';
	</script></head><body><div id="exec-blocker"></div><div class="header"></div><div class="body" id="bodyDiv"><form id="frmData"><div class="optionsContainer"><system:campaign inLogin="false" inSplash="false" location="verticalUp" /><div class="fncPanel info"><div class="title"><system:label show="text" label="mnuAdmCustParam" /><%@include file="../../includes/adminFav.jsp" %></div><div class="content divFncDescription"><div class="fncDescriptionImage" data-src="<system:edit show="value" from="theBean" field="fncImage"/>"></div><div id="fncDescriptionText"><system:label show="text" label="dscFncAdmCustParam"/></div><div class="clear"></div></div></div><%@include file="../../includes/adminActionsEdition.jsp" %><div class="fncPanel options" id="panelInfo"><div class="title"><system:label show="text" label="mnuAddInfo"/></div><div class="content"><div id="btnReloadPars" class="button" title="<system:label show="tooltip" label="btnReloadPars" />"><system:label show="text" label="btnReloadPars" /></div><div class="filter"><div style="width:100%;"><span class="infoGenData"><b><system:label show="text" label="parMemDate"/>: </b></span><a id="lastMemoryUpdate"></a></div><div style="width:100%;"><span class="infoGenData"><b><system:label show="text" label="parDBDate"/>: </b></span><a id="lastDBUpdate"></a></div></div></div></div><system:campaign inLogin="false" inSplash="false" location="verticalDown" /></div><div class="dataContainer"><div class='tabComponent' id="tabComponent"><div class="aTabHeader"><system:campaign inLogin="false" inSplash="false" location="horizontalUp" /></div><!-- GLOBALES --><div class="aTab"><div class="tab" id="cus_par_global"><system:label show="text" label="lblCusParGlo" /></div><div class="contentTab"><div class="fieldGroup" id="container_global" style="margin-top: 30px;"><div id="no_cus_par_global" class="noCustParams"><system:label show='text' label='msgNoGloCusParams' forHtml='true'/></div></div></div></div><!-- PROYECTOS --><system:edit show="iteration" from="theBean" field="allProjects" saveOn="project"><div class="aTab"><div class="tab" id="cus_par_<system:edit show="value" from="project" field="prjId" />"><system:edit show="value" from="project" field="prjTitle" /></div><div class="contentTab"><div class="fieldGroup" id="container_<system:edit show="value" from="project" field="prjId" />" style="margin-top: 30px;"><div id="no_cus_par_<system:edit show="value" from="project" field="prjId" />" class="noCustParams"><system:label show='text' label='msgNoPrjCusParams' forHtml='true'/></div></div></div></div></system:edit></div><system:campaign inLogin="false" inSplash="false" location="horizontalDown" /></div></form></div><jsp:include page="../../includes/footer.jsp" /></body></html>
