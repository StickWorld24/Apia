<div class="aTab"><div class="tab" id="measureTab"><system:label show="text" label="tabCreMeasures" /></div><div class="contentTab"><div class="fieldGroup"><div class="title"><system:label show="text" label="sbtFactTable" /></div><div class=""><input type="radio" name="radFactTable1" id="radFactTable1" <system:edit show="value" from="theBean" field="radUseTableAsFactTableChecked"/>/><label title="<system:label show="tooltip" label="lblUseTable" />" for="radUseTable" class="label"><system:label show="text" label="lblUseTable" /></label><select name="selFactTable" id="selFactTable" <system:edit show="value" from="theBean" field="selTablesDisabled"/> initVal="<system:edit show="value" from="theBean" field="factNameUpperCase"/>" ></select></div><div style="margin-top: 5px;"><input type="radio" name="radFactTable2" id="radFactTable2" <system:edit show="value" from="theBean" field="radUseViewAsFactTableChecked"/> /><label title="<system:label show="tooltip" label="lblCreView" />" for="radIdePreAll" class="label"><system:label show="text" label="lblCreView" /></label></div><div class="field extendedSize" style="margin-left: 5px; margin-top: 10px;"><label title="<system:label show="tooltip" label="lblPropAliasView" />"><system:label show="text" label="lblPropAliasView" />:</label><input type="text" name="txtViewAlias" id="txtViewAlias" class="validate['~validName']" value="<system:edit show="value" from="theBean" field="aliasView"/>"></div><div class="field extendedSize" style="margin-left: 5px; width:90%;"><label title="<system:label show="tooltip" label="lblSql" />"><system:label show="text" label="lblSql" />:</label><textarea cols='120' rows='6' id="txtFactTableView" name="txtFactTableView" value="<system:edit show="value" from="theBean" field="sql"/>"><system:edit show="value" from="theBean" field="sql"/></textarea><input type="hidden" id="viewSQLColumns" value="<system:edit show="value" from="theBean" field="factTableColumns"/>"></input></div></div><div class="fieldGroup"><div class="title"><system:label show="text" label="sbtMeasures" /></div></div><div id="measuresTable" class="gridContainer" style="margin: 0px;"><div class="gridHeader"><table><thead><tr class="header"><th title="<system:label show="tooltip" label="lblSourceField" />"><div style="width: 220px"><system:label show="text" label="lblSourceField" /></div></th><th title="<system:label show="tooltip" label="lblMeasName" />"><div style="width: 120px"><system:label show="text" label="lblMeasName" /></div></th><th title="<system:label show="tooltip" label="lblMeasDispName" />"><div style="width: 120px"><system:label show="text" label="lblMeasDispName" /></div></th><th title="<system:label show="tooltip" label="titMeasType" />"><div style="width: 120px"><system:label show="text" label="titMeasType" /></div></th><th title="<system:label show="tooltip" label="lblAggregator" />"><div style="width: 100px"><system:label show="text" label="lblAggregator" /></div></th><th title="<system:label show="tooltip" label="lblFormat" />"><div style="width: 60px"><system:label show="text" label="lblFormat" /></div></th><th title="<system:label show="tooltip" label="titFormula" />"><div style="width: 190px"><system:label show="text" label="titFormula" /></div></th><th title="<system:label show="tooltip" label="titVisible" />"><div style="width: 40px"><system:label show="text" label="titVisible" /></div></th></tr></thead></table></div><div class="gridBody"  id="gridBodyMeasures"><!-- Cuerpo de la tabla --><table><thead><tr><th width="220px"></th><th width="120px"></th><th width="120px"></th><th width="120px"></th><th width="100px"></th><th width="60px"></th><th width="190px"></th><th width="40px"></th></tr></thead><tbody class="tableData" id="gridMeasures"></tbody></table></div><div class="gridFooter"><div class="listActionButtons" id="gridFooter"><div class="listAddDelRight" id="buttonsMea"><div class="btnAdd navButton" id="btnAddMea"><system:label show="text" label="btnAgr" /></div><div class="actSeparator">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;</div><div class="btnDelete navButton" id="btnDeleteMea"><system:label show="text" label="btnEli" /></div></div></div></div></div></div></div>