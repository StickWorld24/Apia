<%@page import="biz.statum.apia.web.action.query.UserAction"%><%@page import="biz.statum.apia.web.bean.query.UserBean"%><%@page import="biz.statum.sdk.util.FileUtil"%><%@page import="biz.statum.sdk.util.StringUtil"%><%@ page import = "java.io.File"%><%@page import="java.io.FileInputStream"%><%@page import="com.dogma.vo.ReportVo" %><%@page import="biz.statum.apia.web.action.execution.GenerateReportAction"%><%@page import="biz.statum.apia.web.bean.execution.GenerateReportBean"%><%@page import="biz.statum.sdk.util.HttpServletRequestResponse"%><%

out.clear();
String sourceFile = null;
try {
	HttpServletRequestResponse http = new HttpServletRequestResponse(request,response);
	UserBean bean = UserAction.staticRetrieveBean(http,false);
	ReportVo repVo = bean.getRepVo();
	
	if (repVo == null || repVo.getRepName() == null){
		response.setHeader("Content-Disposition", "attachment; filename=ERROR");
	} else {
		sourceFile = repVo.getReportOutputPath();
		
		response.setContentType("application/force-download;charset="+com.dogma.Parameters.APP_ENCODING);
		response.setHeader("Content-Disposition", "attachment; filename=\"" + repVo.getRepName() + repVo.getFileType() + "\"");
		
		FileInputStream in = new FileInputStream(sourceFile);
		ServletOutputStream outs = response.getOutputStream();
		
		byte[] buffer = new byte[8 * 1024];
		int count = 0;
		do {
			outs.write(buffer, 0, count);
			count = in.read(buffer, 0, buffer.length);
		} while (count != -1);

		in.close();
		outs.close();
		
		//Borramos el dise?o del reporte del dir temporal
		File tmpRepFileDesign = new File(repVo.getReportOutputPath());
		tmpRepFileDesign.delete();
	}
} catch (Exception e) {
	e.printStackTrace();
	response.setHeader("Content-Disposition", "attachment; filename=ERROR");
} 

%>