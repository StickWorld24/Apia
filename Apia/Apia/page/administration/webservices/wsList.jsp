<%@include file="../../includes/startInc.jsp" %><html lang="<%=biz.statum.apia.web.bean.BasicBeanStatic.getUserDataStatic(request).getLangCode()%>"><head><%@include file="../../includes/headInclude.jsp" %><script type="text/javascript" src="<system:util show="context" />/page/administration/webservices/wsList.js"></script><script type="text/javascript" src="<system:util show="context" />/page/includes/adminFav.js"></script><script type="text/javascript" src="<system:util show="context" />/page/includes/campaigns.js"></script><script type="text/javascript">
			var URL_REQUEST_AJAX	= '/apia.administration.WebServicesAction.run';
			var TOOLTIP_WS_PROC 	= '<system:label show="text" label="lblWsPro" forScript="true" />'; 
			var TOOLTIP_WS_TSK 		= '<system:label show="text" label="lblWsTsk" forScript="true" />';
			var TOOLTIP_PUB_UNPUB	= '<system:label show="text" label="btnPub" forScript="true" />' + '/' + '<system:label show="text" label="btnUnPub" forScript="true" />';
			var TOOLTIP_USERS 		= '<system:label show="text" label="titUsu" forScript="true" />';
			var NO_EXIST_WS_CAT		= '<system:label show="text" label="msgNoWSCat" forScript="true" />';
		</script></head><body><div class="body" id="bodyDiv"><form id="frmData"><div class="optionsContainer"><system:campaign inLogin="false" inSplash="false" location="verticalUp" /><div class="fncPanel info"><div class="title"><system:label show="text" label="mnuWs" /><%@include file="../../includes/adminFav.jsp" %></div><div class="content divFncDescription"><div class="fncDescriptionImage" data-src="<system:edit show="value" from="theBean" field="fncImage"/>"></div><div id="fncDescriptionText"><system:label show="text" label="dscFncAdmWs"/></div><div class="clear"></div></div></div><div class="fncPanel buttons" id="panelOptionsTabGenData"><div class="title"><system:label show="text" label="mnuOpc" /></div><div class="content"><div id="btnUpdate" class="button suggestedAction" title="<system:label show="tooltip" label="btnAct" />"><system:label show="text" label="btnAct" /></div><div id="btnCloseTab" class="button" title="<system:label show="tooltip" label="btnClose" />"><system:label show="text" label="btnClose" /></div></div></div><system:campaign inLogin="false" inSplash="false" location="verticalDown" /></div><div class="dataContainer"><div class='tabComponent' id="tabComponent"><div class="aTabHeader"><system:campaign inLogin="false" inSplash="false" location="horizontalUp" /></div><div class="aTab"><div class="tab"><system:label show="text" label="tabDatGen" /></div><div class="contentTab"><!-- WS : PROCCESS --><div class="fieldGroup"><div class="title"><system:label show="text" label="sbtWs" /></div><div class="modalOptionsContainer" id="WSProcessContainter" style="min-height: 30px;"></div><div class="clear"></div></div><!-- WS : BUSCLASS --><div class="fieldGroup"><div class="title"><system:label show="text" label="sbtBusClaWs" /></div><div class="modalOptionsContainer" id="WSBusClassContainter" style="min-height: 30px;"></div><div class="clear"></div></div><!-- WS : QUERY --><div class="fieldGroup"><div class="title"><system:label show="text" label="sbtQryWs" /></div><div class="modalOptionsContainer" id="WSQueryContainter" style="min-height: 30px;"></div><div class="clear"></div></div><!-- WS : DELETED --><div class="fieldGroup"><div class="title"><system:label show="text" label="sbtDelWs" /></div><div class="modalOptionsContainer" id="WSDeletedContainter" style="min-height: 30px;"><div id="WSDeletedContainterIn"></div><div class="option" id="unpubAll" data-helper="true" title="<system:label show="text" label="btnUnPubAll" />" style="display: none;"><span><system:label show="text" label="btnUnPubAll" /></span><div id="unpubAll" class="optionIcon optionUnPublishAll"></div></div></div></div><div class="clear"></div></div></div></div><system:campaign inLogin="false" inSplash="false" location="horizontalDown" /></div></form></div><jsp:include page="../../includes/footer.jsp" /></body></html>
