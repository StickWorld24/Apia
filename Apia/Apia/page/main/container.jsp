<%@page import="com.st.util.labels.LabelManager"%><%@page import="com.dogma.busClass.object.Parameter"%><%@page import="com.dogma.vo.LanguageVo"%><%@page import="com.dogma.UserData"%><%@page import="com.dogma.bean.ComunicatorBean"%><%@page import="com.st.util.StringUtil"%><%@page import="biz.statum.sdk.util.HttpServletRequestResponse"%><%@page import="biz.statum.apia.web.tag.TagUtils"%><%@page import="chat.commands.conversation.NewMessage"%><%@page import="com.dogma.bean.ComunicatorBean"%><%@include file="../includes/startInc.jsp" %><html lang="<%=biz.statum.apia.web.bean.BasicBeanStatic.getUserDataStatic(request).getLangCode()%>"><head><%@include file="../includes/headInclude.jsp" %><link href="<system:util show="context" />/css/base/pages/splash/main.css" rel="stylesheet" type="text/css" /><link href="<system:util show="context" />/css/base/pages/container/main.css" rel="stylesheet" type="text/css" /><script type="text/javascript" src="<system:util show="context" />/scripts/tinymce/jscripts/tinymce_4.1.5/tinymce.min.js"></script><script type="text/javascript">
		var SEPARATOR 						= "-";
		var IS_CONTAINER					= true;
		var USR_LOGIN = '<system:util show="currentLogin" />';
		var IS_SSO_LOGIN = toBoolean('<system:util show="isSSOLogin" />');
		var LABEL_SEARCH_FUNCTIONALITY		= '<system:label show="text" label="lblSplashSearchFnc" forHtml="true" forScript="true" />';
		var LABEL_SEARCH_FUNCTIONALITY_INFO	= '<system:label show="tooltip" label="lblSplashSearchFnc" forHtml="true" forScript="true" />';
		var LABEL_CONFIRM_EXIT				= '<system:label show="text" label="msgDesSalApl" forHtml="true" forScript="true" />';
		var LABEL_CONFIRM_CHANGE_ENV		= '<system:label show="text" label="msgConChangeEnv" forHtml="true" forScript="true" />';
		
		var BTN_CONFIRM						= '<system:label show="text" label="btnCon" forHtml="true" forScript="true"/>';
		var BTN_CANCEL						= '<system:label show="text" label="btnCan" forHtml="true" forScript="true"/>';
		var BTN_CLOSE						= '<system:label show="text" label="btnClose" forHtml="true" forScript="true"/>';
		
		var LABEL_OPEN_TREE					= '<system:label show="text" label="lblSplashShowMenu" forScript="true" />';
		var TIT_FORCE_CLOSE					= '<system:label show="text" label="titForceClose" forScript="true" />';
		var MSG_FORCE_CLOSE					= '<system:label show="text" label="msgForceClose" forScript="true" />';
		var MSG_SRV_CONNECTION_LOST			= '<system:label show="text" label="msgSrvConnectionLost" forScript="true" />';
		
		var TAB_ID_REQUEST			= "<system:util show="tabIdRequest" />";
		var IMG_AJAX_WAIT			= "<system:util show="context" />/css/<system:util show="currentStyle" />/img/menu/wait.gif";
		var IMG_EMPTY_IMAGE			= "<system:util show="context" />/css/<system:util show="currentStyle" />/img/menu/empty.gif";
		var TREE_VIEW_IMAGE_NEUTRAL	= "<system:util show="context" />/css/<system:util show="currentStyle" />/img/menu/tree/neutral.gif";
		
		var GNR_TITILE_EXCEPTIONS = '<system:label show="text" label="titSplashExceptions" forScript="true" />';
		
		var DEFAULT_MOBILE_DASHBOARD_ID = "<system:util show="defaultDshMobileId" />";
		
		var LBL_INVALID_LOGIN =  '<system:label show="text" label="msgLogFailed" forScript="true" />';

		var AUTHENTICATION_LDAP="<%=Parameters.AUTHENTICATION_LDAP%>";

		var AUTHENTICATION_METHOD="<%=Parameters.AUTHENTICATION_METHOD%>";

		//Chat
		<%
		UserData userData = TagUtils.getUserData(new HttpServletRequestResponse(request, response));
		Integer environmentId = userData.getEnvironmentId(); %>
		var DATE_FORMAT	= "<%=StringUtil.escapeScriptStr(EnvParameters.getEnvParameter(environmentId,EnvParameters.FMT_DATE))%>";
		var TIME_FORMAT	= "<%=StringUtil.escapeScriptStr(EnvParameters.getEnvParameter(environmentId,EnvParameters.FMT_TIME))%>";
		var CHAT_ENVIRONMENT_ENABLED = <%= Parameters.APIACHAT_MODE_CLIENT && com.dogma.EnvParameters.getEnvParameterBoolean(environmentId,com.dogma.EnvParameters.CHAT_ENABLE) && userData.hasChatEnabled() %>;
		var CHAT_SHOW_PANEL_REQS = <%= EnvParameters.getEnvParameterBoolean(environmentId,EnvParameters.CHAT_SHOW_PANEL_REQS) %>;
		var CHAT_SHOW_PANEL_GROUPS = <%= EnvParameters.getEnvParameterBoolean(environmentId,EnvParameters.CHAT_SHOW_PANEL_GROUPS) %>;
		var CHAT_SHOW_PANEL_USERS = <%= EnvParameters.getEnvParameterBoolean(environmentId,EnvParameters.CHAT_SHOW_PANEL_USERS) %>;

		var MSG_TYPE_NA 					= '<%= NewMessage.TYPE_NA %>';
		var MSG_TYPE_NEW_USER				= '<%= NewMessage.TYPE_NEW_USER %>';
		var MSG_TYPE_EXIT_USER				= '<%= NewMessage.TYPE_EXIT_USER %>';
		var MSG_TYPE_WARN_INACTIVITY		= '<%= NewMessage.TYPE_WARN_INACTIVITY %>';
		
		var MSG_TYPE_NEW_FILE_TRANFER		= '<%= NewMessage.TYPE_NEW_FILE_TRANFER %>';
		var MSG_TYPE_ACCEPT_FILE_TRANFER	= '<%= NewMessage.TYPE_ACCEPT_FILE_TRANFER %>';
		var MSG_TYPE_CANCEL_FILE_TRANFER	= '<%= NewMessage.TYPE_CANCEL_FILE_TRANFER %>';
		var MSG_TYPE_COMPLET_FILE_TRANFER	= '<%= NewMessage.TYPE_COMPLET_FILE_TRANFER %>';
		var MSG_TYPE_SENDING_FILE_TRANFER	= '<%= NewMessage.TYPE_SENDING_FILE_TRANFER %>';
		var MSG_TYPE_ERROR_FILE_TRANFER		= '<%= NewMessage.TYPE_ERROR_FILE_TRANFER %>';
		var MSG_TYPE_COMMAND				= '<%= NewMessage.TYPE_COMMAND %>';
		var MSG_TYPE_ACCEPT_COMMAND			= '<%= NewMessage.TYPE_ACCEPT_COMMAND%>';
		var MSG_TYPE_CANCEL_COMMAND			= '<%= NewMessage.TYPE_CANCEL_COMMAND%>';
		
		var MSG_TYPE_NEW_CONVERSATION_STARTED		= '<%= NewMessage.TYPE_NEW_CONVERSATION_STARTED%>';
		
		var TRANSFER_TASK_COMMAND			= '<%= ComunicatorBean.TRANSFER_TASK_COMMAND%>';
		var LOG_COMMAND						= '<%= ComunicatorBean.LOG_COMMAND%>';
		var START_PROCESS_COMMAND			= '<%= ComunicatorBean.START_PROCESS_COMMAND%>';
		var SHOW_QUERY_COMMAND				= '<%= ComunicatorBean.SHOW_QUERY_COMMAND%>';
		var BUZZ_COMMAND					= '<%= ComunicatorBean.BUZZ_COMMAND%>';
		
		var TIT_WARNING = '<system:label show="text" label="titWarning" forScript="true" />';
		var BTN_NEW_TAB = '<system:label show="text" label="btnNewTab" forScript="true" />';
		var BTN_CURRENT_TAB = '<system:label show="text" label="btnCurrentTab" forScript="true" />';
		var MSG_TAB_IS_OPEN = '<system:label show="text" label="msgTabIsOpen" forScript="true" />';

		var MAX_AMOUNT_TABS				= <%= EnvParameters.getEnvParameterInteger(environmentId, EnvParameters.ENV_MAX_QUAN_OPEN_TABS) %>;
		var LBL_NEW_TABS_OPEN			= '<system:label show="text" label="lblNewTabsOpen" forScript="true" />'; //Abrir
		var LBL_NEW_TABS_OBSERVATION	= '<system:label show="text" label="msgNewTabsObservation" forScript="true" />'; //tabs, puede generar problemas de performance en su navegador.
		var LBL_NEW_TABS_ONE_TAB		= '<system:label show="text" label="msgNewTabsOneTab" forScript="true" />'; //Abrir un nuevo tab, puede generar problemas de performance en su navegador.
		var LBL_ONLY_ONE_CUBE_OPEN		= '<system:label show="text" label="msgOnlyOneCubeOpen" forScript="true" />'; //Solo se puede abrir un cubo por vez
		
		var LBL_MINIMIZE_WIN			= '<system:label show="text" label="lblMinimizeWindow" forScript="true" />';
		var LBL_CLOSE_WIN				= '<system:label show="text" label="lblCloseWindow" forScript="true" />';
		
		var sbtAboutApia				= '<system:label show="text" label="sbtAboutApia" forScript="true" />';
		
		var CHAT_LBL_BY				= '<system:label show="text" label="lblFrom" forHtml="true" forScript="true"/>';
		
		var CHAT_TIT_LOGIN 			= '<system:label show="text" label="lblLoginChat" forHtml="true" forScript="true"/>';
		var CHAT_PNL_USERS 			= '<system:label show="text" label="lblChatUsers" forHtml="true" forScript="true"/>';
		var CHAT_PNL_GROUPS 		= '<system:label show="text" label="lblPool" forHtml="true" forScript="true"/>';
		var CHAT_PNL_REQUESTS 		= '<system:label show="text" label="lblChatRequests" forHtml="true" forScript="true"/>';
		var CHAT_LBL_CONVERSATION 	= '<system:label show="text" label="lblConversation" forHtml="true" forScript="true"/>';
		var CHAT_LBL_REQ_CON 		= '<system:label show="text" label="lblReqChat" forHtml="true" forScript="true"/>';
		var CHAT_LBL_REQ_CON_WITH 	= '<system:label show="text" label="lblReqChatAbout" forHtml="true" forScript="true"/>:';
		var CHAT_TIT_REQUEST 		= '<system:label show="text" label="lblChatRequest" forHtml="true" forScript="true"/>';
		var CHAT_TIT_DO_LOGIN 		= '<system:label show="text" label="btnLog" forHtml="true" forScript="true"/>';
		var CHAT_TIT_NEW_CON 		= '<system:label show="text" label="lblNewChat" forHtml="true" forScript="true"/>';
		var CHAT_PNL_PART 			= '<system:label show="text" label="lblMonChatFilPart" forHtml="true" forScript="true"/>';
		var CHAT_PNL_MSGS 			= '<system:label show="text" label="lblMen" forHtml="true" forScript="true"/>';
		
		var CHAT_TIME_INACT_MSG		= '<%
				if(Parameters.APIACHAT_INACTIVITY_TIME != null && Parameters.APIACHAT_INACTIVITY_WARN_TIME != null) {
					if(Parameters.APIACHAT_INACTIVITY_TIME > Parameters.APIACHAT_INACTIVITY_WARN_TIME) {
						int secs = Parameters.APIACHAT_INACTIVITY_TIME - Parameters.APIACHAT_INACTIVITY_WARN_TIME;
						if(secs < 60) {
							out.write(StringUtil.parseMessage(LabelManager.getName(userData, "lblChatWarnInactivitySecs"), "" + secs));
						} else {
							int mins = (secs / 60);
							out.write(StringUtil.parseMessage(LabelManager.getName(userData, "lblChatWarnInactivityMins"), "" + mins));
						}
					} else {
						out.write("");
					}
				} else {	
					out.write("");
				}
			%>';
		
		var CHAT_ERR_NOT_CONNECTED	= '<system:label show="text" label="lblChatErrNotConnected" forHtml="true" forScript="true"/>';
		var CHAT_RECONNECTED	= '<system:label show="text" label="lblChatReConnected" forHtml="true" forScript="true"/>';
		var CHAT_BTN_SEND_FILE		= '<system:label show="text" label="lblChatBtnSendFile" forHtml="true" forScript="true"/>';
		var CHAT_LBL_WAIT_ACEPT		= '<system:label show="text" label="lblChatWaitAccept" forHtml="true" forScript="true"/>';
		var CHAT_LBL_IS_SENDING		= '<system:label show="text" label="lblChatIsSending" forHtml="true" forScript="true"/>';
		var CHAT_LBL_YOU			= '<system:label show="text" label="lblChatYou" forHtml="true" forScript="true"/>';
		var CHAT_LBL_ACEPT_TRANS	= '<system:label show="text" label="lblChatAceptTrans" forHtml="true" forScript="true"/>';
		var CHAT_LBL_CANEL_TRANS	= '<system:label show="text" label="lblChatCancelTrans" forHtml="true" forScript="true"/>';
		var CHAT_LBL_ENDED_TRANS	= '<system:label show="text" label="lblChatEndTrans" forHtml="true" forScript="true"/>';
		var CHAT_LBL_DOWN_TRANS		= '<system:label show="text" label="lblChatDownTrans" forHtml="true" forScript="true"/>';
		var CHAT_ERR_TRANS_1		= '<system:label show="text" label="lblChatErrTrans1" forHtml="true" forScript="true"/>';
		var CHAT_ERR_TRANS_2		= '<system:label show="text" label="lblChatErrTrans2" forHtml="true" forScript="true"/>';
		var CHAT_USR_LEFT			= '<system:label show="text" label="lblChatUsrLeft" forHtml="true" forScript="true"/>';
		var CHAT_BTN_INVITE_USR		= '<system:label show="text" label="btnChatInviteUsr" forHtml="true" forScript="true"/>';
		var CHAT_BTN_TRANSFER		= '<system:label show="text" label="btnChatTransfer" forHtml="true" forScript="true"/>';
		var CHAT_TITLE_TRANSFER		= '<system:label show="text" label="lblTransConversation" forHtml="true" forScript="true"/>';
		var CHAT_TITLE_HISTORY		= '<system:label show="text" label="btnMonHis" forHtml="true" forScript="true"/>';
		var CHAT_TITLE_COPY_CONTENT	= '<system:label show="text" label="btnCopyContent" forHtml="true" forScript="true"/>';
		var CHAT_USR_ACCEPTED_TASK	= '<system:label show="text" label="msgUsrAccTask" forHtml="true" forScript="true"/>';
		var CHAT_USR_CANCELED_TASK	= '<system:label show="text" label="msgUsuCanTask" forHtml="true" forScript="true"/>';
		var CHAT_USR_ACCEPTED_CMD	= '<system:label show="text" label="lblUsrCmdAcepted" forHtml="true" forScript="true"/>';
		var CHAT_USR_CANCELED_CMD	= '<system:label show="text" label="lblUsrCmdCanceled" forHtml="true" forScript="true"/>';
		
		var LBL_CHAT_TRANS_TASK_1	= '<system:label show="text" label="msgChatWaitTskTrans" forHtml="true" forScript="true"/>';
		var LBL_CHAT_TRANS_TASK_2	= '<system:label show="text" label="msgChatAskTskTrans" forHtml="true" forScript="true"/>';
		var LBL_CHAT_TRANS_TASK_3	= '<system:label show="text" label="msgChatErrTskTrans" forHtml="true" forScript="true"/>';
		
		var LBL_CHAT_BUZZ_1			= '<system:label show="text" label="msgChatBuzzTitle" forHtml="true" forScript="true"/>';
		var LBL_CHAT_BUZZ_2			= '<system:label show="text" label="msgChatBuzzMsg" forHtml="true" forScript="true"/>';
		var LBL_CHAT_BUZZ_3			= '<system:label show="text" label="msgChatBuzzByMe" forHtml="true" forScript="true"/>';
		
		var LBL_CHAT_SUBJECT		= '<system:label show="text" label="lblMonChatResSubject" forHtml="true" forScript="true"/>';
		var LBL_CHAT_USER			= '<system:label show="text" label="lblUsu" forHtml="true" forScript="true"/>';
		var LBL_CHAT_NEW_REQ_FOR	= '<system:label show="text" label="lblNewChatReqFor" forHtml="true" forScript="true"/>';
		
		var PARAMETER_CHAT_CLIENT_DISPLAY_NAME = <%=Parameters.APIACHAT_CLIENT_DISPLAY_NAME%>;
		var PARAMETER_CHAT_CONFIRM_CLOSE = <%=Parameters.APIACHAT_CONFIRM_CHAT_CLOSE ? "true" : "false"%>;
		
		var LBL_CHAT_TIT_CONF_CLOSE		= '<system:label show="text" label="titConfirmChatClose" forHtml="true" forScript="true"/>';
		var LBL_CHAT_MSG_CONF_CLOSE			= '<system:label show="text" label="msgConfirmChatClose" forHtml="true" forScript="true"/>';
		
		var APIACHAT_FREQUENCY_CALLBACK		=  <%=Parameters.APIACHAT_FREQUENCY_CALLBACK%>;
		
		var LANG_ID = '<%=userData.getLangId()%>';
		
		tinymce.init({
			language: 'es',
		    theme: "modern",
		    mode : "exact",
			height : "26",
			width : "218",
			content_css: "scripts/tinymce/jscripts/tinymce_4.1.5/skins/chat.css",
		 	plugins: ["spellchecker"],
		    toolbar: false,
		    menubar: false,
		    statusbar: false,
		    forced_root_block : Browser.safari || Browser.chrome ? 'p' : '',
		    setup: function(ed) {
		    	
		    	var orig_shortcuts_add = ed.shortcuts.add;
		    	ed.shortcuts.add = function(pattern, desc, cmdFunc, scope) {
		            return orig_shortcuts_add(pattern, desc, function () {}, scope);
		        };
		        
		    	ed.on('keydown', function(e) {
		    		var m_evt = new Event(e);
		    		
		    		if(m_evt.key == 'left' || m_evt.key == 'right' || m_evt.key == 'down' || m_evt.key == 'up' || m_evt.key == 'alt' || m_evt.key == 'control' || m_evt.key == 'shift' || m_evt.key == 'capslock')
		    			return;
		    		
		    		targetElm =  $(ed.targetElm);
		    		var time_id = targetElm.get('timeId');
		    		if(time_id)
		    			clearTimeout(time_id);
		    		
		    		if(m_evt.key == 'enter') {
		    			
		    			e.preventDefault();
		    			
		    			if(ed.isDirty())
		    				ed.save();
		    			
		    			targetElm.fireEvent('enterPressed', ed);
		    			
			    		return;
		    		}
		    		
		    		targetElm.set('timeId', setTimeout(function() {
		    			targetElm.set('timeId', '');
		    			
		    			if(ed.spellchecking) {
		    				ed.execCommand('mceSpellCheck', true);
		    				setTimeout(function() {
		    					ed.execCommand('mceSpellCheck', true);
		    				}, 50);
		    			} else {
		    				ed.execCommand('mceSpellCheck', true);
		    			}
		    			
		    			if(Browser.chrome) {
		    				var activeEle = $(document.activeElement);
		    				window['current_range_' + targetElm.get('id')] = {id: activeEle.get('id'), range: activeEle.contentWindow.getSelection().getRangeAt(0)};
		    			}
		    			
		    		}, 1000));
		    		
		    	});
		    	
		    	ed.on('SpellcheckStart', function(e) {
		    		var ed = e.target;
		    		ed.spellchecking = true;
		    		if(Browser.chrome) {
						var current_range = window['current_range_' + $(ed.targetElm).get('id')];
						if(current_range) {
							var sel = $(current_range.id).contentWindow.getSelection();
			    			sel.removeAllRanges();
			    			sel.addRange(current_range.range);
						}
		    		}
		    	});
		    	
		    	ed.on('SpellcheckEnd', function(e) {
		    		var ed = e.target;
		    		ed.spellchecking = false;
		    	});
		    	
		    	ed.on('keypress', function(e) {
		    		//Hay que esperar a que la letra se ponga en el editor
		    		setTimeout(function() {
		    			ed.resize();
		    		}, 1);
		    	});
		    	
		    	ed.resize = function() {
					//Obtener el alto del body
		    		var editor_height = ed.contentDocument.body.offsetHeight;
		
					//Hay que sacarle alto a la parte donde se ven los mensajes
					var targetElm = $(ed.targetElm);
					
					var chatContent = targetElm.getPrevious('div.chatContent');
					
					var old_height = Number.from(chatContent.getStyle('height'));
					var new_height = 300 - Math.min(editor_height - 14 + 3, 69);
					
					if(new_height != old_height) {
						chatContent.setStyle('height', new_height);
						
						//Corregir que se caiga la pagina //MAX_IFRAME_HEIGHT: 82px
		    			targetElm.getPrevious('div.mce-tinymce').getElement('iframe').setStyle('height', Math.min(editor_height + 4, 82));     
					}
		    	}
		    },
		    spellchecker_rpc_url: "<system:util show="context" />/spellchecker/jmyspell-spellchecker",
	    	spellchecker_language: <%
				if(LanguageVo.LANG_EN == uData.getLangId().intValue()) {
					out.write("'en_US'");
				} else if(LanguageVo.LANG_SP == uData.getLangId().intValue()) {
					out.write("'es_UY'");
				} else if(LanguageVo.LANG_PT == uData.getLangId().intValue()) {
					out.write("'pt_BR'");
				} else {
					out.write("'en_US'");
				}
			%>,
		    spellchecker_languages: '<system:label show="text" label="lblIdiIng" forHtml="true" forScript="true" />=en_US,<system:label show="text" label="lblIdiEsp" forHtml="true" forScript="true" />=es_UY,<system:label show="text" label="lblIdiPor" forHtml="true" forScript="true" />=pt_PT'
		});
	</script><script type="text/javascript" src="<system:util show="context" />/js/overlay.js"></script><script type="text/javascript" src="<system:util show="context" />/page/main/message.js"></script><script type="text/javascript" src="<system:util show="context" />/page/main/apia.chat.js"></script><script type="text/javascript" src="<system:util show="context" />/page/main/container.js"></script><script type="text/javascript" src="<system:util show="context" />/page/main/tree.js"></script></head><body class="main-container" onUnload="forceLogout(window);"><div class="message hidden" id="messageContainer"></div><div id="tabLoadingImage" class="tabLoading"></div><div class="tabContainer" id="tabContainer"><div class="tab tabHome" id="tabHome" data-tabId="tab-1">&nbsp;</div><%if(!"true".equals(session.getAttribute("mobile"))) { %><div class="tab tabMenu" id="tabMenu" data-tabId="tab-2">&nbsp;</div><%} else {%><div class="tab tabMobileMenu" id="tabMobileMenu" data-tabId="tab-2">&nbsp;</div><div class="mobileApiaLogo"></div><%} %><div class="divScrollContainer"><div class="tabScrollContainer" id="tabScrollContainer"><div class="tabScrolLeft dontShow" id="tabScrolLeft"></div><div class="tabScrolRight dontShow" id="tabScrolRight"></div><div class="tabMainScrollContainer" id="tabMainScrollContainer"><div class="tabScrollContainerScroll" id="tabScrollContainerScroll"><div class="subTabContainer" id="subTabContainer" style="width: 0px;"></div></div></div></div><%if(!"true".equals(session.getAttribute("mobile"))) { %><div class="tab tabUser" id="tabUser" data-tabId="tab-3" style="background-image: url('<system:util show="context" />/getImageServlet.run?usrLogin=<system:util show="currentLogin" />&height=24&width=24');"><span title="<system:util show="currentLogin" />"><system:util show="currentLoginName" /></span> | <system:util show="currentEnvironment" /> |
			</div><%} %></div></div><div class="tabContentContainer" id="tabContentContainer"><iframe title="tab-1" <%if(uData.isUserAgentIE8()) { %>frameborder="0" <%} %>class="tabContent" id="tab-1" src="<system:util show="context" />/apia.splash.SplashAction.run?<system:util show="tabIdRequest"  />"></iframe><%if(!"true".equals(session.getAttribute("mobile"))) { %><div class="tabMenu" id="tab-2"><div><label for="menuSearchInput" style="display: none;"><system:label show="text" label="lblSplashSearchFnc" /></label><input title="<system:label show="text" label="lblSplashSearchFnc" />" type="text" value="<system:label show="text" label="lblSplashSearchFnc" />" class="searchField searchStart" id="menuSearchInput" autocomplete="off"><div class="right"><img class="dontShow" src="<system:util show="context" />/css/base/img/menu/search.png" alt="Search mode" id="menuModeSearch" style="cursor: pointer;"><img class="dontShow" src="<system:util show="context" />/css/base/img/menu/tree.png" alt="Tree mode" id="menuModeTree" style="cursor: pointer; margin-lef:4px;"></div></div><div id="resultModeSearch" class="resultModeSearch resultModeSearchInfo"><system:label show="text" label="lblFunStartWriting" forHtml="true" forScript="true"/></div><div id="resultModeTree" class="resultModeTree"></div></div><div class="tabUser" id="tab-3"><div class="exit" id="userExit" tabIndex="0"><system:label show="text" label="lblTocCloApp" /></div><div class="configuration" id="splashConfiguration" tabIndex="0"><system:label show="text" label="btnConfiguration" /></div><div class="configuration" id="splashChangeEnv" tabIndex="0"><system:label show="text" label="sbtChangeEnv" /></div><div class="configuration" id="splashAbout" tabIndex="0"><system:label show="text" label="sbtAboutApia" /></div><p></p><div class="chat" id="chatContainerInformation"><div class="status" id="chatStatus"><label for="chatStatusOption"><system:label show="text" label="lblCurStatus" />:</label><select id="chatStatusOption"><option value="connected" selected><system:label show="text" label="lblConnected" /></option><option value="disconnected"><system:label show="text" label="lblDisconnected" /></option></select></div><div class="panel users open" id="chatPanelUsers"><div class="label"><system:label show="text" label="lblChatUsers" /></div><label for="chatUsersFilter" style="display: none;"><system:label show="text" label="lblSearchUsrs" /></label><input id="chatUsersFilter" style="width: 0px;" title="<system:label show="text" label="lblSearchUsrs" />"/><div class="content"></div></div><div class="panel groups open" id="chatPanelGroups"><div class="label"><system:label show="text" label="lblChatGruops" /></div><div class="content"></div></div><div class="panel requests open" id="chatPanelRequests"><div class="label"><system:label show="text" label="lblChatRequests" /></div><div class="content"></div></div></div></div><%} else {%><div class="mobileMenuContent" id="tab-2"><div class="menuInfo"><div class="menuInfo-usrImg"></div><span class="menuInfo-loginName"><system:util show="currentLoginName" /></span><br/><span class="menuInfo-login"><system:util show="currentLogin" /></span><br/><span class="menuInfo-env"><system:util show="currentEnvironment" /></span><br/></div><ul id="menuOptContainer"><li id="menuOptHome"><system:label show="text" label="sbtHomePage"/></li><li id="menuOptTasksList"><system:label show="text" label="mnuLisTar"/></li><li id="menuOptStartPro"><system:label show="text" label="mnuIniPro"/></li><li id="menuOptQuery"><system:label show="text" label="mnuQry"/></li><li id="menuOptReport"><system:label show="text" label="mnuExeReports"/></li><li id="menuOptChangeUserPwd"><system:label show="text" label="mnuCamCon"/></li><li id="menuOptChangeEnv"><system:label show="text" label="sbtChangeEnv"/><div id="collapseMenuEnvIcon"></div></li></ul><ul id="usrEnvList"></ul><hr><div id="menuOptLogout"><system:label show="text" label="btnSal"/></div></div><%} %><div class="configurationModal" id="configModal" tabIndex="0"><div class="header"><system:label show="text" label="sbtConfig"/></div><div class="container"><div class="title"><system:label show="text" label="sbtHomePage" /></div><div class="configurationModalBtns"><div class="button configurationModalBtnLeft" id="btnRestConfModal"><system:label show="text" label="btnRestore"/></div><div class="button configurationModalBtnRight" id="btnMoreConfModal"><system:label show="text" label="btnConfig"/></div></div><div class="title"><system:label show="text" label="sbtOtherConf" /></div><div class="configurationModalBtns"><div class="button configurationModalBtnLeft" id="btnStartConfModal"><system:label show="text" label="btnStartup"/></div><div class="button configurationModalBtnRight" id="btnPassConfModal"><system:label show="text" label="btnPassChange"/></div><div class="button configurationModalBtnLeft" id="btnLangConfModal"><system:label show="text" label="btnLangChange"/></div><div class="button configurationModalBtnRight" id="btnStyleConfModal"><system:label show="text" label="btnStyleChange"/></div></div></div><div class="footer"><div class="close" id="closeConfigModal" tabIndex="0"><system:label show="text" label="lblCloseWindow"/></div></div></div></div></body></html>