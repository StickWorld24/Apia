<element name="form"><attGroup name="<%=LabelManager.getName(labelSet,"flaEjec")%>"><attribute prpId="36" name="prpTab" prpType="S" label="<%=LabelManager.getName(labelSet,"prpTab")%>" type="checkbox" value="false"/><attribute prpId="71" name="prpDontFireWhenInvisible" prpType="S" label="<%=LabelManager.getName(labelSet,"prpDontFireWhenInvisible")%>" type="checkbox" value="false"/></attGroup><attGroup name="<%=LabelManager.getName(labelSet,"flaEve")%>"><attribute name="bussinessclasses" label="onLoad" evtName="ONLOAD" evtId="2" type="modalArray" modalclass="design.modals.EventAdder" modalwidth="700" modalheight="550" clsXml="<%=Parameters.ROOT_PATH%>/flash/form_designer2/bin/classes.jsp?tabId=<%=tab%>&amp;tokenId=<%=token%>"><data><level width="0%" name="evtname" label="Event" type="label" hidden="true" /><level width="0%" name="evtid" label="Event" type="label" hidden="true" /><level width="80%" name="clsname" label="<%=LabelManager.getName(labelSet,"flaNom")%>" type="label" /><level width="0%" name="clsid" label="Clsid" type="label" hidden="true" /><level width="0%" name="bndid" label="Bndid" type="label" hidden="true" /><level width="0%" name="order" label="Order" type="label" hidden="true" /><level width="0%" name="binding" label="Binding" type="modalArray" modalclass="view.modal.EntityBinding" modalUrl="<%=Parameters.ROOT_PATH%>/flash/form_designer2/bin/bindings.jsp?tabId=<%=tab%>&amp;tokenId=<%=token%>" hidden="true" ><data><level width="0%" name="id" label="Id" type="label" hidden="true" /><level width="6%" name="inout" label="<%=LabelManager.getName(labelSet,"lblInOut")%>" type="direction" /><level width="6%" name="type" label="<%=LabelManager.getName(labelSet,"flaPropType")%>" type="type" /><level width="32%" name="param" label="<%=LabelManager.getName(labelSet,"flaProPar")%>" type="label" /><level width="0%" name="desc" label="" type="label" /><level width="20%" name="valType" label="<%=LabelManager.getName(labelSet,"flaValType")%>" type="combo" value="0"><values><value label="<%=LabelManager.getName(labelSet,"flaVal")%>" value="0" show="value"/><value label="<%=LabelManager.getName(labelSet,"lblBusEntAtt")%>" value="1" show="attribute" /><value label="<%=LabelManager.getName(labelSet,"lblProAtt")%>" value="2" show="attribute" /></values></level><level width="36%" name="value" label="<%=LabelManager.getName(labelSet,"flaVal")%>" type="input" /><level width="0%" name="attributeid" label="AttributeId" type="label" hidden="true" /><level width="0%" name="attribute" label="<%=LabelManager.getName(labelSet,"flaAtt")%>" type="modal" atttype="event" hidden="true" attUrl="<%=Parameters.ROOT_PATH%>/flash/form_designer2/bin/attributes.jsp?tabId=<%=tab%>&amp;tokenId=<%=token%>" modalwidth="590" modalheight="380" pagedmodal="true"/></data></level><level width="20%" name="condition" label="<%=LabelManager.getName(labelSet,"lblCondition")%>" type="modalArray" modalclass="design.modals.Condition" modalwidth="310" modalheight="290"><data><title>REGLAS DE SINTAXIS:</title><info>String: 'string' | Number: number | Date: [date] | Null: null 
Atributo de Entidad: ent_att('att_name') | Atributo de Proceso: pro_att('att_name') 
Operador aritm�tico: + , - , / , * 
Operador de comparaci�n : &gt;, &lt;, &gt;=, &lt;=, =, !=, &lt;&gt; 
Operador booleano: and, or | Operador unario: not(expresion)
Variables globales: currentUser, currentTask, currentPool, currentStep</info></data></level></data></attribute><attribute name="bussinessclasses" label="onSubmit" evtName="ONSUBMIT" evtId="3" type="modalArray" modalclass="design.modals.EventAdder" modalwidth="700" modalheight="550" clsXml="<%=Parameters.ROOT_PATH%>/flash/form_designer2/bin/classes.jsp?tabId=<%=tab%>&amp;tokenId=<%=token%>"><data><level width="0%" name="evtname" label="Event" type="label" hidden="true" /><level width="0%" name="evtid" label="Event" type="label" hidden="true" /><level width="80%" name="clsname" label="<%=LabelManager.getName(labelSet,"flaNom")%>" type="label" /><level width="0%" name="clsid" label="Clsid" type="label" hidden="true" /><level width="0%" name="bndid" label="Bndid" type="label" hidden="true" /><level width="0%" name="order" label="Order" type="label" hidden="true" /><level width="0%" name="binding" label="Binding" type="modalArray" modalclass="view.modal.EntityBinding" modalUrl="<%=Parameters.ROOT_PATH%>/flash/form_designer2/bin/bindings.jsp?tabId=<%=tab%>&amp;tokenId=<%=token%>" hidden="true" ><data><level width="0%" name="id" label="Id" type="label" hidden="true" /><level width="6%" name="inout" label="<%=LabelManager.getName(labelSet,"lblInOut")%>" type="direction" /><level width="6%" name="type" label="<%=LabelManager.getName(labelSet,"flaPropType")%>" type="type" /><level width="32%" name="param" label="<%=LabelManager.getName(labelSet,"flaProPar")%>" type="label" /><level width="0%" name="desc" label="" type="label" /><level width="20%" name="valType" label="<%=LabelManager.getName(labelSet,"flaValType")%>" type="combo" value="0"><values><value label="<%=LabelManager.getName(labelSet,"flaVal")%>" value="0" show="value"/><value label="<%=LabelManager.getName(labelSet,"lblBusEntAtt")%>" value="1" show="attribute" /><value label="<%=LabelManager.getName(labelSet,"lblProAtt")%>" value="2" show="attribute" /></values></level><level width="36%" name="value" label="<%=LabelManager.getName(labelSet,"flaVal")%>" type="input" /><level width="0%" name="attributeid" label="AttributeId" type="label" hidden="true" /><level width="0%" name="attribute" label="<%=LabelManager.getName(labelSet,"flaAtt")%>" type="modal" atttype="event" hidden="true" attUrl="<%=Parameters.ROOT_PATH%>/flash/form_designer2/bin/attributes.jsp?tabId=<%=tab%>&amp;tokenId=<%=token%>" modalwidth="590" modalheight="380" pagedmodal="true"/></data></level><level width="20%" name="condition" label="<%=LabelManager.getName(labelSet,"lblCondition")%>" type="modalArray" modalclass="design.modals.Condition" modalwidth="310" modalheight="290"><data><title>REGLAS DE SINTAXIS:</title><info>String: 'string' | Number: number | Date: [date] | Null: null 
Atributo de Entidad: ent_att('att_name') | Atributo de Proceso: pro_att('att_name') 
Operador aritm�tico: + , - , / , * 
Operador de comparaci�n : &gt;, &lt;, &gt;=, &lt;=, =, !=, &lt;&gt; 
Operador booleano: and, or | Operador unario: not(expresion)
Variables globales: currentUser, currentTask, currentPool, currentStep</info></data></level></data></attribute><attribute name="bussinessclasses" label="onReload" evtName="ONRELOAD" evtId="19" type="modalArray" modalclass="design.modals.EventAdder" modalwidth="700" modalheight="550" clsXml="<%=Parameters.ROOT_PATH%>/flash/form_designer2/bin/classes.jsp?tabId=<%=tab%>&amp;tokenId=<%=token%>"><data><level width="0%" name="evtname" label="Event" type="label" hidden="true" /><level width="0%" name="evtid" label="Event" type="label" hidden="true" /><level width="80%" name="clsname" label="<%=LabelManager.getName(labelSet,"flaNom")%>" type="label" /><level width="0%" name="clsid" label="Clsid" type="label" hidden="true" /><level width="0%" name="bndid" label="Bndid" type="label" hidden="true" /><level width="0%" name="order" label="Order" type="label" hidden="true" /><level width="0%" name="binding" label="Binding" type="modalArray" modalclass="view.modal.EntityBinding" modalUrl="<%=Parameters.ROOT_PATH%>/flash/form_designer2/bin/bindings.jsp?tabId=<%=tab%>&amp;tokenId=<%=token%>" hidden="true" ><data><level width="0%" name="id" label="Id" type="label" hidden="true" /><level width="6%" name="inout" label="<%=LabelManager.getName(labelSet,"lblInOut")%>" type="direction" /><level width="6%" name="type" label="<%=LabelManager.getName(labelSet,"flaPropType")%>" type="type" /><level width="32%" name="param" label="<%=LabelManager.getName(labelSet,"flaProPar")%>" type="label" /><level width="0%" name="desc" label="" type="label" /><level width="20%" name="valType" label="<%=LabelManager.getName(labelSet,"flaValType")%>" type="combo" value="0"><values><value label="<%=LabelManager.getName(labelSet,"flaVal")%>" value="0" show="value"/><value label="<%=LabelManager.getName(labelSet,"lblBusEntAtt")%>" value="1" show="attribute" /><value label="<%=LabelManager.getName(labelSet,"lblProAtt")%>" value="2" show="attribute" /></values></level><level width="36%" name="value" label="<%=LabelManager.getName(labelSet,"flaVal")%>" type="input" /><level width="0%" name="attributeid" label="AttributeId" type="label" hidden="true" /><level width="0%" name="attribute" label="<%=LabelManager.getName(labelSet,"flaAtt")%>" type="modal" atttype="event" hidden="true" attUrl="<%=Parameters.ROOT_PATH%>/flash/form_designer2/bin/attributes.jsp?tabId=<%=tab%>&amp;tokenId=<%=token%>" modalwidth="590" modalheight="380" pagedmodal="true"/></data></level><level width="20%" name="condition" label="<%=LabelManager.getName(labelSet,"lblCondition")%>" type="modalArray" modalclass="design.modals.Condition" modalwidth="310" modalheight="290"><data><title>REGLAS DE SINTAXIS:</title><info>String: 'string' | Number: number | Date: [date] | Null: null 
Atributo de Entidad: ent_att('att_name') | Atributo de Proceso: pro_att('att_name') 
Operador aritm�tico: + , - , / , * 
Operador de comparaci�n : &gt;, &lt;, &gt;=, &lt;=, =, !=, &lt;&gt; 
Operador booleano: and, or | Operador unario: not(expresion)
Variables globales: currentUser, currentTask, currentPool, currentStep</info></data></level></data></attribute><attribute name="bussinessclasses" label="onBeforePrint" evtName="ONBEFOREPRINT" evtId="63" type="modalArray" modalclass="design.modals.EventAdder" modalwidth="700" modalheight="550" clsXml="<%=Parameters.ROOT_PATH%>/flash/form_designer2/bin/classes.jsp?tabId=<%=tab%>&amp;tokenId=<%=token%>"><data><level width="0%" name="evtname" label="Event" type="label" hidden="true" /><level width="0%" name="evtid" label="Event" type="label" hidden="true" /><level width="80%" name="clsname" label="<%=LabelManager.getName(labelSet,"flaNom")%>" type="label" /><level width="0%" name="clsid" label="Clsid" type="label" hidden="true" /><level width="0%" name="bndid" label="Bndid" type="label" hidden="true" /><level width="0%" name="order" label="Order" type="label" hidden="true" /><level width="0%" name="binding" label="Binding" type="modalArray" modalclass="view.modal.EntityBinding" modalUrl="<%=Parameters.ROOT_PATH%>/flash/form_designer2/bin/bindings.jsp?tabId=<%=tab%>&amp;tokenId=<%=token%>" hidden="true" ><data><level width="0%" name="id" label="Id" type="label" hidden="true" /><level width="6%" name="inout" label="<%=LabelManager.getName(labelSet,"lblInOut")%>" type="direction" /><level width="6%" name="type" label="<%=LabelManager.getName(labelSet,"flaPropType")%>" type="type" /><level width="32%" name="param" label="<%=LabelManager.getName(labelSet,"flaProPar")%>" type="label" /><level width="0%" name="desc" label="" type="label" /><level width="20%" name="valType" label="<%=LabelManager.getName(labelSet,"flaValType")%>" type="combo" value="0"><values><value label="<%=LabelManager.getName(labelSet,"flaVal")%>" value="0" show="value"/><value label="<%=LabelManager.getName(labelSet,"lblBusEntAtt")%>" value="1" show="attribute" /><value label="<%=LabelManager.getName(labelSet,"lblProAtt")%>" value="2" show="attribute" /></values></level><level width="36%" name="value" label="<%=LabelManager.getName(labelSet,"flaVal")%>" type="input" /><level width="0%" name="attributeid" label="AttributeId" type="label" hidden="true" /><level width="0%" name="attribute" label="<%=LabelManager.getName(labelSet,"flaAtt")%>" type="modal" atttype="event" hidden="true" attUrl="<%=Parameters.ROOT_PATH%>/flash/form_designer2/bin/attributes.jsp?tabId=<%=tab%>&amp;tokenId=<%=token%>" modalwidth="590" modalheight="380" pagedmodal="true"/></data></level><level width="20%" name="condition" label="<%=LabelManager.getName(labelSet,"lblCondition")%>" type="modalArray" modalclass="design.modals.Condition" modalwidth="310" modalheight="290"><data><title>REGLAS DE SINTAXIS:</title><info>String: 'string' | Number: number | Date: [date] | Null: null 
Atributo de Entidad: ent_att('att_name') | Atributo de Proceso: pro_att('att_name') 
Operador aritm�tico: + , - , / , * 
Operador de comparaci�n : &gt;, &lt;, &gt;=, &lt;=, =, !=, &lt;&gt; 
Operador booleano: and, or | Operador unario: not(expresion)
Variables globales: currentUser, currentTask, currentPool, currentStep</info></data></level></data></attribute><attribute name="bussinessclasses" label="onAfterPrint" evtName="ONAFTERPRINT" evtId="64" type="modalArray" modalclass="design.modals.EventAdder" modalwidth="700" modalheight="550" clsXml="<%=Parameters.ROOT_PATH%>/flash/form_designer2/bin/classes.jsp?tabId=<%=tab%>&amp;tokenId=<%=token%>"><data><level width="0%" name="evtname" label="Event" type="label" hidden="true" /><level width="0%" name="evtid" label="Event" type="label" hidden="true" /><level width="80%" name="clsname" label="<%=LabelManager.getName(labelSet,"flaNom")%>" type="label" /><level width="0%" name="clsid" label="Clsid" type="label" hidden="true" /><level width="0%" name="bndid" label="Bndid" type="label" hidden="true" /><level width="0%" name="order" label="Order" type="label" hidden="true" /><level width="0%" name="binding" label="Binding" type="modalArray" modalclass="view.modal.EntityBinding" modalUrl="<%=Parameters.ROOT_PATH%>/flash/form_designer2/bin/bindings.jsp?tabId=<%=tab%>&amp;tokenId=<%=token%>" hidden="true" ><data><level width="0%" name="id" label="Id" type="label" hidden="true" /><level width="6%" name="inout" label="<%=LabelManager.getName(labelSet,"lblInOut")%>" type="direction" /><level width="6%" name="type" label="<%=LabelManager.getName(labelSet,"flaPropType")%>" type="type" /><level width="32%" name="param" label="<%=LabelManager.getName(labelSet,"flaProPar")%>" type="label" /><level width="0%" name="desc" label="" type="label" /><level width="20%" name="valType" label="<%=LabelManager.getName(labelSet,"flaValType")%>" type="combo" value="0"><values><value label="<%=LabelManager.getName(labelSet,"flaVal")%>" value="0" show="value"/><value label="<%=LabelManager.getName(labelSet,"lblBusEntAtt")%>" value="1" show="attribute" /><value label="<%=LabelManager.getName(labelSet,"lblProAtt")%>" value="2" show="attribute" /></values></level><level width="36%" name="value" label="<%=LabelManager.getName(labelSet,"flaVal")%>" type="input" /><level width="0%" name="attributeid" label="AttributeId" type="label" hidden="true" /><level width="0%" name="attribute" label="<%=LabelManager.getName(labelSet,"flaAtt")%>" type="modal" atttype="event" hidden="true" attUrl="<%=Parameters.ROOT_PATH%>/flash/form_designer2/bin/attributes.jsp?tabId=<%=tab%>&amp;tokenId=<%=token%>" modalwidth="590" modalheight="380" pagedmodal="true"/></data></level><level width="20%" name="condition" label="<%=LabelManager.getName(labelSet,"lblCondition")%>" type="modalArray" modalclass="design.modals.Condition" modalwidth="310" modalheight="290"><data><title>REGLAS DE SINTAXIS:</title><info>String: 'string' | Number: number | Date: [date] | Null: null 
Atributo de Entidad: ent_att('att_name') | Atributo de Proceso: pro_att('att_name') 
Operador aritm�tico: + , - , / , * 
Operador de comparaci�n : &gt;, &lt;, &gt;=, &lt;=, =, !=, &lt;&gt; 
Operador booleano: and, or | Operador unario: not(expresion)
Variables globales: currentUser, currentTask, currentPool, currentStep</info></data></level></data></attribute></attGroup><attGroup name="<%=LabelManager.getName(labelSet,"lblStyle")%>"><attribute prpId="3" name="prpFrmInvisible" prpType="S" label="<%=LabelManager.getName(labelSet,"prpFrmInvisible")%>" type="checkbox" value="false"/><attribute prpId="28" name="prpFormHidden" prpType="S" label="<%=LabelManager.getName(labelSet,"prpFormHidden")%>" type="checkbox" value="false"/><attribute prpId="29" name="prpFormClosed" prpType="S" label="<%=LabelManager.getName(labelSet,"prpFormClosed")%>" type="checkbox" value="false"/><attribute prpId="70" name="prpHighlight" prpType="S" label="<%=LabelManager.getName(labelSet,"prpHighlight")%>" type="checkbox" value="false"/></attGroup></element>