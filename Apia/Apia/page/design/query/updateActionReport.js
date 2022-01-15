var actionColsRequired, actionColsCmbs; 

function initReportAction(){
	
	initReportMdlPage();
	loadReportAction();
	
	var btnAddRepQry = $('btnAddRepQry');
	if (btnAddRepQry){		
		btnAddRepQry.addEvent("click",function(e){
			e.stop();
			showReportsModal(processModalReturnReportQuery);
		});
	}
	
	var btnDeleteRepQuery = $('btnDeleteRepQry');
	if (btnDeleteRepQuery){
		btnDeleteRepQuery.addEvent("click",function(e){
			e.stop();
			if(selectionCount($('bodyAddRepQry')) == 0) {
				showMessage(GNR_CHK_AT_LEAST_ONE, GNR_TIT_WARNING, 'modalWarning');
			} else {
				var rows = getSelectedRows($('bodyAddRepQry'));
				for (var i=0;i<rows.length;i++){
					deleteRow(parseInt(rows[i].rowIndex),'bodyAddRepQry');
				}
				Scroller_bodyAddReport = addScrollTable($('bodyAddRepQry'));
			} 
			
		});
	}
	
	var btnUpReportQuery = $('btnUpRepQry');
	if (btnUpReportQuery){
		btnUpReportQuery.addEvent("click", function(e) {
			e.stop();
			if(selectionCount($("bodyAddRepQry")) == 0) {
				showMessage(GNR_CHK_AT_LEAST_ONE, GNR_TIT_WARNING, 'modalWarning');
			} else {
				var pos = getSelectedRows($("bodyAddRepQry"))[0].rowIndex;
				var row = upRow(parseInt(pos),"bodyAddRepQry");
				if (row && Scroller_bodyAddReport != null && Scroller_bodyAddReport.v != null){
					Scroller_bodyAddReport.v.showElement(row);
				}
			}		
		});
	}
	
	var btnDownReportQuery = $('btnDownRepQry');
	if (btnDownReportQuery){
		btnDownReportQuery.addEvent("click", function(e) {
			e.stop();
			if(selectionCount($("bodyAddRepQry")) == 0) {
				showMessage(GNR_CHK_AT_LEAST_ONE, GNR_TIT_WARNING, 'modalWarning');
			} else {
				var pos = getSelectedRows($("bodyAddRepQry"))[0].rowIndex;
				var row = downRow(parseInt(pos),"bodyAddRepQry");
				if (row && Scroller_bodyAddReport != null && Scroller_bodyAddReport.v != null){
					Scroller_bodyAddReport.v.showElement(row);
				}
			}
		});
	}
	
	/*
	 * Variables usadas para modificar dinamicamente columnas requeridas en tab Acciones
	 */
//	actionColsRequired = [
//        	requiereActVieEntCol, requiereActVieProCol, requiereActVieTasCol,	
//        	requiereActWorEntCol, requiereActWorTasCol,	requiereActAcqTasCol,
//        	requiereActComTasCol
//      ]
//  	actionColsCmbs = [
//  		$("chkActVieEnt"), $("chkActViePro"), $("chkActViwTas"),
//  		$("chkActWorEnt"), $("chkActWorTas"), $("chkActAcqTas"),
//  		$("chkActComTas") 
//  	]
//	requieredEntAttCols = requieredEntAttCols.map(function(ele){return ele.toLowerCase();})
//	requieredProAttCols = requieredProAttCols.map(function(ele){return ele.toLowerCase();})
}

function chkAddRpQry_click() {
	var status = $("chkAddRpQry").checked?'visible':'hidden';
	$("btnUpRepQry").style.visibility = status;
	$("btnDownRepQry").style.visibility = status;
	$("btnDeleteRepQry").style.visibility = status;
	$("btnAddRepQry").style.visibility = status;
}

function processModalReturnReportQuery(ret){
	var trows = $('bodyAddRepQry').rows;
	var count = 0;
	ret.each(function(e){
		var addRet = true;	
		var text = e.getRowContent()[0];
		var id = e.getRowId();
		for (i=0;i<trows.length && addRet;i++) {
			if (trows[i].getElementsByTagName("TD")[0].getElementsByTagName("INPUT")[0].value == text) {
				addRet = false;
			}
		}
		if (addRet) {
			
			var arrayTd = new Array();
			var arrayCell = new Array();
		
			var aux = {'type':'span', html:text};
			arrayCell.push(aux);
			aux = {'type':'hidden', name:'qryRepName',value:text};
			arrayCell.push(aux);
			aux = {'type':'hidden', name:'qryRepId', value:id};
			arrayCell.push(aux);
			
			arrayTd.push({'display':'','type':'td',arr:arrayCell});	
			
			arrayCell = new Array();
			var arrayOptions = new Array();
			arrayOptions.push({'value':'C', text:SEL_OPT_CHOSE_DWN, 'selected':true});
			arrayOptions.push({'value':'X', text:SEL_OPT_DWN_EXCEL, 'selected':false});
			arrayOptions.push({'value':'P', text:SEL_OPT_DWN_PDF, 'selected':false});
			arrayOptions.push({'value':'H', text:SEL_OPT_DWN_HTML, 'selected':false});
			
			aux = {'type':'combo', name:'selDwnRepOpt', id:'selDwnRepOpt', 'required':false, 'options':arrayOptions};
			arrayCell.push(aux);
			
			arrayTd.push({'display':'','type':'td',arr:arrayCell});	
			addRowQueryActionRpt($('bodyAddRepQry'),arrayTd);					
		}			
	});	
}

function loadReportAction(){
	var request = new Request({
		method: 'post',
		url: CONTEXT + URL_REQUEST_AJAX + '?action=loadQueryReports&isAjax=true' + TAB_ID_REQUEST,	
		onRequest: function() { SYS_PANELS.showLoading(); },
		onComplete: function(resText, resXml) { 
			modalProcessXml(resXml); SYS_PANELS.closeAll();
			
			var table = $('bodyAddRepQry');
			var footer = table.getParent('.fieldGroup').getElements('.listAddDel')[0];
			var notification = new Element('div', {id : 'editionNot'}); 
			footer.grab(notification, "top");
			initAdminModalHandlerOnChangeHighlight(table, true, false, notification);
		}
	}).send();
}

function processLoadQueryReport(){
	var resXml = getLastFunctionAjaxCall(); 
	var tableDOM = resXml.getElementsByTagName("table");
	if (tableDOM!=null){
		var rows = tableDOM.item(0).getElementsByTagName("row");
		var arrayRow = new Array();
		for (var i=0;i<rows.length;i++){
			var row = rows.item(i);
			var displayRow = toBoolean(row.getAttribute("display"));
			var arrayTd = new Array();
			var cells = row.getElementsByTagName("cell");
			var k = 0;			
			while (k < cells.length){		
				var cell = cells.item(k);
				var type = cell.getAttribute("type");
				var tdDisplay = cell.getAttribute("display");
				lCount = 0;	
				
				auxTd = processTd(cell);
				arrayTd.push({'display':tdDisplay,'type':'td',arr:auxTd});				
							
				k +=lCount;
				k++;
			}
			addRowQueryActionRpt($('bodyAddRepQry'),arrayTd);			
		}		
	}
}

function addRowQueryActionRpt(table,arrTable){
	var parent = table.getParent();
	table.selectOnlyOne = false;
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

	var rowDOM = new Element('tr');
	for (var j=0;j<arrTable.length;j++){
		var td = arrTable[j];
		var div = new Element('div',{styles:{'width':tdWidths[j]}});
		d = addRowQueryActionTdRp(td,div);
			
		var tdDOM = new Element('td',{styles:{'display':td.display}});
		d.inject(tdDOM);
		if (j==1) tdDOM.setAttribute("align","center");
		tdDOM.inject(rowDOM);				
	}
	
	rowDOM.addClass("selectableTR");
	rowDOM.addEvent("click",function(e){myToggle(this)});
	rowDOM.getRowId = function () { return this.getAttribute("rowId"); };
	rowDOM.setRowId = function (a) { this.setAttribute("rowId",a); };
	rowDOM.setAttribute("rowId", table.rows.length);
	
	if(table.rows.length%2==0){
		rowDOM.addClass("trOdd");
	}
	
	rowDOM.inject(table);	
	
	Scroller_bodyAddReport = addScrollTable(table);
}

function addRowQueryActionTdRp(temp,div){
	var td = temp.arr;
	for (var i=0;i<td.length;i++){
		var aux = td[i];
		if (aux.type=="span"){
			domElement = new Element('span',{html:aux.html});
		} else if (aux.type=="hidden"){
			domElement = new Element('input',{type:'hidden',name:aux.name,id:aux.name});
			domElement.setAttribute("value",aux.value);
		} else if (aux.type == "combo") {
			domElement = new Element('select', {name:aux.id, id:aux.id});
			var options = aux.options;
			var option;
			for (i = 0; i < options.length; i++) {
				option = new Element('option', {value:options[i].value, text:options[i].text, selected:options[i].selected});
				domElement.add(option);
			}
		}
		domElement.inject(div);		
		severalProperties(domElement,aux);
	}
	return div;
}

//function checkActionColumnsRequired(){
//	if (!actionColsRequired || !actionColsCmbs) return;
//	
//	var existsEntAtt=false, 
//		existsProAtt=false;
//
//	var attCmbs = $('tblShows').getElements('#cmbShoAttFrom');
//	if (attCmbs){
//		for(var i=0; i<attCmbs.length; i++){
//			if (attCmbs[i].getAttribute('data-isAttribute')!='true') continue;
//			
//			existsEntAtt = existsEntAtt || attCmbs[i].value=="1";
//			existsProAtt = existsProAtt || attCmbs[i].value=="0";
//		}
//	}
//	
//	if (!existsEntAtt && !existsProAtt){
//		var currentColsRequired = actionColsRequired;	
//	} else {
//		//Se actualizan requeridas
//		var currentColsRequired = actionColsRequired.clone();
//		
//		for(var i=0; i<currentColsRequired.length; i++){			
//			if (existsEntAtt)
//				requieredEntAttCols.each(function(r){ currentColsRequired[i].erase(r); })
//			if (existsProAtt)
//				requieredProAttCols.each(function(r){ currentColsRequired[i].erase(r); })
//		}
//	} 
//	
//	for(var i=0; i<actionColsCmbs.length; i++){
//		var lbl = actionColsCmbs[i].nextElementSibling;
//		var colsRequired = currentColsRequired[i].join('\", \"');
//		lbl.textContent = lbl.textContent.replace(/[(](.*)[)]/, '(\"'+colsRequired+'\")'); 
//	}
//	
//	requiereActVieEntCol=currentColsRequired[0];
//	requiereActVieProCol=currentColsRequired[1]; 
//	requiereActVieTasCol=currentColsRequired[2];	
//  	requiereActWorEntCol=currentColsRequired[3]; 
//  	requiereActWorTasCol=currentColsRequired[4];	
//  	requiereActAcqTasCol=currentColsRequired[5];
//  	requiereActComTasCol=currentColsRequired[6];
//}