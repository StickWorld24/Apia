<DIV class="subTit"><%=LabelManager.getName(labelSet,"sbtPerAccCbe")%></DIV><div type="grid" id="permGrid" style="height:200px"><table width="500px" cellpadding="0" cellspacing="0"><thead><tr><th style="width:0px;display:none;" title="<%=LabelManager.getToolTip(labelSet,"lblSel")%>"></th><th min_width="50px" style="width:50px">&nbsp;</th><th min_width="300px" style="width:300px" title="<%=LabelManager.getToolTip(labelSet,"lblNom")%>"><%=LabelManager.getName(labelSet,"lblNom")%></th><th min_width="150px" style="min-width:150px;width:100%" title="<%=LabelManager.getToolTip(labelSet,"lblPer")%>"><%=LabelManager.getName(labelSet,"lblPer")%></th></tr></thead><tbody class="scrollContent"><% Collection colPermissions = dBean.getColPermissions();
	   		   if (colPermissions==null || colPermissions.size()==0){ //Si aun no se definieron permisos%><tr cantDelete="true"><td style="width:0px;display:none;" align="center"><input type='hidden' id="idSel" name="chkSel"><input type='hidden' name="hidPoolId" value="-1"><input type='hidden' name="hidRead" value="1"><input type='hidden' name="hidMod" value="1"></td><td align="center"><div style="width:18px; height:18px;"></div></td><td title="<%=LabelManager.getToolTip(labelSet,"lblTod")%>"><%=LabelManager.getName(labelSet,"lblTod")%></td><td style="min-width:150px"><input name="chkAllowRead" type=checkbox checked onClick="chgChkHidRead(event)"><%=LabelManager.getName(labelSet,"lblPerVer")%><input name="chkAllowModify" type=checkbox checked onClick="chgChkHidMod(event)"><%=LabelManager.getName(labelSet,"lblPerMod")%></td></tr><%}else{//Ya se definieron permisos
				 Iterator itPermissions = colPermissions.iterator();
				 int intPermId=0;
				 while (itPermissions.hasNext()) {
					ObjAccessVo objAccessVo = (ObjAccessVo) itPermissions.next();
					Integer poolId= objAccessVo.getPoolId();
					String poolName;
					boolean readAccess = (objAccessVo.getReadOnly() != null && 1 == objAccessVo.getReadOnly().intValue());
					boolean writeAccess = ( objAccessVo.getReadWrite() != null && 1 == objAccessVo.getReadWrite().intValue());
					boolean cantDelete = (-1 == poolId.intValue());
					String rType="";
					String strImage;
					if (poolId.intValue() == -1){
						strImage="<div style='width:18px; height:18px;'></div>";
						poolName = LabelManager.getName(labelSet,"lblTod");
					} else if (objAccessVo.isAutoGenPool()) {
						strImage="<div style='width:18px; height:18px; background-image:url(" + com.dogma.Parameters.ROOT_PATH + "/styles/" + styleDirectory + "/images/user.gif);background-repeat:no-repeat;'></div>";
						rType = "usu";
						poolName = objAccessVo.getPoolName();
					} else {
						strImage="<div style='width:18px; height:18px; background-image:url(" + com.dogma.Parameters.ROOT_PATH + "/styles/" + styleDirectory + "/images/pool.gif);background-repeat:no-repeat;'></div>";
						rType = "grp";
						poolName = objAccessVo.getPoolName();
					}
					%><tr cantDelete="<%=cantDelete%>"><td style="width:0px;display:none;" align="center"><input type='hidden' id="idSel" name="chkSel"><input type='hidden' name="hidPoolId" value="<%=poolId.intValue()%>"><input type='hidden' name="hidRead" value="<%=(readAccess)?"1":"0"%>"><input type='hidden' name="hidMod" value="<%=(writeAccess)?"1":"0"%>"></td><td align="center"><%=strImage%></td><td title="<%= dBean.fmtHTML(poolName)%>"><%=dBean.fmtHTML(poolName)%></td><% if (poolId==-1){ %><td style="min-width:150px"><input name="chkAllowRead" type=checkbox <%=(readAccess)?"checked":""%> onClick="chgChkHidRead(event)"><%=LabelManager.getName(labelSet,"lblPerVer")%><input name="chkAllowModify" type=checkbox <%=(writeAccess)?"checked":""%> onClick="chgChkHidMod(event)"><%=LabelManager.getName(labelSet,"lblPerMod")%></td><%}else{ %><td style="min-width:150px"><input type="radio" id="rad<%=intPermId %>" onClick="chgRadHidRead(event)" name="<%=rType + intPermId%>" <%if (readAccess && !writeAccess){%> checked <%}%>><%=dBean.fmtScriptStr(LabelManager.getName(labelSet,"lblPerVer"))%><input type="radio" id="rad<%=intPermId %>" onClick="chgRadHidMod(event)" name="<%=rType + intPermId%>" <%if (writeAccess){%> checked <%}%>><%=dBean.fmtScriptStr(LabelManager.getName(labelSet,"lblPerMod"))%></td><%intPermId++;}%></tr><%}
			}%></tbody></table></div><table class="navBar" id="navBar"><tr><td align="right"><button type="button" type="button" onclick="btnAddPoolUsrPerm_click()" accesskey="<%=LabelManager.getAccessKey(labelSet,"btnAgrGruUsr")%>" title="<%=LabelManager.getToolTip(labelSet,"btnAgrGruUsr")%>"><%=LabelManager.getNameWAccess(labelSet,"btnAgrGruUsr")%></button><button type="button" type="button" onclick="btnDelPoolPerm_click()" accesskey="<%=LabelManager.getAccessKey(labelSet,"btnEli")%>" title="<%=LabelManager.getToolTip(labelSet,"btnEli")%>"><%=LabelManager.getNameWAccess(labelSet,"btnEli")%></button></td></tr></table><DIV class="subTit"><%=LabelManager.getName(labelSet,"sbtPerNoAcc")%></DIV><div type="grid" id="gridNoAccProfiles" style="height:100px"><table id="tblProfiles"  width="500px" cellpadding="0" cellspacing="0"><thead><tr><th style="width:0px;display:none;" title="<%=LabelManager.getToolTip(labelSet,"lblSel")%>"></th><th min_width="400px" style="width:400px" title="<%=LabelManager.getToolTip(labelSet,"lblProfile")%>"><%=LabelManager.getName(labelSet,"lblProfile")%></th><th min_width="150px" style="min-width:150px;width:100%" title="<%=LabelManager.getToolTip(labelSet,"lblResDimensions")%>"><%=LabelManager.getName(labelSet,"lblResDimensions")%></th></tr></thead><tbody id="tblPerBody"><%  Collection cubePrfRes = dBean.getCubePrfRestricted();
			if (cubePrfRes != null && cubePrfRes.size()>0){
				Iterator itPrfRes = cubePrfRes.iterator();
				while (itPrfRes.hasNext()) {
					String prfName = (String) itPrfRes.next();
					%><tr><td style="width:0px;display:none;"><input type="hidden" name="chkPrfRestSel"><input type=hidden name="chkPrfRest" value=""></td><td value="<%=prfName%>" flagNew="false"><%=prfName%></td><td style="min-width:150px"><span style="vertical-align:bottom;"><img title="<%=LabelManager.getName(labelSet,"lblCliSelDimension")%>" src="<%=Parameters.ROOT_PATH%>/styles/<%= styleDirectory %>/images/btn_mod.gif" width="17" height="16" onclick="openNoAccDims(this)" style="cursor:pointer;cursor:hand"></span></td></tr><%
				} 
			}%></tbody></table></div><table class="navBar"><COL class="col1"><COL class="col2"><tr><TD></TD><td><button type="button" id="btnAddNoAccPrf" onclick="btnAddNoAccProfile_click()" accesskey="<%=LabelManager.getAccessKey(labelSet,"btnAgr")%>" title="<%=LabelManager.getToolTip(labelSet,"btnAgr")%>"><%=LabelManager.getNameWAccess(labelSet,"btnAgr")%></button><button type="button" id="btnDelNoAccPrf" onclick="btnDelNoAccProfile_click()" accesskey="<%=LabelManager.getAccessKey(labelSet,"btnEli")%>" title="<%=LabelManager.getToolTip(labelSet,"btnEli")%>"><%=LabelManager.getNameWAccess(labelSet,"btnEli")%></button></td></tr></table><br><br><br><br><SCRIPT>

function chgChkHidRead(evt){
	evt=getEventObject(evt);
	var el=getEventSource(evt);
	var tr = getParentRow(el);
	var td = tr.getElementsByTagName("TD");
	if (!td[3].getElementsByTagName("INPUT")[1].checked){//si no estaba seleccionado el modo escritura
		if (td[0].getElementsByTagName("INPUT")[2].value == 1){ //si estaba seleccionado el modo lectura
 			td[0].getElementsByTagName("INPUT")[2].value = 0; //lo desmarcamos
		}else{
 			td[0].getElementsByTagName("INPUT")[2].value = 1; //lo marcamos
		}
	}else{
		//Marcamos el modo lectura
		td[3].getElementsByTagName("INPUT")[0].checked = true;
		td[0].getElementsByTagName("INPUT")[2].value = 1;
	}
}

function chgChkHidMod(evt){
	evt=getEventObject(evt);
	var el=getEventSource(evt);
	var tr = getParentRow(el);
	var td = tr.getElementsByTagName("TD");
	if (td[0].getElementsByTagName("INPUT")[3].value == 1){//si estaba seleccionado el modo escritura
 		td[0].getElementsByTagName("INPUT")[3].value = 0;//lo desmarcamos
	}else{
 		td[0].getElementsByTagName("INPUT")[3].value = 1;//lo marcamos
 		//Marcamos tambien el modo lectura:
 		td[3].getElementsByTagName("INPUT")[0].checked = true;
 		td[0].getElementsByTagName("INPUT")[2].value = 1;
	}
}

function chgRadHidRead(evt){
	evt=getEventObject(evt);
	var el=getEventSource(evt);
	var tr = getParentRow(el);
	var td = tr.getElementsByTagName("TD");
	//El modo lectura en los pooles siempre esta seteado -> al hacer click en el rad lectura lo unico que hacemos es desmarcar el modo escritura
	td[0].getElementsByTagName("INPUT")[3].value = 0;//lo desmarcamos como modo escritura
}

function chgRadHidMod(evt){
	evt=getEventObject(evt);
	var el=getEventSource(evt);
	var tr = getParentRow(el);
	var td = tr.getElementsByTagName("TD");
	//El modo lectura en los pooles siempre esta seteado -> al hacer click en el rad escritura lo unico que hacemos es marcar el modo escritura
	td[0].getElementsByTagName("INPUT")[3].value = 1;//lo marcamos como modo escritura
}

function btnAddPoolUsrPerm_click() {
	var rets = openModal("/programs/modals/pools.jsp?showAutogenerated=true&envAndGlobal=true&envId=" + <%=envId%> + "&showGlobal=true",500,350);
	rets.onclose=function(){
		addObject(rets.returnValue);
	}
}

var intPermId = 1000;//ponemos 1000 como el inicial pq ya pueden haber cargados y se cargan desde 0 (si ya hay mas de 1000 hay problemas)

function addObject(rets) {
	if (rets != null) {
		for (j = 0; j < rets.length; j++) {
			var ret = rets[j];
			var addRet = true;
			
			var poolId = ret[0]; //poolId
			var poolName = ret[1]; //poolName
			var poolAutoGen = ("1" == ret[5]); //poolAutoGen (si es true es un usuario, sino un grupo)
			
			//Nos fijamos si ya no se habia agregado el grupo
			trows=document.getElementById("permGrid").rows;
			for (i=0;i<trows.length && addRet;i++) {
				var actId = trows[i].getElementsByTagName("TD")[0].getElementsByTagName("INPUT")[1].value;
				if (actId == poolId) {
					addRet = false;
				}
			}
			
			if (addRet) {
				var oTd0 = document.createElement("TD"); //oculto
				var oTd1 = document.createElement("TD"); //imagen
				var oTd2 = document.createElement("TD"); //nombre
				var oTd3 = document.createElement("TD"); //permisos
				
				oTd0.innerHTML='<input type="hidden" name="chkSel" value=""></input>';
				oTd0.innerHTML += '<input type="hidden" name="hidPoolId" value="' + poolId +'">';
				oTd0.innerHTML += '<input type="hidden" name="hidRead" value="1">'; //el modo lectura siempre esta seteado
				oTd0.innerHTML += '<input type="hidden" name="hidMod" value="1">';	

				oTd1.innerHTML = '<div style="width:18px; height:18px;"></div>';				
				if (poolAutoGen) { //Si se va a agregar un usuario
					oTd1.getElementsByTagName("DIV")[0].style.backgroundImage=("url(" + URL_STYLE_PATH+ "/images/user.gif)"); //mostramos imagen para usuarios
				} else {
					oTd1.getElementsByTagName("DIV")[0].style.backgroundImage=("url(" + URL_STYLE_PATH+ "/images/pool.gif)"); //mostramos imagen para grupos
				}
				oTd1.getElementsByTagName("DIV")[0].style.backgroundRepeat="no-repeat";
				
				oTd2.title = poolName;
				oTd2.innerHTML = poolName;//mostramos el nombre del usuario

				var rType;
				if (poolAutoGen) { //Si es un pool autogenerado es un usuario
					rType = "usu";
				} else {
					rType = "grp";
				}
						
				//creamos los radio buttons para seleccionar los permisos
				var str = "<input type='radio' id='rad" + intPermId + "' onClick='chgRadHidRead(event)' name='" + rType + intPermId +"'><%=dBean.fmtScriptStr(LabelManager.getName(labelSet,"lblPerVer"))%>";
				str += "<input type=radio id='rad" + intPermId + "' onClick='chgRadHidMod(event)' name='" + rType + intPermId + "' checked><%=dBean.fmtScriptStr(LabelManager.getName(labelSet,"lblPerMod"))%>";
				
				oTd3.innerHTML = str;
								
				var oTr = document.createElement("TR");
				oTr.setAttribute("cantDelete","false");
				oTr.appendChild(oTd0);
				oTr.appendChild(oTd1);
				oTr.appendChild(oTd2);
				oTr.appendChild(oTd3);
				document.getElementById("permGrid").addRow(oTr);
				document.getElementById("permGrid").updateScroll();
				intPermId++;
			}
		}
	}		
}

function btnDelPoolPerm_click() {
	if (document.getElementById("permGrid").selectedItems.length > 0){
		var oRows=document.getElementById("permGrid").selectedItems;
		for(var i=(oRows.length-1);(i>=0);i--){
			if(oRows[i].getAttribute("cantDelete")!="true"){
				oRows[i].parentNode.removeChild(oRows[i]);
				document.getElementById("permGrid").updateScroll();
			}
			oRows[i].style.height="0px";
		}
	}else{
		alert(MSG_MUST_SEL_MEAS_FIRST);
	}
}
</SCRIPT>