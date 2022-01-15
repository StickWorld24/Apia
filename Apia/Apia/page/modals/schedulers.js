var SCHMODAL_HIDE_OVERFLOW	= true;

function initSchedulersMdlPage(){
	var mdlSchContainer = $('mdlSchContainer');
	if (mdlSchContainer.initDone) return;
	mdlSchContainer.initDone = true;

	mdlSchContainer.blockerModal = new Mask();
	
	['orderByNameSchMdl','orderByBusClaSchMdl'].each(function(ele){
		ele = $(ele);
		ele.set('title', GNR_ORDER_BY + ele.getAttribute("title"))
	});
	
	['nameFilterSchMdl', 'busClaFilterSchMdl'].each(function(ele) {
		ele = $(ele);
		ele.setFilterSch = setFilterSch;
		ele.oldValue = ele.value;
		ele.addEvent("keyup", function(e) {
			if (this.oldValue == this.value) return;
			if (this.timmer) $clear(this.timmer);
			this.oldValue = this.value;
			this.timmer = this.setFilterSch.delay(200, this);
			
		});		
	});
	
	$('closeModalSch').addEvent("click", function(e) {
		e.stop();
		closeSchModal();
	});
	
	$('clearFiltersSch').addEvent("click", function(e) {
		e.stop();
		['nameFilterSchMdl'].each(clearFilter);
		$('nameFilterSchkMdl').setFilterSch();
	});
	
 
	$('confirmModalSch').addEvent("click", function(e) {
		var mdlSchContainer = $('mdlSchContainer');
		if (mdlSchContainer.onModalConfirm) jsCaller(mdlSchContainer.onModalConfirm,getSelectedRows($('tableDataSch')));
		closeSchModal();
	});
	
	//Evento doble-click con misma funcionalidad que boton confirmar
	$('tableDataSch').getParent().addEvent("dblclick", function(e) {
		if (mdlSchContainer.onModalConfirm) jsCaller(mdlSchContainer.onModalConfirm,getSelectedRows($('tableDataSch')));
		closeSchModal();
	});
	
	//eventos para order
	['orderByNameSchMdl', 'orderByBusClaSchMdl'].each(function(ele){
		$(ele).addEvent("click", function(e) {
			e.stop();
			currentPrefix = 'Sch';
			callNavigateOrder(this.getAttribute('data-sortBy'),this,'/apia.modals.SchedulersAction.run','Sch');
		});
	});
	
	window.sp_Sch = new Spinner($('tableDataSch').getParent('table'), {message: WAIT_A_SECOND});
	window.sp_Sch.content.getParent().addClass('mdlSpinner');
	
	initNavButtons('/apia.modals.SchedulersAction.run','Sch');
}

var SCHMODAL_SELECTONLYONE	= false;
var SCHMODAL_ADT_SQL = '';

//establecer un filtro
function setFilterSch(){
	callNavigateFilter({
		txtSchName: $('nameFilterSchMdl').value,
		txtBusClass: $('busClaFilterSchMdl').value,
		selectOnlyOne: SCHMODAL_SELECTONLYONE,
		txtAdtSql: SCHMODAL_ADT_SQL
	},null,'/apia.modals.SchedulersAction.run','Sch');
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
	$('schTrOrderBy').getElements(".orderedBy").each(function(item, index){
	    item.removeClass("orderedBy");
	});
	
	$('schTrOrderBy').getElements(".sortUp").each(function(item, index){
		if(obj!=item){
			item.removeClass("sortUp");
			item.addClass("unsorted");
		}
	});
	
	$('schTrOrderBy').getElements(".sortDown").each(function(item, index){
		if(obj!=item){
			item.removeClass("sortDown");
			item.addClass("unsorted");
		}
	});
	
}

var returnFunction;
var blocker;

function showSchModal(retFunction, closeFunction){
	
	if(SCHMODAL_HIDE_OVERFLOW) {
		$(document.body).setStyle('overflow', 'hidden');
	}
	
	setFilterSch();
	unSelectAllRows($('tableDataSch'));
	
	var mdlSchContainer = $('mdlSchContainer');
	mdlSchContainer.removeClass('hiddenModal');
	mdlSchContainer.position();
	mdlSchContainer.blockerModal.show();
	mdlSchContainer.setStyle('zIndex',SYS_PANELS.getNewZIndex());
	mdlSchContainer.onModalConfirm = retFunction;
	mdlSchContainer.onModalClose = closeFunction;
}

function closeSchModal(){
	var mdlSchContainer = $('mdlSchContainer');
	
	if(Browser.chrome || Browser.firefox || Browser.safari) {
		var morph = new Fx.Morph(mdlSchContainer, {duration: 200, wait: false});
		
		morph.start({
			'margin-top': '-10px',
			'opacity': 0
		}).chain(function() {
			
			mdlSchContainer.addClass('hiddenModal');
			mdlSchContainer.setStyles({
				'opacity': 1,
				'margin-top': ''
			}); //Limpiar la transicion
						
			mdlSchContainer.blockerModal.hide();
			if (mdlSchContainer.onModalClose) mdlSchContainer.onModalClose();
			
			if(SCHMODAL_HIDE_OVERFLOW) {
				$(document.body).setStyle('overflow', '');
			}
		});
	} else {
		
		mdlSchContainer.addClass('hiddenModal');
		
		mdlSchContainer.blockerModal.hide();
		if (mdlSchContainer.onModalClose) mdlSchContainer.onModalClose();
		
		if(SCHMODAL_HIDE_OVERFLOW) {
			$(document.body).setStyle('overflow', '');
		}
	}
}
