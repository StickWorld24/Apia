/*
 * Generated by the Jasper component of Apache Tomcat
 * Version: Apache Tomcat/9.0.46
 * Generated at: 2022-01-09 03:23:16 UTC
 * Note: The last modified time of this file was set to
 *       the last modified time of the source file after
 *       generation to assist with modification tracking.
 */
package org.apache.jsp.page.splash;

import javax.servlet.*;
import javax.servlet.http.*;
import javax.servlet.jsp.*;
import com.dogma.vo.filter.QryColumnFilterVo;
import com.dogma.vo.WidQryFilterVo;
import biz.statum.apia.utils.charts.indicatorcharts.IndicatorChart;
import biz.statum.apia.utils.charts.indicatorcharts.ringcharts.CustomRingChart;
import org.jfree.data.general.DefaultPieDataset;
import java.awt.Font;
import org.jfree.ui.HorizontalAlignment;
import com.dogma.controller.ThreadData;
import com.dogma.UserData;
import com.apia.query.QueryFacade;
import com.apia.core.CoreFacade;
import com.st.util.StringUtil;
import org.jfree.chart.JFreeChart;
import com.dogma.vo.QryChartVo;
import com.dogma.vo.QueryVo;
import biz.statum.apia.utils.charts.indicatorcharts.dialcharts.DialChartScale;
import biz.statum.apia.utils.charts.indicatorcharts.thermometercharts.ThermometerChart;
import biz.statum.apia.utils.charts.indicatorcharts.countercharts.CounterChart;
import biz.statum.apia.utils.charts.indicatorcharts.dialcharts.CounterPlot;
import biz.statum.apia.utils.charts.indicatorcharts.dialcharts.DialChartOxford;
import biz.statum.apia.utils.ChartUtils;
import javax.imageio.ImageIO;
import java.awt.Graphics2D;
import java.awt.image.BufferedImage;
import biz.statum.apia.utils.charts.indicatorcharts.dialcharts.DialChartVelocimeter;
import java.util.ArrayList;
import java.awt.Color;
import org.jfree.chart.plot.dial.StandardDialRange;
import java.util.Collection;
import org.jfree.data.general.DefaultValueDataset;
import com.dogma.vo.WidgetVo;
import biz.statum.apia.utils.charts.StatumChart;
import java.awt.Image;

public final class widget_jsp extends org.apache.jasper.runtime.HttpJspBase
    implements org.apache.jasper.runtime.JspSourceDependent,
                 org.apache.jasper.runtime.JspSourceImports {


public QryColumnFilterVo getQryColumnFilterVo(Integer qryColId, Collection<QryColumnFilterVo> filters){
	if (filters!=null && filters.size()>0){
		for (QryColumnFilterVo qryColFilVo : filters) {
			if (qryColFilVo.getQryColumnVo().getQryColId().intValue() == qryColId.intValue()){
				return qryColFilVo;
			}
		}
	}
	return null;
}

  private static final javax.servlet.jsp.JspFactory _jspxFactory =
          javax.servlet.jsp.JspFactory.getDefaultFactory();

  private static java.util.Map<java.lang.String,java.lang.Long> _jspx_dependants;

  private static final java.util.Set<java.lang.String> _jspx_imports_packages;

  private static final java.util.Set<java.lang.String> _jspx_imports_classes;

  static {
    _jspx_imports_packages = new java.util.HashSet<>();
    _jspx_imports_packages.add("javax.servlet");
    _jspx_imports_packages.add("javax.servlet.http");
    _jspx_imports_packages.add("javax.servlet.jsp");
    _jspx_imports_classes = new java.util.HashSet<>();
    _jspx_imports_classes.add("java.awt.Color");
    _jspx_imports_classes.add("biz.statum.apia.utils.ChartUtils");
    _jspx_imports_classes.add("com.dogma.vo.QryChartVo");
    _jspx_imports_classes.add("biz.statum.apia.utils.charts.indicatorcharts.ringcharts.CustomRingChart");
    _jspx_imports_classes.add("biz.statum.apia.utils.charts.indicatorcharts.thermometercharts.ThermometerChart");
    _jspx_imports_classes.add("biz.statum.apia.utils.charts.indicatorcharts.dialcharts.DialChartScale");
    _jspx_imports_classes.add("java.util.ArrayList");
    _jspx_imports_classes.add("biz.statum.apia.utils.charts.indicatorcharts.IndicatorChart");
    _jspx_imports_classes.add("com.dogma.vo.QueryVo");
    _jspx_imports_classes.add("biz.statum.apia.utils.charts.indicatorcharts.dialcharts.DialChartVelocimeter");
    _jspx_imports_classes.add("biz.statum.apia.utils.charts.indicatorcharts.dialcharts.DialChartOxford");
    _jspx_imports_classes.add("java.awt.Graphics2D");
    _jspx_imports_classes.add("com.dogma.UserData");
    _jspx_imports_classes.add("org.jfree.chart.plot.dial.StandardDialRange");
    _jspx_imports_classes.add("org.jfree.chart.JFreeChart");
    _jspx_imports_classes.add("javax.imageio.ImageIO");
    _jspx_imports_classes.add("com.st.util.StringUtil");
    _jspx_imports_classes.add("com.apia.core.CoreFacade");
    _jspx_imports_classes.add("biz.statum.apia.utils.charts.indicatorcharts.dialcharts.CounterPlot");
    _jspx_imports_classes.add("com.dogma.vo.filter.QryColumnFilterVo");
    _jspx_imports_classes.add("com.dogma.vo.WidQryFilterVo");
    _jspx_imports_classes.add("java.awt.image.BufferedImage");
    _jspx_imports_classes.add("java.awt.Image");
    _jspx_imports_classes.add("java.awt.Font");
    _jspx_imports_classes.add("org.jfree.data.general.DefaultPieDataset");
    _jspx_imports_classes.add("java.util.Collection");
    _jspx_imports_classes.add("org.jfree.ui.HorizontalAlignment");
    _jspx_imports_classes.add("biz.statum.apia.utils.charts.indicatorcharts.countercharts.CounterChart");
    _jspx_imports_classes.add("biz.statum.apia.utils.charts.StatumChart");
    _jspx_imports_classes.add("org.jfree.data.general.DefaultValueDataset");
    _jspx_imports_classes.add("com.dogma.controller.ThreadData");
    _jspx_imports_classes.add("com.apia.query.QueryFacade");
    _jspx_imports_classes.add("com.dogma.vo.WidgetVo");
  }

  private volatile javax.el.ExpressionFactory _el_expressionfactory;
  private volatile org.apache.tomcat.InstanceManager _jsp_instancemanager;

  public java.util.Map<java.lang.String,java.lang.Long> getDependants() {
    return _jspx_dependants;
  }

  public java.util.Set<java.lang.String> getPackageImports() {
    return _jspx_imports_packages;
  }

  public java.util.Set<java.lang.String> getClassImports() {
    return _jspx_imports_classes;
  }

  public javax.el.ExpressionFactory _jsp_getExpressionFactory() {
    if (_el_expressionfactory == null) {
      synchronized (this) {
        if (_el_expressionfactory == null) {
          _el_expressionfactory = _jspxFactory.getJspApplicationContext(getServletConfig().getServletContext()).getExpressionFactory();
        }
      }
    }
    return _el_expressionfactory;
  }

  public org.apache.tomcat.InstanceManager _jsp_getInstanceManager() {
    if (_jsp_instancemanager == null) {
      synchronized (this) {
        if (_jsp_instancemanager == null) {
          _jsp_instancemanager = org.apache.jasper.runtime.InstanceManagerFactory.getInstanceManager(getServletConfig());
        }
      }
    }
    return _jsp_instancemanager;
  }

  public void _jspInit() {
  }

  public void _jspDestroy() {
  }

  public void _jspService(final javax.servlet.http.HttpServletRequest request, final javax.servlet.http.HttpServletResponse response)
      throws java.io.IOException, javax.servlet.ServletException {

    if (!javax.servlet.DispatcherType.ERROR.equals(request.getDispatcherType())) {
      final java.lang.String _jspx_method = request.getMethod();
      if ("OPTIONS".equals(_jspx_method)) {
        response.setHeader("Allow","GET, HEAD, POST, OPTIONS");
        return;
      }
      if (!"GET".equals(_jspx_method) && !"POST".equals(_jspx_method) && !"HEAD".equals(_jspx_method)) {
        response.setHeader("Allow","GET, HEAD, POST, OPTIONS");
        response.sendError(HttpServletResponse.SC_METHOD_NOT_ALLOWED, "JSPs only permit GET, POST or HEAD. Jasper also permits OPTIONS");
        return;
      }
    }

    final javax.servlet.jsp.PageContext pageContext;
    javax.servlet.http.HttpSession session = null;
    final javax.servlet.ServletContext application;
    final javax.servlet.ServletConfig config;
    javax.servlet.jsp.JspWriter out = null;
    final java.lang.Object page = this;
    javax.servlet.jsp.JspWriter _jspx_out = null;
    javax.servlet.jsp.PageContext _jspx_page_context = null;


    try {
      response.setContentType("text/html");
      pageContext = _jspxFactory.getPageContext(this, request, response,
      			null, true, 8192, true);
      _jspx_page_context = pageContext;
      application = pageContext.getServletContext();
      config = pageContext.getServletConfig();
      session = pageContext.getSession();
      out = pageContext.getOut();
      _jspx_out = out;


try{
	request.setCharacterEncoding(com.dogma.Parameters.APP_ENCODING);
	response.setCharacterEncoding(com.dogma.Parameters.APP_ENCODING);	
	response.setContentType("image/jpeg");
	response.setDateHeader ("Expires",0);

 	out.clear(); 
	out = pageContext.pushBody();
	java.io.OutputStream outb=response.getOutputStream();
	
	//Tamaño por defecto
	int w=220;
	int h=220;
	
	Integer valueFontSize = null;
	Integer scaleFontSize = null;
	Integer valueDecimals = Integer.valueOf(0);
	Integer valueType = Integer.valueOf(0);
	
	Image img = null;
	StatumChart chart = null;
	
	if (request.getParameter("width")!=null && !"".equals(request.getParameter("width"))) w = Integer.valueOf(request.getParameter("width")).intValue();
	if (request.getParameter("height")!=null && !"".equals(request.getParameter("height"))) h = Integer.valueOf(request.getParameter("height")).intValue();
	
	if (request.getParameter("widType")!=null){
		String widType = request.getParameter("widType");
		
		if (request.getParameter("widKpiType")!=null){
			String widKpiType = request.getParameter("widKpiType");
			
			if (WidgetVo.WIDGET_TYPE_KPI_ID == Integer.parseInt(widType)) { //Si es de tipo KPI
		
				//Recuperamos los parámetros para los widgets de tipo KPI
				double minValue = Double.parseDouble(request.getParameter("minValue"));
				double maxValue = Double.parseDouble(request.getParameter("maxValue"));
				
				String valueFontSizeStr = request.getParameter("valueFontSize");
				String backgColor = request.getParameter("backgColor");
				String ringAnchor = request.getParameter("ringAnchor");
				String pointerColor = request.getParameter("pointerColor");
				String valueColor = request.getParameter("valueColor");
				String noValueColor = request.getParameter("noValueColor");
				String valueTypeStr = request.getParameter("valueType");
				String valueDecimalsStr = request.getParameter("valueDecimals");
				String withBorder = request.getParameter("withBorder");
				String scaleFontSizeStr = request.getParameter("scaleFontSize");
				String zones = request.getParameter("zones");
				String actualValueStr = request.getParameter("actualValue");
				Integer envId = null;
				
				double actualValue = (maxValue + minValue) /2;
				
				if (!"".equals(actualValueStr)) actualValue = Double.valueOf(actualValueStr).doubleValue();
				
				if (request.getParameter("envId")!=null && !"".equals(request.getParameter("envId"))) envId = Integer.valueOf(request.getParameter("envId")); 
				
				Color backgColColor = Color.WHITE;
				Color pointerColColor = Color.ORANGE;
				Color valueColColor = Color.BLACK;
				Color noValueColColor = Color.WHITE;
				
				int fracc = (Double.valueOf(maxValue).intValue() - Double.valueOf(minValue).intValue())/3;
				int minZone1 = Double.valueOf(minValue).intValue();
				int maxZone1 = minZone1 + fracc;
				int minZone2 = maxZone1;
				int maxZone2 = minZone2 + fracc;
				int minZone3 = maxZone2;
				int maxZone3 = Double.valueOf(maxValue).intValue();
				boolean showExampleZones = false;
				String zonesArr [] = null;
				
				if (backgColor!=null){
					if (backgColor.startsWith("rgb(")) backgColor = backgColor.substring(4, backgColor.length() - 1);
					String backgColArr [] = backgColor.split(",");
					if (backgColArr.length==3) {
						backgColColor = new Color(Integer.valueOf(backgColArr[0]), Integer.valueOf(backgColArr[1]), Integer.valueOf(backgColArr[2]));
					}
				}
				
				if (pointerColor!=null){
					//pointerColor es 'rgb(255,158,2)'
					if (pointerColor.startsWith("rgb(")) pointerColor = pointerColor.substring(4, pointerColor.length() - 1);
					String pointerColorArr [] = pointerColor.split(",");
					if (pointerColorArr.length==3) {
						pointerColColor = new Color(Integer.valueOf(pointerColorArr[0]), Integer.valueOf(pointerColorArr[1]), Integer.valueOf(pointerColorArr[2]));
					}
				}
				
				if (valueColor!=null){
					if (valueColor.startsWith("rgb(")) valueColor = valueColor.substring(4, valueColor.length() - 1);
					String valueColorArr [] = valueColor.split(",");
					if (valueColorArr.length==3) {
						valueColColor = new Color(Integer.valueOf(valueColorArr[0]), Integer.valueOf(valueColorArr[1]), Integer.valueOf(valueColorArr[2]));
					}
				}
				
				if (noValueColor!=null){
					if (noValueColor.startsWith("rgb(")) noValueColor = noValueColor.substring(4, noValueColor.length() - 1);
					String noValueColorArr [] = noValueColor.split(",");
					if (noValueColorArr.length==3) {
						noValueColColor = new Color(Integer.valueOf(noValueColorArr[0]), Integer.valueOf(noValueColorArr[1]), Integer.valueOf(noValueColorArr[2]));
					}
				}
				
				if (zones!=null && !"".equals(zones)) {
					zonesArr = zones.split(";"); //Ej: ['0-10-rgb(120,120,120)-233', '10-26-rgb(255,255,0)-255']
				}
				
				DefaultValueDataset dataset = new DefaultValueDataset(actualValue); //Valor a mostrar
				
				if (valueTypeStr!=null && !"".equals(valueTypeStr)) valueType = Integer.valueOf(valueTypeStr);
				if (valueDecimalsStr!=null && !"".equals(valueDecimalsStr)) valueDecimals = Integer.valueOf(valueDecimalsStr);
				
				//Create chart
				if (WidgetVo.WIDGET_KPI_TYPE_RING_ID == Integer.parseInt(widKpiType)) { //Si es de tipo ANILLO
					
					//VALOR ACTUAL
					boolean showValue = true; //SIEMPRE SE MUESTRA EL VALOR EN EL CENTRO
					String valueFontName = CustomRingChart.RING_CHART_VALUE_FONT_NAME;
					int valueFontStyle = CustomRingChart.RING_CHART_VALUE_FONT_STYLE;
					if (valueFontSizeStr!=null && !"".equals(valueFontSizeStr)) valueFontSize = Integer.valueOf(valueFontSizeStr);
					else valueFontSize = CustomRingChart.RING_CHART_VALUE_FONT_SIZE;
					
					//TITULO
					boolean showTitle = false; //NO SE MUESTRA
					String title = "";
					HorizontalAlignment titleAlignment = HorizontalAlignment.CENTER;
					Color titleColor = new Color(240, 240, 240);
					String titleFontName = "Tahoma";
					int titleStyle = Font.BOLD;
					int titleSize = 26;
					
					//ANCHO DEL ANILLO
					double ringAnchorD = CustomRingChart.RING_CHART_RING_ANCHOR; // ANCHO POR DEFECTO
					if (ringAnchor!=null && !"".equals(ringAnchor)) ringAnchorD = Double.valueOf(ringAnchor.replace(',','.'));
					
					//COLOR QUE SE DEBE ASIGNAR A LA ZONA CON VALOR (SEGUN LAS ZONAS DEL WIDGET)
					Color colorZonaValue = null;
					Color colorZonaNoValue =  CustomRingChart.RING_CHART_NO_VALUE_COLOR; //COLOR POR DEFECTO PARA LA ZONA DE NO VALOR
					Color lastZonaColor = CustomRingChart.RING_CHART_NO_VALUE_COLOR;
					
					if (zonesArr!=null && zonesArr.length > 0){ //SI SE DEFINIERON ZONAS --> EL COLOR PARA LA ZONA DE VALOR DEPENDE DE LA ZONA EN LA QUE ESTE EL VALOR ACTUAL
						for (int i = 0; zonesArr!=null && i<zonesArr.length; i++){
							String zneDataArr [] = zonesArr[i].split("-"); 
							Integer zneMin = Double.valueOf(zneDataArr[0]).intValue();
							Integer zneMax = Double.valueOf(zneDataArr[1]).intValue();
							String zneColor = zneDataArr[2]; 
							String transp = zneDataArr[3];
							if (zneColor.startsWith("rgb(")) zneColor = zneColor.substring(4, zneColor.length() - 1);
							String zneColorArr [] = zneColor.split(",");
							if (actualValue > zneMin && actualValue <= zneMax) {
								colorZonaValue = new Color(Integer.valueOf(zneColorArr[0]), Integer.valueOf(zneColorArr[1]), Integer.valueOf(zneColorArr[2]), Integer.valueOf(transp));
							}
							lastZonaColor = new Color(Integer.valueOf(zneColorArr[0]), Integer.valueOf(zneColorArr[1]), Integer.valueOf(zneColorArr[2]), Integer.valueOf(transp));
						}
					
						if (colorZonaValue==null) colorZonaValue = lastZonaColor;
					}
					
					//CREAMOS EL CHART
					chart = ChartUtils.getRingChart(actualValue, maxValue, showValue, valueFontName, valueFontStyle, valueFontSize, valueColColor,
							valueDecimals, valueType, showTitle, title, titleAlignment, titleColor, titleFontName, titleStyle, titleSize, colorZonaValue, noValueColColor, 
							ringAnchorD);
					
					//Recuperamos la imagen con el gráfico
					img= ((CustomRingChart) chart).getChart().createBufferedImage(w,h);
					
				} else if (WidgetVo.WIDGET_KPI_TYPE_GAUGE_VELOCIMETER_ID == Integer.parseInt(widKpiType)) { //Si es de GAUGE VELOCIMETRO
					if (valueFontSizeStr!=null && !"".equals(valueFontSizeStr)) valueFontSize = Integer.valueOf(valueFontSizeStr);
					else valueFontSize = DialChartVelocimeter.DIAL_CHART_VELOCIMETER_VALUE_FONT_SIZE;
					if (scaleFontSizeStr!=null && !"".equals(scaleFontSizeStr)) scaleFontSize = Integer.valueOf(scaleFontSizeStr);
					else scaleFontSize = DialChartVelocimeter.DIAL_CHART_VELOCIMETER_SCALE_TICKS_FONT_SIZE;
					
					chart = ChartUtils.getDialChartVelocimeter(envId, dataset, minValue, maxValue, valueType, "", pointerColColor, backgColColor, valueDecimals, valueFontSize, scaleFontSize);
		
					//Definición de zonas
					if (showExampleZones) {
						Collection<StandardDialRange> stdDialRange = new ArrayList<StandardDialRange>();
						Color white = new Color(1.0f, 1.0f, 1.0f, 0.25f);
						Color red = new Color(1.0f, 0f, 0f, 0.25f);
						
						stdDialRange.add(new StandardDialRange(minZone1, maxZone1, white));
						stdDialRange.add(new StandardDialRange(minZone2, maxZone2, white));
						stdDialRange.add(new StandardDialRange(minZone3, maxZone3, red));
			            
						((DialChartVelocimeter)chart).setZones(stdDialRange, null, null); //Crea la zonas con la configuracion por defecto
					}else if (zonesArr!=null && zonesArr.length > 0){
						Collection<StandardDialRange> stdDialRange = new ArrayList<StandardDialRange>();
						for (int i = 0; i<zonesArr.length; i++){
							String zneDataArr [] = zonesArr[i].split("-"); //[0, 10, rgb(120,120,120), 255]
							Integer zneMin = Double.valueOf(zneDataArr[0]).intValue();
							Integer zneMax = Double.valueOf(zneDataArr[1]).intValue();
							String zneColor = zneDataArr[2]; //"rgb(120,120,120)"
							String transp = zneDataArr[3];
							if (zneColor.startsWith("rgb(")) zneColor = zneColor.substring(4, zneColor.length() - 1);
							String zneColorArr [] = zneColor.split(",");
							if (zneColorArr.length==3) {
								Color zneColColor = new Color(Integer.valueOf(zneColorArr[0]), Integer.valueOf(zneColorArr[1]), Integer.valueOf(zneColorArr[2]), Integer.valueOf(transp));
								stdDialRange.add(new StandardDialRange(zneMin, zneMax, zneColColor));						
							}
						}
						((DialChartVelocimeter)chart).setZones(stdDialRange,null,null); //Crea la zonas con la configuracion por defecto
					}
					
					//Recuperamos la imagen con el gráfico
					img= ((DialChartVelocimeter) chart).getChart().createBufferedImage(w,h);
					
				}else if (WidgetVo.WIDGET_KPI_TYPE_GAUGE_OXFORD_ID == Integer.parseInt(widKpiType)) { //Si es de GAUGE OXFORD
					if (valueFontSizeStr!=null && !"".equals(valueFontSizeStr)) valueFontSize = Integer.valueOf(valueFontSizeStr);
					else valueFontSize = DialChartOxford.DIAL_CHART_OXFORD_VALUE_FONT_SIZE;
					
					chart = ChartUtils.getDialChartOxford(dataset, "", "", false, minValue, maxValue, valueType, valueDecimals, valueFontSize, pointerColColor);
		
					//Agregamos las zonas
					if (showExampleZones) {
						Color white = new Color(1.0f, 1.0f, 1.0f, 1f);
						Color red = new Color(1.0f, 0f, 0f, 0.25f);
						
						((DialChartOxford)chart).addZone("Normal", minZone1, maxZone2, white);
						((DialChartOxford)chart).addZone("Critical", maxZone2, maxZone3, red);
					}else if (zonesArr!=null && zonesArr.length > 0){
						for (int i = 0; i<zonesArr.length; i++){
							String zneDataArr [] = zonesArr[i].split("-"); //[0, 10, rgb(120,120,120), 255]
							Integer zneMin = Double.valueOf(zneDataArr[0]).intValue();
							Integer zneMax = Double.valueOf(zneDataArr[1]).intValue();
							String zneColor = zneDataArr[2]; //"rgb(120,120,120)"
							String transp = zneDataArr[3];
							if (zneColor.startsWith("rgb(")) zneColor = zneColor.substring(4, zneColor.length() - 1);
							String zneColorArr [] = zneColor.split(",");
							if (zneColorArr.length==3) {
								Color zneColColor = new Color(Integer.valueOf(zneColorArr[0]), Integer.valueOf(zneColorArr[1]), Integer.valueOf(zneColorArr[2]), Integer.valueOf(transp));
								((DialChartOxford)chart).addZone("zne"+i, zneMin, zneMax, zneColColor);
							}
							
						}
					}
					
					//Recuperamos la imagen con el gráfico
					img= ((DialChartOxford) chart).getChart().createBufferedImage(w,h);
					
				}else if (WidgetVo.WIDGET_KPI_TYPE_COUNTER_ID == Integer.parseInt(widKpiType)) { //Si es de tipo contador
					if (valueFontSizeStr!=null && !"".equals(valueFontSizeStr)) valueFontSize = Integer.valueOf(valueFontSizeStr);
					else valueFontSize = CounterChart.COUNTER_VALUE_FONT_SIZE;
					boolean border = "true".equals(withBorder) || "1".equals(withBorder);
					
					// create the chart... (Este tipo de chart o no lleva zonas o lleva 3 zonas)
					chart = ChartUtils.getCounterChart(dataset, null, "", CounterPlot.COUNTER_SHAPE_RECTANGLE, valueType, valueDecimals, valueFontSize, border);
					
					if (showExampleZones) {
						((CounterChart) chart).addZone("Normal", minZone1, maxZone1, Color.GREEN);
						((CounterChart) chart).addZone("Warning", minZone2, maxZone2, Color.ORANGE);
						((CounterChart) chart).addZone("Critical", minZone3, maxZone3, Color.RED);
					}else if (zonesArr!=null && zonesArr.length > 0){
						for (int i = 0; i<zonesArr.length; i++){
							String zneDataArr [] = zonesArr[i].split("-"); //[0, 10, rgb(120,120,120), 255]
							Integer zneMin = Double.valueOf(zneDataArr[0]).intValue();
							Integer zneMax = Double.valueOf(zneDataArr[1]).intValue();
							String zneColor = zneDataArr[2]; //"rgb(120,120,120)"
							String transp = zneDataArr[3];
							if (zneColor.startsWith("rgb(")) zneColor = zneColor.substring(4, zneColor.length() - 1);
							String zneColorArr [] = zneColor.split(",");
							if (zneColorArr.length==3) {
								Color zneColColor = new Color(Integer.valueOf(zneColorArr[0]), Integer.valueOf(zneColorArr[1]), Integer.valueOf(zneColorArr[2]), Integer.valueOf(transp));
								((CounterChart) chart).addZone("zne"+i, zneMin, zneMax, zneColColor);
							}
						}
					}
					
					//Recuperamos la imagen con el gráfico
					img= ((CounterChart) chart).getChart().createBufferedImage(w,h);
					
				}else if (WidgetVo.WIDGET_KPI_TYPE_TRAFFIC_LIGHT_ID == Integer.parseInt(widKpiType)) {//Si es de tipo semaforo
					if (valueFontSizeStr!=null && !"".equals(valueFontSizeStr)) valueFontSize = Integer.valueOf(valueFontSizeStr);
					else valueFontSize = CounterChart.COUNTER_TRAFFICLIGHT1_VALUE_FONT_SIZE;
					boolean border = "true".equals(withBorder);
					
					// create the chart... (Este tipo de chart o no lleva zonas o lleva 3 zonas)
					chart = ChartUtils.getTrafficLightChart(dataset, null, "", valueType, valueDecimals, valueFontSize, valueColColor, border);
					
					if (showExampleZones) {
						((CounterChart) chart).addZone("Normal", minZone1, maxZone1, Color.GREEN);
						((CounterChart) chart).addZone("Warning", minZone2, maxZone2, Color.ORANGE);
						((CounterChart) chart).addZone("Critical", minZone3, maxZone3, Color.RED);
					}else if (zonesArr!=null && zonesArr.length > 0){
						for (int i = 0; i<zonesArr.length; i++){
							String zneDataArr [] = zonesArr[i].split("-"); //[0, 10, rgb(120,120,120), 255]
							Integer zneMin = Double.valueOf(zneDataArr[0]).intValue();
							Integer zneMax = Double.valueOf(zneDataArr[1]).intValue();
							String zneColor = zneDataArr[2]; //"rgb(120,120,120)"
							String transp = zneDataArr[3];
							if (zneColor.startsWith("rgb(")) zneColor = zneColor.substring(4, zneColor.length() - 1);
							String zneColorArr [] = zneColor.split(",");
							if (zneColorArr.length==3) {
								Color zneColColor = new Color(Integer.valueOf(zneColorArr[0]), Integer.valueOf(zneColorArr[1]), Integer.valueOf(zneColorArr[2]), Integer.valueOf(transp));
								((CounterChart) chart).addZone("zne"+i, zneMin, zneMax, zneColColor);
							}
						}
					}
					
					//Recuperamos la imagen con el gráfico
					img= ((CounterChart) chart).getChart().createBufferedImage(w,h);
				}else if (WidgetVo.WIDGET_KPI_TYPE_THERMOMETER_ID == Integer.parseInt(widKpiType)) { //Si es de tipo termometro
					if (valueFontSizeStr!=null && !"".equals(valueFontSizeStr)) valueFontSize = Integer.valueOf(valueFontSizeStr);
					else valueFontSize = ThermometerChart.THERMOMETER_VALUE_FONT_SIZE;
					boolean border = false; //"true".equals(withBorder);
					
					
					//Este indicador si o si debe llevar 3 zonas
					if (zonesArr!=null && zonesArr.length == 3){
						//Recuperamos los datos de la zona 1
						String zneDataArr [] = zonesArr[0].split("-"); //[0, 10, rgb(120,120,120), 255]
						Integer zneMin1 = Double.valueOf(zneDataArr[0]).intValue();
						Integer zneMax1 = Double.valueOf(zneDataArr[1]).intValue();
						Color zne1ColColor = null;
						
						String zneColor = zneDataArr[2]; //"rgb(120,120,120)"
						String transp = zneDataArr[3];
						if (zneColor.startsWith("rgb(")) zneColor = zneColor.substring(4, zneColor.length() - 1);
						String zneColorArr [] = zneColor.split(",");
						if (zneColorArr.length==3) {
							zne1ColColor = new Color(Integer.valueOf(zneColorArr[0]), Integer.valueOf(zneColorArr[1]), Integer.valueOf(zneColorArr[2]), Integer.valueOf(transp));
						}
						//Recuperamos los datos de la zona 2
						zneDataArr = zonesArr[1].split("-"); //[0, 10, rgb(120,120,120), 255]
						Integer zneMin2 = Double.valueOf(zneDataArr[0]).intValue();
						Integer zneMax2 = Double.valueOf(zneDataArr[1]).intValue();
						Color zne2ColColor = null;
						
						zneColor = zneDataArr[2]; //"rgb(120,120,120)"
						transp = zneDataArr[3];
						if (zneColor.startsWith("rgb(")) zneColor = zneColor.substring(4, zneColor.length() - 1);
						zneColorArr = zneColor.split(",");
						if (zneColorArr.length==3) {
							zne2ColColor = new Color(Integer.valueOf(zneColorArr[0]), Integer.valueOf(zneColorArr[1]), Integer.valueOf(zneColorArr[2]), Integer.valueOf(transp));
						}
						
						//Recuperamos los datos de la zona 3
						zneDataArr = zonesArr[2].split("-"); //[0, 10, rgb(120,120,120), 255]
						Integer zneMin3 = Double.valueOf(zneDataArr[0]).intValue();
						Integer zneMax3 = Double.valueOf(zneDataArr[1]).intValue();
						Color zne3ColColor = null;
						
						zneColor = zneDataArr[2]; //"rgb(120,120,120)"
						transp = zneDataArr[3];
						if (zneColor.startsWith("rgb(")) zneColor = zneColor.substring(4, zneColor.length() - 1);
						zneColorArr = zneColor.split(",");
						if (zneColorArr.length==3) {
							zne3ColColor = new Color(Integer.valueOf(zneColorArr[0]), Integer.valueOf(zneColorArr[1]), Integer.valueOf(zneColorArr[2]), Integer.valueOf(transp));
						}
						
						// create the chart... (Este tipo de chart lleva 3 zonas obligatoriamente)
						chart = ChartUtils.getThermometerChart(dataset, null, "", Color.LIGHT_GRAY, minValue, maxValue, valueType, valueDecimals, valueFontSize, Color.black, border, zneMax1, zneMax2, zneMax3, zne1ColColor, zne2ColColor, zne3ColColor);
					}
					
					
					//Recuperamos la imagen con el gráfico
					img= ((ThermometerChart) chart).getChart().createBufferedImage(w,h);
				}else if (WidgetVo.WIDGET_KPI_TYPE_SCALE_ID == Integer.parseInt(widKpiType)) { //Si es de tipo balanza
					if (valueFontSizeStr!=null && !"".equals(valueFontSizeStr)) valueFontSize = Integer.valueOf(valueFontSizeStr);
					else valueFontSize = DialChartScale.DIAL_CHART_SCALE_VALUE_FONT_SIZE;
					if (scaleFontSizeStr!=null && !"".equals(scaleFontSizeStr)) scaleFontSize = Integer.valueOf(scaleFontSizeStr);
					else scaleFontSize = DialChartScale.DIAL_CHART_SCALE_TICKS_FONT_SIZE;
					
					//Creamos el indicador
					chart = ChartUtils.getDialChartScale(envId, dataset, "", "", minValue, maxValue, valueType, valueFontSize, scaleFontSize, valueDecimals, pointerColColor);
		
					//A ESTE CHART NO SE LE DEFINEN ZONAS
					
					w=290;
					//Recuperamos la imagen con el gráfico
					img= ((DialChartScale) chart).getChart().createBufferedImage(w,h);
				}
			}
		}else if (WidgetVo.WIDGET_TYPE_QUERY_ID == Integer.parseInt(widType)) { //Si es de tipo CONSULTA
			
			w=450;
			h=430;//300
			
			//Recuperamos los parametros
			Integer envId = Integer.valueOf(request.getParameter("envId"));
			Integer qryId = Integer.valueOf(request.getParameter("qryId"));
			Integer chtId = Integer.valueOf(request.getParameter("chtId"));
			Integer maxCantRowToShow = Integer.valueOf(request.getParameter("maxCantRowToShow"));
			String backgColor = request.getParameter("bgc");
			
			UserData uData = ThreadData.getUserData();
			if(uData == null) {
				uData = new UserData();
	 			uData.setUserId("admin");
	 			uData.setEnvironmentId(envId);
			}
			
			
			Integer widId=0;
			try{
				widId = Integer.valueOf(request.getParameter("widId"));
			}catch(Exception e){}
			
			QueryVo queryVo = CoreFacade.getInstance().getQueryFor(QueryFacade.ACTION_API, null, null, envId, qryId, uData);
			
			Collection<WidQryFilterVo> widQryFilCol = CoreFacade.getInstance().getWidgetQryFilters(envId, widId);
			 
			
			for (WidQryFilterVo widQryFilVo : widQryFilCol) {
				QryColumnFilterVo qryColFilVo = getQryColumnFilterVo(widQryFilVo.getQryColId(), queryVo.getFilters());
				if (qryColFilVo != null) {
					qryColFilVo.setValues(new ArrayList<Object>());
					qryColFilVo.getValues().add(widQryFilVo.getQryColValue());

				}
			}

			
			
			// Recuperamos los datos devueltos por la consulta
			queryVo.setData(null);
			CoreFacade.getInstance().getQueryExecutionData(queryVo.getFilters(), null, queryVo, envId, uData);
			
			// Recuperamos el grafico
			Collection<QryChartVo> colQryChtVo = queryVo.getCharts();
			if (colQryChtVo != null) {
				for (QryChartVo qryChartVo : colQryChtVo) {
					if (qryChartVo.getQryChtId().intValue() == chtId.intValue()){
						qryChartVo.setMaxResultCount(maxCantRowToShow);
						qryChartVo.setChart(QueryFacade.getInstance().getQueryExecutionChartData(qryChartVo, queryVo.getData(), queryVo.getColumns()));
					}
				}
			}
			
			QryChartVo chartVo = queryVo.getChart(chtId);
			JFreeChart jFreeChart = chartVo.getChart();
// 			String color = new String(StringUtil.escapeStr(backgColor)); 
			
// 			int	valueR = Integer.parseInt(color.substring(1, 3), 16);
// 			int	valueG = Integer.parseInt(color.substring(3, 5), 16);
// 			int	valueB = Integer.parseInt(color.substring(5, 7), 16);
			
// 			new Color(valueR,valueG,valueB);
// 			jFreeChart.setBackgroundPaint(new Color(valueR,valueG,valueB));
			
			img = jFreeChart.createBufferedImage(w, h);
		}
		
		//Insertamos la imagen con el grafico en el jsp
		BufferedImage bi = new BufferedImage(w, h, BufferedImage.TYPE_INT_RGB);
	    Graphics2D g2d = bi.createGraphics();
	    if (g2d.drawImage(img, 0, 0,w,h,null)) ImageIO.write( bi, "png", outb);
		outb.close();
	}

} catch(Exception e){
	e.printStackTrace();
} finally {
//	Las siguientes dos lineas evitan la exception: java.lang.IllegalStateException: getOutputStream() has already been called for this response
 	out.clear();
	out = pageContext.pushBody();
}

      out.write('\r');
      out.write('\n');
    } catch (java.lang.Throwable t) {
      if (!(t instanceof javax.servlet.jsp.SkipPageException)){
        out = _jspx_out;
        if (out != null && out.getBufferSize() != 0)
          try {
            if (response.isCommitted()) {
              out.flush();
            } else {
              out.clearBuffer();
            }
          } catch (java.io.IOException e) {}
        if (_jspx_page_context != null) _jspx_page_context.handlePageException(t);
        else throw new ServletException(t);
      }
    } finally {
      _jspxFactory.releasePageContext(_jspx_page_context);
    }
  }
}
