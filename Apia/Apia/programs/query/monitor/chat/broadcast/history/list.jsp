<%@page import="com.dogma.vo.custom.BroadcastMessageVo"%><%@page import="chat.commands.engine.SearchResult"%><%@page import="com.dogma.bean.query.MonitorProcessesBean"%><%@page import="com.dogma.util.DogmaUtil"%><%@include file="../../../../../../components/scripts/server/startInc.jsp" %><HTML><head><%@include file="../../../../../../components/scripts/server/headInclude.jsp" %></head><body><jsp:useBean id="dBean" scope="session" class="com.dogma.bean.query.BroadcastMonitorChatBean"></jsp:useBean><TABLE class="pageTop"><COL class="col1"><COL class="col2"><TR><TD><%=LabelManager.getName(labelSet,"titMonBroadHist")%></TD><TD></TD></TR></TABLE><DIV id="divContent" class="divContent"><form id="frmMain" name="frmMain" method="POST"><DIV class="subTit"><table width="100%"><tr class="subTit"><td width="100%" align="left"><%=LabelManager.getName(labelSet,"sbtFil")%></td><td align="right"><button type="button" id="toggleFilter" title="Ocultar/Mostrar el filtro" class="btn" onclick="toggleFilterSection(<%=Parameters.SCREEN_LIST_SIZE - Parameters.FILTER_LIST_SIZE%>,<%=(Parameters.SCREEN_LIST_SIZE)%>)"><img src="<%=Parameters.ROOT_PATH%>/styles/<%= styleDirectory %>/images/openToc.gif" width="8" height="7"></button></button></td></tr></table></DIV><DIV id="listFilterArea" style="display:none"><DIV style="OVERFLOW:AUTO;HEIGHT:<%= Parameters.FILTER_LIST_SIZE - 32 %>px;"><table class="tblFormLayout"><COL class="col1"><COL class="col2"><COL class="col3"><COL class="col4"><tr><td title="<%=LabelManager.getToolTip(labelSet,"lblMonChatFilFrom")%>"><%=LabelManager.getNameWAccess(labelSet,"lblMonChatFilFrom")%>:</td><td><input name="txtFrom" accesskey="<%=LabelManager.getAccessKey(labelSet,"lblMonChatFilFrom")%>" class="txtDate" size="10" p_mask="<%=DogmaUtil.getHTMLDateMask(dBean.getEnvId(request))%>" p_calendar="true" maxlength="10" type="text" value="<%=dBean.fmtDate(dBean.getFilter().getFrom())%>"></td><td title="<%=LabelManager.getToolTip(labelSet,"lblMonChatFilTo")%>"><%=LabelManager.getNameWAccess(labelSet,"lblMonChatFilTo")%>:</td><td><input name="txtTo" accesskey="<%=LabelManager.getAccessKey(labelSet,"lblMonChatFilTo")%>" class="txtDate" size="10" p_mask="<%=DogmaUtil.getHTMLDateMask(dBean.getEnvId(request))%>" p_calendar="true" maxlength="10" type="text" value="<%=dBean.fmtDate(dBean.getFilter().getTo())%>"></tr><tr><td title="<%=LabelManager.getToolTip(labelSet,"lblMonChatFilByUser")%>"><%=LabelManager.getNameWAccess(labelSet,"lblMonChatFilByUser")%>:</td><td><input name="byUser" maxlength="50" type="text" value="<%=dBean.fmtStr(dBean.getFilter().getByUser())%>" accesskey="<%=LabelManager.getAccessKey(labelSet,"lblMonChatFilSubject")%>"></td></tr><tr><td title="<%=LabelManager.getToolTip(labelSet,"lblMonChatFilSeen")%>"><%=LabelManager.getNameWAccess(labelSet,"lblMonChatFilSeen")%>:</td><td><select name="cmbSeen" accesskey="<%=LabelManager.getAccessKey(labelSet,"lblMonChatFilSeen")%>"><option value=""></option><option value="true" <%= (dBean.getFilter().getSeen() != null && dBean.getFilter().getSeen().booleanValue()) ? "selected" : "" %>><%=LabelManager.getName(labelSet,"lblYes")%></option><option value="false" <%= (dBean.getFilter().getSeen() != null && ! dBean.getFilter().getSeen().booleanValue()) ? "selected" : "" %>><%=LabelManager.getName(labelSet,"lblNo")%></option></select></td><td title="<%=LabelManager.getToolTip(labelSet,"lblMonChatFilBlock")%>"><%=LabelManager.getNameWAccess(labelSet,"lblMonChatFilBlock")%>:</td><td><select name="cmbSeen" accesskey="<%=LabelManager.getAccessKey(labelSet,"lblMonChatFilBlock")%>"><option value=""></option><option value="true" <%= (dBean.getFilter().getBlock() != null && dBean.getFilter().getBlock().booleanValue()) ? "selected" : "" %>><%=LabelManager.getName(labelSet,"lblYes")%></option><option value="false" <%= (dBean.getFilter().getBlock() != null && ! dBean.getFilter().getBlock().booleanValue()) ? "selected" : "" %>><%=LabelManager.getName(labelSet,"lblNo")%></option></select></td></tr><tr><td title="<%=LabelManager.getToolTip(labelSet,"lblMonChatFilMsg")%>"><%=LabelManager.getNameWAccess(labelSet,"lblMonChatFilMsg")%>:</td><td colspan="3"><input name="txtMsg" maxlength="255" size="80" type="text" value="<%=dBean.fmtStr(dBean.getFilter().getContent())%>" accesskey="<%=LabelManager.getAccessKey(labelSet,"lblMonChatFilMsg")%>"></td></tr></table></div><table class="tblFormLayout"><COL class="col1"><COL class="col2"><COL class="col3"><COL class="col4"><tr><td></td><td colspan=3 align="right"><button type="button" onclick="btnSearch_click()" title="<%=LabelManager.getToolTip(labelSet,"btnBus")%>" accesskey="<%=LabelManager.getAccessKey(labelSet,"btnBus")%>"><%=LabelManager.getNameWAccess(labelSet,"btnBus")%></button></td></tr></table></DIV><!--     ---------------------------------------------               --><DIV class="subTit"><%=LabelManager.getName(labelSet,"sbtRes")%></DIV><div type="grid" fastGrid="true" id="gridList" style="height:<%=Parameters.SCREEN_LIST_SIZE%>px"><table width="500px" cellpadding="0" cellspacing="0"><thead><tr><th min_width="130px" style="width:130px" title="<%=LabelManager.getToolTip(labelSet,"lblMonBroadChatSent")%>"><%=LabelManager.getName(labelSet,"lblMonBroadChatSent")%></th><th min_width="100px" style="min-width:100px;width:20%" title="<%=LabelManager.getToolTip(labelSet,"lblMonBroadChatBy")%>"><%=LabelManager.getName(labelSet,"lblMonBroadChatBy")%></th><th min_width="130px" style="width:130px" title="<%=LabelManager.getToolTip(labelSet,"lblMonBroadChatBlock")%>"><%=LabelManager.getName(labelSet,"lblMonBroadChatBlock")%></th><th min_width="100px" style="min-width:100px;width:80%" title="<%=LabelManager.getToolTip(labelSet,"lblMonBroadChatMsg")%>"><%=LabelManager.getName(labelSet,"lblMonBroadChatMsg")%></th></tr></thead><tbody><%	Collection col = dBean.getPage();
							if (col != null) {
								Iterator it = col.iterator();
								int i = 0;
								BroadcastMessageVo vo = null;
								while (it.hasNext()) {
									vo = (BroadcastMessageVo) it.next(); %><tr row_id="id=<%=vo.getId()%>" id=LIST><td><% if (! vo.isSeen()) { %><b><% } %><%= dBean.fmtHTML(vo.getDate()) %><% if (! vo.isSeen()) { %></b><% } %></td><td style="min-width:100px"><% if (! vo.isSeen()) { %><b><% } %><%= dBean.fmtHTML(vo.getMessage().user.name) %><% if (! vo.isSeen()) { %></b><% } %></td><td><%=LabelManager.getName(labelSet,vo.getMessage().block ? "lblYes" : "lblNo")%></td><td style="min-width:100px"><% if (! vo.isSeen()) { %><b><% } %><%= dBean.fmtHTML(biz.statum.sdk.util.StringUtil.sizeLimite(vo.getMessage().message, 100, true)) %><% if (! vo.isSeen()) { %></b><% } %></td></tr><%i++;%><%}
							}%></tbody></table><iframe id="docFrame" style="display:none"></iframe></div><table class="navBar"><COL class="col1"><COL class="col2"><tr><%@include file="../../../../../includes/navButtons.jsp" %><td><button type="button" onclick="btnView_click()" accesskey="<%=LabelManager.getAccessKey(labelSet,"btnView")%>" title="<%=LabelManager.getToolTip(labelSet,"btnView")%>"><%=LabelManager.getNameWAccess(labelSet,"btnView")%></button><button type="button" onclick="btnDelete_click()" accesskey="<%=LabelManager.getAccessKey(labelSet,"btnDel")%>" title="<%=LabelManager.getToolTip(labelSet,"btnView")%>"><%=LabelManager.getNameWAccess(labelSet,"btnDel")%></button></td></tr></table></form></div><TABLE class="pageBottom"><COL class="col1"><COL class="col2"><TR><TD></TD><TD><button type="button" onclick="splash()" accesskey="<%=LabelManager.getAccessKey(labelSet,"btnSal")%>" title="<%=LabelManager.getToolTip(labelSet,"btnSal")%>"><%=LabelManager.getNameWAccess(labelSet,"btnSal")%></button></TD></TR></TABLE></body></html><%@include file="../../../../../../components/scripts/server/endInc.jsp" %><script language="javascript"></script><script language="javascript" src='<%=Parameters.ROOT_PATH%>/programs/query/monitor/chat/broadcast/history/list.js'></script>

