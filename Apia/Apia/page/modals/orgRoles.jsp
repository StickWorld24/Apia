<system:edit show="ifModalNotLoaded" field="orgRoles.jsp"><system:edit show="markModalAsLoaded" field="orgRoles.jsp" /><div id="mdlOrgRoleContainer" class="mdlContainer hiddenModal"><div class="mdlHeader"><system:label show="text" label="titOrgRoles" /></div><div class="mdlBody"><div class="gridHeader gridHeaderModal"><!-- Cabezal y filtros --><table><thead><tr id="orgRolesTrOrderBy" class="header"><th id="orderByNameOrgRoleMdl" class="allowSort sort<system:filter show="sortStyle" from="com.dogma.vo.filter.OrganizationalRoleFilterVo" field="ORDER_NAME"/>" data-sortBy="<system:edit show="constant" from="com.dogma.vo.filter.OrganizationalRoleFilterVo" field="ORDER_NAME"/>" title="<system:label show="tooltip" label="lblNom" />"><div><system:label show="text" label="lblNom" /></div></th></tr><tr class="filter"><th title="<system:label show="tooltip" label="lblNom" />"><input id="nameFilterOrgRoleMdl" type="text" value="" maxlength="255"></th></tr></thead></table></div><div class="gridBody gridBodyModal"><!-- Cuerpo de la tabla --><table><thead><tr><th></th></tr></thead><tbody class="tableData" id="tableDataOrgRole"></tbody></table></div><div class="gridFooter"><jsp:include page="/page/includes/navButtons.jsp?prefix=OrgRole"/></div></div></div></system:edit>