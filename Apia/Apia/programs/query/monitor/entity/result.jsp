<%@page import="com.dogma.vo.filter.*"%><%@page import="com.dogma.util.DogmaUtil"%><%@page import="com.st.util.translator.TranslationManager"%><%@page import="com.dogma.UserData"%><DIV class="subTit"><%=LabelManager.getName(labelSet,"sbtEjeRes")%></DIV><div type="grid" id="gridList" style="height:<%=Parameters.SCREEN_LIST_SIZE%>px"><table id="tblHead" cellpadding="0" cellspacing="0"><thead><tr><th align="center" style="width:0px;display:none;" title="<%=LabelManager.getToolTip(labelSet,"lblEjeSelTod")%>"></th><% canOrderBy = dBean.getFilter().getOrderBy() != MonitorEntityFilterVo.ORDER_ID; %><th min_width="80px" style="width:80px<% if (canOrderBy) {%>;cursor:hand" onclick="orderBy('<%=MonitorEntityFilterVo.ORDER_ID%>')<%}%>" title="<%=LabelManager.getToolTip(labelSet,"lblEjeIdeEnt")%>"><%=canOrderBy?"<u>":""%><%=LabelManager.getName(labelSet,"lblEjeIdeEnt")%><%=canOrderBy?"</u>":""%></th><% canOrderBy = dBean.getFilter().getOrderBy() != MonitorEntityFilterVo.ORDER_TYPE; %><%if (!blnSpecific) {%><th min_width="150px" style="width:150px<% if (canOrderBy) {%>;cursor:hand" onclick="orderBy('<%=MonitorEntityFilterVo.ORDER_TYPE%>')<%}%>" title="<%=LabelManager.getToolTip(labelSet,"lblEjeTip")%>"><%=canOrderBy?"<u>":""%><%=LabelManager.getName(labelSet,"lblEjeTip")%><%=canOrderBy?"</u>":""%></th><%}%><% if (dBean.getEntityAttributes() == null) { %><% canOrderBy = dBean.getFilter().getOrderBy() != MonitorEntityFilterVo.ORDER_ATT_1; %><th min_width="150px" style="width:150px<% if (canOrderBy) {%>;cursor:hand" onclick="orderBy('<%=MonitorEntityFilterVo.ORDER_ATT_1%>')<%}%>" title="<%=LabelManager.getToolTip(labelSet,"lblAtt1EntNeg")%>"><%=canOrderBy?"<u>":""%><%=LabelManager.getName(labelSet,"lblAtt1EntNeg")%><%=canOrderBy?"</u>":""%></th><% canOrderBy = dBean.getFilter().getOrderBy() != MonitorEntityFilterVo.ORDER_ATT_2; %><th min_width="150px" style="width:150px<% if (canOrderBy) {%>;cursor:hand" onclick="orderBy('<%=MonitorEntityFilterVo.ORDER_ATT_2%>')<%}%>" title="<%=LabelManager.getToolTip(labelSet,"lblAtt2EntNeg")%>"><%=canOrderBy?"<u>":""%><%=LabelManager.getName(labelSet,"lblAtt2EntNeg")%><%=canOrderBy?"</u>":""%></th><% canOrderBy = dBean.getFilter().getOrderBy() != MonitorEntityFilterVo.ORDER_ATT_3; %><th min_width="150px" style="width:150px<% if (canOrderBy) {%>;cursor:hand" onclick="orderBy('<%=MonitorEntityFilterVo.ORDER_ATT_3%>')<%}%>" title="<%=LabelManager.getToolTip(labelSet,"lblAtt3EntNeg")%>"><%=canOrderBy?"<u>":""%><%=LabelManager.getName(labelSet,"lblAtt3EntNeg")%><%=canOrderBy?"</u>":""%></th><% canOrderBy = dBean.getFilter().getOrderBy() != MonitorEntityFilterVo.ORDER_ATT_4; %><th min_width="150px" style="width:150px<% if (canOrderBy) {%>;cursor:hand" onclick="orderBy('<%=MonitorEntityFilterVo.ORDER_ATT_4%>')<%}%>" title="<%=LabelManager.getToolTip(labelSet,"lblAtt4EntNeg")%>"><%=canOrderBy?"<u>":""%><%=LabelManager.getName(labelSet,"lblAtt4EntNeg")%><%=canOrderBy?"</u>":""%></th><% canOrderBy = dBean.getFilter().getOrderBy() != MonitorEntityFilterVo.ORDER_ATT_5; %><th min_width="150px" style="width:150px<% if (canOrderBy) {%>;cursor:hand" onclick="orderBy('<%=MonitorEntityFilterVo.ORDER_ATT_5%>')<%}%>" title="<%=LabelManager.getToolTip(labelSet,"lblAtt5EntNeg")%>"><%=canOrderBy?"<u>":""%><%=LabelManager.getName(labelSet,"lblAtt5EntNeg")%><%=canOrderBy?"</u>":""%></th><% canOrderBy = dBean.getFilter().getOrderBy() != MonitorEntityFilterVo.ORDER_ATT_6; %><th min_width="150px" style="width:150px<% if (canOrderBy) {%>;cursor:hand" onclick="orderBy('<%=MonitorEntityFilterVo.ORDER_ATT_6%>')<%}%>" title="<%=LabelManager.getToolTip(labelSet,"lblAtt6EntNeg")%>"><%=canOrderBy?"<u>":""%><%=LabelManager.getName(labelSet,"lblAtt6EntNeg")%><%=canOrderBy?"</u>":""%></th><% canOrderBy = dBean.getFilter().getOrderBy() != MonitorEntityFilterVo.ORDER_ATT_7; %><th min_width="150px" style="width:150px<% if (canOrderBy) {%>;cursor:hand" onclick="orderBy('<%=MonitorEntityFilterVo.ORDER_ATT_7%>')<%}%>" title="<%=LabelManager.getToolTip(labelSet,"lblAtt7EntNeg")%>"><%=canOrderBy?"<u>":""%><%=LabelManager.getName(labelSet,"lblAtt7EntNeg")%><%=canOrderBy?"</u>":""%></th><% canOrderBy = dBean.getFilter().getOrderBy() != MonitorEntityFilterVo.ORDER_ATT_8; %><th min_width="150px" style="width:150px<% if (canOrderBy) {%>;cursor:hand" onclick="orderBy('<%=MonitorEntityFilterVo.ORDER_ATT_8%>')<%}%>" title="<%=LabelManager.getToolTip(labelSet,"lblAtt8EntNeg")%>"><%=canOrderBy?"<u>":""%><%=LabelManager.getName(labelSet,"lblAtt8EntNeg")%><%=canOrderBy?"</u>":""%></th><% canOrderBy = dBean.getFilter().getOrderBy() != MonitorEntityFilterVo.ORDER_ATT_9; %><th min_width="150px" style="width:150px<% if (canOrderBy) {%>;cursor:hand" onclick="orderBy('<%=MonitorEntityFilterVo.ORDER_ATT_9%>')<%}%>" title="<%=LabelManager.getToolTip(labelSet,"lblAtt9EntNeg")%>"><%=canOrderBy?"<u>":""%><%=LabelManager.getName(labelSet,"lblAtt9EntNeg")%><%=canOrderBy?"</u>":""%></th><% canOrderBy = dBean.getFilter().getOrderBy() != MonitorEntityFilterVo.ORDER_ATT_10; %><th min_width="150px" style="width:150px<% if (canOrderBy) {%>;cursor:hand" onclick="orderBy('<%=MonitorEntityFilterVo.ORDER_ATT_10%>')<%}%>" title="<%=LabelManager.getToolTip(labelSet,"lblAtt10EntNeg")%>"><%=canOrderBy?"<u>":""%><%=LabelManager.getName(labelSet,"lblAtt10EntNeg")%><%=canOrderBy?"</u>":""%></th><% canOrderBy = dBean.getFilter().getOrderBy() != MonitorEntityFilterVo.ORDER_ATT_NUM_1; %><th min_width="150px" style="width:150px<% if (canOrderBy) {%>;cursor:hand" onclick="orderBy('<%=MonitorEntityFilterVo.ORDER_ATT_NUM_1%>')<%}%>" title="<%=LabelManager.getToolTip(labelSet,"lblAttNum1EntNeg")%>"><%=canOrderBy?"<u>":""%><%=LabelManager.getName(labelSet,"lblAttNum1EntNeg")%><%=canOrderBy?"</u>":""%></th><% canOrderBy = dBean.getFilter().getOrderBy() != MonitorEntityFilterVo.ORDER_ATT_NUM_2; %><th min_width="150px" style="width:150px<% if (canOrderBy) {%>;cursor:hand" onclick="orderBy('<%=MonitorEntityFilterVo.ORDER_ATT_NUM_2%>')<%}%>" title="<%=LabelManager.getToolTip(labelSet,"lblAttNum2EntNeg")%>"><%=canOrderBy?"<u>":""%><%=LabelManager.getName(labelSet,"lblAttNum2EntNeg")%><%=canOrderBy?"</u>":""%></th><% canOrderBy = dBean.getFilter().getOrderBy() != MonitorEntityFilterVo.ORDER_ATT_NUM_3; %><th min_width="150px" style="width:150px<% if (canOrderBy) {%>;cursor:hand" onclick="orderBy('<%=MonitorEntityFilterVo.ORDER_ATT_NUM_3%>')<%}%>" title="<%=LabelManager.getToolTip(labelSet,"lblAttNum3EntNeg")%>"><%=canOrderBy?"<u>":""%><%=LabelManager.getName(labelSet,"lblAttNum3EntNeg")%><%=canOrderBy?"</u>":""%></th><% canOrderBy = dBean.getFilter().getOrderBy() != MonitorEntityFilterVo.ORDER_ATT_NUM_4; %><th min_width="150px" style="width:150px<% if (canOrderBy) {%>;cursor:hand" onclick="orderBy('<%=MonitorEntityFilterVo.ORDER_ATT_NUM_4%>')<%}%>" title="<%=LabelManager.getToolTip(labelSet,"lblAttNum4EntNeg")%>"><%=canOrderBy?"<u>":""%><%=LabelManager.getName(labelSet,"lblAttNum4EntNeg")%><%=canOrderBy?"</u>":""%></th><% canOrderBy = dBean.getFilter().getOrderBy() != MonitorEntityFilterVo.ORDER_ATT_NUM_5; %><th min_width="150px" style="width:150px<% if (canOrderBy) {%>;cursor:hand" onclick="orderBy('<%=MonitorEntityFilterVo.ORDER_ATT_NUM_5%>')<%}%>" title="<%=LabelManager.getToolTip(labelSet,"lblAttNum5EntNeg")%>"><%=canOrderBy?"<u>":""%><%=LabelManager.getName(labelSet,"lblAttNum5EntNeg")%><%=canOrderBy?"</u>":""%></th><% canOrderBy = dBean.getFilter().getOrderBy() != MonitorEntityFilterVo.ORDER_ATT_NUM_6; %><th min_width="150px" style="width:150px<% if (canOrderBy) {%>;cursor:hand" onclick="orderBy('<%=MonitorEntityFilterVo.ORDER_ATT_NUM_6%>')<%}%>" title="<%=LabelManager.getToolTip(labelSet,"lblAttNum6EntNeg")%>"><%=canOrderBy?"<u>":""%><%=LabelManager.getName(labelSet,"lblAttNum6EntNeg")%><%=canOrderBy?"</u>":""%></th><% canOrderBy = dBean.getFilter().getOrderBy() != MonitorEntityFilterVo.ORDER_ATT_NUM_7; %><th min_width="150px" style="width:150px<% if (canOrderBy) {%>;cursor:hand" onclick="orderBy('<%=MonitorEntityFilterVo.ORDER_ATT_NUM_7%>')<%}%>" title="<%=LabelManager.getToolTip(labelSet,"lblAttNum7EntNeg")%>"><%=canOrderBy?"<u>":""%><%=LabelManager.getName(labelSet,"lblAttNum7EntNeg")%><%=canOrderBy?"</u>":""%></th><% canOrderBy = dBean.getFilter().getOrderBy() != MonitorEntityFilterVo.ORDER_ATT_NUM_8; %><th min_width="150px" style="width:150px<% if (canOrderBy) {%>;cursor:hand" onclick="orderBy('<%=MonitorEntityFilterVo.ORDER_ATT_NUM_8%>')<%}%>" title="<%=LabelManager.getToolTip(labelSet,"lblAttNum8EntNeg")%>"><%=canOrderBy?"<u>":""%><%=LabelManager.getName(labelSet,"lblAttNum8EntNeg")%><%=canOrderBy?"</u>":""%></th><% canOrderBy = dBean.getFilter().getOrderBy() != MonitorEntityFilterVo.ORDER_ATT_DTE_1; %><th min_width="150px" style="width:150px<% if (canOrderBy) {%>;cursor:hand" onclick="orderBy('<%=MonitorEntityFilterVo.ORDER_ATT_DTE_1%>')<%}%>" title="<%=LabelManager.getToolTip(labelSet,"lblAttDte1EntNeg")%>"><%=canOrderBy?"<u>":""%><%=LabelManager.getName(labelSet,"lblAttDte1EntNeg")%><%=canOrderBy?"</u>":""%></th><% canOrderBy = dBean.getFilter().getOrderBy() != MonitorEntityFilterVo.ORDER_ATT_DTE_2; %><th min_width="150px" style="width:150px<% if (canOrderBy) {%>;cursor:hand" onclick="orderBy('<%=MonitorEntityFilterVo.ORDER_ATT_DTE_2%>')<%}%>" title="<%=LabelManager.getToolTip(labelSet,"lblAttDte2EntNeg")%>"><%=canOrderBy?"<u>":""%><%=LabelManager.getName(labelSet,"lblAttDte2EntNeg")%><%=canOrderBy?"</u>":""%></th><% canOrderBy = dBean.getFilter().getOrderBy() != MonitorEntityFilterVo.ORDER_ATT_DTE_3; %><th min_width="150px" style="width:150px<% if (canOrderBy) {%>;cursor:hand" onclick="orderBy('<%=MonitorEntityFilterVo.ORDER_ATT_DTE_3%>')<%}%>" title="<%=LabelManager.getToolTip(labelSet,"lblAttDte3EntNeg")%>"><%=canOrderBy?"<u>":""%><%=LabelManager.getName(labelSet,"lblAttDte3EntNeg")%><%=canOrderBy?"</u>":""%></th><% canOrderBy = dBean.getFilter().getOrderBy() != MonitorEntityFilterVo.ORDER_ATT_DTE_4; %><th min_width="150px" style="width:150px<% if (canOrderBy) {%>;cursor:hand" onclick="orderBy('<%=MonitorEntityFilterVo.ORDER_ATT_DTE_4%>')<%}%>" title="<%=LabelManager.getToolTip(labelSet,"lblAttDte4EntNeg")%>"><%=canOrderBy?"<u>":""%><%=LabelManager.getName(labelSet,"lblAttDte4EntNeg")%><%=canOrderBy?"</u>":""%></th><% canOrderBy = dBean.getFilter().getOrderBy() != MonitorEntityFilterVo.ORDER_ATT_DTE_5; %><th min_width="150px" style="width:150px<% if (canOrderBy) {%>;cursor:hand" onclick="orderBy('<%=MonitorEntityFilterVo.ORDER_ATT_DTE_5%>')<%}%>" title="<%=LabelManager.getToolTip(labelSet,"lblAttDte5EntNeg")%>"><%=canOrderBy?"<u>":""%><%=LabelManager.getName(labelSet,"lblAttDte5EntNeg")%><%=canOrderBy?"</u>":""%></th><% canOrderBy = dBean.getFilter().getOrderBy() != MonitorEntityFilterVo.ORDER_ATT_DTE_6; %><th min_width="150px" style="width:150px<% if (canOrderBy) {%>;cursor:hand" onclick="orderBy('<%=MonitorEntityFilterVo.ORDER_ATT_DTE_6%>')<%}%>" title="<%=LabelManager.getToolTip(labelSet,"lblAttDte6EntNeg")%>"><%=canOrderBy?"<u>":""%><%=LabelManager.getName(labelSet,"lblAttDte6EntNeg")%><%=canOrderBy?"</u>":""%></th><%	} else if (dBean.getEntityAttributes() != null) {
								Iterator attributes = dBean.getEntityAttributes().iterator();
								AttributeVo att = null;
								int count = MonitorEntityFilterVo.ORDER_ATT_1;
								while (attributes.hasNext()) {
									att = (AttributeVo) attributes.next();
									canOrderBy = 
									(count == MonitorEntityFilterVo.ORDER_ATT_1 && MonitorEntityFilterVo.ORDER_ATT_1 != dBean.getFilter().getOrderBy()) ||
									(count == MonitorEntityFilterVo.ORDER_ATT_2 && MonitorEntityFilterVo.ORDER_ATT_2 != dBean.getFilter().getOrderBy()) ||
									(count == MonitorEntityFilterVo.ORDER_ATT_3 && MonitorEntityFilterVo.ORDER_ATT_3 != dBean.getFilter().getOrderBy()) ||
									(count == MonitorEntityFilterVo.ORDER_ATT_4 && MonitorEntityFilterVo.ORDER_ATT_4 != dBean.getFilter().getOrderBy()) ||
									(count == MonitorEntityFilterVo.ORDER_ATT_5 && MonitorEntityFilterVo.ORDER_ATT_5 != dBean.getFilter().getOrderBy()) ||
									(count == MonitorEntityFilterVo.ORDER_ATT_6 && MonitorEntityFilterVo.ORDER_ATT_6 != dBean.getFilter().getOrderBy()) ||
									(count == MonitorEntityFilterVo.ORDER_ATT_7 && MonitorEntityFilterVo.ORDER_ATT_7 != dBean.getFilter().getOrderBy()) ||
									(count == MonitorEntityFilterVo.ORDER_ATT_8 && MonitorEntityFilterVo.ORDER_ATT_8 != dBean.getFilter().getOrderBy()) ||
									(count == MonitorEntityFilterVo.ORDER_ATT_9 && MonitorEntityFilterVo.ORDER_ATT_9 != dBean.getFilter().getOrderBy()) ||
									(count == MonitorEntityFilterVo.ORDER_ATT_10 && MonitorEntityFilterVo.ORDER_ATT_10 != dBean.getFilter().getOrderBy()) ||
																			
									(count == MonitorEntityFilterVo.ORDER_ATT_NUM_1 && MonitorEntityFilterVo.ORDER_ATT_NUM_1 != dBean.getFilter().getOrderBy()) ||
									(count == MonitorEntityFilterVo.ORDER_ATT_NUM_2 && MonitorEntityFilterVo.ORDER_ATT_NUM_2 != dBean.getFilter().getOrderBy()) ||
									(count == MonitorEntityFilterVo.ORDER_ATT_NUM_3 && MonitorEntityFilterVo.ORDER_ATT_NUM_3 != dBean.getFilter().getOrderBy()) ||
									(count == MonitorEntityFilterVo.ORDER_ATT_NUM_4 && MonitorEntityFilterVo.ORDER_ATT_NUM_4 != dBean.getFilter().getOrderBy()) ||
									(count == MonitorEntityFilterVo.ORDER_ATT_NUM_5 && MonitorEntityFilterVo.ORDER_ATT_NUM_5 != dBean.getFilter().getOrderBy()) ||
									(count == MonitorEntityFilterVo.ORDER_ATT_NUM_6 && MonitorEntityFilterVo.ORDER_ATT_NUM_6 != dBean.getFilter().getOrderBy()) ||
									(count == MonitorEntityFilterVo.ORDER_ATT_NUM_7 && MonitorEntityFilterVo.ORDER_ATT_NUM_7 != dBean.getFilter().getOrderBy()) ||
									(count == MonitorEntityFilterVo.ORDER_ATT_NUM_8 && MonitorEntityFilterVo.ORDER_ATT_NUM_8 != dBean.getFilter().getOrderBy()) ||

									(count == MonitorEntityFilterVo.ORDER_ATT_DTE_1 && MonitorEntityFilterVo.ORDER_ATT_DTE_1 != dBean.getFilter().getOrderBy()) ||
									(count == MonitorEntityFilterVo.ORDER_ATT_DTE_2 && MonitorEntityFilterVo.ORDER_ATT_DTE_2 != dBean.getFilter().getOrderBy()) ||
									(count == MonitorEntityFilterVo.ORDER_ATT_DTE_3 && MonitorEntityFilterVo.ORDER_ATT_DTE_3 != dBean.getFilter().getOrderBy()) ||
									(count == MonitorEntityFilterVo.ORDER_ATT_DTE_4 && MonitorEntityFilterVo.ORDER_ATT_DTE_4 != dBean.getFilter().getOrderBy()) ||
									(count == MonitorEntityFilterVo.ORDER_ATT_DTE_5 && MonitorEntityFilterVo.ORDER_ATT_DTE_5 != dBean.getFilter().getOrderBy()) ||				
									(count == MonitorEntityFilterVo.ORDER_ATT_DTE_6 && MonitorEntityFilterVo.ORDER_ATT_DTE_6 != dBean.getFilter().getOrderBy());
									
									showAttValue[count - MonitorEntityFilterVo.ORDER_ATT_1] = att != null;
									if (att != null) { %><th min_width="100px" style="width:100px<% if (canOrderBy) {%>;cursor:hand" onclick="orderBy('<%=count%>')<%}%>" title="<%=dBean.fmtHTML(att.getAttDesc())%>"><%=canOrderBy?"<u>":""%><%=dBean.fmtHTML(att.getAttLabel())%><%=canOrderBy?"</u>":""%></th><%
									}
									count ++;
								} 
							}%><% canOrderBy = dBean.getFilter().getOrderBy() != MonitorEntityFilterVo.ORDER_CREATE_DATE; %><th min_width="140px" style="width:140px<% if (canOrderBy) {%>;cursor:hand" onclick="orderBy('<%=MonitorEntityFilterVo.ORDER_CREATE_DATE%>')<%}%>" title="<%=LabelManager.getToolTip(labelSet,"lblEjeFchCre")%>"><%=canOrderBy?"<u>":""%><%=LabelManager.getName(labelSet,"lblEjeFchCre")%><%=canOrderBy?"</u>":""%></th><% canOrderBy = dBean.getFilter().getOrderBy() != MonitorEntityFilterVo.ORDER_CREATE_USER; %><th min_width="110px" style="width:110px<% if (canOrderBy) {%>;cursor:hand" onclick="orderBy('<%=MonitorEntityFilterVo.ORDER_CREATE_USER%>')<%}%>" title="<%=LabelManager.getToolTip(labelSet,"lblEjeUsuCre")%>"><%=canOrderBy?"<u>":""%><%=LabelManager.getName(labelSet,"lblEjeUsuCre")%><%=canOrderBy?"</u>":""%></th></tr></thead><tbody><%	Collection col = dBean.getList();
						if (col != null) {
							Iterator it = col.iterator();
							int i = 0;
							ConsultBusEntInstancesVo consVo = null;
							while (it.hasNext()) {
								consVo = (ConsultBusEntInstancesVo) it.next();%><tr><td style="width:0px;display:none;"><input type="hidden" name="chkSel<%=i%>" value="<%=dBean.fmtInt(consVo.getBusEntInstId())%>"><input type="hidden" id="idSel" name="busEntInstId<%=i%>" value="<%=dBean.fmtInt(consVo.getBusEntInstId())%>"></td><td><%=dBean.fmtHTML(consVo.getEntityIdentification())%></td><%if (!blnSpecific) {%><td><%=dBean.fmtHTML(consVo.getEntityType()!=null?consVo.getEntityType().getBusEntTitle():"")%></td><%}%><%if (blnStatus) {%><td><%=dBean.fmtHTML(consVo.getEntityStatus()!=null?TranslationManager.getStatusTitle(consVo.getEntityStatus().getEntStaName(), ((UserData)request.getSession().getAttribute(Parameters.SESSION_ATTRIBUTE)).getEnvironmentId(), ((UserData)request.getSession().getAttribute(Parameters.SESSION_ATTRIBUTE)).getLangId()):"")%></td><%}%><%if (blnProcess) {%><td><%=dBean.fmtHTML(consVo.getProcessInstance()!=null && consVo.getProcessInstance().getProcess() != null ? consVo.getProcessInstance().getProcess().getProName():"")%></td><%}%><% for (int j = 0; j < showAttValue.length; j++) { %><%if (showAttValue[j]) {%><td <%=(consVo.getAttLabel(j) != null)?("title=\"" + dBean.fmtHTML(consVo.getAttLabel(j)) + "\""):""%>><%=dBean.fmtHTMLObject(consVo.getAttValue(j))%></td><%}%><% } %><td><%=dBean.fmtHTMLTime(consVo.getBusEntInstCreateData())%></td><td><%=dBean.fmtHTML(consVo.getBusEntInstCreateUser())%></td></tr><%i++;%><%}
						}%></tbody></table></div><table class="navBar"><COL class="col1"><COL class="col2"><tr><%@include file="../../../includes/navButtons.jsp" %><td><button type="button" onclick="btnView_click()" accesskey="<%=LabelManager.getAccessKey(labelSet,"btnView")%>" title="<%=LabelManager.getToolTip(labelSet,"btnView")%>"><%=LabelManager.getNameWAccess(labelSet,"btnView")%></button></td></tr></table>