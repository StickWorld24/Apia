<div class="gridHeader" id="gridHeader"><!-- Cabezal y filtros --><table title="<system:query show="value" from="theBean" field="qryTitle"/>"><thead><tr id="trOrderBy" class="header"><system:query show="ifValue" from="theBean" field="hasShowMoreInfo" value="true"><th data-moreInfo="true" style="width: 30px;"><div style="width: 30px; overflow: hidden; white-space: pre;">&nbsp;</div></th></system:query><system:query show="iteration" from="theBean" field="columnsToShow" saveOn="header"><system:query show="ifValue" from="header" field="showAsMoreInfo" value="false"><th id="orderBy<system:edit show="value" from="header" field="colName"/>" class="<system:query show="ifValue" from="header" field="canOrder" value="true">allowSort</system:query> sort<system:query show="value" from="header" field="sortStyle"/><system:query show="ifValue" from="header" field="isRequired" value="true"> required</system:query>" data-sortBy="<system:query show="value" from="header" field="colNameUpper"/>" title="<system:query show="value" from="header" field="title" />"><div style="<system:query show="ifValue" from="header" field="autoFitWidthTitle" value="true">white-space: nowrap;</system:query>width: <system:query show="value" from="header" field="width" />px"<system:query show="ifValue" from="header" field="autoFitWidthTitle" value="true">data-autofit="true"</system:query>><div style="overflow:hidden;width:100%"><system:query show="value" from="header" field="colText"/></div></div></th></system:query></system:query></tr><system:query show="ifValue" from="theBean" field="hasColumnWithFilter" value="true"><tr class="filter"><system:query show="ifValue" from="theBean" field="hasShowMoreInfo" value="true"><th style="width: 30px;"><div style="width: 30px; overflow: hidden; white-space: pre;">&nbsp;</div></th></system:query><system:query show="iteration" from="theBean" field="columnsToShow" saveOn="header"><system:query show="ifValue" from="header" field="showAsMoreInfo" value="false"><system:query show="ifExistsValue" from="header" field="filter"><th title="<system:query show="value" from="header" field="title" />"><system:query show="saveValue" from="header" field="filter" saveOn="filter" /><div style="<system:query show="ifValue" from="header" field="autoFitWidthTitle" value="true">white-space: nowrap;</system:query>width: <system:query show="value" from="header" field="width" />px"<system:query show="ifValue" from="header" field="autoFitWidthTitle" value="true">data-autofit="true"</system:query>><div style="overflow:hidden;width:100%"><system:query show="ifValue" from="filter" field="showAsAdditionalFilter" value="false"><system:query show="value" from="filter" field="htmlFilterColumn" avoidHtmlConvert="true" /></system:query></div></div></th></system:query><system:query show="ifNotExistsValue" from="header" field="filter"><th><div style="width: <system:query show="value" from="header" field="width" />px">&nbsp;</div></th></system:query></system:query></system:query></tr></system:query></thead></table></div>