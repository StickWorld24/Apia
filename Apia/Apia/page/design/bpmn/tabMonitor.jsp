<script type="text/javascript">
var PRIMARY_SEPARATOR				= new Element('div').set('html', '<system:edit show="constant" from="com.st.util.StringUtil" field="PRIMARY_SEPARATOR"/>').get('text');
</script>

<div class="aTab">
	<div class="tab" id="tabMonitor"><system:label show="text" label="tabMon" /></div>
		<div class="contentTab" id="contentTabMonitor">							
			<div>
							
				<div class="fieldGroup">
					<div class="title"><system:label show="text" label="sbtMonForEnt" /></div>
				</div>	
				<div class="fieldGroup split">
					<div class="modalOptionsContainer optionFormsContainer" id="monitorFormsContainer">						
						<input type="hidden" id="txtFormsId" name="txtFormsId" value="">							
					</div>
					<div class="clear"></div>					
					<div class="modalOptionsContainer">						
						<div class="option optionAdd" id="addMonitorForm" data-helper="true" style="height: 20px">
							<system:label show="text" label="btnAgr" />								
						</div>												
					</div>					
				</div>
				
			</div>
					
		</div>
</div>