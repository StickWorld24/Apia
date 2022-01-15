
var tipCapsLockPwd;
var tipCapsLockPwdCnf;
var sp;

window.addEvent('load', function() {
	
	sp = new Spinner(document.body,{message:WAIT_A_SECOND});
	if(Browser.ie) {
		sp.content.getParent().setStyles({top:0, left: 0});
		//$(document.body).setStyle('overflow-y', 'hidden');
		$(document.body).getElement('div.spinner-img').setStyles({
			width: '100%',
			backgroundPosition: 'center'
		}).set('scroll', 'auto');
	}
	
	//tooltips para links de la pagina
//	var loginRemember = $('loginRemember');	
	
	var formChecker = new FormCheck(
			'passwordForm',
			{
				submit:false,
				display : {
					keepFocusOnError : 1,
					tipsPosition: 'left',
					tipsOffsetY: -12,
					tipsOffsetX: -10,
					titlesInsteadNames : 1
				}
			}
	);
	
	Generic.setButton($("changePwd")).addEvent("click", function(e) {
		if(e) e.stop();
		$("messageContainer").addClass("hidden");
		
		if(!formChecker.isFormValid()){
			return;
		}
		
		var usrLgIn = $('currentUser').value;
		var usrToken = $('hidUsrTkn').value;
		
		var request = new Request({
			method: 'post',
			url: CONTEXT + '/apia.security.LoginAction.run?action=changePasswordFromExternal&usrLgIn=' + usrLgIn + "&usrToken=" + usrToken + '&tokenId=' + TOKEN_ID,
			data: {
				newPassword:new AesUtil(keySize, iterationCount).encrypt(salt, iv, passPhrase, $('newPassword').value)
			},
			onRequest: function() { sp.show(true); },
			onComplete: function(resText, resXml) {processXMLChangeResponse(resXml); }
		}).send();
	});
	
	$("newPassword").addEvent("keydown" , function(evt){checkCapsLock(evt, false);});
	$("newPasswordConf").addEvent("keydown" , function(evt){checkCapsLock(evt, true);});
	
	tipCapsLockPwd = FormCheck.makeTooltip('newPassword', CAPS_TITLE);
	tipCapsLockPwdCnf = FormCheck.makeTooltip('newPasswordConf', CAPS_TITLE);
	
	if (TOKEN_EXPIRED) {
		$('passwordForm').style.display = 'none';
		var messageContainer = $("messageContainer");
		messageContainer.removeClass("hidden");
		messageContainer.addClass("warning");
		messageContainer.innerHTML = "";

		new Element('span.label', {html: MSG_PSSWD_EXPIRED}).inject(messageContainer);
	} else if (TOKEN_INVALID) {
		$('passwordForm').style.display = 'none';
		var messageContainer = $("messageContainer");
		messageContainer.removeClass("hidden");
		messageContainer.addClass("warning");
		messageContainer.innerHTML = "";

		new Element('span.label', {html: MSG_PSSWD_EXPIRED}).inject(messageContainer);
	}
})

function gotoSplash(){
	var form = new Element('form', {
		action: CONTEXT + '/apia.security.LoginAction.run',
		method: 'post'
	});
	new Element('input', {name: 'action', value: 'gotoSplash'}).inject(form);
	new Element('input', {name: 'tokenId', value: TOKEN_ID}).inject(form);
	new Element('input', {name: 'tabId', value: TAB_ID}).inject(form);
	form.inject(document.body);
	form.submit();
}

function processXMLChangeResponse(ajaxCallXml){
	if (ajaxCallXml != null) {
		//obtener el codigo de retorno
		var code = ajaxCallXml.getElementsByTagName("code");
		//si el login fue exitoso, redirigir al splash
		if(LOGIN_OK == code.item(0).firstChild.nodeValue){
			gotoSplash();	
		} else if ( LOGIN_ERROR  == code.item(0).firstChild.nodeValue){
			//si el codigo es diferente de 0	
			var messages = ajaxCallXml.getElementsByTagName("messages");
			if (messages != null && messages.length > 0 && messages.item(0) != null) {
				messages = messages.item(0).getElementsByTagName("message");
				for(var i = 0; i < messages.length; i++) {
					var message = messages.item(i);
					var text	= message.getAttribute("text");
					showMessage(text);							
				}
			}
			sp.hide(true);
		}
	}
}

function showMessage(text){
	if(window.MOBILE) {
		var panel = SYS_PANELS.newPanel([]);		
		panel.content.innerHTML = text;
		SYS_PANELS.addClose(panel);
		SYS_PANELS.adjustVisual();
	} else {
		var messageContainer = $("messageContainer");
		messageContainer.removeClass("hidden");
		messageContainer.addClass("warning");
		messageContainer.innerHTML="";

		new Element('span.label', {html: text}).inject(messageContainer);
	}
}

function checkCapsLock(e, action) {
	var value = e.target.value;

	if(value.length == 0)
		return;
	
	value = value.substr(value.length - 1, value.length);
	var code = value.charCodeAt(0);
	
	if (code >= 65 && code <= 90) {
		if (action) {
			tipCapsLockPwd.hide();
			tipCapsLockPwdCnf.show();
		} else {
			tipCapsLockPwdCnf.hide();
			tipCapsLockPwd.show();
		}
	} else {
		if (action) {
			tipCapsLockPwdCnf.hide();
		} else {
			tipCapsLockPwd.hide();
		}
	}
}












