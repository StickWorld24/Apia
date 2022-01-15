<%@page import="biz.statum.apia.web.action.security.LoginAction"%><%@page import="com.dogma.Configuration"%><%@page import="biz.statum.apia.web.bean.security.LoginBean"%><%@page import="java.util.Enumeration"%><%@page import="biz.statum.apia.web.bean.BasicBeanStatic"%><%@page import="com.dogma.UserData"%><%@page import="biz.statum.sdk.util.StringUtil"%><%response.setCharacterEncoding(com.dogma.Parameters.APP_ENCODING);%><%@ taglib prefix="system"	uri="/WEB-INF/system-tags.tld" %><%@ taglib prefix='region'  uri='/WEB-INF/regions.tld' %><%@ taglib prefix="c"		uri="http://java.sun.com/jsp/jstl/core" %><%@ page import="com.dogma.Parameters"%><%

boolean isAuthenticated = false;
String remoteUser="";
if(request.getRemoteUser()!=null){
	isAuthenticated = true;
	remoteUser = request.getRemoteUser();
}

if (Boolean.valueOf(request.getParameter("firstTime"))) {
	session.setAttribute("usrNotExists", Boolean.valueOf(request.getParameter("usrNotExists")));
	session.setAttribute("tknExpired", Boolean.valueOf(request.getParameter("tknExpired")));
	session.setAttribute("invalidTkn", Boolean.valueOf(request.getParameter("invalidTkn")));
	session.setAttribute("usrToken", request.getParameter("usrToken"));
}

// var USER_EXISTS 			= "<system:edit show="value" from="theRequest" field="usrExists" />";
// var TOKEN_EXPIRED 			= "<system:edit show="value" from="theRequest" field="tknExpired" />";
// var TOKEN_INVALID			= "<system:edit show="value" from="theRequest" field="invalidTkn" />";
// request.getParameter("usrToken")

UserData uData = BasicBeanStatic.getUserDataStatic(request);
String template = Parameters.LOGIN_JSP_TEMPLATE;
if (StringUtil.isEmpty(template) || "toApiaTemplate".equals(request.getParameter("forceDefaultTemplate"))) template = "/page/login/classic/defaultTemplate.jsp";

String ua = request.getHeader("User-Agent").toLowerCase();
String force = request.getParameter("force");	
String usrLogin = request.getParameter("usrLgIn");
if ("mobile".equals(force) || !"full".equals(force) && ua.matches("(?i).*((android|bb\\d+|meego).+mobile|avantgo|bada\\/|blackberry|blazer|compal|elaine|fennec|hiptop|iemobile|ip(hone|od)|iris|kindle|lge |maemo|midp|mmp|mobile.+firefox|netfront|opera m(ob|in)i|palm( os)?|phone|p(ixi|re)\\/|plucker|pocket|psp|series(4|6)0|symbian|treo|up\\.(browser|link)|vodafone|wap|windows ce|xda|xiino).*")||ua.substring(0,4).matches("(?i)1207|6310|6590|3gso|4thp|50[1-6]i|770s|802s|a wa|abac|ac(er|oo|s\\-)|ai(ko|rn)|al(av|ca|co)|amoi|an(ex|ny|yw)|aptu|ar(ch|go)|as(te|us)|attw|au(di|\\-m|r |s )|avan|be(ck|ll|nq)|bi(lb|rd)|bl(ac|az)|br(e|v)w|bumb|bw\\-(n|u)|c55\\/|capi|ccwa|cdm\\-|cell|chtm|cldc|cmd\\-|co(mp|nd)|craw|da(it|ll|ng)|dbte|dc\\-s|devi|dica|dmob|do(c|p)o|ds(12|\\-d)|el(49|ai)|em(l2|ul)|er(ic|k0)|esl8|ez([4-7]0|os|wa|ze)|fetc|fly(\\-|_)|g1 u|g560|gene|gf\\-5|g\\-mo|go(\\.w|od)|gr(ad|un)|haie|hcit|hd\\-(m|p|t)|hei\\-|hi(pt|ta)|hp( i|ip)|hs\\-c|ht(c(\\-| |_|a|g|p|s|t)|tp)|hu(aw|tc)|i\\-(20|go|ma)|i230|iac( |\\-|\\/)|ibro|idea|ig01|ikom|im1k|inno|ipaq|iris|ja(t|v)a|jbro|jemu|jigs|kddi|keji|kgt( |\\/)|klon|kpt |kwc\\-|kyo(c|k)|le(no|xi)|lg( g|\\/(k|l|u)|50|54|\\-[a-w])|libw|lynx|m1\\-w|m3ga|m50\\/|ma(te|ui|xo)|mc(01|21|ca)|m\\-cr|me(rc|ri)|mi(o8|oa|ts)|mmef|mo(01|02|bi|de|do|t(\\-| |o|v)|zz)|mt(50|p1|v )|mwbp|mywa|n10[0-2]|n20[2-3]|n30(0|2)|n50(0|2|5)|n7(0(0|1)|10)|ne((c|m)\\-|on|tf|wf|wg|wt)|nok(6|i)|nzph|o2im|op(ti|wv)|oran|owg1|p800|pan(a|d|t)|pdxg|pg(13|\\-([1-8]|c))|phil|pire|pl(ay|uc)|pn\\-2|po(ck|rt|se)|prox|psio|pt\\-g|qa\\-a|qc(07|12|21|32|60|\\-[2-7]|i\\-)|qtek|r380|r600|raks|rim9|ro(ve|zo)|s55\\/|sa(ge|ma|mm|ms|ny|va)|sc(01|h\\-|oo|p\\-)|sdk\\/|se(c(\\-|0|1)|47|mc|nd|ri)|sgh\\-|shar|sie(\\-|m)|sk\\-0|sl(45|id)|sm(al|ar|b3|it|t5)|so(ft|ny)|sp(01|h\\-|v\\-|v )|sy(01|mb)|t2(18|50)|t6(00|10|18)|ta(gt|lk)|tcl\\-|tdg\\-|tel(i|m)|tim\\-|t\\-mo|to(pl|sh)|ts(70|m\\-|m3|m5)|tx\\-9|up(\\.b|g1|si)|utst|v400|v750|veri|vi(rg|te)|vk(40|5[0-3]|\\-v)|vm40|voda|vulc|vx(52|53|60|61|70|80|81|83|85|98)|w3c(\\-| )|webc|whit|wi(g |nc|nw)|wmlb|wonu|x700|yas\\-|your|zeto|zte\\-")) {
	session.setAttribute("mobile", "true");		
} else {
	session.removeAttribute("mobile");
}

%><region:render template='<%=template%>'><region:put section='linkCss'><system:util show="baseLoginStyles" /><%if("true".equals(session.getAttribute("mobile")) ) {%><meta name="viewport" content="width=device-width, initial-scale=1, maximum-scale=1"><%}%></region:put><region:put section='scriptJs'><script type="text/javascript" src="<system:util show="context" />/js/modernizr.custom.js"></script><script type="text/javascript" src="<system:util show="context" />/js/mootools-core-1.4.5-full-compat.js"></script><script type="text/javascript" src="<system:util show="context" />/js/mootools-more-1.4.0.1-compat.js"></script><script type="text/javascript" src="<system:util show="context" />/js/generics.js"></script><%com.dogma.UserData uDataAux = biz.statum.apia.web.bean.BasicBeanStatic.getUserDataStatic(request);%><script type="text/javascript" src="<system:util show="context" />/js/formcheck/lang/<%=uDataAux.getLangCode()%>.js"></script><script type="text/javascript" src="<system:util show="context" />/js/formcheck/formcheck.js"></script><script type="text/javascript" src="<system:util show="context" />/page/externalAccess/resetPwd.js"></script><script type="text/javascript" src="<system:util show="context" />/page/includes/campaigns.js"></script><script type="text/javascript" src="<system:util show="context" />/js/aes/aes.js"></script><%if("true".equals(session.getAttribute("mobile"))) {%><script type="text/javascript" src="<system:util show="context" />/js/modal.js"></script><% } %></region:put><region:put section='javascriptVariables'>
		var CONTEXT					= "<system:util show="context" />";
		var LOGIN_OK				= "<system:edit show="constant" from="biz.statum.apia.web.bean.security.LoginBean" field="LOGIN_OK"/>";
		var LOGIN_ERROR				= "<system:edit show="constant" from="biz.statum.apia.web.bean.security.LoginBean" field="LOGIN_ERROR"/>";
		var LOGIN_ERROR_CAPTCHA		= "<system:edit show="constant" from="biz.statum.apia.web.bean.security.LoginBean" field="LOGIN_ERROR_CAPTCHA"/>";
		var CAPS_TITLE				= "<system:label show="text" label="msgBloqMay" forScript="true" />";  
		var WAIT_A_SECOND			= '<system:label show="text" label="lblEspUnMom" forScript="true" />';
		var DO_LOGIN				= '<system:label show="text" label="btnLog" forScript="true" />';
		var USER_LANGUAGE_SELECION	= '<%=uData.getLangId() %>';
		var USER_EXISTS 			= toBoolean('<%= session.getAttribute("usrExists") %>');
		var TOKEN_EXPIRED 			= toBoolean('<%= session.getAttribute("tknExpired") %>');
		var TOKEN_INVALID			= toBoolean('<%= session.getAttribute("invalidTkn") %>');
		
		<!-- external access section -->
		var IS_EXTERNAL = "<system:edit show="value" from="theRequest" field="external" />";
		var LANG_ID = "<system:edit show="value" from="theRequest" field="hidLangId" />";
		var ENV_ID = "<system:edit show="value" from="theRequest" field="envId" />"  != "" ? "<system:edit show="value" from="theRequest" field="envId" />" : "<system:edit show="value" from="theRequest" field="cmbEnv" />";
		
		var TAB_ID = "<%=System.currentTimeMillis() %>";
		var TOKEN_ID = TAB_ID;
		
		var isAuthenticated = <%=isAuthenticated %>;
		
		var LBL_CAPTCHA = "<system:label show="text" label="lblVerifCode" forHtml="true"/>";
		var MSG_PSSWD_EXPIRED = "<system:label show="text" label="msgPsswdTknExp" forHtml="true"/>";
		var MSG_INVALID_TKN_URL = "<system:label show="text" label="msgPsswdTknUrlInv" forHtml="true"/>";
		
		var MOBILE = <%= "true".equals(session.getAttribute("mobile")) ? "true" : "false" %>;
		var BTN_CLOSE = '<system:label show="text" label="btnCer" forHtml="true" forScript="true"/>';
		
		if (MOBILE){ $(window.document.html).addClass("mobile-mode"); }
		
		var iv 				= '<%=biz.statum.apia.utils.AES.IV%>';
		var salt 			= '<%=biz.statum.apia.utils.AES.SALT%>';
		var keySize 		= 128;
		var iterationCount	= 100;
		var passPhrase		= '<%=uData.getPassPhrase() %>';
		
	</region:put><region:put section="htmlLanguages"><div class="languages <%="true".equals(session.getAttribute(LoginBean.SESSION_ATT_USE_CAPTCHA)) ? "captchaActive" : ""%>"><system:util show="prepareLanguagesByLabelId" saveOn="languagesInLabelSet"/><system:util show="prepareUserLanguage" saveOn="usrLanguage"/><system:edit show="iteration" from="languagesInLabelSet" saveOn="language"><system:edit show="ifValue" from="language" field="langId" value="with:usrLanguage"><span class="language currentLanguage lang_<system:edit show="value" from="language" field="langName" />"><a href="#"><system:edit show="value" from="language" field="langTitle" /></a></span></system:edit><system:edit show="ifNotValue" from="language" field="langId" value="with:usrLanguage"><span class="language lang_<system:edit show="value" from="language" field="langName" />"><a href="<system:util show="context" />/apia.security.LoginAction.run?action=languagePsswdChng&langId=<system:edit show="value" from="language" field="langId" />" ><system:edit show="value" from="language" field="langTitle" /></a></span></system:edit></system:edit></div></region:put><region:put section="htmlLogo"><div class="divImage"><div class="logoB"></div><div class="logoA"></div></div></region:put><region:put section="htmlForm"><form id="passwordForm" action="" method="get"><div class="loginContainer"><div class="section sec1"><div class="field" style="display:none"><input type="text" id="hidUsrTkn" value="<%= session.getAttribute("usrToken") %>"/></div><div class="field required"><label title="<system:label show="tooltip" label="lblUsu" />" for="currentUser"><system:label show="text" label="lblUsu" />:</label><input type="text" id="currentUser" name="currentUser" class="validate['required']"/></div><div class="field required"><label title="<system:label show="tooltip" label="lblPwdNew" />" for="newPassword"><system:label show="text" label="lblPwdNew" />:</label><input type="password" id="newPassword" name="newPassword" class="validate['required']" title="<system:label show="text" label="lblPwdNew" />"/></div><div class="field required"><label title="<system:label show="tooltip" label="lblConPwd" />" for="newPasswordConf"><system:label show="text" label="lblConPwd" />:</label><input type="password" id="newPasswordConf" name="newPasswordConf" class="validate['required','confirm:newPassword']"></div></div><div class="section sec2"><div class="content"><div class="loginPanelButton" id="changePwd" title="<system:label show="tooltip" label="btnCon" />"><system:label show="text" label="btnCon" /></div></div></div></div></form></region:put><region:put section="htmlCampaign">&nbsp;<system:campaign inLogin="true" inSplash="false" /></region:put><region:put section="htmlMessages"><div class="message hidden" id="messageContainer"></div><system:util show="ifInvalidVersion" ><div class="message fatalError"><b>ERROR IN DATABASE VERSION (<system:util show="versionDb" />) <br>AND CODE VERSION (<system:util show="versionApia" />)</b><br>
				Please contact the administrator
			</div></system:util></region:put><region:put section="htmlFooter"><%@include file="/page/includes/footer.jsp" %></region:put></region:render>