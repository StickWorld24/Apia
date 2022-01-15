var evtNotif;
function initTabActions(){
	evtNotif = "";
	
	//Agregar Grupo Notificacion
    $('addPoolNotC').addEvent("click", function(evt){
    	evt.stop();
    	openPoolsModal('C');    	
    });
    $('addPoolNotE').addEvent("click", function(evt){
    	evt.stop();
    	openPoolsModal('E');    	
    });
    $('addPoolNotA').addEvent("click", function(evt){
    	evt.stop();
    	openPoolsModal('A');    	
    });
    $('addPoolNotO').addEvent("click", function(evt){
    	evt.stop();
    	openPoolsModal('O');    	
    });    
    
    //Mensajes
    $('viewMsgNotC').addEvent("click", function(evt){
    	evt.stop();
    	openMsgsModal('C'); 	   	
    });
    $('viewMsgNotE').addEvent("click", function(evt){
    	evt.stop();
    	openMsgsModal('E'); 	   	
    });
    $('viewMsgNotA').addEvent("click", function(evt){
    	evt.stop();
    	openMsgsModal('A'); 	   	
    });
    $('viewMsgNotO').addEvent("click", function(evt){
    	evt.stop();
    	openMsgsModal('O'); 	   	
    });
    
    ['addPoolNotC','addPoolNotE','addPoolNotA','addPoolNotO','viewMsgNotC','viewMsgNotE','viewMsgNotA','viewMsgNotO'].each(setTooltip);
	
	onChangeChkReaPool($('chkReaPool'));
	
	loadNotifications();
}

function disabledAllTabActions(){
	if (MODE_DISABLED){
    	var tabContent = $('contentTabActions');
    	tabContent.getElements("input").each(function(input){
    		input.disabled = true;
    		input.readOnly = true;
    		input.addClass("readonly");
    	});
    	tabContent.getElements("select").each(function(select){
    		select.disabled = true;
    		select.readOnly = true;
    		select.addClass("readonly");
    	});
    	tabContent.getElements("div.option").each(function(option){
    		option.removeEvents('click');
    	});
    	tabContent.getElements("div.mdl-btn").each(function(option){
    		option.removeEvents('click');
    	});
    }
}

function openPoolsModal(event){
	evtNotif = event;
	POOLMODAL_SHOWAUTOGENERATED = false;
	POOLMODAL_SHOWNOTAUTOGENERATED = false;
	POOLMODAL_FROMENVS = "";
	POOLMODAL_SHOWCURRENTENV = false;
	POOLMODAL_SHOWGLOBAL = true;
	POOLMODAL_EXACTMATCH = ""; 
	POOLMODAL_SELECTONLYONE	= false;
	showPoolsModal(processPoolsModalReturn);
}

function openMsgsModal(event){
	evtNotif = event;
	var text = $("msgText"+event).value;
	var sub = $("msgSub"+event).value;
	showMsgNotificationsModal(event,sub,text,processMsgNotifModalReturn);
}

function onChangeChkReaPool(chkReaPool){
	var cmbReaPool = $('cmbReaPool');
	var divChkReaPool = $('divChkReaPool');
	
	if (chkReaPool.checked == true){
		cmbReaPool.disabled = false;
		
		if (!cmbReaPool.hasClass("validate['required']")){
			cmbReaPool.addClass("validate['required']");
		}
		$('frmData').formChecker.register(cmbReaPool);
		
		if (!divChkReaPool.hasClass("required")){
			divChkReaPool.addClass("required");
		}
		
	} else {
		cmbReaPool.disabled = true;
		cmbReaPool.value = "";
		
		$('frmData').formChecker.dispose(cmbReaPool);
		
		if (divChkReaPool.hasClass("required")){
			divChkReaPool.removeClass("required");
		}
	}	
}

function onChangeCmbNotif(cmbNotif){
	var cmbNotifId = cmbNotif.getAttribute("id");
	var levelX = $("levX"+cmbNotifId);
	if (cmbNotif.value != "0"){
		levelX.value = "";
		levelX.disabled = true;
	} else {
		levelX.disabled = false;
		levelX.value = "0";
	}
}

function loadNotifications(){
	var request = new Request({
		method : 'post',
		url : CONTEXT + URL_REQUEST_AJAX + '?action=loadNotifications&isAjax=true' + TAB_ID_REQUEST,
		onRequest : function() { },
		onComplete : function(resText, resXml) { 
			processNotificationXml(resXml); 
			
			['containerPoolsC','containerPoolsE','containerPoolsA','containerPoolsO'].each(function(container){
				initAdminModalHandlerOnChangeHighlight($(container));	
			})
		}
	}).send();
}

function processNotificationXml(resXml){
	var notifications = resXml.getElementsByTagName("notifications")
	if (notifications != null && notifications.length > 0 && notifications.item(0) != null) {
		var notify, create, end, alert, overdue;
		
		//Usuario creador proceso
		//notify = notifications.item(0).getElements("notify_U")[0];
		notify = notifications.item(0).getElementsByTagName("notify_U")[0];
		end = notify.getAttribute("end");
		$('chkUE').checked = (end == "-2");			
		alert = notify.getAttribute("alert");
		$('chkUA').checked = (alert == "-2");			
		overdue = notify.getAttribute("overdue");
		$('chkUO').checked = (overdue == "-2");			
		//Grupo del usuario creador
		//notify = notifications.item(0).getElements("notify_P")[0];
		notify = notifications.item(0).getElementsByTagName("notify_P")[0];
		end = notify.getAttribute("end");
		if (end >= 0) {
			$('cmbPE').value = "0";
			$('levXcmbPE').value = end;			
		} else { 
			$('cmbPE').value = end; 
			$('levXcmbPE').value = "";
			$('levXcmbPE').disabled = true;
		}
		alert = notify.getAttribute("alert");
		if (alert >= 0) {
			$('cmbPA').value = "0";
			$('levXcmbPA').value = alert;			
		} else { 
			$('cmbPA').value = alert; 
			$('levXcmbPA').value = "";
			$('levXcmbPA').disabled = true;
		}	
		overdue = notify.getAttribute("overdue");
		if (overdue >= 0) {
			$('cmbPO').value = "0";
			$('levXcmbPO').value = overdue;			
		} else { 
			$('cmbPO').value = overdue; 
			$('levXcmbPO').value = "";
			$('levXcmbPO').disabled = true;
		}
		//Usuario creador entidad
		//notify = notifications.item(0).getElements("notify_E")[0];
		notify = notifications.item(0).getElementsByTagName("notify_E")[0];
		create = notify.getAttribute("create");
		$('chkEC').checked = (create == "-2");
		end = notify.getAttribute("end");
		$('chkEE').checked = (end == "-2");			
		alert = notify.getAttribute("alert");
		$('chkEA').checked = (alert == "-2");			
		overdue = notify.getAttribute("overdue");
		$('chkEO').checked = (overdue == "-2");
		//Usuarios(s) con tarea(s) adquirida
		//notify = notifications.item(0).getElements("notify_A")[0];
		notify = notifications.item(0).getElementsByTagName("notify_A")[0];
		alert = notify.getAttribute("alert");
		$('chkAA').checked = (alert == "-2");			
		overdue = notify.getAttribute("overdue");
		$('chkAO').checked = (overdue == "-2");
		//Grupo asignado a tarea					
		//notify = notifications.item(0).getElements("notify_T")[0];
		notify = notifications.item(0).getElementsByTagName("notify_T")[0];
		alert = notify.getAttribute("alert");
		if (alert >= 0) {
			$('cmbTA').value = "0";
			$('levXcmbTA').value = alert;			
		} else { 
			$('cmbTA').value = alert; 
			$('levXcmbTA').value = "";
			$('levXcmbTA').disabled = true;
		}	
		overdue = notify.getAttribute("overdue");
		if (overdue >= 0) {
			$('cmbTO').value = "0";
			$('levXcmbTO').value = overdue;			
		} else { 
			$('cmbTO').value = overdue; 
			$('levXcmbTO').value = "";
			$('levXcmbTO').disabled = true;
		}
		
		//Grupos
		var pools = notifications.item(0).getElementsByTagName("pools");
		if (pools != null && pools.length > 0 && pools.item(0) != null) {
			//pools = pools.item(0).getElements("pool");
			pools = pools.item(0).getElementsByTagName("pool");
			for(var i = 0; i < pools.length; i++){
				var pool = pools[i];
				var pEvent = pool.getAttribute("event");
				var pId = pool.getAttribute("id");
				var pName = pool.getAttribute("name");
				createPoolNotif(pId,pName,pEvent);
			}
		}
		
		//Mensajes
		var msgs = notifications.item(0).getElementsByTagName("messages");
		if (msgs != null && msgs.length > 0 && msgs.item(0) != null) {
			//msgs = msgs.item(0).getElements("message");
			msgs = msgs.item(0).getElementsByTagName("message");
			for(var i = 0; i < msgs.length; i++){
				var msg = msgs[i];
				var msgText = $("msgText"+msg.getAttribute("event"));
				msgText.value = msg.getAttribute("text");
				var msgSubject = $("msgSub"+msg.getAttribute("event"));
				msgSubject.value = msg.getAttribute("subject");
			}
		}
	}
	
	disabledAllTabActions();
	
	fixTable();
}

function createPoolNotif(pId,pName,evt){
	var before = $("addPoolNot"+evt);
	if (!$("pNot"+evt+pId)){
		var p = new Element("div",{'id': "pNot"+evt+pId, 'class': 'option optionTextOverflow optionRemoveTD optionWidth75', html: pName, 'title': pName}).inject(before,"before");
		p.setAttribute("pIdNum",pId);
		p.setAttribute("pName",pName);
		p.addEvent("click",function(evt){ this.destroy(); fixTable(); });
	}
	fixTable();
}

function processPoolsModalReturn(ret){
	ret.each(function(pool){
		createPoolNotif(pool.getRowId(),pool.getRowContent()[0],evtNotif);	
	});	
}

function processMsgNotifModalReturn(ret){
	var inputMsgNot = $("msgText"+evtNotif);
	inputMsgNot.value = ret.message;
	var inputSubNot = $("msgSub"+evtNotif);
	inputSubNot.value = ret.subject;
}

function executeBeforeConfirmTabActions(){
	var poolsIdC = $('poolsIdC');
	var values = "";
	var container = $('containerPoolsC');
	container.getElements("div.option").each(function (option){
		if (option.getAttribute("id") != "addPoolNotC"){
			if (values != "") values += ";";
			values += option.getAttribute("pIdNum");
			values += PRIMARY_SEPARATOR;
			values += option.getAttribute("pName");
		}
	});
	poolsIdC.value = values;
	
	var poolsIdE = $('poolsIdE');
	values = "";
	container = $('containerPoolsE');
	container.getElements("div.option").each(function (option){
		if (option.getAttribute("id") != "addPoolNotE"){
			if (values != "") values += ";";
			values += option.getAttribute("pIdNum");
			values += PRIMARY_SEPARATOR;
			values += option.getAttribute("pName");
		}
	});
	poolsIdE.value = values;
		
	var poolsIdA = $('poolsIdA');
	values = "";
	container = $('containerPoolsA');
	container.getElements("div.option").each(function (option){
		if (option.getAttribute("id") != "addPoolNotA"){
			if (values != "") values += ";";
			values += option.getAttribute("pIdNum");
			values += PRIMARY_SEPARATOR;
			values += option.getAttribute("pName");
		}
	});
	poolsIdA.value = values;
	
	var poolsIdO = $('poolsIdO');
	values = "";
	container = $('containerPoolsO');
	container.getElements("div.option").each(function (option){
		if (option.getAttribute("id") != "addPoolNotO"){
			if (values != "") values += ";";
			values += option.getAttribute("pIdNum");
			values += PRIMARY_SEPARATOR;
			values += option.getAttribute("pName");
		}
	});
	poolsIdO.value = values;
	
	return true;
}

function fixTable(){
	var table = $('tableData');
	addScrollTable(table);
}


