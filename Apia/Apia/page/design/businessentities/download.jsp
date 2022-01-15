<%@page import="biz.statum.sdk.util.FileUtil"%><%@page import="biz.statum.sdk.util.StringUtil"%><%@ page import = "java.io.File"%><%@page import="java.io.FileInputStream"%><%@page import="com.st.util.labels.*"%><%@page import="biz.statum.apia.web.action.design.BusinessEntitiesAction"%><%@page import="biz.statum.apia.web.bean.design.BusEntitiesBean"%><%@page import="biz.statum.sdk.util.HttpServletRequestResponse"%><%

out.clear();
String tmpFile = null;
String fileName = null;
try {
	HttpServletRequestResponse http = new HttpServletRequestResponse(request,response);
	BusEntitiesBean bean = BusinessEntitiesAction.staticRetrieveBean(http,false);
	tmpFile = bean.getTmpFileName();
	fileName = bean.getFileName();

	if (StringUtil.isEmpty(tmpFile)){
		response.setHeader("Content-Disposition", "attachment; filename=ERROR");
	} else {
		response.setContentType("application/force-download;charset="+com.dogma.Parameters.APP_ENCODING);
		response.setHeader("Content-Disposition", "attachment; filename=\""+fileName+"\"");
		
		FileInputStream in = new FileInputStream(tmpFile);
		ServletOutputStream outs = response.getOutputStream();
		
		byte[] buffer = new byte[8 * 1024];
		int count = 0;
		do {
			outs.write(buffer, 0, count);
			count = in.read(buffer, 0, buffer.length);
		} while (count != -1);

		in.close();
		outs.close();
	}
} catch (Exception e) {
	e.printStackTrace();
	response.setHeader("Content-Disposition", "attachment; filename=ERROR");
} 

%>