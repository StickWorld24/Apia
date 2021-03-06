<%@page import="com.dogma.vo.*"%><%@page import="java.util.*"%><%@include file="../../components/scripts/server/startInc.jsp" %><HTML><head><%@include file="../../components/scripts/server/headInclude.jsp" %></head><body><%
com.dogma.bean.DogmaAbstractBean aBean = (com.dogma.bean.DogmaAbstractBean) session.getAttribute("dBean");
com.dogma.bean.DocumentBean dBean = aBean.getDocumentBean(request);
Collection docSignatures = dBean.getDocumentSignatures(request);
%><TABLE class="pageTop"><COL class="col1"><COL class="col2"><TR><TD><%=LabelManager.getName(labelSet,"titVerSignatures")%></TD><TD></TD></TR></TABLE><DIV id="divContent" class="divContent"><form id="frmMain" name="frmMain" method="POST" onSubmit="return false"><DIV class="subTit"><%=LabelManager.getName(labelSet,"titVerSignatures")%></DIV><div type="grid" id="gridForms" style="height:150px"><table width="500px" cellpadding="0" cellspacing="0"><thead><tr><th style="width:30%" title="<%=LabelManager.getToolTip(labelSet,"lblSigUsu")%>"><%=LabelManager.getToolTip(labelSet,"lblSigUsu")%></th><th style="width:40%" title="<%=LabelManager.getToolTip(labelSet,"lblSigDate")%>"><%=LabelManager.getName(labelSet,"lblSigDate")%></th><th style="width:15%" title="<%=LabelManager.getToolTip(labelSet,"lblVerSig")%>"><%=LabelManager.getName(labelSet,"lblVerSig")%></th><th style="width:15%" title="PKCS7">PKCS7</th></tr></thead><tbody><%if(docSignatures!=null){ 
				   			Iterator it = docSignatures.iterator();
				   			while(it.hasNext()){
				   				UsrSignsVo vo = (UsrSignsVo)it.next();
				   		%><tr><td><%=aBean.fmtStr(vo.getUsrSignLogin()) %></td><td><%=aBean.fmtDateAMPM(vo.getUsrSignDate()) %></td><td><img style="cursor:hand" src="<%=Parameters.ROOT_PATH%>/images/signCheck.gif" onclick="checkSign('<%=aBean.fmtInt(vo.getUsrSignId()) %>')"></td><td><button onclick="downloadPKCS7(<%=vo.getUsrSignId() %>)"><%=LabelManager.getName(labelSet,"btnDow")%></button></td></tr><%	 }
				   		} %></tbody></table></div></form></div><TABLE class="pageBottom"><COL class="col1"><COL class="col2"><COL class="col3"><TR><TD align="rigth"><button type="button" onclick="btnExit_click()" accesskey="<%=LabelManager.getAccessKey(labelSet,"btnSal")%>" title="<%=LabelManager.getToolTip(labelSet,"btnSal")%>"><%=LabelManager.getNameWAccess(labelSet,"btnSal")%></button></TD></TR></TABLE><iframe style="display:none" id="ifrDownload"></iframe></body></html><%@include file="../../components/scripts/server/endInc.jsp" %><script language="javascript">	

function checkSign(signId){
	
	var	http_request = getXMLHttpRequest();
	
	http_request.open('POST', "DocumentAction.do?action=verifySignature", false);
	http_request.setRequestHeader("content-type","application/x-www-form-urlencoded; charset=utf-8");
    http_request.send("signId=" + signId + "&docId=<%=request.getParameter("docId")%>");
    
     if (http_request.readyState == 4) {
            if (http_request.status == 200) {
                if(http_request.responseText == "OK"){
                	alert(DIGITAL_SIGNATURE_OK);
                } else if (http_request.responseText == "OK_REV") {
                	alert(DIGITAL_SIGNATURE_OK_CERT);
                } else {
                	alert(DIGITAL_SIGNATURE_NOK);
                }
            } else {
               	alert("Could not contact the server.");            
            }
        }
	
}

function btnExit_click() {
	window.returnValue=null;
	window.close();
}

function downloadPKCS7(signId){
	document.getElementById("ifrDownload").src="DocumentAction.do?action=downloadPKCS7&signId=" + signId;
}

</script>
 