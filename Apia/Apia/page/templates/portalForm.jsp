<%@page import="com.dogma.vo.LanguageVo"%>
<%@page import="com.dogma.Parameters"%>


<%@ taglib uri='regions' prefix='region'%>
<%@include file="../includes/startInc.jsp"%>
<html
	lang="<%=biz.statum.apia.web.bean.BasicBeanStatic.getUserDataStatic(request).getLangCode()%>">
<head>


<script type="text/javascript">
var URL_APP = "<%=Configuration.ROOT_PATH%>";
var divsInsteadOfTable = true;
var ERROR_NUMBER = '<system:label show="text" label="lblErrorNum"/>';			
var BTN_ANTERIOR = '<system:label show="text" label="btnAnt"/>';
var BTN_SIGUIENTE = '<system:label show="text" label="btnSig"/>';
</script>
<%request.setAttribute("mode", "portal");%>
<%@include file="../includes/headInclude.jsp"%>
<region:render section='scripts_include' />


<system:util show="basePortalFormStyles" />

	
<script type="text/javascript"	src="<%=Configuration.ROOT_PATH%>/page/templates/portalForm.js"></script>

<script type="text/javascript">
	
<%	Collection<LanguageVo> langs = null;
	Object tskLangs = request.getAttribute("tskTradLang");
	if (tskLangs != null)
		langs = (Collection<LanguageVo>) tskLangs;

	out.write("var DOC_LANGS		= {");
	if (langs != null) {
		String str_langs = "";
		for (LanguageVo lang : langs) {
			if (str_langs.length() > 0)
				str_langs += ", " + lang.getLangId() + ": '" + lang.getLangName() + "'";
			else
				str_langs += lang.getLangId() + ": '" + lang.getLangName() + "'";
		}
		out.write(str_langs + "};");
	} else {
		out.write("};");
	}
%>
	
</script>
</head>
<body id="paginaPortal">

	<div id="div-nav-error"></div>
	<div class="body" id="bodyDiv">
	<div id="titleContainer">
		<div class="titleContainer">
		<region:render section='title' />
		</div>
	</div>
	<div id="progressStepBar" class="pBarContainer" tabindex="-1"></div>
		<form id="frmData" action="dummy" method="post">
			<input type='submit' style='display:none' value='submit' disabled>
			<div class="dataContainer">
				<div class='tabComponent' id="tabComponent">

					<div class="aTabHeader">
						<system:campaign inLogin="false" inSplash="false"
							location="horizontalUp" />
					</div>
					<div class="fncPanel info" style='display: none'>

						<div class="title">
							<span class="title"><region:render section='title' /></span>
						</div>

						<div class="content divFncDescription" style="position: relative;">
							<div class="fncDescriptionImgSection">
								<region:render section='taskImage' />
							</div>
							<div class="descInfo">
								<div class="title" style="font-weight: bold;"></div>
								<div class="fncDescriptionText" id="fncDescriptionText"></div>
							</div>
							<div class="clear"></div>
						</div>

						<region:render section='apiaSocial' />
					</div>

					<div class='aTab'>
						<div class='tab' style="display: none">
							<system:label show="text" label="tabEjeFor" />
						</div>
						<div class='contentTab'>
							<region:render section='entityForms' />
							<region:render section='processForms' />
						</div>
					</div>
					<div class='bottom fncPanel' id="btnPanel">
						<div class="float-right-buttons">
							<region:render section='buttons' />
						</div>
					</div>
				<system:campaign inLogin="false" inSplash="false" location="horizontalDown" />
				</div>

			</div>

		</form>
	</div>
	<div style="display: none" id="divDragDropForm"></div>

	<%@include file="../modals/documents.jsp"%>
	<%@include file="../modals/calendarsView.jsp"%>
	<%@include file="../social/socialShareMdl.jsp"%>
	<%@include file="../social/socialReadChannelMdl.jsp"%>
	<%@include file="../execution/includes/endInclude.jsp"%>

	<region:render section='signature' />

	<div class="div_ayuda" id="div_ayuda"></div>

</body>

</html>