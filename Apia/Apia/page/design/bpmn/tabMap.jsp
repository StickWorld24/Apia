<%@page import="com.dogma.Parameters"%>
<%
	String tabId = "&tabId=" + request.getParameter("tabId") + "&tokenId=" + uData.getTokenId();
%>
<script>
	window.addEvent("domready", function() {
		$("tabMap").addEvent("click", function() {
			$("aMapTab").setStyle("height", "100%");
		}).addEvent("custom_blur", function() {
			$("aMapTab").setStyle("height", "auto");
		});
	});
</script>
<div class="aTab" id="aMapTab">
	<div class="tab" id="tabMap"><system:label show="text" label="tabProMap" /></div>
		<div class="contentTab" id="contentTabMap" style="height: 100%;" >
			<div id="pDesignerContainer" style="width: 100%; height: 100%;">
				
				<!-- INICIO: PROCESOS BPMN -->
				<system:edit show="ifValue" from="theEdition" field="isBpmn" value="1">
					
					<!-- INICIO: CREAR, MODIFICAR, VERSIONES -->
					<system:edit show="ifValue" from="theBean" field="modeDebug" value="false">
						<iframe id="editor" width="100%" height="100%" frameBorder="0" src=""></iframe>
						
					</system:edit>
					<!-- FIN: CREAR, MODIFICAR, VERSIONES -->
					
					<!-- INICIO: DEBUG -->
					<system:edit show="ifValue" from="theBean" field="modeDebug" value="true">
						
				
					</system:edit>				
					<!-- FIN: DEBUG -->
				
				</system:edit>
				<!-- FIN: PROCESOS BPMN -->
				
				
				<!-- INICIO: PROCESOS -->
				<system:edit show="ifNotValue" from="theEdition" field="isBpmn" value="1">
					
					
					<!-- FLASH PARA IMPRESION -->
					<div id="imageGenerator" style="position:absolute;top=1;left=0;width:1px;height:1px;overflow:hidden">
						
						<input id="prntAction" name="action"/>
						<input id="prntTabId" name="tabId"/>
						<input id="prntTokenId" name="tokenId"/>
					</div>
				</system:edit>
				<!-- FIN: PROCESOS -->
								
				<!-- INICIO: GENERAL PARA AMBOS CASOS -->
				<div width=100% style="display: none;">
					<%  if (!proVo.getProDefinitionXml().contains("&amp;")) {
						String tmpMap = StringUtil.replace(proVo.getProDefinitionXml(),"&","&amp;");
						if (tmpMap.contains("&amp;amp;")) {
							tmpMap = StringUtil.replace(proVo.getProDefinitionXml(),"&amp;amp;","&amp;");
						}%> 
						<TEXTAREA p_required="true"  id="txtMap" name="txtMap" cols="100" rows="30"><%=tmpMap%></TEXTAREA>
					<% } else { %>
						<TEXTAREA p_required="true"  id="txtMap" name="txtMap" cols="100" rows="30"><%=proVo.getProDefinitionXml()%></TEXTAREA>
					<% } %>
				</div>			
				<!-- FIN: GENERAL PARA AMBOS CASOS -->
				
			</div>					
		</div>
</div>