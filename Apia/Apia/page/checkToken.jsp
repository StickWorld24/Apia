<%@page import="com.dogma.security.business.SessionEntry"%><%@page import="java.util.Collection"%><%@page import="com.st.db.dataAccess.DBConnection"%><%@page import="com.dogma.dataAccess.DBManagerUtil"%><%@page import="com.dogma.security.client.SecurityClient"%><%
boolean valid = false;
DBConnection c = null;
try{
c = DBManagerUtil.getApiaConnection();
SecurityClient client = new SecurityClient();
client.setDBConnection(c);
try{
	Collection<SessionEntry> sessions = client.getSessions("APIA", null,-1, null, null, null, null);
		
	if(sessions!=null){
		for (SessionEntry sesent : sessions) {
			if(sesent.getLogin().equals(request.getParameter("user"))){
// 				long actual = sesent.getMilisToRecycle();
// 				long token = Long.valueOf(request.getParameter("token")).longValue();
// 				long margen = 5000;
// 				long min = token - margen;
// 				long max = token + margen;
// 				if( actual>min && actual<max) {
// 					valid = true;
// 				}
				int id = sesent.getSessionid().hashCode(); 
				int token = Integer.valueOf(request.getParameter("token")).intValue();
				if(token==id){
					valid = true;
				}
			}
		}
	}
	 
} catch(Exception e){
	e.printStackTrace();
	 
} finally {
	client.cleanConnection();
}


} finally {
	DBManagerUtil.close(c);
}

if(request.getHeader("User-Agent").indexOf("Firefox")<0){
	response.setHeader("Pragma","public no-cache");
}else{	
	response.setHeader("Pragma","no-cache");
}
response.setHeader("Cache-Control","no-store");
response.setDateHeader("Expires",-1); 
response.setCharacterEncoding(com.dogma.Parameters.APP_ENCODING);
response.setContentType("text/xml");
out.clear();
out.print(valid);
%>