<%@page import="com.dogma.vo.*"%><%@page import="com.dogma.vo.custom.*"%><%@page import="com.dogma.vo.filter.*"%><%@page import="java.util.*"%><%@page import="com.dogma.util.DogmaUtil"%><%@page import="com.dogma.bean.scheduler.SchedulerBean"%><%@include file="../../../components/scripts/server/startInc.jsp" %><% boolean canOrderBy = false; %><HTML><head><%@include file="../../../components/scripts/server/headInclude.jsp" %></head><body><jsp:useBean id="dBean" scope="session" class="com.dogma.bean.scheduler.SchedulerBean"></jsp:useBean><%
BusClassVo qryBusClassVo = dBean.getQryBusClass();
%><TABLE class="pageTop"><COL class="col1"><COL class="col2"><TR><TD><%=LabelManager.getName(labelSet,"titSch")%></TD><TD></TD></TR></TABLE><DIV id="divContent" class="divContent"><form id="frmMain" name="frmMain" method="POST"><DIV class="subTit"><table width="100%"><tr class="subTit"><td width="100%" align="left"><%=LabelManager.getName(labelSet,"sbtFil")%></td><td align="right"><button type="button" id="toggleFilter" title="<%=LabelManager.getToolTip(labelSet,"lblMonButFil")%>" class="btn" onclick="toggleFilterSection(<%=Parameters.SCREEN_LIST_SIZE - Parameters.FILTER_LIST_SIZE%>,<%=(Parameters.SCREEN_LIST_SIZE)%>)"><img src="<%=Parameters.ROOT_PATH%>/styles/<%= styleDirectory %>/images/openToc.gif" width="8" height="7"></button></td></tr></table></DIV><DIV id="listFilterArea" style="display:none"><DIV style="OVERFLOW:AUTO;HEIGHT:<%= Parameters.FILTER_LIST_SIZE - 32 %>px;"><table class="tblFormLayout"><COL class="col1"><COL class="col2"><COL class="col3"><COL class="col4"><tr><td title="<%=LabelManager.getToolTip(labelSet,"lblNom")%>"><%=LabelManager.getNameWAccess(labelSet,"lblNom")%>:</td><td><input name="txtSchName" maxlength="50" accesskey="<%=LabelManager.getAccessKey(labelSet,"lblNom")%>" type="text" value="<%=dBean.fmtStr(dBean.getFilter().getSchName())%>"></td><td title="<%=LabelManager.getToolTip(labelSet,"lblCla")%>"><%=LabelManager.getNameWAccess(labelSet,"lblCla")%>:</td><td><input name="txtBusClass" maxlength="50" accesskey="<%=LabelManager.getAccessKey(labelSet,"lblCla")%>" type="text" value="<%=dBean.fmtStr(dBean.getFilter().getBusClassName())%>"></td></tr><tr><td title="<%=LabelManager.getToolTip(labelSet,"lblSta")%>"><%=LabelManager.getNameWAccess(labelSet,"lblSta")%>:</td><td><select name="cmbStatus" accesskey="<%=LabelManager.getAccessKey(labelSet,"lblSta")%>" ><option value="" <%=(dBean.getFilter().getStatus() == null)?"selected":""%>></option><option value="<%= SchBusClaActivityVo.STATUS_DISABLED %>" <%=(dBean.getFilter().getStatus() != null && dBean.getFilter().getStatus().intValue() == SchBusClaActivityVo.STATUS_DISABLED)?"selected":"" %>><%= LabelManager.getName(labelSet,"lblSchStaDis") %></option><option value="<%= SchBusClaActivityVo.STATUS_ERROR_DISABLED %>" <%=(dBean.getFilter().getStatus() != null && dBean.getFilter().getStatus().intValue() == SchBusClaActivityVo.STATUS_ERROR_DISABLED)?"selected":"" %>><%= LabelManager.getName(labelSet,"lblSchStaErrDis") %></option><option value="<%= SchBusClaActivityVo.STATUS_NONE %>" <%=(dBean.getFilter().getStatus() != null && dBean.getFilter().getStatus().intValue() == SchBusClaActivityVo.STATUS_NONE)?"selected":""%>><%= LabelManager.getName(labelSet,"lblSchStaNoRun") %></option><option value="<%= SchBusClaActivityVo.STATUS_IN_EXECUTION %>" <%=(dBean.getFilter().getStatus() != null && dBean.getFilter().getStatus().intValue() == SchBusClaActivityVo.STATUS_IN_EXECUTION)?"selected":""%>><%= LabelManager.getName(labelSet,"lblSchStaRun") %></option><option value="<%= SchBusClaActivityVo.STATUS_FOR_EXECUTION %>" <%=(dBean.getFilter().getStatus() != null && dBean.getFilter().getStatus().intValue() == SchBusClaActivityVo.STATUS_FOR_EXECUTION)?"selected":""%>><%= LabelManager.getName(labelSet,"lblSchStaForRun") %></option><option value="<%= SchBusClaActivityVo.STATUS_CANCEL %>" <%=(dBean.getFilter().getStatus() != null && dBean.getFilter().getStatus().intValue() == SchBusClaActivityVo.STATUS_CANCEL)?"selected":""%>><%= LabelManager.getName(labelSet,"lblSchStaCancel") %></option><option value="<%= SchBusClaActivityVo.STATUS_FINISH_OK %>" <%=(dBean.getFilter().getStatus() != null && dBean.getFilter().getStatus().intValue() == SchBusClaActivityVo.STATUS_FINISH_OK)?"selected":""%>><%= LabelManager.getName(labelSet,"lblSchStaOk") %></option><option value="<%= SchBusClaActivityVo.STATUS_FINISH_ERROR %>" <%=(dBean.getFilter().getStatus() != null && dBean.getFilter().getStatus().intValue() == SchBusClaActivityVo.STATUS_FINISH_ERROR)?"selected":""%>><%= LabelManager.getName(labelSet,"lblSchStaError") %></option></select></td><td title="<%=LabelManager.getToolTip(labelSet,"lblPeri")%>"><%=LabelManager.getNameWAccess(labelSet,"lblPeri")%>:</td><td><select name="cmbPer" accesskey="<%=LabelManager.getAccessKey(labelSet,"lblPeri")%>" ><option value="" <%=(dBean.getFilter().getPeriodicity() == null)?"selected":""%>></option><%
								Collection cPer = dBean.getPeriodicity(request,labelSet);
								if(cPer!=null){
									Iterator itPer = cPer.iterator();
									while(itPer.hasNext()){
										CmbDataVo cmb = (CmbDataVo)itPer.next();%><option value="<%=dBean.fmtHTML(cmb.getValue())%>" <%=(cmb.getValue().equals(dBean.getFilter().getPeriodicity()))?"selected ":""%> ><%=dBean.fmtHTML(cmb.getText())%></option><%
									}
								} %></select></td></tr><tr><td title="<%=LabelManager.getToolTip(labelSet,"lblFchIni")%>"><%=LabelManager.getNameWAccess(labelSet,"lblFchIni")%></td><td><input name="dteStartFrom" class="txtDate" size="10" p_mask = "<%=DogmaUtil.getHTMLDateMask(dBean.getEnvId(request))%>" p_calendar="true" maxlength="10" type="text" value="<%=dBean.fmtDate(dBean.getFilter().getStartFrom())%>" accesskey="<%=LabelManager.getAccessKey(labelSet,"lblFchIni")%>">
			   				-
			   				<input name="dteStartTo" class="txtDate" size="10" p_mask = "<%=DogmaUtil.getHTMLDateMask(dBean.getEnvId(request))%>" p_calendar="true" maxlength="10" type="text" value="<%=dBean.fmtDate(dBean.getFilter().getStartTo())%>" accesskey="<%=LabelManager.getAccessKey(labelSet,"lblFchIni")%>"></td><td title="<%=LabelManager.getToolTip(labelSet,"lblFchFin")%>"><%=LabelManager.getNameWAccess(labelSet,"lblFchFin")%></td><td><input name="dteEndFrom" class="txtDate" size="10" p_mask = "<%=DogmaUtil.getHTMLDateMask(dBean.getEnvId(request))%>" p_calendar="true" maxlength="10" type="text" value="<%=dBean.fmtDate(dBean.getFilter().getEndFrom())%>" accesskey="<%=LabelManager.getAccessKey(labelSet,"lblFchEnd")%>">
			   				-
			   				<input name="dteEndTo" class="txtDate" size="10" p_mask = "<%=DogmaUtil.getHTMLDateMask(dBean.getEnvId(request))%>" p_calendar="true" maxlength="10" type="text" value="<%=dBean.fmtDate(dBean.getFilter().getEndTo())%>" accesskey="<%=LabelManager.getAccessKey(labelSet,"lblFchEnd")%>"></td></tr><tr><td title="<%=LabelManager.getToolTip(labelSet,"lblUltEje")%>"><%=LabelManager.getNameWAccess(labelSet,"lblUltEje")%></td><td><input name="dteLastFrom" class="txtDate" size="10" p_mask = "<%=DogmaUtil.getHTMLDateMask(dBean.getEnvId(request))%>" p_calendar="true" maxlength="10" type="text" value="<%=dBean.fmtDate(dBean.getFilter().getStartFrom())%>" accesskey="<%=LabelManager.getAccessKey(labelSet,"lblUltEje")%>">
			   				-
			   				<input name="dteLastTo" class="txtDate" size="10" p_mask = "<%=DogmaUtil.getHTMLDateMask(dBean.getEnvId(request))%>" p_calendar="true" maxlength="10" type="text" value="<%=dBean.fmtDate(dBean.getFilter().getStartTo())%>" accesskey="<%=LabelManager.getAccessKey(labelSet,"lblUltEje")%>"></td><td></td><td></td></tr></table></div><table class="tblFormLayout"><COL class="col1"><COL class="col2"><COL class="col3"><COL class="col4"><tr><td></td><td colspan=3 align="right"><button type="button" onclick="btnSearch_click()" title="<%=LabelManager.getToolTip(labelSet,"btnBus")%>" accesskey="<%=LabelManager.getAccessKey(labelSet,"btnBus")%>"><%=LabelManager.getNameWAccess(labelSet,"btnBus")%></button></td></tr></table></DIV><DIV class="subTit"><%=LabelManager.getName(labelSet,"sbtRes")%></DIV><div type="grid" id="gridList" style="height:<%=Parameters.SCREEN_LIST_SIZE%>px"><table cellpadding="0" cellspacing="0"><thead><tr><th style="width:width:0px;display:none;" title="<%=LabelManager.getToolTip(labelSet,"lblSel")%>"></th><% canOrderBy = dBean.getFilter().getOrderBy() != SchedulerFilterVo.ORDER_START; %><th min_width="100px" style="width:100px<% if (canOrderBy) {%>;cursor:hand" onclick="orderBy('<%=SchedulerFilterVo.ORDER_START%>')<%}%>" title="<%=LabelManager.getToolTip(labelSet,"lblFchIni")%>"><%=canOrderBy?"<u>":""%><%=LabelManager.getName(labelSet,"lblFchIni")%><%=canOrderBy?"</u>":""%></th><% canOrderBy = dBean.getFilter().getOrderBy() != SchedulerFilterVo.ORDER_END; %><th min_width="100px" style="width:100px<% if (canOrderBy) {%>;cursor:hand" onclick="orderBy('<%=SchedulerFilterVo.ORDER_END%>')<%}%>" title="<%=LabelManager.getToolTip(labelSet,"lblFchFin")%>"><%=canOrderBy?"<u>":""%><%=LabelManager.getName(labelSet,"lblFchFin")%><%=canOrderBy?"</u>":""%></th><% canOrderBy = dBean.getFilter().getOrderBy() != SchedulerFilterVo.ORDER_SCH_NAME; %><th min_width="180px" style="width:180px<% if (canOrderBy) {%>;cursor:hand" onclick="orderBy('<%=SchedulerFilterVo.ORDER_SCH_NAME%>')<%}%>" title="<%=LabelManager.getToolTip(labelSet,"lblNom")%>"><%=canOrderBy?"<u>":""%><%=LabelManager.getName(labelSet,"lblNom")%><%=canOrderBy?"</u>":""%></th><% canOrderBy = dBean.getFilter().getOrderBy() != SchedulerFilterVo.ORDER_BUS_CASS; %><th min_width="180px" style="width:180px<% if (canOrderBy) {%>;cursor:hand" onclick="orderBy('<%=SchedulerFilterVo.ORDER_BUS_CASS%>')<%}%>" title="<%=LabelManager.getToolTip(labelSet,"lblCla")%>"><%=canOrderBy?"<u>":""%><%=LabelManager.getName(labelSet,"lblCla")%><%=canOrderBy?"</u>":""%></th><% canOrderBy = dBean.getFilter().getOrderBy() != SchedulerFilterVo.ORDER_PERIODICITY; %><th min_width="70px" style="width:70px<% if (canOrderBy) {%>;cursor:hand" onclick="orderBy('<%=SchedulerFilterVo.ORDER_PERIODICITY%>')<%}%>" title="<%=LabelManager.getToolTip(labelSet,"lblPeri")%>"><%=canOrderBy?"<u>":""%><%=LabelManager.getName(labelSet,"lblPeri")%><%=canOrderBy?"</u>":""%></th><% canOrderBy = dBean.getFilter().getOrderBy() != SchedulerFilterVo.ORDER_LAST_EXECUTION; %><th min_width="100px" style="width:100px<% if (canOrderBy) {%>;cursor:hand" onclick="orderBy('<%=SchedulerFilterVo.ORDER_LAST_EXECUTION%>')<%}%>" title="<%=LabelManager.getToolTip(labelSet,"lblUltEje")%>"><%=canOrderBy?"<u>":""%><%=LabelManager.getName(labelSet,"lblUltEje")%><%=canOrderBy?"</u>":""%></th><% canOrderBy = dBean.getFilter().getOrderBy() != SchedulerFilterVo.ORDER_STATUS; %><th min_width="70px" style="width:70px<% if (canOrderBy) {%>;cursor:hand" onclick="orderBy('<%=SchedulerFilterVo.ORDER_STATUS%>')<%}%>" title="<%=LabelManager.getToolTip(labelSet,"lblSta")%>"><%=canOrderBy?"<u>":""%><%=LabelManager.getName(labelSet,"lblSta")%><%=canOrderBy?"</u>":""%></th></tr></thead><tbody><%	Collection col = dBean.getList();
							if (col != null) {
								Iterator it = col.iterator();
								int i = 0;
								SchBusClaActivityVo sVO = null;
								boolean editable = true;
								String label = null;
								while (it.hasNext()) {
									sVO = (SchBusClaActivityVo) it.next();
									editable = (qryBusClassVo == null || ! qryBusClassVo.getBusClaId().equals(sVO.getBusClaId()));%><tr <%= (!editable)?" x_disabled='true' ":"" %><%if (i % 2 == 0) {%>class="trOdd"<%}%>><td style="width:0px;display:none;"><input type="hidden" id="idSel<%= (!editable)?"No":"" %>" name="chkSel<%=i%>"><input type="hidden" name="hidEnvId<%=i%>" value="<%=dBean.fmtInt(sVO.getEnvId())%>"><input type="hidden" name="hidSchId<%=i%>" value="<%=dBean.fmtInt(sVO.getSchBusClaId())%>"><input type="hidden" name="hidBusClaId<%=i%>" value="<%=dBean.fmtInt(sVO.getBusClaId())%>"></td><td><%=dBean.fmtHTMLTime(sVO.getFirstExecution())%></td><td><%=dBean.fmtHTMLTime(sVO.getEndExecution())%></td><td><%=dBean.fmtHTML(sVO.getSchName())%></td><td><%=dBean.fmtHTML(sVO.getClassName())%></td><td><%=dBean.fmtHTML(SchedulerBean.getPeriodicityName(request,sVO.getPeriodicity()))%></td><td><%=dBean.fmtDateAMPM(sVO.getLastExecution())%></td><td><% if (sVO.getSchActStatus() != null) {
											switch (sVO.getSchActStatus().intValue()) {
												case SchBusClaActivityVo.STATUS_DISABLED:
													label = "lblSchStaDis";
													break;
												case SchBusClaActivityVo.STATUS_ERROR_DISABLED:
													label = "lblSchStaErrDis";
													break;
												case SchBusClaActivityVo.STATUS_NONE:
													label = "lblSchStaNoRun";
													break;
												case SchBusClaActivityVo.STATUS_IN_EXECUTION:
													label = "lblSchStaRun";
													break;
												case SchBusClaActivityVo.STATUS_FOR_EXECUTION:
													label = "lblSchStaForRun";
													break;
												case SchBusClaActivityVo.STATUS_CANCEL:
													label = "lblSchStaCancel";
													break;
												case SchBusClaActivityVo.STATUS_FINISH_OK:
													label = "lblSchStaOk";
													break;
												case SchBusClaActivityVo.STATUS_FINISH_ERROR:
													label = "lblSchStaError";
													break;
											}
										} %><%= LabelManager.getName(labelSet,label) %></td></tr><%i++;%><%}
							}%></tbody></table></div><table class="navBar"><COL class="col1"><COL class="col2"><tr><%@include file="../../includes/navButtons.jsp" %><td><button onclick="btnRefresh_click()" accesskey="<%=LabelManager.getAccessKey(labelSet,"btnRef")%>" title="<%=LabelManager.getToolTip(labelSet,"btnRef")%>"><%=LabelManager.getNameWAccess(labelSet,"btnRef")%></button><button type="button" onclick="btnRun_click()" accesskey="<%=LabelManager.getAccessKey(labelSet,"btnRunNow")%>" title="<%=LabelManager.getToolTip(labelSet,"btnRunNow")%>"><%=LabelManager.getNameWAccess(labelSet,"btnRunNow")%></button><button type="button" onclick="btnEnaDis_click()" accesskey="<%=LabelManager.getAccessKey(labelSet,"btnEnaDis")%>" title="<%=LabelManager.getToolTip(labelSet,"btnEnaDis")%>"><%=LabelManager.getNameWAccess(labelSet,"btnEnaDis")%></button><button type="button" onclick="btnNew_click()" accesskey="<%=LabelManager.getAccessKey(labelSet,"btnCre")%>" title="<%=LabelManager.getToolTip(labelSet,"btnCre")%>"><%=LabelManager.getNameWAccess(labelSet,"btnCre")%></button><button type="button" onclick="btnMod_click()" accesskey="<%=LabelManager.getAccessKey(labelSet,"btnMod")%>" title="<%=LabelManager.getToolTip(labelSet,"btnMod")%>"><%=LabelManager.getNameWAccess(labelSet,"btnMod")%></button><button type="button" onclick="btnDel_click()" accesskey="<%=LabelManager.getAccessKey(labelSet,"btnEli")%>" title="<%=LabelManager.getToolTip(labelSet,"btnEli")%>"><%=LabelManager.getNameWAccess(labelSet,"btnEli")%></button><button type="button" onclick="btnDep_click()" accesskey="<%=LabelManager.getAccessKey(labelSet,"btnDep")%>" title="<%=LabelManager.getToolTip(labelSet,"btnDep")%>"><%=LabelManager.getNameWAccess(labelSet,"btnDep")%></button></td></tr></table></FORM></DIV><TABLE class="pageBottom"><COL class="col1"><COL class="col2"><TR><TD></TD><TD><button type="button" onclick="splash()" accesskey="<%=LabelManager.getAccessKey(labelSet,"btnSal")%>" title="<%=LabelManager.getToolTip(labelSet,"btnSal")%>"><%=LabelManager.getNameWAccess(labelSet,"btnSal")%></button></TD></TR></TABLE></body></html><%@include file="../../../components/scripts/server/endInc.jsp" %><script>
MSG_SCH_NO_UPDATABLE = "<%=LabelManager.getName(labelSet,"msgSchNoUpdatable") %>";
MSG_SCH_NO_DELETABLE = "<%=LabelManager.getName(labelSet,"msgSchNoDeletable") %>";
WIDGET_SCHEDULER_NAME = "<%=SchBusClaActivityVo.EXECUTE_WIDGET_SCHED_PREFIX%>";
</script><script language="javascript" src='<%=Parameters.ROOT_PATH%>/programs/scheduler/admin/list.js'></script>