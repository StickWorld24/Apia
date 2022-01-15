<%@page import="com.dogma.Configuration"%>
<%@page import="biz.statum.sdk.util.HttpServletRequestResponse"%>
<%@page import="biz.statum.apia.web.bean.BasicBeanStatic"%>
<%@page import="biz.statum.sdk.util.StringUtil"%>
<%@ taglib uri='/WEB-INF/regions.tld' prefix='region' %>
<%@ taglib prefix="system"	uri="/WEB-INF/system-tags.tld" %>

<%
String template = "/page/templates/taskDefault.jsp";
if (StringUtil.notEmpty(request.getParameter("template"))){
	template = request.getParameter("template");
}
out.clear();
%>
<region:render template='<%=template%>'>
	<region:put section='title'>
		<div class="titImage">
			<img title="<system:label show="text" label="lblEjeTitPriPro2"/>" src="<system:util show="context" />/css/base/img/priority2.gif" alt="">
		</div>
		<div class='proTitle'><system:label show="text" label="lblTempTit" /></div>
	</region:put>
	
	<region:put section="tskDescription">
		<system:label show="text" label="lblTempDesc" />
	</region:put>
	
	<region:put section="taskImage">
		<img src="<system:util show="context" />/css/base/img/functionalities/Tareas.gif">			
	</region:put>

	<region:put section="apiaSocial">
		<system:edit show="ifParameter" field="APIASOCIAL_ACTIVE" value="true">
			<div id="divAdminActEdit" class="fncPanel buttons">
				<div id="apiaSocialShare" class="apiaSocialShare"></div>
				<div class="title"><system:label show='text' label='lblChnSoc'/></div>
				<div class="content" style="height: 200px;">
					<div id="apiaSocialExecPanel" class="apiaSocialExecPanel">
						<div id="apiaSocialNoMessages" class="apiaSocialNoMessages"><system:label show='text' label='msgNoMessages' forHtml='true'/></div>
					</div>
				</div>
			</div>											
		</system:edit>
	</region:put>

	<region:put section='entityMain'>
		<div class="fieldGroup">
			<div class="title"><system:label show="text" label="sbtEjeDatEnt" /></div>					
			<div class="field required">
				<label title="<system:label show="tooltip" label="lblEjeIdeEnt" />"><system:label show="text" label="lblEjeIdeEnt" />:</label>
				<b><system:label show="text" label="lblAutNum"/></b>
			</div>
			<div class="field">
				<label title="<system:label show="tooltip" label="lblEjeTipEnt" />"><system:label show="text" label="lblEjeTipEnt" /><system:label show="separator" label=""/></label>
				<b><system:label show="text" label="lblExample"/></b>
			</div>
		</div>
		<div class="fieldGroup">	
			<div class="field">
				<label title="<system:label show="tooltip" label="lblEjeUsuCreEnt" />"><system:label show="text" label="lblEjeUsuCreEnt" /><system:label show="separator" label=""/></label>
			</div>
			<div class="field">
				<label title="<system:label show="tooltip" label="lblEjeFecCreEnt" />"><system:label show="text" label="lblEjeFecCreEnt" /><system:label show="separator" label=""/></label>
			</div>		
		</div>
	</region:put>
	
	<region:put section='entityDocuments'>
		<div class="fieldGroup">
			<div class="title"><system:label show="text" label="sbtEjeDocEnt" /></div>	
			
			<div class="fieldGroup" id="docContentE">
				<div class="divAdder">
					<div class="modalOptionsContainer" id="prmDocumentContainterE">
						<div class="element docAddDocument" id="docAddDocumentE" data-helper="true">
							<div class="option optionAdd"><system:label show="text" label="btnAgr" /></div>
						</div>							
					</div>
				</div>
				<div class="clear"></div>
			</div>
	 	</div>
	</region:put>
	
	<region:put section='processMain'>
		<div class="fieldGroup">
			<div class="title"><system:label show="text" label="sbtEjeDatPro" /></div>	
					
			<div class="field required">
				<label title="<system:label show="tooltip" label="lblEjeIdePro" />"><system:label show="text" label="lblEjeIdePro" />:</label>
					<b><system:label show="text" label="lblAutNum"/></b>
			</div>
			
			<div class="field">
				<label title="<system:label show="tooltip" label="lblEjeNomPro" />"><system:label show="text" label="lblEjeNomPro" />:</label>
					<b><system:label show="text" label="lblExample"/></b>
			</div>
			
			<div class="field">
				<label title="<system:label show="tooltip" label="lblEjeAccPro" />"><system:label show="text" label="lblEjeAccPro" />:</label>
				<b><system:label show="text" label="lblAccProCre" /></b>
			</div>
			
			<div class="field required">
				<label title="<system:label show="tooltip" label="lblEjePriPro" />"><system:label show="text" label="lblEjePriPro" />:</label>
				<select name="cmbProPri">
					<option value="<%=com.dogma.vo.ProInstanceVo.PRO_PRIORITY_NORMAL%>" selected><system:label show="text" label="lblEjePriProNor" /></option>
					<option value="<%=com.dogma.vo.ProInstanceVo.PRO_PRIORITY_LOW%>"><system:label show="text" label="lblEjePriProBaj" /></option>
					<option value="<%=com.dogma.vo.ProInstanceVo.PRO_PRIORITY_HIGH%>"><system:label show="text" label="lblEjePriProAlt" /></option>
					<option value="<%=com.dogma.vo.ProInstanceVo.PRO_PRIORITY_URGENT%>"><system:label show="text" label="lblEjePriProUrg" /></option>			   					
				</select>
			</div>
			
		</div>
		<div class="fieldGroup">	
	
			<div class="field">
				<label title="<system:label show="tooltip" label="lblEjeUsuCrePro" />"><system:label show="text" label="lblEjeUsuCrePro" />:</label>
				<b></b>
			</div>
			
			<div class="field">
				<label title="<system:label show="tooltip" label="lblEjeStaPro" />"><system:label show="text" label="lblEjeStaPro" />:</label>
				<b></b>
			</div>
					
			<div class="field">
				<label title="<system:label show="tooltip" label="titCal" />"><system:label show="text" label="titCal" />:</label>
				<select id="selCal" name="selCal">
				
				</select>
				<button type='button' class='genericBtn' id="btnViewCal" title="<system:label show="tooltip" label="btnVer" />">
					<system:label show="text" label="btnVer" />
				</button>
			</div>			
		</div>	
	</region:put>
	
	<region:put section='processDocuments'>
		<div class="fieldGroup">
			<div class="title"><system:label show="text" label="sbtEjeDocPro" /></div>	
			<div class="fieldGroup" id="docContentP">
				<div class="divAdder">
					<div class="modalOptionsContainer" id="prmDocumentContainterP">
						<div class="element docAddDocument" id="docAddDocumentP" data-helper="true">
							<div class="option optionAdd"><system:label show="text" label="btnAgr" /></div>
						</div>							
					</div>
				</div>
				<div class="clear"></div>
			</div>		
		</div>
	</region:put>
	
	<region:put section='entityForms'>
		<div class="fieldGroup">
			<div class="title"><system:label show="text" label="tabEjeFor" /></div>
		
			<div class="field">
				<label title="<system:label show="tooltip" label="lblField" />&nbsp;1"><system:label show="text" label="lblField" />&nbsp;1:&nbsp;</label>
				<select class="readonly" value=""></select>
			</div>
			<div class="field">
				<label title="<system:label show="tooltip" label="lblField" />&nbsp;2"><system:label show="text" label="lblField" />&nbsp;2:&nbsp;</label>
				<input type="text" class="readonly" value="">
			</div>
		</div>										
	</region:put>
	
	
	<region:put section='processForms'>
		<div class="fieldGroup">
			<div class="title"><system:label show="text" label="tabEjeForPro" /></div>
		
			<div class="field">
				<label title="<system:label show="tooltip" label="lblField" />&nbsp;1"><system:label show="text" label="lblField" />&nbsp;1:&nbsp;</label>
				<select class="readonly" value=""></select>
			</div>
			<div class="field">
				<label title="<system:label show="tooltip" label="lblField" />&nbsp;2"><system:label show="text" label="lblField" />&nbsp;2:&nbsp;</label>
				<input type="text" class="readonly" value="">
			</div>
		</div>												
	</region:put>
	
	
	<region:put section='taskComments'>
		<div class="fieldGroup">
			<div class="title"><system:label show="text" label="sbtEjeObsAct" /></div>
			<div class="fieldCommentLeft">		
				<div class="field fieldComment">
					<label title="<system:label show="tooltip" label="lblEjeObs" />"><system:label show="text" label="lblEjeObs" />:</label>
					<textarea name="txtComment" ></textarea>
				</div>
			</div>
			<div class="fieldCommentRight">
				<div class="field">
					<label title="<system:label show="tooltip" label="lblEjeAgrMar" />"><system:label show="text" label="lblEjeAgrMar" />:</label>
					<input type=checkbox name=chkAddAlert>
				</div>
				<div class="field">
					<label title="<system:label show="tooltip" label="lblEjeAgrMarTod" />"><system:label show="text" label="lblEjeAgrMarTod" />:</label>
					<input type=checkbox id=chkAddAllAlert name=chkAddAllAlert>
				</div>
				<div class="field">
					<label title="<system:label show="tooltip" label="lblEjeEliMar" />"><system:label show="text" label="lblEjeEliMar" />:</label>
					<input type=checkbox id=chkRemAlert name=chkRemAlert>
				</div>
			</div>
		</div>	
	</region:put>
	
	<region:put section='taskMonitor'>
		<div class="gridContainer">	
			<div class="gridHeader">
				<table>
					<thead>
						<tr class="header">
							<th width="200px" title="<system:label show="tooltip" label="lblMonTskPro" />"><div style="width: 200px"><system:label show="text" label="lblMonTskPro" /></div></th>
							<th width="200px" title="<system:label show="tooltip" label="lblMonPoolNom" />"><div style="width: 100px"><system:label show="text" label="lblMonPoolNom" /></div></th>
							<th width="100px" title="<system:label show="tooltip" label="lblMonProEleInstSta" />"><div style="width: 100px"><system:label show="text" label="lblMonProEleInstSta" /></div></th>
							<th width="150px" title="<system:label show="tooltip" label="lblMonProEleInstDatRea" />"><div style="width: 150px"><system:label show="text" label="lblMonProEleInstDatRea" /></div></th>
							<th width="150px" title="<system:label show="tooltip" label="lblMonProEleInstDatEnd" />"><div style="width: 150px"><system:label show="text" label="lblMonProEleInstDatEnd" /></div></th>
							<th width="100px" title="<system:label show="tooltip" label="lblMonUsrLog" />"><div style="width: 100px"><system:label show="text" label="lblMonUsrLog" /></div></th>
						</tr>					
					</thead>
				</table>
			</div>
			<div class="gridBody" id="gridBodyFormEnt">
				<!-- Cuerpo de la tabla -->
				<table>			
					<thead>					
						<tr>
							<th width="200px"></th>
							<th width="200px"></th>	
							<th width="100px"></th>
							<th width="150px"></th>
							<th width="150px"></th>
							<th width="100px"></th>						
						</tr>								
					</thead>
					<tbody class="tableData" id="tableDataFormEnt">
						
			   		</tbody>
				</table>
			</div>
		</div>
	</region:put>
	
	<region:put section='scripts_include'>
		<script type="text/javascript">
			function initPage(){}
		</script>
		
		<link href="<system:util show="context" />/css/base/modules/schedulerExec.css" rel="stylesheet" type="text/css" >
		
	</region:put>
	
	<region:put section='buttons'>
		<div id="divAdminActEdit" class="fncPanel buttons">
			<div class="title"><system:label show='text' label='titActions'/></div>
			<div class="content">
				<div id="btnConf" class="button submit suggestedAction" title="<system:label show="tooltip" label="btnCon" />"><system:label show="text" label="btnCon" /></div>
				<div id="btnSave" class="button" title="<system:label show="tooltip" label="btnGua"/>"><system:label show="text" label="btnGua"/></div>
			</div>
		</div>
	</region:put>		
	
	<region:put section="helpDocuments">
		<div class="title"><system:label show="text" label="mnuOpc"/></div>
		<div class="content">
			<div id="btnViewDocs" class="button" title="<system:label show="tooltip" label="sbtEjeDoc" />"><system:label show="text" label="sbtEjeDoc" /></div>
			<div id="btnPrintFrm" class="button" title="<system:label show="tooltip" label="btnStaPri" />"><system:label show="text" label="btnStaPri" /></div>
		</div>
	</region:put>	
</region:render>
	
