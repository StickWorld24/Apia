/*
 * Generated by the Jasper component of Apache Tomcat
 * Version: Apache Tomcat/9.0.46
 * Generated at: 2022-01-11 03:25:02 UTC
 * Note: The last modified time of this file was set to
 *       the last modified time of the source file after
 *       generation to assist with modification tracking.
 */
package org.apache.jsp.page.execution.includes;

import javax.servlet.*;
import javax.servlet.http.*;
import javax.servlet.jsp.*;

public final class entityVisibilities_jsp extends org.apache.jasper.runtime.HttpJspBase
    implements org.apache.jasper.runtime.JspSourceDependent,
                 org.apache.jasper.runtime.JspSourceImports {

  private static final javax.servlet.jsp.JspFactory _jspxFactory =
          javax.servlet.jsp.JspFactory.getDefaultFactory();

  private static java.util.Map<java.lang.String,java.lang.Long> _jspx_dependants;

  static {
    _jspx_dependants = new java.util.HashMap<java.lang.String,java.lang.Long>(3);
    _jspx_dependants.put("/WEB-INF/system-tags.tld", Long.valueOf(1637234098211L));
    _jspx_dependants.put("/page/execution/includes/../../generic/visibilities.jsp", Long.valueOf(1637234318628L));
    _jspx_dependants.put("/WEB-INF/regions.tld", Long.valueOf(1637234098043L));
  }

  private static final java.util.Set<java.lang.String> _jspx_imports_packages;

  private static final java.util.Set<java.lang.String> _jspx_imports_classes;

  static {
    _jspx_imports_packages = new java.util.HashSet<>();
    _jspx_imports_packages.add("javax.servlet");
    _jspx_imports_packages.add("javax.servlet.http");
    _jspx_imports_packages.add("javax.servlet.jsp");
    _jspx_imports_classes = null;
  }

  private org.apache.jasper.runtime.TagHandlerPool _005fjspx_005ftagPool_005fsystem_005flabel_0026_005fshow_005flabel_005fnobody;

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
    _005fjspx_005ftagPool_005fsystem_005flabel_0026_005fshow_005flabel_005fnobody = org.apache.jasper.runtime.TagHandlerPool.getTagHandlerPool(getServletConfig());
  }

  public void _jspDestroy() {
    _005fjspx_005ftagPool_005fsystem_005flabel_0026_005fshow_005flabel_005fnobody.release();
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

      out.write("<div class=\"tabContent\"><div class=\"fieldGroup\"><div class=\"title\">");
      if (_jspx_meth_system_005flabel_005f0(_jspx_page_context))
        return;
      out.write("</div>");
      out.write("<div class=\"fieldGroup\" id=\"visContent\"><div class=\"modalOptionsContainer\" id=\"poolsContainter\"><div class=\"element\" id=\"addPool\" data-helper=\"true\" tabIndex=\"0\"><div class=\"option optionAdd\">");
      if (_jspx_meth_system_005flabel_005f1(_jspx_page_context))
        return;
      out.write("</div></div></div><div class=\"clear\"></div></div>");
      out.write("</div></div>");
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

  private boolean _jspx_meth_system_005flabel_005f0(javax.servlet.jsp.PageContext _jspx_page_context)
          throws java.lang.Throwable {
    javax.servlet.jsp.PageContext pageContext = _jspx_page_context;
    javax.servlet.jsp.JspWriter out = _jspx_page_context.getOut();
    //  system:label
    biz.statum.apia.web.tag.other.LabelTag _jspx_th_system_005flabel_005f0 = (biz.statum.apia.web.tag.other.LabelTag) _005fjspx_005ftagPool_005fsystem_005flabel_0026_005fshow_005flabel_005fnobody.get(biz.statum.apia.web.tag.other.LabelTag.class);
    boolean _jspx_th_system_005flabel_005f0_reused = false;
    try {
      _jspx_th_system_005flabel_005f0.setPageContext(_jspx_page_context);
      _jspx_th_system_005flabel_005f0.setParent(null);
      // /page/execution/includes/entityVisibilities.jsp(1,184) name = show type = java.lang.String reqTime = false required = true fragment = false deferredValue = false expectedTypeName = null deferredMethod = false methodSignature = null
      _jspx_th_system_005flabel_005f0.setShow("text");
      // /page/execution/includes/entityVisibilities.jsp(1,184) name = label type = java.lang.String reqTime = false required = true fragment = false deferredValue = false expectedTypeName = null deferredMethod = false methodSignature = null
      _jspx_th_system_005flabel_005f0.setLabel("sbtEjeEntVis");
      int _jspx_eval_system_005flabel_005f0 = _jspx_th_system_005flabel_005f0.doStartTag();
      if (_jspx_th_system_005flabel_005f0.doEndTag() == javax.servlet.jsp.tagext.Tag.SKIP_PAGE) {
        return true;
      }
      _005fjspx_005ftagPool_005fsystem_005flabel_0026_005fshow_005flabel_005fnobody.reuse(_jspx_th_system_005flabel_005f0);
      _jspx_th_system_005flabel_005f0_reused = true;
    } finally {
      org.apache.jasper.runtime.JspRuntimeLibrary.releaseTag(_jspx_th_system_005flabel_005f0, _jsp_getInstanceManager(), _jspx_th_system_005flabel_005f0_reused);
    }
    return false;
  }

  private boolean _jspx_meth_system_005flabel_005f1(javax.servlet.jsp.PageContext _jspx_page_context)
          throws java.lang.Throwable {
    javax.servlet.jsp.PageContext pageContext = _jspx_page_context;
    javax.servlet.jsp.JspWriter out = _jspx_page_context.getOut();
    //  system:label
    biz.statum.apia.web.tag.other.LabelTag _jspx_th_system_005flabel_005f1 = (biz.statum.apia.web.tag.other.LabelTag) _005fjspx_005ftagPool_005fsystem_005flabel_0026_005fshow_005flabel_005fnobody.get(biz.statum.apia.web.tag.other.LabelTag.class);
    boolean _jspx_th_system_005flabel_005f1_reused = false;
    try {
      _jspx_th_system_005flabel_005f1.setPageContext(_jspx_page_context);
      _jspx_th_system_005flabel_005f1.setParent(null);
      // /page/execution/includes/../../generic/visibilities.jsp(1,193) name = show type = java.lang.String reqTime = false required = true fragment = false deferredValue = false expectedTypeName = null deferredMethod = false methodSignature = null
      _jspx_th_system_005flabel_005f1.setShow("text");
      // /page/execution/includes/../../generic/visibilities.jsp(1,193) name = label type = java.lang.String reqTime = false required = true fragment = false deferredValue = false expectedTypeName = null deferredMethod = false methodSignature = null
      _jspx_th_system_005flabel_005f1.setLabel("btnAgr");
      int _jspx_eval_system_005flabel_005f1 = _jspx_th_system_005flabel_005f1.doStartTag();
      if (_jspx_th_system_005flabel_005f1.doEndTag() == javax.servlet.jsp.tagext.Tag.SKIP_PAGE) {
        return true;
      }
      _005fjspx_005ftagPool_005fsystem_005flabel_0026_005fshow_005flabel_005fnobody.reuse(_jspx_th_system_005flabel_005f1);
      _jspx_th_system_005flabel_005f1_reused = true;
    } finally {
      org.apache.jasper.runtime.JspRuntimeLibrary.releaseTag(_jspx_th_system_005flabel_005f1, _jsp_getInstanceManager(), _jspx_th_system_005flabel_005f1_reused);
    }
    return false;
  }
}