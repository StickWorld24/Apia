<system:edit show="ifModalNotLoaded" field="reports.jsp"><system:edit show="markModalAsLoaded" field="reports.jsp" /><div id="mdlReportsContainer" class="mdlContainer hiddenModal" tabIndex="0"><div class="mdlHeader"><system:label show="text" label="titReports" /></div><div class="mdlBody"><div class="gridHeader gridHeaderModal"><!-- Cabezal y filtros --><table title="<system:label show="text" label="titReports" />"><thead><tr id="reportsTrOrderBy" class="header"><th id="orderByNameReportMdl" class="allowSort sort<system:filter show="sortStyle" from="com.dogma.vo.filter.ReportFilterVo" field="ORDER_NAME"/>" data-sortBy="<system:edit show="constant" from="com.dogma.vo.filter.ReportFilterVo" field="ORDER_NAME"/>" title="<system:label show="tooltip" label="lblNom" />"><div style="width:180px"><system:label show="text" label="lblNom" /></div></th><th id="orderByDescReportMdl" class="allowSort sort<system:filter show="sortStyle" from="com.dogma.vo.filter.ReportFilterVo" field="ORDER_DESC"/>" data-sortBy="<system:edit show="constant" from="com.dogma.vo.filter.ReportFilterVo" field="ORDER_DESC"/>" title="<system:label show="tooltip" label="lblEma" />"><div style="width:180px"><system:label show="text" label="lblDesc" /></div></th></tr><tr class="filter"><th><input title="<system:label show="tooltip" label="lblNom" />" id="nameFilterReportsMdl" type="text" value="" maxlength="255"></th><th><input title="<system:label show="tooltip" label="lblDesc" />" id="descFilterReportsMdl" type="text" value="" maxlength="255"></th></tr></thead></table></div><div class="gridBody gridBodyModal"><!-- Cuerpo de la tabla --><table title="<system:label show="text" label="titReports" />"><thead><tr><th style="width:180px"></th><th style="width:180px"></th></tr></thead><tbody class="tableData" id="tableDataReport"></tbody></table></div><div class="gridFooter"><jsp:include page="/page/includes/navButtons.jsp?prefix=Report"/></div></div></div></system:edit>