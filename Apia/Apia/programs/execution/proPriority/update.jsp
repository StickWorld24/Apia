
<%@page import="com.dogma.vo.*"%><%@page import="com.dogma.vo.filter.*"%><%@page import="java.util.*"%><%@page import="com.dogma.bean.query.MonitorProcessesBean"%><%@include file="../../../components/scripts/server/startInc.jsp" %><HTML><head><%@include file="../../../components/scripts/server/headInclude.jsp" %></head><body><jsp:useBean id="dBean" scope="session" class="com.dogma.bean.execution.ProPriorityBean"></jsp:useBean><TABLE class="pageTop"><COL class="col1"><COL class="col2"><TR><TD><%=LabelManager.getName(labelSet,"titPriPro")%></TD><TD></TD></TR></TABLE><%
ProcessVo proVo =  dBean.getProVo();
ProInstanceVo proInstVo = dBean.getProInstVo();
String template = "/templates/taskDefault.jsp";
request.setAttribute("priProFnc","true");
%><DIV id="divContent" class="divContent"><form id="frmMain" name="frmMain" method="POST"><%@include file="../includes/processMain.jsp"%></region:put></form></div><TABLE class="pageBottom"><COL class="col1"><COL class="col2"><TR><TD></TD><TD><button type="button" onclick="btnBack_click()" accesskey="<%=LabelManager.getAccessKey(labelSet,"btnMonBack")%>" title="<%=LabelManager.getToolTip(labelSet,"btnMonBack")%>"><%=LabelManager.getNameWAccess(labelSet,"btnMonBack")%></button><button type="button" onclick="btnConf_click()" accesskey="<%=LabelManager.getAccessKey(labelSet,"btnCon")%>" title="<%=LabelManager.getToolTip(labelSet,"btnCon")%>"><%=LabelManager.getNameWAccess(labelSet,"btnCon")%></button><button type="button" onclick="splash()" accesskey="<%=LabelManager.getAccessKey(labelSet,"btnSal")%>" title="<%=LabelManager.getToolTip(labelSet,"btnSal")%>"><%=LabelManager.getNameWAccess(labelSet,"btnSal")%></button></TD></TR></TABLE></body></html><%@include file="../../../components/scripts/server/endInc.jsp" %><script language="javascript" src='<%=Parameters.ROOT_PATH%>/programs/execution/proPriority/proPriority.js'></script>