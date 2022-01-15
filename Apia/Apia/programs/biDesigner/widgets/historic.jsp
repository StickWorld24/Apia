<DIV class="subTit"><%=LabelManager.getName(labelSet,"sbtHistoric")%></DIV><table width="100%" class="tblFormLayout"><tr><td align="right" title="<%=LabelManager.getToolTip(labelSet,"lblChartType")%>"><%=LabelManager.getName(labelSet,"lblChartType")%>:</td><td align="left"><select name="cmbChartType" id="cmbChartType" style="width:120px" accesskey="<%=LabelManager.getAccessKey(labelSet,"lblChartType")%>"><option value="<%=ChartDataVo.GRAPH_TYPE_LINES%>" <%=(widVo != null && widVo.getWidHisChrtType() != null && ChartDataVo.GRAPH_TYPE_LINES.equals(widVo.getWidHisChrtType()))?"selected":""%>><%=LabelManager.getName(labelSet,"txtLineType")%></option><option value="<%=ChartDataVo.GRAPH_TYPE_V_COLUMN_2D%>" <%=(widVo != null && widVo.getWidHisChrtType() != null && ChartDataVo.GRAPH_TYPE_V_COLUMN_2D.equals(widVo.getWidHisChrtType()))?"selected":""%>><%=LabelManager.getName(labelSet,"txtBarVerType")%></option></select></td><td></td><td></td><td></td><td></td></tr><tr><td align="right" title="<%=LabelManager.getToolTip(labelSet,"lblChartColor")%>"><%=LabelManager.getName(labelSet,"lblChartColor")%>:</td><td align="left"><input type="input" name="txtHistColor" id="txtHistColor" style="width:60px" class="txtReadonly" readonly value="<%=(widVo!=null && widVo.getWidHisChrtColor()!=null)?widVo.getWidHisChrtColor():"#0044EB"%>" /><a href="#" onclick="colorPicker(this)"><img width="15" height="13" border="0" src="<%=Parameters.ROOT_PATH%>/styles/<%= styleDirectory %>/images/palette.gif"></a><input maxlength="0" type="text" size="2" style="width:60px;background-color:<%=(widVo!=null && widVo.getWidHisChrtColor()!=null)?widVo.getWidHisChrtColor():"#0044EB"%>;"></input></td><td></td><td></td><td></td><td></td></tr></table><DIV class="subTit"><%=LabelManager.getName(labelSet,"sbtMetas")%></DIV><br><table width="100%" class="tblFormLayout"><tr><td align="right" title="<%=LabelManager.getToolTip(labelSet,"lblWidMetaHelp")%>"><%=LabelManager.getName(labelSet,"lblViewMeta")%>:</td><td align="left"><input name="chkSeeMeta" title="<%=LabelManager.getToolTip(labelSet,"lblWidMetaHelp")%>" type="checkbox" onclick="chkSeeMetaClk()" <%=(widVo.getWidViewMeta()!=null && widVo.getWidViewMeta().intValue()==1)?"checked":""%>></input></td></tr><tr><td align="right" title="<%=LabelManager.getToolTip(labelSet,"lblChartColor")%>"><%=LabelManager.getName(labelSet,"lblChartColor")%>:</td><td align="left"><input type="input" name="txtMetaColor" id="txtMetaColor" style="width:60px" class="txtReadonly" readonly value="<%=(widVo!=null && widVo.getWidHisMetaColor()!=null)?widVo.getWidHisMetaColor():"#FF0000"%>" /><a href="#" onclick="colorPicker(this)" id="colorMetaPicker"><img width="15" height="13" border="0" src="<%=Parameters.ROOT_PATH%>/styles/<%= styleDirectory %>/images/palette.gif"></a><input maxlength="0" type="text" size="2" style="width:60px;background-color:<%=(widVo!=null && widVo.getWidHisMetaColor()!=null)?widVo.getWidHisMetaColor():"#FF0000"%>;"></input></td><td></td><td></td><td></td><td></td></tr><tr><td align="right" title="<%=LabelManager.getToolTip(labelSet,"lblWidMetaTable")%>"><%=LabelManager.getName(labelSet,"lblWidMetaTable")%>:</td><td align="left"><input name="widMetaTable" id="widMetaTable" maxlength="50" <%=(widVo.getWidViewMeta()==null || widVo.getWidViewMeta().intValue()==0)?"disabled":"p_required='true'"%> value="<%=(widVo.getMetaTableName()!=null)?widVo.getMetaTableName():""%>"></td><td></td><td></td><td></td><td></td></tr><tr><td align="right" title="<%=LabelManager.getToolTip(labelSet,"lblWidMetaValCol")%>"><%=LabelManager.getName(labelSet,"lblWidMetaValCol")%>:</td><td align="left"><input name="widMetaColumn" id="widMetaColumn" maxlength="50" <%=(widVo.getWidViewMeta()==null || widVo.getWidViewMeta().intValue()==0)?"disabled":"p_required='true'"%> value="<%=(widVo.getMetaColValue()!=null)?widVo.getMetaColValue():""%>"></td><td></td><td></td><td></td><td></td></tr><tr><td align="right" title="<%=LabelManager.getToolTip(labelSet,"lblWidMetaDteCol")%>"><%=LabelManager.getName(labelSet,"lblWidMetaDteCol")%>:</td><td align="left"><input name="widMetaDteColumn" id="widMetaDteColumn" maxlength="50" <%=(widVo.getWidViewMeta()==null || widVo.getWidViewMeta().intValue()==0)?"disabled":"p_required='true'"%> value="<%=(widVo.getMetaColDte()!=null)?widVo.getMetaColDte():""%>"></td><td></td><td></td><td></td><td></td></tr><tr><td align="right" title="<%=LabelManager.getToolTip(labelSet,"lblWidMetaCondition")%>"><%=LabelManager.getName(labelSet,"lblWidMetaCondition")%>:</td><td align="left" colspan=4><input style="width:370px" name="widMetaCondition" id="widMetaCondition" maxlength="255" <%=(widVo.getWidViewMeta()==null || widVo.getWidViewMeta().intValue()==0)?"disabled":""%> value="<%=(widVo.getMetaCondition()!=null)?widVo.getMetaCondition():""%>"></td></tr><tr><td align="right" title="<%=LabelManager.getToolTip(labelSet,"lblWidMetaMultiplier")%>"><%=LabelManager.getName(labelSet,"lblWidMetaMultiplier")%>:</td><td align="left"><input name="widMetaMultiplier" p_numeric="true" id="widMetaMultiplier" maxlength="5" <%=(widVo.getWidViewMeta()==null || widVo.getWidViewMeta().intValue()==0)?"disabled":"p_required='true'"%> value="<%=(widVo.getMetaMultiplier()!=null)?widVo.getMetaMultiplier():""%>"></td><td></td><td></td><td></td><td></td></tr><tr><td align="right" title="<%=LabelManager.getToolTip(labelSet,"lblMetaBy")%>"><%=LabelManager.getName(labelSet,"lblMetaBy")%>:</td><td align="left"><input name="chkMetaByYear" type="checkbox" <%=(widVo!=null && widVo.isMetaByYear())?"checked":""%><%=(widVo==null || widVo.getWidViewMeta()==null || widVo.getWidViewMeta().intValue() == 0)?"disabled":""%>><%=LabelManager.getName(labelSet,"lblYear")%></input><input name="chkMetaByMonth" type="checkbox" <%=(widVo!=null && widVo.isMetaByMonth())?"checked":""%><%=(widVo==null || widVo.getWidViewMeta()==null || widVo.getWidViewMeta().intValue() == 0)?"disabled":""%>><%=LabelManager.getName(labelSet,"lblMonth")%></input><input name="chkMetaByDay" type="checkbox" <%=(widVo!=null && widVo.isMetaByDay())?"checked":""%><%=(widVo==null || widVo.getWidViewMeta()==null || widVo.getWidViewMeta().intValue() == 0)?"disabled":""%>><%=LabelManager.getName(labelSet,"lblBIDay")%></input></td><td></td><td></td><td></td><td></td></tr></table>