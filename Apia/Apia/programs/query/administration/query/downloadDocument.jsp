<%@ page import = "com.dogma.vo.*"%><%@ page import	= "com.dogma.bean.*"%><%@ page import	= "com.dogma.util.DownloadUtil"%><%@ page import = "javax.activation.*"%><%@ page import = "java.io.*"%><%@ page import = "java.util.*"%><jsp:useBean id="qBean" scope="session" class="com.dogma.bean.query.QueryBean"></jsp:useBean><%
	DocumentBean dBean = qBean.getDocumentBean(request);
	out.clear();
	
	DocumentVo docVo = null;
	docVo = dBean.getDocumentDownloadConf(request);

	ServletOutputStream outs = response.getOutputStream();

	response.setContentType("application/x-msdownload"); 

	if (docVo == null || docVo.getDocName() == null){
		response.setHeader("Content-Disposition", "attachment; filename=ERROR");
	} else {
	String sourceFile = docVo.getTmpFilePath();
	String fileName = docVo.getDocName();
	fileName = fileName.replaceAll(" ","_");

	response.setHeader("Content-Disposition", "attachment; filename=" + fileName);

	try {
	
	FileInputStream in = new FileInputStream(sourceFile);

	byte[] buffer = new byte[8 * 1024];
	int count = 0;
	do {
		outs.write(buffer, 0, count);
		count = in.read(buffer, 0, buffer.length);
	} while (count != -1);

	in.close();
	outs.close();

	//Borramos el documento del dir temporal
	File docFileFrom = new File(sourceFile);
	docFileFrom.delete();

	} catch (Exception e) {
		e.printStackTrace();
		response.setHeader("Content-Disposition", "attachment; filename=ERROR");
	}
	}
%>