<%@page import="com.dogma.vo.*"%><%@page import="java.util.*"%><%@include file="../../../components/scripts/server/startInc.jsp" %><HTML><head><%@include file="../../../components/scripts/server/headInclude.jsp" %></head><body><jsp:useBean id="dBean" scope="session" class="com.dogma.bean.administration.DashboardBean"></jsp:useBean><TABLE class="pageTop"><COL class="col1"><COL class="col2"><TR><TD><%=LabelManager.getName(labelSet,"lblDashboard")%></TD><TD></TD></TR></TABLE><DIV id="divContent" class="divContent"><form id="frmMain" name="frmMain" method="POST"><%
			Collection col = dBean.getDependencies();
			if (col!=null && col.size()>=1) {
				Iterator it = col.iterator();
				boolean blnWidgets = true;
				boolean finShowWidgets = false; 
				int countShownWidgets = 1; 
				
				while (it.hasNext() && (!finShowWidgets)) {
					Object obj = it.next();
					if (obj instanceof WidgetVo) {
						if (countShownWidgets > Parameters.MAX_DEPENDENCIES_SHOWN && !finShowWidgets) {
							out.print("<BR>" + LabelManager.getName(labelSet,"lblMasDep"));
							finShowWidgets = true;
						} else if (!finShowWidgets){
							if (blnWidgets) { %><DIV class="subTit"><%=LabelManager.getName(labelSet,"sbtDepWidgets")%></DIV><%
								blnWidgets = false;
							}
							String widStr = ((WidgetVo) obj).getWidName();
							if (((WidgetVo) obj).getWidDesc() != null && !"".equals(((WidgetVo) obj).getWidDesc())){
								widStr = widStr + " (" + ((WidgetVo) obj).getWidDesc() + ")";
							}
							out.print("<LI class=\"liDep\">" + widStr + "</a>");
							countShownWidgets++;
						}
					} 
				}
			} else {
				out.print(LabelManager.getName(labelSet,"lblNoDep"));
			}
		%></FORM></DIV><TABLE class="pageBottom"><COL class="col1"><COL class="col2"><TR><TD></TD><TD><button type="button" onclick="lnkDownDeps_click()" <%if (col.size() == 0){%>disabled<%}%> accesskey="<%=LabelManager.getAccessKey(labelSet,"btnDwnDeps")%>" title="<%=LabelManager.getToolTip(labelSet,"btnDwnDeps")%>"><%=LabelManager.getNameWAccess(labelSet,"btnDwnDeps")%></button><button type="button" onclick="btnBack_click()" accesskey="<%=LabelManager.getAccessKey(labelSet,"btnVol")%>" title="<%=LabelManager.getToolTip(labelSet,"btnVol")%>"><%=LabelManager.getNameWAccess(labelSet,"btnVol")%></button><button type="button" onclick="splash()" accesskey="<%=LabelManager.getAccessKey(labelSet,"btnSal")%>" title="<%=LabelManager.getToolTip(labelSet,"btnSal")%>"><%=LabelManager.getNameWAccess(labelSet,"btnSal")%></button></TD></TR></TABLE></body></html><%@include file="../../../components/scripts/server/endInc.jsp" %><script language="javascript">
function btnExit_click(){
	splash();
}

function btnBack_click() {
	document.getElementById("frmMain").action = "biDesigner.DashboardAction.do?action=backToList";
	submitForm(document.getElementById("frmMain"));
}
function lnkDownDeps_click(){
	document.getElementById("frmMain").action = "biDesigner.DashboardAction.do?action=downDepsTxt";
	document.getElementById("frmMain").submit();	
}
</script>