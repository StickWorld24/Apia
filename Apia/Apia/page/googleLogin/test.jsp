<%@page import="com.apia.core.CoreFacade"%><%@page import="com.dogma.vo.EnvironmentVo"%><%@page import="java.io.OutputStreamWriter"%><%@page import="com.dogma.Configuration"%><%@page import="com.dogma.Parameters"%><%@page import="com.dogma.controller.ThreadData"%><%@page import="biz.statum.apia.web.bean.security.LoginBean"%><%@page import="org.json.JSONException"%><%@page import="org.json.JSONObject"%><%@page import="java.net.URLEncoder"%><%@page import="java.io.InputStreamReader"%><%@page import="java.io.BufferedReader"%><%@page import="java.net.URLConnection"%><%@page import="java.net.URL"%><%		

      
            Integer langId= 1;
            Integer envId= 1;
            
            LoginBean lb = new LoginBean();
            ThreadData.set(ThreadData.LOGINFROMFACEBOOK, "true");
            String messages = lb.createFacebookGoogleUser("xxxxx","xxxxx","","Google");
            int res = lb.login(request, envId, "xxxxx", null, null, langId);
            if(res == LoginBean.LOGIN_OK){
            	String tokenId = ThreadData.getUserData().getTokenId();
            	response.sendRedirect(Parameters.ROOT_PATH+"/apia.security.LoginAction.run?action=gotoSplash&tokenId=" + tokenId + "&tabId=1");
            } else {
            	response.sendRedirect(Parameters.ROOT_PATH+"/errorSSOLogin.jsp?message="+messages);
            }
%>