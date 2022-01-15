var indexError = 0;
var firstTime= true;
var portalFormTemplate = true;
var frmCheckerDisplay = {
	addClassErrorToField : 1,
	errorsLocation : 3,	
	listErrorsAtTop : true, 
	indicateErrors : 2, 
	scrollToFirst : false, 
	showErrors: 0 
}
var oldErrorList = [];
var removeBoxError = true; //marca si hay que borrar el modal con que contiene "siguiente" y "anterior" 

//modal con "siguiente" y "anterior" error
var errorModal = new Element('div').set('id','box-error').set('class', 'box-error').set('html','<span class="box-error-title">Error 2 de 2</span>'+
		'<ul><li><a style="cursor: pointer;" class="floatIzq" href="#" onclick="showError(this,\'prev\');return false;">&lt;&lt; ' + BTN_ANTERIOR +'</a>'+
		'</li><li>	<a style="cursor: pointer;" class="floatDer" href="#" onclick="showError(this,\'next\');return false;">'+ BTN_SIGUIENTE + ' &gt;&gt;</a>'+
		'</li></ul>');

function setErrorModalMsg(modal,msg){
	var span = modal.getElementsByTagName("span");
	span = span[0].innerHTML = msg;
}

window.addEvent('load', function() {	
	//re design captcha
	$$('div.captcha-container').each(function (item){
		item.getParent().getParent().set('style','height: 100px;');
		$$(item.getParent().getElementsByTagName('input')).each(function (itemInput){
			itemInput.addClass('captchaInput');
			});
	});
//	$$('div.wasTr div.wasTd div.exec_field.monitor_field').each(function (captcha){
//		captcha.set('style', 'height: 130px;');		
//	}); 
	
	//render radio buttons
	var list = null;
	if(divsInsteadOfTable){
		list = $$(".wasTd>div>label")
	} else{
		list = $$("td>div>label")
	}
	list.each(function(item){
		if (item.hasClass('optionLabel')) 
			item.set('style','color:black;');
	});

	//render Documents	
	$$(".asLabelFileinput").each(function(item){
		var parent = item.getParent();
//		parent.getParent().set('style', 'padding-bottom: 20px!important');
		var divWasTd = parent;
		while (!divWasTd.getParent().hasClass('wasTr')){
			divWasTd = divWasTd.getParent();
		}
		if (!divWasTd.hasClass('wasTd')){
			divWasTd.addClass('wasTd');
		}
	});
	$$('.document').filter(function(item){
		return !item.hasClass('grid_document')
	}).each(function(item) {
		item.addClass('no_grid_document');	
	});
	
	//render textAreas
	var listOfTextArea = $$(document.getElementsByTagName('textarea'));
	for(var iter = 0; iter < listOfTextArea.length; iter++){
		var div = listOfTextArea[iter].getParent();
		var td = listOfTextArea[iter].getParent().getParent();
		if ((div != undefined) && (td != undefined) && (td.hasClass('wasTd') || td.get('tag')=='td') && (div.get('tag')=='div')){
			listOfTextArea[iter] = listOfTextArea[iter].set('style', 'width: 30%');
			var span = div.getElementsByTagName('span');
			span[0].set('style','vertical-align: top;');
			
		}
	}
	
	//render grids titles
	var listOfGrids = $$(document.getElementsByClassName('gridContainer'));
	for (var iter = 0; iter < listOfGrids.length; iter++) {
		let item = listOfGrids[iter]
		if (item !== undefined && item.style.display != 'none'){
			try {
				//Definicion de variables
				let obj      = null; //temporal
				let objArray = null; //temporal arreglo
				let titles   = [];   //Arreglo de titulos inicializado para utilizar push
				obj = item.getElementsByClassName('gridHeader')[0];
				obj = bajar(obj, 3);
				objArray = obj.children; //Lista de th columnas
				//Obtiene titulos
				for (let j = 0; j < objArray.length; j++) {
					titles.push(bajar(objArray[j], 1).title);
				}
				obj = item.getElementsByClassName('gridBody')[0];
				obj = bajar(obj, 2);
				objArray = obj.children; //Lista de tr filas
				for(let j = 0; j < objArray.length; j++) {
					let fila = objArray[j];
					let columnas = fila.children;
					for(let k = 0; k < columnas.length; k++) {
						bajar(columnas[k], 2).title = titles[k];
					}
				}
			} catch(err) {}
		}
	}
	
	//prepare checkbox style
	var listOfCheckbox = $$("input[type=checkbox]");
	for (var iter = 0; iter < listOfCheckbox.length; iter++){
		if (listOfCheckbox[iter] !== undefined){
			var label = listOfCheckbox[iter].getParent();
			$$(label.getElementsByTagName('span')).set('class','asLabel');
		}
	}
	
	if(typeof divsInsteadOfTable == 'undefined'){
		//clean and render forms
		var forms = $$('div.formContainer');
		for(let i = 0; i < forms.length; i++){
			var table = forms[i].getElementsByTagName('table');
	
			table = table[0].getChildren();
			if (table != null){
				removeFormColGroup(table);
				removeFormTHead(table);
				removeTdDivStyle(table);
			}
		}
	}
});

function removeFormColGroup(table){	
	var colgroup = table[0].getChildren();
	for(let i = 1; i < Array.from(colgroup).length; i++){
		colgroup[i].setAttribute("style","width: 0;");
	}
	colgroup[0].setAttribute("style","width: 90%;");
}
function removeFormTHead(table){
	var thead = table[1].getChildren();
	var tr = thead[0].getChildren();
	for(let i = 1; i < Array.from(tr).length; i++){
		tr[i].setAttribute("style","width: 0;");
	}
	tr[0].setAttribute("style","width: 90%;");
}
function removeTdDivStyle(table){
	var divs = table[2].getElementsByTagName("div");
	for (let i = 0; i < divs.length; i++ ){
		divs[i].style.removeProperty('width');
	}
}


function removeErrors(){
	var x = document.getElementsByClassName("fc-field-error");
	for (i = 0; i < x.length; i++) {
		
		var y = document.getElementsByClassName("err-num-" + i);
		for (j = 0; j < y.length; j++) {			
			y[j].removeClass("err-num-" + i);					 	
		}
						 	
	}	
	
	var x = document.getElementsByClassName("campo-error-perso");
	for (i = 0; i < x.length; i++) {
		x[i].removeClass("campo-error-perso");					 									 	
	}
	
}

//ir al error correspondiente luego de hacer click en la lista de errores en la 
//parte superior de la pantalla
function goToError(element){
	// create and set message
	var errorList = $('errorlist').getChildren();//error List as array
	var cantError = errorList.length - 1;
	var msg = insertParamsToTag(ERROR_NUMBER,[element.get('data-errornumber'), cantError]);
	setErrorModalMsg(errorModal,msg);
	
	var error = $$('.wasTd[data-ordernumber='+element.get('data-ordernumber') + '], td[data-ordernumber='+element.get('data-ordernumber') + ']');
	if(typeof divsInsteadOfTable === 'undefined'){
		error = $$('td[data-ordernumber='+element.get('data-ordernumber') + ']');
	}
	error = error[0];
	new Fx.Scroll(window).toElementCenter(error);
//  injectar el modal que tiene "siguiente" y "anterior" errores
	errorModal.inject(error);
	removeBoxError = false;
	$('box-error').set('style', 'display: block;')
}

//mError = modalError
function showError(mError, nextPrev){
	if($('errorlist')){
		var tdCurrentError = mError.getParent();
		while (!tdCurrentError.hasClass('wasTd') && tdCurrentError.get('tag') != ('td')){
			tdCurrentError = tdCurrentError.getParent();
		};
		
		//error List as array
		var errorList = $('errorlist').getChildren();
		
		//tail of errorList
		errorList = errorList.slice(1);
		var cantError = errorList.length;
		
		var currentErrorAtList = errorList.filter(function (errorItem){
			return (tdCurrentError.get('data-ordernumber') === errorItem.get('data-ordernumber'))
		});
		if (currentErrorAtList[0] == undefined){
			currentErrorAtList[0] = errorList[0];
		}
		var currentErrorAtListInt = parseInt(currentErrorAtList[0].get('data-errornumber'));
	
		if(nextPrev == "next"){
			currentErrorAtListInt++;
		}
		else currentErrorAtListInt--;
		
		//get new index
		//currentErrorAtList is in [1..cantError] newIndex is in [0..cantError-1]
		var newIndex = (currentErrorAtListInt - 1); 
		newIndex = (newIndex + cantError);		
		newIndex = newIndex % (cantError); 
		
		// go back to currentErrorAtList
		currentErrorAtListInt = newIndex+1;
		
		var errorToShow = errorList.filter(function (errorItem){ 
			var errorItemNumber = (parseInt(errorItem.get('data-errornumber')));
			return (errorItemNumber == currentErrorAtListInt); 
			});
		goToError(errorToShow[0]);
	} else {
		$('box-error').set('style', 'display: none;');
	}
}

function sortElementAtTopListError(){
	
	var errorNumber = 0;
	
	if($('errorlist')!=null){
		$('errorlist')
		.getChildren()
		.filter(function (item){
			return item.get('data-errorNumber')!= null			
		})
		.sort(function(a,b) {//custom compare function
			var aOrderNumber = parseInt(a.get('data-ordernumber'));
			var bOrderNumber = parseInt(b.get('data-ordernumber'));
			if (aOrderNumber > bOrderNumber) 
				return 1;
			else 
				return -1;
			})
		.each(function (item) {
			item.set('data-errorNumber', ++errorNumber);
			var errorDescription = item.getChildren()
				.filter(function (item){
					return item.hasClass("leftErrorSpan");	
				})
				.get('html')[0];
			
			errorDescription =  errorDescription.substring(errorDescription.indexOf("."));
			errorDescription = errorNumber + errorDescription;
			item.getChildren()
				.filter(function (item){
					return item.hasClass("leftErrorSpan")
					
				})
				.set('html', errorDescription);
	
			item.inject($('errorlist'));
			});
	}
}

//Este método debe ser ejecutado luego de que se cierre un modal en el que se 
//inicialicen los errores, con el objetivo de volver a dibujar los errores
function onClosePortalFormModal(){
	frmData.formChecker.isFormValid();
	errorModal.set('style','display: none;');
}
//Baja un numero fijo de veces por el primer hijo
function bajar(obj, num) {
    try{
      for(let i=0; i<num; i++){
          obj = obj.children[0];
      }
      return obj;
    }catch(err){
      return null; 
    }
}
