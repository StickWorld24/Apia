		<div type="tab" style="visibility:hidden" style="visibility:hidden;" tabTitle="<%=LabelManager.getToolTip(labelSet,"tabTskSchProps")%>" tabText="<%=LabelManager.getName(labelSet,"tabTskSchProps")%>"><DIV class="subTit"><%=LabelManager.getName(labelSet,"sbtSchProps")%></DIV><table><!-- VER DISPONIBLES EN ASIGNACION --><tr><td><input name="chkSeeDisp" type="checkbox" <%if (tskSchVo.getTskSchId()==null || (tskSchVo.getTskSchFlags()!=null && tskSchVo.getTskSchFlags(TaskSchedulerVo.FLAG_DISPLAY_DISPONIBILITY))) {%> checked <%}%> ><%=LabelManager.getName(labelSet,"lblSeeDispInAsign")%></input></td></tr><!-- PERMITIR CITAS EN SEMANAS NO CONFIGURADAS --><tr><td><input name="chkAllowCit" type="checkbox" onclick="chkAllowCitClk()" <%if (tskSchVo.getTskSchFlags()!=null && tskSchVo.getTskSchFlags(TaskSchedulerVo.FLAG_ALLOW_NO_CONFIG_DATES)) {%> checked <%}%> ><%=LabelManager.getName(labelSet,"lblSchPerCitNoConfig")%></input></td><td align="right"><%=LabelManager.getName(labelSet,"lblDefOvrAsign")%>:</td><td><input name="txtDefOvrAsgn" size=10 p_numeric="true" title="<%=LabelManager.getToolTip(labelSet,"lblDefOvrAsign")%>" type="text" <%if (tskSchVo.getTskSchFlags()==null || !tskSchVo.getTskSchFlags(TaskSchedulerVo.FLAG_ALLOW_NO_CONFIG_DATES)) {%> disabled <%}%><%if(tskSchVo!=null && tskSchVo.getTskSchId() != null && tskSchVo.getTskSchDefOvrasgn()!=null) {%>value="<%=tskSchVo.getTskSchDefOvrasgn().intValue()%>"<%}else{%>value="2"<%}%>></td><td><%=LabelManager.getName(labelSet,"lblDefSubHoraria")%>:</td><td align="left"><select name="txtDefSubHor" onChange="changeDefFraccCmb()" <%if (tskSchVo.getTskSchFlags()==null || !tskSchVo.getTskSchFlags(TaskSchedulerVo.FLAG_ALLOW_NO_CONFIG_DATES)) {%> disabled <%}%>><% Iterator itFrac = dBean.getPosibleFraccTimes().iterator();
	   						   while (itFrac.hasNext()){
	   						   		Integer fracVal = (Integer) itFrac.next();%><option value="<%=fracVal.intValue()%>" <%=(tskSchVo.getTskSchDefFrac()!=null && tskSchVo.getTskSchDefFrac().intValue() == fracVal.intValue())?"selected":""%>><%=fracVal.intValue()%></option><%}%><option value="0" <%if(tskSchVo!=null && !dBean.isComboDefFracc()){%> selected <%}%>><%=LabelManager.getToolTip(labelSet,"lblOther")%></option></select><input name="txtOthDefFracc" id="txtOthDefFracc" style="width:30px;" maxlength="5" p_numeric="true" <%if(tskSchVo==null || dBean.isComboDefFracc()){%> disabled <%}%> value="<%=(tskSchVo!=null && !dBean.isComboDefFracc())?tskSchVo.getTskSchDefFrac():""%>"></input></td></tr><!-- NOTIFICAR AL ADMINISTRADOR --><tr><td><input name="chkNotify" type="checkbox" onclick="chkNotifyClk()" <%if (tskSchVo.getTskSchFlags()!=null && tskSchVo.getTskSchFlags(TaskSchedulerVo.FLAG_NOTIFY_ADMIN)) {%> checked <%}%><%if (tskSchVo.getTskSchFlags()==null || !tskSchVo.getTskSchFlags(TaskSchedulerVo.FLAG_ALLOW_NO_CONFIG_DATES)) {%> disabled <%}%>><%=LabelManager.getName(labelSet,"lblSchNotAdmin")%></input></td><td></td></tr><!-- EMAIL DE ADMINISTRADORES --><tr><td><%=LabelManager.getNameWAccess(labelSet,"lblSchAdmEmails")%>:</td><td><input name="txtEmails" maxlength="255" size=80 title="<%=LabelManager.getName(labelSet,"msgSchAdmEmails")%>" type="text" <%if (tskSchVo.getTskSchFlags()==null || !tskSchVo.getTskSchFlags(TaskSchedulerVo.FLAG_NOTIFY_ADMIN)) {%> disabled <%}%><%if(tskSchVo!=null && tskSchVo.getTskSchId() != null) {%>value="<%=dBean.fmtStr(tskSchVo.getTskSchMails())%>"<%}%>></td></tr></table></div>	