<%@include file="../includes/startInc.jsp" %><html><head><style type="text/css">
			.message{
				background-color: rgb(249, 237, 184);
			    border: 1px solid rgb(237, 201, 103);
		    	color: #707070;
		    	padding: 5px 20px;
		    	width: 68%;
		    	margin-left: 10%;
		    	text-align: center;
    		}
			.outer {
			    display: table;
			    position: absolute;
			    height: 100%;
			    width: 100%;    
			}
			.middle {
			    display: table-cell;
			    vertical-align: middle;
			}
			.inner {
			    margin-left: auto;
			    margin-right: auto;
			    width: /*whatever width you want*/;
			}

		</style></head><body><div id="bodyDiv"><div class="outer"><div class="middle"><div class="inner"><div class="message"><system:label show="text" label="msgFileNotFound" forScript="true" /></div></div></div></div></div></body></html>




