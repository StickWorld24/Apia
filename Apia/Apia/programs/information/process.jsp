<%@page import="com.dogma.vo.*"%><%@page import="com.dogma.vo.custom.*"%><%@include file="../../components/scripts/server/startInc.jsp" %><HTML><head><%@include file="../../components/scripts/server/headInclude.jsp" %></head><body><jsp:useBean id="dBean" scope="session" class="com.dogma.bean.DogmaAbstractBean"></jsp:useBean><% ProcessVo proVo = com.dogma.bean.administration.ProcessBean.getProcessInfo(request); %><table class="pageTop"><col class="col1"><col class="col2"><tr><td><%=LabelManager.getName(labelSet,"titPro")%></td><td></td></tr></table><div id="divContent" class="divContent"><form id="frmMain" name="frmMain" method="POST"><div class="subTit"><%=LabelManager.getName(labelSet,"sbtDat")%></div><table class="tblFormLayout"><col class="col1"><col class="col2"><col class="col3"><col class="col4"><tr><td title="<%=LabelManager.getToolTip(labelSet,"lblNom")%>"><%=LabelManager.getName(labelSet,"lblNom")%>:</td><td><%=dBean.fmtStr(proVo.getProName())%></td><td title="<%=LabelManager.getToolTip(labelSet,"lblDes")%>"><%=LabelManager.getName(labelSet,"lblDes")%>:</td><td><%=dBean.fmtHTML(proVo.getProDesc())%></td></tr><tr><tr><td title="<%=LabelManager.getToolTip(labelSet,"lblAccPro")%>"><%=LabelManager.getName(labelSet,"lblAccPro")%>:</td><td><%=ProcessVo.PROCESS_ACTION_CREATION.equals(proVo.getProAction())?LabelManager.getName(labelSet,"lblAccProCre"):""%><%=ProcessVo.PROCESS_ACTION_ALTERATION.equals(proVo.getProAction())?LabelManager.getName(labelSet,"lblAccProAlt"):""%><%=ProcessVo.PROCESS_ACTION_CANCEL.equals(proVo.getProAction())?LabelManager.getName(labelSet,"lblAccProCan"):""%></td><td title="<%=LabelManager.getToolTip(labelSet,"lblTipPro")%>"><%=LabelManager.getName(labelSet,"lblTipPro")%>:</td><td><%=ProcessVo.PROCESS_TYPE_AUTO.equals(proVo.getProType())?LabelManager.getName(labelSet,"lblTipProAut"):""%><%=ProcessVo.PROCESS_TYPE_MANUAL.equals(proVo.getProType())?LabelManager.getName(labelSet,"lblTipProMan"):""%></td></tr><tr><td title="<%=LabelManager.getToolTip(labelSet,"lblProDurMax")%>"><%=LabelManager.getName(labelSet,"lblProDurMax")%>:</td><td><%=dBean.fmtInt(proVo.getProMaxDuration())%></td><td title="<%=LabelManager.getToolTip(labelSet,"lblTipNot")%>"><%=LabelManager.getName(labelSet,"lblTipNot")%>:</td><td><%//=	(ProcessVo.PROCESS_NOT_TYPE_EMAIL.equals(proVo.getProAlertType()) || ProcessVo.PROCESS_NOT_TYPE_BOTH.equals(proVo.getProAlertType()))?LabelManager.getName(labelSet,"lblProNotMail"):"" %><%//= (ProcessVo.PROCESS_NOT_TYPE_BOTH.equals(proVo.getProAlertType()))?"<br>":""%><%//=	(ProcessVo.PROCESS_NOT_TYPE_MESSAGE.equals(proVo.getProAlertType()) || ProcessVo.PROCESS_NOT_TYPE_BOTH.equals(proVo.getProAlertType()))?LabelManager.getName(labelSet,"lblProNotMes"):"" %></td></tr><tr><td title="<%=LabelManager.getToolTip(labelSet,"lblProDurAle")%>"><%=LabelManager.getName(labelSet,"lblProDurAle")%>:</td><td><%=dBean.fmtInt(proVo.getProAlertDuration())%></td></tr></table></form></div><table class="pageBottom"><col class="col1"><col class="col2"><tr><td></td><td><button type="button" onclick="btnExit_click()" accesskey="<%=LabelManager.getAccessKey(labelSet,"btnSal")%>" title="<%=LabelManager.getToolTip(labelSet,"btnSal")%>"><%=LabelManager.getNameWAccess(labelSet,"btnSal")%></button></td></tr></table></body></html><%@include file="../../components/scripts/server/endInc.jsp" %><script>
function btnExit_click() {
	window.close();
}
</script>

