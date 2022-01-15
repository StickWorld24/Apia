var lastAttType = null;

function initPage(){
	//crear spinner de espere un momento
	sp = new Spinner(document.body,{message:WAIT_A_SECOND});
	
	$('btnTest').addEvent('click', function(e) {
		e.stop();
		if (lastAttType != "D"){
			opentTestExpresion();
		}		
	});	
	//['btnTest'].each(setTooltip);
	
	changeAttType($('attType'));	
	
	initAdminFieldOnChangeHighlight();
	initAdminFieldOnChangeHighlight($('modalOptionsContainer'));
	initAdminActionsEdition(verifyPermissions,false,false,false);
	initPermissions();
	initAdminFav();
	
	getBodyController().canRemoveTab = function() { return ! AT_LEAST_ON_FIELD_INPUT_CHANGED; };
}

function cmbPrjChange(cmb){
	var nameInput = $('attName');
	
	if(nameInput.value=='') {
		if(cmb.options[cmb.selectedIndex].get('data-prefix') && cmb.options[cmb.selectedIndex].get('data-prefix')!=''){
			nameInput.value = cmb.options[cmb.selectedIndex].get('data-prefix') + '_'; 	
		}
	} else {
		for(i=0; i<cmb.options.length; i++){
			var prefixName = cmb.options[i].get('data-prefix') + '_';
			if(nameInput.value == prefixName) {
				if(cmb.options[i].get('data-prefix') != ''){
					nameInput.value = cmb.options[cmb.selectedIndex].get('data-prefix') + '_';	
				} else {
					nameInput.value = '';
				}
				
			}
		}
	}
		

}

 

function opentTestExpresion() {
	var panel = SYS_PANELS.newPanel([]);

	panel.header.innerHTML = TIT_TEST_EXPRESSION;
	
	var dicContainer = new Element('div');
	new Element('span', {html: LBL_TEST_EXPRESSION + ": "}).inject(dicContainer);
	new Element('input', {type: 'text', name: 'toTest', id: 'toTest'}).inject(dicContainer);
	dicContainer.inject(panel.content);
	
	new Element('div', {id: 'testResult'}).inject(panel.content);
	
	var button = new Element('DIV.button', { html: 'Test'});
	button.inject(panel.footer);
	button.addEvent('click',testExpression);
	
	SYS_PANELS.addClose(panel);
	SYS_PANELS.adjustVisual();
}

function testExpression(s){
	if (document.getElementById("toTest").value != "") {
   		var re = new RegExp(document.getElementById("attRegExp").value);
		var str = document.getElementById("toTest").value;
		$('testResult').innerHTML = (re.test(str) != true) ? msgExpRegFail : msgExpRegOk;
	}
}

function changeAttType(cmb){
	var attLength = $('attLength');
	var attMask = $('attMask');
	var attRegExp = $('attRegExp');
	var btnTest = $('btnTest');
	
	if (cmb.value == "D"){ //Fecha
		attLength.value = DATE_LENGTH;
		attLength.readOnly = true;
		attLength.addClass("readonly");
		attMask.value = DATE_MASK;
		attMask.readOnly = true;
		attMask.addClass("readonly");
		attRegExp.value = "";
		attRegExp.readOnly = true;		
		attRegExp.addClass("readonly");
	} else if (lastAttType == "D"){
		attLength.value = "";
		attLength.readOnly = false;
		attLength.removeClass("readonly");
		attMask.value = "";
		attMask.readOnly = false;
		attMask.removeClass("readonly");
		attRegExp.value = "";
		attRegExp.readOnly = false;		
		attRegExp.removeClass("readonly");
	}
	
	lastAttType = cmb.value; 
}

function checkLen99999(el){
	var error = false;
	if ($('attType').value != "D" && toBoolean(DATA_USED)){
		if ($('attLength').value != ""){
			var currLen = parseInt($('attLength').value);
			var auxLen = parseInt($('attLengthAux').value);
			error = auxLen > currLen;
		}
	}
	
	if (error){
		el.errors.push(MSG_ERR_SMALLER_SIZE.replace("<TOK1>",$('attLengthAux').value));
        return false;	
	}
	
	if (el.value != ""){
		var intValue = parseInt(el.value);
	    if (!(intValue >= 0 && intValue <= 99999)) {
	        el.errors.push(MSG_ERR_LENGTH);
	        return false;
	    }
	}
    
    return true;
}