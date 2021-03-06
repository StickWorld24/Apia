function initPage(){
	//crear spinner de espere un momento
	sp = new Spinner(document.body,{message:WAIT_A_SECOND});
	
	//Cambiar imagen
	$('changeImg').addEvent("click", function(evt){
		evt.stop();
		showImagesModal(processModalImageConfirm);		
	});
	//Reiniciar imagen
	$('btnResetImg').addEvent("click", function(evt){
		evt.stop();
		var txtPathImg = $('imgPath');
		var changeImg = $('changeImg'); 
		changeImg.style.backgroundImage = "url('"+CONTEXT + "/" + PATH_IMG + DEFAULT_IMG+"')";
		txtPathImg.value = DEFAULT_IMG;
		txtPathImg.fireEvent('change');
	});
	
	//Init Tabs
	initTabFilters();
	initTabFiltersMetadata();
	initTabDisplay();
	initPermissions();			
	
	initDocTypeMdlPage();
	initUsrMdlPage();
	initTaskMdlPage();
	initProcMdlPage();
	initEntMdlPage();
	initAttMdlPage();
	initFormMdlPage();
	initImgMdlPage();
	
	initAdminActionsEdition(executeBeforeConfirm);
	initAdminFav();	
	initAdminFieldOnChangeHighlight();
	
	var imgPath = $('imgPath');
	if (imgPath){
		imgPath.addEvent("change",function(){
			var isSameValue = this.value == this.get('initialValue');
			if (! isSameValue) {
				this.getParent().addClass("highlighted");
			} else {
				this.getParent().removeClass("highlighted");
			}
		});
	}
	
	getBodyController().canRemoveTab = function() { return ! AT_LEAST_ON_FIELD_INPUT_CHANGED; };
}

function cmbPrjChange(cmb){
	var nameInput = $('monDocName');
	
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

function executeBeforeConfirm(){
	var ok = true;
	
	if (ok) { ok = ok && executeBeforeConfirmTabFilters(); }
	if (ok) { ok = ok && executeBeforeConfirmTabFiltersMetadata(); }
	if (ok) { ok = ok && executeBeforeConfirmTabDisplay(); }
		
	return ok;
}

function processModalImageConfirm(image){
	if (image != null){
		var txtPathImg = $('imgPath');
		var changeImg = $('changeImg'); 
		changeImg.style.backgroundImage = "url('"+image.path+"')";
		txtPathImg.value = image.id;
		txtPathImg.fireEvent('change');
	}
}

