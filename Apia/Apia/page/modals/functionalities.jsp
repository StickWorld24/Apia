<system:edit show="ifModalNotLoaded" field="functionalities.jsp"><system:edit show="markModalAsLoaded" field="functionalities.jsp" /><div id="mdlFncsContainer" class="mdlContainer hiddenModal"><div class="mdlHeader"><system:label show="tooltip" label="sbtFncs" /></div><div class="mdlBody"><div class="gridHeader gridHeaderModal"><!-- Cabezal y filtros --><table><thead><tr id="functionalitiesTrOrderBy" class="header"><th id="orderByFncFolderMdl" class="allowSort sort<system:filter show="sortStyle" from="biz.statum.apia.vo.filter.FunctionalityFilterVo" field="ORDER_FOLDER"/>" data-sortBy="<system:edit show="constant" from="biz.statum.apia.vo.filter.FunctionalityFilterVo" field="ORDER_FOLDER"/>" title="<system:label show="tooltip" label="lblCar" />"><div style="width: 150px"><system:label show="text" label="lblCar"/></div></th><th id="orderByFncNameMdl" class="allowSort sort<system:filter show="sortStyle" from="biz.statum.apia.vo.filter.FunctionalityFilterVo" field="ORDER_NAME"/>" data-sortBy="<system:edit show="constant" from="biz.statum.apia.vo.filter.FunctionalityFilterVo" field="ORDER_NAME"/>" title="<system:label show="tooltip" label="lblTipAdmFun" />"><div style="width: 150px"><system:label show="text" label="lblTipAdmFun" /></div></th></tr><tr class="filter"><th title="<system:label show="tooltip" label="lblCar" />"><div style="width: 200px"><input id="folderFilterFncMdl" type="text" value="" maxlength="255"></div></th><th title="<system:label show="tooltip" label="lblTipAdmFun" />"><div style="width: 200px"><input id="nameFilterFncMdl" type="text" value="" maxlength="255"></div></th></tr></thead></table></div><div class="gridBody gridBodyModal"><!-- Cuerpo de la tabla --><table><thead><tr><th style="width:200px"></th><th style="width:200px"></th></tr></thead><tbody class="tableData" id="tableDataFnc"></tbody></table></div><div class="gridFooter"><jsp:include page="/page/includes/navButtons.jsp?prefix=Fnc"/></div></div></div></system:edit>