<%@page import="com.st.util.labels.LabelManager"%><%@page import="biz.statum.apia.web.bean.design.FormsBean"%><%@page import="biz.statum.sdk.util.HttpServletRequestResponse"%><%@page import="biz.statum.apia.web.action.design.FormsAction"%><%@page import="com.dogma.Parameters"%><%@page import="com.dogma.UserData"%><%
if(request.getHeader("User-Agent").indexOf("Firefox") < 0)
	response.setHeader("Pragma","public no-cache");
else
	response.setHeader("Pragma","no-cache");

response.setHeader("Cache-Control","no-store");
response.setDateHeader("Expires",-1); 
response.setCharacterEncoding("utf-8");

Integer labelSet = Parameters.DEFAULT_LABEL_SET;
Integer langId = Parameters.DEFAULT_LANG;

//UserData uData = (com.dogma.UserData)session.getAttribute("sessionAttribute");
com.dogma.UserData uData = biz.statum.apia.web.bean.BasicBeanStatic.getUserDataStatic(request);
if (uData != null) {
	labelSet = uData.getLabelSetId();
	langId = uData.getLangId();
}

String acc = request.getParameter("action");
String values = "";
if("definition".equals(acc)) {
	
} else {
	FormsBean dBean = FormsAction.staticRetrieveBean(new HttpServletRequestResponse(request, response));
	values = dBean.getModalData(request, response);	
}

%><?xml version="1.0" ?><forms><data><level width="0" name="id" label="id" type="label" hidden="true" /><level width="40%" name="name" label="<%=LabelManager.getName(labelSet, langId, "flaNom")%>" type="label" /><level width="60%" name="label" label="<%=LabelManager.getName(labelSet, langId, "lblTit")%>" type="label" /></data><values><%=values%></values></forms>