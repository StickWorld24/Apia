<%@page import="java.util.Collections"%><%@page import="com.dogma.UserData"%><%@page import="java.io.FilenameFilter"%><%@page import="java.io.File"%><%@page import="java.io.IOException"%><%@page import="java.io.FileInputStream"%><%@page import="java.io.InputStream"%><%@page import="java.util.Properties"%><%@include file="/page/includes/startInc.jsp" %><html lang="<%=biz.statum.apia.web.bean.BasicBeanStatic.getUserDataStatic(request).getLangCode()%>"><head><%@include file="/page/includes/headInclude.jsp" %><script type="text/javascript">	
	function initPage() {	
		frameElement.getParent().setStyle('max-height', this.document.body.offsetHeight + 12);
		frameElement.setStyle('height', this.document.body.offsetHeight + 10);
		parent.SYS_PANELS.adjustVisual();
	}
	
</script><%!

public Collection<Properties> getPropertiesFromPath(String path, UserData uData){
	Collection<Properties> props = new ArrayList<Properties>();
	
	try{
		File aboutDir =  new File(path);
		if(aboutDir.exists() && aboutDir.isDirectory()){
			File[] result = aboutDir.listFiles(new FilenameFilter() {
			    public boolean accept(File dir, String name) {
			        return name.toLowerCase().endsWith(".properties");
			    }
			});
			ArrayList<String> distincts = new ArrayList<String>();
			for(File f : result){
				String name = f.getName();
				name=name.substring(0,name.indexOf('.'));
				if(name.indexOf('_')>-1){
					name=name.substring(0,name.indexOf('_'));
				}
				if(!distincts.contains(name)){
					distincts.add(name);
				}
			}
			Collections.sort(distincts);
	 		for(String pName : distincts){
	 			Properties prop = new Properties();
	 			InputStream input = null;
	 			try{
		 			String propPath = path + File.separator + pName + "_" + uData.getLangCode()  + ".properties";
		 		 	try {
		 		 		input = new FileInputStream(propPath);
		 		 	} catch (IOException ex) {
		 		 		propPath = path + File.separator + pName + ".properties";
		 		 		input = new FileInputStream(propPath);
		 		 	} 
		 		 	prop.load(input);
		 		 	props.add(prop);
	 			} catch(Exception ex){
	 				
	 			} finally {
	 		 	 	if (input != null) {
	 		 	 		try {
	 		 	 			input.close();
	 		 	 		} catch (IOException e) {
	 		 	 			e.printStackTrace();
	 		 	 		}
	 		 	 	}
	 		 	}
	 		}
		}
	} catch (Exception ex) {
		
	}

	return props;
}

%><%
Collection<Properties> props = new ArrayList<Properties>();

Collection<Properties> propAll = getPropertiesFromPath(Configuration.APP_PATH + File.separator + "about" + File.separator + "_all",uData);
if(propAll!=null) props.addAll(propAll);
Collection<Properties> propEnv = getPropertiesFromPath(Configuration.APP_PATH + File.separator + "about" + File.separator + uData.getEnvironmentName(),uData);
if(propEnv!=null) props.addAll(propEnv);

%></head><body><div class="aboutContainer"><!-- Statum --><div class="aboutDiv"><div class="aboutDivImage"><img src="<system:util show="context" />/images/statum.png"></div><div class="aboutDivText"><p><system:label show="text" label="lblSTATUMDesc" forHtml="true" forScript="true"/></p></div><div class="aboutDivUrl"><a href="http://www.statum.biz/" target="_blank"><system:label show="text" label="lblMoreInfo" forHtml="true" forScript="true"/></a></div></div><!-- Apia --><div class="aboutDiv"><div class="aboutDivImage"><img src="<system:util show="context" />/images/apiaLogo.png"></div><div class="aboutDivText"><p><system:label show="text" label="lblApiaDesc" forHtml="true" forScript="true"/></p></div><div class="aboutDivUrl"><a href="http://www.statum.biz/statum/type1/9/apia-informacion" target="_blank"><system:label show="text" label="lblMoreInfo" forHtml="true" forScript="true"/></a></div></div><%
		String imgSrc = null;
		String desc = null;
		String url = null;
		for(Properties pr : props){
			imgSrc = pr.getProperty("image");
			desc = pr.getProperty("description");
			url = pr.getProperty("url");
			if(imgSrc == null || "".equals(imgSrc.trim())) {
				imgSrc = EnvParameters.getEnvParameter(envId, EnvParameters.SPLASH_IMAGE);
			}
			%><div class="aboutDiv"><div class="aboutDivImage"><img src="<system:util show="context" /><%=imgSrc%>"></div><div class="aboutDivText"><p><%=desc%></p></div><div class="aboutDivUrl"><%if(url != null && !"".equals(url.trim())) { %><a href="<%=url%>" target="_blank"><system:label show="text" label="lblMoreInfo" forHtml="true" forScript="true"/></a><%} %></div></div><%
		}
		%></div></body></html>