<div class="aTab"><div class="tab" id="tabHistoric"><system:label show="text" label="tabWidHistoric" /></div><div class="contentTab"><div class="fieldGroup" style="height:240px;"><div class="title"><system:label show="text" label="sbtHistoric" /></div><div class="fieldGroup" style="position: relative;"><div class="field"><label title="<system:label show="tooltip" label="lblChartType" />"><system:label show="text" label="lblChartType" />:</label><select name="cmbChartType" id="cmbChartType" ><option value="<system:edit show="constant" from="com.dogma.vo.custom.charts.ChartDataVo" field="GRAPH_TYPE_LINES" saveOn="constantValue" />" <system:edit show="ifValue" from="theEdition" field="widHisChrtType" value="with:constantValue">selected</system:edit>><system:label show="text" label="txtLineType" /></option><option value="<system:edit show="constant" from="com.dogma.vo.custom.charts.ChartDataVo" field="GRAPH_TYPE_V_COLUMN_2D" saveOn="constantValue" />" <system:edit show="ifValue" from="theEdition" field="widHisChrtType" value="with:constantValue">selected</system:edit>><system:label show="text" label="txtBarVerType2D" /></option><option value="<system:edit show="constant" from="com.dogma.vo.custom.charts.ChartDataVo" field="GRAPH_TYPE_V_COLUMN_3D" saveOn="constantValue" />" <system:edit show="ifValue" from="theEdition" field="widHisChrtType" value="with:constantValue">selected</system:edit>><system:label show="text" label="txtBarVerType3D" /></option></select></br></div><div class="fieldGroup"><div class="field" img_target="historyLine1,historyLine2"><label title="<system:label show="tooltip" label="lblChartColor" />"><system:label show="text" label="lblChartColor" />:</label><div class="colorPicker"><input class="colorPickerHex" size="13" type="text" name="histColNumber" id="histColNumber" value="<system:edit show="value" from="theEdition" field="widHisChrtColor"/>"></input><img id="histColImg" width="14" height="14" src="<system:util show="context" />/css/base/img/palette.gif" style="cursor: pointer;"><input class="colorPickerCol" name="histColColor" id="histColColor" type="text" value="" readonly ></div></div></div><div id="historyLine1" style="position: absolute; right: 35px; top: 50px; width: 175px; height: 174px"><img src= "<system:util show="context" />/css/base/img/dashboard/historyChart.png"/></div></div><div class="fieldGroup" style=""><div class="field"><label title="<system:label show="tooltip" label="lblViewLast" />"><system:label show="text" label="lblViewLast" />:</label><select name="cmbVwLast" id="cmbVwLast" style="width:80%"><option value="10" <system:edit show="ifValue" from="theEdition" field="widVwCant" value="10">selected</system:edit>>10</option><option value="20" <system:edit show="ifValue" from="theEdition" field="widVwCant" value="20">selected</system:edit>>20</option><option value="40" <system:edit show="ifValue" from="theEdition" field="widVwCant" value="50">selected</system:edit>>50</option><option value="100" <system:edit show="ifValue" from="theEdition" field="widVwCant" value="100">selected</system:edit>>100</option></select></div><div class="field"><label title="<system:label show="tooltip" label="lblStoreLast" />"><system:label show="text" label="lblStoreLast" />:</label><select name="cmbStoreLast" id="cmbStoreLast" style="width:80%"><option value="10" <system:edit show="ifValue" from="theEdition" field="widStoCant" value="10">selected</system:edit>>10</option><option value="20" <system:edit show="ifValue" from="theEdition" field="widStoCant" value="20">selected</system:edit>>20</option><option value="50" <system:edit show="ifValue" from="theEdition" field="widStoCant" value="50">selected</system:edit>>50</option><option value="100" <system:edit show="ifValue" from="theEdition" field="widStoCant" value="100">selected</system:edit>>100</option><option value="500" <system:edit show="ifValue" from="theEdition" field="widStoCant" value="500">selected</system:edit>>500</option><option value="1000" <system:edit show="ifValue" from="theEdition" field="widStoCant" value="1000">selected</system:edit>>1000</option></select></div></div></div><div class="fieldGroup" style="height:130px; position:relative;"><div class="title"><system:label show="text" label="sbtMetas" /></div><div class="field oneLineChbox extendedSize"><label for="chkSeeMeta" title="<system:label show="tooltip" label="lblViewMeta" />"><system:label show="text" label="lblViewMeta" />:</label><input class="text-aligned" type="checkbox" id="chkSeeMeta" name="chkSeeMeta"></input></div></br></br><div class="fieldGroup" id="divMetaValues"><!--  style="display:none" --><div class="fieldGroup"><div class="field" img_target="metaLine"><label title="<system:label show="tooltip" label="lblChartColor" />"><system:label show="text" label="lblChartColor" />:</label><div class="colorPicker"><input class="colorPickerHex" size="13" type="text" name="metaColNumber" id="metaColNumber" value="<system:edit show="value" from="theEdition" field="widHisMetaColor"/>"></input><img id="metaColImg" width="14" height="14" src="<system:util show="context" />/css/base/img/palette.gif" style="cursor: pointer;"><input class="colorPickerCol" name="metaColColor" id="metaColColor" type="text" value="" readonly ></div></div></div><div class="fieldGroup"><div class="field required"><!-- TABLA DE METAS --><label style="width:100px" title="<system:label show="tooltip" label="lblWidMetaTable" />"><system:label show="text" label="lblWidMetaTable" />:</label><input type="text" name="widMetaTable" id="widMetaTable" value="<system:edit show="value" from="theEdition" field="metaTableName"/>"></div><div class="field required"><!-- COLUMNA DE METAS --><label title="<system:label show="tooltip" label="lblWidMetaValCol" />"><system:label show="text" label="lblWidMetaValCol" />:</label><input type="text" name="widMetaColumn" id="widMetaColumn" value="<system:edit show="value" from="theEdition" field="metaColValue"/>"></div><div class="field required"><!-- COLUMNA DE FECHA --><label title="<system:label show="tooltip" label="lblWidMetaDteCol" />"><system:label show="text" label="lblWidMetaDteCol" />:</label><input type="text" name="widMetaDteColumn" id="widMetaDteColumn" value="<system:edit show="value" from="theEdition" field="metaColDte"/>"></div></div><div class="fieldGroup"><div class="field extendedSize"><!-- CONDICION --><label title="<system:label show="tooltip" label="lblWidMetaCondition" />"><system:label show="text" label="lblWidMetaCondition" />:</label><input type="text" name="widMetaCondition" id="widMetaCondition" value="<system:edit show="value" from="theEdition" field="metaCondition"/>"></div><div class="field required"><!-- MULTIPLICADOR --><label title="<system:label show="tooltip" label="lblWidMetaMultiplier" />"><system:label show="text" label="lblWidMetaMultiplier" />:</label><input type="text" name="widMetaMultiplier" id="widMetaMultiplier" value="<system:edit show="value" from="theEdition" field="metaMultiplier"/>"></div></div><div class="fieldGroup"><div class="field oneLineChbox extendedSize"><!-- META POR: A�O - MES - DIA --><label title="<system:label show="tooltip" label="lblMetaBy" />"><system:label show="text" label="lblMetaBy" />:</label><input class="text-aligned" type="checkbox" id="chkMetaByYear" name="chkMetaByYear"><system:label show="text" label="lblYear" /></input><input class="text-aligned" type="checkbox" id="chkMetaByMonth" name="chkMetaByMonth"><system:label show="text" label="lblMonth" /></input><input class="text-aligned" type="checkbox" id="chkMetaByDay" name="chkMetaByDay"><system:label show="text" label="lblBIDay" /></input></div></div><div id="historyLine2" style="position: absolute; right: 35px; top: 50px; width: 175px; height: 174px"><div id="metaLine" style="position:absolute; top:50%; left: 6px; width:169px; height: 2px; background-color: rgb(244, 39, 39)"></div><img src= "<system:util show="context" />/css/base/img/dashboard/historyChart.png"/></div></div></div></div></div>