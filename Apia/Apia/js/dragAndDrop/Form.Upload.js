/*
---

name: Form.Upload
description: Create a multiple file upload form
license: MIT-style license.
authors: Arian Stolwijk
requires: [Form.MultipleFileInput, Request.File]
provides: Form.Upload

...
*/

(function(){
"use strict";

if (!this.Form) this.Form = {};
var Form = this.Form;

Form.Upload = new Class({

	Implements: [Options, Events],

	options: {
		dropMsg: 'Please drop your files here',
		fireAtOnce: false,
		useList: true,
		useProgress: false,
		allowMultiple: true,
		resetOnDrop: false,
		onComplete: function(){
			// reload
			window.location.href = window.location.href;
		}
	},

	initialize: function(input, options){
		input = this.input = document.id(input);
		
		this.setOptions(options);

		// Our modern file upload requires FormData to upload
		if ('FormData' in window) 
			this.modernUpload(input);
		else 
			this.legacyUpload(input);
	},

	modernUpload: function(input){

		this.modern = true;

		var form = input.getParent('form');
		if (!form) return;

		var self = this;

		var drop = this.options.domDrop ? this.options.domDrop : (new Element('div.droppable', { text: this.options.dropMsg }).inject(input, 'after'));

		var list = this.options.useList ? new Element('ul.uploadList').inject(drop, 'after') : null;
		var progress = this.options.useProgress ? (this.options.domProgress ? this.options.domProgress : new Element('div.progress').setStyle('display', 'none').inject(this.options.useList ? list : drop, 'after')) : null;

		var uploadReq = new Request.File({
			url: form.get('action'),
			onRequest: function(event) {
				self.fireEvent('request', Array.slice(arguments));
				if (progress) {
					progress.setStyle('display', 'block');
					progress.setStyle('width', '0px');
				}
			},
			onProgress: function(event){
				var loaded = event.loaded, total = event.total;
				if (progress) {
					progress.setStyle('width', parseInt(loaded / total * 100, 10).limit(0, 100) + '%');
				}
			},
			onComplete: function(){
				if (progress) progress.setStyle('width', '100%');
				self.fireEvent('complete', Array.slice(arguments));
				this.reset();
			}
		});

		var inputname = input.get('name');

		var  inputFiles = new Form.MultipleFileInput(input, list, drop, {
			avoidDetectInputChange: this.options.avoidDetectInputChange,
			allowMultiple: this.options.allowMultiple,
			filterFileTypes: this.options.filterFileTypes,
			allowedFileTypes: this.options.allowedFileTypes,
			forbiddenFileTypes: this.options.forbiddenFileTypes,
			disableAfterDrop: this.options.disableAfterDrop,
			docOptions: this.options.docOptions,
			elemId: this.options.elemId,
			dropElemProps: null,
			
			onAdd: function(file) {
				
				var fileRemoved = false;
				var mdlDocumentContainer = $('mdlDocumentContainer');
				if (mdlDocumentContainer.deletedDocuments == undefined) mdlDocumentContainer.deletedDocuments = [];
				if (mdlDocumentContainer.repeatedDocuments == undefined) mdlDocumentContainer.repeatedDocuments = [];	// ver si no confunde su uso, ya que seria solo para los droppeados
//				if (!this.options.allowMultiple) deleteAllDocumentsPreviews(false);
				var action = mdlDocumentContainer.extraProperties && mdlDocumentContainer.extraProperties.action ?  mdlDocumentContainer.extraProperties.action : null; 
				mdlDocumentContainer.extraProperties = this.options.docOptions;
				if (action != '') mdlDocumentContainer.extraProperties.action = action;
				
				/*
				 * check if added file meets extension and size requirements
				 * this.options.allowedFileTypes[fileExtension] == -1 states that only extension must be checked
				 * genericDocType symbolizes the presence of a docType with no extension restriction. 
				 * */ 
				var fileExt = file.name.substring(file.name.lastIndexOf('.') + 1).toLowerCase();
				var fileSize = file.size;
				if (this.options.forbiddenFileTypes != undefined && this.options.forbiddenFileTypes != null && 
						Object.keys(this.options.forbiddenFileTypes).length != 0) {
					if (fileExt in this.options.forbiddenFileTypes) {
						if (!fileRemoved) {
							this.remove(file);
							fileRemoved = true;
							mdlDocumentContainer.deletedDocuments.push(file.name);
						}
					} 
				} 

				if (this.options.allowedFileTypes != undefined && this.options.allowedFileTypes != null &&
						Object.keys(this.options.allowedFileTypes).length != 0 && this.options.filterFileTypes) {
					if ('all' in this.options.allowedFileTypes && parseInt(fileSize) > parseInt(this.options.allowedFileTypes['all'])) {
						this.remove(file);
						fileRemoved = true;
						mdlDocumentContainer.deletedDocuments.push(file.name);
					} else if ((fileExt in this.options.allowedFileTypes && (this.options.allowedFileTypes[fileExt] 
								&& this.options.allowedFileTypes[fileExt] != -1 && parseInt(fileSize) > parseInt(this.options.allowedFileTypes[fileExt]))) ||
								(!(fileExt in this.options.allowedFileTypes)) && !('all' in this.options.allowedFileTypes)) {
						if (!fileRemoved) {
							this.remove(file);
							fileRemoved = true;
							mdlDocumentContainer.deletedDocuments.push(file.name);
						}
					}		 
				} 
				
				/*
				 * check if added file it's a new version of a file already uploaded
				 * */
				if (Object.keys(this.options.docOptions) != 0 && this.options.docOptions.name != null 
						&& this.options.docOptions.name.length > 0 && file.name != this.options.docOptions.name) {
					if (!fileRemoved) {
						this.remove(file);
						fileRemoved = true;
						mdlDocumentContainer.deleteFileByNotMatchingNames += 1;
					}
				}
				
				/*
				 * check if modal is open and the dropped document fulfills with this
				 * */
				var documentsMdl = $('mdlDocumentContainer');
				if (documentsMdl && documentsMdl.isVisible()) {
					var docTypeSel = documentsMdl.getElementById('cmbDocType');
					if (docTypeSel) {
						var dcType;
						if ((navigator.userAgent.indexOf("MSIE") != -1 ) || (!!document.documentMode == true )) {
							dcType = docTypeSel.getSelected()[0];
						} else {
							dcType = docTypeSel.selectedOptions[0];
						}
						
						var extensions = dcType.getAttribute('data-extensions');
						var maxSize = dcType.getAttribute('data-maxvalueallowed');
						if (extensions != null && extensions.length > 0) extensions = extensions.split(';');
						if ((extensions != null && extensions.length > 0 && !extensions.includes(fileExt)) || parseInt(fileSize) > parseInt(maxSize)) {
							if (!fileRemoved) {
								this.remove(file);
								fileRemoved = true;
								mdlDocumentContainer.deletedDocuments.push(file.name);
							}
						}
					}
				}
				
				/*
				 * Check that a new dropped file is not already added
				 * */
				var incomingFileInfo = {'name': file.name, 'type': file.type};
				
				if ($('mdlDocumentContainer').isVisible()) {
					if ($('mdlDocumentContainer').droppedFiles.length > 0) {
						for (var i = 0; i < $('mdlDocumentContainer').droppedFiles.length; i++) {
							if (JSON.stringify(incomingFileInfo) == JSON.stringify($('mdlDocumentContainer').droppedFiles[i])) {
								this.remove(file);
								fileRemoved = true;
								mdlDocumentContainer.repeatedDocuments.push(file.name);
								break;
							}
						}
					}
				} else {
					if ($('mdlDocumentContainer').droppedFiles == undefined || $('mdlDocumentContainer').droppedFiles.length == 0 || !this.options.allowMultiple)
						$('mdlDocumentContainer').droppedFiles = [];
				}
				
				if (fileRemoved === false) $('mdlDocumentContainer').droppedFiles.push(incomingFileInfo);
				var dropArea = this.drop.id;
				if (dropArea != undefined && dropArea.startsWith('dropArea') && (dropArea.endsWith('P') || dropArea.endsWith('E'))) {
					$('mdlDocumentContainer').extraProperties = this.options.docOptions;
				}
				
				if ($('mdlDocumentContainer').isVisible() && $('mdlDocumentContainer').extraProperties && $('mdlDocumentContainer').extraProperties.action != 'confirmDroppedDocuments')
					$('mdlDocumentContainer').extraProperties = this.options.docOptions;
				
				if (fileRemoved === false && !this.options.allowMultiple) deleteAllDocumentsPreviews(false);
			},
			
			onDragenter: function() {
				if (this.drop.getChildren('div').length > 0) {
					if (this.options.elemId == 'P' || this.options.elemId == 'E') {
						increaseDropArea(this.drop.getChildren('div')[0]);	// DROP AREA EN UNA INSTANCIA DE ENTIDAD/TAREA
					} else {
						increaseDropArea(this.drop);	// FILE INPUT DENTRO DE UNA GRILLA
					}
				} else if (this.drop.getChildren('span').length > 0) {
					increaseDropArea(this.drop.getChildren('span')[0]);	// FILE INPUT FUERA DE UNA GRILLA
				} else {
					increaseDropArea(this.drop);	// DROP AREA DENTRO DEL MODAL DE DOCUMENTOS
				}
				
				if (self.options.resetOnDrop) self.reset();
			},
			onDragleave: function() {
				if (this.drop.getChildren('div').length > 0) {
					if (this.options.elemId == 'P' || this.options.elemId == 'E') {
						normalizeDropArea(this.drop.getChildren('div')[0], true);
					} else {
						normalizeDropArea(this.drop, false);
					}
				} else if (this.drop.getChildren('span').length > 0) {
					normalizeDropArea(this.drop.getChildren('span')[0], false);
				} else {
					normalizeDropArea(this.drop, true);
				}
			},
			onDrop: function(){
				if (this.drop.getChildren('div').length > 0) {
					if (this.options.elemId == 'P' || this.options.elemId == 'E') {
						normalizeDropArea(this.drop.getChildren('div')[0], true);
					} else {
						normalizeDropArea(this.drop, false);
					}
				} else if (this.drop.getChildren('span').length > 0) {
					normalizeDropArea(this.drop.getChildren('span')[0], false);
				} else {
					normalizeDropArea(this.drop, true);
				}
				
				if (self.options.fireAtOnce){
					
					var mdlDocumentContainer = $('mdlDocumentContainer');
					var deletedDocsWarning = '';
					var repeatedDocsWarning = '';
					var notMatchingNamesDocsError = '';
					if (Object.keys(mdlDocumentContainer.deletedDocuments).length > 0) {
						for (var iter = 0; iter < mdlDocumentContainer.deletedDocuments.length; iter++) {
							deletedDocsWarning += mdlDocumentContainer.deletedDocuments[iter] + '<br>';
						}
					} 
					
					if (Object.keys(mdlDocumentContainer.repeatedDocuments).length > 0) {
						var hiddenDocuments = [];
						var droppedDocuments = $('docsNamesContainer').getElementsByClassName('option');
						if (droppedDocuments && droppedDocuments.length > 0) {
							for (var iter = 0; iter < droppedDocuments.length; iter++) {
								if (droppedDocuments[iter].style.display == 'none')
									hiddenDocuments.push(droppedDocuments[iter].getChildren('div')[0].getChildren('span')[0].innerText.trim());
							}
						}
						
						for (var iter = 0; iter < mdlDocumentContainer.repeatedDocuments.length; iter++) {
							if (!hiddenDocuments.includes(mdlDocumentContainer.repeatedDocuments[iter]))
								repeatedDocsWarning += mdlDocumentContainer.repeatedDocuments[iter] + '<br>';
						}
					}
					
					if (mdlDocumentContainer.deleteFileByNotMatchingNames > 0) {
						notMatchingNamesDocsError = LBL_DROP_FILE_NAMES_NOT_MATCH;
					}
					
					mdlDocumentContainer.deletedDocuments = [];
					mdlDocumentContainer.repeatedDocuments = [];
					mdlDocumentContainer.deleteFileByNotMatchingNames = 0;
					
					SYS_PANELS.closeActive();
					
					var messageDisplayed = false;
					
					if (deletedDocsWarning != '' || repeatedDocsWarning != '') {
						messageDisplayed = true;
						showMessage((deletedDocsWarning != '' ? '<b>' + LBL_DROP_FILE_DELETED + ' :</b><br>' + deletedDocsWarning : '') + (repeatedDocsWarning != '' ? '<b>' + LBL_DROP_FILE_REPEATED + ' :</b><br>' + repeatedDocsWarning : ''), GNR_TIT_WARNING, 'modalWarning', function() {
								if (inputFiles.getFiles().length > 0) {
//									SYS_PANELS.showLoading();
									input.value = '';
									self.submit(inputFiles, inputname, uploadReq);
								}
							}
						);
					} 
						
					else if (notMatchingNamesDocsError != '') {
						messageDisplayed = true;
						showMessage(notMatchingNamesDocsError, GNR_TITILE_EXCEPTIONS, 'modalError', function() {
								if (inputFiles.getFiles().length > 0) {
//									SYS_PANELS.showLoading();
									input.value = '';
									self.submit(inputFiles, inputname, uploadReq);
								}
							}
						);
					}
					
					
					
					if (!messageDisplayed && inputFiles.getFiles().length > 0) {
						input.value = '';
						self.submit(inputFiles, inputname, uploadReq);
					}
					
				}
			},
			onChange: function(){
				drop.removeClass.pass('drop_hover', drop);
				if (self.options.fireAtOnce){
					self.submit(inputFiles, inputname, uploadReq);
				}
			}
		});

		form.addEvent('submit', function(event){
			if (event) event.preventDefault();
			self.submit(inputFiles, inputname, uploadReq);
//			if ($('btnConfirmDocumentModal').callUpdateStatus) 
//				$('btnConfirmDocumentModal').callUpdateStatus.delay(200);
		});

		self.reset = function() {
			var files = inputFiles.getFiles();
			for (var i = 0; i < files.length; i++){
				inputFiles.remove(files[i]);
			}
		};
	},

	submit: function(inputFiles, inputname, uploadReq){
		inputFiles.getFiles().each(function(file){
			uploadReq.append(inputname , file);
		});
		
		uploadReq.send();
		
		if ($('btnConfirmDocumentModal').callUpdateStatus) {
			if ($('mdlDocumentContainer').isVisible()) SYS_PANELS.closeActive();
			$('mdlDocumentContainer').set("data-prefix", $('mdlDocumentContainer').extraProperties.prefix);
			if (!$('mdlDocumentContainer').extraProperties.params) $('mdlDocumentContainer').extraProperties.params = '';
			$('mdlDocumentContainer').extraProperties.params += '&delayForDrop=true';
			$('btnConfirmDocumentModal').callUpdateStatus.delay(200);
		} 
	},

	legacyUpload: function(input){

		var rows = [];

		var row = input.getParent('.wrapper-block');
		var rowClone = row.clone(true, true);
		var add = function(event){
			event.preventDefault();

			var newRow = rowClone.clone(true, true),
				inputID = String.uniqueID(),
				label = newRow.getElement('label');

			newRow.getElement('input').set('id', inputID).grab(new Element('a.delInputRow', {
				text: 'x',
				events: {click: function(event){
					event.preventDefault();
					newRow.destroy();
				}}
			}), 'after');

			if (label) label.set('for', inputID);
			newRow.inject(row, 'after');
			rows.push(newRow);
		};

		new Element('a.addInputRow', { text: '+', events: {click: add} }).inject(input, 'after');

		this.reset = function() {
			for (var i = 0; i < rows.length; i++){
				rows[i].destroy();
			}
			rows = [];
		};

	},

	isModern: function(){
		return !!this.modern;
	}

});

}).call(window);

var formerText;

/*
 * EN LOS SIGUIENTES METODOS SE HACE UN WRAPPER DEL AREA DEL DROP
 * POR PROBLEMAS CON MOZILLA FIREFOX. PARTICULARMENTE, AL HACER DROP
 * Y PARARSE SOBRE ALGUNA DE LAS LETRAS DEL MENSAJE MOSTRADO, FIREFOX
 * NO DETECTA A LA LETRA COMO PARTE DEL AREA Y COMIENZA A MOSTRAR
 * Y OCULTAR EL AREA INCONTROLABLEMENTE
 * */

function increaseDropArea(dropArea) {
	if (dropArea.hasClass('auxElem')) return;
	if(dropArea.tagName.toLowerCase() == 'span') {
		if (dropArea.id.startsWith('mdl')) {
			var elem = new Element('span.auxElem');
			dropArea.addClass('auxElem');
			var dropParent = dropArea.getParent();
			var spanCopy = dropArea;
			formerText = '';
			spanCopy.removeClass('dropIcon');
			spanCopy.inject(elem);
			elem.inject(dropParent);
			elem.setStyle('height', '40px');
			changeElemStyle(spanCopy, true, '1', '1');
			spanCopy.setStyles({
				'background-color': 'transparent',
				'height': dropArea.getStyle('height'),
				'line-height': '1'
//				'transform': '',
//				'-ms-transform': '',
//				'-webkit-transform': '',
			});
//				'zIndex': '9999999',
//				'border': '2px solid black',
//				'borderStyle': 'dashed',
//				'text-align': 'center',
				
//			});
			spanCopy.innerHTML = LBL_LEAVE_DOCS_HERE;
		} else {
			var elem = new Element('span.auxElem');
			var dropParent = dropArea.getParent();
			var spanCopy = dropArea;
			formerText = spanCopy.textContent;
			spanCopy.innerHTML = LBL_LEAVE_DOCS_HERE;
			spanCopy.inject(elem);
			elem.inject(dropParent);
			changeElemStyle(spanCopy, true, '1.1', '1.3');
			spanCopy.setStyles({
				'background-color': 'transparent',
			});
//			spanCopy.setStyles({
//				'zIndex': '9999999',
//				'transform': 'scale(1.1, 1.3)',
//				'-ms-transform': 'scale(1.1, 1.3)',
//				'-webkit-transform': 'scale(1.1, 1.3)', 
//				'border': '1.5px solid',
//				'borderStyle': 'dashed',
//				'text-align': 'center',
//				'background-color': 'transparent'
//			});
		}
		 
	} else if (!dropArea.hasClass('dropIcon')) {
		if (dropArea.getChildren('div')[0].hasClass('docData')) {
			changeElemStyle(dropArea, true, '1.1', '1.1');
			var auxInput = new Element('div');
			auxInput.innerHTML = LBL_LEAVE_DOCS_HERE;
//			dropArea.getChildren('div')[0].text = 'MESSAGE IN CHILD';
//			dropArea.setStyles({
//				'transform': 'scale(1.1, 1.1)',
//				'-ms-transform': 'scale(1.1, 1.1)',
//				'-webkit-transform': 'scale(1.1, 1.1)',
//			});
//			dropArea.setStyle('transform', 'scale(1.1, 1.1)');
		} else {
			changeElemStyle(dropArea, true, '1.7', '2');
//			dropArea.setStyles( {
//				'transform': 'scale(1.7, 2)',
//				'-ms-transform': 'scale(1.7, 2)',
//				'-webkit-transform': 'scale(1.7, 2)',
//				
//			});
			if (dropArea.childNodes[0].textContent != LBL_LEAVE_DOCS_HERE)
				formerText = dropArea.childNodes[0].textContent;
			dropArea.childNodes[0].innerHTML = LBL_LEAVE_DOCS_HERE;
		}
	} else {
		var elem = new Element('div.auxElem');
		var dropParent = dropArea.getParent();
		var dropAreaCopy = dropArea;
		dropAreaCopy.removeClass('dropIcon');
		dropAreaCopy.innerHTML = LBL_LEAVE_DOCS_HERE;
		dropAreaCopy.inject(elem);
		elem.inject(dropParent);
		changeElemStyle(dropAreaCopy, true, '1.1', '1.1');
		dropAreaCopy.setStyles({
			'background-color': 'white',
			'height': '60px',
			'line-height': '3.5'
		});
//		dropAreaCopy.setStyles({
//			'zIndex': '9999999',
//			'transform': 'scale(1.25, 1.2)',
//			'-ms-transform': 'scale(1.25, 1.2)',
//			'-webkit-transform': 'scale(1.25, 1.2)', 
//			'border': '1.5px solid black',
//			'borderStyle': 'dashed',
//			'text-align': 'center',
//			'background-color': 'red',
//			'heigth': '50px',
//			'line-height': '3.5'
//		});
	}
	
	dropArea.removeClass('dropIcon');
}

function normalizeDropArea(dropArea, addClass) {
	if (addClass) dropArea.addClass('dropIcon');
	changeElemStyle(dropArea, false);
//	dropArea.setStyles({
//		'transform': '',
//		'-ms-transform': '',
//		'-webkit-transform': '',
//		'zIndex': '1',
//		'border': '',
//		'text-align': 'left',
//		'background-color': 'transparent'
//	});
	
	if(dropArea.tagName.toLowerCase() == 'span') {
		if (dropArea.id.startsWith('mdl')) {
			dropArea.innerHTML = '';
			dropArea.removeClass('auxElem');
			changeElemStyle(dropArea, false);
//			dropArea.setStyles({
//				'transform': '',
//				'-ms-transform': '',
//				'-webkit-transform': '',
//				'zIndex': '1',
//				'border': '',
//				'text-align': 'left',
//				'background-color': 'transparent'
//			});
		} else {
			var realDropArea = dropArea.childNodes[0].clone();
			realDropArea.addClass('dropIcon');
			realDropArea.innerHTML = formerText;
			changeElemStyle(realDropArea, false);
//			realDropArea.setStyles({
//				'transform': '',
//				'-ms-transform': '',
//				'-webkit-transform': '',
//				'zIndex': '1',
//				'border': '',
//				'text-align': 'left',
//				'background-color': 'transparent'
//			});
			dropArea.getParent().replaceChild(realDropArea, dropArea);
		}
	} else if (!dropArea.hasClass('dropIcon')) {
		if (dropArea.getChildren('div')[0].hasClass('docData')) {

		} else {
			dropArea.childNodes[0].innerHTML = formerText;
		}
	} else {
		var realDropArea = dropArea.childNodes[0].clone();
		realDropArea.addClass('dropIcon');
		realDropArea.innerHTML = '';
		changeElemStyle(realDropArea, false);
		realDropArea.removeAttribute('style');
//		realDropArea.setStyles({
//			'transform': '',
//			'-ms-transform': '',
//			'-webkit-transform': '',
//			'zIndex': '1',
//			'border': '',
//			'text-align': 'left',
//			'background-color': 'transparent'
//		});
		dropArea.getParent().replaceChild(realDropArea, dropArea);
	}
}

function changeElemStyle(elem, add, transformX, transformY) {
	elem.setStyles({
		'transform': add ? 'scale(' + transformX + ', ' + transformY + ')' : '',
		'-ms-transform': add ? 'scale(' + transformX + ', ' + transformY + ')' : '',
		'-webkit-transform': add ? 'scale(' + transformX + ', ' + transformY + ')' : '',
		'zIndex': add ? '9999999' : '1',
		'border': add ? '2px solid black' : '',
		'text-align': add ? 'center' : 'left',
		'borderStyle': add ? 'dashed' : '',
		'background-color': add ? 'white' : 'transparent'
	});	
}