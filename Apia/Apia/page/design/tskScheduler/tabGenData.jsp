<div class="aTab"><div class="tab"><system:label show="text" label="tabDatGen" /></div><div class="contentTab"><div class="fieldGroup"><div class="title"><system:label show="text" label="sbtDatTskSch" /></div><div class="field fieldTwoFifths required"><label title="<system:label show="tooltip" label="lblNom" />"><system:label show="text" label="lblNom" />:</label><input type="text" name="tskSchName" id="tskSchName" class="validate['required','~validName']"  value="<system:edit show="value" from="theEdition" field="tskSchName"/>"></div><div class="field fieldTwoFifths required"><label title="<system:label show="tooltip" label="lblTit" />"><system:label show="text" label="lblTit" />:</label><input type="text" name="tskSchTitle" id="tskSchTitle" class="validate['required']"  value="<system:edit show="value" from="theEdition" field="tskSchTitle"/>"></div><div class="field fieldOneFifths fieldLast"><label title="<system:label show="tooltip" label="titPrj" />"><system:label show="text" label="titPrj" />:</label><select name="selPrj" id="selPrj" onchange='cmbPrjChange(this)'><system:util show="prepareProjects" saveOn="projects" /><system:edit show="iteration" from="projects" saveOn="project"><system:edit show="saveValue" from="project" field="prjId" saveOn="prjId"/><option value="<system:edit show="value" from="project" field="prjId"/>" data-prefix="<system:edit show="value" from="project" field="prjPrefix"/>"
							<system:edit show="ifValue" from="theEdition" field="prjId" value="with:prjId">selected</system:edit>
						><system:edit show="value" from="project" field="prjTitle"/></option></system:edit></select></div><div class="field fieldFull"><label title="<system:label show="tooltip" label="lblDesc" />"><system:label show="text" label="lblDesc" />:</label><textarea type="text" name="tskSchDesc" id="tskSchDesc" maxlength="255" cols=80 rows=3><system:edit show="value" from="theEdition" field="tskSchDesc"/></textarea></div></div><div class="fieldGroup"><div class="field fieldTwoFifths"><label title="<system:label show="tooltip" label="titCal" />"><system:label show="text" label="titCal" />:</label><select name="selCal" id="selCal"><option></option><system:util show="prepareCalendars" saveOn="calendars" /><system:edit show="iteration" from="calendars" saveOn="calendar"><system:edit show="saveValue" from="calendar" field="calendarId" saveOn="calendarId"/><option value="<system:edit show="value" from="calendar" field="calendarId"/>" 
								<system:edit show="ifValue" from="theEdition" field="calId" value="with:calendarId">selected</system:edit>
						><system:edit show="value" from="calendar" field="calendarName"/></option></system:edit></select></div><div class="field fieldOneFifths required"><label title="<system:label show="tooltip" label="lblActPrvMins" />"><system:label show="text" label="lblActPrvMins" />:</label><input class="numeric" type="text" name="txtActPrev" id="txtActPrev"value="<system:edit show="value" from="theEdition" field="tskSchPrvActTime"/>"></div></div><div class="fieldGroup"><div class="title"><system:label show="text" label="sbtWeekData" /></div><div class="field"><label title="<system:label show="tooltip" label="lblSubHoraria" />"><system:label show="text" label="lblSubHoraria" />:</label><select class="small40" name="selFrec" id="selFrec" style="margin-right: 5px;"><system:edit show="iteration" from="theBean" field="frecCol" saveOn="frec"><option value="<system:edit show="value" from="frec" decoder="biz.statum.apia.web.decoder.IntegerDecoder"/>"
								<system:edit show="ifValue" from="theBean" field="tskSchWeekFrec" value="with:frec">selected</system:edit>
						><system:edit show="value" from="frec" decoder="biz.statum.apia.web.decoder.IntegerDecoder"/></option></system:edit><option value="0"><system:label show="text" label="lblOther" /></option></select><input class="small40" type="text" name="txtOthFrec" id="txtOthFrec" 
					<system:edit show="ifValue" from="theBean" field="isComboFrec" value="true">disabled</system:edit>  
					value="<system:edit show="ifNotValue" from="theBean" field="isComboFrec" value="true"><system:edit show="value" from="theBean" field="tskSchWeekFrec"/></system:edit>"><input type="hidden" name="txtHidFrec" id="txtHidFrec" value="<system:edit show="value" from="theBean" field="tskSchWeekFrec"/>"></div><div class="field required"><label title="<system:label show="tooltip" label="lblOvrAsign" />"><system:label show="text" label="lblOvrAsign" />:</label><input class="numeric" type="text" name="txtOvrAsign" id="txtOvrAsign" value="<system:edit show="value" from="theBean" field="tskSchWeekOvrAsgn"/>"></div></div><div class="fieldGroup"><%@include file="../../includes/schedulerDesign.jsp" %></div><div class="fieldGroup"><div class="field" style="width:100%"><div class="title"><system:label show="text" label="sbtExclusionDays" /></div><div id="excDayContainter" class="modalOptionsContainer"><div class="option dateOption"><input id="inputSbtExclusionDays" class="datePicker" type="text" value="" size=10></div></div><div class="clear"></div></div></div></div></div>