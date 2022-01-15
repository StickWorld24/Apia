<%@page import="com.dogma.util.DogmaUtil"%>
<script type="text/javascript">
	var MSG_ERR_CBE_PAGE			= '<system:edit show="value" from="theBean" field="errMsgCubePage" />';
	var SHOW_CBE_PAGE				= toBoolean('<system:edit show="value" from="theBean" field="showCubePage" />');
	
	var MUST_CONF 					= '<system:label show="text" label="msgMustConfProBefGenCube" forScript="true" />';
	var MSG_DELETE_CUBE 			= '<system:label show="text" label="msgDelCbeConfirm" forScript="true" />';
	var MSG_CUBE_NAME_ALREADY_EXIST = '<system:label show="tooltip" label="msgCubExi" forScript="true" />';
	var MSG_CUBE_NAME_INVALID 		= '<system:label show="tooltip" label="msgCbeNamInv" forScript="true" />';
	
	var MSG_MUST_ENT_ONE_DIM			= '<system:label forHtml="true" forScript="true" show="text" label="msgMustEntOneDimension" />';
	var MSG_DIM_NAME_UNIQUE 			= '<system:label forHtml="true" forScript="true" show="text" label="msgDimNameUnique" />';
	var MSG_MUST_ENT_ONE_MEAS 			= '<system:label forHtml="true" forScript="true" show="text" label="msgMustEntOneMeasure" />';
	var MSG_MEASURE_NAME_UNIQUE 		= '<system:label forHtml="true" forScript="true" show="text" label="msgMeasureNameUnique" />';
	var MSG_ATLEAST_ONE_MEAS_VISIBLE 	= '<system:label forHtml="true" forScript="true" show="text" label="msgAtLeastOneMeasVisible" />';
	var MSG_PRF_NO_ACC_DELETED 			= '<system:label forHtml="true" forScript="true" show="text" label="msgPrfNoAccDeleted" />';
	var MSG_PRFS_NO_ACC_DELETED 		= '<system:label forHtml="true" forScript="true" show="text" label="msgPrfsNoAccDeleted" />';
	var MSG_MUST_ENTER_FORMULA 			= '<system:label forHtml="true" forScript="true" show="text" label="msgMustEntFormula" />';
	var MSG_MEAS_OP1_NAME_INVALID 		= '<system:label forHtml="true" forScript="true" show="text" label="msgMeasOp1NameInvalid" />';
	var MSG_OP_INVALID					= '<system:label forHtml="true" forScript="true" show="text" label="msgOpInvalid" />';
	var MSG_MEAS_OP2_NAME_INVALID 		= '<system:label forHtml="true" forScript="true" show="text" label="msgMeasOp2NameInvalid" />';
	var MSG_MEAS_NAME_LOOP_INVALID 		= '<system:label forHtml="true" forScript="true" show="text" label="msgMeasNameLoopInvalid" />';
	var MSG_MIS_DIM_ATT					= '<system:label forHtml="true" forScript="true" show="text" label="msgMisDimAttribute" />';
	var MSG_WRG_DIM_NAME 				= '<system:label forHtml="true" forScript="true" show="text" label="msgWrgDimName" />';
	var MSG_WRG_MEA_NAME 				= '<system:label forHtml="true" forScript="true" show="text" label="msgWrgMeaName" />';
	var MSG_MIS_MEA_ATT 				= '<system:label forHtml="true" forScript="true" show="text" label="msgMisMeaAttribute" />';
	var MSG_CBE_NAME_MISS 				= '<system:label forHtml="true" forScript="true" show="text" label="msgCbeNameMiss" />';
		
	var hasCube = toBoolean('<system:edit show="value" from="theBean" field="hasCube"/>');
	
	var YEAR 	= '<system:label forHtml="true" forScript="true" show="text" label="lblYear" />';
	var SEM 	= '<system:label forHtml="true" forScript="true" show="text" label="lblSem" />'; 
	var TRIM 	= '<system:label forHtml="true" forScript="true" show="text" label="lblTrim" />';
	var MON 	= '<system:label forHtml="true" forScript="true" show="text" label="lblMonth" />';
	var WEEDAY 	= '<system:label forHtml="true" forScript="true" show="text" label="lblWeeDay" />';
	var DAY 	= '<system:label forHtml="true" forScript="true" show="text" label="lblBIDay" />';	
	var HOUR 	= '<system:label forHtml="true" forScript="true" show="text" label="lblBIHour" />';
	var MIN 	= '<system:label forHtml="true" forScript="true" show="text" label="lblMinute" />';
	var SEC 	= '<system:label forHtml="true" forScript="true" show="text" label="lblSecond" />';
	
	var TIME_FORMAT	= "<%=DogmaUtil.getHTMLTimeMask()%>";
	
	var MSLBL 		= '<system:label forHtml="true" forScript="true" show="text" label="lblMeasStandard" />';
	var MCLBL 		= '<system:label forHtml="true" forScript="true" show="text" label="lblMeasCalculated" />';
	var AGR_NAME 	= '<system:label forHtml="true" forScript="true" show="text" label="flaPropAllMemberName" />';
	var LBL_PROPS	= '<system:label forHtml="true" forScript="true" show="text" label="titProps" />';
	var RESTRIC		= '<system:label forHtml="true" forScript="true" show="text" label="lblCliSelDimension" />';
	var LBL_DIM 	= '<system:label forHtml="true" forScript="true" show="text" label="lblDwDimensions" />';
	var LBL_VIS		= '<system:label forHtml="true" forScript="true" show="text" label="titVisible" />';
	var LBL_PERM	= '<system:label forHtml="true" forScript="true" show="text" label="sbtPerAccCbe" />';
	var LBL_PERM2	= '<system:label forHtml="true" forScript="true" show="text" label="titPermAcc" />';
	var MSG_ALL_DIM	= '<system:label forHtml="true" forScript="true" show="text" label="msgAllDimVis" />';
	var LBL_MDL_ADD = '<system:label forHtml="true" forScript="true" show="text" label="titVwProAttsAsoc" />';
	var PRIMARY_SEPARATOR		= new Element('div').set('html', '<system:edit show="constant" from="com.st.util.StringUtil" field="PRIMARY_SEPARATOR"/>').get('text');
</script>

<div class="aTab">
	<div class="tab" id="tabAnalyticalQueries"><system:label show="text" label="lblDwQry" /></div>
		<div class="contentTab" id="contentTabAnalyticalQueries">							
			<div>				
				
				<system:edit show="ifValue" from="theBean" field="showCubePage" value="false">
					<div class="fieldGroup" style="display: none;" id="msgMustConf">
						<div class="fieldFull">
							<label class="label"><b><system:edit show="value" from="theBean" field="errMsgCubePage" /></b></label>
						</div>
					</div>
				</system:edit>			
			
				<system:edit show="ifValue" from="theBean" field="showCubePage" value="true">
					<div class="fieldGroup">
						<div class="title"><system:label show="text" label="sbtGenData" /></div>
					</div>
					<div class="fieldGroup splitOneThird">	
						<div class="field inOneLine">
							<label title="<system:label show="tooltip" label="lblDwCreCube" />" class="label"><system:label show="text" label="lblDwCreCube" />:&nbsp;</label>
							<input type="checkbox" id="chkCreCube" name="chkCreCube" onclick="onClickChkCreCube(this);" <system:edit show="ifValue" from="theBean" field="hasCube" value="true">checked</system:edit> />
							<input type="hidden" name="cubeChanged" id="cubeChanged" value="false">							
						</div>
					</div>
					<br>					
					<div class="fieldGroup">	
						<div class="field fieldOneThird required" id="divCubeName">
							<label title="<system:label show="tooltip" label="lblName" />" class="label"><system:label show="text" label="lblName" />:&nbsp;</label>
							<input type="text" id="cubeName" name="cubeName" maxlength="32" class="validate['required','~validCubeName']" value="<system:edit show="value" from="theBean" field="cubeName"/>" onchange="setCubeChanged();"/>
						</div>						
						<div class="field fieldOneThird required" id="divCubeTitle">
							<label title="<system:label show="tooltip" label="docTit" />" class="label"><system:label show="text" label="docTit" />:&nbsp;</label>
							<input type="text" id="cubeTitle" name="cubeTitle" maxlength="32" class="validate['required']" value="<system:edit show="value" from="theBean" field="cubeTitle"/>" onchange="setCubeChanged();"/>
						</div>
						<div class="field fieldOneThird">
							<label title="<system:label show="tooltip" label="lblDes" />" class="label"><system:label show="text" label="lblDes" />:&nbsp;</label>
							<input type="text" id="cubeDesc" name="cubeDesc" maxlength="255" value="<system:edit show="value" from="theBean" field="cubeDesc"/>" onchange="setCubeChanged();"/>
						</div>
					</div>
					
					<div class="clear"></div> <br>
					
					<div class="fieldGroup">
						<div class="title"><system:label show="text" label="lblDwDimensions" /></div>
						<div id="gridDimensions" class="gridContainer" style="margin: 0px;">
							<div class="gridHeader">
								<table>
									<thead>
										<tr class="header">
											<th title="<system:label show="tooltip" label="lblAtt" />"><div style="width: 130px"><system:label show="text" label="lblAtt" /></div></th>
											<th title="<system:label show="tooltip" label="lblTip" />"><div style="width: 50px"><system:label show="text" label="lblTip" /></div></th>
											<th title="<system:label show="tooltip" label="lblNom" />"><div style="width: 700px"><system:label show="text" label="lblNom" /></div></th>						
										</tr>					
									</thead>
								</table>
							</div>
							<div class="gridBody" id="gridBodyDimensions" style="height: 120px">
								<table>			
									<thead>					
										<tr>
											<th width="130px"></th>
											<th width="50px"></th>
											<th width="700px"></th>					
										</tr>								
									</thead>
									<tbody class="tableData" id="gridDims">
										<input type="hidden" id="retDimensions" name="retDimensions" value="">
										<input type="hidden" id="retDimensionsLoaded" name="retDimensionsLoaded" value="">
									</tbody>
								</table>
							</div>
							<div class="gridFooter">	
								<div class="listActionButtons" id="gridFooter">			
									<div class="listAddDelRight" id="buttonsDim" >
										<div class="btnAdd navButton" id="btnPropDim"><system:label show="text" label="btnProperties" /></div>
										<div class="actSeparator">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;</div>
										<div class="btnAdd navButton" id="btnAddDim"><system:label show="text" label="btnAgr" /></div>
										<div class="actSeparator">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;</div>
										<div class="btnDelete navButton" id="btnDeleteDim"><system:label show="text" label="btnEli" /></div>													
									</div>
								</div>		
							</div>							
						</div>						
					</div>
					
					<div class="clear"></div> <br>
					
					<div class="fieldGroup">
						<div class="title"><system:label show="text" label="lblMeasures" /></div>
						<div id="gridMeasuresTable" class="gridContainer" style="margin: 0px;">
							<div class="gridHeader">
								<table>
									<thead>
										<tr class="header">
											<th title="<system:label show="tooltip" label="lblAtt" />"><div style="width: 130px"><system:label show="text" label="lblAtt" /></div></th>
											<th title="<system:label show="tooltip" label="lblDispName" />"><div style="width: 140px"><system:label show="text" label="lblDispName" /></div></th>
											<th title="<system:label show="tooltip" label="titMeasType" />"><div style="width: 120px"><system:label show="text" label="titMeasType" /></div></th>
											<th title="<system:label show="tooltip" label="lblAggregator" />"><div style="width: 100px"><system:label show="text" label="lblAggregator" /></div></th>
											<th title="<system:label show="tooltip" label="lblFormat" />"><div style="width: 130px"><system:label show="text" label="lblFormat" /></div></th>
											<th title="<system:label show="tooltip" label="titFormula" />"><div style="width: 150px"><system:label show="text" label="titFormula" /></div></th>						
											<th title="<system:label show="tooltip" label="titVisible" />"><div style="width: 50px"><system:label show="text" label="titVisible" /></div></th>
										</tr>					
									</thead>
								</table>
							</div>
							<div class="gridBody" id="gridBodyMeasures" style="height: 120px">
								<table>			
									<thead>					
										<tr>
											<th width="130px"></th>
											<th width="140px"></th>
											<th width="120px"></th>		
											<th width="100px"></th>		
											<th width="130px"></th>		
											<th width="150px"></th>		
											<th width="50px"></th>					
										</tr>								
									</thead>
									<tbody class="tableData" id="gridMeasures">
										<input type="hidden" id="retMeasures" name="retMeasures" value="">
										<input type="hidden" id="retMeasuresLoaded" name="retMeasuresLoaded" value="">
										
									</tbody>
								</table>
							</div>
							<div class="gridFooter">	
								<div class="listActionButtons" id="gridFooter">			
									<div class="listAddDelRight" id="buttonsMea">
										<div class="btnAdd navButton" id="btnDupMea"><system:label show="text" label="btnDup" /></div>
										<div class="actSeparator">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;</div>
										<div class="btnAdd navButton" id="btnAddMea"><system:label show="text" label="btnAgr" /></div>
										<div class="actSeparator">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;</div>
										<div class="btnDelete navButton" id="btnDeleteMea"><system:label show="text" label="btnEli" /></div>													
									</div>
								</div>		
							</div>							
						</div>						
					</div>
					
					<div class="clear"></div> <br>
					
					<div class="fieldGroup split">
						<div class="title"><system:label show="text" label="lblPrfAccCube" /></div>
						<div class="modalOptionsContainer" id="profilesCubeContainer">						
							<input type="hidden" id="txtProfCube" name="txtProfCube" value="">
							<div class="element docAddDocument" id="addProfCube" data-helper="true">
								<div class="option optionAdd">
									<system:label show="text" label="btnAgr" />			
								</div>
							</div>										
						</div>						
					</div>
					
					<div class="fieldGroup split">
						<div class="title"><system:label show="text" label="sbtPerNoAcc" /></div>
						<div class="modalOptionsContainer" id="profilesCubePermContainer">						
							<input type="hidden" id="txtProfPermCube" name="txtProfPermCube" value="">
							<div class="element docAddDocument" id="addProfPermCube" data-helper="true">						
								<div class="option optionAdd">
									<system:label show="text" label="btnAgr" />
								</div>
							</div>
						</div>
					</div>
					
					<div class="clear"></div> <br>
					
					<div class="fieldGroup">
						<div class="title"><system:label show="text" label="lblDataLoad" /></div>
					</div>	
						
					<div class="fieldGroup" >		
						<div class="defBlock">
							<div class="oneLineRadio">
								<input type="radio" name="radLoad" id="radLoadConf" onclick="onClickRadLoad(this);" value="1" checked>
								<label title="<system:label show="tooltip" label="lblLoadOnConfirm" />" for="radLoadConf" class="label"><system:label show="text" label="lblLoadOnConfirm" /></label>
							</div>
							<div>&nbsp;</div>
							<div class="oneLineRadio"> 	
								<input type="radio" name="radLoad" id="radLoadAfter" onclick="onClickRadLoad(this);" value="2">
								<label title="<system:label show="tooltip" label="lblSchedLoad" />" for="radLoadAfter" class="label"><system:label show="text" label="lblSchedLoad" /></label>
							</div>
							<div>&nbsp;</div>					
						</div>
						
						<br><br>
						
						<div class="defBlock">
							<div class="field" style="width: 170px;"> 	
								<label title="<system:label show="tooltip" label="lblFchIni" />" class="label"><system:label show="text" label="lblFchIni" />:&nbsp;</label>
								<input type="text" name="iniDteLoad" id="iniDteLoad" style="width: 60px;" class="datePickerCustom" value="">								
							</div>
							
							<div class="field" style="width: 170px;"> 	
								<label title="<system:label show="tooltip" label="lblHorIni" />" class="label"><system:label show="text" label="lblHorIni" />:&nbsp;&nbsp;&nbsp;</label>
								<input type="text" id="iniHrLoad" name="iniHrLoad" maxlength="5" style="width: 30px;" value="" />
							</div>						
						</div>
					</div>
					
					<div class="clear"></div><br><br><br><br><br>
				</system:edit>			
				
			</div>					
		</div>
</div>