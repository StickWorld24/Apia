
function DEFAULT_USR_SHOW_MODAL(){
	initUsrMdlPage();
	USERMODAL_EXTERNAL = true;
	USERMODAL_SELECTONLYONE	= true;
	showUsersModal(processUsersModalReturnForLDAP);
	return true;
}