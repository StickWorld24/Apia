<%@include file="../../includes/startInc.jsp" %><html lang="<%=biz.statum.apia.web.bean.BasicBeanStatic.getUserDataStatic(request).getLangCode()%>"><head><%@include file="../../includes/headInclude.jsp" %><script type="text/javascript" src="<system:util show="context" />/page/administration/mtransfer/mtransferList.js"></script><script type="text/javascript" src="<system:util show="context" />/page/administration/mtransfer/channels.js"></script><script type="text/javascript" src="<system:util show="context" />/page/administration/mtransfer/publishedchannels.js"></script><script type="text/javascript" src="<system:util show="context" />/page/administration/mtransfer/remoteapias.js"></script><script type="text/javascript" src="<system:util show="context" />/page/administration/mtransfer/models.js"></script><%----%><script type="text/javascript" src="<system:util show="context" />/page/includes/adminFav.js"></script><script type="text/javascript" src="<system:util show="context" />/page/includes/campaigns.js"></script><script type="text/javascript">
			var URL_REQUEST_AJAX	= '/apia.administration.MTransferAction.run';
			//var TOOLTIP_WS_PROC 	= '<system:label show="text" label="lblWsPro" forScript="true" />'; 
			//var TOOLTIP_WS_TSK 		= '<system:label show="text" label="lblWsTsk" forScript="true" />';
			//var TOOLTIP_PUB_UNPUB	= '<system:label show="text" label="btnPub" forScript="true" />' + '/' + '<system:label show="text" label="btnUnPub" forScript="true" />';
			//var TOOLTIP_USERS 		= '<system:label show="text" label="titUsu" forScript="true" />';
			//var NO_EXIST_WS_CAT		= '<system:label show="text" label="msgNoWSCat" forScript="true" />';

			var FIELD_REMOTE_APP_NAME_EMPTY		= '<system:label show="text" label="msgFieldRemoteAppNameEmpty" forScript="true" />';
			var FIELD_REMOTE_APP_IP_EMPTY		= '<system:label show="text" label="msgFieldRemoteAppIpEmpty" forScript="true" />';
			var FIELD_REMOTE_APP_PORT_EMPTY		= '<system:label show="text" label="msgFieldRemoteAppPortEmpty" forScript="true" />';
			var FIELD_REMOTE_APP_CONTEXT_EMPTY	= '<system:label show="text" label="msgFieldRemoteAppContextEmpty" forScript="true" />';
			var FIELD_REMOTE_APP_EMPTY			= '<system:label show="text" label="msgFieldRemoteAppEmpty" forScript="true" />';
			var FIELD_TRANSFER_CHANNEL_EMPTY	= '<system:label show="text" label="msgFieldTransferChannelEmpty" forScript="true" />';
			var FIELD_REMOTE_CHANNEL_PORT_EMPTY		= '<system:label show="text" label="msgFieldRemoteChannelPortEmpty" forScript="true" />';
			var CHECK_DELETE_REMOTE_APP		= '<system:label show="text" label="msgCheckDeleteRemoteApp" forScript="true" />';
			var CHECK_DELETE_REMOTE_CHANNEL		= '<system:label show="text" label="msgCheckDeleteRemoteChannel" forScript="true" />';
			var CHECK_SAVE_REMOTE_MODEL_MESSAGE		= '<system:label show="text" label="msgCheckSaveRemoteModelMesage" forScript="true" />';

			var FIELD_TRANSFER_CHANNEL_NAME_EMPTY	= '<system:label show="text" label="msgFieldTransferChannelNameEmpty" forScript="true" />';
			var FIELD_TRANSFER_CHANNEL_EXEC_EMPTY	= '<system:label show="text" label="msgFieldTransferChannelExecEmpty" forScript="true" />';
			var CHECK_DELETE_TRANSFER_CHANNEL		= '<system:label show="text" label="msgCheckDeleteTransferChannel" forScript="true" />';

			var FIELD_MODEL_MESSAGE_DESCR_EMPTY	= '<system:label show="text" label="msgFieldModelMessageDescrEmpty" forScript="true" />';
			var FIELD_MODEL_MESSAGE_ACTION_EMPTY	= '<system:label show="text" label="msgFieldModelMessageActionEmpty" forScript="true" />';
			var FIELD_MODEL_MESSAGE_ELEMENT_ACTION_EMPTY	= '<system:label show="text" label="msgFieldModelMessageElementActionEmpty" forScript="true" />';

			var FIELD_MODEL_MESSAGE_PARAM_DATATYPE_EMPTY	= '<system:label show="text" label="msgFieldModelMessageParamDatatypeEmpty" forScript="true" />';
			var FIELD_MODEL_MESSAGE_PARAM_SOURCETYPE_EMPTY	= '<system:label show="text" label="msgFieldModelMessageParamSourceTypeEmpty" forScript="true" />';
			var CHECK_DELETE_MODEL_MESSAGE		= '<system:label show="text" label="msgCheckDeleteModelMessage" forScript="true" />';

			var FIELD_EO_ELEMENT_EMPTY	= '<system:label show="text" label="msgFieldEOElementEmpty" forScript="true" />';
			var FIELD_EO_REMOTE_APP_RECORD_EMPTY	= '<system:label show="text" label="msgFieldEORemoteAppRecordEmpty" forScript="true" />';

			var FIELD_PUBLISHED_CHANNEL_PORT_EMPTY	= '<system:label show="text" label="msgFieldPublishedChannelPortEmpty" forScript="true" />';
			var FIELD_PUBLISHED_CHANNEL_TRANSFER_CHANNEL_EMPTY	= '<system:label show="text" label="msgFieldPublishedChannelTransferChannelEmpty" forScript="true" />';
			var CHECK_DELETE_PUBLISHED_CHANNEL		= '<system:label show="text" label="msgCheckDeletePublishedChannel" forScript="true" />';
			
			var CHECK_DELETE_ENABLE_OBJECT = '<system:label show="text" label="msgCheckDeleteEnableObject" forScript="true" />';
			
		</script></head><body><div class="body" id="bodyDiv"><form id="frmData"><div class="optionsContainer"><system:campaign inLogin="false" inSplash="false" location="verticalUp" /><div class="fncPanel info"><div class="title"><system:label show="text" label="mnuMtransfer" /><%@include file="../../includes/adminFav.jsp" %></div><div class="content divFncDescription"><div class="fncDescriptionImage" data-src="<system:edit show="value" from="theBean" field="fncImage"/>"></div><div id="fncDescriptionText"><system:label show="text" label="dscFncAdmMtransfer"/></div><div class="clear"></div></div></div><div class="fncPanel buttons" id="panelOptionsTabGenData"><div class="title"><system:label show="text" label="mnuOpc" /></div><div class="content"><div id="btnUpdate" class="button" title="<system:label show="tooltip" label="btnAct" />"><system:label show="text" label="btnAct" /></div><div id="btnCloseTab" class="button" title="<system:label show="tooltip" label="btnClose" />"><system:label show="text" label="btnClose" /></div></div></div><div id="divAdminActEdit" class="fncPanel buttons"><div class="title"><system:label show="text" label="mnuOpc"/></div><div class="content"><div id="miApiaButtons" class="hidden"><%--<system:edit show="iteration" from="theBean" field="formatButtons" saveOn="parameter"><system:edit show="value" from="parameter" field="html" avoidHtmlConvert="true"/></system:edit>--%><%--<div><button id='saveMyApplication' class="genericBtn" onClick='executeBtn(this)'>Guardar mi aplicación</button></div><br>--%><div id="saveMyApplication" class="button suggestedAction" onClick='saveMyApplication()' title="<system:label show="tooltip" label="btnSaveMyApplicationLabel" />"><system:label show="text" label="btnSaveMyApplicationLabel" /></div><div><div id="enableProcessMyApp" class="button" onClick='loadObjectsEnabledProcess()' title="<system:label show="tooltip" label="btnEnableProcessMyApp" />"><system:label show="text" label="btnEnableProcessMyApp" /></div><div id="enableEntityMyApp" class="button" onClick='loadObjectsEnabledEntity()' title="<system:label show="tooltip" label="btnEnableEntityMyApp" />"><system:label show="text" label="btnEnableEntityMyApp" /></div><div id="enableQueryMyApp" class="button" onClick='loadObjectsEnabledQuery()' title="<system:label show="tooltip" label="btnEnableQueryMyApp" />"><system:label show="text" label="btnEnableQueryMyApp" /></div><div id="enableBusClassMyApp" class="button" onClick='loadObjectsEnabledBusClass()' title="<system:label show="tooltip" label="btnEnableBusClassMyApp" />"><system:label show="text" label="btnEnableBusClassMyApp" /></div></div><br><%--<div><button id='enableProcessMyApp' class="genericBtn" value='1' idAction='getListEnableObjectsByAction' type='button' container='MTransferContainter2' onClick='loadInfoSingleElement(this)'>Habilitar Proceso</button><button id='enableEntityMyApp' class="genericBtn" value='2' idAction='getListEnableObjectsByAction' type='button' container='MTransferContainter2' onClick='loadInfoSingleElement(this)'>Habilitar Entidad</button><button id='enableBusClassMyApp' class="genericBtn" value='4' idAction='getListEnableObjectsByAction' type='button' container='MTransferContainter2' onClick='loadInfoSingleElement(this)'>Habilitar clase de negocio</button><button id='enableQueryMyApp' class="genericBtn" value='3' idAction='getListEnableObjectsByAction' type='button' container='MTransferContainter2' onClick='loadInfoSingleElement(this)'><span>Habilitar Consulta de usuario</span></button></div><br>--%><%--<div><button id='newObjectEnable' class="genericBtn hidden" type='button' onClick='executeBtn(this)'>Agregar elemento</button><button id='cancelListObjects'class="genericBtn hidden"  type='button' onClick='initMyAppTab()'>Cancelar</button></div><br>--%><div><div id="newObjectEnable" class="button suggestedAction hidden" onClick='executeBtn(this)' title="<system:label show="tooltip" label="btnNewObjectEnabled" />"><system:label show="text" label="btnNewObjectEnabled" /></div><div id="cancelListObjects" class="button hidden" onClick='initMyAppTab()' title="<system:label show="tooltip" label="btnCancelListObjects" />"><system:label show="text" label="btnCancelListObjects" /></div></div><br><%--<div><button id='saveObjectEnable'class="genericBtn hidden" type='button' onClick='executeBtn(this)'>Guardar</button><button id='deleteObjectEnable' class="genericBtn hidden" type='button' onClick='executeBtn(this)'>Eliminar</button><button id='cancelEnabledObject' class="genericBtn hidden" type='button' onClick='returnListEnableObjects()'>Cancelar</button></div><br>--%><div><div id="saveObjectEnable" class="button suggestedAction hidden" onClick='executeBtn(this)' title="<system:label show="tooltip" label="btnSaveObjectEnable" />"><system:label show="text" label="btnSaveObjectEnable" /></div><div id="deleteObjectEnable" class="button hidden" onClick='deleteEnableObject()' title="<system:label show="tooltip" label="btnDeleteObjectEnable" />"><system:label show="text" label="btnDeleteObjectEnable" /></div><div id="cancelEnabledObject" class="button hidden" onClick='returnListEnableObjects()' title="<system:label show="tooltip" label="btnCancelEnabledObject" />"><system:label show="text" label="btnCancelEnabledObject" /></div></div><br><div><div id="addRemotAppObjectEnable" class="button hidden" onClick='executeBtn(this)' title="<system:label show="tooltip" label="btnAddRemotAppObjectEnable" />"><system:label show="text" label="btnAddRemotAppObjectEnable" /></div></div><br><%--<div><button id='addRemotAppObjectEnable' class="genericBtn hidden" type='button' onClick='executeBtn(this)'>Agregar aplicación remota</button></div><br>--%></div><div id="channelsButtons" class="hidden"><%--<system:edit show="iteration" from="theBean" field="locButtons" saveOn="parameter"><system:edit show="value" from="parameter" field="html" avoidHtmlConvert="true"/></system:edit>--%><%--<div><button id='addChannel' type='button' onClick='executeBtn(this)'>Agregar canal</button></div><br>--%><div><div id="addChannel" class="button suggestedAction hidden" onClick='executeBtn(this)' title="<system:label show="tooltip" label="btnAddChannel" />"><system:label show="text" label="btnAddChannel" /></div></div><br><%--<div><button id='saveTransferChannel' type='button' onClick='executeBtn(this)' class='hidden'>Guardar</button><button id='deleteTransferChannel' type='button' onClick='executeBtn(this)' class='hidden'>Eliminar</button><button id='cancelEditChannel' type='button' onClick='initChannelTab()' class='hidden'>Cancelar</button></div><br>--%><div><div id="saveTransferChannel" class="button suggestedAction hidden" onClick='executeBtn(this)' title="<system:label show="tooltip" label="btnSaveTransferChannel" />"><system:label show="text" label="btnSaveTransferChannel" /></div><div id="deleteTransferChannel" class="button hidden" onClick='executeBtn(this)' title="<system:label show="tooltip" label="btnDeleteTransferChannel" />"><system:label show="text" label="btnDeleteTransferChannel" /></div><div id="cancelEditChannel" class="button hidden" onClick='initChannelTab()' title="<system:label show="tooltip" label="btnCancelEditChannel" />"><system:label show="text" label="btnCancelEditChannel" /></div></div><br></div><div id="publishedChannelsButtons" class="hidden"><%--<system:edit show="iteration" from="theBean" field="logButtons" saveOn="parameter"><system:edit show="value" from="parameter" field="html" avoidHtmlConvert="true"/></system:edit>--%><%--<div><button id='addPublishedChannel' type='button' onClick='executeBtn(this)'>Publicar nuevo canal</button></div><br>--%><div><div id="addPublishedChannel" class="button suggestedAction hidden" onClick='executeBtn(this)' title="<system:label show="tooltip" label="btnAddPublishedChannel" />"><system:label show="text" label="btnAddPublishedChannel" /></div></div><br><%--<div><button id='publishChannel' type='button' onClick='executeBtn(this)' class='hidden'>Guardar y publicar</button><button id='deletePublishedChannel' type='button' onClick='executeBtn(this)' class='hidden'>Eliminar</button><button id='cancelEditPublishedChannel' type='button' onClick='initPublishedChannelTab()' class='hidden'>Cancelar</button></div><br>--%><div><div id="publishChannel" class="button suggestedAction hidden" onClick='executeBtn(this)' title="<system:label show="tooltip" label="btnPublishChannel" />"><system:label show="text" label="btnPublishChannel" /></div><div id="deletePublishedChannel" class="button hidden" onClick='executeBtn(this)' title="<system:label show="tooltip" label="btnDeletePublishedChannel" />"><system:label show="text" label="btnDeletePublishedChannel" /></div><div id="cancelEditPublishedChannel" class="button hidden" onClick='initPublishedChannelTab()' title="<system:label show="tooltip" label="btnCancelEditPublishedChannel" />"><system:label show="text" label="btnCancelEditPublishedChannel" /></div></div><br></div><div id="remoteAppButtons" class="hidden"><%--<system:edit show="iteration" from="theBean" field="emailButtons" saveOn="parameter"><system:edit show="value" from="parameter" field="html" avoidHtmlConvert="true"/></system:edit>--%><%--<div><button id='addApplication' type='button' onClick='executeBtn(this)'>Agregar aplicación remota</button></div><br>--%><div><div id="addApplication" class="button suggestedAction hidden" onClick='executeBtn(this)' title="<system:label show="tooltip" label="btnAddApplication" />"><system:label show="text" label="btnAddApplication" /></div></div><br><%--<div><button id='saveApp' type='button' onClick='executeBtn(this)' class='hidden'>Guardar</button><button id='deleteApp' type='button' onClick='executeBtn(this)' class='hidden'>Eliminar</button></div><br><div><button id='addRemoteChannel' type='button' onClick='executeBtn(this)' class='hidden'>Agregar nuevo canal remoto</button><button id='cancelEditRemoteApp' type='button' onClick='initRemoteAppsTab()' class='hidden'>Cancelar</button></div><br>--%><div><div id="saveApp" class="button suggestedAction hidden" onClick='executeBtn(this)' title="<system:label show="tooltip" label="btnSaveApp" />"><system:label show="text" label="btnSaveApp" /></div><div id="deleteApp" class="button hidden" onClick='executeBtn(this)' title="<system:label show="tooltip" label="btnDeleteApp" />"><system:label show="text" label="btnDeleteApp" /></div><div id="addRemoteChannel" class="button hidden" onClick='executeBtn(this)' title="<system:label show="tooltip" label="btnAddRemoteChannel" />"><system:label show="text" label="btnAddRemoteChannel" /></div><div id="cancelEditRemoteApp" class="button hidden" onClick='initRemoteAppsTab()' title="<system:label show="tooltip" label="btnCancelEditRemoteApp" />"><system:label show="text" label="btnCancelEditRemoteApp" /></div></div><br><%--<div><button id='saveRemoteChannel' type='button' onClick='executeBtn(this)' class='hidden'>Guardar</button><button id='deleteRemoteChannel' type='button' onClick='executeBtn(this)' class='hidden'>Eliminar</button><button id='cancelEditRemoteChannel' type='button' onClick='returnRemoteAppInfoTab()' class='hidden'>Cancelar canal remoto</button></div><br>--%><div><div id="saveRemoteChannel" class="button suggestedAction hidden" onClick='executeBtn(this)' title="<system:label show="tooltip" label="btnSaveRemoteChannel" />"><system:label show="text" label="btnSaveRemoteChannel" /></div><div id="deleteRemoteChannel" class="button hidden" onClick='executeBtn(this)' title="<system:label show="tooltip" label="btnDeleteRemoteChannel" />"><system:label show="text" label="btnDeleteRemoteChannel" /></div><div id="cancelEditRemoteChannel" class="button hidden" onClick='returnRemoteAppInfoTab()' title="<system:label show="tooltip" label="btnCancelEditRemoteChannel" />"><system:label show="text" label="btnCancelEditRemoteChannel" /></div></div><br><%--html.append("<label>Url para sincronizar aplicación remota: </label><input type='text' id='urlToSyncr' value='' ><button id='syncWithRemoteAppURL' type='button' onClick='executeBtn(this)'>Sincronizar</button><br>");

								html.append("<label>Url para sincronizar modelos: </label><input type='text' id='urlToSyncrMessage' value='' >");
								html.append("<label>Ambiente Apia remoto: </label><input type='text' id='remoteEnvToSyncrMessage' value='' ><button id='syncGetRemoteModelListRemoteAppURL' type='button' onClick='executeBtn(this)'>Sincronizar</button><br>");--%></div><div id="messageModelButtons" class="hidden"><%--<system:edit show="iteration" from="theBean" field="otherButtons" saveOn="parameter"><system:edit show="value" from="parameter" field="html" avoidHtmlConvert="true"/></system:edit>--%><%--<div><button id='newMessageModel' type='button' onClick='executeBtn(this)'>Agregar modelo de mensaje</button></div><br>--%><div><div id="newMessageModel" class="button suggestedAction hidden" onClick='executeBtn(this)' title="<system:label show="tooltip" label="btnNewMessageModel" />"><system:label show="text" label="btnNewMessageModel" /></div></div><br><%--<div><button id='saveMessageModel' type='button' onClick='executeBtn(this)' class='hidden'>Guardar</button><button id='deleteMessageModel' type='button' onClick='executeBtn(this)' class='hidden'>Eliminar</button><button id='cancelMessageModel' type='button' onClick='initModelsTab()' class='hidden'>Cancelar</button></div><br>--%><div><div id="saveMessageModel" class="button suggestedAction hidden" onClick='executeBtn(this)' title="<system:label show="tooltip" label="btnSaveMessageModel" />"><system:label show="text" label="btnSaveMessageModel" /></div><div id="deleteMessageModel" class="button hidden" onClick='executeBtn(this)' title="<system:label show="tooltip" label="btnDeleteMessageModel" />"><system:label show="text" label="btnDeleteMessageModel" /></div><div id="cancelMessageModel" class="button hidden" onClick='initModelsTab()' title="<system:label show="tooltip" label="btnCancelMessageModel" />"><system:label show="text" label="btnCancelMessageModel" /></div></div><br></div></div></div><system:campaign inLogin="false" inSplash="false" location="verticalDown" /></div><div class="dataContainer"><div class='tabComponent' id="tabComponent"><div class="aTabHeader"><system:campaign inLogin="false" inSplash="false" location="horizontalUp" /></div><!-- Parámetros Apia --><div class="aTab"><div class="tab" id="miApiaTab"><system:label show="text" label="tabMTParamMyApia" /></div><div class="contentTab"><div class="fieldGroup"><div class="title"><system:label show="text" label="sbtMTParamMyApia" /></div><div class="modalOptionsContainer" id="MTransferContainter1" style="min-height: 30px;"></div><div class="clear"></div></div><div class="fieldGroup"><!--<div class="title"><system:label show="text" label="sbtMTParamMyApia" /></div>--><div class="modalOptionsContainer" id="MTransferContainter2" style="min-height: 30px;"></div><div class="clear"></div></div><div class="fieldGroup"><!--<div class="title"><system:label show="text" label="sbtMTParamMyApia" /></div>--><div class="modalOptionsContainer" id="MTransferContainter3" style="min-height: 30px;"></div><div class="clear"></div></div><div class="clear"></div></div></div><!-- Canales --><div class="aTab"><div class="tab" id="channelsTab"><system:label show="text" label="tabMTChannels" /></div><div class="contentTab"><div class="fieldGroup"><div class="title"><system:label show="text" label="sbtMTChannels" /></div><div class="modalOptionsContainer" id="MTChannelsContainer1" style="min-height: 30px;"></div><div class="clear"></div></div><!-- Editar/agregar canal --><div class="fieldGroup"><div class="title"><system:label show="text" label="sbtMTChannelsEdit" /></div><div class="modalOptionsContainer" id="MTChannelsContainer2" style="min-height: 30px;"></div><div class="clear"></div></div><div class="clear"></div></div></div><!-- Publicar canales --><div class="aTab"><div class="tab" id="publishedChannelsTab"><system:label show="text" label="tabMTPublishedChannels" /></div><div class="contentTab"><div class="fieldGroup"><div class="title"><system:label show="text" label="sbtMTPublishedChannels" /></div><div class="modalOptionsContainer" id="MTPublishedChannelsContainter1" style="min-height: 30px;"></div><div class="clear"></div></div><!-- Editar/agregar canal publicado--><div class="fieldGroup"><div class="title"><system:label show="text" label="sbtMTPublishedChannelsEdit" /></div><div class="modalOptionsContainer" id="MTPublishedChannelsContainter2" style="min-height: 30px;"></div><div class="clear"></div></div><div class="clear"></div></div></div><!-- Apias Remotos --><div class="aTab"><div class="tab" id="remoteAppTab"><system:label show="text" label="tabMTRemoteApias" /></div><div class="contentTab"><div class="fieldGroup"><div class="title"><system:label show="text" label="sbtRemoteApias" /></div><div class="modalOptionsContainer" id="MTRemoteApiaContainter1" style="min-height: 30px;"></div><div class="clear"></div></div><!-- Editar/agregar App remota--><div class="fieldGroup"><div class="title"><system:label show="text" label="sbtRemoteApiaEdit" /></div><div class="modalOptionsContainer" id="MTRemoteApiaContainter2" style="min-height: 30px;"></div><div class="clear"></div></div><!-- Editar/agregar Canal remoto--><div class="fieldGroup"><!--<div class="title"><system:label show="text" label="sbtRemoteChannelEdit" /></div>--><div class="modalOptionsContainer" id="MTRemoteApiaContainter3" style="min-height: 30px;"></div><div class="clear"></div></div><div class="clear"></div></div></div><!-- Modelos --><div class="aTab"><div class="tab" id="messageModelTab"><system:label show="text" label="tabMTModels" /></div><div class="contentTab"><div class="fieldGroup"><div class="title"><system:label show="text" label="sbtMTModels" /></div><div class="modalOptionsContainer" id="MTModelsContainter1" style="min-height: 30px;"></div><div class="clear"></div></div><div class="fieldGroup"><div class="title"><system:label show="text" label="sbtMTModelEdit" /></div><div class="modalOptionsContainer" id="MTModelsContainter2" style="min-height: 30px;"></div><div class="clear"></div></div><div class="clear"></div></div></div></div><system:campaign inLogin="false" inSplash="false" location="horizontalDown" /><input type="hidden" id="currentParamTab" name="currentParamTab"></div></form></div><jsp:include page="../../includes/footer.jsp" /></body></html>

