<%@include file="../../includes/startInc.jsp" %><html lang="<%=biz.statum.apia.web.bean.BasicBeanStatic.getUserDataStatic(request).getLangCode()%>"><head><%@include file="../../includes/headInclude.jsp" %><script type="text/javascript" src="<system:util show="context" />/page/administration/hierarchicalStructure/structure.js"></script><script type="text/javascript" src="<system:util show="context" />/page/administration/hierarchicalStructure/mdlInformation.js"></script><script type="text/javascript" src="<system:util show="context" />/page/includes/adminActionsEdition.js"></script><script type="text/javascript" src="<system:util show="context" />/page/includes/navButtons.js"></script><script type="text/javascript" src="<system:util show="context" />/page/includes/campaigns.js"></script><script type="text/javascript" src="<system:util show="context" />/page/includes/adminFav.js"></script><script type="text/javascript" src="<system:util show="context" />/page/modals/pools.js"></script><script type="text/javascript">
		var URL_REQUEST_AJAX 	= '/apia.administration.HierarchicalStructureAction.run';
		var MODE_GLOBAL			= toBoolean('<system:edit show="value" from="theBean" field="modeGlobal" />');
		var ENABLE				= toBoolean('<system:edit show="value" from="theBean" field="enable" />');
		var MSG_MUST_SEL_ONE	= '<system:label show="text" label="lblSelNod" forScript="true" />';
		var MSG_NOT_ENABLE		= '<system:label show="text" label="lblEnvHieNotActive" forScript="true" />';
		var MSG_DEL_GLB_NODE	= '<system:label show="text" label="msgDesBorNod" forScript="true" />';
		var MSG_CANT_MOVE_NODE	= '<system:label show="text" label="lblMovNod" forScript="true" />';
		var MSG_CANT_DEL_NODE	= '<system:label show="text" label="lblEliNod" forScript="true" />';
		var MSG_OP_COMP_OK		= '<system:label show="text" label="msgOpOk" forScript="true" />';
		var MSG_NODE_EXIST		= '<system:label show="text" label="msgNodeExist" forScript="true" />';
		var MSG_NODES_EXIST		= '<system:label show="text" label="msgNodesExist" forScript="true" />';
		var MSG_CANT_ADD		= '<system:label show="text" label="msgNotAddNode" forScript="true" />';
		var PRIMARY_SEPARATOR	= new Element('div').set('html', '<system:edit show="constant" from="com.st.util.StringUtil" field="PRIMARY_SEPARATOR"/>').get('text');
	</script></head><body><div id="exec-blocker"></div><div class="body" id="bodyDiv"><form id="frmData"><div class="optionsContainer"><system:campaign inLogin="false" inSplash="false" location="verticalUp" /><div class="fncPanel info"><div class="title"><!-- GLOBAL --><system:edit show="ifValue" from="theBean" field="modeGlobal" value="true"><system:label show="text" label="mnuEstJer" /></system:edit><!-- ENVIRONMENT --><system:edit show="ifValue" from="theBean" field="modeGlobal" value="false"><system:label show="text" label="mnuEstJerAmb" /></system:edit><%@include file="../../includes/adminFav.jsp" %></div><div class="content divFncDescription"><div class="fncDescriptionImage" data-src="<system:edit show="value" from="theBean" field="fncImage"/>"></div><!-- GLOBAL --><system:edit show="ifValue" from="theBean" field="modeGlobal" value="true"><div id="fncDescriptionText"><system:label show="text" label="dscFncAdmEstJer"/></div></system:edit><!-- ENVIRONMENT --><system:edit show="ifValue" from="theBean" field="modeGlobal" value="false"><div id="fncDescriptionText"><system:label show="text" label="dscFncAdmEstJerAmb"/></div></system:edit><div class="clear"></div></div></div><!-- ENABLE --><system:edit show="ifValue" from="theBean" field="enable" value="true"><%@include file="../../includes/adminActionsEdition.jsp" %><div class="fncPanel buttons"><div class="title"><system:label show="text" label="mnuOpc" /></div><div class="content"><div id="btnAddGroup" class="button" title="<system:label show="tooltip" label="btnAgrGru" />"><system:label show="text" label="btnAgr" /></div><div id="btnDelGroup" class="button" title="<system:label show="tooltip" label="btnEli" />"><system:label show="text" label="btnEli" /></div><div id="btnDown" class="button" title="<system:label show="tooltip" label="btnDow" />"><system:label show="text" label="btnDow" /></div><div id="btnUp" class="button" title="<system:label show="tooltip" label="btnUpl" />"><system:label show="text" label="btnUpl" /></div></div></div></system:edit><system:campaign inLogin="false" inSplash="false" location="verticalDown" /></div><div class="dataContainer"><div class='tabComponent' id="tabComponent"><div class="aTabHeader"><system:campaign inLogin="false" inSplash="false" location="horizontalUp" /></div><div class="aTab"><div class="tab"><system:label show="text" label="sbtStruct"/></div><div class="contentTab"><div><!-- ENABLE --><system:edit show="ifValue" from="theBean" field="enable" value="true"><label style="float: right;"><input type="checkbox" id="btnShowUnits" style="position: relative; bottom: 2px; vertical-align: middle;"></input><span><system:label show="text" label="lblShowOrgUnits"/></span></label><div id="hierarchyDesignContainer"><div id="hierarchyDesign"><ol class="tree"></ol></div></div><input type="hidden" name="xmlTree" id="xmlTree" value=""></system:edit><!-- DISABLE --><system:edit show="ifValue" from="theBean" field="enable" value="false"><div class="fieldGroup" style="display: none;" id="msgNotEnable"><div class="fieldFull"><label class="label"><b><system:label show="text" label="lblEnvHieNotActive"/></b></label></div></div></system:edit></div></div></div></div><system:campaign inLogin="false" inSplash="false" location="horizontalDown" /></div></form></div><jsp:include page="../../includes/footer.jsp" /><!-- MODALS --><%@include file="../../modals/pools.jsp" %><%@include file="mdlInformation.jsp" %></body></html>


