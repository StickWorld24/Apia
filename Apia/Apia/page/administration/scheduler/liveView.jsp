<%@include file="../../includes/startInc.jsp" %><html lang="<%=biz.statum.apia.web.bean.BasicBeanStatic.getUserDataStatic(request).getLangCode()%>"><head><%@include file="../../includes/headInclude.jsp" %><script type="text/javascript" src="<system:util show="context" />/page/administration/scheduler/liveView.js"></script><script type="text/javascript" src="<system:util show="context" />/page/includes/adminFav.js"></script><script type="text/javascript" src="<system:util show="context" />/page/includes/adminActions.js"></script><script type="text/javascript" src="<system:util show="context" />/page/includes/navButtons.js"></script><script type="text/javascript" src="<system:util show="context" />/page/includes/campaigns.js"></script><script type="text/javascript">
			var URL_REQUEST_AJAX = '/apia.administration.SchedulerAction.run';
			var ADDITIONAL_INFO_IN_TABLE_DATA  = true;
		</script></head><body><div class="body" id="bodyDiv"><div class="optionsContainer"><system:campaign inLogin="false" inSplash="false" location="verticalUp" /><div class="fncPanel info"><div class="title"><system:label show="text" label="mnuSchAmb" /><%@include file="../../includes/adminFav.jsp" %></div><div class="content divFncDescription"><div class="fncDescriptionImage" data-src="<system:edit show="value" from="theBean" field="fncImage"/>"></div><div id="fncDescriptionText"><system:label show="text" label="dscFncSch"/></div><div class="clear"></div></div></div><div class="fncPanel options"><div class="title"><system:label show="text" label="titActions"/></div><div class="content"><div id="btnBinding" class="button" title="<system:label show="tooltip" label="btnViewBinding" />"><system:label show="text" label="btnViewBinding" /></div><div id="btnBackToList" class="button suggestedAction" title="<system:label show="tooltip" label="btnVol" />"><system:label show="text" label="btnVol" /></div><div id="btnCloseTab" class="button" title="<system:label show="tooltip" label="btnClose" />"><system:label show="text" label="btnClose" /></div></div></div><div class="fncPanel options lastOptions"><div class="title"><system:label show="text" label="mnuOpc"/></div><div class="content"><div class="filter"><span><system:label show="text" label="lblSchKeepEndedFor"/>:</span><select id="keepEndedFor"><option value="1" selected>1 min</option><option value="5">5 min</option><option value="10">10 min</option><option value="30">30 min</option></select></div><div class="filter"><span><system:label show="text" label="lblSchRefresh"/>:</span><select id="refreshEvery"><option value="1" selected>1 sec</option><option value="5">5 sec</option><option value="10">10 sec</option><option value="30">30 sec</option><option value="60">60 sec</option></select></div></div><div class="clear"></div></div><system:campaign inLogin="false" inSplash="false" location="verticalDown" /></div><div class="gridContainer"><system:campaign inLogin="false" inSplash="false" location="horizontalUp" /><div class="gridHeader" id="gridHeader"><table><thead><tr id="trOrderBy" class="header"><th id="" title="<system:label show="tooltip" label="lblName" />"><div style="width: 220px"><system:label show="text" label="lblName" /></div></th><th id="" title="<system:label show="tooltip" label="lblCla" />"><div style="width: 220px"><system:label show="text" label="lblCla" /></div></th><th id="" title="<system:label show="tooltip" label="lblSchStart" />"><div style="width: 100px"><system:label show="text" label="lblSchStart" /></div></th><th id="" title="<system:label show="tooltip" label="lblSchEnd" />"><div style="width: 100px"><system:label show="text" label="lblSchEnd" /></div></th><th id="" title="<system:label show="tooltip" label="lblSchNext" />"><div style="width: 100px"><system:label show="text" label="lblSchNext" /></div></th><th id="" title="<system:label show="tooltip" label="lblSchPorc" />"><div style="width: 100px"><system:label show="text" label="lblSchPorc" /></div></th></tr></thead></table></div><div class="gridBody" id="gridBody"><!-- Cuerpo de la tabla --><table><thead><tr><th width="220px"></th><th width="220px"></th><th width="100px"></th><th width="100px"></th><th width="100px"></th><th width="100px"></th></tr></thead><tbody class="tableData" id="tableData"></tbody></table></div><system:campaign inLogin="false" inSplash="false" location="horizontalDown" /></div></div><%@include file="../../includes/footer.jsp" %></body></html>