		<div type="tab" style="visibility:hidden" style="visibility:hidden;" tabTitle="<%=LabelManager.getToolTip(labelSet,"tabDatGen")%>" tabText="<%=LabelManager.getName(labelSet,"tabDatGen")%>"><DIV class="subTit"><%=LabelManager.getName(labelSet,"sbtDatPro")%></DIV><table class="tblFormLayout"><tr><!-- PROYECTOS --><%Collection colProj = dBean.getProjects(request); %><td style="width:20%;" title="<%=LabelManager.getToolTip(labelSet,"titPrj")%>"><%=LabelManager.getNameWAccess(labelSet,"titPrj")%>:</td><td><input type=hidden name="txtPrj" value=""><select name="selPrj" onchange="cmbProySel()" accesskey="<%=LabelManager.getAccessKey(labelSet,"lblPrj")%>"><%if (colProj != null && colProj.size()>0) {
		   					Iterator itPrj = colProj.iterator();
		   					ProjectVo prjVo = null;%><option value="0"></option><%while (itPrj.hasNext()) {
	   							prjVo = (ProjectVo) itPrj.next();%><option value="<%=prjVo.getPrjId()%>"
	   							<%if (hasProject) {
									if (prjVo.getPrjId().equals(proVo.getPrjId())) {
										out.print ("selected");
									}
								}%>
								><%=prjVo.getPrjName()%></option><%}
	   					}%></select></td><td style="width:20%;" title="<%=LabelManager.getToolTip(labelSet,"lblCat")%>"><%=LabelManager.getNameWAccess(labelSet,"lblCat")%>:</td><td rowspan=5 valign=top align=left><div id="tblProfileTree" style="BORDER-LEFT:1px solid #777777;BORDER-RIGHT:1px solid #777777;BORDER-TOP:1px solid gray;BORDER-BOTTOM:1px solid #777777;BACKGROUND-COLOR:#DFDFDF;SCROLLBAR-FACE-COLOR: #DFDFDF;SCROLLBAR-HIGHLIGHT-COLOR: #FFFFFF;SCROLLBAR-SHADOW-COLOR: #C0C0C0;SCROLLBAR-ARROW-COLOR: #808080;SCROLLBAR-DARKSHADOW-COLOR: #808080;SCROLLBAR-BASE-COLOR: #808080;scrollbar-3d-light-color: #808080;OVERFLOW:AUTO;WIDTH:100%;HEIGHT:133px"><%
						  request.setAttribute("envId", dBean.getEnvId(request));
						  request.setAttribute("selCat", proVo.getClaTreId());
						  %><jsp:include page="../clasifications/getClasificationTreeXML.jsp"/></div></td></tr><tr><%if (proVo.hasEverBeenInstanced()) {%><td title="<%=LabelManager.getToolTip(labelSet,"lblNom")%>"><%=LabelManager.getName(labelSet,"lblNom")%>:</td><td class="readOnly" ><input type="hidden" name="txtName" value="<%=dBean.fmtStr(proVo.getProName())%>"><%=dBean.fmtHTML(proVo.getProName())%></td><%} else {%><td title="<%=LabelManager.getToolTip(labelSet,"lblNom")%>"><%=LabelManager.getNameWAccess(labelSet,"lblNom")%>:</td><td><input name="txtName" p_required="true" maxlength="50" accesskey="<%=LabelManager.getAccessKey(labelSet,"lblNom")%>" type="text" value="<%=dBean.fmtStr(proVo.getProName())%>"></td><%}%></tr><tr><td title="<%=LabelManager.getToolTip(labelSet,"lblTit")%>"><%=LabelManager.getNameWAccess(labelSet,"lblTit")%>:</td><td><input name="txtTitle" p_required="true" maxlength="250" accesskey="<%=LabelManager.getAccessKey(labelSet,"lblTit")%>" type="text" value="<%=dBean.fmtStr(proVo.getProTitle())%>" size=30></td></tr><tr><td title="<%=LabelManager.getToolTip(labelSet,"lblDes")%>"><%=LabelManager.getNameWAccess(labelSet,"lblDes")%>:</td><td><TEXTAREA p_maxlength="true" maxlength="255" name="txtDesc" cols=30 rows=4 accesskey="<%=LabelManager.getAccessKey(labelSet,"lblDes")%>"><%=dBean.fmtHTML(proVo.getProDesc())%></TEXTAREA></td></tr><tr><input type="hidden" name="hidUsrCanWrite" value="<%=saveChanges%>"><input type="hidden" name="actualUser" value="<%=dBean.getActualUser(request)%>"></tr><!--     - INDICADOR DE ACCI�N          --><tr><td title="<%=LabelManager.getToolTip(labelSet,"lblAccPro")%>"><%=LabelManager.getNameWAccess(labelSet,"lblAccPro")%>:</td><%if (proVo.hasEverBeenInstanced()) {%><td class="readOnly"><input type="hidden" name="txtProAction"  onChange="loadQuerys()" value="<%= proVo.getProAction() %>"><%	if (ProcessVo.PROCESS_ACTION_CREATION.equals(proVo.getProAction())) {
									out.print(LabelManager.getName(labelSet,"lblAccProCre"));
								} else if (ProcessVo.PROCESS_ACTION_ALTERATION.equals(proVo.getProAction())) {
									out.print(LabelManager.getName(labelSet,"lblAccProAlt"));
								} else if (ProcessVo.PROCESS_ACTION_CANCEL.equals(proVo.getProAction())) {
									out.print(LabelManager.getName(labelSet,"lblAccProCan"));
								}%><% } else { %><td><select name="txtProAction" p_required="true"  onChange="loadQuerys()" accesskey="<%=LabelManager.getAccessKey(labelSet,"lblAccPro")%>"><option value=""></option><option value="<%=ProcessVo.PROCESS_ACTION_CREATION%>"  <%=ProcessVo.PROCESS_ACTION_CREATION.equals(proVo.getProAction())?"selected":""%>><%=LabelManager.getName(labelSet,"lblAccProCre")%></option><%if (envUsesEntities) {%><option value="<%=ProcessVo.PROCESS_ACTION_ALTERATION%>" <%=ProcessVo.PROCESS_ACTION_ALTERATION.equals(proVo.getProAction())?"selected":""%>><%=LabelManager.getName(labelSet,"lblAccProAlt")%></option><%}%><option value="<%=ProcessVo.PROCESS_ACTION_CANCEL%>" <%=ProcessVo.PROCESS_ACTION_CANCEL.equals(proVo.getProAction())?"selected":""%>><%=LabelManager.getName(labelSet,"lblAccProCan")%></option></select><% } %></td></tr><!--     - TIPO DE PROCESO          --><tr style="display:none"><td title="<%=LabelManager.getToolTip(labelSet,"lblTipPro")%>"><%=LabelManager.getNameWAccess(labelSet,"lblTipPro")%>:</td><td><% if (dBean.getOperationType() == com.dogma.bean.administration.BPMNBean.OP_TYPE_INSERT) {%><select name="txtProType" onChange="proTypeChange()" p_required="true" accesskey="<%=LabelManager.getAccessKey(labelSet,"lblTipPro")%>"><option value="<%=ProcessVo.PROCESS_TYPE_AUTO%>" <%=ProcessVo.PROCESS_TYPE_AUTO.equals(proVo.getProType())?"selected":""%>><%=LabelManager.getName(labelSet,"lblTipProAut")%></option><option value="<%=ProcessVo.PROCESS_TYPE_MANUAL%>" <%=ProcessVo.PROCESS_TYPE_MANUAL.equals(proVo.getProType())?"selected":""%>><%=LabelManager.getName(labelSet,"lblTipProMan")%></option></select><% } else {%><input type=hidden name="txtProType" value="<%=dBean.fmtStr(proVo.getProType())%>"><input disabled=true class="txtReadONly" value="<%= proVo.getProType().equals(ProcessVo.PROCESS_TYPE_AUTO) ? LabelManager.getName(labelSet,"lblTipProAut") : LabelManager.getName(labelSet,"lblTipProMan")%>"><% } %></td></tr><!--     - ENTIDAD ASOCIADA          --><%	Collection col = dBean.getBusEntities(request);
   					boolean hasEntity = proVo.getEntityProcessVo() != null;
   					if (col != null && col.size()>0) {%><tr><td title="<%=LabelManager.getToolTip(labelSet,"lblEntAso")%>"><%=LabelManager.getNameWAccess(labelSet,"lblEntAso")%>:</td><%if (hasEntity) {%><td colspan=2 class="readOnly"><input type=hidden name="txtBusEnt" value="<%=proVo.getEntityProcessVo().getBusEntId()%>"><%} else {%><td colspan=2><input type=hidden name="txtBusEnt" value=""><select  onChange="loadQuerys()" name="selBusEnt" onBlur="entBlur()" accesskey="<%=LabelManager.getAccessKey(labelSet,"lblEntAso")%>"><option><%}%><%	Iterator it = col.iterator();
							BusEntityVo entVo = null;
		   					while (it.hasNext()) {
		   						entVo = (BusEntityVo) it.next();
								if (!hasEntity) {%><option value="<%=entVo.getBusEntId()%>" <%
									if (proVo.getEntityProcessVo() != null && entVo.getBusEntId().equals(proVo.getEntityProcessVo().getBusEntId())) {
										out.print ("selected");
									}%>><%=entVo.getBusEntName()%><%} else if (proVo.getEntityProcessVo() != null && entVo.getBusEntId().equals(proVo.getEntityProcessVo().getBusEntId())) {
									out.print(entVo.getBusEntName());
								}
		   					}%></select></td></tr><%} else {%><input type=hidden name="txtBusEnt" value=""><input type=hidden name="selBusEnt" value=""><%}%><!--     - TEMPLATES          --><!-- CONSULTA ASOCIADA --><tr><td title="<%=LabelManager.getToolTip(labelSet,"lblQryAso")%>"><%=LabelManager.getNameWAccess(labelSet,"lblQryAso")%>:</td></td><td><select name="qryId" id="qryId"><option value=""></option><% 
							col = dBean.getQuerys(request);
							if (col != null && col.size() > 0) {
								for (Iterator it = col.iterator(); it.hasNext(); ) {
									QueryVo qryVo = (QueryVo) it.next(); %><option value="<%= qryVo.getQryId() %>" <%= (qryVo.getQryId().equals(proVo.getQryId()))?"selected":"" %>><%= qryVo.getQryName() %></option><% 
								}
							} %></select></td><td title="<%=LabelManager.getToolTip(labelSet,"lblImage")%>"><%=LabelManager.getNameWAccess(labelSet,"lblImage")%>:</td><%String img=( "".equals(proVo.getImgPath()) || proVo.getImgPath()==null  )?"":proVo.getImgPath();%><td><div onClick="openImagePicker(this)" style="cursor:pointer;cursor:hand;position:relative;width:50px;height:50px;background-image:url(<%=Parameters.ROOT_PATH+"/images/"%><%=img==""?"uploaded/procicon.png":"uploaded/"+img%>)"><input type="hidden" name="txtProjImg" id="txtProjImg" value="<%=img%>" /></div></td></tr><!-- TEMPLATES --><tr><td title="<%=LabelManager.getToolTip(labelSet,"lblTem")%>"><%=LabelManager.getNameWAccess(labelSet,"lblTem")%>:</td><td colspan=3 nowrap><select name="txtTemplate" onChange="changeTemplate()" accesskey="<%=LabelManager.getAccessKey(labelSet,"lblTem")%>"><%	String[][] templates = com.dogma.DogmaConstants.PRO_TEMPLATES;
							boolean isCustomTemplate = true;
							for (int i=0;i< templates.length;i++) {
								out.print("<option value=\"" + dBean.fmtStr(templates[i][1]) + "\"" );
								if ((proVo.getProExeTemplate() != null && 
									proVo.getProExeTemplate().equals(templates[i][1])) ||
									proVo.getProExeTemplate() == templates[i][1]) {
									out.print(" selected ");
									isCustomTemplate = false;
								}
								out.print(">");
								out.print(LabelManager.getName(labelSet,templates[i][0]));
								out.print("\n");
							}
							%><option value="<CUSTOM>" <%=isCustomTemplate?"selected":""%>><%=LabelManager.getName(labelSet,"lblTemCustom")%></select>
		   				&nbsp;
						<button type="button" id="btnVerOne" <%if (isCustomTemplate) {%>style="display:none"<%}%> onClick="btnViewTemplate()" accesskey="<%=LabelManager.getAccessKey(labelSet,"btnVer")%>" title="<%=LabelManager.getToolTip(labelSet,"btnVer")%>"><%=LabelManager.getNameWAccess(labelSet,"btnVer")%></button><input id=customTemplate onKeyUp="customKeyPress()" type="text" name="txtCusTemplate" size="40" <%if (!isCustomTemplate) {%>disabled="true" style="display:none"<%} else {%> value="<%=dBean.fmtStr(proVo.getProExeTemplate())%>" <%}%>>
		   				&nbsp;
						<button type="button" id="btnVerTwo" <%if (!isCustomTemplate) {%>style="display:none"<%}%> onClick="btnViewTemplate()" accesskey="<%=LabelManager.getAccessKey(labelSet,"btnVer")%>" title="<%=LabelManager.getToolTip(labelSet,"btnVer")%>"><%=LabelManager.getNameWAccess(labelSet,"btnVer")%></button></td></tr><!-- CALENDARIOS --><%	Collection colCal = dBean.getCalendars();
   					boolean hasCalendar = (proVo.getCalendarId() != null && proVo.getCalendarId().intValue() != 0);
   
   					if (colCal != null && colCal.size()>0) {
   					System.out.println("hasCalendar: "+ hasCalendar);%><tr><td title="<%=LabelManager.getToolTip(labelSet,"titCal")%>"><%=LabelManager.getNameWAccess(labelSet,"titCal")%>:</td><td colspan=2><input type=hidden name="txtCal" value=""><select name="selCal" accesskey="<%=LabelManager.getAccessKey(labelSet,"lblEntAso")%>"><%Iterator itCal = colCal.iterator();
		   					CalendarVo calVo = null;%><option value="0"></option><%
		   					while (itCal.hasNext()) {
		   						calVo = (CalendarVo) itCal.next();%><option value="<%=calVo.getCalendarId()%>" 
		   						<%if (hasCalendar) {
									if (calVo.getCalendarId().equals(proVo.getCalendarId())) {
										out.print ("selected");
									}%>
									><%=calVo.getCalendarName()%></option><%} else {%>
									><%=calVo.getCalendarName()%></option><%}%><%}%></select>
		   				&nbsp;
		   				<button type="button" id="btnVerCal" onClick="btnViewCalendar()" accesskey="<%=LabelManager.getAccessKey(labelSet,"btnVer")%>" title="<%=LabelManager.getToolTip(labelSet,"btnVer")%>"><%=LabelManager.getNameWAccess(labelSet,"btnVer")%></button></td></tr><tr><td title="<%=LabelManager.getToolTip(labelSet,"lblNotCalChange")%>"><%=LabelManager.getNameWAccess(labelSet,"lblNotCalChange")%>:</td><td><input type="checkbox" name="chkDontAllowCalChange" accesskey="<%=LabelManager.getAccessKey(labelSet,"lblAllowCalChange")%>" <%if(proVo.getFlagValue(ProcessVo.FLAG_DONT_ALLOW_CALENDAR_CHANGE)) {%>checked<%}%>></td></tr><%} else { System.out.println("No hay ningun calendario definido");%><input type=hidden name="txtCal" value=""><%}%><tr><td title="<%=LabelManager.getToolTip(labelSet,"lblProHidFun")%>"><%=LabelManager.getNameWAccess(labelSet,"lblProHidFun")%>:</td><td><input type="checkbox" name="chkHidFun" accessKey="<%=LabelManager.getAccessKey(labelSet,"lblProHidFun")%>" <%= proVo.getFlagValue(ProcessVo.FLAG_HIDDE_FUNCTIONALITY)?"checked":""%>></td><td title="<%=LabelManager.getToolTip(labelSet,"lblPerDel")%>"><%=LabelManager.getNameWAccess(labelSet,"lblPerDel")%>:</td><td><input type="checkbox" name="txtPerDel" accesskey="<%=LabelManager.getAccessKey(labelSet,"lblPerDel")%>" <%if(proVo.getFlagValue(ProcessVo.FLAG_DELEGATE)) {%>checked<%}%>></td></tr><tr><td title="<%=LabelManager.getToolTip(labelSet,"lblProCreateFun")%>"><%=LabelManager.getNameWAccess(labelSet,"lblProCreateFun")%>:</td><% if (proVo.isFncInProfile()) { %><td><input type="checkbox" name="chkCreateFunX" accessKey="<%=LabelManager.getAccessKey(labelSet,"lblProCreateFun")%>" disabled checked><input type="hidden" name="chkCreateFun" checked value="true"></td><% } else { %><td><input type="checkbox" name="chkCreateFun" value="true" accessKey="<%=LabelManager.getAccessKey(labelSet,"lblProCreateFun")%>" <%= (proVo.getFncId() != null)?"checked":""%>></td><% } %></tr><tr><td title="<%=LabelManager.getToolTip(labelSet,"lblMsgProcCreated")%>"><%=LabelManager.getNameWAccess(labelSet,"lblMsgProcCreated")%>:</td><td><input type="checkbox" name="chkMsgProc" accessKey="<%=LabelManager.getAccessKey(labelSet,"lblMsgProcCreated")%>" <%if(proVo.isFlagNull(proVo.getProFlags(),ProcessVo.FLAG_MSG_PROCESS_CREATED) || (!proVo.isFlagNull(proVo.getProFlags(),ProcessVo.FLAG_MSG_PROCESS_CREATED) && proVo.getFlagValue(ProcessVo.FLAG_MSG_PROCESS_CREATED))) {%>checked<%}%>></td><td title="<%=LabelManager.getToolTip(labelSet,"lblMsgEntCreated")%>"><%=LabelManager.getNameWAccess(labelSet,"lblMsgEntCreated")%>:</td><%if (proVo.getEntityProcessVo() == null){ %><td><input disabled=true type="checkbox" name="chkMsgEnt" accesskey="<%=LabelManager.getAccessKey(labelSet,"lblMsgEntCreated")%>" <%if(proVo.isFlagNull(proVo.getProFlags(),ProcessVo.FLAG_MSG_ENTITY_CREATED) || (!proVo.isFlagNull(proVo.getProFlags(),ProcessVo.FLAG_MSG_ENTITY_CREATED) && proVo.getFlagValue(ProcessVo.FLAG_MSG_ENTITY_CREATED))) {%>checked<%}%>></td><%} else { %><td><input type="checkbox" name="chkMsgEnt" accesskey="<%=LabelManager.getAccessKey(labelSet,"lblMsgEntCreated")%>" <%if(proVo.isFlagNull(proVo.getProFlags(),ProcessVo.FLAG_MSG_ENTITY_CREATED) || (!proVo.isFlagNull(proVo.getProFlags(),ProcessVo.FLAG_MSG_ENTITY_CREATED) && proVo.getFlagValue(ProcessVo.FLAG_MSG_ENTITY_CREATED))) {%>checked<%}%>></td><%}%></tr><tr><td title="<%=LabelManager.getToolTip(labelSet,"lblMsgCustomCreated")%>"><%=LabelManager.getNameWAccess(labelSet,"lblMsgCustomCreated")%>:</td><td><input type="checkbox" name="chkMsgCustom" onClick="changeCustomMsg()" accesskey="<%=LabelManager.getAccessKey(labelSet,"lblMsgCustomCreated")%>" <%if(proVo.getFlagValue(ProcessVo.FLAG_MSG_CUSTOM_CREATED)) {%>checked<%}%>></td><%if(proVo.getFlagValue(ProcessVo.FLAG_MSG_CUSTOM_CREATED)) {%><td><input name="txtCustomMsg" maxlength="255" accesskey="<%=LabelManager.getAccessKey(labelSet,"lblMsgCustomCreated")%>" type="text" value="<%=dBean.fmtStr(proVo.getCustomMsg())%>" size=50></td><%} else {%><td><input name="txtCustomMsg" maxlength="255" accesskey="<%=LabelManager.getAccessKey(labelSet,"lblMsgCustomCreated")%>" type="text" value="<%=dBean.fmtStr(proVo.getCustomMsg())%>" style="visibility:hidden" size=50></td><%}%></tr><tr><td title="<%=LabelManager.getToolTip(labelSet,"lblExternalUrlAccess")%>"><%=LabelManager.getNameWAccess(labelSet,"lblExternalUrlAccess")%>:</td><td colspan="3"><%= ExternalGenerator.generateProcessUrl(request, proVo.getProId(), (proVo.getEntityProcessVo() != null) ? proVo.getEntityProcessVo().getBusEntId() : null)%></td></tr></table><BR><DIV class="subTit"><%=LabelManager.getName(labelSet,"sbtDefIde")%></DIV><table class="tblFormLayout"><tr><td colspan=4><table width=100%><tr><%if (proVo.hasEverBeenInstanced()) {%><input type="hidden" name="radIdePre" value="<%=proVo.getProIdePre()%>"><input type="hidden" name="radIdeNum" value="<%=proVo.getProIdeNum()%>"><input type="hidden" name="radIdePos" value="<%=proVo.getProIdePos()%>"><input type="hidden" name="txtIdePre" value="<%=proVo.getProIdePreFix()%>"><input type="hidden" name="txtIdePos" value="<%=proVo.getProIdePosFix()%>"><%}%><td align=right vAlign="middle"><%=LabelManager.getName(labelSet,"lblPre")%>:</td><td vAlign="middle"><input type="radio" name="radIdePre" onClick="changeIdePre(true);" value="<%=ProcessVo.IDENTIFIER_TXT_NOT_USE%>" <%if (proVo.getProIdePre() == null || ProcessVo.IDENTIFIER_TXT_NOT_USE.equals(proVo.getProIdePre())) {out.print(" checked ");}%><%= proVo.hasEverBeenInstanced()?"disabled":"" %>><%=LabelManager.getName(labelSet,"lblNoUsa")%></td><td align=right vAlign="middle"><%=LabelManager.getName(labelSet,"lblNumero")%>:</td><td vAlign="middle"><input type="radio" name="radIdeNum" value="<%=ProcessVo.IDENTIFIER_NUM_AUTO%>" <%if (proVo.getProIdeNum() == null || ProcessVo.IDENTIFIER_NUM_AUTO.equals(proVo.getProIdeNum())) {out.print(" checked ");}%><%= proVo.hasEverBeenInstanced()?"disabled":"" %>><%=LabelManager.getName(labelSet,"lblAutNum")%></td><td align=right vAlign="middle"><%=LabelManager.getName(labelSet,"lblSuf")%>:</td><td vAlign="middle"><input type="radio" name="radIdePos" onClick="changeIdePos(true);" value="<%=ProcessVo.IDENTIFIER_TXT_NOT_USE%>" <%if (proVo.getProIdePos() == null || ProcessVo.IDENTIFIER_TXT_NOT_USE.equals(proVo.getProIdePos())) {out.print(" checked ");}%><%= proVo.hasEverBeenInstanced()?"disabled":"" %>><%=LabelManager.getName(labelSet,"lblNoUsa")%></td></tr><tr><td align=right vAlign="middle"></td><td vAlign="middle"><input type="radio" name="radIdePre" onClick="changeIdePre(true);" value="<%=ProcessVo.IDENTIFIER_TXT_WRITE%>" <%if (ProcessVo.IDENTIFIER_TXT_WRITE.equals(proVo.getProIdePre())) {out.print(" checked ");}%><%= proVo.hasEverBeenInstanced()?"disabled":"" %>><%=LabelManager.getName(labelSet,"lblPerIng")%></td><td align=right vAlign="middle"></td><td vAlign="middle"><input type="radio" name="radIdeNum" value="<%=ProcessVo.IDENTIFIER_NUM_WRITE%>" <%if (ProcessVo.IDENTIFIER_NUM_WRITE.equals(proVo.getProIdeNum())) {out.print(" checked ");}%><%= proVo.hasEverBeenInstanced()?"disabled":"" %>><%=LabelManager.getName(labelSet,"lblExiIng")%></td><td align=right vAlign="middle"></td><td vAlign="middle"><input type="radio" name="radIdePos" onClick="changeIdePos(true);" value="<%=ProcessVo.IDENTIFIER_TXT_WRITE%>" <%if (ProcessVo.IDENTIFIER_TXT_WRITE.equals(proVo.getProIdePos())) {out.print(" checked ");}%><%= proVo.hasEverBeenInstanced()?"disabled":"" %>><%=LabelManager.getName(labelSet,"lblPerIng")%></td></tr><tr><td align=right vAlign="middle"></td><td vAlign="middle"><table cellspacing="0" cellpadding="0"><tr><td><input type="radio" name="radIdePre" onClick="changeIdePre(false);" value="<%=ProcessVo.IDENTIFIER_TXT_FIXED%>" <%if (ProcessVo.IDENTIFIER_TXT_FIXED.equals(proVo.getProIdePre())) {out.print(" checked ");}%><%= proVo.hasEverBeenInstanced()?"disabled":"" %>><%=LabelManager.getName(labelSet,"lblFij")%></td><td><input type=text size=6 maxlength=50 name="txtIdePre" value="<%=dBean.fmtStr(proVo.getProIdePreFix())%>" <%if (!ProcessVo.IDENTIFIER_TXT_FIXED.equals(proVo.getProIdePre())) {out.print(" disabled ");} else {out.print(" p_required=true"); if(proVo.hasEverBeenInstanced()){out.print(" disabled");}}%>></td></tr></table></td><td align=right vAlign="middle"></td><td vAlign="middle"><input type="radio" name="radIdeNum" value="<%=ProcessVo.IDENTIFIER_NUM_BOTH%>" <%if (ProcessVo.IDENTIFIER_NUM_BOTH.equals(proVo.getProIdeNum())) {out.print(" checked ");}%><%= proVo.hasEverBeenInstanced()?"disabled":"" %>><%=LabelManager.getName(labelSet,"lblAmbos")%></td><td align=right vAlign="middle"></td><td vAlign="middle"><table cellspacing="0" cellpadding="0"><tr><td><input type="radio" name="radIdePos" onClick="changeIdePos(false);" value="<%=ProcessVo.IDENTIFIER_TXT_FIXED%>" <%if (ProcessVo.IDENTIFIER_TXT_FIXED.equals(proVo.getProIdePos())) {out.print(" checked ");}%><%= proVo.hasEverBeenInstanced()?"disabled":"" %>><%=LabelManager.getName(labelSet,"lblFij")%></td><td><input type=text size=6 maxlength=50 name="txtIdePos" value="<%=dBean.fmtStr(proVo.getProIdePosFix())%>" <%if (!ProcessVo.IDENTIFIER_TXT_FIXED.equals(proVo.getProIdePos())) {out.print(" disabled ");} else {out.print(" p_required=true"); if(proVo.hasEverBeenInstanced()){out.print(" disabled");}}%>></td></tr></table></td></tr></table></td></tr></table></div>	