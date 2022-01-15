<%@page import="biz.statum.sdk.util.CollectionUtil"%><%@page import="java.util.ArrayList"%><%@page import="java.util.zip.ZipEntry"%><%@page import="java.io.FileOutputStream"%><%@page import="java.util.zip.ZipOutputStream"%><%@page import="com.dogma.Parameters"%><%@page import="java.util.Map"%><%@page import="java.util.HashMap"%><%@page import="java.util.Collection"%><%@page import="biz.statum.sdk.util.FileUtil"%><%@page import="biz.statum.sdk.util.StringUtil"%><%@ page import = "java.io.File"%><%@page import="java.io.FileInputStream"%><%@page import="biz.statum.apia.web.action.monitor.MonitorDocumentAction"%><%@page import="biz.statum.apia.web.bean.monitor.MonitorDocumentBean"%><%@page import="com.dogma.vo.DocumentVo"%><%@page import="biz.statum.sdk.util.HttpServletRequestResponse"%><%

out.clear();
String fileName = null;
String srcFile = null;
HashMap<String, String> srcFileLocAndName = null;
String zipFile = null;
try {
	HttpServletRequestResponse http = new HttpServletRequestResponse(request,response);
	MonitorDocumentBean bean = MonitorDocumentAction.staticRetrieveBean(http,false);

	//CAM_12370: si se redirige a este JSP, no ocurren errores al obtener documento
	srcFileLocAndName = bean.getDocTmpPathNdName();
	response.setContentType("application/force-download;charset=" + com.dogma.Parameters.APP_ENCODING);
	ServletOutputStream outs = response.getOutputStream();
	
	
	if (srcFileLocAndName.size() == 1) {
		srcFile = (String) srcFileLocAndName.keySet().toArray()[0];
		fileName = srcFileLocAndName.get(srcFile);
		response.setHeader("Content-Disposition", "attachment; filename=\"" + fileName + "\"");
	} else {
		response.setHeader("Content-Disposition", "attachment; filename=\"" + "documents.zip" + "\"");
		Collection<String> mapValues = new ArrayList<String>();
		Integer index = 1;
		
		zipFile = Parameters.TMP_FILE_STORAGE + "documents.zip";
		new File(zipFile).createNewFile();
		ZipOutputStream zos = new ZipOutputStream(new FileOutputStream(zipFile));
		
		for (Map.Entry<String, String> entry : srcFileLocAndName.entrySet()) {
			String sourceFile = entry.getKey();
			fileName = entry.getValue();
			fileName = fileName.replaceAll(" ","_");
			if (mapValues.contains(fileName)) {
				String name = fileName.substring(0, fileName.indexOf("."));
				String ext = fileName.substring(fileName.indexOf(".") + 1);
				fileName = name + "(" + index + ")." + ext;
				index++;
			} else {
				mapValues.add(fileName);
			}
			FileInputStream in = new FileInputStream(sourceFile);
			zos.putNextEntry(new ZipEntry(fileName));

			byte[] buffer = new byte[8 * 1024];
			int count = 0;
			do {
				zos.write(buffer, 0, count);
				count = in.read(buffer, 0, buffer.length);
			} while (count != -1);

			zos.closeEntry();
			in.close();
		}
		zos.close();
		srcFile = zipFile;
	}
	
	FileInputStream in = new FileInputStream(srcFile);
	
	byte[] buffer = new byte[8 * 1024];
	int count = 0;
	do {
		outs.write(buffer, 0, count);
		count = in.read(buffer, 0, buffer.length);
	} while (count != -1);
	
	in.close();
	outs.close();

} catch (Exception e) {
	e.printStackTrace();
	response.setHeader("Content-Disposition", "attachment; filename=ERROR");
} finally {
	if (StringUtil.notEmpty(zipFile)) FileUtil.deleteFile(zipFile);
	if (srcFileLocAndName != null && srcFileLocAndName.size() > 0) {
		for (String fName : srcFileLocAndName.keySet()) {
			FileUtil.deleteFile(fName);
		}
	}
}

%>