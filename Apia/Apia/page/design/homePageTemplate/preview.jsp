<script type="text/javascript">
	var MSG_DAT_REQ 		= '<system:label show="text" label="ApiaWS14" forScript="true" />';
	var MSG_EXIST_HPT_NAME	= '<system:label show='text' label='msgHPTExi' forScript="true" />';
	var MSG_ERR				= '<system:label show="text" label="msgHPTErr" forScript="true" />';	
</script><link href="<system:util show="context" />/css/base/pages/splash/splashLayout.css" rel="stylesheet" type="text/css" /><system:util show="baseStyles" /><system:edit show="ifModalNotLoaded" field="homeTemplate.jsp"><system:edit show="markModalAsLoaded" field="homeTemplate.jsp" /><div id="mdlHomeTemplateContainer" class="mdlContainer hiddenModal"><div class="mdlHeader"><system:label show="text" label="sbtPreView" /></div><div class="mdlBody" id="mdlBodyHT"><!-- DATOS GENERALES --><div class="fieldGroup"><div class="field" id="divName"><label title="<system:label show="tooltip" label="lblNom" />"><system:label show="text" label="lblNom" />:&nbsp;</label><br><span id="htName"></span></div><div class="field extendedSize" id="divDesc"><label title="<system:label show="tooltip" label="lblDesc" />"><system:label show="text" label="lblDesc" />:&nbsp;</label><br><span id="htDesc"></span></div></div><!-- PREVISUALIZACION --><div class="fieldGroup" id="divPreview" ><div class="field fieldFull"><div class="templateViewMdl splashLayout splashPreview" id="divTemplateView" style="margin-left: 12%"><iframe id="tempHtml"   style="width: 350px; height: 220px;" ></iframe></div></div></div></div><div class="mdlFooter"><div class="close" id="closeHomeTemplateModal" title="<system:label show="text" label="btnCer" />"><system:label show="text" label="btnCer" /></div></div></div></system:edit>