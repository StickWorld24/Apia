<element name="textarea"><attGroup name="<%=LabelManager.getName(labelSet,"flaEjec")%>"><attribute name="attr" label="<%=LabelManager.getName(labelSet,"flaAtt")%>" type="modal" modalclass="design.modals.DataFinder" modalwidth="590" modalheight="380" pagedmodal="true" modalUrl="<%=Parameters.ROOT_PATH%>/flash/form_designer2/bin/attributes.jsp?tabId=<%=tab%>&tokenId=<%=token%>" modaltitle="lbl_datafinder_att_title" modaladd="openAttributeTab"><values><value><level name="id" value="" /><level name="name" value="" /></value></values></attribute><attribute prpId="19" name="prpName" prpType="S" label="<%=LabelManager.getName(labelSet,"prpName")%>" type="text" datatype="String" value=""/><attribute prpId="33" name="prpTransient" prpType="S" label="<%=LabelManager.getName(labelSet,"prpTransient")%>" type="checkbox" value="false"/><attribute prpId="16" name="prpDefault" prpType="S" label="<%=LabelManager.getName(labelSet,"prpDefault")%>" type="text" datatype="String" value=""/><attribute prpId="7" name="prpRequired" prpType="S" label="<%=LabelManager.getName(labelSet,"prpRequired")%>" type="checkbox" value="false"/><attribute prpId="93" name="prpReqTraduction" prpType="S" label="<%=LabelManager.getName(labelSet,"prpReqTraduction")%>" type="checkbox" value="false"/></attGroup><attGroup name="<%=LabelManager.getName(labelSet,"flaEve")%>"><attribute name="bussinessclasses" label="onChange" evtName="ONCHANGE" evtId="1" type="modalArray" modalclass="design.modals.EventAdder" modalwidth="700" modalheight="550" clsXml="<%=Parameters.ROOT_PATH%>/flash/form_designer2/bin/classes.jsp?tabId=<%=tab%>&tokenId=<%=token%>"><data><level width="0%" name="evtname" label="Event" type="label" hidden="true" /><level width="0%" name="evtid" label="Event" type="label" hidden="true" /><level width="70%" name="clsname" label="<%=LabelManager.getName(labelSet,"flaNom")%>" type="label" /><level width="0%" name="clsid" label="Clsid" type="label" hidden="true" /><level width="0%" name="bndid" label="Bndid" type="label" hidden="true" /><level width="0%" name="order" label="Order" type="label" hidden="true" /><level width="0%" name="binding" label="Binding" type="modalArray" modalclass="view.modal.EntityBinding" modalUrl="<%=Parameters.ROOT_PATH%>/flash/form_designer2/bin/bindings.jsp?tabId=<%=tab%>&tokenId=<%=token%>" hidden="true" ><data><level width="0%" name="id" label="Id" type="label" hidden="true" /><level width="6%" name="inout" label="<%=LabelManager.getName(labelSet,"lblInOut")%>" type="direction" /><level width="6%" name="type" label="<%=LabelManager.getName(labelSet,"flaPropType")%>" type="type" /><level width="32%" name="param" label="<%=LabelManager.getName(labelSet,"flaProPar")%>" type="label" /><level width="0%" name="desc" label="" type="label" /><level width="20%" name="valType" label="<%=LabelManager.getName(labelSet,"flaValType")%>" type="combo" value="0"><values><value label="<%=LabelManager.getName(labelSet,"flaVal")%>" value="0" show="value"/><value label="<%=LabelManager.getName(labelSet,"lblBusEntAtt")%>" value="1" show="attribute" /><value label="<%=LabelManager.getName(labelSet,"lblProAtt")%>" value="2" show="attribute" /></values></level><level width="36%" name="value" label="<%=LabelManager.getName(labelSet,"flaVal")%>" type="input" /><level width="0%" name="attributeid" label="AttributeId" type="label" hidden="true" /><level width="0%" name="attribute" label="<%=LabelManager.getName(labelSet,"flaAtt")%>" type="modal" atttype="event" hidden="true" attUrl="<%=Parameters.ROOT_PATH%>/flash/form_designer2/bin/attributes.jsp?tabId=<%=tab%>&tokenId=<%=token%>" modalwidth="590" modalheight="380" pagedmodal="true"/></data></level><level width="15%" name="condition" label="<%=LabelManager.getName(labelSet,"lblCondition")%>" type="modalArray" modalclass="design.modals.Condition" modalwidth="310" modalheight="290"><data><title>REGLAS DE SINTAXIS:</title><info>String: 'string' | Number: number | Date: [date] | Null: null 
Atributo de Entidad: ent_att('att_name') | Atributo de Proceso: pro_att('att_name') 
Operador aritmético: + , - , / , * 
Operador de comparación : &gt;, &lt;, &gt;=, &lt;=, =, !=, &lt;&gt; 
Operador booleano: and, or | Operador unario: not(expresion)
Variables globales: currentUser, currentTask, currentPool, currentStep</info></data></level><level width="15%" name="ajax" label="AJAX" type="checkbox"></level></data></attribute></attGroup><attGroup name="<%=LabelManager.getName(labelSet,"lblStyle")%>"><attribute prpId="2" name="prpReadOnly" prpType="S" label="<%=LabelManager.getName(labelSet,"prpReadOnly")%>" type="checkbox" value="false"/><attribute prpId="4" name="prpDisabled" prpType="S" label="<%=LabelManager.getName(labelSet,"prpDisabled")%>" type="checkbox" value="false"/><attribute prpId="39" name="prpInputAsText" prpType="S" label="<%=LabelManager.getName(labelSet,"prpInputAsText")%>" type="checkbox" value="false"/><attribute prpId="31" name="prpVisibilityHidden" prpType="S" label="<%=LabelManager.getName(labelSet,"prpVisibilityHidden")%>" type="checkbox" value="false"/><attribute prpId="1" name="prpSize" prpType="N" label="<%=LabelManager.getName(labelSet,"prpSize")%>" type="text" datatype="int" value=""/><attribute prpId="12" name="prpRows" prpType="N" label="<%=LabelManager.getName(labelSet,"prpRows")%>" type="text" datatype="int" value=""/><attribute prpId="5" name="prpFontColor" prpType="S" label="<%=LabelManager.getName(labelSet,"prpFontColor")%>" type="colorPicker" datatype="String" value=""/><attribute prpId="37" name="prpValColor" prpType="S" label="<%=LabelManager.getName(labelSet,"prpValColor")%>" type="colorPicker" datatype="String" value=""/><attribute prpId="90" name="prpCssClass" prpType="S" label="<%=LabelManager.getName(labelSet,"prpCssClass")%>" type="text" datatype="String" value=""/><attribute prpId="40" name="prpNoPrint" prpType="S" label="<%=LabelManager.getName(labelSet,"prpNoPrint")%>" type="checkbox" value="false"/><attribute prpId="35" name="prpToolTip" prpType="S" label="<%=LabelManager.getName(labelSet,"prpToolTip")%>" type="text" datatype="String" value=""/><attribute prpId="95" name="prpShowTooltipAsHelp" prpType="S" label="<%=LabelManager.getName(labelSet,"prpShowTooltipAsHelp")%>" type="checkbox" value="false"/></attGroup></element>