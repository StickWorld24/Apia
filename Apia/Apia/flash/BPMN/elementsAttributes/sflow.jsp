	<element name="sflow"><attGroup name=""<%=(!bpmnAtts?" notShown=\"true\"":"")%>><attribute name="conditiondocumentation" label="<%=lbl("lblbtnDocumentation")%>" type="modalArray" modalclass="view.modal.Condition" modalwidth="530" modalheight="300" use="optional" dataType="string" /><attribute label="<%=lbl("lblName")%>" name="name" type="text" change="setName" use="optional" dataType="string"/><attribute name="conditiontype" label="<%=lbl("flaTip")%>" type="combo" change="conditionChange" value="None"><values><value label="None" value="None" disable="conditionexpression,conditiondocumentation"/><value label="Expression" value="CONDITION" enable="conditionexpression,conditiondocumentation"/></values></attribute><attribute name="conditionexpression" label="<%=lbl("flaProCndMod")%>" disabled="true" type="modalArray" validateurl="<%=Parameters.ROOT_PATH%>/apia.design.BPMNProcessAction.run?action=xmlValCondition&<%=tabId%>" modalclass="view.modal.Condition" modalwidth="530" modalheight="330" ><data><%=condRules%></data></attribute><attribute label="<%=lbl("lblProDesignOld")%>" name="apiatype" type="combo" value="None" change="setApiaType"><values><value label="None" value="None" /><value label="Wizard" value="Wizard" /><value label="Loopback" value="Loopback" /></values></attribute><attribute label="ExecutionOrder" name="executionorder" type="text" use="optional" dataType="int" disabled="true"/></attGroup><attGroup name="User Defined Attributes" id="userproperties"<%=(!userAtts?" notShown=\"true\"":"")%>><attribute label="User Attributes" name="userattributes" modalwidth="310" modalheight="330" type="modalArray" modalclass="view.modal.LevelAdder"><data><level width="30%" label="<%=lbl("lblName")%>" name="name" type="text" /><level width="30%" label="<%=lbl("flaProBndTyp")%>" name="type" type="combo" value="String"><values><value label="String" value="String" /><value label="Numeric" value="Numeric" /><value label="Boolean" value="Boolean" /></values></level><level width="30%" label="<%=lbl("flaVal")%>" name="value" type="text" /></data></attribute></attGroup><%if(simAtts){%><attGroup name="Simulator" id="simulator"><attribute label="<%=lbl("lblPoolProbability")%>" name="probability" type="text" use="optional" dataType="int" value="100" /></attGroup><%}%></element>