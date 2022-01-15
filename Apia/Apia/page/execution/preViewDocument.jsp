
<%@page import="com.st.util.FileUtil"%><%@page import="biz.statum.apia.utils.AES"%><%@page import="com.dogma.document.DocumentsUtil"%><%@page import="com.dogma.UserData"%><%@ page import = "com.dogma.vo.*"%><%@ page import	= "com.dogma.bean.*"%><%@ page import	= "com.dogma.util.DownloadUtil"%><%@ page import = "javax.activation.*"%><%@ page import = "java.io.*"%><%@ page import = "java.util.*"%><%	
	out.clear();
try{
        String salt = "12345678910111213141516171819200";
        String iv	= "12345678910111213141516171819200";
        String strDocId = request.getParameter("docId");
        String data = AES.decrypt(strDocId, "APIA",salt,iv);
        String[] arr = data.split("-");
        String sourceFile = arr[0];
        String fileName = arr[1];

        ServletOutputStream outs = response.getOutputStream();
        String findContentType = request.getParameter("findContentType");
        if(findContentType != null && "true".equals(findContentType)){
           String customContentType = FileUtil.getContentTypeOfFile(fileName);
           if(customContentType!=null && !"".equals(customContentType)){
             response.setContentType(customContentType);
           }
        }

        if(request.getParameter("avoidContentDisposition")==null){
          response.setHeader("Content-Disposition", "attachment; filename=" + fileName);
        }

        FileInputStream in = new FileInputStream(sourceFile);
        byte[] buffer = new byte[8 * 1024];
        int count = 0;
        do {
            outs.write(buffer, 0, count);
            count = in.read(buffer, 0, buffer.length);
        } while (count != -1);

        in.close();
        outs.close();

        File docFileFrom = new File(sourceFile);
        docFileFrom.delete();

}catch(Exception e){
	e.printStackTrace();
	response.setHeader("Content-Disposition", "attachment; filename=UnavailableDocument");
}
%>