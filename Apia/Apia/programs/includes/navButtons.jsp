 <%if (dBean.getTotalRows()!=0){%>
 <td align="left" title="<%=LabelManager.getName(labelSet,"lblTotReg")%>:<%=dBean.getTotalRows()%>">
	 <input type="hidden" id="page" name="page" value="<%=dBean.getPageNumber()%>">
	 <input type="hidden" id="hidActualPage" name="hidActualPage" value="<%=dBean.getPageNumber()%>">
	 <input type="hidden" id="hidTotalRecords" name="hidTotalRecords" value="<%=dBean.getTotalRows()%>">
	 <input type="hidden" id="hidCantPages" name="hidCantPages" value="<%=dBean.getTotalPages()%>">
   <button type="button" onclick="first()">&lt;&lt;</button>
   <button type="button" onclick="prev()">&lt;</button>
   <input value="<%=dBean.getPageNumber()%>" style="width:22px;max-width:22px;text-align:right;" name="goToPage" onkeypress="doGoToPage(event)"> <%=LabelManager.getName(labelSet,"lblNavOf")%> <%
   if (dBean.hasReachedMax()) {%>
   <B><font title="<%=LabelManager.getName(labelSet,"lblHayMasDad")%>"><%=dBean.getTotalPages()%>*</font></B>&nbsp;
   <%} else {%>
	<%=dBean.getTotalPages()%> &nbsp;
   <%}%>
   <button type="button" title="<%=LabelManager.getToolTip(labelSet,"btnNavNext")%>" onclick="next()">&gt;</button>
   <button type="button" title="<%=LabelManager.getToolTip(labelSet,"btnNavLast")%>" onclick="last()">&gt;&gt;</button>
 </td>
<%}else{%>
  <td align="left">
   <%if (dBean.hasReachedMax()) {%>
	   <%=LabelManager.getName(labelSet,"lblReaMaxFil")%>
    <%} else {%>
	   <%=LabelManager.getName(labelSet,"lblNoRet")%>
    <%}%>
  </td>
<%}%>
