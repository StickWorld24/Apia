<%-- define a toolbar for Viewer mode --%><wcf:toolbar id="toolbar01" bundle="com.tonbeller.jpivot.toolbar.resources"><wcf:scriptbutton id="chartButton01" tooltip="toolb.chart" img="chart" model="#{chart01.visible}"/><wcf:scriptbutton id="chartPropertiesButton01" tooltip="toolb.chart.config" img="chart-config" model="#{chartform01.visible}"/><wcf:separator/><wcf:scriptbutton id="printPropertiesButton01" tooltip="toolb.print.config" img="print-config" model="#{printform01.visible}"/><wcf:imgbutton id="printpdf" tooltip="toolb.print" img="print" href="../Print?cube=01&type=1"/><wcf:imgbutton id="printxls" tooltip="toolb.excel" img="excel" href="../Print?cube=01&type=0"/><wcf:separator/><wcf:scriptbutton id="viewInfoButton01" tooltip="toolb.viewInfo" img="infoBtn" model="#{viewInfo01.visible}"/><wcf:separator/></wcf:toolbar>
	