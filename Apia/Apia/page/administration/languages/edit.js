function initPage(){
	//crear spinner de espere un momento
	sp = new Spinner(document.body,{message:WAIT_A_SECOND});
	
	initAdminFieldOnChangeHighlight();
	initAdminActionsEdition();
	initAdminFav();
	
	getBodyController().canRemoveTab = function() { return ! AT_LEAST_ON_FIELD_INPUT_CHANGED; };
}

/*
 * Update Modal Actions
 */

var frmMdl;

function prepareAttTranslationUpdateModal(){
	var updateDate = $('iniDteUpdate'); var updateTime = $('iniTimeUpdate');
	setAdmDatePicker(updateDate); setHourField(updateTime);
	
	updateDate.getNext().addClass('validate[\"required\"]');
	updateTime.addClass('validate[\"required\",\"~validateHours\"]');
	
	frmMdl = document.getElement('.lang-update-action-mdl').getElement('form')
	frmMdl.formChecker = new FormCheck(
		frmMdl,
		{
			submit:false,
			display : {
				keepFocusOnError : 1,
				tipsPosition: 'left',
				tipsOffsetY: -12,
				tipsOffsetX: -10
			}
		}
	);
	
	setAsReadOnly(updateDate.getNext(), true);
	setAsReadOnly(updateTime, true);
	
	enableUpdateOptions(false);
}

function changeUpdateOptionAction(obj){
	enableUpdateOptions($('copyPrevTrans').checked || $('clearPrevTrans').checked);
}

function changeUpdateAction(obj){
	setAsReadOnly($('iniDteUpdate').getNext(), obj.value!='2');
	setAsReadOnly($('iniTimeUpdate'), obj.value!='2');
}

function setAsReadOnly(obj, readonly){
	if (!obj) return;
	
	if (readonly){
		obj.setAttribute('disabled','');
		obj.addClass('readonly');
		obj.value='';
	} else {
		obj.removeAttribute('disabled');
		obj.removeClass('readonly');
	}
}

function enableUpdateOptions(enable){
	var isDisabled = $('onConfirm').getAttribute('disabled')=='';
	
	['onConfirm','schAction'].each(function(ele){
		if (enable){
			$(ele).removeAttribute('disabled');
		} else {
			$(ele).setAttribute('disabled','');
			$(ele).checked=false;
		}	
	})
	if (!enable){ changeUpdateAction({}); }
	else if (isDisabled){ $('onConfirm').checked=true; }	
}

function confirmUpdateModal(obj){
	if (!frmMdl.formChecker.isFormValid()) return ; 
}

function validateHours(obj){
   if (obj.value == "") return true;	
	
   var RegEx = /^([0-1]?[0-9]|2[0-4]):([0-5][0-9])(:[0-5][0-9])?$/;
   if(!obj.value.match(RegEx)){
	  obj.errors.push("Invalid format "+TIME_FORMAT);
      return false;
   }   
   return true;
}
