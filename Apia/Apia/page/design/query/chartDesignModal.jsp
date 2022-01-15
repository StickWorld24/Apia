<%@include file="../../includes/startInc.jsp" %><html lang="<%=biz.statum.apia.web.bean.BasicBeanStatic.getUserDataStatic(request).getLangCode()%>"><head><%@include file="../../includes/headInclude.jsp" %><script type="text/javascript" src="<system:util show="context" />/page/design/query/chartDesignModal.js"></script><script type="text/javascript">
	
		var BAR_VER_TYPE_ID		= '<system:edit show="constant" from="com.dogma.vo.QryChartVo" field="TYPEBARVERT" />';
		var BAR_HOR_TYPE_ID		= '<system:edit show="constant" from="com.dogma.vo.QryChartVo" field="TYPEBARHOR" />';
		var LINE_TYPE_ID		= '<system:edit show="constant" from="com.dogma.vo.QryChartVo" field="TYPELINES" />';
		var WFALL_TYPE_ID		= '<system:edit show="constant" from="com.dogma.vo.QryChartVo" field="TYPEWATERFALL" />';
		var PIE_TYPE_ID			= '<system:edit show="constant" from="com.dogma.vo.QryChartVo" field="PIE" />';

		//Definicion de subtipos
		var b2D_SUBTYPE			= '<system:label show="text" label="txt2DSubType" forScript="true" />';
		var b3D_SUBTYPE			= '<system:label show="text" label="txt3DSubType" forScript="true" />';
		
		var CATEGORIA			= '<system:label show="text" label="lblCateg" forScript="true" />';
		var AXE_X				= '<system:label show="text" label="lblEjeX" forScript="true" />';
		
		var b2D_SUBTYPE_ID		= '<system:edit show="constant" from="com.dogma.vo.QryChartVo" field="SUBTYPE2D" />';
		var b3D_SUBTYPE_ID		= '<system:edit show="constant" from="com.dogma.vo.QryChartVo" field="SUBTYPE3D" />';
		
		var chartId = '<%=request.getParameter("id")%>';
		var isInDB = '<%=request.getParameter("isInDB")%>';
		
		var PALETTE = "<system:util show="context" />/css/base/img/palette.gif";
		
		var MSG_ENT_CHT_TITLE = '<system:label show="text" label="msgEntChtTitle" forScript="true" />';
		var MSG_SEL_SOME_SERIE = '<system:label show="text" label="msgNoSeries" forScript="true" />';
	</script></head><body style="overflow: hidden;"><div class="body" id="bodyDiv" style="padding-left: 20px; padding-right: 20px;"><form id="frmChartDesign" name="frmChartDesign"><div class="fieldGroup"><div class="title" style="margin-top: "><system:label show="text" label="sbtChtType" /></div><div class="field"><label title="<system:label show="tooltip" label="lblType" />" for="chtType"><system:label show="text" label="lblType" />:&nbsp;</label><select name="chtType" id="chtType" onchange="chtTypeChange()"><option value="0"><system:label show="text" label="txtBarVerType" /></option><option value="1"><system:label show="text" label="txtBarHorType" /></option><option value="2"><system:label show="text" label="txtLineType" /></option><option value="3"><system:label show="text" label="txtWFallType" /></option><option value="4"><system:label show="text" label="txtPieType" /></option></select><input type='hidden' id="chartId" value="" /><input type='hidden' id="chartIsInDB" value="" /></div><div class="field"><label title="<system:label show="tooltip" label="lblSubType" />" for="chtSubType"><system:label show="text" label="lblSubType" />:&nbsp;</label><select name="chtSubType" id="chtSubType" onchange="chtSubTypeChange()"><option value="1"><system:label show="text" label="txt2DSubType" /></option><option value="2"><system:label show="text" label="txt3DSubType" /></option></select></div><div class="clearLeft"></div><div class="title" style="margin-top: 5px"><system:label show="text" label="sbtChtDefinition" /></div><div class="fieldGroup split" style='width: 55%; vertical-align:top'><div class="field"><label title="<system:label show="tooltip" label="lblTit" />" for="chtTitle"><system:label show="text" label="lblTit" />:&nbsp;</label><input name="chtTitle" id="chtTitle" value="" class="validation['required']" /></div><div class="field" id="divColors"><label title="<system:label show="tooltip" label="lblSchColors" />" for="chtColors"><system:label show="text" label="lblSchColors" />:&nbsp;</label><select name="chtColors" id="chtColors" onchange="lockColorSelect()" class="validation['required']"></select></div><div class="field" id="divTitY"><label id="lblTitY" title="<system:label show="tooltip" label="lblTitY" />" for="chtTitleY"><system:label show="text" label="lblTitY" />:&nbsp;</label><input name="chtTitleY" id="chtTitleY" value="" /></div><div class="clearLeft"></div><div class="field" id="divColX"><label title="<system:label show="tooltip" label="lblEjeX" />" id="labelX" for="chtColX"><system:label show="text" label="lblEjeX" />:&nbsp;</label><select name="chtColX" id="chtColX" onchange="lockSerie()"></select></div><div class="field" id="divTitX"><label id="lblTitX" title="<system:label show="tooltip" label="lblTitX" />" for="chtTitleX"><system:label show="text" label="lblTitX" />:&nbsp;</label><input type="text" name="chtTitleX" id="chtTitleX" /></div><br/><div id="divPrps"><label style="color:#333333;" title="<system:label show="tooltip" label="lblViewLegend" />" for="chkLegend" class="label"><system:label show="text" label="lblViewLegend" />:&nbsp;									
							<input type="checkboX" name="chkLegend" id="chkLegend" onclick="showChart()" checked/></label><label style="color:#333333;" title="<system:label show="tooltip" label="lblViewValues" />" for="chkValues" class="label"><system:label show="text" label="lblViewValues" />:&nbsp;									
							<input type="checkboX" name="chkValues" id="chkValues" onclick="showChart()" checked/></label><label id="lblGrid" style="color:#333333;" title="<system:label show="tooltip" label="lblViewGrid" />" for="chkGrid" class="label"><system:label show="text" label="lblViewGrid" />:&nbsp;									
							<input type="checkboX" name="chkGrid" id="chkGrid" onclick="showChart()" checked /></label></div><div id="divMorePrps"><label style="color:#333333;" title="<system:label show="tooltip" label="lblViewYLabels" />" for="chkYLabels" class="label"><system:label show="text" label="lblViewYLabels" />:&nbsp;									
							<input type="checkboX" name="chkYLabels" id="chkYLabels" onclick="showChart()" checked/></label><label style="color:#333333;" title="<system:label show="tooltip" label="lblViewXLabels" />" for="chkXLabels" class="label"><system:label show="text" label="lblViewXLabels" />:&nbsp;									
							<input type="checkboX" name="chkXLabels" id="chkXLabels" onclick="showChart()" checked/></label></div></div><div class="fieldGroup split" style='width:48%; margin-bottom: 0px'><div class="field"><iframe id="ifrChartSample" width="350px" height="260px" frameborder="0" src="" style="overflow:hidden;position:absolute;top:85px;left:430px;"></iframe></div></div><div class="clearLeft"></div><br/><br/><br/><br/><div class="title"><system:label show="text" label="sbtChtSeries" /></div><div class="gridHeader" style="background-image: none"><table id="tblSeries" width="100%"><thead><tr class="header"><th title="<system:label show="tooltip" label="lblNom" />" width="400px"><system:label show="text" label="lblNom" /></th><th title="<system:label show="tooltip" label="lblColor" />" width="200px"><system:label show="text" label="lblColor" /></th><th title="<system:label show="tooltip" label="lblShow" />" width="50px"><system:label show="text" label="lblShow" /></th></tr></thead></table></div><div class="gridBody" style="background-image: none; height:170px;"><table id="tblSeries" width="100%"><thead><tr class="header"><th title="<system:label show="tooltip" label="lblNom" />" width="400px"><system:label show="text" label="lblNom" /></th><th title="<system:label show="tooltip" label="lblColor" />" width="200px"><system:label show="text" label="lblColor" /></th><th title="<system:label show="tooltip" label="lblShow" />" width="50px"><system:label show="text" label="lblShow" /></th></tr></thead><tbody class="tableData" id="bodySeries" style='min-height:200px'></tbody></table></div><div class="gridFooter" ><div class="listActionButtons" id="gridFooterSeries"><div class="listUpDown"><div class="btnUp navButton" id="btnUpSeries" ><system:label show="text" label="btnUp" /></div><div class="actSeparator">&nbsp;&nbsp;&nbsp;</div><div class="btnDown navButton" id="btnDownSeries" ><system:label show="text" label="btnDown" /></div></div></div></div></div></form></div></body>