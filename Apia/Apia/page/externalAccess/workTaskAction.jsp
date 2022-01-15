<%@page import="biz.statum.apia.web.LinkFactory"%><%@page import="com.dogma.vo.TasksListVo"%><%@page import="biz.statum.sdk.util.HttpServletRequestResponse"%><%@page import="biz.statum.apia.web.bean.taskslist.TasksListBean"%><%@include file="../includes/startInc.jsp" %><%@page import="com.apia.execution.ExternalService"%><%@page import="com.dogma.vo.EnvironmentVo"%><%@page import="com.apia.core.CoreFacade"%><%@page import="com.dogma.EnvParameters"%><%@page import="com.dogma.Parameters"%><%@page import="com.st.util.labels.LabelManager"%><%@page import="com.dogma.bean.DogmaAbstractBean"%><%@page import="com.dogma.bean.execution.ListTaskBean"%><%@page import="java.util.*"%><%@page import="com.dogma.UserData"%><%@page import="com.dogma.bean.DogmaAbstractBean"%><%@page import="com.st.util.StringUtil"%><%@page import="com.dogma.ExternalAccessLoader"%><%


	//  * Abre el formulario de la primer tarea de la lista de tareas de un usuario sin hacer login, ni seleccionar la tarea, selecciona la primera, si no hay ninguna en la lista de tareas libres la saca de mis tareas
	//	* @param user				user
	//	* @param pass				password
	//  * @param logFromFile 		if (param user is null or param pass is null) and (logFromFile is true or Y), get user and pass from file externalAccessUsers.xml (if null --> false)
	//  * @param logFromSession		if (param user is null or param pass is null) and (logFromFile is false or N or null) and (logFromSession is true or Y), get user and pass from session (if null --> false)
	//  * @param askLogin 			if (param user is null or param pass is null) and (logFromFile is false or N or null) and (logFromSession is false or N or null) and (askLogin is true or Y) the application ask for a user and password. (Default if param user=null, pass=null and logFromFile=false
	//	* @param remoteUser			remote user (user that call the url)
	//	* @param env	environment (if null --> env = 1)
	//	* @param lang	language    (if null or wrong --> lang = 1)
	//  * @param nomTsk	Task name   (if null take the first one in the list)
    //  * @param numInst Instance number of the process (if null take the first one in the list)
	//  * @param onFinish			action on finish (1:close window (DEFAULT), 2:execute url again, 4:close tab. 5: gotoUrl, 100: customOnFinish)
	//  * @param onFinishURL		url to navigate on finish
	//  * @param sessionAtts		atributes and values to store in the http session (usage:  &sessionAtts=name,value,name,value)
	//  * @param eatt_typ_nom (TYP could be 'str','num' or 'dte' and NOM the name of the attribute, ex: eatt_num_suc)
	//  * @param patt_typ_nom (TYP could be 'str','num' or 'dte' and NOM the name of the attribute, ex: patt_num_suc)
	//	* @param encryptedPass		indicates if password is encrypted 

	// se pueden omitir [[user], [pass], [logFromFile], [logFromSession], [askLogin], [remoteUser],[env], [lang], [onFinish], [sessionAtts], [nomTsk], [numInst], [nomProc], [eatt_typ_nom]

	//Ejemplos:
	//http://localhost:8080/ApiaDesarrollo/programs/login/workTask.jsp --> Abre la ventana de login (en lenguaje default) y luego captura la primer tarea de la lista de tareas libres o de las capturadas si no hay ninguna en las libres, al terminar cierra la ventana
	//http://localhost:8080/ApiaDesarrollo/programs/login/workTask.jsp?user=admin&pass=admin  --> Captura la primer tarea de la lista de tareas libres o de las capturadas si no hay ninguna en las libres
	//http://localhost:8080/ApiaDesarrollo/programs/login/workTask.jsp?user=admin&pass=admin&env=1&lang=2&onFinish=3 -->Idem anterior pero en portugues
	//http://localhost:8080/ApiaDesarrollo/programs/login/workTask.jsp?user=admin&pass=admin&nomTsk=TAREA_SUB_UNO --> Captura la primer tarea de nombre TAREA_SUB_UNO
	//http://localhost:8080/ApiaDesarrollo/programs/login/workTask.jsp?user=admin&pass=admin&nomTsk=TAREA_SUB_UNO&numInst=11 --> Captura la tarea TAREA_SUB_UNO cuyo numero de instancia es 11

//http://localhost:8080/Apia164Estable/programs/login/workTask.jsp?user=admin&pass=admin&nomTsk=TAREA2&eatt_num_att_ent=1234			
//http://localhost:8080/Apia164Estable/programs/login/workTask.jsp?user=admin&pass=admin&nomTsk=TAREA2&eatt_num_att_ent=1234&eatt_str_att_ent2=casa
//http://localhost:8080/Apia164Estable/programs/login/workTask.jsp?user=admin&pass=admin&nomTsk=TAREA2&eatt_num_att_ent=1234&patt_str_att_proc=casa
//http://localhost:8080/Apia164Estable/programs/login/workTask.jsp?user=admin&pass=admin&nomTsk=TAREA2&eatt_num_att_ent=1234&eatt_str_att_ent2=casaent&patt_str_att_proc=casaproc		
//http://localhost:8080/Apia164Estable/programs/login/workTask.jsp?user=admin&pass=admin&nomTsk=TAREA2&eatt_num_att_ent=1234&eatt_str_att_ent2=casaent&patt_str_att_proc=casaproc&onFinish=2		
//http://localhost:8080/Apia164Estable/programs/login/workTask.jsp?user=admin&pass=admin&env=1&lang=1&nomTsk=TAREA2&numInst=null&onFinish=2&eatt_dte_fecha=05/12/2008		
			
	Integer langId = null;
	Integer labelSet = Parameters.DEFAULT_LABEL_SET;
	String nomTsk = null;
	String numInst = null;
	String onFinish = "1"; //por defecto 
	String onFinishURL = "";
	String sessionAtts = null;
	boolean logged = false; //de uso interno
// 	String token = null;
	
	String styleDirectory = "default";
	UserData userData = BasicBeanStatic.getUserDataStatic(request);
	if (userData!=null) {
		styleDirectory = EnvParameters.getEnvParameter(userData.getEnvironmentId(),EnvParameters.ENV_STYLE);
	}
	//token 
// 	if (request.getParameter("token") != null && !"null".equals(request.getParameter("token")) && !"".equals(request.getParameter("token"))) {
// 		token = request.getParameter("token");
// 	}

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
	
	//Obtenemos lenguaje
	if (request.getParameter("lang") != null
			&& !"null".equals(request.getParameter("lang"))) {
		try{
			langId = Integer.valueOf(request.getParameter("lang"));
		}catch(Exception e){
			langId = Parameters.DEFAULT_LANG;	
		}
	} else {
		langId = Parameters.DEFAULT_LANG;
	}
	
	//Obtenemos nombre de la tarea
	if (request.getParameter("nomTsk") != null	&& !"null".equals(request.getParameter("nomTsk"))) {
		nomTsk = String.valueOf(request.getParameter("nomTsk"));
	}
	
	//Obtenemos numero de instancia de la tarea
	if (request.getParameter("numInst") != null && !"null".equals(request.getParameter("numInst"))) {
		numInst = request.getParameter("numInst");
	}
	
	//Obtenemos acción final
	if (request.getParameter("onFinish") != null && !"null".equals(request.getParameter("onFinish")) && !"".equals(request.getParameter("onFinish"))) {
		onFinish = request.getParameter("onFinish");
	}
	
	
	//onFinishURL
	if (request.getParameter("onFinishURL") != null && !"null".equals(request.getParameter("onFinishURL")) && !"".equals(request.getParameter("onFinishURL"))) {
		onFinishURL = request.getParameter("onFinishURL");
	}
	
	//Obtenemos parametro que indica si el password viene encriptada
// 	if (request.getParameter("encryptedPass")!=null && "true".equals(request.getParameter("encryptedPass")) && request.getParameter("pass")!=null && !"".equals(request.getParameter("pass"))){
// 		pass = ExternalService.decryptApia(request.getParameter("pass"));
// 	}
	
	
	userData.setOnFinish(onFinish);
	userData.setOnFinishURL(onFinishURL);
	userData.setExternalMode(true);
	
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
	
	HttpServletRequestResponse http = new HttpServletRequestResponse(request, response);
	TasksListBean tlBean = new TasksListBean("apia.taskslist.TasksListAction");
	tlBean.init(http);
	TasksListVo vo = tlBean.getTaskForUrl(http, nomTsk, numInst, userData);
	
	if (vo==null){
		request.getRequestDispatcher("/page/externalAccess/messages.jsp?messageText=" + LabelManager.getName(1,langId, "msgTskNotExi")).forward(request, response);
		return;
	}
	
	//verificar si esta adquirida
	if(!vo.isAdquired()){
		///adquirir
		tlBean.aquireTaskForUrl(http,vo.getProcInstId(),vo.getTaskInstId());
	}
	
	
	Integer proInstId = vo.getProcInstId();
	Integer proEleInstId = vo.getTaskInstId();
	
	String tokenId = userData.getTokenId();
	
		
	String redirectUrl=LinkFactory.createExecutionTaskActionForceAcquire(proInstId, proEleInstId, tokenId);
	
	
	if(attParams!=null) redirectUrl += "&attParams=" + attParams;
	if(sessionAtts!=null) redirectUrl += "&sessionAtts=" + sessionAtts;
	
// 	System.out.println(redirectUrl);
	 

%><!DOCTYPE html><html lang="<%=biz.statum.apia.web.bean.BasicBeanStatic.getUserDataStatic(request).getLangCode()%>"><head><%@include file="../includes/headInclude.jsp" %><script type="text/javascript">
			function init(){
				document.getElementById("workArea").style.height = (getStageHeight() - 2) + "px";
				document.getElementById("workArea").src="<%=Parameters.ROOT_PATH + "/" + redirectUrl%>";
				document.getElementById("workArea").style.left="0px";
				document.getElementById("workArea").style.top="0px";
			}
			function showLoading() {
				SYS_PANELS.showLoading();
			}
			function initPage() {}
		</script></head><body style="margin: 0px;" onload="init();showLoading();" class="no-padding"><iframe title="workTask" name="workArea" id="workArea" onload="SYS_PANELS.closeAll();" style="width:100%;height:100%;border:0px;" <%= request.getHeader("user-agent").contains("MSIE 8.0") ? "scrolling=\"auto\" frameBorder=0" : ""%>></iframe></body></html>	
 

