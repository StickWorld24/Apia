<div type="tab" style="visibility:hidden" style="visibility:hidden;" tabTitle="<%=LabelManager.getToolTip(labelSet,"tabAttPro")%>" tabText="<%=LabelManager.getName(labelSet,"tabAttPro")%>"><!--     - Secci�n de atributos espec�ficos          --><table class="tblFormLayout"><COL class="col1"><COL class="col2"><COL class="col3"><COL class="col4"><tr><td title="<%=LabelManager.getToolTip(labelSet,"lblAtt1Pro")%>"><%=LabelManager.getNameWAccess(labelSet,"lblAtt1Pro")%>:</td><td><%
								attribute = (AttributeVo) attributes.get(proVo.getAttId1()); %><input type="hidden" name="hidAttId1" value="<%= (attribute != null)?attribute.getAttId().toString():"" %>"><input type="text" name="txtAttName1" readonly class='txtReadOnly' value="<%= (attribute != null)?attribute.getAttName():"" %>"><img src="<%=Parameters.ROOT_PATH%>/styles/<%= styleDirectory %>/images/btnQuery.gif" onClick="btnLoadAtt_click(1,'<%= AttributeVo.TYPE_STRING %>')" style="cursor:hand;position:static;" accesskey="<%=LabelManager.getAccessKey(labelSet,"lblAtt1Pro")%>"><button type="button" onClick="btnRemAtt_click(1,'<%= AttributeVo.TYPE_STRING %>')" title="<%=LabelManager.getToolTip(labelSet,"btnRemAtt")%>" accesskey="<%=LabelManager.getAccessKey(labelSet,"btnRemAtt")%>"><%=LabelManager.getNameWAccess(labelSet,"btnRemAtt")%></button></td><td title="<%=LabelManager.getToolTip(labelSet,"lblAttNum1EntNeg")%>"><%=LabelManager.getNameWAccess(labelSet,"lblAttNum1Pro")%>:</td><td><%
								attribute = (AttributeVo) attributes.get(proVo.getAttIdNum1()); %><input type="hidden" name="hidAttIdNum1" value="<%= (attribute != null)?attribute.getAttId().toString():"" %>"><input type="text" name="txtAttNameNum1" readonly class='txtReadOnly' value="<%= (attribute != null)?attribute.getAttName():"" %>"><img src="<%=Parameters.ROOT_PATH%>/styles/<%= styleDirectory %>/images/btnQuery.gif" onClick="btnLoadAtt_click(1,'<%= AttributeVo.TYPE_NUMERIC %>')" style="cursor:hand;position:static;" accesskey="<%=LabelManager.getAccessKey(labelSet,"lblAttNum1Pro")%>"><button type="button" onClick="btnRemAtt_click(1,'<%= AttributeVo.TYPE_NUMERIC %>')" title="<%=LabelManager.getToolTip(labelSet,"btnRemAtt")%>" accesskey="<%=LabelManager.getAccessKey(labelSet,"btnRemAtt")%>"><%=LabelManager.getNameWAccess(labelSet,"btnRemAtt")%></button></td></tr><tr><td title="<%=LabelManager.getToolTip(labelSet,"lblAtt2Pro")%>"><%=LabelManager.getNameWAccess(labelSet,"lblAtt2Pro")%>:</td><td><%
								attribute = (AttributeVo) attributes.get(proVo.getAttId2()); %><input type="hidden" name="hidAttId2" value="<%= (attribute != null)?attribute.getAttId().toString():"" %>"><input type="text" name="txtAttName2" readonly class='txtReadOnly' value="<%= (attribute != null)?attribute.getAttName():"" %>"><img src="<%=Parameters.ROOT_PATH%>/styles/<%= styleDirectory %>/images/btnQuery.gif" onClick="btnLoadAtt_click(2,'<%= AttributeVo.TYPE_STRING %>')" style="cursor:hand;position:static;" accesskey="<%=LabelManager.getAccessKey(labelSet,"lblAtt2Pro")%>"><button type="button" onClick="btnRemAtt_click(2,'<%= AttributeVo.TYPE_STRING %>')" title="<%=LabelManager.getToolTip(labelSet,"btnRemAtt")%>" accesskey="<%=LabelManager.getAccessKey(labelSet,"btnRemAtt")%>"><%=LabelManager.getNameWAccess(labelSet,"btnRemAtt")%></button></td><td title="<%=LabelManager.getToolTip(labelSet,"lblAttNum2Pro")%>"><%=LabelManager.getNameWAccess(labelSet,"lblAttNum2Pro")%>:</td><td><%
								attribute = (AttributeVo) attributes.get(proVo.getAttIdNum2()); %><input type="hidden" name="hidAttIdNum2" value="<%= (attribute != null)?attribute.getAttId().toString():"" %>"><input type="text" name="txtAttNameNum2" readonly class='txtReadOnly' value="<%= (attribute != null)?attribute.getAttName():"" %>"><img src="<%=Parameters.ROOT_PATH%>/styles/<%= styleDirectory %>/images/btnQuery.gif" onClick="btnLoadAtt_click(2,'<%= AttributeVo.TYPE_NUMERIC %>')" style="cursor:hand;position:static;" accesskey="<%=LabelManager.getAccessKey(labelSet,"lblAttNum2Pro")%>"><button type="button" onClick="btnRemAtt_click(2,'<%= AttributeVo.TYPE_NUMERIC %>')" title="<%=LabelManager.getToolTip(labelSet,"btnRemAtt")%>" accesskey="<%=LabelManager.getAccessKey(labelSet,"btnRemAtt")%>"><%=LabelManager.getNameWAccess(labelSet,"btnRemAtt")%></button></td></tr><tr><td title="<%=LabelManager.getToolTip(labelSet,"lblAtt3Pro")%>"><%=LabelManager.getNameWAccess(labelSet,"lblAtt3Pro")%>:</td><td><%
								attribute = (AttributeVo) attributes.get(proVo.getAttId3()); %><input type="hidden" name="hidAttId3" value="<%= (attribute != null)?attribute.getAttId().toString():"" %>"><input type="text" name="txtAttName3" readonly class='txtReadOnly' value="<%= (attribute != null)?attribute.getAttName():"" %>"><img src="<%=Parameters.ROOT_PATH%>/styles/<%= styleDirectory %>/images/btnQuery.gif" onClick="btnLoadAtt_click(3,'<%= AttributeVo.TYPE_STRING %>')" style="cursor:hand;position:static;" accesskey="<%=LabelManager.getAccessKey(labelSet,"lblAtt3Pro")%>"><button type="button" onClick="btnRemAtt_click(3,'<%= AttributeVo.TYPE_STRING %>')" title="<%=LabelManager.getToolTip(labelSet,"btnRemAtt")%>" accesskey="<%=LabelManager.getAccessKey(labelSet,"btnRemAtt")%>"><%=LabelManager.getNameWAccess(labelSet,"btnRemAtt")%></button></td><td title="<%=LabelManager.getToolTip(labelSet,"lblAttNum3Pro")%>"><%=LabelManager.getNameWAccess(labelSet,"lblAttNum3Pro")%>:</td><td><%
								attribute = (AttributeVo) attributes.get(proVo.getAttIdNum3()); %><input type="hidden" name="hidAttIdNum3" value="<%= (attribute != null)?attribute.getAttId().toString():"" %>"><input type="text" name="txtAttNameNum3" readonly class='txtReadOnly' value="<%= (attribute != null)?attribute.getAttName():"" %>"><img src="<%=Parameters.ROOT_PATH%>/styles/<%= styleDirectory %>/images/btnQuery.gif" onClick="btnLoadAtt_click(3,'<%= AttributeVo.TYPE_NUMERIC %>')" style="cursor:hand;position:static;" accesskey="<%=LabelManager.getAccessKey(labelSet,"lblAttNum3Pro")%>"><button type="button" onClick="btnRemAtt_click(3,'<%= AttributeVo.TYPE_NUMERIC %>')" title="<%=LabelManager.getToolTip(labelSet,"btnRemAtt")%>" accesskey="<%=LabelManager.getAccessKey(labelSet,"btnRemAtt")%>"><%=LabelManager.getNameWAccess(labelSet,"btnRemAtt")%></button></td></tr><tr><td title="<%=LabelManager.getToolTip(labelSet,"lblAtt4Pro")%>"><%=LabelManager.getNameWAccess(labelSet,"lblAtt4Pro")%>:</td><td><%
								attribute = (AttributeVo) attributes.get(proVo.getAttId4()); %><input type="hidden" name="hidAttId4" value="<%= (attribute != null)?attribute.getAttId().toString():"" %>"><input type="text" name="txtAttName4" readonly class='txtReadOnly' value="<%= (attribute != null)?attribute.getAttName():"" %>"><img src="<%=Parameters.ROOT_PATH%>/styles/<%= styleDirectory %>/images/btnQuery.gif" onClick="btnLoadAtt_click(4,'<%= AttributeVo.TYPE_STRING %>')" style="cursor:hand;position:static;" accesskey="<%=LabelManager.getAccessKey(labelSet,"lblAtt4Pro")%>"><button type="button" onClick="btnRemAtt_click(4,'<%= AttributeVo.TYPE_STRING %>')" title="<%=LabelManager.getToolTip(labelSet,"btnRemAtt")%>" accesskey="<%=LabelManager.getAccessKey(labelSet,"btnRemAtt")%>"><%=LabelManager.getNameWAccess(labelSet,"btnRemAtt")%></button></td><td title="<%=LabelManager.getToolTip(labelSet,"lblAttDte1Pro")%>"><%=LabelManager.getNameWAccess(labelSet,"lblAttDte1Pro")%>:</td><td><%
								attribute = (AttributeVo) attributes.get(proVo.getAttIdDte1()); %><input type="hidden" name="hidAttIdDte1" value="<%= (attribute != null)?attribute.getAttId().toString():"" %>"><input type="text" name="txtAttNameDte1" readonly class='txtReadOnly' value="<%= (attribute != null)?attribute.getAttName():"" %>"><img src="<%=Parameters.ROOT_PATH%>/styles/<%= styleDirectory %>/images/btnQuery.gif" onClick="btnLoadAtt_click(1,'<%= AttributeVo.TYPE_DATE %>')" style="cursor:hand;position:static;" accesskey="<%=LabelManager.getAccessKey(labelSet,"lblAttDte1Pro")%>"><button type="button" onClick="btnRemAtt_click(1,'<%= AttributeVo.TYPE_DATE%>')" title="<%=LabelManager.getToolTip(labelSet,"btnRemAtt")%>" accesskey="<%=LabelManager.getAccessKey(labelSet,"btnRemAtt")%>"><%=LabelManager.getNameWAccess(labelSet,"btnRemAtt")%></button></td></tr><tr><td title="<%=LabelManager.getToolTip(labelSet,"lblAtt5Pro")%>"><%=LabelManager.getNameWAccess(labelSet,"lblAtt5Pro")%>:</td><td><%
								attribute = (AttributeVo) attributes.get(proVo.getAttId5()); %><input type="hidden" name="hidAttId5" value="<%= (attribute != null)?attribute.getAttId().toString():"" %>"><input type="text" name="txtAttName5" readonly class='txtReadOnly' value="<%= (attribute != null)?attribute.getAttName():"" %>"><img src="<%=Parameters.ROOT_PATH%>/styles/<%= styleDirectory %>/images/btnQuery.gif" onClick="btnLoadAtt_click(5,'<%= AttributeVo.TYPE_STRING %>')" style="cursor:hand;position:static;" accesskey="<%=LabelManager.getAccessKey(labelSet,"lblAtt5Pro")%>"><button type="button" onClick="btnRemAtt_click(5,'<%= AttributeVo.TYPE_STRING %>')" title="<%=LabelManager.getToolTip(labelSet,"btnRemAtt")%>" accesskey="<%=LabelManager.getAccessKey(labelSet,"btnRemAtt")%>"><%=LabelManager.getNameWAccess(labelSet,"btnRemAtt")%></button></td><td title="<%=LabelManager.getToolTip(labelSet,"lblAttDte2Pro")%>"><%=LabelManager.getNameWAccess(labelSet,"lblAttDte2Pro")%>:</td><td><%
								attribute = (AttributeVo) attributes.get(proVo.getAttIdDte2()); %><input type="hidden" name="hidAttIdDte2" value="<%= (attribute != null)?attribute.getAttId().toString():"" %>"><input type="text" name="txtAttNameDte2" readonly class='txtReadOnly' value="<%= (attribute != null)?attribute.getAttName():"" %>"><img src="<%=Parameters.ROOT_PATH%>/styles/<%= styleDirectory %>/images/btnQuery.gif" onClick="btnLoadAtt_click(2,'<%= AttributeVo.TYPE_DATE %>')" style="cursor:hand;position:static;" accesskey="<%=LabelManager.getAccessKey(labelSet,"lblAttDte2Pro")%>"><button type="button" onClick="btnRemAtt_click(2,'<%= AttributeVo.TYPE_DATE%>')" title="<%=LabelManager.getToolTip(labelSet,"btnRemAtt")%>" accesskey="<%=LabelManager.getAccessKey(labelSet,"btnRemAtt")%>"><%=LabelManager.getNameWAccess(labelSet,"btnRemAtt")%></button></td></tr><tr><td></td><td></td><td title="<%=LabelManager.getToolTip(labelSet,"lblAttDte3Pro")%>"><%=LabelManager.getNameWAccess(labelSet,"lblAttDte3Pro")%>:</td><td><%
								attribute = (AttributeVo) attributes.get(proVo.getAttIdDte3()); %><input type="hidden" name="hidAttIdDte3" value="<%= (attribute != null)?attribute.getAttId().toString():"" %>"><input type="text" name="txtAttNameDte3" readonly class='txtReadOnly' value="<%= (attribute != null)?attribute.getAttName():"" %>"><img src="<%=Parameters.ROOT_PATH%>/styles/<%= styleDirectory %>/images/btnQuery.gif" onClick="btnLoadAtt_click(3,'<%= AttributeVo.TYPE_DATE %>')" style="cursor:hand;position:static;" accesskey="<%=LabelManager.getAccessKey(labelSet,"lblAttDte3Pro")%>"><button type="button" onClick="btnRemAtt_click(3,'<%= AttributeVo.TYPE_DATE%>')" title="<%=LabelManager.getToolTip(labelSet,"btnRemAtt")%>" accesskey="<%=LabelManager.getAccessKey(labelSet,"btnRemAtt")%>"><%=LabelManager.getNameWAccess(labelSet,"btnRemAtt")%></button></td></tr></table></div>