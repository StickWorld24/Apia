<%@page import="biz.statum.apia.web.bean.BeanUtils"%>

<%@page import="biz.statum.apia.web.bean.BasicBeanStatic"%>
<%@page import="java.util.Enumeration"%>

<%@page import="com.dogma.controller.ThreadData"%>
<%@page import="biz.statum.apia.web.action.portal.PortalAction"%>
<%@page import="biz.statum.apia.web.bean.portal.PortalBean"%>
<%@page import="biz.statum.sdk.util.HttpServletRequestResponse"%>
<%@include file="../../includes/startInc.jsp" %>

<%	
	request.getSession(true); //si no hay sesion, crearla.
	HttpServletRequestResponse http = new HttpServletRequestResponse(request, response);
	
	String ua = request.getHeader("User-Agent").toLowerCase();
	String force = request.getParameter("force");	
	if ("mobile".equals(force) || !"full".equals(force) && ua.matches("(?i).*((android|bb\\d+|meego).+mobile|avantgo|bada\\/|blackberry|blazer|compal|elaine|fennec|hiptop|iemobile|ip(hone|od)|iris|kindle|lge |maemo|midp|mmp|mobile.+firefox|netfront|opera m(ob|in)i|palm( os)?|phone|p(ixi|re)\\/|plucker|pocket|psp|series(4|6)0|symbian|treo|up\\.(browser|link)|vodafone|wap|windows ce|xda|xiino).*")||ua.substring(0,4).matches("(?i)1207|6310|6590|3gso|4thp|50[1-6]i|770s|802s|a wa|abac|ac(er|oo|s\\-)|ai(ko|rn)|al(av|ca|co)|amoi|an(ex|ny|yw)|aptu|ar(ch|go)|as(te|us)|attw|au(di|\\-m|r |s )|avan|be(ck|ll|nq)|bi(lb|rd)|bl(ac|az)|br(e|v)w|bumb|bw\\-(n|u)|c55\\/|capi|ccwa|cdm\\-|cell|chtm|cldc|cmd\\-|co(mp|nd)|craw|da(it|ll|ng)|dbte|dc\\-s|devi|dica|dmob|do(c|p)o|ds(12|\\-d)|el(49|ai)|em(l2|ul)|er(ic|k0)|esl8|ez([4-7]0|os|wa|ze)|fetc|fly(\\-|_)|g1 u|g560|gene|gf\\-5|g\\-mo|go(\\.w|od)|gr(ad|un)|haie|hcit|hd\\-(m|p|t)|hei\\-|hi(pt|ta)|hp( i|ip)|hs\\-c|ht(c(\\-| |_|a|g|p|s|t)|tp)|hu(aw|tc)|i\\-(20|go|ma)|i230|iac( |\\-|\\/)|ibro|idea|ig01|ikom|im1k|inno|ipaq|iris|ja(t|v)a|jbro|jemu|jigs|kddi|keji|kgt( |\\/)|klon|kpt |kwc\\-|kyo(c|k)|le(no|xi)|lg( g|\\/(k|l|u)|50|54|\\-[a-w])|libw|lynx|m1\\-w|m3ga|m50\\/|ma(te|ui|xo)|mc(01|21|ca)|m\\-cr|me(rc|ri)|mi(o8|oa|ts)|mmef|mo(01|02|bi|de|do|t(\\-| |o|v)|zz)|mt(50|p1|v )|mwbp|mywa|n10[0-2]|n20[2-3]|n30(0|2)|n50(0|2|5)|n7(0(0|1)|10)|ne((c|m)\\-|on|tf|wf|wg|wt)|nok(6|i)|nzph|o2im|op(ti|wv)|oran|owg1|p800|pan(a|d|t)|pdxg|pg(13|\\-([1-8]|c))|phil|pire|pl(ay|uc)|pn\\-2|po(ck|rt|se)|prox|psio|pt\\-g|qa\\-a|qc(07|12|21|32|60|\\-[2-7]|i\\-)|qtek|r380|r600|raks|rim9|ro(ve|zo)|s55\\/|sa(ge|ma|mm|ms|ny|va)|sc(01|h\\-|oo|p\\-)|sdk\\/|se(c(\\-|0|1)|47|mc|nd|ri)|sgh\\-|shar|sie(\\-|m)|sk\\-0|sl(45|id)|sm(al|ar|b3|it|t5)|so(ft|ny)|sp(01|h\\-|v\\-|v )|sy(01|mb)|t2(18|50)|t6(00|10|18)|ta(gt|lk)|tcl\\-|tdg\\-|tel(i|m)|tim\\-|t\\-mo|to(pl|sh)|ts(70|m\\-|m3|m5)|tx\\-9|up(\\.b|g1|si)|utst|v400|v750|veri|vi(rg|te)|vk(40|5[0-3]|\\-v)|vm40|voda|vulc|vx(52|53|60|61|70|80|81|83|85|98)|w3c(\\-| )|webc|whit|wi(g |nc|nw)|wmlb|wonu|x700|yas\\-|your|zeto|zte\\-")) {
		session.setAttribute("mobile", "true");		
	} else {
		session.removeAttribute("mobile");
	}

	PortalBean bean = PortalAction.staticRetrieveBean(http);
%>

<html lang="<%=biz.statum.apia.web.bean.BasicBeanStatic.getUserDataStatic(request).getLangCode()%>">
<head>
	<meta http-equiv="Content-Type" content="text/html; charset=<%=com.dogma.Parameters.APP_ENCODING%>">
	<meta http-equiv="X-UA-Compatible" content="IE=edge">
	<meta name="theme-color" content="#2A467A">
	<%if(bean.getPageDescription()!=null){ %>
		<meta name="Description" content="<%=BeanUtils.fmtHTML(bean.getPageDescription())%>">
	<%} %>
	
	<%
	
	String pageTitle = Parameters.DISPLAY_TITLE;
	if(bean.getPageTitle()!=null){ 
		pageTitle =bean.getPageTitle(); 
	}%>
	
	<title><%=pageTitle%></title>
	<%if("true".equals(session.getAttribute("mobile")) ) {%>
		<meta name="viewport" content="width=device-width, initial-scale=1, maximum-scale=1">
	<%}%>
	
	<link rel="shortcut icon" href="<system:util show="context" />/css/<system:util show="defaultStyle" />/favicon.ico">
	
	<system:util show="basePortalStyles" />	
    <link href="<system:util show="context" />/js/xbbcode/xbbcode.css" rel="stylesheet" type="text/css">
    
	<script type="text/javascript" src="<system:util show="context" />/js/modernizr.custom.js"></script>
	<script type="text/javascript" src="<system:util show="context" />/js/aes/aes.js"></script>
	
	<script type="text/javascript" src="<system:util show="context" />/js/mootools-core-1.4.5-full-compat.js"></script>
	<script type="text/javascript" src="<system:util show="context" />/js/mootools-more-1.4.0.1-compat.js"></script>
	
	<script type="text/javascript" src="<system:util show="context" />/js/modal.js"></script>
	<script type="text/javascript" src="<system:util show="context" />/js/generics.js"> </script>
	
	<script type="text/javascript" src="<system:util show="context" />/js/xbbcode/xbbcode.js"> </script>
	<script type="text/javascript" src="<system:util show="context" />/js/Zoomer.js"></script>

	<script type="text/javascript" src="<system:util show="context" />/js/formcheck/lang/es.js"> </script>
	<script type="text/javascript" src="<system:util show="context" />/js/formcheck/formcheck.js"> </script>
	
	<script type="text/javascript" src="<system:util show="context" />/page/includes/campaigns.js"></script>
	<script type="text/javascript" src="<system:util show="context" />/page/login/portal/portal.js"></script>	
	
	<script type="text/javascript" src="<system:util show="context" />/js/modalController.js"> </script> 
	<script type="text/javascript" src="<system:util show="context" />/js/scroller.js"></script>
	
	<%com.dogma.UserData uDataAux = biz.statum.apia.web.bean.BasicBeanStatic.getUserDataStatic(request);%>
	<script type="text/javascript" src="<system:util show="context" />/js/formcheck/lang/<%=uDataAux.getLangCode()%>.js"> </script>
	
	
	
	<base target="_blank">
	
	<script type="text/javascript">
	
		<%
		String escapedTabId = com.st.util.StringUtil.escapeStr(com.st.util.StringUtil.escapeHTML(request.getParameter("tabId")));
		String escapedTokenId = com.st.util.StringUtil.escapeStr(com.st.util.StringUtil.escapeHTML(request.getParameter("tokenId")));
		try{
			Long.valueOf(request.getParameter("tabId"));
		} catch(NumberFormatException e){
			escapedTabId="";
		}
		
		try{
			Long.valueOf(request.getParameter("tokenId"));
		} catch(NumberFormatException e){
			escapedTokenId="";
		}
		%>
	
		var	sp;
		var TAB_CONTAINER;
		var CONTEXT					= "<system:util show='context' />";
		var STYLE					= "<system:util show='defaultStyle' />";
		var TAB_ID					= "<%=escapedTabId %>";
		var TAB_ID_REQUEST			= "&tabId=<%=escapedTabId%>&tokenId=<%=escapedTokenId%>";
		var WAIT_A_SECOND			= '<system:label show="text" label="lblEspUnMom" forScript="true" />';
		var GNR_TIT_WARNING 		= '<system:label show="text" label="titMsgWarning" forScript="true" />';
		var GNR_CHK_ONLY_ONE 		= '<system:label show="text" label="msgDebSelSolUno" forScript="true" />';
		var GNR_CHK_AT_LEAST_ONE 	= '<system:label show="text" label="msgDebSelUno" forScript="true" />';
		var GNR_MORE_RECORDS		= '<system:label show="text" label="lblNoRet" forScript="true" />';
		var GNR_TOT_RECORDS			= '<system:label show="text" label="lblTotReg" forScript="true" />';
		var GNR_TITILE_EXCEPTIONS	= '<system:label show="text" label="titSplashExceptions" forHtml="true" forScript="true" />';
		var GNR_TITILE_MESSAGES		= "<system:label show="text" label="lblMen" forHtml="true" forScript="true"/>"; 
		var BTN_CONFIRM				= '<system:label show="text" label="btnCon" forHtml="true" forScript="true"/>';
		var BTN_CANCEL				= '<system:label show="text" label="btnCan" forHtml="true" forScript="true"/>';
		var BTN_CLOSE				= '<system:label show="text" label="btnCer" forHtml="true" forScript="true"/>';
		var MSIE 					= window.navigator.appVersion.indexOf("MSIE")>=0;
		var MSG_LOADING				= '<system:label show="text" label="msgLoading" forHtml="true" forScript="true" />';
		var IS_EXTERNAL				= '<%=com.st.util.StringUtil.escapeHTML(request.getParameter("external"))%>';
		var MSG_INVALID_REG_EXP		= '<system:label show="text" label="msgExpRegFal" forHtml="true" forScript="true"/>';
		var ERR_UNEXPECTED			= '<system:label show="text" label="errUnexpected" forHtml="true" forScript="true"/>';
		var ERR_NOTHING_TO_LOAD		= '<system:label show="text" label="errNothingToLoad" forHtml="true" forScript="true"/>';
		var ERR_OPEN_URL			= '<system:label show="text" label="errOpenUrl" forHtml="true" forScript="true"/>';
		
		var CURRENT_PORTAL_TOKEN_ID = "<%=escapedTokenId%>";
		
		
		var MOBILE = <%= "true".equals(session.getAttribute("mobile")) ? "true" : "false" %>;
		
		window.addEvent('resize', function() {
			resizeImages();
		});
		
		window.addEvent('load', function() {

			if (MOBILE){ $(window.document.html).addClass("mobile-mode"); }
			
			window.addEvent('keyup', Generic.showSearch);
			window.addEvent('keydown', Generic.preventBackNavigation);
			
			initPage();
			
			<%= bean.writeJS(http, true) %>
			
			resizeImages();
		});
		
		var URL_PORTAL_PANEL_REFRESH	= CONTEXT + "/apia.portal.PortalAction.run?action=panelRefresh" + TAB_ID_REQUEST;
		var URL_PORTAL_PANEL_ACTION		= CONTEXT + "/apia.portal.PortalAction.run?action=panelAction" + TAB_ID_REQUEST;
		var URL_PORTAL_PANEL_RSS		= CONTEXT + "/apia.portal.PortalAction.run?action=panelRss" + TAB_ID_REQUEST;

		<%= bean.writeJS(http, false) %>
	</script>
	
	<style type="text/css">
		<%= bean.writeCSS(http) %>
	</style>
</head>

<body id="body">
	<div class="body splash splashLayout" id="bodyController">
		<%= bean.drawHTML(http) %>		
	</div>	
</body>

</html>	