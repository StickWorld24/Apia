<%@ taglib uri='regions' prefix='region'%>
<%@include file="../includes/startInc.jsp" %>
<html lang="<%=biz.statum.apia.web.bean.BasicBeanStatic.getUserDataStatic(request).getLangCode()%>">
<head>
	<!--
		Template de tarea. Oculta tabs, mostrando solo los formularios presentes en el primer tab. 
		Oculta nombre de proceso, tarea y botones de documentos.
		Centra los botones de acciones al final de la p?gina.
	 -->
	<%@include file="../includes/headInclude.jsp" %>
	<region:render section='scripts_include' />
	
	<style type="text/css">
		.tabHolder, #panelPinShow, .theFooter {
			display: none !important;
		}
		
		#frmData {
			display: block;
		}
		div.body {
			height: auto;
		}
		
		div.dataContainer {
			position: relative;
		}
		
		.actions .title {
			display: none;
		}
		
		.actions .button {
			display: block !important;
			width: 95px;
			margin: auto !important;
		}
		div.fncPanel div.stepsGraph {
			float: none !important;
			margin: auto !important;
			display: table;
		}
		div.fncPanel div.stepsGraph > div {
/* 			float: none; */
		}
	</style>
	<script type="text/javascript">
		window.addEvent('load', function() {		
			var frmData = $('frmData');
			
			frmData.addClass('autoHideActions');
			frmData.getElement('div.dataContainer').addClass('max-size');
			window.fireEvent('resize');
		})
	</script>
</head>
<body>
	<div id="exec-blocker"></div>
	<div class="body" id="bodyDiv">
		<form id="frmData" action="dummy" method="post">
			<input type='submit' style='display:none' value='submit' disabled>
			<div class="dataContainer">
				<div class='tabComponent' id="tabComponent">
					<div class="aTabHeader"><system:campaign inLogin="false" inSplash="false" location="horizontalUp" /></div>
					<div class='aTab'>
						<div class='tab'><system:label show="text" label="tabEjeFor"/></div>
						<div class='contentTab'>
							<region:render section='entityForms' />
							<region:render section='processForms' />
						</div>
					</div>

				</div>
				<system:campaign inLogin="false" inSplash="false" location="horizontalDown" />
		 	</div>	
		</form>
		<div style="display:none" id="divDragDropForm"></div>
	</div>
	<div class="actions">
		<region:render section='buttons' />
				
		<region:render section='apiaSocial' />
	</div>
	<%@include file="../includes/footer.jsp" %>
	<%@include file="../modals/documents.jsp" %>
	<%@include file="../modals/calendarsView.jsp" %>
	<%@include file="../social/socialShareMdl.jsp" %>
	<%@include file="../social/socialReadChannelMdl.jsp" %>
	<%@include file="../execution/includes/endInclude.jsp" %>
	
	<region:render section='signature' />
</body>

</html>
