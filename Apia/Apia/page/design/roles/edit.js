function initPage(){
	//crear spinner de espere un momento
	sp = new Spinner(document.body,{message:WAIT_A_SECOND});
		
	initAdminFieldOnChangeHighlight();
	initAdminActionsEdition(verifyPermissions,false,false,false);
	initPermissions();
	initAdminFav();
	
	getBodyController().canRemoveTab = function() { return ! AT_LEAST_ON_FIELD_INPUT_CHANGED; };
}

function cmbPrjChange(cmb){
	var nameInput = $('rolName');
	
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