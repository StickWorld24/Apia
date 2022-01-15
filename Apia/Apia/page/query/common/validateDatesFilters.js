function initValidate() {
	setDatesChecker();
}

function validateDates(obj){
	var objId = obj.id;
	objId = objId.substring(objId.length - 1);
	var parent = obj.getParent();
	var childs = parent.getChildren();
	var chNro = 1;
	var dteStart = null;
	var dteEnd = null;
	for (i = 0; i < childs.length; i++) {
		if (childs[i].tagName.toLowerCase() == 'input' && childs[i].id == '') {
			if (childs[i].className.contains('datePickerChecker')) {
				if (chNro == 1) {
					var dteStart = childs[i];
					chNro++;
				} else {
					var dteEnd = childs[i];
					break;
				}
			}
		}
	}
	
	if (!dteEnd) {
		var id = obj.id;
		if (objId.match(/\d+/)) {
			dteEnd = getObject(id + 'i');
		} else {
			dteEnd = dteStart;
			dteStart = getObject(id.substring(0, id.length - 1));
		}
	}
	
	var datesOk = verifyDates(dteStart,dteEnd);
	var checkTime = true;
	
	if (!datesOk || (datesOk && !checkTime)){
		showMessage(MSG_ERROR_DATE, GNR_TIT_WARNING, 'modalWarning');
		var toClear;
		if (objId.match(/\d+/)){
			toClear = dteStart;
		} else if (typeof(objId) == 'string'){
			toClear = dteEnd;
		}
		toClear.value = "";
		if (toClear == dteStart || toClear == dteEnd){
			toClear.getNext().value = "";		
		}
	}
}

function getObject(objId) {
	var obj = $(objId);
	var parent = obj.getParent();
	var childs = parent.getChildren();
	for (i = 0; i < childs.length; i++) {
		if (childs[i].tagName.toLowerCase() == 'input' && childs[i].id == '') {
			if (childs[i].className.contains('datePickerChecker')) {
				return childs[i];
			}
		}
	}
}