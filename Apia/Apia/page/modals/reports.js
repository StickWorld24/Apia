var REPORTMODAL_HIDE_OVERFLOW	= true;
var SHOW_ONLY_PENTAHO_TYPE = true;

function initReportMdlPage(){
	var mdlReportsContainer = $('mdlReportsContainer');
	if (mdlReportsContainer.initDone) return;
	mdlReportsContainer.initDone = true;
	
	mdlReportsContainer.blockerModal = new Mask();
	
	['orderByNameReportMdl','orderByDescReportMdl'].each(function(ele){
		ele = $(ele);
		ele.set('title', GNR_ORDER_BY + ele.get("title"))
	});
	
	['nameFilterReportsMdl','descFilterReportsMdl'].each(function(ele) {
		ele = $(ele);
		ele.setFilterReport = setFilterReport;
		ele.oldValue = ele.value;
		ele.addEvent("keyup", function(e) {
			if (this.oldValue == this.value) return;
			if (this.timmer) $clear(this.timmer);
			this.oldValue = this.value;
			this.timmer = this.setFilterReport.delay(200, this);
			
		});		
	});
	
	$('closeModalReport').addEvent("click", function(e) {
		if(e) e.stop();
		closeReportsModal();
	}).addEvent('keypress', Generic.enterKeyToClickListener);
	
	$('clearFiltersReport').addEvent("click", function(e) {
		if(e) e.stop();
		['nameFilterReportsMdl'].each(clearFilter);
		$('descFilterReportsMdl').value="";
		
		$('nameFilterReportsMdl').setFilterReport();
	}).addEvent('keypress', Generic.enterKeyToClickListener);
	
	var confirmModalReport = $('confirmModalReport').addEvent("click", function(e) {
		var mdlReportsContainer = $('mdlReportsContainer');
		if (mdlReportsContainer.onModalConfirm) jsCaller(mdlReportsContainer.onModalConfirm,getSelectedRows($('tableDataReport')));
		closeReportsModal();
	}).addEvent('keypress', Generic.enterKeyToClickListener).addEvent('keydown', function(e) {
		if(!e.shift && e.key == 'tab') {
			e.preventDefault();
			mdlReportsContainer.focus();
		}
	});
	
	mdlReportsContainer.addEvent('keydown', function(e) {
		
		if(e.target == mdlReportsContainer && e.shift && e.key == 'tab') {
			e.preventDefault();
			mdlReportsContainer.focus();
		}
	});
	
	//Evento doble-click con misma funcionalidad que boton confirmar
	$('tableDataReport').getParent().addEvent("dblclick", function(e) {
		if (mdlReportsContainer.onModalConfirm) jsCaller(mdlReportsContainer.onModalConfirm,getSelectedRows($('tableDataReport')));
		closeReportsModal();
	});
	
	//eventos para order
	['orderByNameReportMdl','orderByDescReportMdl'].each(function(ele){
		$(ele).addEvent("click", function(e) {
			e.stop();
			callNavigateOrder(this.getAttribute('data-sortBy'),this,'/apia.modals.ReportsAction.run', 'Report');
		});
	});
	
	window.sp_Pool = new Spinner($('tableDataReport').getParent('table'), {message: WAIT_A_SECOND});
	window.sp_Pool.content.getParent().addClass('mdlSpinner');
	
	initNavButtons('/apia.modals.ReportsAction.run','Report');
}



//establecer un filtro
function setFilterReport(){
	SHOW_ONLY_PENTAHO_TYPE = false;
	callNavigateFilter({
		txtName: $('nameFilterReportsMdl').value,
		txtDesc: $('descFilterReportsMdl').value,
		txtShow: SHOW_ONLY_PENTAHO_TYPE
	},null,'/apia.modals.ReportsAction.run', 'Report');
}

//establecer el orden
function setOrderByClass(obj){
	obj.toggleClass("orderedBy");
	if(obj.hasClass("unsorted")){
		obj.removeClass("unsorted")
		obj.addClass("sortUp");
	} else {
		if(obj.hasClass("sortUp")){
			obj.removeClass("sortUp")
			obj.addClass("sortDown");
		}else{
			obj.addClass("sortUp")
			obj.removeClass("sortDown");
		}
	}
}

function removeOrderByClass(obj){
	$('reportsTrOrderBy').getElements(".orderedBy").each(function(item, index){
	    item.removeClass("orderedBy");
	});
	
	$('reportsTrOrderBy').getElements(".sortUp").each(function(item, index){
		if(obj!=item){
			item.removeClass("sortUp");
			item.addClass("unsorted");
		}
	});
	
	$('reportsTrOrderBy').getElements(".sortDown").each(function(item, index){
		if(obj!=item){
			item.removeClass("sortDown");
			item.addClass("unsorted");
		}
	});
}

function showReportsModal(retFunction, closeFunction){
	
	if(REPORTMODAL_HIDE_OVERFLOW) {
		$(document.body).setStyle('overflow', 'hidden');
	}
	
	setFilterReport();
	unSelectAllRows($('tableDataReport'));

	var mdlReportContainer = $('mdlReportsContainer');
	mdlReportContainer.removeClass('hiddenModal');
	mdlReportContainer.position();
	mdlReportContainer.blockerModal.show();
	mdlReportContainer.blockerModal.element.setStyle('zIndex', SYS_PANELS.getNewZIndex());
	mdlReportContainer.setStyle('zIndex', SYS_PANELS.getNewZIndex());
	mdlReportContainer.onModalConfirm = retFunction;
	mdlReportContainer.onModalClose = closeFunction;
	
//	mdlReportContainer.focus();
}

function closeReportsModal(){
	var mdlReportContainer = $('mdlReportsContainer');
	
	if(Browser.chrome || Browser.firefox || Browser.safari) {
		var morph = new Fx.Morph(mdlReportContainer, {duration: 200, wait: false});
		
		morph.start({
			'margin-top': '-10px',
			'opacity': 0
		}).chain(function() {
			
			mdlReportContainer.addClass('hiddenModal');
			mdlReportContainer.setStyles({
				'opacity': 1,
				'margin-top': ''
			}); //Limpiar la transicion
						
			mdlReportContainer.blockerModal.hide();
			if (mdlReportContainer.onModalClose) mdlReportContainer.onModalClose();
			
			if(REPORTMODAL_HIDE_OVERFLOW) {
				$(document.body).setStyle('overflow', '');
			}
		});
	} else {
		
		mdlReportContainer.addClass('hiddenModal');
		
		mdlReportContainer.blockerModal.hide();
		if (mdlReportContainer.onModalClose) mdlReportContainer.onModalClose();
		
		if(REPORTMODAL_HIDE_OVERFLOW) {
			$(document.body).setStyle('overflow', '');
		}
	}
}