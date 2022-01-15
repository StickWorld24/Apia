<%@page import="biz.statum.apia.web.LinkFactory"%><%@page import="java.util.Enumeration"%><%@page import="com.dogma.controller.ThreadData"%><%@page import="com.apia.execution.ExternalService"%><%@include file="../includes/startInc.jsp" %><%@page import="com.apia.core.CoreFacade"%><%@page import="com.dogma.vo.EnvironmentVo"%><%@page import="com.dogma.Parameters"%><%@page import="com.st.util.labels.LabelManager"%><%@page import="com.dogma.UserData"%><%@page import="com.dogma.EnvParameters"%><%@page import="com.dogma.ExternalAccessLoader"%><%


	Integer langId = null;
	Integer labelSet = Parameters.DEFAULT_LABEL_SET;
	String type = null;
	String entInstId = null;
	Integer entCode = null;
	Integer proCode = null;
	Integer proCancelCode = null;
	String onFinish = "1"; //por defecto 
	String onFinishURL = "";
	String sessionAtts = null;
	
	String token = null;
	String styleDirectory = "default";
	UserData userData = BasicBeanStatic.getUserDataStatic(request);
	if (userData!=null) {
		styleDirectory = EnvParameters.getEnvParameter(userData.getEnvironmentId(),EnvParameters.ENV_STYLE);
	}
	
	Integer env = 1; 
	if (request.getParameter("env") != null	&& !"null".equals(request.getParameter("env"))) {
		try{
			env = Integer.valueOf(request.getParameter("env"));
		}catch(NumberFormatException e){
			String envName = request.getParameter("env");
			try{
    			EnvironmentVo eVo = CoreFacade.getInstance().getEnvironment(envName);
    			if(eVo!=null){
    				env=eVo.getEnvId();
    			}
			}catch(Exception ex){
				ex.printStackTrace();
			}
		}
	}
 
	if(userData.getEnvironmentId()==null) userData.setEnvironmentId(env);
	
	//token 
	if (request.getParameter("token") != null && !"null".equals(request.getParameter("token")) && !"".equals(request.getParameter("token"))) {
		token = request.getParameter("token");
	}
	
	//Obtenemos codigoEntidad
	if (request.getParameter("entCode") != null && !"null".equals(request.getParameter("entCode"))) {
		try{
			entCode = Integer.valueOf(request.getParameter("entCode"));
		}catch(NumberFormatException e){
			//Do nothing
		}
	}
	
	
	if (request.getParameter("entInstId") != null && !"null".equals(request.getParameter("entInstId"))) {
		try{
			entInstId = request.getParameter("entInstId");
		}catch(NumberFormatException e){
			//Do nothing
		}
	}
	
	
	//Obtenemos codigoProceso
	if (request.getParameter("proCode") != null && !"null".equals(request.getParameter("proCode"))) {
		try{
			proCode = Integer.valueOf(request.getParameter("proCode"));
		}catch(NumberFormatException e){
			//Do nothing
		}
	}
	
	
	
	//Obtenemos lenguaje
	if (request.getParameter("lang") != null && !"null".equals(request.getParameter("lang"))) {
		try{
			langId = Integer.valueOf(request.getParameter("lang"));
		}catch(Exception e){
			langId = Parameters.DEFAULT_LANG;	
		}
		
	} else {
		langId = Parameters.DEFAULT_LANG;
	}
	//Obtenemos tipo
	if (request.getParameter("type") != null) {
		if (request.getParameter("type").equals("E") || request.getParameter("type").equals("F")) {
			type = "F";
		} else if (request.getParameter("type").equals("P")){
			type = "P";
		}
	}

	//Obtenemos codigoProceso a cancelar
	if (request.getParameter("proCancelCode") != null && !"null".equals(request.getParameter("proCancelCode"))) {
		try{
			proCancelCode = Integer.valueOf(request.getParameter("proCancelCode"));
		}catch(NumberFormatException e){
			//Do nothing
		}
	}
	//Obtenemos acción final
	if (request.getParameter("onFinish") != null && !"null".equals(request.getParameter("onFinish")) && !"".equals(request.getParameter("onFinish"))) {
		onFinish = request.getParameter("onFinish");
	}
	
	//onFinishURL
	if (request.getParameter("onFinishURL") != null && !"null".equals(request.getParameter("onFinishURL")) && !"".equals(request.getParameter("onFinishURL"))) {
		onFinishURL = request.getParameter("onFinishURL");
	}
	
	Enumeration attParamsEnum = request.getParameterNames();
	String attParams = null;
	String errorMsg=null;
	if (userData == null){
		userData = new UserData();
		userData.setLangId(langId);
		userData.setLabelSetId(Parameters.DEFAULT_LABEL_SET);
	}
	
	if (request.getParameter("attParams")!=null && !"".equals(request.getParameter("attParams"))){
		attParams = request.getParameter("attParams");
	}else{
		while (attParamsEnum.hasMoreElements()) {
			String paramName = (String)attParamsEnum.nextElement();
			String arr [] = StringUtil.split(paramName,"_");
			if (arr[0].equals("eatt") || arr[0].equals("patt")) {
				String attType = arr[1].toUpperCase();
				if (!"STR".equals(attType) && !"NUM".equals(attType) && !"DTE".equals(attType)){
					errorMsg = LabelManager.getName(userData.getLabelSetId(),langId,"msgWrngAttType");
				}
				if (request.getParameter(paramName) != null && !"null".equals(request.getParameter(paramName))){
					if (attParams == null){
						attParams = paramName + "=" + String.valueOf(request.getParameter(paramName));
					}else {
						attParams = attParams + ";" + paramName + "=" + String.valueOf(request.getParameter(paramName));
					}
				}
			}
		}
	}
	
	if (request.getParameter("sessionAtts") != null && !"null".equals(request.getParameter("sessionAtts")) && !"".equals(request.getParameter("sessionAtts"))) {
		sessionAtts = request.getParameter("sessionAtts");
		String[] atts = sessionAtts.split(",");
		if(atts.length%2==0){
			for(int i=0;i<atts.length;i=i+2){
				String name= atts[i];
				String value= atts[i+1];
				request.getSession().setAttribute(name,value);
			}
		}else{
			//no es un numero par, entonces falta un valor
			//errorMsg = "invalid value for parameter: sessionAtts";
		}
	}
	
 
	
	String txtBusEntId = entCode!=null?String.valueOf(entCode):"";
	String txtProId = proCode!=null?String.valueOf(proCode):"";
	 
 
	
	userData.setOnFinish(onFinish);
	userData.setOnFinishURL(onFinishURL);
	userData.setExternalMode(true);
	
	String tokenId = String.valueOf(System.currentTimeMillis());
	if (request.getParameter("tokenId")!=null) tokenId = request.getParameter("tokenId");
	
	
	//TODO: ver esto
	//Integer proCancelCode = Integer.valueOf(request.getParameter("proCancelCode")); 
	
	if( "null".equals(entInstId)) entInstId = null;
	String redirectUrl=null;
	if("F".equals(type)){
		if(entInstId==null || entInstId.length()==0 ){
			redirectUrl=LinkFactory.createExecutionTaskActionConfirmSelection(txtBusEntId, tokenId)+"&entInstId="+entInstId;
		}else{
			redirectUrl="/apia.execution.EntInstanceListAction.run?action=update&id=" + entInstId + "&tokenId=" + tokenId + "&tabId=" + System.currentTimeMillis();
		}
	} else {
		if(entInstId==null) {
			redirectUrl=LinkFactory.createExecutionTaskActionStartCreateProcess(txtBusEntId, txtProId, tokenId);
		} else {
			redirectUrl=LinkFactory.createExecutionTaskActionStartAlterationProcess(entInstId, txtProId, tokenId);
		}
	}
	
	if(attParams!=null) redirectUrl += "&attParams=" + attParams;
	if(sessionAtts!=null) redirectUrl += "&sessionAtts=" + sessionAtts;
	
// 	System.out.println(redirectUrl);
	
	
%><!DOCTYPE html><html lang="<%=biz.statum.apia.web.bean.BasicBeanStatic.getUserDataStatic(request).getLangCode()%>"><head><%@include file="../includes/headInclude.jsp" %><script type="text/javascript" src="<%=Parameters.ROOT_PATH%>/js/mootools-core-1.4.5-full-compat.js"></script><script type="text/javascript" src="<%=Parameters.ROOT_PATH%>/js/mootools-more-1.4.0.1-compat.js"></script><script type="text/javascript" src="<%=Parameters.ROOT_PATH%>/js/generics.js"></script><script type="text/javascript">
			function initPage(){
				document.getElementById("workArea").style.height = (getStageHeight() - 2) + "px";
				document.getElementById("workArea").src="<%=Parameters.ROOT_PATH + "/" + redirectUrl%>";
				document.getElementById("workArea").style.left="0px";
				document.getElementById("workArea").style.top="0px";
			}
			function showLoading() {
				SYS_PANELS.showLoading();
			}
		</script></head><body style="margin: 0px;" onload="showLoading();" class="no-padding"><iframe title="open" name="workArea" id="workArea" onload="SYS_PANELS.closeAll();" style="width:100%;height:100%;border:0px;" <%= request.getHeader("user-agent").contains("MSIE 8.0") ? "scrolling=\"auto\" frameBorder=0" : ""%>></iframe></body></html>	
 

