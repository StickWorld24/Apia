<script type="text/javascript">
	var NO_SEL_EVT_NOT = '<system:label show="text" label="msgNotSelEvtNotif" forScript="true" />';
	var PRIMARY_SEPARATOR		= new Element('div').set('html', '<system:edit show="constant" from="com.st.util.StringUtil" field="PRIMARY_SEPARATOR"/>').get('text');
</script>

<div class="aTab">
	<div class="tab" id="tabActions"><system:label show="text" label="tabAct" /></div>
		<div class="contentTab" id="contentTabActions">							
			<div>
							
				<div class="fieldGroup">
					<div class="title"><system:label show="text" label="sbtDurAct" /></div>
				</div>
				
				<div class="fieldGroup splitOneThird">	
					<div class="field inputDayHr">
						<label title="<system:label show="tooltip" label="lblIniProAle" />"><system:label show="text" label="lblIniProAle" />:&nbsp;</label>
						<label title="<system:label show="tooltip" label="lblDay" />">&nbsp;<system:label show="text" label="lblDay" />&nbsp;</label>
						<input type="text" name="iniAlertDay" id="iniAlertDay" class="validate['numeric']" size="4" maxlength="3" value="<system:edit show="value" from="theEdition" field="proAlertDurationDay" />" >
						<label title="<system:label show="tooltip" label="lblHour" />">&nbsp;<system:label show="text" label="lblHour" /></label>
						<input type="text" name="iniAlertHour" id="iniAlertHour" class="validate['numeric']" size="4" maxlength="3" value="<system:edit show="value" from="theEdition" field="proAlertDurationHour" />" >
					</div>
				</div>
				
				<div class="fieldGroup splitOneThird"></div>
				
				<div class="fieldGroup splitOneThird">				
					<div class="field inputDayHr">
						<label title="<system:label show="tooltip" label="lblIniProAtr" />"><system:label show="text" label="lblIniProAtr" />:&nbsp;</label>
						<label title="<system:label show="tooltip" label="lblDay" />">&nbsp;<system:label show="text" label="lblDay" />&nbsp;</label>
						<input type="text" name="iniAtrDay" id="iniAtrDay" class="validate['numeric']" size="4" maxlength="3" value="<system:edit show="value" from="theEdition" field="proMaxDurationDay" />" >
						<label title="<system:label show="tooltip" label="lblHour" />">&nbsp;<system:label show="text" label="lblHour" /></label>
						<input type="text" name="iniAtrHour" id="iniAtrHour" class="validate['numeric']" size="4" maxlength="3" value="<system:edit show="value" from="theEdition" field="proMaxDurationHour" />" >
					</div>
				</div>
				
				<div class="fieldGroup">							
					<div class="defBlock split">
						<div class="defLbl">
							<label title="<system:label show="tooltip" label="lblTipNot" />" class="label"><system:label show="text" label="lblTipNot" />:&nbsp;</label>
						</div>
					
						<div class="oneLineChbox">
							<input type="checkbox" name="chkNotifEmail" id="chkNotifEmail" <system:edit show="ifValue" from="theEdition" field="notEmail" value="true">checked</system:edit> >
							<label title="<system:label show="tooltip" label="lblProNotMail" />" class="label"><system:label show="text" label="lblProNotMail" />&nbsp;</label>							
						</div>
					
						<div>&nbsp;</div>
						
						<div class="oneLineChbox"> 	
							<input type="checkbox" name="chkNotifMsg" id="chkNotifMsg" <system:edit show="ifValue" from="theEdition" field="notMessage" value="true">checked</system:edit> >
							<label title="<system:label show="tooltip" label="lblProNotMes" />" class="label"><system:label show="text" label="lblProNotMes" /></label>
						</div>
					
						<div>&nbsp;</div>
					
						<div class="oneLineChbox">
							<input type="checkbox" name="chkNotifChat" id="chkNotifChat" <system:edit show="ifValue" from="theEdition" field="notChat" value="true">checked</system:edit> >
							<label title="<system:label show="tooltip" label="lblProNotChat" />" class="label"><system:label show="text" label="lblProNotChat" /></label>
						</div>	
					</div>	
					
					<div class="defBlock split">
						<div class="defLbl">
							<label title="<system:label show="tooltip" label="lblProInAtr" />" class="label"><system:label show="text" label="lblProInAtr" />:&nbsp;</label>
						</div>
					
						<div class="oneLineChbox">
							<input type="checkbox" name="chkRelTsk" id="chkRelTsk" <system:edit show="ifFlag" from="theEdition" field="6" >checked</system:edit> >
							<label title="<system:label show="tooltip" label="lblLibTsks" />" class="label"><system:label show="text" label="lblLibTsks" />&nbsp;</label>							
						</div>
					
						<div>&nbsp;</div>
						
						<div class="oneLineChbox" id="divChkReaPool"> 	
							<input type="checkbox" name="chkReaPool" id="chkReaPool" <system:edit show="ifValue" from="theEdition" field="hasPool" value="true">checked</system:edit> onchange="onChangeChkReaPool(this);">
							<label title="<system:label show="tooltip" label="lblReaProGru" />" class="label"><system:label show="text" label="lblReaProGru" /></label>
							<select name="cmbReaPool" id="cmbReaPool" style="width: 200px; margin-left: 10px; margin-top: 6px;">
								<option value=""></option>
								<system:util show="prepareEnvPools" saveOn="pools" />
								<system:edit show="iteration" from="pools" saveOn="pool">
									<system:edit show="saveValue" from="pool" field="poolId" saveOn="poolId"/>
									<option value="<system:edit show="value" from="pool" field="poolId"/>" <system:edit show="ifValue" from="theEdition" field="proGruReasign" value="with:poolId">selected</system:edit>><system:edit show="value" from="pool" field="poolName"/></option>
								</system:edit>								    										   					
		  					</select>
						</div>		
					</div>					
																								
				</div>
				
				<div class="clear"></div>
				
				<br><br>
								
				<div class="fieldGroup">
					<div class="title"><system:label show="text" label="titNot" /></div>
					
					<div class="field fieldFull">
						<div class="gridContainer" style="margin-left:5px;">
							<div class="gridHeader" id="gridHeader">
								<table>
									<thead>
										<tr class="filter highFixed">
											<th title=""><div style="width: 210px"></div></th>								
											<th title="<system:label show="tooltip" label="lblProCre" />"><div style="width: 160px"><system:label show="text" label="lblProCre" /></div></th>
											<th title="<system:label show="tooltip" label="lblProEnd" />"><div style="width: 160px"><system:label show="text" label="lblProEnd" /></div></th>
											<th title="<system:label show="tooltip" label="lblProAla" />"><div style="width: 160px"><system:label show="text" label="lblProAla" /></div></th>														
											<th title="<system:label show="tooltip" label="lblProOve" />"><div style="width: 160px"><system:label show="text" label="lblProOve" /></div></th>										
										</tr>
									</thead>
								</table>
							</div>
							<div class="gridBody" id="gridBody">
								<table>
									<thead>
										<tr>
											<th width="210px"></th>
											<th width="160px"></th>
											<th width="160px"></th>
											<th width="160px"></th>								
											<th width="160px"></th>
										</tr>
									</thead>
									<tbody class="tableData" id="tableData">
										<tr class="trOdd highFixed">
											<td width="210px" align="left" title="<system:label show="tooltip" label="lblProNotU" />"><label><b><system:label show="text" label="lblProNotU" /></b></label></td>
											<td width="160px" align="center"></td>
											<td width="160px" align="center"><input type="checkbox" id="chkUE" name="chkUE" align="middle"></td>
											<td width="160px" align="center"><input type="checkbox" id="chkUA" name="chkUA" align="middle"></td>
											<td width="160px" align="center"><input type="checkbox" id="chkUO" name="chkUO" align="middle"></td>									
										</tr>
										<tr class="highFixed">
											<td width="210px" align="left" title="<system:label show="tooltip" label="lblProNotP" />"><label><b><system:label show="text" label="lblProNotP" /></b></label></td>
											<td width="160px" align="center"></td>
											<td width="160px" align="center">
												<select id="cmbPE" name="cmbPE" style="width:72%;" onchange="onChangeCmbNotif(this);">
													<system:util show="prepareNotifications" saveOn="notifications" />
													<system:edit show="iteration" from="notifications" saveOn="notif">
														<option value="<system:edit show="value" from="notif" field="value"/>"><system:edit show="value" from="notif" field="name"/></option>
													</system:edit>		
												</select>
												&nbsp;
												<input type="text" id="levXcmbPE" name="levXcmbPE" class="compact validate['digit']" maxlength="3" value="">
											</td>
											<td width="160px" align="center">
												<select id="cmbPA" name="cmbPA" style="width:72%;" onchange="onChangeCmbNotif(this);">
													<system:util show="prepareNotifications" saveOn="notifications" />
													<system:edit show="iteration" from="notifications" saveOn="notif">
														<option value="<system:edit show="value" from="notif" field="value"/>"><system:edit show="value" from="notif" field="name"/></option>
													</system:edit>		
												</select>
												&nbsp;
												<input type="text" id="levXcmbPA" name="levXcmbPA" class="compact validate['digit']" maxlength="3" value="">
											</td>
											<td width="160px" align="center">
												<select id="cmbPO" name="cmbPO" style="width:72%;" onchange="onChangeCmbNotif(this);">
													<system:util show="prepareNotifications" saveOn="notifications" />
													<system:edit show="iteration" from="notifications" saveOn="notif">
														<option value="<system:edit show="value" from="notif" field="value"/>"><system:edit show="value" from="notif" field="name"/></option>
													</system:edit>		
												</select>
												&nbsp;
												<input type="text" id="levXcmbPO" name="levXcmbPO" class="compact validate['digit']" maxlength="3" value="">
											</td>																				
										</tr>
										<tr class="trOdd highFixed">
											<td width="210px" align="left" title="<system:label show="tooltip" label="lblProNotE" />"><label><b><system:label show="text" label="lblProNotE" /></b></label></td>
											<td width="160px" align="center"><input type="checkbox" id="chkEC" name="chkEC" align="middle"></td>
											<td width="160px" align="center"><input type="checkbox" id="chkEE" name="chkEE" align="middle"></td>
											<td width="160px" align="center"><input type="checkbox" id="chkEA" name="chkEA" align="middle"></td>
											<td width="160px" align="center"><input type="checkbox" id="chkEO" name="chkEO" align="middle"></td>								
										</tr>
										<tr class="highFixed">
											<td width="210px" align="left" title="<system:label show="tooltip" label="lblProNotA" />"><label><b><system:label show="text" label="lblProNotA" /></b></label></td>
											<td width="160px" align="center"></td>
											<td width="160px" align="center"></td>
											<td width="160px" align="center"><input type="checkbox" id="chkAA" name="chkAA" align="middle"></td>
											<td width="160px" align="center"><input type="checkbox" id="chkAO" name="chkAO" align="middle"></td>									
										</tr>
										<tr class="trOdd highFixed">
											<td width="210px" align="left" title="<system:label show="tooltip" label="lblProNotT" />"><label><b><system:label show="text" label="lblProNotT" /></b></label></td>
											<td width="160px" align="center"></td>
											<td width="160px" align="center"></td>
											<td width="160px" align="center">
												<select id="cmbTA" name="cmbTA" style="width:72%;" onchange="onChangeCmbNotif(this);">
													<system:util show="prepareNotifications" saveOn="notifications" />
													<system:edit show="iteration" from="notifications" saveOn="notif">
														<option value="<system:edit show="value" from="notif" field="value"/>"><system:edit show="value" from="notif" field="name"/></option>
													</system:edit>		
												</select>
												&nbsp;
												<input type="text" id="levXcmbTA" name="levXcmbTA" class="compact validate['digit']" maxlength="3" value="">
											</td>
											<td width="160px" align="center">
												<select id="cmbTO" name="cmbTO" style="width:72%;" onchange="onChangeCmbNotif(this);">
													<system:util show="prepareNotifications" saveOn="notifications" />
													<system:edit show="iteration" from="notifications" saveOn="notif">
														<option value="<system:edit show="value" from="notif" field="value"/>"><system:edit show="value" from="notif" field="name"/></option>
													</system:edit>		
												</select>
												&nbsp;
												<input type="text" id="levXcmbTO" name="levXcmbTO" class="compact validate['digit']" maxlength="3" value="">
											</td>									
										</tr>
										<tr class="highFixed">
											<td width="210px" align="left" title="<system:label show="tooltip" label="lblPool" />"><label><b><system:label show="text" label="lblPool" /></b></label></td>
											<td width="160px" align="center">
												<div class="modalOptionsContainer" id="containerPoolsC">						
													<div class="option optionAddOnlyIcon optionAddRigth" id="addPoolNotC" data-helper="true" title="<system:label show="text" label="btnAgr" />"></div>						
												</div>
												<input type="hidden" id="poolsIdC" name="poolsIdC" value="">
											</td>
											<td width="160px" align="center">
												<div class="modalOptionsContainer" id="containerPoolsE">						
													<div class="option optionAddOnlyIcon optionAddRigth" id="addPoolNotE" data-helper="true" title="<system:label show="text" label="btnAgr" />"></div>						
												</div>
												<input type="hidden" id="poolsIdE" name="poolsIdE" value="">
											</td>
											<td width="160px" align="center">
												<div class="modalOptionsContainer" id="containerPoolsA"> 						
													<div class="option optionAddOnlyIcon optionAddRigth" id="addPoolNotA" data-helper="true" title="<system:label show="text" label="btnAgr" />"></div>						
												</div>
												<input type="hidden" id="poolsIdA" name="poolsIdA" value="">
											</td>
											<td width="160px" align="center">
												<div class="modalOptionsContainer" id="containerPoolsO">						
													<div class="option optionAddOnlyIcon optionAddRigth" id="addPoolNotO" data-helper="true" title="<system:label show="text" label="btnAgr" />"></div>						
												</div>
												<input type="hidden" id="poolsIdO" name="poolsIdO" value="">
											</td>									
										</tr>
										<tr class="trOdd lastTr highFixed">
											<td width="210px" align="left" title="<system:label show="tooltip" label="lblMen" />"><label><b><system:label show="text" label="lblMen" /></b></label></td>
											<td width="160px" align="center"><div id="viewMsgNotC" class="mdl-btn" title="<system:label show="text" label="btnVer" />"></div><input type="hidden" id="msgTextC" name="msgTextC" value=""><input type="hidden" id="msgSubC" name="msgSubC" value=""></td>
											<td width="160px" align="center"><div id="viewMsgNotE" class="mdl-btn" title="<system:label show="text" label="btnVer" />"></div><input type="hidden" id="msgTextE" name="msgTextE" value=""><input type="hidden" id="msgSubE" name="msgSubE" value=""></td>
											<td width="160px" align="center"><div id="viewMsgNotA" class="mdl-btn" title="<system:label show="text" label="btnVer" />"></div><input type="hidden" id="msgTextA" name="msgTextA" value=""><input type="hidden" id="msgSubA" name="msgSubA" value=""></td>
											<td width="160px" align="center"><div id="viewMsgNotO" class="mdl-btn" title="<system:label show="text" label="btnVer" />"></div><input type="hidden" id="msgTextO" name="msgTextO" value=""><input type="hidden" id="msgSubO" name="msgSubO" value=""></td>
										</tr>
									</tbody>
								</table>
							</div>												
						</div>		
					</div>				
				</div>
			</div>		
		</div>
</div>