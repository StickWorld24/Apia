<%@include file="../../includes/startInc.jsp" %><html lang="<%=biz.statum.apia.web.bean.BasicBeanStatic.getUserDataStatic(request).getLangCode()%>"><head><%@include file="../../includes/headInclude.jsp" %><script type="text/javascript" src="<system:util show="context" />/page/administration/calendars/edit.js"></script><script type="text/javascript" src="<system:util show="context" />/page/includes/adminActionsEdition.js"></script><script type="text/javascript" src="<system:util show="context" />/page/includes/navButtons.js"></script><script type="text/javascript" src="<system:util show="context" />/page/includes/campaigns.js"></script><script type="text/javascript">
		var URL_REQUEST_AJAX 	= '/apia.administration.CalendarsAction.run';
		var TT_ADD_FREE_DAY		= '<system:label show="text" label="lblAddHol" forScript="true" />';
		var TT_SHOW_YEAR		= '<system:label show="text" label="lblShowYear" forScript="true" />';
		var SELECT_DAY			= '<system:label show="text" label="msgSelDay" forScript="true" />';
		var INCORRECT_DAY		= '<system:label show="text" label="msgWrngInt" forScript="true" />';		
	</script></head><body><div id="exec-blocker"></div><div class="body" id="bodyDiv"><form id="frmData"><div class="optionsContainer"><system:campaign inLogin="false" inSplash="false" location="verticalUp" /><div class="fncPanel info"><div class="title"><system:label show="text" label="mnuCalend" /><%@include file="../../includes/adminFav.jsp" %></div><div class="content divFncDescription"><div class="fncDescriptionImage" data-src="<system:edit show="value" from="theBean" field="fncImage"/>"></div><div id="fncDescriptionText"><system:label show="text" label="dscFncAdmCal"/></div><div class="clear"></div></div></div><%@include file="../../includes/adminActionsEdition.jsp" %><system:campaign inLogin="false" inSplash="false" location="verticalDown" /></div><div class="dataContainer"><div class='tabComponent' id="tabComponent"><div class="aTabHeader"><system:campaign inLogin="false" inSplash="false" location="horizontalUp" /></div><!-- DATOS GENERALES --><div class="aTab"><div class="tab" id="tabGenData"><system:label show="text" label="tabDatGen" /></div><div class="contentTab" id="contentTabGenData"><div><div class="fieldGroup"><div class="title"><system:label show="text" label="sbtGenData" /></div><div class="field fieldTwoFifths required"><label title="<system:label show="tooltip" label="lblNom" />"><system:label show="text" label="lblNom" />:</label><input type="text" name="calName" id="calName" class="validate['required','~validName']" maxlength="50" value="<system:edit show="value" from="theEdition" field="calendarName"/>"></div><div class="field fieldFull"><label title="<system:label show="tooltip" label="lblDes" />"><system:label show="text" label="lblDes" />:</label><textarea type="text" name="calDesc" id="calDesc" maxlength="255" cols=80 rows=3><system:edit show="value" from="theEdition" field="calendarDesc"/></textarea></div></div><div class="fieldGroup"><div class="title"><system:label show="text" label="sbtDatDayLab" /></div><table><!-- LUNES --><tr><td><label title="<system:label show="tooltip" label="lblLunes" />" class="validate['~validLabel']" day="2"><system:label show="text" label="lblLunes" />:</label></td><td><input type="checkbox" name="chk2" id="chk2" onchange="enableDisableAllDay(this,2)"></td><td class="modalOptionsContainer"><div ><div class="option"><label title="<system:label show="tooltip" label="lblAllDay"/>" day="2"><system:label show="text" label="lblAllDay" /></label><input type="checkbox" name="allDayChk2" id="allDayChk2" onchange="enableDisableLabDay(this,2,0,0)"></div></div></td><td align="center" style="width: 100px;"><label title="<system:label show="tooltip" label="lblHorSta" />"><system:label show="text" label="lblHorSta" />:</label><select name="cmbSta2" id="cmbSta2" style="width:55px" disabled ><system:util show="prepareHoursLabDays" saveOn="hours" /><system:edit show="iteration" from="hours" saveOn="hour_save"><system:edit show="saveValue" from="hour_save" field="vHour" saveOn="hour"/><option value="<system:edit show="value" from="hour_save" field="vHour"/>"><system:edit show="value" from="hour_save" field="tHour"/></option></system:edit></select></td><td></td><td align="center" style="width: 100px;"><label title="<system:label show="tooltip" label="lblHorEnd" />"><system:label show="text" label="lblHorEnd" />:</label><select name="cmbEnd2" id="cmbEnd2" style="width:55px" disabled><system:util show="prepareHoursLabDays" saveOn="hours" /><system:edit show="iteration" from="hours" saveOn="hour_save"><system:edit show="saveValue" from="hour_save" field="vHour" saveOn="hour"/><option value="<system:edit show="value" from="hour_save" field="vHour"/>"><system:edit show="value" from="hour_save" field="tHour"/></option></system:edit></select></td></tr><!-- MARTES --><tr><td><label title="<system:label show="tooltip" label="lblMartes" />" class="validate['~validLabel']" day="3"><system:label show="text" label="lblMartes" />:</label></td><td><input type="checkbox" name="chk3" id="chk3" onchange="enableDisableAllDay(this,3)"></td><td class="modalOptionsContainer"><div ><div class="option"><label title="<system:label show="tooltip" label="lblAllDay"/>" day="3"><system:label show="text" label="lblAllDay" /></label><input type="checkbox" name="allDayChk3" id="allDayChk3" onchange="enableDisableLabDay(this,3,0,0)"></div></div></td><td align="center" style="width: 100px;"><label title="<system:label show="tooltip" label="lblHorSta" />"><system:label show="text" label="lblHorSta" />:</label><select name="cmbSta3" id="cmbSta3" style="width:55px" disabled ><system:util show="prepareHoursLabDays" saveOn="hours" /><system:edit show="iteration" from="hours" saveOn="hour_save"><system:edit show="saveValue" from="hour_save" field="vHour" saveOn="hour"/><option value="<system:edit show="value" from="hour_save" field="vHour"/>"><system:edit show="value" from="hour_save" field="tHour"/></option></system:edit></select></td><td></td><td align="center" style="width: 100px;"><label title="<system:label show="tooltip" label="lblHorEnd" />"><system:label show="text" label="lblHorEnd" />:</label><select name="cmbEnd3" id="cmbEnd3" style="width:55px" disabled><system:util show="prepareHoursLabDays" saveOn="hours" /><system:edit show="iteration" from="hours" saveOn="hour_save"><system:edit show="saveValue" from="hour_save" field="vHour" saveOn="hour"/><option value="<system:edit show="value" from="hour_save" field="vHour"/>"><system:edit show="value" from="hour_save" field="tHour"/></option></system:edit></select></td></tr><!-- MIERCOLES --><tr><td><label title="<system:label show="tooltip" label="lblMiercoles" />" class="validate['~validLabel']" day="4"><system:label show="text" label="lblMiercoles" />:</label></td><td><input type="checkbox" name="chk4" id="chk4" onchange="enableDisableAllDay(this,4,0,0)" ></td><td class="modalOptionsContainer"><div ><div class="option"><label title="<system:label show="tooltip" label="lblAllDay"/>" day="4"><system:label show="text" label="lblAllDay" /></label><input type="checkbox" name="allDayChk4" id="allDayChk4" onchange="enableDisableLabDay(this,4,0,0)"></div></div></td><td align="center" style="width: 100px;"><label title="<system:label show="tooltip" label="lblHorSta" />"><system:label show="text" label="lblHorSta" />:</label><select name="cmbSta4" id="cmbSta4" style="width:55px" disabled ><system:util show="prepareHoursLabDays" saveOn="hours" /><system:edit show="iteration" from="hours" saveOn="hour_save"><system:edit show="saveValue" from="hour_save" field="vHour" saveOn="hour"/><option value="<system:edit show="value" from="hour_save" field="vHour"/>"><system:edit show="value" from="hour_save" field="tHour"/></option></system:edit></select></td><td></td><td align="center" style="width: 100px;"><label title="<system:label show="tooltip" label="lblHorEnd" />"><system:label show="text" label="lblHorEnd" />:</label><select name="cmbEnd4" id="cmbEnd4" style="width:55px" disabled><system:util show="prepareHoursLabDays" saveOn="hours" /><system:edit show="iteration" from="hours" saveOn="hour_save"><system:edit show="saveValue" from="hour_save" field="vHour" saveOn="hour"/><option value="<system:edit show="value" from="hour_save" field="vHour"/>"><system:edit show="value" from="hour_save" field="tHour"/></option></system:edit></select></td></tr><!-- JUEVES --><tr><td><label title="<system:label show="tooltip" label="lblJueves" />" class="validate['~validLabel']" day="5"><system:label show="text" label="lblJueves" />:</label></td><td><input type="checkbox" name="chk5" id="chk5" onchange="enableDisableAllDay(this,5,0,0)" ></td><td class="modalOptionsContainer"><div ><div class="option"><label title="<system:label show="tooltip" label="lblAllDay"/>" day="5"><system:label show="text" label="lblAllDay" /></label><input type="checkbox" name="allDayChk5" id="allDayChk5" onchange="enableDisableLabDay(this,5,0,0)"></div></div></td><td align="center" style="width: 100px;"><label title="<system:label show="tooltip" label="lblHorSta" />"><system:label show="text" label="lblHorSta" />:</label><select name="cmbSta5" id="cmbSta5" style="width:55px" disabled ><system:util show="prepareHoursLabDays" saveOn="hours" /><system:edit show="iteration" from="hours" saveOn="hour_save"><system:edit show="saveValue" from="hour_save" field="vHour" saveOn="hour"/><option value="<system:edit show="value" from="hour_save" field="vHour"/>"><system:edit show="value" from="hour_save" field="tHour"/></option></system:edit></select></td><td></td><td align="center" style="width: 100px;"><label title="<system:label show="tooltip" label="lblHorEnd" />"><system:label show="text" label="lblHorEnd" />:</label><select name="cmbEnd5" id="cmbEnd5" style="width:55px" disabled><system:util show="prepareHoursLabDays" saveOn="hours" /><system:edit show="iteration" from="hours" saveOn="hour_save"><system:edit show="saveValue" from="hour_save" field="vHour" saveOn="hour"/><option value="<system:edit show="value" from="hour_save" field="vHour"/>"><system:edit show="value" from="hour_save" field="tHour"/></option></system:edit></select></td></tr><!-- VIERNES --><tr><td><label title="<system:label show="tooltip" label="lblViernes" />" class="validate['~validLabel']" day="6"><system:label show="text" label="lblViernes" />:</label></td><td><input type="checkbox" name="chk6" id="chk6" onchange="enableDisableAllDay(this,6,0,0)" ></td><td class="modalOptionsContainer"><div ><div class="option"><label title="<system:label show="tooltip" label="lblAllDay"/>" day="6"><system:label show="text" label="lblAllDay" /></label><input type="checkbox" name="allDayChk6" id="allDayChk6" onchange="enableDisableLabDay(this,6,0,0)"></div></div></td><td align="center" style="width: 100px;"><label title="<system:label show="tooltip" label="lblHorSta" />"><system:label show="text" label="lblHorSta" />:</label><select name="cmbSta6" id="cmbSta6" style="width:55px" disabled ><system:util show="prepareHoursLabDays" saveOn="hours" /><system:edit show="iteration" from="hours" saveOn="hour_save"><system:edit show="saveValue" from="hour_save" field="vHour" saveOn="hour"/><option value="<system:edit show="value" from="hour_save" field="vHour"/>"><system:edit show="value" from="hour_save" field="tHour"/></option></system:edit></select></td><td></td><td align="center" style="width: 100px;"><label title="<system:label show="tooltip" label="lblHorEnd" />"><system:label show="text" label="lblHorEnd" />:</label><select name="cmbEnd6" id="cmbEnd6" style="width:55px" disabled><system:util show="prepareHoursLabDays" saveOn="hours" /><system:edit show="iteration" from="hours" saveOn="hour_save"><system:edit show="saveValue" from="hour_save" field="vHour" saveOn="hour"/><option value="<system:edit show="value" from="hour_save" field="vHour"/>"><system:edit show="value" from="hour_save" field="tHour"/></option></system:edit></select></td></tr><!-- SABADO --><tr><td><label title="<system:label show="tooltip" label="lblSabado" />" class="validate['~validLabel']" day="7"><system:label show="text" label="lblSabado" />:</label></td><td><input type="checkbox" name="chk7" id="chk7" onchange="enableDisableAllDay(this,7,0,0)" ></td><td class="modalOptionsContainer"><div ><div class="option"><label title="<system:label show="tooltip" label="lblAllDay"/>" day="7"><system:label show="text" label="lblAllDay" /></label><input type="checkbox" name="allDayChk7" id="allDayChk7" onchange="enableDisableLabDay(this,7,0,0)"></div></div></td><td align="center" style="width: 100px;"><label title="<system:label show="tooltip" label="lblHorSta" />"><system:label show="text" label="lblHorSta" />:</label><select name="cmbSta7" id="cmbSta7" style="width:55px" disabled ><system:util show="prepareHoursLabDays" saveOn="hours" /><system:edit show="iteration" from="hours" saveOn="hour_save"><system:edit show="saveValue" from="hour_save" field="vHour" saveOn="hour"/><option value="<system:edit show="value" from="hour_save" field="vHour"/>"><system:edit show="value" from="hour_save" field="tHour"/></option></system:edit></select></td><td></td><td align="center" style="width: 100px;"><label title="<system:label show="tooltip" label="lblHorEnd" />"><system:label show="text" label="lblHorEnd" />:</label><select name="cmbEnd7" id="cmbEnd7" style="width:55px" disabled><system:util show="prepareHoursLabDays" saveOn="hours" /><system:edit show="iteration" from="hours" saveOn="hour_save"><system:edit show="saveValue" from="hour_save" field="vHour" saveOn="hour"/><option value="<system:edit show="value" from="hour_save" field="vHour"/>"><system:edit show="value" from="hour_save" field="tHour"/></option></system:edit></select></td></tr><!-- DOMINGO --><tr><td><label title="<system:label show="tooltip" label="lblDomingo" />" class="validate['~validLabel']" day="1"><system:label show="text" label="lblDomingo" />:</label></td><td><input type="checkbox" name="chk1" id="chk1" onchange="enableDisableAllDay(this,1,0,0)" ></td><td class="modalOptionsContainer"><div ><div class="option"><label title="<system:label show="tooltip" label="lblAllDay"/>" day="1"><system:label show="text" label="lblAllDay" /></label><input type="checkbox" name="allDayChk1" id="allDayChk1" onchange="enableDisableLabDay(this,1,0,0)"></div></div></td><td align="center" style="width: 100px;"><label title="<system:label show="tooltip" label="lblHorSta" />"><system:label show="text" label="lblHorSta" />:</label><select name="cmbSta1" id="cmbSta1" style="width:55px" disabled ><system:util show="prepareHoursLabDays" saveOn="hours" /><system:edit show="iteration" from="hours" saveOn="hour_save"><system:edit show="saveValue" from="hour_save" field="vHour" saveOn="hour"/><option value="<system:edit show="value" from="hour_save" field="vHour"/>"><system:edit show="value" from="hour_save" field="tHour"/></option></system:edit></select></td><td></td><td align="center" style="width: 100px;"><label title="<system:label show="tooltip" label="lblHorEnd" />"><system:label show="text" label="lblHorEnd" />:</label><select name="cmbEnd1" id="cmbEnd1" style="width:55px" disabled><system:util show="prepareHoursLabDays" saveOn="hours" /><system:edit show="iteration" from="hours" saveOn="hour_save"><system:edit show="saveValue" from="hour_save" field="vHour" saveOn="hour"/><option value="<system:edit show="value" from="hour_save" field="vHour"/>"><system:edit show="value" from="hour_save" field="tHour"/></option></system:edit></select></td></tr></table></div><div class="fieldGroup"><div class="field" style="width:100%"><div class="title"><system:label show="text" label="lblFerDay" /></div><input type="hidden" id="freeDays" name="freeDays" value=""><div class="modalOptionsContainer" id="freeDaysContainter"><div id="divAddFreeDay" class="option" style="height: 30px;"><input id="addFreeDay" class="datePicker" type="text" value="" size=10></div></div></div></div></div></div></div></div><system:campaign inLogin="false" inSplash="false" location="horizontalDown" /></div></form></div><jsp:include page="../../includes/footer.jsp" /></body></html>
