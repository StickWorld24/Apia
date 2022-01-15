function initObjectTable() {
	$('aTabObj').addEvent("focus", function(evt) {
		addScrollTable($('tableDataObj'));
	});
	
	var addObject = $('btnAddObj');
	if (addObject) {
		addObject.addEvent('click', function(evt) {
			evt.stop();
			addRow($('tableDataObj'));
		});
	}
	
	var delObject = $('btnDeleteObj');
	if (delObject) {
		delObject.addEvent('click', function(evt) {
			evt.stop();
			if (selectionCount($('tableDataObj')) == 0) {
				showMessage(GNR_CHK_AT_LEAST_ONE, GNR_TIT_WARNING, 'modalWarning');
			} else {
				var pos = getSelectedRows($('tableDataObj'))[0].rowIndex;
				deleteRow(parseInt(pos),'tableDataObj');
			}
		})
	}
}

function addRow(table, col1, col2) {
	var optionSelected = $('selNatLangType').value;
	var parent = table.getParent();
	table.selectOnlyOne = true;
	var thead = parent.getFirst("thead");
	var theadTr = thead ? thead.getFirst("tr") : null;
	var headers = theadTr ? thead.getElements("th") : null;
	var tdWidths = headers ? new Array(headers.length) : null;
	if (headers) {
		for (var i = 0; i < headers.length; i++) {
			tdWidths[i] = headers[i].style.width;
			if (! tdWidths[i]) tdWidths[i] = headers[i].width;
			if (! tdWidths[i]) tdWidths[i] = headers[i].getAttribute("width");
		}
	}
	var i=0;
	var tr = new Element('tr');
	tr.addClass("selectableTR");
	tr.addEvent("click",function(e){myToggle(this)});
	tr.getRowId = function () { return this.getAttribute("rowId"); };
	tr.setRowId = function (a) { this.setAttribute("rowId",a); };
	tr.setAttribute("rowId", table.rows.length);
	
	var td = new Element('td',{'align': 'center'});
	div = new Element('div', {styles: {width: tdWidths[i], overflow: 'hidden', 'white-space': 'pre','text-align':'center'}});
	var object;
	var nameLeft = 'txtQuest';
	var nameRight = 'txtAns';
	if (optionSelected != 'C') {
		if (col1) {
			object = col1;
		} else {
			object = new Element('select');
			populateSelect(object);
		}
	} else {
		if (col1) {
			object = col1;
		} else {
			object = new Element('input');
		}
		object.setAttribute('type','text');
	}
	object.setAttribute('style','width:90%');
	object.setAttribute("class", nameLeft);
	object.setAttribute("name", nameLeft);
	object.setAttribute("id", nameLeft);
	object.inject(div);
	new Element("span",{html:"&nbsp;*"}).inject(div);
	div.inject(td);
	td.inject(tr);
	i++;
	
	var elemToAutocomplete = input;
	
	var td = new Element('td',{'align': 'center'});	
	var input = col2 ? col2 : new Element("input");
	div = new Element('div', {styles: {width: tdWidths[i], overflow: 'hidden', 'white-space': 'pre','text-align':'center'}});
	input.setAttribute("name", nameRight);
	input.setAttribute("id", nameRight);
	input.setAttribute('type','text');
	input.setAttribute('style','width:90%');
	input.inject(div);	
	div.inject(td);
	td.inject(tr);
	i++;
		
	if(table.rows.length%2==0){
		tr.addClass("trOdd");
	}
	
	tr.inject(table);	
	
	addScrollTable(table);
	
	initAdminFieldOnChangeHighlight(false, false, false, tr);
}

function deleteRow(pos,tblName) {
	var table = $(tblName);
	var row = table.rows[pos-1];
	inputs = row.getElementsByTagName("input");
	input = inputs.item(0);
	row.dispose();
	for (var i=0;i<table.rows.length;i++){
		table.rows[i].setRowId(i);
		if (i%2==0){
			table.rows[i].addClass("trOdd");
		}else{
			table.rows[i].removeClass("trOdd");
		}
	}
	addScrollTable(table);
} 

function myToggle(oTr){
	if (oTr.getParent().selectOnlyOne) {
		var parent = oTr.getParent();
		if (parent.lastSelected) parent.lastSelected.toggleClass("selectedTR");
		parent.lastSelected = oTr;
	}
	oTr.toggleClass("selectedTR"); 
}

function populateSelect(element) {
	var optionSelected = $('selNatLangType').value;
	var langSelected = $('selNatLangLang').value;
	if (optionSelected != 'C') {
		var action = '?action=getDefaultQuestions&questType=' + optionSelected + '&langId=' + langSelected;
		if (optionSelected == 'N') {
			action = '?action=getCommandFunctionNames';
		}
		var request = new Request({
			method: 'post',
			url: CONTEXT + URL_REQUEST_AJAX + action +  TAB_ID_REQUEST,
			onRequest: function() { SYS_PANELS.showLoading(); },
			onComplete: function(resText, resXml) { 
				var questions = resXml.getElementsByTagName('object');
				if (questions.length > 0) {
					for (i = 0; i < questions.length; i++) {
						var child = questions[i];
						var option = new Element('option');
						option.innerHTML = child.getAttribute('objElem');
						option.setAttribute('value', child.getAttribute('objId'));
						element.add(option);
					}
				}
				SYS_PANELS.closeAll();
			}
		}).send();
	}
}