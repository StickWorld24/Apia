<div class="field"><label title="<system:label show="tooltip" label="lblQryActVieQry" />" for="chkActVieQry" class="label"><system:label show="text" label="lblQryActVieQry" />:&nbsp;</label><input type="checkbox" id="chkActVieQry" name="chkActVieQry" onclick="chkActVieQry_click()" <system:edit show="ifValue" from="theBean" field="chkActVieQry" value="true" >checked</system:edit> /></div><div class="clearLeft"></div><div class="gridHeader"><table width="100%"><thead><tr class="header"><th title="<system:label show="tooltip" label="lblNom" />" ><div style="width: 500px"><system:label show="text" label="lblNom" /></div></th><th title="<system:label show="tooltip" label="lblQryAllowUsrSelectAutoFilter" />" ><div style="width: 200px"><system:label show="text" label="lblQryAllowUsrSelectAutoFilter" /></div></th></tr></thead></table></div><div class="gridBody" style="background-image: none;"><table id="tblActionQuery" width="100%"><thead><tr class="header"><th width="500px"></th><th width="200px"></th></tr></thead><tbody class="tableData" id="bodyActionQuery"></tbody></table></div><div class="gridFooter"><div class="listActionButtons" id="gridFooterFormEnt"><div class="listUpDown"><div class="btnUp navButton" id="btnUpActionQuery" <system:edit show="ifValue" from="theBean" field="chkActVieQry" value="false" >style='visibility: hidden'</system:edit> ><system:label show="text" label="btnUp" /></div><div class="actSeparator">&nbsp;&nbsp;&nbsp;</div><div class="btnDown navButton" id="btnDownActionQuery" <system:edit show="ifValue" from="theBean" field="chkActVieQry" value="false" >style='visibility: hidden'</system:edit> ><system:label show="text" label="btnDown" /></div></div><div class="listAddDel"><div class="actSeparator">&nbsp;&nbsp;&nbsp;</div><div class="btnAdd navButton" id="btnDeleteActionQuery" <system:edit show="ifValue" from="theBean" field="chkActVieQry" value="false" >style='visibility: hidden'</system:edit> ><system:label show="text" label="btnEli" /></div><div class="actSeparator">&nbsp;&nbsp;&nbsp;</div><div class="btnAdd navButton" id="btnAddActionQuery" <system:edit show="ifValue" from="theBean" field="chkActVieQry" value="false" >style='visibility: hidden'</system:edit> ><system:label show="text" label="btnAgr" /></div></div></div></div><br><!-- ADD REPORTS TO QUERY --><div class="field"><label title="<system:label show="tooltip" label="lblQryViewRep" />" for="chkAddRpQry" class="label"><system:label show="text" label="lblQryViewRep" />:&nbsp;</label><input type="checkbox" id="chkAddRpQry" name="chkAddRpQry" onclick="chkAddRpQry_click()" <system:edit show="ifValue" from="theBean" field="chkAddRpQry" value="true" >checked</system:edit> /></div><div class="clearLeft"></div><div class="gridHeader"><table width="100%"><thead><tr class="header"><th title="<system:label show="tooltip" label="lblNom" />" ><div style="width: 500px"><system:label show="text" label="lblNom" /></div></th><th title="<system:label show="tooltip" label="lblDwnAs" />" ><div style="width: 200px"><system:label show="text" label="lblDwnAs" /></div></th></tr></thead></table></div><div class="gridBody" style="background-image: none;"><table id="tblAddRepQry" width="100%"><thead><tr class="header"><th width="500px"></th><th width="200px"></th></tr></thead><tbody class="tableData" id="bodyAddRepQry"></tbody></table></div><div class="gridFooter"><div class="listActionButtons" id="gridFooterFormEnt"><div class="listUpDown"><div class="btnUp navButton" id="btnUpRepQry" <system:edit show="ifValue" from="theBean" field="chkAddRpQry" value="false" >style='visibility: hidden'</system:edit> ><system:label show="text" label="btnUp" /></div><div class="actSeparator">&nbsp;&nbsp;&nbsp;</div><div class="btnDown navButton" id="btnDownRepQry" <system:edit show="ifValue" from="theBean" field="chkAddRpQry" value="false" >style='visibility: hidden'</system:edit> ><system:label show="text" label="btnDown" /></div></div><div class="listAddDel"><div class="actSeparator">&nbsp;&nbsp;&nbsp;</div><div class="btnAdd navButton" id="btnDeleteRepQry" <system:edit show="ifValue" from="theBean" field="chkAddRpQry" value="false" >style='visibility: hidden'</system:edit> ><system:label show="text" label="btnEli" /></div><div class="actSeparator">&nbsp;&nbsp;&nbsp;</div><div class="btnAdd navButton" id="btnAddRepQry" <system:edit show="ifValue" from="theBean" field="chkAddRpQry" value="false" >style='visibility: hidden'</system:edit> ><system:label show="text" label="btnAgr" /></div></div></div></div><div class="clearLeft sep"></div><div class="field fieldFull oneLineChbox oneLineQryAction"><input type="checkbox" id="chkActVieEnt" name="chkActVieEnt"  <system:edit show="value" from="theBean" field="chkActVieEnt" /> /><label title="<system:label show="tooltip" label="lblQryActVieEnt" />" for="chkActVieEnt" class="label"><system:label show="text" label="lblQryActVieEnt" />&nbsp;(<system:edit show="value" from="theBean" field="requiereActVieEntCol" />):&nbsp;</label></div><div class="field fieldFull oneLineChbox oneLineQryAction"><input type="checkbox" id="chkActViePro" name="chkActViePro"  <system:edit show="value" from="theBean" field="chkActViePro" /> /><label title="<system:label show="tooltip" label="lblQryActViePro" />" for="chkActViePro" class="label"><system:label show="text" label="lblQryActViePro" />&nbsp;(<system:edit show="value" from="theBean" field="requiereActVieProCol" />):&nbsp;</label></div><div class="field fieldFull oneLineChbox oneLineQryAction"><input type="checkbox" id="chkActViwTas" name="chkActViwTas"  <system:edit show="value" from="theBean" field="chkActViwTas" /> /><label title="<system:label show="tooltip" label="lblQryActVieTas" />" for="chkActViwTas" class="label"><system:label show="text" label="lblQryActVieTas" />&nbsp;(<system:edit show="value" from="theBean" field="requiereActVieTasCol" />):&nbsp;</label></div><div class="field fieldFull oneLineChbox oneLineQryAction"><input type="checkbox" id="chkActWorEnt" name="chkActWorEnt"  <system:edit show="value" from="theBean" field="chkActWorEnt" /> /><label title="<system:label show="tooltip" label="lblQryActWorEnt" />" for="chkActWorEnt" class="label"><system:label show="text" label="lblQryActWorEnt" />&nbsp;(<system:edit show="value" from="theBean" field="requiereActWorEntCol" />):&nbsp;</label></div><div class="field fieldFull oneLineChbox oneLineQryAction"><input type="checkbox" id="chkActWorTas" name="chkActWorTas"  <system:edit show="value" from="theBean" field="chkActWorTas" /> /><label title="<system:label show="tooltip" label="lblQryActWorTas" />" for="chkActWorTas" class="label"><system:label show="text" label="lblQryActWorTas" />&nbsp;(<system:edit show="value" from="theBean" field="requiereActWorTasCol" />):&nbsp;</label></div><div class="field fieldFull oneLineChbox oneLineQryAction"><input type="checkbox" id="chkActAcqTas" name="chkActAcqTas"  <system:edit show="value" from="theBean" field="chkActAcqTas" /> /><label title="<system:label show="tooltip" label="lblQryActAcqTas" />" for="chkActAcqTas" class="label"><system:label show="text" label="lblQryActAcqTas" />&nbsp;(<system:edit show="value" from="theBean" field="requiereActAcqTasCol" />):&nbsp;</label></div><div class="field fieldFull oneLineChbox oneLineQryAction"><input type="checkbox" id="chkActComTas" name="chkActComTas"  <system:edit show="value" from="theBean" field="chkActComTas" /> /><label title="<system:label show="tooltip" label="lblQryActComTas" />" for="chkActComTas" class="label"><system:label show="text" label="lblQryActComTas" />&nbsp;(<system:edit show="value" from="theBean" field="requiereActComTasCol" />):&nbsp;</label></div>		