<!-- <system:edit show="ifValue" from="theBean" field="adtFilters" value="true"> --><div class="fncPanel options lastOptions"><div class="title" title="<system:label show="tooltip" label="titAdmAdtFilter"/>"><system:label show="text" label="titAdmAdtFilter"/></div><div class="content"><!-- FILTROS ADICIONALES FIJOS --><system:edit show="ifValue" from="theBean" field="adtFil1" value="true"><div class="filter"><span><system:label show="text" label="lblLastActDate"/>:</span><input id="txtCreateFrom" name="txtCreateFrom" type="text" size="9" maxlength="10" class="datePicker datePickerChecker filterInputDate" value="<system:filter show="value" filter="9"/>">&nbsp;&nbsp;-&nbsp;&nbsp;<input id="txtCreateTo" name="txtCreateTo" type="text" size="9" maxlength="10" class="datePicker datePickerChecker filterInputDate"  value="<system:filter show="value" filter="10"/>" ></div></system:edit><system:edit show="ifValue" from="theBean" field="adtFil2" value="true"><div class="filter"><span><system:label show="text" label="lblDes"/>:</span><input type="text" id="descFilter" name="descFilter" value="<system:filter show="value" filter="1"/>"></div></system:edit><div class="filter" <system:edit show="ifValue" from="theBean" field="adtFil3" value="false">style="display:none"</system:edit>><span><system:label show="text" label="lblSrc"/>:</span><select id="cmbDocType" onchange="enableDisableFilters(this);setFilter()" name="cmbDocType" value="<system:filter show="value" filter="4"></system:filter>" style="max-width: 60% !important;"><option></option><system:edit show="iteration" from="theBean" field="filDocumentSource" saveOn="docType_save"><system:edit show="saveValue" from="docType_save" field="docType" saveOn="docType"/><option value="<system:edit show="value" from="docType_save" field="docType"/>" ><system:edit show="value" from="docType_save" field="docTypeName"/></option></system:edit></select></div><system:edit show="ifValue" from="theBean" field="adtFil4" value="true"><div class="filter"><system:edit show="ifValue" from="theBean" field="srcTitPreFilter" value="false"><span><system:label show="text" label="lblSrcTit"/>:</span><input type="text" id="ownerTitleFilter" name="ownerTitleFilter" value="<system:filter show="value" filter="11"/>"></system:edit><system:edit show="ifValue" from="theBean" field="srcTitPreFilter" value="true"><!-- TAREA --><system:edit show="ifValue" from="theBean" field="filSrcTitTsk" value="true"><div class="filter"><span><system:label show="text" label="lblEjeTar"/>:</span><system:edit show="ifValue" from="theBean" field="srcTitTskWithValue" value="false"><input type="text" id="ownerFilterTsk" name="ownerFilterTsk" value=""></system:edit><system:edit show="ifValue" from="theBean" field="srcTitTskWithValue" value="true"><select id="ownerFilterTsk" name="ownerFilterTsk" onchange="setFilter()" value="" style="max-width: 60% !important;"><option></option><system:edit show="iteration" from="theBean" field="filDocumentSourceTsk" saveOn="docSource_save"><option value="<system:edit show="value" from="docSource_save" field="tskId"/>" ><system:edit show="value" from="docSource_save" field="docSourceTitle"/></option></system:edit></select></system:edit></div></system:edit><system:edit show="ifValue" from="theBean" field="filSrcTitPro" value="true"><!-- PROCESO --><div class="filter"><span><system:label show="text" label="lblEleProcess"/>:</span><system:edit show="ifValue" from="theBean" field="srcTitProWithValue" value="false"><input type="text" id="ownerFilterPro" name="ownerFilterPro" value=""></system:edit><system:edit show="ifValue" from="theBean" field="srcTitProWithValue" value="true"><select id="ownerFilterPro" name="ownerFilterPro" onchange="setFilter()" value="" style="max-width: 60% !important;"><option></option><system:edit show="iteration" from="theBean" field="filDocumentSourcePro" saveOn="docSource_save"><option value="<system:edit show="value" from="docSource_save" field="proId"/>" ><system:edit show="value" from="docSource_save" field="docSourceTitle"/></option></system:edit></select></system:edit></div></system:edit><system:edit show="ifValue" from="theBean" field="filSrcTitEnt" value="true"><!-- ENTIDAD --><div class="filter"><span><system:label show="text" label="lblEnt"/>:</span><system:edit show="ifValue" from="theBean" field="srcTitEntWithValue" value="false"><input type="text" id="ownerFilterEnt" name="ownerFilterEnt" value=""></system:edit><system:edit show="ifValue" from="theBean" field="srcTitEntWithValue" value="true"><select id="ownerFilterEnt" name="ownerFilterEnt" onchange="setFilter()" value="" style="max-width: 60% !important;"><option></option><system:edit show="iteration" from="theBean" field="filDocumentSourceEnt" saveOn="docSource_save"><option value="<system:edit show="value" from="docSource_save" field="busEntId"/>" ><system:edit show="value" from="docSource_save" field="docSourceTitle"/></option></system:edit></select></system:edit></div></system:edit><system:edit show="ifValue" from="theBean" field="filSrcTitAtt" value="true"><!-- ATTRIBUTO --><div class="filter"><span><system:label show="text" label="lblAtt"/>:</span><system:edit show="ifValue" from="theBean" field="srcTitAttWithValue" value="false"><input type="text" id="ownerFilterAtt" name="ownerFilterAtt" value=""></system:edit><system:edit show="ifValue" from="theBean" field="srcTitAttWithValue" value="true"><select id="ownerFilterAtt" name="ownerFilterAtt" onchange="setFilter()" value="" style="max-width: 60% !important;"><option></option><system:edit show="iteration" from="theBean" field="filDocumentSourceAtt" saveOn="docSource_save"><option value="<system:edit show="value" from="docSource_save" field="attId"/>" ><system:edit show="value" from="docSource_save" field="docSourceTitle"/></option></system:edit></select></system:edit></div></system:edit><system:edit show="ifValue" from="theBean" field="filSrcTitFrm" value="true"><!-- FORMULARIO --><div class="filter"><span><system:label show="text" label="lblFor"/>:</span><system:edit show="ifValue" from="theBean" field="srcTitFrmWithValue" value="false"><input type="text" id="ownerFilterFrm" name="ownerFilterFrm" value=""></system:edit><system:edit show="ifValue" from="theBean" field="srcTitFrmWithValue" value="true"><select id="ownerFilterFrm" name="ownerFilterFrm" onchange="setFilter()" value="" style="max-width: 60% !important;"><option></option><system:edit show="iteration" from="theBean" field="filDocumentSourceFrm" saveOn="docSource_save"><option value="<system:edit show="value" from="docSource_save" field="frmId"/>" ><system:edit show="value" from="docSource_save" field="docSourceTitle"/></option></system:edit></select></system:edit></div></system:edit></system:edit></div></system:edit><system:edit show="ifValue" from="theBean" field="adtFil5" value="true"><div class="filter"><span><system:label show="text" label="lblMonInstProNroReg"/>:</span><input type="text" id="instFilter" name="instFilter" value="<system:filter show="value" filter="12"/>"></div></system:edit><system:edit show="ifValue" from="theBean" field="adtFil6" value="true"><div class="filter" id="divContent"><system:edit show="ifValue" from="theBean" field="docIndexActive" value="true"><span><system:label show="text" label="lblContent" />:</span></system:edit><input type="<system:edit show="value" from="theBean" field="docIndexActiveType"/>" id="contentFilter" name="contentFilter" value="<system:filter show="value" filter="13"/>"></div></system:edit></div></div><!-- </system:edit> -->