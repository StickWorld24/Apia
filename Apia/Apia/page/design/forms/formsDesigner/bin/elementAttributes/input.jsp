<element name="input"><attGroup name="<%=LabelManager.getName(labelSet,"flaEjec")%>"><attribute name='type' label='<%=LabelManager.getName(labelSet,"flaProTyp")%>' value='0' type='combo'><values><value label="INPUT" value="0" classname="view.fields.InputField" /><value label="COMBOBOX" value="1" classname="view.fields.ComboboxField" /><value label="CHECKBOX" value="2" classname="view.fields.CheckboxField" /><value label="RADIOBUTTON" value="3" classname="view.fields.RadiobuttonField" /><value label="HIDDEN INPUT" value="4" classname="view.fields.HiddenField" /><value label="PASSWORD" value="5" classname="view.fields.PasswordField" /></values></attribute><attribute name="attr" label="<%=LabelManager.getName(labelSet,"flaAtt")%>" type="modal" modalclass="design.modals.DataFinder" modalwidth="590" modalheight="380" pagedmodal="true" modalUrl="<%=Parameters.ROOT_PATH%>/flash/form_designer2/bin/attributes.jsp?tabId=<%=tab%>&amp;tokenId=<%=token%>" modaltitle="lbl_datafinder_att_title" modaladd="openAttributeTab"><values><value><level name="id" value="" /><level name="name" value="" /></value></values></attribute><attribute name="prpChildOrder" label="<%=LabelManager.getName(labelSet,"flaOrderInTable")%>" type="modal" modalclass="design.modals.GridOrder" only_for_grid="true"/><attribute prpId="19" name="prpName" prpType="S" label="<%=LabelManager.getName(labelSet,"prpName")%>" type="text" datatype="String" value=""/><attribute prpId="10" name="prpModal" prpType="S" label="<%=LabelManager.getName(labelSet,"prpModal")%>" type="modalErase" modalclass="design.modals.DataFinder" modalwidth="590" modalheight="380" modalUrl="<%=Parameters.ROOT_PATH%>/flash/form_designer2/bin/queries.jsp?type=10&amp;tabId=<%=tab%>&amp;tokenId=<%=token%>" modaltitle="lbl_datafinder_mdl_title"><values><value><level name="id" type="label" value="" /><level name="name" type="label" value="" /></value></values></attribute><attribute prpId="82" name="prpStoreMdlQryResult" prpType="S" label="<%=LabelManager.getName(labelSet,"prpStoreMdlQryResult")%>" type="checkbox" value="false"/><attribute prpId="33" name="prpTransient" prpType="S" label="<%=LabelManager.getName(labelSet,"prpTransient")%>" type="checkbox" value="false"/><attribute prpId="54" name="prpRegExpMessage" prpType="S" label="<%=LabelManager.getName(labelSet,"prpRegExpMessage")%>" type="text" datatype="String" value=""/><attribute prpId="53" name="prpFormula" prpType="S" label="<%=LabelManager.getName(labelSet,"prpFormula")%>" type="text" datatype="String" value=""/><attribute prpId="16" name="prpDefault" prpType="S" label="<%=LabelManager.getName(labelSet,"prpDefault")%>" type="text" datatype="String" value=""/><attribute prpId="7" name="prpRequired" prpType="S" label="<%=LabelManager.getName(labelSet,"prpRequired")%>" type="checkbox" value="false"/><attribute prpId="93" name="prpReqTraduction" prpType="S" label="<%=LabelManager.getName(labelSet,"prpReqTraduction")%>" type="checkbox" value="false"/><attribute prpId="65" name="prpGridLabel" only_for_grid="true" prpType="S" label="<%=LabelManager.getName(labelSet,"prpGridLabel")%>" type="text" datatype="String" value=""/></attGroup><attGroup name="<%=LabelManager.getName(labelSet,"flaEve")%>"><attribute name="bussinessclasses" label="onChange" evtName="ONCHANGE" evtId="1" type="modalArray" modalclass="design.modals.EventAdder" modalwidth="700" modalheight="550" clsXml="<%=Parameters.ROOT_PATH%>/flash/form_designer2/bin/classes.jsp?tabId=<%=tab%>&amp;tokenId=<%=token%>"><data><level width="0%" name="evtname" label="Event" type="label" hidden="true" /><level width="0%" name="evtid" label="Event" type="label" hidden="true" /><level width="70%" name="clsname" label="<%=LabelManager.getName(labelSet,"flaNom")%>" type="label" /><level width="0%" name="clsid" label="Clsid" type="label" hidden="true" /><level width="0%" name="bndid" label="Bndid" type="label" hidden="true" /><level width="0%" name="order" label="Order" type="label" hidden="true" /><level width="0%" name="binding" label="Binding" type="modalArray" modalclass="view.modal.EntityBinding" modalUrl="<%=Parameters.ROOT_PATH%>/flash/form_designer2/bin/bindings.jsp?tabId=<%=tab%>&amp;tokenId=<%=token%>" hidden="true" ><data><level width="0%" name="id" label="Id" type="label" hidden="true" /><level width="6%" name="inout" label="<%=LabelManager.getName(labelSet,"lblInOut")%>" type="direction" /><level width="6%" name="type" label="<%=LabelManager.getName(labelSet,"flaPropType")%>" type="type" /><level width="32%" name="param" label="<%=LabelManager.getName(labelSet,"flaProPar")%>" type="label" /><level width="0%" name="desc" label="" type="label" /><level width="20%" name="valType" label="<%=LabelManager.getName(labelSet,"flaValType")%>" type="combo" value="0"><values><value label="<%=LabelManager.getName(labelSet,"flaVal")%>" value="0" show="value"/><value label="<%=LabelManager.getName(labelSet,"lblBusEntAtt")%>" value="1" show="attribute" /><value label="<%=LabelManager.getName(labelSet,"lblProAtt")%>" value="2" show="attribute" /></values></level><level width="36%" name="value" label="<%=LabelManager.getName(labelSet,"flaVal")%>" type="input" /><level width="0%" name="attributeid" label="AttributeId" type="label" hidden="true" /><level width="0%" name="attribute" label="<%=LabelManager.getName(labelSet,"flaAtt")%>" type="modal" atttype="event" hidden="true" attUrl="<%=Parameters.ROOT_PATH%>/flash/form_designer2/bin/attributes.jsp?tabId=<%=tab%>&amp;tokenId=<%=token%>" modalwidth="590" modalheight="380" pagedmodal="true"/></data></level><level width="15%" name="condition" label="<%=LabelManager.getName(labelSet,"lblCondition")%>" type="modalArray" modalclass="design.modals.Condition" modalwidth="310" modalheight="290"><data><title>REGLAS DE SINTAXIS:</title><info>String: 'string' | Number: number | Date: [date] | Null: null 
Atributo de Entidad: ent_att('att_name') | Atributo de Proceso: pro_att('att_name') 
Operador aritm�tico: + , - , / , * 
Operador de comparaci�n : &gt;, &lt;, &gt;=, &lt;=, =, !=, &lt;&gt; 
Operador booleano: and, or | Operador unario: not(expresion)
Variables globales: currentUser, currentTask, currentPool, currentStep</info></data></level><level width="15%" name="ajax" label="AJAX" type="checkbox"></level></data></attribute><attribute name="bussinessclasses" label="onModalReturn" evtName="ONMODALRETURN" evtId="37" type="modalArray" modalclass="design.modals.EventAdder" modalwidth="700" modalheight="550" clsXml="<%=Parameters.ROOT_PATH%>/flash/form_designer2/bin/classes.jsp?tabId=<%=tab%>&amp;tokenId=<%=token%>"><data><level width="0%" name="evtname" label="Event" type="label" hidden="true" /><level width="0%" name="evtid" label="Event" type="label" hidden="true" /><level width="70%" name="clsname" label="<%=LabelManager.getName(labelSet,"flaNom")%>" type="label" /><level width="0%" name="clsid" label="Clsid" type="label" hidden="true" /><level width="0%" name="bndid" label="Bndid" type="label" hidden="true" /><level width="0%" name="order" label="Order" type="label" hidden="true" /><level width="0%" name="binding" label="Binding" type="modalArray" modalclass="view.modal.EntityBinding" modalUrl="<%=Parameters.ROOT_PATH%>/flash/form_designer2/bin/bindings.jsp?tabId=<%=tab%>&amp;tokenId=<%=token%>" hidden="true" ><data><level width="0%" name="id" label="Id" type="label" hidden="true" /><level width="6%" name="inout" label="<%=LabelManager.getName(labelSet,"lblInOut")%>" type="direction" /><level width="6%" name="type" label="<%=LabelManager.getName(labelSet,"flaPropType")%>" type="type" /><level width="32%" name="param" label="<%=LabelManager.getName(labelSet,"flaProPar")%>" type="label" /><level width="0%" name="desc" label="" type="label" /><level width="20%" name="valType" label="<%=LabelManager.getName(labelSet,"flaValType")%>" type="combo" value="0"><values><value label="<%=LabelManager.getName(labelSet,"flaVal")%>" value="0" show="value"/><value label="<%=LabelManager.getName(labelSet,"lblBusEntAtt")%>" value="1" show="attribute" /><value label="<%=LabelManager.getName(labelSet,"lblProAtt")%>" value="2" show="attribute" /></values></level><level width="36%" name="value" label="<%=LabelManager.getName(labelSet,"flaVal")%>" type="input" /><level width="0%" name="attributeid" label="AttributeId" type="label" hidden="true" /><level width="0%" name="attribute" label="<%=LabelManager.getName(labelSet,"flaAtt")%>" type="modal" atttype="event" hidden="true" attUrl="<%=Parameters.ROOT_PATH%>/flash/form_designer2/bin/attributes.jsp?tabId=<%=tab%>&amp;tokenId=<%=token%>" modalwidth="590" modalheight="380" pagedmodal="true"/></data></level><level width="15%" name="condition" label="<%=LabelManager.getName(labelSet,"lblCondition")%>" type="modalArray" modalclass="design.modals.Condition" modalwidth="310" modalheight="290"><data><title>REGLAS DE SINTAXIS:</title><info>String: 'string' | Number: number | Date: [date] | Null: null 
Atributo de Entidad: ent_att('att_name') | Atributo de Proceso: pro_att('att_name') 
Operador aritm�tico: + , - , / , * 
Operador de comparaci�n : &gt;, &lt;, &gt;=, &lt;=, =, !=, &lt;&gt; 
Operador booleano: and, or | Operador unario: not(expresion)
Variables globales: currentUser, currentTask, currentPool, currentStep</info></data></level><level width="15%" name="ajax" label="AJAX" type="checkbox"></level></data></attribute></attGroup><attGroup name="<%=LabelManager.getName(labelSet,"lblStyle")%>"><attribute prpId="2" name="prpReadOnly" prpType="S" label="<%=LabelManager.getName(labelSet,"prpReadOnly")%>" type="checkbox" value="false"/><attribute prpId="4" name="prpDisabled" prpType="S" label="<%=LabelManager.getName(labelSet,"prpDisabled")%>" type="checkbox" value="false"/><attribute prpId="39" name="prpInputAsText" prpType="S" label="<%=LabelManager.getName(labelSet,"prpInputAsText")%>" type="checkbox" value="false"/><attribute prpId="31" name="prpVisibilityHidden" prpType="S" label="<%=LabelManager.getName(labelSet,"prpVisibilityHidden")%>" type="checkbox" value="false"/><attribute prpId="1" name="prpSize" prpType="N" label="<%=LabelManager.getName(labelSet,"prpSize")%>" type="text" datatype="int" value=""/><attribute prpId="5" name="prpFontColor" prpType="S" label="<%=LabelManager.getName(labelSet,"prpFontColor")%>" type="colorPicker" datatype="String" value=""/><attribute prpId="37" name="prpValColor" prpType="S" label="<%=LabelManager.getName(labelSet,"prpValColor")%>" type="colorPicker" datatype="String" value=""/><attribute prpId="90" name="prpCssClass" prpType="S" label="<%=LabelManager.getName(labelSet,"prpCssClass")%>" type="text" datatype="String" value=""/><attribute prpId="40" name="prpNoPrint" prpType="S" label="<%=LabelManager.getName(labelSet,"prpNoPrint")%>" type="checkbox" value="false"/><attribute prpId="24" name="prpColWidth" only_for_grid="true" prpType="S" label="<%=LabelManager.getName(labelSet,"prpColWidth")%>" type="text" datatype="int" value="" /><attribute prpId="35" name="prpToolTip" prpType="S" label="<%=LabelManager.getName(labelSet,"prpToolTip")%>" type="text" datatype="String" value=""/><attribute prpId="95" name="prpShowTooltipAsHelp" prpType="S" label="<%=LabelManager.getName(labelSet,"prpShowTooltipAsHelp")%>" type="checkbox" value="false"/></attGroup><attGroup name="<%=LabelManager.getName(labelSet,"flaProBnd")%>"><attribute prpId="11" name="entBinding" label="<%=LabelManager.getName(labelSet,"flaEntBin")%>" type="modalErase" modalclass="design.modals.DataFinder" modalwidth="590" modalheight="380" modalUrl="<%=Parameters.ROOT_PATH%>/flash/form_designer2/bin/entities.jsp?tabId=<%=tab%>&amp;tokenId=<%=token%>" bindAttUrl="<%=Parameters.ROOT_PATH%>/flash/form_designer2/bin/entBindAttributes.jsp?tabId=<%=tab%>&amp;tokenId=<%=token%>" volatile_childs="" modaltitle="lbl_datafinder_ent_title"><values><value><level name="id" type="label" value="" /><level name="name" type="label" value="" /></value></values><attributes name="entBindingAsociation"></attributes></attribute></attGroup></element>