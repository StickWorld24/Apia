<%@page import="biz.statum.apia.web.bean.design.BPMNProcessBean"%>
<script type="text/javascript">
	var NO_SEL_CAL				= '<system:label show="text" label="msgSelCal" forScript="true" />';	
	var IDENTIFIER_TXT_FIXED 	= '<system:edit show="constant" from="com.dogma.vo.ProcessVo" field="IDENTIFIER_TXT_FIXED" />';
	var PATH_IMG				= '<system:edit show="value" from="theBean" field="imgPath" />';
	var TEMP_COMPLETE			= '<system:edit show="constant" from="com.dogma.vo.custom.TemplateVo" field="TEMP_COMPLETE"/>';
	var NO_CLASSIFICATIONS		= '<system:label show="text" label="msgNoCateg" forScript="true" />';
	
	var PRO_TEMPLATE_PAGE		= '<system:util show="context"/>/page/design/bpmn/proTemplates.jsp';
	var MSG_ADD_TEMPLATE		= '<system:label show="text" label="msgAddTemplate" forScript="true" />';
	
	var PATH_IMG				= '<system:edit show="constant" from="com.dogma.vo.ImagesVo" field="IMAGES_UPLOADED" />';
	var DEFAULT_IMG				= '<system:edit show="constant" from="com.dogma.vo.ImagesVo" field="DEFAULT_IMG_PRO" />';
</script>

<div class="aTab">
	<div class="tab" id="tabGenData"><system:label show="text" label="tabProGen" /></div>
	<div class="contentTab" id="contentTabGenData">
		<div class="fieldGroup">
			<div class="title"><system:label show="text" label="sbtDatPro" /></div>				
			
			<system:edit show="ifValue" from="theEdition" field="hasEverBeenInstanced" value="false">
				<div class="field fieldTwoFifths required">
					<label title="<system:label show="tooltip" label="lblNom" />"><system:label show="text" label="lblNom" />:&nbsp;</label>
					<input type="text" name="txtName" id="txtName" maxlength="50" class="validate['required','~validName']" value="<system:edit show="value" from="theEdition" field="proName"/>" onchange="onChangeProName(this);">
				</div>	
			</system:edit>		
			<system:edit show="ifValue" from="theEdition" field="hasEverBeenInstanced" value="true">
				<div class="field fieldTwoFifths">
					<label title="<system:label show="tooltip" label="lblNom" />"><system:label show="text" label="lblNom" />:&nbsp;</label>
					<span><b><system:edit show="value" from="theEdition" field="proName"/></b></span>
					<input type="hidden" id="txtName" name="txtName" value="<system:edit show="value" from="theEdition" field="proName"/>">
				</div>
			</system:edit>
			
			<div class="field fieldTwoFifths required">
				<label title="<system:label show="tooltip" label="lblTit" />"><system:label show="text" label="lblTit" />:&nbsp;</label>
				<input type="text" name="txtTitle" id="txtTitle" maxlength="255" class="validate['required']" value="<system:edit show="value" from="theEdition" field="proTitle"/>" onchange="onChangeProTitle(this);">
			</div>
			
			<div class="field fieldOneFifths fieldLast">
				<label title="<system:label show="tooltip" label="titPrj" />"><system:label show="text" label="titPrj" />:&nbsp;</label>
				<select name="cmbProject" id="cmbProject"  onchange='cmbPrjChange(this)'>
					<system:util show="prepareProjects" saveOn="projects" />
					<system:edit show="iteration" from="projects" saveOn="project">
						<system:edit show="saveValue" from="project" field="prjId" saveOn="prjId"/>
						<option value="<system:edit show="value" from="project" field="prjId"/>"  data-prefix="<system:edit show="value" from="project" field="prjPrefix"/>" <system:edit show="ifValue" from="theEdition" field="prjId" value="with:prjId">selected</system:edit>><system:edit show="value" from="project" field="prjTitle"/></option>
					</system:edit>				   										   					
  					</select>
			</div>
			
			<div class="field fieldFull">
				<label title="<system:label show="tooltip" label="lblDes" />"><system:label show="text" label="lblDes" />:&nbsp;</label>
				<textarea name="txtDesc" id="txtDesc" maxlength="255" cols=80 rows=3><system:edit show="value" from="theEdition" field="proDesc"/></textarea>
			</div>				
		
			<div class="clearLeft"></div>
		
			<system:edit show="ifValue" from="theEdition" field="hasEverBeenInstanced" value="false">
				<div class="field fieldOneThird required">
					<label title="<system:label show="tooltip" label="lblAccPro" />"><system:label show="text" label="lblAccPro" />:&nbsp;</label>
					<select name="cmbAction" id="cmbAction" class="validate['required']" onchange="onChangeCmbAction(this);">
						
						<system:util show="prepareProcessAction" saveOn="types" />
						<system:edit show="iteration" from="types" saveOn="type_save">
							<system:edit show="saveValue" from="type_save" field="type" saveOn="type"/>
							<option value="<system:edit show="value" from="type_save" field="type"/>" <system:edit show="ifValue" field="proAction" value="with:type">selected</system:edit>><system:edit show="value" from="type_save" field="typeName"/></option>
						</system:edit>				   										   					
 					</select>
 				</div>	
			</system:edit>		
			<system:edit show="ifValue" from="theEdition" field="hasEverBeenInstanced" value="true">
				<div class="field fieldOneThird">
					<label title="<system:label show="tooltip" label="lblAccPro" />"><system:label show="text" label="lblAccPro" />:&nbsp;</label>
					<span><b><system:edit show="value" from="theEdition" field="proActionName"/></b></span>
					<input type="hidden" id="cmbAction" name="cmbAction" value="<system:edit show="value" from="theEdition" field="proAction"/>">
				</div>
			</system:edit>
			
			<system:edit show="ifNotExistsValue" from="theEdition" field="entityProcessVo">
				<div class="field fieldOneThird">
					<label title="<system:label show="tooltip" label="lblEntAso" />"><system:label show="text" label="lblEntAso" />:&nbsp;</label>
					<select name="cmbEntAsoc" id="cmbEntAsoc" onchange="onChangeCmbEntAsoc(this)" >
						<option></option>
						<system:util show="prepareProEntitiesName" saveOn="types" />
						<system:edit show="iteration" from="types" saveOn="type_save">
						<system:edit show="saveValue" from="type_save" field="vTitle" saveOn="type"/>
							<option value="<system:edit show="value" from="type_save" field="vTitle"/>"><system:edit show="value" from="type_save" field="tTitleName"/></option>
						</system:edit>				   										   					
 					</select>
 				</div>	
			</system:edit>				
			<system:edit show="ifExistsValue" from="theEdition" field="entityProcessVo">
				<div class="field fieldOneThird">
					<label title="<system:label show="tooltip" label="lblEntAso" />"><system:label show="text" label="lblEntAso" />:&nbsp;</label>
					<span><b><system:edit show="value" from="theEdition" field="entityProcessName"></system:edit></b></span>
					<input type="hidden" name="cmbEntAsoc" id="cmbEntAsoc" value="<system:edit show="value" from="theEdition" field="entityProcessId"/>">
				</div>
			</system:edit>
		
			<div class="field fieldOneThird">
				<label title="<system:label show="tooltip" label="lblQry" />"><system:label show="text" label="lblQry" />:&nbsp;</label>
				<select name="cmbQryAsoc" id="cmbQryAsoc" initial_value="<system:edit show="value" from="theEdition" field="qryId"/>"></select>
			</div>
			
			<div class="field fieldOneThird">
				<label title="<system:label show="tooltip" label="lblSimCalendar" />" class="label"><system:label show="text" label="lblSimCalendar" />:&nbsp;</label>
				<select name="cmbCalendar" id="cmbCalendar" >
					<option></option>
					<system:util show="prepareCalendars" saveOn="calendars" />
					<system:edit show="iteration" from="calendars" saveOn="calendar">
						<system:edit show="saveValue" from="calendar" field="calendarId" saveOn="calId"/>
						<option value="<system:edit show="value" from="calendar" field="calendarId"/>" <system:edit show="ifValue" from="theEdition" field="calendarId" value="with:calId">selected</system:edit>><system:edit show="value" from="calendar" field="calendarName"/></option>
					</system:edit>						    										   					
 				</select>
			</div>
			
			<div class="field fieldOneThird" id="divTemplate">
				<label title="<system:label show="tooltip" label="lblTem" />" class="label"><system:label show="text" label="lblTem" />:&nbsp;</label>
				<select name="cmbTemplate" id="cmbTemplate" onchange="onChangeCmbTemplate(this);">
					<system:util show="showPrepareProTemplatesForModal" saveOn="templates" />
					<system:edit show="iteration" from="templates" saveOn="template">
						<system:edit show="saveValue" from="template" field="name" saveOn="name"/>
						<option value="<system:edit show="value" from="template" field="name"/>" forModal="<system:edit show="value" from="template" field="idForModal"/>" <system:edit show="ifValue" from="theEdition" field="proExeTemplate" value="with:name">selected</system:edit>><system:edit show="value" from="template" field="location"/></option>
					</system:edit>	
					<option value="<CUSTOM>" idForModal="<system:edit show="constant" from="com.dogma.vo.custom.TemplateVo" field="TEMP_CUSTOM"/>" <system:edit show="ifValue" from="theBean" field="customTemplate" value="true" >selected</system:edit>><system:label show="text" label="lblTemCustom" /></option>
				</select>						
 			</div>
 				
 			<div class="field fieldOneThird">
 					<label>&nbsp;</label>
 					<input type="text" id="txtTemplate" name="txtTemplate" style="visibility: hidden;" value="<system:edit show="ifValue" from="theBean" field="customTemplate" value="true"><system:edit show="value" from="theEdition" field="proExeTemplate"/></system:edit>" />
 			</div>
 			
		</div>	
			
		<div class="fieldGroup splitOneThirdImg">
			<div class="field">
				<label title="<system:label show="tooltip" label="prpImg" />" class="label"><system:label show="text" label="prpImg" />:&nbsp;</label>
			</div>
			<div class="field fieldImg">
				<div class="imagePicker" style="background-image: url(<system:edit show="value" from="theBean" field="imgFullPath" />)" id="changeImg">
					<input type="hidden" name="txtPathImg" id="txtPathImg" value="<system:edit show="value" from="theEdition" field="imgPath" />" />										
				</div>
			</div>
		</div>
		
		<div class="fieldGroup splitTwoThird">
			<label title="<system:label show="tooltip" label="titCla" />" class="label"><system:label show="text" label="titCla" />:&nbsp;</label>
			<div class="modalOptionsContainer" id="divClassifications">
				<div class="optionCategoryTree" id="divOptionClaTree"><ul id="claContainer"></ul></div>
				<input type="hidden" id="txtCla" name="txtCla">
			</div>
		</div>						
		
		<div class="fieldGroup">
			<div class="field fieldOneThird" <system:edit show="ifValue" from="theBean" field="existCalendars" value="false">style="display: none;"</system:edit>>
				<label title="<system:label show="tooltip" label="lblNotCalChange" />" class="label"><system:label show="text" label="lblNotCalChange" />:&nbsp;</label>
				<input type="checkbox" id="flagNotAllowCal" name="flagNotAllowCal" <system:edit show="ifFlag" from="theEdition" field="13" >checked</system:edit> />
			</div>
				
			<div class="field fieldOneThird">
				<label title="<system:label show="tooltip" label="lblProCreateFun" />" class="label"><system:label show="text" label="lblProCreateFun" />:&nbsp;</label>
				<input type="checkbox" id="chkCreFnc" name="chkCreFnc" <system:edit show="ifExistsValue" from="theEdition" field="fncId" >checked="true" </system:edit> <system:edit show="ifValue" from="theEdition" field="fncInProfile" value="true">disabled="true" </system:edit>/>
			</div>
				
			<div class="field fieldOneThird">
				<label title="<system:label show="tooltip" label="lblProHidFun" />" class="label"><system:label show="text" label="lblProHidFun" />:&nbsp;</label>
				<input type="checkbox" id="flagNotShowMenu" name="flagNotShowMenu" <system:edit show="ifFlag" from="theEdition" field="3" >checked</system:edit> />
			</div>
				
			<div class="field fieldOneThird">
				<label title="<system:label show="tooltip" label="lblPerDel" />" class="label"><system:label show="text" label="lblPerDel" />:&nbsp;</label>
				<input type="checkbox" id="flagAllowDel" name="flagAllowDel" <system:edit show="ifFlag" from="theEdition" field="4" >checked</system:edit> />
			</div>
				
			<div class="field fieldOneThird">
				<label title="<system:label show="tooltip" label="lblMsgProcCreated" />" class="label"><system:label show="text" label="lblMsgProcCreated" />:&nbsp;</label>
				<input type="checkbox" id="flagMsgProCre" name="flagMsgProCre" <system:edit show="ifValue" from="theEdition" field="msgProCreChecked" value="true">checked</system:edit> />
			</div>
			
			<div class="field fieldOneThird">
				<label title="<system:label show="tooltip" label="lblMsgEntCreated" />" class="label"><system:label show="text" label="lblMsgEntCreated" />:&nbsp;</label>
				<input type="checkbox" id="flagMsgEntCre" name="flagMsgEntCre" <system:edit show="ifValue" from="theEdition" field="msgEntCreChecked" value="true">checked</system:edit> />
			</div>
				
		</div>
		<div class="fieldGroup">
			<div class="field fieldOneThird" id="divFlagMsgCustCreTxt">
				<label title="<system:label show="tooltip" label="lblMsgCustomCreated" />" class="label"><system:label show="text" label="lblMsgCustomCreated" />:&nbsp;</label>
				<input type="checkbox" id="flagMsgCustCre" name="flagMsgCustCre" <system:edit show="ifFlag" from="theEdition" field="11">checked</system:edit> onchange="onChangeFlagMsgCustCre(this)"/>
			</div>
			<div class="field fieldOneThird">
				<label>&nbsp;</label>
				<input type="text" id="flagMsgCustCreTxt" name="flagMsgCustCreTxt" maxlength="255" style="visibility: hidden;" <system:edit show="ifFlag" from="theEdition" field="11">value="<system:edit show="value" from="theEdition" field="customMsg"/>"</system:edit>/>
			</div>
		</div>
		
		<div class="fieldGroup">
			<div class="field fieldOneThird">
				<label title="<system:label show="tooltip" label="lblPubRSSPro" />" class="label"><system:label show="text" label="lblPubRSSPro" />:&nbsp;</label>
				<input type="checkbox" id="flagPubRSS" name="flagPubRSS" <system:edit show="ifFlag" from="theEdition" field="14">checked</system:edit> />
			</div>
			<div class="field fieldOneThird">
				<label title="<system:label show="tooltip" label="lblEnableSocial" />" class="label"><system:label show="text" label="lblEnableSocial" />:&nbsp;</label>
				<input type="checkbox" id="flagEnableSocial" name="flagEnableSocial" <system:edit show="ifNotFlag" from="theEdition" field="17">checked</system:edit> />
			</div>
		</div>
				
		<div class="fieldGroup">
			<div class="field fieldOneThird">
				<label title="<system:label show="tooltip" label="lblEmbedSignature" />" class="label"><system:label show="text" label="lblEmbedSignature" />:&nbsp;</label>
				<select name="flagEmbedSignature" id="flagEmbedSignature">
					<option value="" <%=dBean.getProcessVo().getFlagValue(15) ? "" : "selected"%>></option>
					<option value="1" <%=dBean.getProcessVo().getFlagValue(15) && dBean.getProcessVo().getFlagValue(16) ? "selected" : ""%>><system:label show="text" label="lblYes" /></option>
					<option value="2" <%=dBean.getProcessVo().getFlagValue(15) && !dBean.getProcessVo().getFlagValue(16) ? "selected" : ""%>><system:label show="text" label="lblNo" /></option>
				</select>	
			</div>
		</div>
		
		<div class="fieldGroup" <system:edit show="ifValue" from="theBean" field="modeCreate" value="true">style="display: none;"</system:edit>>
			<div class="field fieldFull">
				<label title="<system:label show="tooltip" label="lblExternalUrlAccess" />" class="label"><system:label show="text" label="lblExternalUrlAccess" />:&nbsp;</label>
				<span><system:edit show="value" from="theBean" field="processUrl" /></span>										
			</div>
		</div>						
		
		<div class="fieldGroup">							
			<div class="title"><system:label show="text" label="sbtDefIde" /></div>	
			
			<div class="splitOneThird">
				<div class="defLbl div-with-options">
					<label title="<system:label show="tooltip" label="lblPre" />" class="label"><system:label show="text" label="lblPre" />:&nbsp;</label>
				</div>
			
				<div class="oneLineRadio">
					<input type="radio" name="radIdePre" id="radIdePreNo" onclick="changeIdePre(this);" value="<system:edit show="constant" from="com.dogma.vo.ProcessVo" field="IDENTIFIER_TXT_NOT_USE" />" <system:edit show="value" from="theBean" field="radIdePreNoChecked" /> <system:edit show="value" from="theBean" field="radIdePreNoDisabled" />>
					<label title="<system:label show="tooltip" label="lblNoUsa" />" for="radIdePreNo" class="label"><system:label show="text" label="lblNoUsa" /></label>
				</div>
			
				<div>&nbsp;</div>
			
				<div class="oneLineRadio"> 	
					<input type="radio" name="radIdePre" id="radIdePreAll" onclick="changeIdePre(this);" value="<system:edit show="constant" from="com.dogma.vo.ProcessVo" field="IDENTIFIER_TXT_WRITE" />" <system:edit show="value" from="theBean" field="radIdePreAllChecked" /> <system:edit show="value" from="theBean" field="radIdePreAllDisabled" /> >
					<label title="<system:label show="tooltip" label="lblPerIng" />" for="radIdePreAll" class="label"><system:label show="text" label="lblPerIng" /></label>
				</div>
			
				<div>&nbsp;</div>	
			
				<div class="oneLineRadio" id="divMandatoryIdePre">
					<input type="radio" name="radIdePre" id="radIdePreFix" onclick="changeIdePre(this);" value="<system:edit show="constant" from="com.dogma.vo.ProcessVo" field="IDENTIFIER_TXT_FIXED" />" <system:edit show="value" from="theBean" field="radIdePreFixChecked" /> <system:edit show="value" from="theBean" field="radIdePreFixDisabled" />>
					<label title="<system:label show="tooltip" label="lblFij" />" for="radIdePreFix" class="label"><system:label show="text" label="lblFij" /></label>
					<input type=text size=6 maxlength=50 name="txtIdePre" id="txtIdePre" value="<system:edit show="value" from="theEdition" field="proIdePreFix" />" <system:edit show="ifNotValue" from="theBean" field="radIdePreFixChecked" value="checked">readonly class="readonly"</system:edit> <system:edit show="value" from="theBean" field="radIdePreFixDisabled" />/>
				</div>	
			</div>
			
			<div class="splitOneThird">
				<div class="defLbl div-with-options">
					<label title="<system:label show="tooltip" label="lblNumero" />" class="label"><system:label show="text" label="lblNumero" />:&nbsp;</label>
				</div>
			
				<div class="oneLineRadio">
					<input type="radio" name="radIdeNum" id="radIdeNumAuto" value="<system:edit show="constant" from="com.dogma.vo.ProcessVo" field="IDENTIFIER_NUM_AUTO" />" <system:edit show="value" from="theBean" field="radIdeNumAuto" /> <system:edit show="value" from="theBean" field="radIdeNumAutoDisabled" />>
					<label title="<system:label show="tooltip" label="lblAutNum" />" for="radIdeNumAuto" class="label"><system:label show="text" label="lblAutNum" /></label>
				</div>
			
				<div>&nbsp;</div>
			
				<div class="oneLineRadio"> 	
					<input type="radio" name="radIdeNum" id="radIdeNumReq" value="<system:edit show="constant" from="com.dogma.vo.ProcessVo" field="IDENTIFIER_NUM_WRITE" />" <system:edit show="value" from="theBean" field="radIdeNumReq" /> <system:edit show="value" from="theBean" field="radIdeNumReqDisabled" />>
					<label title="<system:label show="tooltip" label="lblExiIng" />" for="radIdeNumReq" class="label"><system:label show="text" label="lblExiIng" /></label>
				</div>
			
				<div>&nbsp;</div>	
			
				<div class="oneLineRadio">
					<input type="radio" name="radIdeNum" id="radIdeNumBoth" value="<system:edit show="constant" from="com.dogma.vo.ProcessVo" field="IDENTIFIER_NUM_BOTH" />" <system:edit show="value" from="theBean" field="radIdeNumBoth" /> <system:edit show="value" from="theBean" field="radIdeNumBothDisabled" />>
					<label title="<system:label show="tooltip" label="lblAmbos" />"  for="radIdeNumBoth" class="label"><system:label show="text" label="lblAmbos" /></label>
				</div>	
			</div>	
			
			<div class="splitOneThird">
				<div class="defLbl div-with-options">
					<label title="<system:label show="tooltip" label="lblSuf" />" class="label"><system:label show="text" label="lblSuf" />:&nbsp;</label>
				</div>
			
				<div class="oneLineRadio">
					<input type="radio" name="radIdePos" id="radIdePosNo" onclick="changeIdePos(this);" value="<system:edit show="constant" from="com.dogma.vo.ProcessVo" field="IDENTIFIER_TXT_NOT_USE" />" <system:edit show="value" from="theBean" field="radIdePosNoChecked" /> <system:edit show="value" from="theBean" field="radIdePosNoDisabled" />>
					<label title="<system:label show="tooltip" label="lblNoUsa" />" for="radIdePosNo" class="label"><system:label show="text" label="lblNoUsa" /></label>
				</div>
			
				<div>&nbsp;</div>
			
				<div class="oneLineRadio"> 	
					<input type="radio" name="radIdePos" id="radIdePosAll" onclick="changeIdePos(this);" value="<system:edit show="constant" from="com.dogma.vo.ProcessVo" field="IDENTIFIER_TXT_WRITE" />" <system:edit show="value" from="theBean" field="radIdePosAllChecked" /> <system:edit show="value" from="theBean" field="radIdePosAllDisabled" />>
					<label title="<system:label show="tooltip" label="lblPerIng" />" for="radIdePosAll" class="label"><system:label show="text" label="lblPerIng" /></label>
				</div>
			
				<div>&nbsp;</div>	
			
				<div class="oneLineRadio" id="divMandatoryIdePos">											
					<input type="radio" name="radIdePos" id="radIdePosFix" onclick="changeIdePos(this);" value="<system:edit show="constant" from="com.dogma.vo.ProcessVo" field="IDENTIFIER_TXT_FIXED" />" <system:edit show="value" from="theBean" field="radIdePosFixChecked" /> <system:edit show="value" from="theBean" field="radIdePosFixDisabled" />>
					<label title="<system:label show="tooltip" label="lblFij" />" for="radIdePosFix" class="label"><system:label show="text" label="lblFij" /></label>
					<input type=text size=6 maxlength=50 name="txtIdePos" id="txtIdePos" value="<system:edit show="value" from="theEdition" field="proIdePosFix" />" <system:edit show="ifNotValue" from="theBean" field="radIdePosFixChecked" value="checked">readonly class="readonly"</system:edit> <system:edit show="value" from="theBean" field="radIdePosFixDisabled" /> />		
				</div>	
			</div>	
			
			<div style="height: 35px; display: block;"></div>																		
		</div>	
	</div>
</div>