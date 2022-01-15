<%@page import="com.dogma.vo.*"%><%@page import="com.dogma.vo.filter.*"%><%@page import="java.util.*"%><%@include file="../../../components/scripts/server/startInc.jsp" %><% boolean canOrderBy = false; %><HTML><head><%@include file="../../../components/scripts/server/headInclude.jsp" %></head><body><jsp:useBean id="dBean" scope="session" class="com.dogma.bean.security.EnvironmentsBean"></jsp:useBean><TABLE class="pageTop"><COL class="col1"><COL class="col2"><TR><TD><%=LabelManager.getName(labelSet,"titAmb")%></TD><TD></TD></TR></TABLE><DIV id="divContent" class="divContent"><form id="frmMain" name="frmMain" method="POST"><DIV class="subTit"><table width="100%"><tr class="subTit"><td width="100%" align="left"><%=LabelManager.getName(labelSet,"sbtFil")%></td><td align="right"><button type="button" id="toggleFilter" title="<%=LabelManager.getToolTip(labelSet,"lblMonButFil")%>" class="btn" onclick="toggleFilterSection(<%=Parameters.SCREEN_LIST_SIZE - Parameters.FILTER_LIST_SIZE%>,<%=(Parameters.SCREEN_LIST_SIZE)%>)"><img src="<%=Parameters.ROOT_PATH%>/styles/<%= styleDirectory %>/images/openToc.gif" width="8" height="7"></button></td></tr></table></DIV><DIV id="listFilterArea" style="display:none"><DIV style="OVERFLOW:AUTO;HEIGHT:<%= Parameters.FILTER_LIST_SIZE - 32 %>px;"><table class="tblFormLayout"><COL class="col1"><COL class="col2"><COL class="col3"><COL class="col4"><tr><td title="<%=LabelManager.getToolTip(labelSet,"lblNom")%>"><%=LabelManager.getNameWAccess(labelSet,"lblNom")%>:</td><td><input name="txtName" maxlength="50" type="text" accesskey="<%=LabelManager.getAccessKey(labelSet,"lblNom")%>" value="<%=dBean.fmtStr(dBean.getFilter().getName())%>"></td><td title="<%=LabelManager.getToolTip(labelSet,"lblDes")%>"><%=LabelManager.getNameWAccess(labelSet,"lblDes")%>:</td><td><input name="txtDesc" maxlength="50" type="text" accesskey="<%=LabelManager.getAccessKey(labelSet,"lblDes")%>" value="<%=dBean.fmtStr(dBean.getFilter().getDesc())%>"></td></tr></table></DIV><table class="tblFormLayout"><COL class="col1"><COL class="col2"><COL class="col3"><COL class="col4"><tr><td></td><td colspan=3 align="right"><button type="button" onclick="btnSearch_click()" title="<%=LabelManager.getToolTip(labelSet,"btnBus")%>" accesskey="<%=LabelManager.getAccessKey(labelSet,"btnBus")%>"><%=LabelManager.getNameWAccess(labelSet,"btnBus")%></button></td></tr></table></DIV><!--     ---------------------------------------------               --><DIV class="subTit"><%=LabelManager.getName(labelSet,"sbtRes")%></DIV><div type="grid" id="gridList" style="height:<%=Parameters.SCREEN_LIST_SIZE%>px"><table width="500px" cellpadding="0" cellspacing="0"><thead><tr><th style="width:0px;display:none;" title="<%=LabelManager.getToolTip(labelSet,"lblSel")%>"></th><% canOrderBy = dBean.getFilter().getOrderBy() != EnvironmentFilterVo.ORDER_NAME; %><th min_width="120px" style="min-width:120px;width:25%<% if (canOrderBy) {%>;cursor:hand" onclick="orderBy('<%=EnvironmentFilterVo.ORDER_NAME%>')<%}%>" title="<%=LabelManager.getToolTip(labelSet,"lblNom")%>"><%=canOrderBy?"<u>":""%><%=LabelManager.getName(labelSet,"lblNom")%><%=canOrderBy?"</u>":""%></th><% canOrderBy = dBean.getFilter().getOrderBy() != EnvironmentFilterVo.ORDER_DESC; %><th min_width="150px" style="min-width:150px;width:50%<% if (canOrderBy) {%>;cursor:hand" onclick="orderBy('<%=EnvironmentFilterVo.ORDER_DESC%>')<%}%>" title="<%=LabelManager.getToolTip(labelSet,"lblDes")%>"><%=canOrderBy?"<u>":""%><%=LabelManager.getName(labelSet,"lblDes")%><%=canOrderBy?"</u>":""%></th><th min_width="80px" style="min-width:80px;width:25%" title="<%=LabelManager.getToolTip(labelSet,"lblEti")%>"><%=LabelManager.getName(labelSet,"lblEti")%></th><% canOrderBy = dBean.getFilter().getOrderBy() != EnvironmentFilterVo.ORDER_USER; %><th min_width="80px" style="width:80px<% if (canOrderBy) {%>;cursor:hand" onclick="orderBy('<%=EnvironmentFilterVo.ORDER_USER%>')<%}%>" title="<%=LabelManager.getToolTip(labelSet,"lblLastUsrName")%>"><%=canOrderBy?"<u>":""%><%=LabelManager.getName(labelSet,"lblLastUsrName")%><%=canOrderBy?"</u>":""%></th><% canOrderBy = dBean.getFilter().getOrderBy() != EnvironmentFilterVo.ORDER_DATE; %><th min_width="80px" style="width:80px<% if (canOrderBy) {%>;cursor:hand" onclick="orderBy('<%=EnvironmentFilterVo.ORDER_DATE%>')<%}%>" title="<%=LabelManager.getToolTip(labelSet,"lblLastActDate")%>"><%=canOrderBy?"<u>":""%><%=LabelManager.getName(labelSet,"lblLastActDate")%><%=canOrderBy?"</u>":""%></th></tr></thead><tbody><%	Collection col = dBean.getList();
							if (col != null) {
								Iterator it = col.iterator();
								int i = 0;
								EnvironmentVo eVO = null;
								while (it.hasNext()) {
									eVO = (EnvironmentVo) it.next(); %><tr <%if (i % 2 == 0) {%>class="trOdd"<%}%>><td style="width:0px;display:none;"><input type="hidden" id="idSel" name="chkSel<%=i%>"><input type="hidden" name="hidEnvId<%=i%>" value="<%=dBean.fmtInt(eVO.getEnvId())%>"></td><td style="min-width:120px"><%=dBean.fmtHTML(eVO.getEnvName())%></td><td style="min-width:150px"><%=dBean.fmtHTML(eVO.getEnvDesc())%></td><td style="min-width:80px"><%=dBean.fmtHTML(dBean.getLabelSetNane(eVO.getLblSetId()))%></td><td><%=dBean.fmtHTML(eVO.getRegUser())%></td><td><%=dBean.fmtHTML(eVO.getRegDate())%></td></tr><%i++;%><%}
							}%></tbody></table></div><table class="navBar"><COL class="col1"><COL class="col2"><tr><%@include file="../../includes/navButtons.jsp" %><td><button type="button" onclick="btnIni_click()" accesskey="<%=LabelManager.getAccessKey(labelSet,"btnIni")%>" title="<%=LabelManager.getToolTip(labelSet,"btnIni")%>"><%=LabelManager.getNameWAccess(labelSet,"btnIni")%></button><button type="button" onclick="btnParam_click()" accesskey="<%=LabelManager.getAccessKey(labelSet,"btnParams")%>" title="<%=LabelManager.getToolTip(labelSet,"btnParams")%>"><%=LabelManager.getNameWAccess(labelSet,"btnParams")%></button><button type="button" onclick="btnClo_click()" accesskey="<%=LabelManager.getAccessKey(labelSet,"btnClo")%>" title="<%=LabelManager.getToolTip(labelSet,"btnClo")%>"><%=LabelManager.getNameWAccess(labelSet,"btnClo")%></button><button type="button" onclick="btnNew_click()" accesskey="<%=LabelManager.getAccessKey(labelSet,"btnCre")%>" title="<%=LabelManager.getToolTip(labelSet,"btnCre")%>"><%=LabelManager.getNameWAccess(labelSet,"btnCre")%></button><button type="button" onclick="btnMod_click()" accesskey="<%=LabelManager.getAccessKey(labelSet,"btnMod")%>" title="<%=LabelManager.getToolTip(labelSet,"btnMod")%>"><%=LabelManager.getNameWAccess(labelSet,"btnMod")%></button><button type="button" onclick="btnDel_click()" accesskey="<%=LabelManager.getAccessKey(labelSet,"btnEli")%>" title="<%=LabelManager.getToolTip(labelSet,"btnEli")%>"><%=LabelManager.getNameWAccess(labelSet,"btnEli")%></button><button type="button" onclick="btnDep_click()" accesskey="<%=LabelManager.getAccessKey(labelSet,"btnDep")%>" title="<%=LabelManager.getToolTip(labelSet,"btnDep")%>"><%=LabelManager.getNameWAccess(labelSet,"btnDep")%></button></td></tr></table></form></div><TABLE class="pageBottom"><COL class="col1"><COL class="col2"><TR><TD></TD><TD><button type="button" onclick="splash()" accesskey="<%=LabelManager.getAccessKey(labelSet,"btnSal")%>" title="<%=LabelManager.getToolTip(labelSet,"btnSal")%>"><%=LabelManager.getNameWAccess(labelSet,"btnSal")%></button></TD></TR></TABLE></body></html><%@include file="../../../components/scripts/server/endInc.jsp" %><script language='javascript' src='<%=Parameters.ROOT_PATH%>/programs/security/environments/list.js'></script>


