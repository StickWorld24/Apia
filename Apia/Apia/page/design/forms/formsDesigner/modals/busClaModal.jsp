<%@include file="../../../../includes/startInc.jsp" %><html style="overflow: hidden;"><head><%@include file="../../../../includes/headInclude.jsp" %><script type="text/javascript" src="<system:util show="context" />/page/design/forms/formsDesigner/properties.js"></script><script type="text/javascript" src="<system:util show="context" />/page/design/forms/formsDesigner/modals/busClaModal.js"></script><script type="text/javascript" src="<system:util show="context" />/js/autocomplete/autocompleter.js"></script><script type="text/javascript" src="<system:util show="context" />/js/autocomplete/autocompleter.request.js"></script><script type="text/javascript" src="<system:util show="context" />/js/autocomplete/observer.js"></script><link href="<system:util show="context" />/page/design/forms/formsDesigner/designer.css" rel="stylesheet" type="text/css" ><%
boolean isFormProp = "true".equals(request.getParameter("isFormProp"));
String evtLabel = request.getParameter("evtLabel");
%><script type="text/javascript">
	var URL_REQUEST_AJAX = '/apia.design.FormsAction.run';
	var ATTRIBUTES_MODAL= '<system:util show="context"/>/page/design/forms/formsDesigner/modals/attModal.jsp';
	var CONDITION_MODAL= '<system:util show="context"/>/page/design/forms/formsDesigner/modals/busClaCondModal.jsp';
	var ADDITIONAL_INFO_IN_TABLE_DATA = false;
	var IS_FORM_PROP = toBoolean('<%= request.getParameter("isFormProp") %>');
	
	var LBL_CLOSE = '<system:label show="text" label="lblCloseWindow" forScript="true" />';
	var LBL_YES	 = '<system:label show="text" label="lblYes" forScript="true" />';
	var LBL_NO	 = '<system:label show="text" label="lblNo" forScript="true" />';
	var LBL_UP 	 = '<system:label show="text" label="btnUp" forScript="true" />';
	var LBL_DOWN = '<system:label show="text" label="btnDown" forScript="true" />';
	var LBL_ADD	 = '<system:label show="text" label="btnAgr" forScript="true" />';
	var LBL_DEL	 = '<system:label show="text" label="btnDel" forScript="true" />';
</script></head><body><div class="body" id="bodyDiv" style="padding: 0 10px 0 10px; overflow: hidden; "><div style="width:100%;height:100%;float:left"><div class="fieldGroup" style="height: inherit;position: relative;"><div class="title"><system:label show="text" label="flaEvtForBusCla" /><%= evtLabel %></div><div class="gridContainer mdlTableContainer"><div class="bus-cla-actions"><div style="width:300px;float: left;position:relative;"><input id="busClaInputSearch" style="width:100%;height: 20px;padding: 2px 25px 2px 0px;box-sizing: border-box;"/><div id="busClaIconSearch" class="autocomplete-search"></div><input id="busClaSearchId" style="display:none;" /></div><div class="bus-cla-action-icons"><div id="btnAddBC" data-disabled="true" class="icon-container icon-container-right"><div class="icon-item add-icon"></div></div><div id="btnRemoveBC" class="icon-container icon-container-right"><div class="icon-item remove-icon"></div></div><div id="btnUpBC" class="icon-container icon-container-right"><div class="icon-item up-icon"></div></div><div id="btnDownBC" class="icon-container icon-container-right"><div class="icon-item down-icon"></div></div></div></div><div style="position: relative;height: 45%;margin-bottom:15px;"><div id="paramGridHeader" class="gridHeader" style="position: absolute;width: 100%;"><table><thead><tr class="header"><% if (isFormProp){ %><th width="70%"><system:label show="text" label="lblNom" /></th><th width="30%"><system:label show="text" label="flaProCnd" /></th><% } else { %><th width="60%"><system:label show="text" label="lblNom" /></th><th width="20%"><system:label show="text" label="flaProCnd" /></th><th width="20%">AJAX</th><% } %></tr></thead></table></div><div class="gridContainerWithFilter" style="padding:24px 0px 1px !important;"><div class="gridBody" style="height:100%; border-bottom: 1px solid #DDDDDD;"><table><thead><tr><% if (isFormProp){ %><th width="70%"></th><th width="30%"></th><% } else { %><th width="60%"></th><th width="20%"></th><th width="20%"></th><% } %></tr></thead><tbody class="tableData" id="tableDataBC"></tbody></table></div></div></div><div style="position: relative;height: 40%;"><div id="paramGridHeader" class="gridHeader" style="position: absolute;width: 100%;"><table><thead><tr class="header"><th width="10%"><system:label show="text" label="lblInOut" /></th><th width="10%"><system:label show="text" label="flaProTyp" /></th><th width="20%"><system:label show="text" label="flaProPar" /></th><th width="25%"><system:label show="text" label="lblDesc" /></th><th width="15%"><system:label show="text" label="flaValType" /></th><th width="20%"><system:label show="text" label="flaVal" /></th></tr></thead></table></div><div class="gridContainerWithFilter" style="padding:24px 0px 1px !important;"><div class="gridBody" style="height:100%; border-bottom: 1px solid #DDDDDD;"><table style="table-layout:fixed;"><thead><tr><th class="hidden-th" width="10%"></th><th class="hidden-th" width="10%"></th><th class="hidden-th" width="20%"></th><th class="hidden-th" width="25%"></th><th class="hidden-th" width="15%"></th><th class="hidden-th" width="20%"></th></tr></thead><tbody class="tableData" id="tableDataBCParams"></tbody></table></div></div></div></div></div></div></div></body>

