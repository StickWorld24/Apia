
<system:edit show="ifModalNotLoaded" field="mdlDocInformation.jsp"><system:edit show="markModalAsLoaded" field="mdlDocInformation.jsp" /><div id="mdlDocInformationContainer" class="mdlContainer hiddenModal"><div class="mdlHeader"><system:label show="text" label="lblInf" /></div><div class="mdlBody" id="mdlBodyDocInfo"><!-- DATOS GENERALES --><div class="fieldGroup"><div class="title"><system:label show="text" label="sbtDocInfo" /></div><div class="field fieldHalfMdl"><label title="<system:label show="tooltip" label="lblDocType" />" style="width: auto !important;"><system:label show="text" label="lblDocType" />:&nbsp;</label><span id="docType"></span></div><div class="field fieldHalfMdl largeText"><label title="<system:label show="tooltip" label="lblNom" />" style="width: auto !important;"><system:label show="text" label="lblNom" />:&nbsp;</label><span id="docName"></span></div><div class="field fieldHalfMdl largeText"><label title="<system:label show="tooltip" label="lblDesc" />" style="width: auto !important;"><system:label show="text" label="lblDesc" />:&nbsp;</label><span id="docDesc"></span></div><div class="field fieldHalfMdl"><label title="<system:label show="tooltip" label="lblExpDate" />" style="width: auto !important;"><system:label show="text" label="lblExpDate" />:&nbsp;</label><span id="docExpDateMon"></span></div><div class="field fieldHalfMdl"><label title="<system:label show="tooltip" label="lblLock" />" style="width: auto !important;"><system:label show="text" label="lblLock" />:&nbsp;</label><span id="docLock"></span></div></div><!-- PERMISOS --><div class="fieldGroup" <system:edit show="ifValue" from="theBean" field="showMdlInfoPerm" value="false">style="display:none"</system:edit>><div class="title"><system:label show="text" label="sbtPerAccDoc" /></div><div class="field fieldFull"><div class="modalOptionsContainer" id="permContainter"></div></div></div><!-- METADATOS --><div class="fieldGroup" <system:edit show="ifValue" from="theBean" field="showMdlInfoMet" value="false">style="display:none"</system:edit>><div class="title"><system:label show="text" label="titMetadata" /></div></div><div id="divNoMetadata" style="display: none;"><span class="italic"><system:label show="text" label="msgNoMetadata" /></span><br><br></div><div id="divMetadata" <system:edit show="ifValue" from="theBean" field="showMdlInfoMet" value="false">style="display:none"</system:edit>><div class="gridHeader"><!-- Cabezal y filtros --><table><thead><tr id="trOrderBy" class="header"><th title="<system:label show="tooltip" label="docTit" />"><div style="width:200px"><system:label show="text" label="docTit" /></div></th><th title="<system:label show="tooltip" label="lblVal" />"><div style="width:180px"><system:label show="text" label="lblVal" /></div></th><th title="<system:label show="tooltip" label="lblFree" />"><div style="width:50px"><system:label show="text" label="lblFree" /></div></th></tr></thead></table></div><div class="gridBody" style="overflow-x: hidden !important; height: 120px;"><!-- Cuerpo de la tabla --><table><thead><tr><th width="200px"></th><th width="179px"></th><th width="50px"></th></tr></thead><tbody class="tableData" id="tableDataMetadata"></tbody></table></div><div class="gridFooter"></div></div></div><div class="mdlFooter"><div class="close" id="closeDocInformationModal" title="<system:label show="text" label="btnCer" />"><system:label show="text" label="btnCer" /></div></div></div></system:edit>