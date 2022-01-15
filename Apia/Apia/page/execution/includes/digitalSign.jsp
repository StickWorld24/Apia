<%@page import="com.dogma.Configuration"%><script type="text/javascript">
	var appletBlocker;
	
	function showAppletModal() {
		signedOK = "false";
		appletBlocker = $$('div.modalBlocker')[0]
		if(!appletBlocker)
			appletBlocker = createBlockerDiv();
		var divDigitalSign = $("divDigitalSign").setStyles({
			display: 'block',
			zIndex: Number.from(appletBlocker.getStyle('z-index')) + 1
		});
		
		<% 
			boolean hasCustomBrowser = false;
			if(!"".equals(Configuration.SIGNATURE_PAGE_CHROME)) { 
				hasCustomBrowser = true;
		%>
				if(Browser.chrome && Browser.version >= 42) {
					divDigitalSign.position();
					var ifrApplet = $("ifrApplet");
					ifrApplet.setStyle("height", 150);
					ifrApplet.setStyle("width", 500);
					divDigitalSign.position();
					divDigitalSign.addClass("chromeApplet");
					$("ifrApplet").src =  "<system:util show="context" />/<%=Configuration.SIGNATURE_PAGE_CHROME%>?<system:util show="tabIdRequest" />";
					divDigitalSign.focus();
				} else 
		<% 	}
			if(!"".equals(Configuration.SIGNATURE_PAGE_FIREFOX)) { 
				hasCustomBrowser = true;
		%>
				if(Browser.firefox && Browser.version >= 50) {
					divDigitalSign.position();
					var ifrApplet = $("ifrApplet");
					ifrApplet.setStyle("height", 150);
					ifrApplet.setStyle("width", 500);
					divDigitalSign.position();
					divDigitalSign.addClass("firefoxApplet");
					$("ifrApplet").src =  "<system:util show="context" />/<%=Configuration.SIGNATURE_PAGE_FIREFOX%>?<system:util show="tabIdRequest" />";
					divDigitalSign.focus();
				} else 
		<% 	}
			if(!"".equals(Configuration.SIGNATURE_PAGE_EDGE)) { 
				hasCustomBrowser = true;
		%>
				if(Browser.Platform.name.contains("win") && Browser.edge && Browser.version*100000 >= 1515063) {
					divDigitalSign.position();
					var ifrApplet = $("ifrApplet");
					ifrApplet.setStyle("height", 150);
					ifrApplet.setStyle("width", 500);
					divDigitalSign.position();
					divDigitalSign.addClass("edgeApplet");
					$("ifrApplet").src =  "<system:util show="context" />/<%=Configuration.SIGNATURE_PAGE_EDGE%>?<system:util show="tabIdRequest" />";
					divDigitalSign.focus();
				} else 
		<% 	}
			if(!"".equals(Configuration.SIGNATURE_PAGE_IE)) { 
				hasCustomBrowser = true;
		%>
				if(Browser.ie) {
					divDigitalSign.position();
					$("ifrApplet").src =  "<system:util show="context" />/<%=Configuration.SIGNATURE_PAGE_IE%>?<system:util show="tabIdRequest" />";
				} else 
		<% 	}
			if(!"".equals(Configuration.SIGNATURE_PAGE_OPERA)) { 
				hasCustomBrowser = true;
		%>
				if(Browser.opera) {
					divDigitalSign.position();
					$("ifrApplet").src =  "<system:util show="context" />/<%=Configuration.SIGNATURE_PAGE_OPERA%>?<system:util show="tabIdRequest" />";
				} else 
		<% 	}
			if(!"".equals(Configuration.SIGNATURE_PAGE_SAFARI)) { 
				hasCustomBrowser = true;
		%>
				if(Browser.safari) {
					divDigitalSign.position();
					$("ifrApplet").src =  "<system:util show="context" />/<%=Configuration.SIGNATURE_PAGE_SAFARI%>?<system:util show="tabIdRequest" />";
				} else 
		<% 	}
			
			if(hasCustomBrowser) { %>
			{
		<% } %>
			divDigitalSign.position();
			$("ifrApplet").src =  "<system:util show="context" />/<%=Configuration.SIGNATURE_PAGE_DEFAULT%>?<system:util show="tabIdRequest" />";
		<% if(hasCustomBrowser) { %>
			}
		<% } %>
	}
	
	function hideAppletModal() {
		if(!appletBlocker) {
			appletBlocker = $$('div.modalBlocker')[0];
		}
		if(appletBlocker)
			appletBlocker.destroy();
		appletBlocker = null;
		$('divDigitalSign').setStyle('display', 'none');
	}
</script>