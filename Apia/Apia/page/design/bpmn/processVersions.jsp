<script type="text/javascript">
	var MSG_CONFIRM_RECOVER = '<system:label show="text" label="lblRecVer" forScript="true" />';
	var TITLE				= '<system:label show="text" label="lblProVers" forScript="true" />';
</script>

<system:edit show="ifModalNotLoaded" field="versions.jsp">
	<system:edit show="markModalAsLoaded" field="versions.jsp" />
	<div id="mdlVersionsContainer" class="mdlContainer hiddenModal" tabIndex="0">
		<div class="mdlHeader"><span id="mdlTitle"></span></div>
		
		<form id="frmModalVersions">
			<div class="gridHeader" id="gridHeader">
				<!-- Cabezal -->
				<table>
					<thead>
						<tr class="header">
							<th title="<system:label show="text" label="lblVer"/>"><div style="width: 45px"><system:label show="text" label="lblVer" /></div></th>
							<th title="<system:label show="text" label="lblFecUltMod" />"><div style="width: 120px"><system:label show="text" label="lblFecUltMod" /></div></th>
							<th title="<system:label show="text" label="lblUsuUltMod" />"><div style="width: 100px"><system:label show="text" label="lblUsuUltMod" /></div></th>
						</tr>
					</thead>					
				</table>
			</div>	
			<div class="gridBody" id="gridBodyModal">
				<!-- Cuerpo de la tabla -->
				<table>		
					<thead>
						<tr>
							<th width="45px"></th>
							<th width="120px"></th>
							<th width="100px"></th>
						</tr>
					</thead>					
					<tbody class="tableData" id="versionsModalTableData">
								
					</tbody>
				</table>
			</div>
			<div class="gridFooter">
				<div class="navButtonsOptions">
					<div tabIndex="0" class="navButton" id="btnRecoverVersionsModal" title="<system:label show="text" label="btnRec" />"><system:label show="text" label="btnRec" /></div>
					<div tabIndex="0" class="navButton" id="btnLookVersionsModal" title="<system:label show="text" label="btnVer" />"><system:label show="text" label="btnVer" /></div>
				</div>
			</div>
			<div class="mdlFooter footer">
				<div tabIndex="0" class="close" id="btnCloseVersionModal" title="<system:label show="text" label="btnCer" />"><system:label show="text" label="btnCer" /></div>
			</div>
		</form>
	</div>
</system:edit>

