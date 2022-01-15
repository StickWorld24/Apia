
var spModalDocInformation;

function initDocDwnInfoMdlPage(){
	var mdlDocDwnInfoContainer = $('mdlDocDwnInfoContainer');
	if (mdlDocDwnInfoContainer.initDone) return;
	mdlDocDwnInfoContainer.initDone = true;

	mdlDocDwnInfoContainer.blockerModal = new Mask();
	
	spModalDocInformation = new Spinner($('mdlBodyDocInfo'),{message:WAIT_A_SECOND});
	
	$('closeDocDwnInfoModal').addEvent("click", function(e) {
		e.stop();
		closeDocDwnInfoModal();
	});
	
	var btnCopyUrl = $('btnCpyClip');
	if (btnCopyUrl) {
		btnCopyUrl.addEvent('click', function(evt) {
			if (evt) evt.stop();
			var url = $('hDocUrlArea');
			url.focus();
			url.select();
			var success = document.execCommand('copy');
			if (success) {
				var message = $('hCopyConfMsg');
				message.innerHTML = MSG_COPY_URL
			} else {
				var message = $('hCopyConfMsg');
				message.innerHTML = MSG_URL_NOT_COPIED;
			}
		})
	}
}

function showDocDwnInfoModal(docId){   
	var mdlDocDwnInfoContainer = $('mdlDocDwnInfoContainer');
	mdlDocDwnInfoContainer.removeClass('hiddenModal');
	mdlDocDwnInfoContainer.position();
	mdlDocDwnInfoContainer.blockerModal.show();
	mdlDocDwnInfoContainer.setStyle('zIndex', SYS_PANELS.getNewZIndex());
	mdlDocDwnInfoContainer.docId = docId;
	
	spModalDocInformation.show(true);
	cleanDocDwnInformationModal();
	loadDocDwnInfo(mdlDocDwnInfoContainer.docId);
}

function loadDocDwnInfo(docId){
	var request = new Request({
		method : 'post',
		url : CONTEXT + URL_REQUEST_AJAX + '?action=loadDocDwnInformation&isAjax=true&docId=' + docId + TAB_ID_REQUEST,
		onRequest : function() { },
		onComplete : function(resText, resXml) { processXmlDocDwnInfo(resXml); }
	}).send();
}

function cleanDocDwnInformationModal(){
	$("hDocType").innerHTML = "";
	$("hDocName").innerHTML = "";
	$("hDocDesc").innerHTML = "";
	$("hDocLock").innerHTML = "";
	$('hDocUrlArea').innerHTML = "";
	$('hdocExpDate').innerHTML = '';
//	$('hDocUrl').innerHTML = "";
	$('tableDocDwnHist').getElements("tr").each(function(tr){ tr.destroy(); });	
	$('hCopyConfMsg').innerHTML = "";
}

function processXmlDocDwnInfo(resXml){
	var information = resXml.getElementsByTagName("information")
	if (information != null && information.length > 0 && information.item(0) != null) {
		information = information.item(0);
		var genData = information.getElementsByTagName("genData").item(0);
		var history = information.getElementsByTagName("docDownHistory");
		
		//Datos generales
		$('hDocName').innerHTML = genData.getAttribute("name");
		$('hDocLock').innerHTML = genData.getAttribute("lock");
		$('hDocType').innerHTML = genData.getAttribute("docType");
		$('hDocDesc').innerHTML = genData.getAttribute("description");
		$('hDocUrlArea').innerHTML = genData.getAttribute("docDownUrl");
		$('hdocExpDate').innerHTML = genData.getAttribute('docExpDate');
//		$('hDocUrl').innerHTML = genData.getAttribute("docDownUrl");		
		
		//Historial de descargas
		var hasHistory = false;
		var tableHistory = $('tableDocDwnHist');
		if (history != null && history.length > 0 && history.item(0) != null) {
			history = history.item(0).getElementsByTagName("docHistory");
			for (var i = 0; i < history.length; i++){
				hasHistory = true;
				var xmlMet = history[i];
				var tr = new Element("tr",{}).inject(tableHistory);
				if (i % 2 == 0) { tr.addClass("trOdd"); }
				if (i == history.length-1) { tr.addClass("lastTr"); }				
				//td1 version date
				var td1 = new Element("td", {'align':'center'}).inject(tr);
				var div1 = new Element('div', {styles: {width: '150px', overflow: 'hidden', 'white-space': 'pre', 'margin': '4px 0px'}}).inject(td1);
				var spanName = new Element('span',{html: xmlMet.getAttribute("hisVer")}).inject(div1);
				if (div1.scrollWidth > div1.offsetWidth) {
					td1.title = xmlMet.getAttribute("hisVer");
					td1.addClass("titiled");
				}
				//td2 download date
				var td2 = new Element("td", {'align':'center'}).inject(tr);
				var div2 = new Element('div', {styles: {width: '150px', overflow: 'hidden', 'white-space': 'pre', 'margin': '4px 0px'}}).inject(td2);
				var spanValue = new Element('span',{html: xmlMet.getAttribute("hisDwn")}).inject(div2);
				if (div2.scrollWidth > div2.offsetWidth) {
					td2.title = xmlMet.getAttribute("hisDwn");
					td2.addClass("titiled");
				}
				//td3 download user
				var td3 = new Element("td", {'align':'center'}).inject(tr);
				var div3 = new Element('div', {styles: {width: '90px', overflow: 'hidden', 'white-space': 'pre', 'margin': '4px 0px'}}).inject(td3);
				var spanFree = new Element('span',{html: xmlMet.getAttribute("hisUsr")}).inject(div3);
			}
		}
		if (hasHistory){
			$('divNoHistory').setStyle("display","none");
			$('divDwnHistory').setStyle("display","");
			addScrollTable(tableHistory);
		} else {
			$('divNoHistory').setStyle("display","");
			$('divDwnHistory').setStyle("display","none");
		}
	}		
	
	var mdlDocDwnInfoContainer = $('mdlDocDwnInfoContainer');
	mdlDocDwnInfoContainer.position();
	
	spModalDocInformation.hide(true);
}

function closeDocDwnInfoModal(){
    var mdlDocDwnInfoContainer = $('mdlDocDwnInfoContainer');
    mdlDocDwnInfoContainer.addClass('hiddenModal');
    mdlDocDwnInfoContainer.blockerModal.hide();	    
}

