<%@page import="biz.statum.apia.utils.AES"%><%@page import="java.net.URLEncoder"%><%@page import="com.dogma.Configuration"%><%@page import="com.dogma.Parameters"%><%@page import="com.st.util.FileUtil"%><%@page import="biz.statum.apia.utils.AES"%><%@page import="com.dogma.document.DocumentsUtil"%><%@page import="com.dogma.UserData"%><%@ page import="com.dogma.vo.*"%><%@ page import="com.dogma.bean.*"%><%@ page import="com.dogma.util.DownloadUtil"%><%@ page import="javax.activation.*"%><%@ page import="java.io.*"%><%@ page import="java.util.*"%><%@ page trimDirectiveWhitespaces="true"%><%@page language="java"%><%
	String docId = request.getParameter("docId");
	String envId = request.getParameter("envId");
	String tokenId = request.getParameter("tokenId");
	String user = request.getParameter("user");
	String auxDocId = AES.decrypt(docId, tokenId);

	String salt = "12345678910111213141516171819200";
	String iv = "12345678910111213141516171819200";
	String docStr = "";

	String sourceFile = "";
	String fileName = "";
	String url = "";
	try {
            Integer timestamp = 0;
            UserData uData = new UserData();
            uData.setUserId(user);
            DocumentVo docVo = DocumentsUtil.getInstance().getDocumentDownload(new Integer(envId), new Integer(auxDocId), uData);
            if (docVo != null && docVo.getDocName() != null) {
                File tempPdfFile = new File(docVo.getTmpFilePath());
                if (tempPdfFile.exists()) {

                    sourceFile = docVo.getTmpFilePath();
                    fileName = docVo.getDocName();
                    fileName = fileName.replaceAll(" ", "_");
                    docStr = AES.encrypt(sourceFile + "-" + fileName, "APIA", salt, iv);
                    url = Parameters.ROOT_PATH + "/page/execution/preViewDocument.jsp?findContentType=true&avoidContentDisposition=true&docId="+ URLEncoder.encode(docStr,Configuration.JAVA_ENCODING);
                    out.clear();
                    %><object data="<%=url%>"
                      type="application/pdf"
                      width="100%"
                      height="100%"></object><%
                }
            }
            else {
                    out.clear();
                    response.sendRedirect(Parameters.ROOT_PATH + "/page/execution/viewDocError.jsp");
            }
	} catch (Exception e) {
		e.printStackTrace();
		out.clear();
		response.sendRedirect(Parameters.ROOT_PATH + "/page/execution/viewDocError.jsp");
	}
%>


