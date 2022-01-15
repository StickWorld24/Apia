/**
 *	FUNCTIONS TO LOAD AND DISPLAY FOLDERS STRUCTURE
 */

function loadHtmlStructure(forModal, ulId, untilFldId) {
	$(ulId).innerHTML = '';
	var request = new Request({
		method: 'post',
		url: CONTEXT + URL_REQUEST_AJAX + '?action=loadFolderStructure&isAjax=true' + TAB_ID_REQUEST,
		onRequest: function() { /*SYS_PANELS.showLoading();*/ },
		onComplete: function(resText, resXml) { 
			if (resXml.getElementsByTagName('folder') != null && resXml.getElementsByTagName('folder').length > 0) {
				createFullStructure(resXml, forModal, ulId); 
			} else {
				if ($('gridBody')) $('gridBody').noDataMessage.setStyle('display', '');
			}
			
		}
	}).send(untilFldId ? '&until=' + untilFldId : '');
}

function createFullStructure(resXml, forModal, ulId) {
	var allNodesByParent = {};
	Array.from(resXml.getElementsByTagName('folder')).each(function(elem) {
		var id = elem.getAttribute('id');
		var parent = elem.getAttribute('parent');
		var level = elem.getAttribute('level');
		if (level === '') {
			level = 0;
		}
		
		if (typeof allNodesByParent[level] === 'undefined') {
			allNodesByParent[level] = new Array();
		}
		
		allNodesByParent[level].push(elem);
	});
	
//	if (forModal) {
//		var item = new Element('li', {'styles': {'text-align' : 'center', 'list-style-type': 'none'}});
//		var div = new Element('div', {'class': 'modalOptionsContainer'}).inject(item);
//		new Element('span', {'class': 'option optionAdd', 'styles': {'width': '95%'}, 'text': MSG_NO_SELECT_FOLDER}).inject(div);
//		new Element('br').inject(item, 'after');
//		
//		item.addEvent('click', function(evt) {
//			if (evt) evt.stop();
//			if ($$('li.folder.selected').length > 0) $$('li.folder.selected')[0].removeClass('selected');
//			collapseAll();
//				
//		});
//		item.inject($(ulId));
//	}
	
	var mainStructure = $(ulId);
	for (var key in allNodesByParent) {
		var folder;
		var nodeList = allNodesByParent[key];
		for (var i = 0; i < nodeList.length; i++) {
    		if (key == 0) {
    			createFolderInStructure(allNodesByParent[key][i], forModal).inject(mainStructure);
    		} else {
    			var parent = nodeList[i].getAttribute('parent');
        		var parentEle = mainStructure.getElementById(parent + (forModal === true ? '_mdl' : ''));
        		var parentUl = parentEle.getElementsByTagName('ul');
    			if (parentUl == null || parentUl.length == 0) {
	    			parentUl = new Element('ul', {'class':'directory'});
	    			parentUl.inject(parentEle);
	    			parentEle.removeClass('leaf').removeClass('closeFld').addClass('subroot').addClass('openFld');
	    		} else {
	    			parentUl = parentUl[0];
	    		}
	    		
	    		createFolderInStructure(allNodesByParent[key][i], forModal).inject(parentUl);
    		}
		}
	}
	
	loadEventsToArrays($$("span.toggler"), $$('li.folder'));
	
	if ($('filterOrder')) {
		var sortProperties = {
				name: false,
				date: false,
				asc: false
			};
			
		switch($('filterOrder').value) {
			case '1':
				sortProperties.name = true;
				sortProperties.asc = true;
				break;
			case '2':
				sortProperties.name = true;
				sortProperties.asc = false;
				break;
			case '3':
				sortProperties.date = true;
				sortProperties.asc = true;
				break;
			case '4':
				sortProperties.date = true;
				sortProperties.asc = false;
				break;
		}
		
		if ($(ulId).childNodes[0] == null) {
			if (gridBody && gridBody.noDataMessage) $(gridBody.noDataMessage).setStyle('display','none');
		}
		
		sortStructure($(ulId), sortProperties.name, sortProperties.date, sortProperties.asc);
	} else {
		sortStructure($(ulId), true, false, true);
	}
	
	
	collapseAll();
	
	SYS_PANELS.closeActive();
}

function createFolderInStructure(xml, forModal) {
	var strDate = xml.getAttribute('date').replace(' ', 'T') + 'Z';
	var list = new Element('li', {'id': xml.getAttribute('id') + (forModal === true ? '_mdl' : ''), 'class':'folder closeFld leaf', 'title': xml.getAttribute('desc')});
	var main = new Element('span', {'class':'mainSpan'}).inject(list);
	new Element('span', {'class': 'toggler'}).inject(main);
	new Element('span', {'class': 'emptySpace'}).inject(main);
	new Element('span', {'class': 'icon'}).inject(main);
	if (forModal) {
		list.addClass('hasRemover');
		var spanContainer = new Element('span', {'class': 'folderText modalOptionsContainer'}).inject(main);
		var spanSon = new Element('span').inject (new Element('span', {'class': 'canRemove'}).inject(spanContainer));
		new Element('span', {'text': xml.getAttribute('name')}).inject(spanSon);
		var closeBttn = new Element('span', {'tabIndex': '0', 'class': 'optionRemove', styles: {'display': 'none'}}).inject(spanSon);
		closeBttn.addEvent('click', function(evt) {
			if (evt) evt.stop();
			this.getParent('li.folder').removeClass('selected');
			this.setStyle('display', 'none');
//			if ($$('li.folder.selected').length > 0) $$('li.folder.selected')[0].removeClass('selected');
//			collapseAll();
		})
	} else {
		new Element('span', {'class': 'folderText', 'text': xml.getAttribute('name')}).inject(main);
	}
	
	if (toBoolean(xml.getAttribute('showDate')) === true) {
		new Element('span', {'class': 'folderExtraInfo', 'text': MSG_LAST_MOD_DATE + ': ' + xml.getAttribute('formattedDate')}).setStyle('display', 'none').inject(main);
		new Element('span', {'text':strDate}).setStyle('display', 'none').inject(main);
	}
	
	list.addClass((toBoolean(xml.getAttribute('edit')) === false ? 'uneditableFldTree' : ''));
	return list
}

function loadEventsToArrays(arrayToggler, arrayFolder) {
	arrayToggler.each(function(ele) { 
		ele.addEvent('click', function(evt) {
			ele.getParent("li").toggleClass("openFld"); ele.getParent("li").toggleClass("closeFld");
		});
	});
	
	arrayFolder.each(function(ele) {
		if (!ele.hasClass('uneditableFldTree')) {
			ele.addEvent('click', function(evt) {
				if (evt) evt.stop();
				$$('span.folderText').each(function(elem) {
						elem.removeClass('selected');
				});
				
				$$('span.folderExtraInfo').each(function(elem) {
					elem.removeClass('selected');
				});
				
				$$('li.selected').each(function(elem) {
					elem.toggleClass('selected');
					if (elem.hasClass('hasRemover')) elem.getElements('span.optionRemove')[0].setStyle('display', 'none');
				});
				
				ele.toggleClass('selected');
				ele.getElementsByClassName('folderText')[0].toggleClass('selected');
				if (ele.hasClass('hasRemover')) ele.getElements('span.optionRemove')[0].setStyle('display', '');
				if ($$('span.folderExtraInfo').length > 0) ele.getElementsByClassName('folderExtraInfo')[0].toggleClass('selected');
			});
		}
		
		ele.addEvent('dblclick', function(evt) {
			if (evt) evt.stop();
			ele.getElementsByClassName('toggler')[0].fireEvent('click');
		});
		
		ele.addEvent('mouseover', function(evt) {
			if (evt) evt.stop();
			ele.toggleClass('mouseover');
		});
		
		ele.addEvent('mouseout', function(evt) {
			if (evt) evt.stop();
			ele.toggleClass('mouseover');
		});
	});
}

function collapseAll() {
	$$('li.folder').each(function(elem) {
		elem.removeClass('openFld').addClass('closeFld');
	});
}

function sortStructure(elem, byName, byDate, asc) {
	if (elem != null /*&& typeof elem.childNodes[1] !== 'undefined'*/) {
		var liElems = [];
		for (var i = 0; i < elem.childNodes.length; i++) {
			if (elem.childNodes[i].hasClass('folder')) liElems.push(elem.childNodes[i]);
		}
		
		if (liElems != null && liElems.length > 0) {
			liElems = Array.from(liElems).sort(function(primerElem, segundoElem) {
				if (byName === true) {
					if (asc === true) return naturalCompare(primerElem, segundoElem, 3);
					else return naturalCompare(segundoElem, primerElem, 3);
				} else if (byDate === true) {
					if (asc === true) return naturalCompare(primerElem, segundoElem, 4);
					else return naturalCompare(segundoElem, primerElem, 4);
				}
			});
			
			Array.from(liElems).each(function(elm) {
				elm.inject(elem);
			});
			
			Array.from(elem.childNodes).each(function(li) {
				sortStructure(li.childNodes[1], byName, byDate, asc);
			});
			
		}
	}
}

function sortDocuments(elem, asc) {
	if (elem != null) {
		var liElems = [];
		for (var i = 0; i < elem.childNodes.length; i++) {
			if (elem.childNodes[i].hasClass('document') && elem.childNodes[i].hasClass('leaf')) liElems.push(elem.childNodes[i]);
		}
		
		if (liElems.length > 0) {
			liElems = Array.from(liElems).sort(function(primerElem, segundoElem) {
				return naturalCompare(primerElem, segundoElem, 3);
			});
		}
		
		Array.from(liElems).each(function(elm) {
			elm.inject(elem);
		});
		
		Array.from(elem.childNodes).each(function(li) {
			sortDocuments(li.childNodes[1], asc);
		});
	}
}

function naturalCompare(primero, segundo, sortBy) {
    var ax = [], bx = [];

    var a = primero.childNodes[0].childNodes[sortBy].innerHTML;
	var b = segundo.childNodes[0].childNodes[sortBy].innerHTML;
    
	if (sortBy == 3) {
		a.replace(/(\d+)|(\D+)/g, function(_, $1, $2) { ax.push([$1 || Infinity, $2 || ""]) });
	    b.replace(/(\d+)|(\D+)/g, function(_, $1, $2) { bx.push([$1 || Infinity, $2 || ""]) });
	    
	    while(ax.length && bx.length) {
	        var an = ax.shift();
	        var bn = bx.shift();
	        var nn = (an[0] - bn[0]) || an[1].localeCompare(bn[1]);
	        if(nn) return nn;
	    }

	    return ax.length - bx.length;
	} else if (sortBy == 4) {
		var primerDate = new Date(a);
		var segundaDate = new Date(b);
		
		if (primerDate > segundaDate) return 1;
		if (primerDate < segundaDate) return -1;
		return 0;
	}
}