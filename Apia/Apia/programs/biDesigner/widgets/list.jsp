<%@page import="com.dogma.vo.*"%><%@page import="com.dogma.vo.filter.*"%><%@page import="java.util.*"%><%@page import="com.dogma.bi.BIEngine"%><%@include file="../../../components/scripts/server/startInc.jsp" %><% boolean canOrderBy = false; %><HTML><head><%@include file="../../../components/scripts/server/headInclude.jsp" %></head><script type="text/javascript" defer="true">
var biCorrectlyInstalled = "<%=BIEngine.biCorrectlyInstalled()%>";
</script><body><jsp:useBean id="dBean" scope="session" class="com.dogma.bean.administration.WidgetBean"></jsp:useBean><TABLE class="pageTop"><COL class="col1"><COL class="col2"><TR><TD><%=LabelManager.getName(labelSet,"titWidget")%></TD><TD></TD></TR></TABLE><DIV id="divContent" class="divContent"><form id="frmMain" name="frmMain" method="POST"><DIV class="subTit"><table width="100%"><tr class="subTit"><td width="100%" align="left"><%=LabelManager.getName(labelSet,"sbtFil")%></td><td align="right"><button type="button" id="toggleFilter" title="<%=LabelManager.getToolTip(labelSet,"lblMonButFil")%>" class="btn" onclick="toggleFilterSection(<%=Parameters.SCREEN_LIST_SIZE - Parameters.FILTER_LIST_SIZE%>,<%=(Parameters.SCREEN_LIST_SIZE)%>)"><img src="<%=Parameters.ROOT_PATH%>/styles/<%= styleDirectory %>/images/openToc.gif" width="8" height="7"></button></td></tr></table></DIV><DIV id="listFilterArea" style="display:none"><DIV style="OVERFLOW:AUTO;HEIGHT:<%= Parameters.FILTER_LIST_SIZE - 32 %>px;"><table class="tblFormLayout"><COL class="col1"><COL class="col2"><COL class="col3"><COL class="col4"><tr><td title="<%=LabelManager.getToolTip(labelSet,"lblNom")%>"><%=LabelManager.getNameWAccess(labelSet,"lblNom")%>:</td><td><input name="txtName" maxlength="50" type="text" accesskey="<%=LabelManager.getAccessKey(labelSet,"lblNom")%>" value="<%=dBean.fmtStr(dBean.getFilter().getName())%>"></td><td title="<%=LabelManager.getToolTip(labelSet,"lblDes")%>"><%=LabelManager.getNameWAccess(labelSet,"lblDes")%>:</td><td><input name="txtDesc" maxlength="50" type="text" accesskey="<%=LabelManager.getAccessKey(labelSet,"lblDes")%>" value="<%=dBean.fmtStr(dBean.getFilter().getDesc())%>"></td></tr><tr><td title="<%=LabelManager.getToolTip(labelSet,"lblType")%>"><%=LabelManager.getNameWAccess(labelSet,"lblType")%>:</td><td><select name="cmbWidType" id="cmbWidType" style="width:125px" accesskey="<%=LabelManager.getAccessKey(labelSet,"lblType")%>"><option value="0"></option><option value="<%=WidgetVo.WIDGET_TYPE_KPI_ID.intValue()%>" <%=(dBean.getFilter() != null && dBean.getFilter().getType() != null && WidgetVo.WIDGET_TYPE_KPI_ID.intValue() == dBean.getFilter().getType().intValue())?"selected":""%>><%=WidgetVo.WIDGET_TYPE_KPI_NAME%></option><option value="<%=WidgetVo.WIDGET_TYPE_CUBE_ID.intValue()%>" <%=(dBean.getFilter() != null && dBean.getFilter().getType() != null && WidgetVo.WIDGET_TYPE_CUBE_ID.intValue() == dBean.getFilter().getType().intValue())?"selected":""%>><%=WidgetVo.WIDGET_TYPE_CUBE_NAME%></option><option value="<%=WidgetVo.WIDGET_TYPE_QUERY_ID.intValue()%>" <%=(dBean.getFilter() != null && dBean.getFilter().getType() != null && WidgetVo.WIDGET_TYPE_QUERY_ID.intValue() == dBean.getFilter().getType().intValue())?"selected":""%>><%=WidgetVo.WIDGET_TYPE_QUERY_NAME%></option><option value="<%=WidgetVo.WIDGET_TYPE_CUSTOM_ID.intValue()%>" <%=(dBean.getFilter() != null && dBean.getFilter().getType() != null && WidgetVo.WIDGET_TYPE_CUSTOM_ID.intValue() == dBean.getFilter().getType().intValue())?"selected":""%>><%=WidgetVo.WIDGET_TYPE_CUSTOM_NAME%></option></select></td><td title="<%=LabelManager.getToolTip(labelSet,"lblWidSource")%>"><%=LabelManager.getNameWAccess(labelSet,"lblWidSource")%>:</td><td><select name="cmbSrcType" id="cmbSrcType" style="width:125px" accesskey="<%=LabelManager.getAccessKey(labelSet,"lblWidSource")%>"><option value="0"></option><option value="<%=WidgetVo.WIDGET_SRC_TYPE_BUS_CLASS_ID.intValue()%>" <%=(dBean.getFilter() != null && dBean.getFilter().getSource() != null && WidgetVo.WIDGET_SRC_TYPE_BUS_CLASS_ID.intValue() == dBean.getFilter().getSource().intValue())?"selected":""%>><%=WidgetVo.WIDGET_SRC_TYPE_BUS_CLASS_NAME%></option><option value="<%=WidgetVo.WIDGET_SRC_TYPE_CUBE_VIEW_ID.intValue()%>" <%=(dBean.getFilter() != null && dBean.getFilter().getSource() != null && WidgetVo.WIDGET_SRC_TYPE_CUBE_VIEW_ID.intValue() == dBean.getFilter().getSource().intValue())?"selected":""%>><%=WidgetVo.WIDGET_SRC_TYPE_CUBE_VIEW_NAME%></option><option value="<%=WidgetVo.WIDGET_SRC_TYPE_QUERY_ID.intValue()%>" <%=(dBean.getFilter() != null && dBean.getFilter().getSource() != null && WidgetVo.WIDGET_SRC_TYPE_QUERY_ID.intValue() == dBean.getFilter().getSource().intValue())?"selected":""%>><%=WidgetVo.WIDGET_SRC_TYPE_QUERY_NAME%></option></select></td></tr></table></DIV><table class="tblFormLayout"><COL class="col1"><COL class="col2"><COL class="col3"><COL class="col4"><tr><td></td><td colspan=3 align="right"><button type="button" onclick="btnSearch_click()" title="<%=LabelManager.getToolTip(labelSet,"btnBus")%>" accesskey="<%=LabelManager.getAccessKey(labelSet,"btnBus")%>"><%=LabelManager.getNameWAccess(labelSet,"btnBus")%></button></td></tr></table></DIV><DIV class="subTit"><%=LabelManager.getName(labelSet,"sbtRes")%></DIV><div type="grid" id="gridList" style="height:<%=Parameters.SCREEN_LIST_SIZE%>px"><table  cellpadding="0" cellspacing="0"><thead><tr><th style="width:0px;display:none;" title="<%=LabelManager.getToolTip(labelSet,"lblSel")%>"></th><th min_width="24px" style="width:24px" title="<%=LabelManager.getToolTip(labelSet,"lblPerm")%>">&nbsp;</th><% canOrderBy = dBean.getFilter().getOrderBy() != WidgetFilterVo.ORDER_NAME; %><th min_width="100px" style="width:100px<% if (canOrderBy) {%>;cursor:hand" onclick="orderBy('<%=WidgetFilterVo.ORDER_NAME%>')<%}%>" title="<%=LabelManager.getToolTip(labelSet,"lblNom")%>"><%=canOrderBy?"<u>":""%><%=LabelManager.getName(labelSet,"lblNom")%><%=canOrderBy?"</u>":""%></th><% canOrderBy = dBean.getFilter().getOrderBy() != WidgetFilterVo.ORDER_TITLE; %><th min_width="100px" style="width:100px<% if (canOrderBy) {%>;cursor:hand" onclick="orderBy('<%=CubeFilterVo.ORDER_TITLE%>')<%}%>" title="<%=LabelManager.getToolTip(labelSet,"lblTit")%>"><%=canOrderBy?"<u>":""%><%=LabelManager.getName(labelSet,"lblTit")%><%=canOrderBy?"</u>":""%></th><% canOrderBy = dBean.getFilter().getOrderBy() != WidgetFilterVo.ORDER_DESC; %><th min_width="180px" style="min-width:180px;max-width:244px;width:100%<% if (canOrderBy) {%>;cursor:hand" onclick="orderBy('<%=WidgetFilterVo.ORDER_DESC%>')<%}%>" title="<%=LabelManager.getToolTip(labelSet,"lblDes")%>"><%=canOrderBy?"<u>":""%><%=LabelManager.getName(labelSet,"lblDes")%><%=canOrderBy?"</u>":""%></th><% canOrderBy = dBean.getFilter().getOrderBy() != WidgetFilterVo.ORDER_TYPE; %><th min_width="120px" style="width:120px<% if (canOrderBy) {%>;cursor:hand" onclick="orderBy('<%=WidgetFilterVo.ORDER_TYPE%>')<%}%>" title="<%=LabelManager.getToolTip(labelSet,"lblType")%>"><%=canOrderBy?"<u>":""%><%=LabelManager.getName(labelSet,"lblType")%><%=canOrderBy?"</u>":""%></th><% canOrderBy = dBean.getFilter().getOrderBy() != WidgetFilterVo.ORDER_SOURCE; %><th min_width="100px" style="width:100px<% if (canOrderBy) {%>;cursor:hand" onclick="orderBy('<%=WidgetFilterVo.ORDER_SOURCE%>')<%}%>" title="<%=LabelManager.getToolTip(labelSet,"lblWidSource")%>"><%=canOrderBy?"<u>":""%><%=LabelManager.getName(labelSet,"lblWidSource")%><%=canOrderBy?"</u>":""%></th><% canOrderBy = dBean.getFilter().getOrderBy() != WidgetFilterVo.ORDER_USER; %><th min_width="70px" style="width:70px<% if (canOrderBy) {%>;cursor:hand" onclick="orderBy('<%=WidgetFilterVo.ORDER_USER%>')<%}%>" title="<%=LabelManager.getToolTip(labelSet,"lblLastUsrName")%>"><%=canOrderBy?"<u>":""%><%=LabelManager.getName(labelSet,"lblLastUsrName")%><%=canOrderBy?"</u>":""%></th><% canOrderBy = dBean.getFilter().getOrderBy() != WidgetFilterVo.ORDER_DATE; %><th min_width="70px" style="width:70px<% if (canOrderBy) {%>;cursor:hand" onclick="orderBy('<%=WidgetFilterVo.ORDER_DATE%>')<%}%>" title="<%=LabelManager.getToolTip(labelSet,"lblLastActDate")%>"><%=canOrderBy?"<u>":""%><%=LabelManager.getName(labelSet,"lblLastActDate")%><%=canOrderBy?"</u>":""%></th></tr></thead><tbody><%	
					   		if (BIEngine.biCorrectlyInstalled()){
					   			Collection col = dBean.getList();
					   			String actualUser = dBean.getActualUser(request);
					   			if (col != null) {
									Iterator it = col.iterator();
									int i = 0;
									WidgetVo pVO = null;
									while (it.hasNext()) {
										pVO = (WidgetVo) it.next();
										boolean readPerm = dBean.hasReadPermission(request, pVO.getWidId(), actualUser);
										boolean writePerm = dBean.hasWritePermission(request, pVO.getWidId(), actualUser);
										boolean enabled = true;
										String msg = "";
										//Si el widget se carga con una clase de negocio y no estamos en el ambiente de la clase de negocio, no permitimos modificarlo
										if (pVO.getWidSrcType()!=null && pVO.getWidSrcType().intValue() == WidgetVo.WIDGET_SRC_TYPE_BUS_CLASS_ID.intValue() && pVO.getEnvId()!=null && pVO.getEnvId().intValue() != dBean.getEnvId(request).intValue()){
											enabled = false;
											msg = LabelManager.getToolTip(labelSet,"msgWidBusClaNoEditable").replace("<TOK1>",dBean.getEnvName(pVO.getEnvId()));
										}
										//Si el widget se carga con una consulta de usuario y no estamos en el ambiente de la consulta de usuario, no permitimos modificarlo
										if (pVO.getWidSrcType()!=null && pVO.getWidSrcType().intValue() == WidgetVo.WIDGET_SRC_TYPE_QUERY_ID.intValue() && pVO.getEnvId()!=null && pVO.getEnvId().intValue() != dBean.getEnvId(request).intValue()){
											enabled = false;
											msg = LabelManager.getToolTip(labelSet,"msgWidQryNoEditable").replace("<TOK1>",dBean.getEnvName(pVO.getEnvId()));
										}
										%><tr><td  style="width:0px;display:none;"><% if (!enabled) { %><input type=hidden style="visibility:hidden"><% } else {%><input type="hidden" id="idSel" name="chkSel<%=i%>"><%}%><input type="hidden" name="hidWidId<%=i%>" value="<%=dBean.fmtInt(pVO.getWidId())%>"></td><td align="center" vAlign="top" style="width:28px;align:center;"><% if (!readPerm) {%><img border=0 src='<%=Parameters.ROOT_PATH%>/styles/<%= styleDirectory %>/images/noAccess.png' title="<%=LabelManager.getToolTip(labelSet,"msgCantRead")%>"><%}%><input type="hidden" name="hidUsrCanRead" value="<%=readPerm%>"><input type="hidden" name="hidUsrCanWrite" value="<%=writePerm%>"></td><td <%if (!enabled){%> style="color:gray;" title="<%=msg%>"<%}%>><%=dBean.fmtHTML(pVO.getWidName())%></td><td <%if (!enabled){%> style="color:gray;" title="<%=msg%>"<%}%>><%=dBean.fmtHTML(pVO.getWidTitle())%></td><td style="min-width:180px;max-width:244px" <%if (!enabled){%> style="color:gray;" title="<%=msg%>"<%}%>><%=dBean.fmtHTML(pVO.getWidDesc())%></td><td <%if (!enabled){%> style="color:gray;" title="<%=msg%>"<%}%>><%=dBean.fmtHTML(pVO.getWidCompleteType())%></td><% if (pVO.getWidSrcType()!=null && pVO.getWidSrcType().intValue() == WidgetVo.WIDGET_SRC_TYPE_CUBE_VIEW_ID.intValue()){%><td <%if (!enabled){%> style="color:gray;" title="<%=msg%>"<%}%>><%=dBean.fmtHTML(WidgetVo.WIDGET_SRC_TYPE_CUBE_VIEW_NAME)%></td><%}else if (pVO.getWidSrcType()!=null && pVO.getWidSrcType().intValue() == WidgetVo.WIDGET_SRC_TYPE_BUS_CLASS_ID.intValue()){%><td <%if (!enabled){%> style="color:gray;" title="<%=msg%>"<%}%>><%=dBean.fmtHTML(WidgetVo.WIDGET_SRC_TYPE_BUS_CLASS_NAME)%></td><%}else if (pVO.getWidSrcType()!=null && pVO.getWidSrcType().intValue() == WidgetVo.WIDGET_SRC_TYPE_QUERY_ID.intValue()){%><td <%if (!enabled){%> style="color:gray;" title="<%=msg%>"<%}%>><%=dBean.fmtHTML(WidgetVo.WIDGET_SRC_TYPE_QUERY_NAME)%></td><%}else{%><td></td><%}%><td <%if (!enabled){%> style="color:gray;" title="<%=msg%>"<%}%>><%=dBean.fmtHTML(pVO.getRegUser())%></td><td <%if (!enabled){%> style="color:gray;" title="<%=msg%>"<%}%>><%=dBean.fmtHTML(pVO.getRegDate())%></td></tr><%i++;%><%}
					   			}
							}%></tbody></table></div><table class="navBar"><COL class="col1"><COL class="col2"><tr><%@include file="../../includes/navButtons.jsp" %><td align="right"><button type="button" onclick="btnClo_click()" <%=(!BIEngine.biCorrectlyInstalled())?"disabled":""%> accesskey="<%=LabelManager.getAccessKey(labelSet,"btnClo")%>" title="<%=LabelManager.getToolTip(labelSet,"btnClo")%>"><%=LabelManager.getNameWAccess(labelSet,"btnClo")%></button><button type="button" onclick="btnNew_click()" <%=(!BIEngine.biCorrectlyInstalled())?"disabled":""%> accesskey="<%=LabelManager.getAccessKey(labelSet,"btnCre")%>" title="<%=LabelManager.getToolTip(labelSet,"btnCre")%>"><%=LabelManager.getNameWAccess(labelSet,"btnCre")%></button><button type="button" onclick="btnMod_click()" <%=(!BIEngine.biCorrectlyInstalled())?"disabled":""%> accesskey="<%=LabelManager.getAccessKey(labelSet,"btnMod")%>" title="<%=LabelManager.getToolTip(labelSet,"btnMod")%>"><%=LabelManager.getNameWAccess(labelSet,"btnMod")%></button><button type="button" onclick="btnDel_click()" <%=(!BIEngine.biCorrectlyInstalled())?"disabled":""%> accesskey="<%=LabelManager.getAccessKey(labelSet,"btnEli")%>" title="<%=LabelManager.getToolTip(labelSet,"btnEli")%>"><%=LabelManager.getNameWAccess(labelSet,"btnEli")%></button><button type="button" onclick="btnDep_click()" <%=(!BIEngine.biCorrectlyInstalled())?"disabled":""%> accesskey="<%=LabelManager.getAccessKey(labelSet,"btnDep")%>" title="<%=LabelManager.getToolTip(labelSet,"btnDep")%>"><%=LabelManager.getNameWAccess(labelSet,"btnDep")%></button></td></tr></table></form></div><TABLE class="pageBottom"><COL class="col1"><COL class="col2"><TR><TD></TD><TD align="right"><button type="button" onclick="splash()" accesskey="<%=LabelManager.getAccessKey(labelSet,"btnSal")%>" title="<%=LabelManager.getToolTip(labelSet,"btnSal")%>"><%=LabelManager.getNameWAccess(labelSet,"btnSal")%></button></TD></TR></TABLE></body></html><%@include file="../../../components/scripts/server/endInc.jsp" %><script>
var MSG_WID_ONLY_READ = "<%=LabelManager.getName(labelSet,"msgWidOnlyRead")%>";
var MSG_WID_CANT_READ = "<%=LabelManager.getName(labelSet,"msgWidNoRead")%>";
var MSG_INSUF_PERMS   = "<%=LabelManager.getName(labelSet,"msgInsufPermissions")%>";
</script><script language="javascript" src='<%=Parameters.ROOT_PATH%>/programs/biDesigner/widgets/list.js'></script>