<system:edit show="ifModalNotLoaded" field="busClassParams.jsp"><system:edit show="markModalAsLoaded" field="busClassParams.jsp" /><div id="mdlBusClaParContainer" class="mdlContainer hiddenModal"><div class="mdlHeader"><system:label show="text" label="titPar" /></div><div class="mdlBody"><div class="gridHeader gridHeaderModal"><!-- Cabezal y filtros --><table><thead><tr class="filter"><th style="width:400px" title="<system:label show="tooltip" label="lblNom" />"><input id="nameFilterBusClaParMdl" type="text" value="" maxlength="255"></th></tr></thead></table></div><div class="gridBody gridBodyModal"><!-- Cuerpo de la tabla --><table><thead><tr><th style="width:400px"></th></tr></thead><tbody class="tableData" id="tableDataBusClaPar"></tbody></table></div><div class="gridFooter"><jsp:include page="/page/includes/navButtons.jsp?prefix=BusClaPar"/></div></div></div></system:edit>