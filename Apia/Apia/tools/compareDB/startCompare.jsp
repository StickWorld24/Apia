<%@include file="../../components/scripts/server/startInc.jsp" %><HTML XMLNS:CONTROL><head><%@include file="../../components/scripts/server/headInclude.jsp" %></head><body><TABLE class="pageTop"><COL class="col1"><COL class="col2"><TR><TD>Compare DB</TD><TD></TD></TR></TABLE><div id="divContent"><form method="post" action="compare.jsp"><br><br>
	&nbsp;&nbsp;&nbsp;&nbsp;Tmp Path : <input name="tmpPath" value="d:\tmp"><br><br><table width = 100%><tr><td width=50%><B>FROM </B></td><td width=50%><B>TO </B></td></tr><tr><td width=50%> driver : <input name="driverFrom" value="ORACLE"></td><td width=50%> driver : <input name="driverTo" value="ORACLE"></td></tr><tr><td width=50%> envId : <input name="envIdFrom" value="1022"></td><td width=50%> envId : <input name="envIdTo" value="1022"></td></tr><tr><td width=50%> dbUrl : <input name="dbUrlFrom" value="jdbc:ORACLE:thin:@sttest01:1521:apiaperf"></td><td width=50%> dbUrl : <input name="dbUrlTo" value="jdbc:ORACLE:thin:@sttest01:1521:apiaperf" ></td></tr><tr><td width=50%> dbUsr : <input name="dbUsrFrom" value="vivo22_01"></td><td width=50%> dbUsr : <input name="dbUsrTo" value="vivo22_01"></td></tr><tr><td width=50%> dbPass : <input name="dbPassFrom" value="apia"></td><td width=50%> dbPass : <input name="dbPassTo" value="apia"></td></tr></table><BR><BR><input type=submit></form></div><TABLE class="pageBottom"><COL class="col1"><COL class="col2"><TR><TD></TD><TD><button>Cancel</button></TD></TR></TABLE></body></html>