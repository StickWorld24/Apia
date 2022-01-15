<%-- define a toolbar for Navigator mode --%><wcf:toolbar id="toolbar01" bundle="com.tonbeller.jpivot.toolbar.resources"><wcf:scriptbutton id="cubeNaviButton" tooltip="toolb.cube" img="cube" model="#{navi01.visible}"/><wcf:scriptbutton id="mdxEditButton" tooltip="toolb.mdx.edit" img="mdx-edit" model="#{mdxedit01.visible}"/><wcf:scriptbutton id="sortConfigButton" tooltip="toolb.table.config" img="sort-asc" model="#{sortform01.visible}"/><wcf:separator/><wcf:scriptbutton id="levelStyle" tooltip="toolb.level.style" img="level-style" model="#{table01.extensions.axisStyle.levelStyle}"/><wcf:scriptbutton id="hideSpans" tooltip="toolb.hide.spans" img="hide-spans" model="#{table01.extensions.axisStyle.hideSpans}"/><wcf:scriptbutton id="nonEmpty" tooltip="toolb.non.empty" img="non-empty" model="#{table01.extensions.nonEmpty.buttonPressed}"/><wcf:scriptbutton id="swapAxes" tooltip="toolb.swap.axes" img="swap-axes" model="#{table01.extensions.swapAxes.buttonPressed}"/><wcf:separator/><wcf:scriptbutton model="#{table01.extensions.drillMember.enabled}"	 tooltip="toolb.navi.member" radioGroup="navi" id="drillMember"   img="navi-member"/><wcf:scriptbutton model="#{table01.extensions.drillPosition.enabled}" tooltip="toolb.navi.position" radioGroup="navi" id="drillPosition" img="navi-position"/><wcf:scriptbutton model="#{table01.extensions.drillReplace.enabled}"	 tooltip="toolb.navi.replace" radioGroup="navi" id="drillReplace"  img="navi-replace"/><wcf:scriptbutton model="#{table01.extensions.drillThrough.enabled}"  tooltip="toolb.navi.drillthru" id="drillThrough01"  img="navi-through"/><wcf:separator/><wcf:scriptbutton id="chartButton01" tooltip="toolb.chart" img="chart" model="#{chart01.visible}"/><wcf:scriptbutton id="chartPropertiesButton01" tooltip="toolb.chart.config" img="chart-config" model="#{chartform01.visible}"/><wcf:separator/><wcf:scriptbutton id="printPropertiesButton01" tooltip="toolb.print.config" img="print-config" model="#{printform01.visible}"/><wcf:imgbutton id="printpdf" tooltip="toolb.print" img="print" href="../Print?cube=01&type=1"/><wcf:imgbutton id="printxls" tooltip="toolb.excel" img="excel" href="../Print?cube=01&type=0"/><wcf:separator/><wcf:scriptbutton id="saveButton01" tooltip="toolb.viewAdmin" img="confBtn" model="#{savebrowser01.visible}"/></wcf:toolbar>