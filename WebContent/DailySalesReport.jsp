<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
	pageEncoding="ISO-8859-1"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
<title>Ifill : Daily Sales</title>
<link href="${pageContext.request.contextPath}/css/bootstrap.css" rel="stylesheet" media="screen">
<link href="${pageContext.request.contextPath}/css/style.css" rel="stylesheet" type="text/css" />
<link rel="stylesheet" href="${pageContext.request.contextPath}/css/skitter.css" type="text/css">
<script src="${pageContext.request.contextPath}/js/jquery-2.1.0.min.js" type="text/javascript"></script>
<script src="${pageContext.request.contextPath}/js/bootstrap.min.js"></script>
<script type="text/javascript">
	
	$(document)
			.ready(
					function() {
					
					//alert('ready');
					/* $('#logout_button').css('display','block');
			        $('#saveButton').css('display','block');
			        $('#backbutton').css('display','block'); */
			        
			        <% 
			        	String url = null;
			        	Object obj = session.getAttribute("ReportDate");
			        	if(obj == null){
			        		url = "\'/ifill/ifill/reports/salesReportData\'";
			        	}else{
			        		url = "\'/ifill/ifill/reports/salesReportData/"+obj.toString()+"\'";
			        	}
			        %>
			        var dataUrl = <%= url.toString() %>
			        //alert('url : '+dataUrl);
					$.ajax({
						type : "GET",
						url : dataUrl,
						contentType : 'application/json',
						dataType : "text",
						success : function(list) {												
							//alert(list);
							populateData(list);
						},
						error : function(xhr) {
							alert("Opps !!!! Somethings went wrong at the server. Please contact admin for further help : "
									+ xhr.status);
						}
					});	
					
					function populateData(list){
						var totalMSSales = 0;
						var totalMSRs = 0;
						var totalHSDSales = 0;
						var totalHSDRs = 0;
						var totalHSDTest = 0;
						var totalMSTest = 0;
						var totalHSDLtr = 0;
						var totalMSLtr = 0;
						var totalLubesRs = 0;
						var finalData = jQuery.parseJSON(list);
						var rows = 3;
						$.each(finalData, function(index, value) {
							if(value.type == "Fuel"){
								if(value.product == "HSD"){
									
									totalHSDLtr= totalHSDLtr + value.saleLtr;
									totalHSDRs = totalHSDRs + value.saleRs;
									totalHSDTest = totalHSDTest + value.test;
								}else if(value.product == "MS"){
									
									totalMSRs = totalMSRs + value.saleRs;
									totalMSLtr= totalMSLtr + value.saleLtr;
									totalMSTest = totalMSTest + value.test;
								}
								
								/* $("#"+value.product.toLowerCase()+"_"+value.pumpId.toLowerCase()+"_cr").append("<div align='center'><p style='text-align:right'>"+value.closing+"</p></div>");
								$("#"+value.product.toLowerCase()+"_"+value.pumpId.toLowerCase()+"_or").append("<div align='center'><p style='text-align:right'>"+value.opening+"</p></div>");
								$("#"+value.product.toLowerCase()+"_"+value.pumpId.toLowerCase()+"_sales").append("<div align='center'><p style='text-align:right'>"+value.saleLtr+"</p></div>");
							 */
							 	//alert(value.pumpId.toLowerCase()+"_cr");
								/* $("#"+value.pumpId.toLowerCase()+"_cr").append("<div align='center'><p style='text-align:right'>"+value.closing+"</p></div>");
								$("#"+value.pumpId.toLowerCase()+"_or").append("<div align='center'><p style='text-align:right'>"+value.opening+"</p></div>");
								$("#"+value.pumpId.toLowerCase()+"_sales").append("<div align='center'><p style='text-align:right'>"+value.saleLtr+"</p></div>"); */
								
								$("#"+(value.product.substring(0,1)).toLowerCase()+"_"+value.pumpId.toLowerCase()+"_cr").append("<div align='center'><p style='text-align:right'>"+value.closing+"</p></div>");
								$("#"+(value.product.substring(0,1)).toLowerCase()+"_"+value.pumpId.toLowerCase()+"_or").append("<div align='center'><p style='text-align:right'>"+value.opening+"</p></div>");
								$("#"+(value.product.substring(0,1)).toLowerCase()+"_"+value.pumpId.toLowerCase()+"_sales").append("<div align='center'><p style='text-align:right'>"+value.saleLtr+"</p></div>");
							
							}else if(value.type == "Lube"){
								//alert('found a lube');
								$('#salesGrid'+rows).append("<td><div><p style='text-align:center'>"+rows+"</div></td>");
								$('#salesGrid'+rows).append("<td><div><p style='text-align:left'>"+value.product+"</div></td>");
								$('#salesGrid'+rows).append("<td><div><p style='text-align:right'>"+value.finalQuantity+"</div></td>");
								$('#salesGrid'+rows).append("<td><div><p style='text-align:right'>"+value.saleRs+"</div></td>");
								
								rows = rows + 1;
								$('#stockRows').append("<tr id='salesGrid"+rows+"' ></tr>");
								
								totalLubesRs = totalLubesRs + value.saleRs;
							}
						})
						
						totalHSDSales = totalHSDLtr - totalHSDTest;
						totalMSSales = totalMSLtr - totalMSTest;
						
						$("#ms_sales").append("<div align='center'><p style='text-align:right'>"+totalMSLtr+"</p></div>");
						$("#ms_testing").append("<div align='center'><p style='text-align:right'>"+totalMSTest+"</p></div>");
						$("#ms_totalsale").append("<div align='center'><p style='text-align:right'>"+totalMSSales+"</p></div>");
						
						$("#hsd_sales").append("<div align='center'><p style='text-align:right'>"+totalHSDLtr+"</p></div>");
						$("#hsd_testing").append("<div align='center'><p style='text-align:right'>"+totalHSDTest+"</p></div>");
						$("#hsd_totalsale").append("<div align='center'><p style='text-align:right'>"+totalHSDSales+"</p></div>");
						
						$("#ms_total_sale").append(totalMSSales);
						$("#ms_total_rs").append(totalMSRs);
						
						$("#hsd_total_sale").append(totalHSDSales);
						$("#hsd_total_rs").append(totalHSDRs);						
					
					
						$('#salesGrid'+rows).append("<td colspan='2'></td>");
						$('#salesGrid'+rows).append("<td><div><p style='text-align:center'><strong>Total Sales Rs</strong></div></td>");
						$('#salesGrid'+rows).append("<td><div><p style='text-align:right'><strong>"+(totalMSRs + totalHSDRs + totalLubesRs)+"</strong></div></td>");
						
						//alert(new Date());
					}
					
							
		$('#logoutButton').click(function(e){
			$.ajax({
				type : "GET",
				url : "/ifill/profile/logout",
				contentType : 'application/json',
				dataType : "text",
				success : function(status) {												
					//alert('successfully logged out'+status);
					window.location.href = "/ifill/views/showAppHomePage";
				},
				error : function(xhr) {
					alert("Opps !! We could not delete the row now. Please try again. Please find the cause : "
							+ xhr.status);
				}
			});
		});
					
					});
	
</script>
<style type="text/css">
.Text_grey {
	font-family: Arial, Helvetica, sans-serif;
	font-size: 12px;
	font-style: normal;
	font-weight: normal;
	color: #999999;
}
</style>
</head>

<body>
<table width="1003" border="0" align="center" cellpadding="0" cellspacing="0">
  <tr>
    <td width="604" height="30"><span class="logo">I-</span><span class="logo1">fill </span></td>
    <td width="399" height="45" align="right" valign="top"><a href="#" id='logoutButton'><img src="${pageContext.request.contextPath}/images/logout.png" alt="logout.png" width="120" height="40" /></a></td>
  </tr>
</table>

<br />
<table width="1003" border="0" align="center" cellpadding="0" cellspacing="0">
  <tr>
    <td width="252" height="40" align="left" valign="middle" class="subheading" style="background-image:url(${pageContext.request.contextPath}/images/report_button.png); background-repeat:no-repeat">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;Daily Sales Report</td>
    <td width="751"><br />
   </td>
  </tr>
</table>
<table width="1003" border="0" align="center" cellpadding="0" cellspacing="0" >
  <tr>
    <td width="887">
    <table width="100%" border="0" align="right" cellpadding="0" cellspacing="0" style="border:1px solid #cccccc;
    border-radius:5px; background-image:url(${pageContext.request.contextPath}/images/login_bg.jpg); background-repeat:repeat" bgcolor="#f7f7f7">
      <tr>
        <td height="42" align="center" valign="middle"></br>
          <table>
				<tr align="center"><td><h3>ABC Filling Station, </br></h3><h4>PQR Road, XYZ Dist.</h4></td></tr>
				<!-- <tr align="center"><td><h4>Tanikella Road, Khammam Dist.</h4></td></tr> -->							
			</table> 
			<table width="980" border="0" align="center" cellpadding="0"
				cellspacing="0">
				<tr align="left">
					<td width="418"></td>
					<td width="562" height="25" align="center" valign="bottom">
							&nbsp;&nbsp;<span class="para5">Date : <u><%-- <%= session.getAttribute("Date").toString(); %> --%></u></span>
						</td>
				</tr>
			</table><hr width="75%" align="center" /></br>                
            <div class="col-md-offset-1 col-md-10 column" >
            <table width="85%" border="0" align="center" class="table table-striped table-bordered table-condensed " cellpadding="2" cellspacing="1">
            	<thead>
	              <tr>
	                <td height="30" class="text-left" bgcolor="#fbd073"><strong> &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;<font size='3'><u>M.S</u></font></strong></td>
	                <td height="30" class="text-center" bgcolor="#fbd073"><strong> Pump 1</strong></td>
	                <td height="30" class="text-center" bgcolor="#fbd073"><strong> </strong><strong>Pump 2</strong></td>
	                <td height="30" class="text-center" bgcolor="#fbd073"><strong> </strong><strong>Pump 3</strong></td>
	                <td height="30" class="text-center" bgcolor="#fbd073"><strong> Pump 4</strong></td>
	                <td height="30" class="text-center" bgcolor="#fbd073"><strong> Pump 5</strong></td>
	                
	              </tr>
              </thead>
              <tr>
                <td   align="left" bgcolor="#efeefc" class="para"><strong>&nbsp;&nbsp;&nbsp;&nbsp;<span class="para5">&nbsp;C/o /MR</span></strong></td>
                <td   bgcolor="#efeefc" id="m_pump-1_cr"></td>
                <td   bgcolor="#efeefc" align="right"  id="m_pump-2_cr"></td>
                <td   bgcolor="#efeefc" align="right"  id="m_pump-3_cr"></td>
                <td   bgcolor="#efeefc" align="right"  id="m_pump-4_cr"></td>
                <td   bgcolor="#efeefc" align="right"  id="m_pump-5_cr"></td>
                
              </tr>
              <tr>
                <td   align="left" bgcolor="#e4feea" class="para"><strong>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;<span class="para5">OP / Mr</span></strong></td>
                <td   bgcolor="#e4feea" id="m_pump-1_or"></td>
                <td   bgcolor="#e4feea"  align="right" id="m_pump-2_or"></td>
                <td   bgcolor="#e4feea"  align="right" id="m_pump-3_or"></td>
                <td   bgcolor="#e4feea"  align="right" id="m_pump-4_or"></td>
                <td   bgcolor="#e4feea"  align="right" id="m_pump-5_or"></td>
                
              </tr>
              <tr>
                <td   align="left" bgcolor="#efeefc" class="para"><strong>&nbsp;&nbsp;&nbsp;<span class="para5">&nbsp;&nbsp;Sales</span></strong></td>
                <td   bgcolor="#efeefc" id="m_pump-1_sales"></td>
                <td   bgcolor="#efeefc" align="right" id="m_pump-2_sales"></td>
                <td   bgcolor="#efeefc" align="right" id="m_pump-3_sales"></td>
                <td   bgcolor="#efeefc" align="right" id="m_pump-4_sales"></td>
                <td   bgcolor="#efeefc" align="right" id="m_pump-5_sales"></td>
                
              </tr>
            </table>
            </div>
            <br />
            <div class="col-md-offset-1 col-md-10 column" >
            <table width="85%" border="0" align="center" class="table table-striped table-bordered table-condensed " cellpadding="2" cellspacing="1">
              <thead>
              <tr>
                 <td height="30" class="text-left" bgcolor="#fbd073"><strong> &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;<font size='3'><u>H.S.D</u></font></strong></td>
                <th height="30" bgcolor="#fbd073" class="text-center" ><strong> Pump 1</strong></th>
                <th height="30" bgcolor="#fbd073" class="text-center" ><strong> </strong><strong>Pump 2</strong></th>
                <th height="30" bgcolor="#fbd073" class="text-center" ><strong> </strong><strong>Pump 3</strong></th>
                <th height="30" bgcolor="#fbd073" class="text-center" ><strong> Pump 4</strong></th>
                <th height="30" bgcolor="#fbd073" class="text-center" ><strong> Pump 5</strong></th>
               </tr>
              </thead>
              <tr>
                <td   align="left" bgcolor="#efeefc" class="para"><strong>&nbsp;&nbsp;&nbsp;&nbsp;<span class="para5">&nbsp;C/o /MR</span></strong></td>
                <td   bgcolor="#efeefc"  align="right" id="h_pump-1_cr"></td>
                <td   bgcolor="#efeefc"  align="right" id="h_pump-2_cr"></td>
                <td   bgcolor="#efeefc"  align="right" id="h_pump-3_cr"></td>
                <td   bgcolor="#efeefc"  align="right" id="h_pump-4_cr"></td>
                <td   bgcolor="#efeefc"  align="right" id="h_pump-5_cr"></td>
                
              </tr>
              <tr>
                <td   align="left" bgcolor="#e4feea" class="para"><strong>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;<span class="para5">OP / Mr</span></strong></td>
                <td   bgcolor="#e4feea"  align="right" id="h_pump-1_or"></td>
                <td   bgcolor="#e4feea"  align="right" id="h_pump-2_or"></td>
                <td   bgcolor="#e4feea"  align="right" id="h_pump-3_or"></td>
                <td   bgcolor="#e4feea"  align="right" id="h_pump-4_or"></td>
                <td   bgcolor="#e4feea"  align="right" id="h_pump-5_or"></td>
                
              </tr>
              <tr>
                <td   align="left" bgcolor="#efeefc" class="para"><strong>&nbsp;&nbsp;&nbsp;<span class="para5">&nbsp;&nbsp;Sales</span></strong></td>
                <td   bgcolor="#efeefc"  align="right" id="h_pump-1_sales"></td>
                <td   bgcolor="#efeefc"  align="right" id="h_pump-2_sales"></td>
                <td   bgcolor="#efeefc"  align="right" id="h_pump-3_sales"></td>
                <td   bgcolor="#efeefc"  align="right" id="h_pump-4_sales"></td>
                <td   bgcolor="#efeefc"  align="right" id="h_pump-5_sales"></td>
                
              </tr>
            </table>
            </div>
            </br>
            <div class="col-md-offset-1 col-md-10 column" >
            <table width="85%" border="0" align="center" class="table table-striped table-bordered table-condensed " cellpadding="2" cellspacing="1">
              <thead>
              <tr>
                <th class="text-center" align="center" bgcolor="#fbd073">M.S</th>
                <th class="text-center" align="center" bgcolor="#fbd073">H.S.D</th>  
               </tr>              
              </thead>
              <tr>
                <td align="center" bgcolor="#f9f9f9"><table class="para5" width="65%"><tr><td>&nbsp;&nbsp;Sales : </td><td id="ms_sales"></td></tr></table></td>
                <td align="center" bgcolor="#f9f9f9"><table class="para5" width="65%"><tr><td>&nbsp;&nbsp;Sales : </td><td id="hsd_sales"></td></tr></table></td>
            
              </tr>
              <tr>
                <td align="center" bgcolor="#e4feea" class="para5"><table class="para5" width="65%"><tr><td>&nbsp;&nbsp;Testing : </td><td id="ms_testing"></td></tr></table></td>
                <td align="center" bgcolor="#e4feea" class="para5"><table class="para5" width="65%"><tr><td>&nbsp;&nbsp;Testing : </td><td id="hsd_testing"></td></tr></table></td>
               
              </tr>
              <tr>
                <td align="center" bgcolor="#f9f9f9" class="para5"><table class="para5" width="65%"><tr><td>&nbsp;&nbsp;Total Sales : </td><td id="ms_totalsale"></td></tr></table></td>
                <td align="center" bgcolor="#f9f9f9" class="para5"><table  class="para5" width="65%"><tr><td>&nbsp;&nbsp;Total Sales : </td><td id="hsd_totalsale"></td></tr></table></td>
               
              </tr>
            </table>
            </div>
            <br />

            <div class="col-md-offset-1 col-md-10 column" >
            <table width="85%" cellpadding="2" cellspacing="1" class="table table-striped table-bordered table-condensed " id="stockRows">
				<thead>
				<tr>
					<th class="text-center" bgcolor="#aeb1e0" align="center">S.No</th>
					<th class="text-center" bgcolor="#aeb1e0" align="center">Description</th>
					<th class="text-center" bgcolor="#aeb1e0" align="center">Sales</th>
					<th class="text-center" bgcolor="#aeb1e0" align="center">Amount</th>
				</tr>					
				</thead>
				<tr>
					<td  class="text-center" >1</td>
					<td  class="text-left" >Petrol</td>
					<td align="right" id="ms_total_sale"></td>
					<td align="right" id="ms_total_rs"></td>
				</tr>
				<tr>
					<td  class="text-center" >2</td>
					<td  class="text-left" >Diesel</td>
					<td align="right" id="hsd_total_sale"></td>
					<td align="right" id="hsd_total_rs"></td>
				</tr>
  				<tr id="salesGrid3"></tr>
  				
			</table>
			</div>
          <br />
          <!-- <table width="50%" border="0" align="right" cellpadding="0" cellspacing="0">
            <tr>
              <td align="right"><a href="user.html" class="para5"><strong class="para5">&lt;&lt; back&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; </strong></a></td>
            </tr>
          </table> -->
          <div class="col-md-offset-1 col-md-10 column" >
          <!-- <table >
          	<tr>
          	<td class="col-md-offset-1 col-md-8"></td>
			<td class="col-md-offset-1 col-md-8"></td>
			<td class="col-md-offset-1 col-md-8"></td>
			<td><a id='backbutton' href="/ifill/inventory/showHomePage" class="pull-left btn btn-default">Go Back</a></td>
			</tr>
		</table> -->
		<br />
		<div class="col-md-offset-1 col-md-10 column" id="test">
							<table ><tr><td align="left"></td>
								<td align="right"></td>
								<td  class="col-md-offset-1 col-md-10" ></td>
								<td  class="col-md-offset-1 col-md-10" ><a id='saveButton' href="#" class="pull-left btn btn-success" onclick="divPrint();">Print / Save</a></td>
								<td><a id='backbutton' href="/ifill/inventory/showHomePage" class="pull-left btn btn-warning">Go Back</a></td>
								</table>
								<script type="text/javascript">
							      function divPrint() {
							      	//alert("printing");
							        //$("#print_div").addClass("printable");
							        //$('body').css('display','none');
							        
							        //$('#print_div').css('display', 'block');
							        //alert('added printable');
							        $('#logout_button').css('display','none');
							        $('#saveButton').css('display','none');
							        $('#backbutton').css('display','none');
							        window.print();
							      }
							    </script>
						</div>
						<br /><br /><br /><br />
		</div>
          <br />
          <br /><p></p>
          </td>
      </tr>
    </table>
    </td>
  </tr>
</table>
<br />
<table width="1003" border="0" align="center" cellpadding="0" cellspacing="0">
  <tr>
    <td height="30" align="center" bgcolor="#8780b0" class="copyright">@copyright 2013 . All Rights Reserved</td>
  </tr>
</table>
</body>
</html>
