/*
 * Generated by the Jasper component of Apache Tomcat
 * Version: Apache Tomcat/9.0.46
 * Generated at: 2022-01-10 03:48:42 UTC
 * Note: The last modified time of this file was set to
 *       the last modified time of the source file after
 *       generation to assist with modification tracking.
 */
package org.apache.jsp.page.splash;

import javax.servlet.*;
import javax.servlet.http.*;
import javax.servlet.jsp.*;
import java.util.ArrayList;
import java.util.Collection;
import biz.statum.apia.utils.charts.xycharts.BarChart3D;
import biz.statum.apia.utils.charts.xycharts.LineChart;
import biz.statum.apia.utils.charts.StatumChart;
import biz.statum.apia.utils.ChartUtils;
import biz.statum.apia.utils.charts.piecharts.PieChart3D;
import org.jfree.chart.axis.ValueAxis;
import org.jfree.chart.renderer.category.BarRenderer;
import org.jfree.chart.axis.CategoryLabelPositions;
import org.jfree.chart.axis.CategoryAxis;
import org.jfree.data.category.DefaultCategoryDataset;
import org.jfree.chart.plot.PlotOrientation;
import org.jfree.chart.plot.Plot;
import java.util.HashMap;
import org.jfree.ui.RectangleInsets;
import org.jfree.chart.renderer.category.BarRenderer3D;
import biz.statum.apia.framework.splash.panels.CustomUserWorkTaskExecutionClass;
import java.text.AttributedString;
import java.text.DecimalFormat;
import org.jfree.chart.labels.StandardCategoryItemLabelGenerator;
import org.jfree.chart.labels.CategoryItemLabelGenerator;
import com.dogma.Configuration;
import org.jfree.chart.renderer.category.CategoryItemRenderer;
import org.jfree.chart.plot.CategoryPlot;
import org.jfree.chart.ChartFactory;
import org.jfree.chart.JFreeChart;
import org.jfree.chart.plot.PiePlot3D;
import org.jfree.data.general.DefaultPieDataset;
import org.jfree.data.general.PieDataset;
import org.jfree.ui.ApplicationFrame;
import org.jfree.ui.RefineryUtilities;
import org.jfree.util.Rotation;
import java.awt.image.*;
import javax.imageio.ImageIO;
import java.io.*;
import java.awt.*;
import com.st.util.*;

public final class pie_jsp extends org.apache.jasper.runtime.HttpJspBase
    implements org.apache.jasper.runtime.JspSourceDependent,
                 org.apache.jasper.runtime.JspSourceImports {

  private static final javax.servlet.jsp.JspFactory _jspxFactory =
          javax.servlet.jsp.JspFactory.getDefaultFactory();

  private static java.util.Map<java.lang.String,java.lang.Long> _jspx_dependants;

  private static final java.util.Set<java.lang.String> _jspx_imports_packages;

  private static final java.util.Set<java.lang.String> _jspx_imports_classes;

  static {
    _jspx_imports_packages = new java.util.HashSet<>();
    _jspx_imports_packages.add("java.awt");
    _jspx_imports_packages.add("javax.servlet");
    _jspx_imports_packages.add("java.awt.image");
    _jspx_imports_packages.add("com.st.util");
    _jspx_imports_packages.add("javax.servlet.http");
    _jspx_imports_packages.add("java.io");
    _jspx_imports_packages.add("javax.servlet.jsp");
    _jspx_imports_classes = new java.util.HashSet<>();
    _jspx_imports_classes.add("biz.statum.apia.utils.ChartUtils");
    _jspx_imports_classes.add("org.jfree.chart.axis.CategoryLabelPositions");
    _jspx_imports_classes.add("org.jfree.data.category.DefaultCategoryDataset");
    _jspx_imports_classes.add("org.jfree.util.Rotation");
    _jspx_imports_classes.add("java.util.HashMap");
    _jspx_imports_classes.add("org.jfree.chart.plot.PlotOrientation");
    _jspx_imports_classes.add("java.util.ArrayList");
    _jspx_imports_classes.add("biz.statum.apia.utils.charts.piecharts.PieChart3D");
    _jspx_imports_classes.add("biz.statum.apia.framework.splash.panels.CustomUserWorkTaskExecutionClass");
    _jspx_imports_classes.add("org.jfree.chart.JFreeChart");
    _jspx_imports_classes.add("javax.imageio.ImageIO");
    _jspx_imports_classes.add("org.jfree.chart.renderer.category.BarRenderer3D");
    _jspx_imports_classes.add("org.jfree.data.general.PieDataset");
    _jspx_imports_classes.add("biz.statum.apia.utils.charts.xycharts.LineChart");
    _jspx_imports_classes.add("org.jfree.chart.axis.CategoryAxis");
    _jspx_imports_classes.add("org.jfree.ui.RectangleInsets");
    _jspx_imports_classes.add("java.util.Collection");
    _jspx_imports_classes.add("org.jfree.data.general.DefaultPieDataset");
    _jspx_imports_classes.add("org.jfree.ui.ApplicationFrame");
    _jspx_imports_classes.add("java.text.DecimalFormat");
    _jspx_imports_classes.add("org.jfree.chart.axis.ValueAxis");
    _jspx_imports_classes.add("java.text.AttributedString");
    _jspx_imports_classes.add("org.jfree.chart.ChartFactory");
    _jspx_imports_classes.add("org.jfree.chart.labels.StandardCategoryItemLabelGenerator");
    _jspx_imports_classes.add("org.jfree.chart.renderer.category.CategoryItemRenderer");
    _jspx_imports_classes.add("biz.statum.apia.utils.charts.StatumChart");
    _jspx_imports_classes.add("org.jfree.ui.RefineryUtilities");
    _jspx_imports_classes.add("biz.statum.apia.utils.charts.xycharts.BarChart3D");
    _jspx_imports_classes.add("org.jfree.chart.plot.CategoryPlot");
    _jspx_imports_classes.add("org.jfree.chart.plot.Plot");
    _jspx_imports_classes.add("org.jfree.chart.labels.CategoryItemLabelGenerator");
    _jspx_imports_classes.add("com.dogma.Configuration");
    _jspx_imports_classes.add("org.jfree.chart.plot.PiePlot3D");
    _jspx_imports_classes.add("org.jfree.chart.renderer.category.BarRenderer");
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
	 
	String[] proNames = request.getParameterValues("n");
	String[] proCants = request.getParameterValues("c");
	
	double total=0;

	//Tama??o por defecto
	int w=450;
	int h=300;
	
	//Recuperamos los par??metros
	String schema = request.getParameter("s"); //schema de colores que se desea usar
	String mode = request.getParameter("v");   //tipo de grafico (pie3D, barV3d or barH3d)
	
	if (schema == null || schema.length() == 0) schema = ChartUtils.COLOR_DEFAULT; //Color por defecto en Apia
	if (mode == null || mode.length() == 0) mode = ChartUtils.CHART_PIE_3D; //Grafico por defecto para el splash

	try { w = Integer.parseInt(request.getParameter("w")); } catch (Exception e) {}
	try { h = Integer.parseInt(request.getParameter("h")); } catch (Exception e) {}
	
	String title = request.getParameter("title"); //T??tulo del grafico
	if (title == null) title = "";
	
	String avoidLegend = request.getParameter("avoidLegend");
	String avoidLabels = request.getParameter("avoidLabels");
	boolean showLegend = false; //avoidLegend == null || "false".equalsIgnoreCase(avoidLegend);
	boolean showLabels = proNames.length <= 10; //avoidLegend == null || "false".equalsIgnoreCase(avoidLabels);
	
	Image img = null;
	Collection<Comparable> categories = new ArrayList<Comparable>();
	
	//Create chart
	if (ChartUtils.CHART_PIE_3D.equals(mode)) { //Si es de tipo torta 3d
		
		//Creamos el dataset a utilizar
		DefaultPieDataset dataset = new DefaultPieDataset();
		for(int i=0;i<proNames.length;i++) total+=Double.parseDouble(proCants[i]);
		for(int i=0;i<proNames.length;i++){
			dataset.setValue(proNames[i],(Double.parseDouble(proCants[i])*100)/total);
			categories.add(proNames[i]);
		}
		
		//Creamos el chart
		PieChart3D chart  = ChartUtils.getPieChart3D(dataset, "", showLegend);

		//Seteamos el formato definido por defecto por Apia
		chart.setColorSchema(schema);
		chart.setApiaDefaultFormat(categories);
		
		//Recuperamos la imagen con el gr??fico
		img= chart.getChart().createBufferedImage(w,h);
		
	}else { //es de tipo barras

		//Creamos el dataset a utilizar
		DefaultCategoryDataset dataset = new DefaultCategoryDataset();
		for(int i=0;i<proNames.length;i++) {
			dataset.addValue(Double.parseDouble(proCants[i]), "", proNames[i]);
			categories.add(proNames[i]);
		}
		
		//Recuperamos la orientaci??n definida para el bar actual
		PlotOrientation orientation = PlotOrientation.VERTICAL;
		if (ChartUtils.CHART_BAR_H_3D.equals(mode)) orientation = PlotOrientation.HORIZONTAL;
		
		//Creamos el chart
		BarChart3D chart = ChartUtils.getBarChart3D(dataset, title, "", "", orientation, showLegend, false, false);
		
		//Seteamos el formato definido por defecto por Apia
		chart.setColorSchema(schema);
		chart.setApiaDefaultFormat();
		
		//Recuperamos la imagen con el gr??fico
		img= chart.getChart().createBufferedImage(w,h);
	}
	
	//Insertamos la imagen con el grafico en el jsp
	BufferedImage bi = new BufferedImage(w, h, BufferedImage.TYPE_INT_RGB);
    Graphics2D g2d = bi.createGraphics();
    g2d.drawImage(img, 0, 0,w,h,null);
	ImageIO.write( bi, "png", outb);
	outb.close();
	

} catch(Exception e){
	
	e.printStackTrace();
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
