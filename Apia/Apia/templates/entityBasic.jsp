<%@ taglib uri='regions' prefix='region' %><%@page import="com.dogma.vo.*"%><%@page import="com.dogma.bean.execution.*"%><%@page import="java.util.*"%><%@include file="../components/scripts/server/startInc.jsp" %><HTML XMLNS:CONTROL><head><%@include file="../components/scripts/server/headInclude.jsp" %></head><body><TABLE class="pageTop"><COL class="col1"><COL class="col2"><TR><TD><region:render section='title'/></TD><TD align="right"><button onclick="showDocs_click()" accesskey="<%=LabelManager.getAccessKey(labelSet,"sbtEjeDoc")%>" title="<%=LabelManager.getToolTip(labelSet,"sbtEjeDoc")%>"><%=LabelManager.getNameWAccess(labelSet,"sbtEjeDoc")%></button></TD></TR></TABLE><region:render section='entitySumMain'/><region:render section='processSumMain'/><div id="divContent" <region:render section='divHeight'/>><form id="frmMain" name="frmMain" method="POST"><region:render section='entityMain'/><region:render section='entityForms'/></FORM></div><TABLE class="pageBottom"><COL class="col1"><COL class="col2"><TR><TD></TD><TD><region:render section='buttons'/></TD></TR></TABLE></body></html><script>
function showDocs_click() {
	openModal("/programs/documents/docExecutionModal.jsp?a=a"+windowId,500,300);
}
</script>
