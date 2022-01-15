function initPage() {
	loadHtmlStructure(false, 'dcsFldsTreeMdl');
}

function getModalReturnValue() {
	var selFolders = $$('li.folder.selected');
	if (selFolders.length > 1) {
		showMessage(GNR_CHK_ONLY_ONE, GNR_TIT_WARNING, 'modalWarning');
		return null;
	} else if (selFolders.length == 0) {
		showMessage(GNR_CHK_AT_LEAST_ONE, GNR_TIT_WARNING, 'modalWarning');
		return null;
	} else {
		var folderId = selFolders[0].id;
		var folderName = selFolders[0].getChildren('span')[0].getChildren('span.folderText')[0].innerHTML;
		return [folderId, folderName];
	}
}