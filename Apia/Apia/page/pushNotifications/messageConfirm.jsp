<%@page import="com.dogma.vo.PushNotificationHistoryVo"%><%@page import="com.dogma.business.execution.NotificationService"%><%
//1 recibido
//2 leido
//3 borrado
//4 borrado sin ser leido
System.out.println("*****************Accion sobre mensaje " + request.getParameter("idMensaje") + ": " + request.getParameter("estado"));

Integer msgId = null;

try{
	msgId = Integer.valueOf(request.getParameter("idMensaje"));
} catch(NumberFormatException e){
	
}
if(msgId!=null) {
	String estado = request.getParameter("estado");
	NotificationService.getInstance().updatePushNotification(msgId, estado, "busClass");
}
%>