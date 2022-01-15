<%@page import="com.dogma.vo.*"%><%@page import="com.dogma.vo.filter.*"%><%@page import="java.util.*"%><%@include file="../../../components/scripts/server/startInc.jsp" %><% boolean canOrderBy = false; %><HTML><head><%@include file="../../../components/scripts/server/headInclude.jsp" %></head><body onload="tryReload()"><jsp:useBean id="dBean" scope="session" class="com.dogma.bean.security.UserBean"></jsp:useBean><TABLE class="pageTop"><COL class="col1"><COL class="col2"><TR><TD><%=LabelManager.getName(labelSet,dBean.isModeGlobal()?"titUsu":"titUsuEnv")%></TD><TD></TD></TR></TABLE><DIV id="divContent" class="divContent"><form id="frmMain" name="frmMain" method="POST"><DIV class="subTit"><table width="100%"><tr class="subTit"><td width="100%" align="left"><%=LabelManager.getName(labelSet,"sbtFil")%></td><td align="right"><button type="button" id="toggleFilter" title="<%=LabelManager.getToolTip(labelSet,"lblMonButFil")%>" class="btn" onclick="toggleFilterSection(<%=Parameters.SCREEN_LIST_SIZE - Parameters.FILTER_LIST_SIZE%>,<%=(Parameters.SCREEN_LIST_SIZE)%>)"><img src="<%=Parameters.ROOT_PATH%>/styles/<%= styleDirectory %>/images/openToc.gif" width="8" height="7"></button></td></tr></table></DIV><DIV id="listFilterArea" style="display:none"><DIV style="OVERFLOW:AUTO;HEIGHT:<%= Parameters.FILTER_LIST_SIZE - 32 %>px;"><table class="tblFormLayout"><COL class="col1"><COL class="col2"><COL class="col3"><COL class="col4"><tr><td title="<%=LabelManager.getToolTip(labelSet,"lblLog")%>"><%=LabelManager.getNameWAccess(labelSet,"lblLog")%>:</td><td><input name="txtLogin" maxlength="50" type="text" value="<%=dBean.fmtStr(dBean.getFilter().getLogin())%>" accesskey="<%=LabelManager.getAccessKey(labelSet,"lblLog")%>"></td><td title="<%=LabelManager.getToolTip(labelSet,"lblNom")%>"><%=LabelManager.getNameWAccess(labelSet,"lblNom")%>:</td><td><input name="txtName" maxlength="50" type="text" accesskey="<%=LabelManager.getAccessKey(labelSet,"lblNom")%>" value="<%=dBean.fmtStr(dBean.getFilter().getName())%>"></td></tr><tr><td title="<%=LabelManager.getToolTip(labelSet,"lblEma")%>"><%=LabelManager.getNameWAccess(labelSet,"lblEma")%>:</td><td><input name="txtEmail" maxlength="50" type="text" value="<%=dBean.fmtStr(dBean.getFilter().getEmail())%>" accesskey="<%=LabelManager.getAccessKey(labelSet,"lblEma")%>"></td><td></td><td></td></tr></table></div><table class="tblFormLayout"><COL class="col1"><COL class="col2"><COL class="col3"><COL class="col4"><tr><td></td><td colspan=3 align="right"><button type="button" onclick="btnSearch_click()" title="<%=LabelManager.getToolTip(labelSet,"btnBus")%>" accesskey="<%=LabelManager.getAccessKey(labelSet,"btnBus")%>"><%=LabelManager.getNameWAccess(labelSet,"btnBus")%></button></td></tr></table></DIV><!--     ---------------------------------------------               --><DIV class="subTit"><%=LabelManager.getName(labelSet,"sbtRes")%></DIV><div type="grid" id="gridList" style="height:<%=Parameters.SCREEN_LIST_SIZE%>px"><table cellpadding="0" cellspacing="0"><thead><tr><th style="width:0px;display:none;" title="<%=LabelManager.getToolTip(labelSet,"lblSel")%>"></th><% canOrderBy = dBean.getFilter().getOrderBy() != UserFilterVo.ORDER_LOGIN; %><th min_width="80px" style="min-width:70px;width:40%<% if (canOrderBy) {%>;cursor:hand" onclick="orderBy('<%=UserFilterVo.ORDER_LOGIN%>')<%}%>" title="<%=LabelManager.getToolTip(labelSet,"lblLog")%>"><%=canOrderBy?"<u>":""%><%=LabelManager.getName(labelSet,"lblLog")%><%=canOrderBy?"</u>":""%></th><% canOrderBy = dBean.getFilter().getOrderBy() != UserFilterVo.ORDER_NAME; %><th min_width="250px" style="min-width:200px;width:60%<% if (canOrderBy) {%>;cursor:hand" onclick="orderBy('<%=UserFilterVo.ORDER_NAME%>')<%}%>" title="<%=LabelManager.getToolTip(labelSet,"lblNom")%>"><%=canOrderBy?"<u>":""%><%=LabelManager.getName(labelSet,"lblNom")%><%=canOrderBy?"</u>":""%></th><% canOrderBy = dBean.getFilter().getOrderBy() != UserFilterVo.ORDER_EMAIL; %><th min_width="120px" style="width:120px<% if (canOrderBy) {%>;cursor:hand" onclick="orderBy('<%=UserFilterVo.ORDER_EMAIL%>')<%}%>" title="<%=LabelManager.getToolTip(labelSet,"lblEma")%>"><%=canOrderBy?"<u>":""%><%=LabelManager.getName(labelSet,"lblEma")%><%=canOrderBy?"</u>":""%></th><% canOrderBy = dBean.getFilter().getOrderBy() != UserFilterVo.ORDER_USER; %><th min_width="90px" style="width:90px<% if (canOrderBy) {%>;cursor:hand" onclick="orderBy('<%=UserFilterVo.ORDER_USER%>')<%}%>" title="<%=LabelManager.getToolTip(labelSet,"lblLastUsrName")%>"><%=canOrderBy?"<u>":""%><%=LabelManager.getName(labelSet,"lblLastUsrName")%><%=canOrderBy?"</u>":""%></th><% canOrderBy = dBean.getFilter().getOrderBy() != UserFilterVo.ORDER_DATE; %><th min_width="90px" style="width:90px<% if (canOrderBy) {%>;cursor:hand" onclick="orderBy('<%=UserFilterVo.ORDER_DATE%>')<%}%>" title="<%=LabelManager.getToolTip(labelSet,"lblLastActDate")%>"><%=canOrderBy?"<u>":""%><%=LabelManager.getName(labelSet,"lblLastActDate")%><%=canOrderBy?"</u>":""%></th></tr></thead><tbody><%	Collection col = dBean.getList();
							if (col != null) {
								Iterator it = col.iterator();
								int i = 0;
								UserVo uVO = null;
								while (it.hasNext()) {
									uVO = (UserVo) it.next(); 
									if (! uVO.getFlagValue(UserVo.FLAG_OCULTAR)) { %><tr<%=uVO.getFlagValue(UserVo.FLAG_DISABLED)?" style='color:#a2a2a2'":""%>><td style="width:0px;display:none;"><input type="hidden" id="idSel" name="chkSel<%=i%>"><input type="hidden" name="hidUserId<%=i%>" value="<%=dBean.fmtStr(uVO.getUsrLogin())%>"></td><td style="min-width:70px"><%= uVO.getFlagValue(UserVo.FLAG_ALL_ENV)?"<B>":""%><%=dBean.fmtHTML(uVO.getUsrLogin())%><%= uVO.getFlagValue(UserVo.FLAG_ALL_ENV)?"</B>":""%></td><td style="min-width:200px"><%=dBean.fmtHTML(uVO.getUsrName())%></td><td><%=dBean.fmtHTML(uVO.getUsrEmail())%></td><td><%=dBean.fmtHTML(uVO.getRegUser())%></td><td><%=dBean.fmtHTML(uVO.getRegDate())%></td></tr><%i++;%><%	}
								}
							}%></tbody></table></div><table class="navBar"><COL class="col1"><COL class="col2"><tr><%@include file="../../includes/navButtons.jsp" %><td><button type="button" onclick="btnExp_click()" accesskey="<%=LabelManager.getAccessKey(labelSet,"btnDow")%>" title="<%=LabelManager.getToolTip(labelSet,"btnDow")%>"><%=LabelManager.getNameWAccess(labelSet,"btnDow")%></button><button type="button" onclick="btnUpl_click()" accesskey="<%=LabelManager.getAccessKey(labelSet,"btnUpl")%>" title="<%=LabelManager.getToolTip(labelSet,"btnUpl")%>"><%=LabelManager.getNameWAccess(labelSet,"btnUpl")%></button><button type="button" onclick="btnClo_click()" accesskey="<%=LabelManager.getAccessKey(labelSet,"btnClo")%>" title="<%=LabelManager.getToolTip(labelSet,"btnClo")%>"><%=LabelManager.getNameWAccess(labelSet,"btnClo")%></button><button type="button" onclick="btnNew_click()" accesskey="<%=LabelManager.getAccessKey(labelSet,"btnCre")%>" title="<%=LabelManager.getToolTip(labelSet,"btnCre")%>"><%=LabelManager.getNameWAccess(labelSet,"btnCre")%></button><button type="button" onclick="btnMod_click()" accesskey="<%=LabelManager.getAccessKey(labelSet,"btnMod")%>" title="<%=LabelManager.getToolTip(labelSet,"btnMod")%>"><%=LabelManager.getNameWAccess(labelSet,"btnMod")%></button><button type="button" onclick="btnDel_click()" accesskey="<%=LabelManager.getAccessKey(labelSet,"btnEli")%>" title="<%=LabelManager.getToolTip(labelSet,"btnEli")%>"><%=LabelManager.getNameWAccess(labelSet,"btnEli")%></button><button type="button" onclick="btnDep_click()" accesskey="<%=LabelManager.getAccessKey(labelSet,"btnDep")%>" title="<%=LabelManager.getToolTip(labelSet,"btnDep")%>"><%=LabelManager.getNameWAccess(labelSet,"btnDep")%></button></td></tr></table></form></div><TABLE class="pageBottom"><COL class="col1"><COL class="col2"><TR><TD></TD><TD><button type="button" onclick="splash()" accesskey="<%=LabelManager.getAccessKey(labelSet,"btnSal")%>" title="<%=LabelManager.getToolTip(labelSet,"btnSal")%>"><%=LabelManager.getNameWAccess(labelSet,"btnSal")%></button></TD></TR></TABLE></body></html><%@include file="../../../components/scripts/server/endInc.jsp" %><script language="javascript"  src='<%=Parameters.ROOT_PATH%>/programs/security/users/list.js'></script><script language="javascript">
var RELOAD_STYLE = <%= dBean.needToReloadStyle(request) %>;

function tryReload(){
	if (RELOAD_STYLE && windowId=="") {
		window.parent.frames[0].window.location = "FramesAction.do?action=top"; //header
		window.parent.frames[2].window.location.reload(); //menu
		//window.parent.frames[3].window.location.reload(); //result
		//window.parent.frames[4].window.location.reload(); //hidden frame
	}else if (RELOAD_STYLE && windowId!=""){
		window.parent.logout();
	}
}

</script>