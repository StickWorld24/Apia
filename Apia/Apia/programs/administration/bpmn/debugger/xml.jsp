<jsp:useBean id="dBean" scope="session" class="com.dogma.bean.administration.BPMNBean"></jsp:useBean><%response.setContentType("text/xml");%><%= dBean.getDebuggerXml() %>