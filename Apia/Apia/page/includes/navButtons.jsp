<%@ taglib prefix="system"	uri="/WEB-INF/system-tags.tld" %><script type="text/javascript">
	var MUST_FILTER = '<system:label show="text" label="lblMstSrtFilter" forScript="true" />';
</script><div class="navButtons"><div class="pGroup"><div tabIndex="0" id="navFirst<system:edit show="value" from="theRequest" field="prefix"/>" class="pButton btnFirst"></div><div tabIndex="0" id="navPrev<system:edit show="value" from="theRequest" field="prefix"/>" class="pButton btnPrev"></div></div><div class="pGroup" id="navigator<system:edit show="value" from="theRequest" field="prefix"/>"><label for="navBarCurrentPage<system:edit show="value" from="theRequest" field="prefix"/>">&nbsp;</label><input title="<system:label show="tooltip" label="lblPage" />" id="navBarCurrentPage<system:edit show="value" from="theRequest" field="prefix"/>" type="text" size=2 value=0 class="navBarCurrentPage"><system:label show="text" label="lblFrom" /><span id="navBarPageCount<system:edit show="value" from="theRequest" field="prefix"/>" class="navBarPageCount">0</span></div><div class="pGroup"><div tabIndex="0" id="navNext<system:edit show="value" from="theRequest" field="prefix"/>" class="pButton btnNext"></div><div tabIndex="0" id="navLast<system:edit show="value" from="theRequest" field="prefix"/>" class="pButton btnLast"></div></div><div class="pGroup"><div tabIndex="0" id="navRefresh<system:edit show="value" from="theRequest" field="prefix"/>" class="pButton btnRefresh"></div></div></div><div class="navButtonsOptions"><system:edit show="ifExistsValue" from="theRequest" field="prefix" value=""><div class="navButton" tabIndex="0" id="closeModal<system:edit show="value" from="theRequest" field="prefix"/>" style="width: 40px"><system:label show="text" label="lblCloseWindow" /></div></system:edit><div class="navButton navButtonRemoveFilters" tabIndex="0" id="clearFilters<system:edit show="value" from="theRequest" field="prefix"/>"><system:label show="text" label="btnClearFilter" /></div><system:edit show="ifExistsValue" from="theRequest" field="prefix" value=""><div class="navButton" tabIndex="0" id="confirmModal<system:edit show="value" from="theRequest" field="prefix"/>" style="width: 60px"><system:label show="text" label="btnCon" /></div></system:edit></div>