<%@page import="biz.statum.sdk.util.StringUtil"%><%@page import="com.dogma.util.DownloadUtil"%><%@page import="com.dogma.vo.*"%><%@page import="com.dogma.*"%><%@page import="java.util.*"%><%@page import="com.dogma.Parameters"%><jsp:useBean id="qBean" scope="session" class="com.dogma.bean.query.EntInstanceBean"></jsp:useBean><%
com.dogma.bean.query.EntInstanceBean dBean = qBean;

response.setContentType("application/x-msdownload;charset=ISO-8859-1");
String fileName = StringUtil.replaceAll(qBean.getQueryVo().getQryTitle(), StringUtil.SPACE_STRING, StringUtil.UNDERBAR_SEPARATOR);
response.setHeader("Content-Disposition", "attachment; filename=\"" + fileName + ".csv\"");
String separator = Parameters.CSV_FIELD_SEPARATOR;
String lineSeparator = DownloadUtil.LINE_SEPARATOR;
out.clear();

out.print(dBean.generateQueryCsv(request));

%>