<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
	pageEncoding="ISO-8859-1"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<title>iFill Reports : CashPosition</title>	
<script src="${pageContext.request.contextPath}/js/jquery-2.1.0.min.js"	type="text/javascript"></script>
<link href="${pageContext.request.contextPath}/css/bootstrap.css" rel="stylesheet" media="screen">
<link href="${pageContext.request.contextPath}/css/style.css" rel="stylesheet" type="text/css" />
<link rel="stylesheet" href="${pageContext.request.contextPath}/css/skitter.css" type="text/css">
<%-- <script src="${pageContext.request.contextPath}/js/bootstrap.min.js"></script> --%>
<style type="text/css">
     /* @media print {
        body * {
          display:none;
        }

        body .printable {
          display:block;
        }
      } */
    </style>
<script type="text/javascript">
var customerID =  "";
var date =  "";

function onLoad() {
		
		  customerID =  '<%= session.getAttribute("customerID")%>';
		  date =  '<%= session.getAttribute("Date")%>';
		
		alert(customerID + "_"+date);
		}
		
	$(document).ready(function(){
						
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
	})
</script>
<script type="text/javascript">
	$(document)
			.ready(function() {	
				
				var customerID =  '<%= session.getAttribute("customerID")%>';
				alert(customerID);
				$.ajax({
							type : "GET",
							url : "/ifill/reports/salesCreditData/"+customerID,
							contentType : 'application/json',
							dataType : "text",
							success : function(ldr) {
								var finalData = jQuery.parseJSON(ldr);
								var readings = 1;
								$.each(finalData, function(index, value) {
									$.each(value, function(index, val) {									
										console.log(val);
										$('#row'+readings).append("<td align='center'><div class='col-md-offset-1 col-md-10'>"+readings+"</div></td>");									
										$('#row'+readings).append("<td align='center'><div class='col-md-offset-1 col-md-10'>"+val.date+"</div></td>");
										$('#row'+readings).append("<td align='center'><div class='col-md-offset-1 col-md-10'>"+val.credit+"</div></td>");
										$('#row'+readings).append("<td align='center'><div class='col-md-offset-1 col-md-10'>"+val.recovery+"</div></td>");
										
										readings = readings + 1;
										$('#tab_logic').append("<tr id='row"+readings+"' ></tr>");
																	
									});																	
								});
							},
							error : function(xhr) {
								alert("Opps !!!! Somethings went wrong at the server. Please contact admin for further help : "
										+ xhr.status);
							}
						});
			
			})

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

<body onload="onLoad()">
<div id="print_div"> 
	<table width="1003" border="0" align="center" cellpadding="0"
		cellspacing="0">
		<tr>
			<td width="604" height="30"><span class="logo">I-</span><span
				class="logo1">fill </span></td>
			<td width="399" height="45" align="right" valign="top"><a href="#" id='logoutButton'><img src="${pageContext.request.contextPath}/images/logout.png" alt="logout.png" width="120" height="40" /></a></td>
		</tr>
	</table>
	</div>
	<!-- <div id="print_div"> -->
	<br />
	<table width="1003" border="0" align="center" cellpadding="0"
		cellspacing="0">
		<tr>
			<td width="252" height="40" align="left" valign="middle"
				class="subheading"
				style="background-image: url(${pageContext.request.contextPath}/images/report_button.png); background-repeat: no-repeat">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;Credit Report</td>
			<td width="751"><br /></td>
		</tr>
	</table>
	<table width="1003" border="0" align="center" cellpadding="0"
		cellspacing="0">
		<tr>
			<td width="887"><table width="100%" border="0" align="right"
					cellpadding="0" cellspacing="0"
					style="border: 1px solid #cccccc; border-radius: 5px; background-image: url(${pageContext.request.contextPath}/images/login_bg.jpg); background-repeat: repeat"
					bgcolor="#f7f7f7">
					
					<tr>
					
						<td height="42" align="center" valign="middle" style=""><br />
							<table>
								<tr align="center"><td><h3>ABC Filling Station, </br></h3><h4>PQR Road, XYZ Dist.</h4></td></tr>
								<!-- <tr align="center"><td><h4>Tanikella Road, Khammam Dist.</h4></td></tr> -->								
							</table> 
							<table width="980" border="0" align="center" cellpadding="0"
								cellspacing="0">
								<tr align="left">
									<td width="418"><span class="para5">Customer Id : &nbsp;&nbsp; <u><%= session.getAttribute("customerID").toString() %></u></span></td>
									<td width="562" height="25" align="center" valign="center">
											&nbsp;&nbsp;<span class="para5">Date : <u><%= session.getAttribute("Date").toString() %></u></span>
										</td>
								</tr>
							</table><hr width="75%" align="center" /></br>
							<table width="980" border="1" align="center" cellpadding="2" cellspacing="1" id="tab_logic">
								
								<tr>
									<td height="30" align="center" bgcolor="#c9dba2"><span class="para"><strong>S.No</strong></span>.</td>
									<td height="30" align="center" bgcolor="#c9dba2" class="para"><strong>Date</strong></td>
									<td height="30" align="center" bgcolor="#c9dba2" class="para"><strong>Credits</strong></td>
									<td height="30" align="center" bgcolor="#c9dba2" class="para"><strong>Recovery</strong></td>
								</tr>
								
								<tr id="row1"></tr>
								
							</table> <br />
							<!-- </div> -->
							<!-- <table width="50%" border="0" align="right" cellpadding="0"
								cellspacing="0">
								<tr>
									<td align="right"><a href="user.html" class="para5"><strong
											class="para5">&lt;&lt;
												back&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; </strong></a></td>
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
							        //$("#print_div").addClass('printable');
							        //$('body').css('display','none');							        
							        //$('#print_div').css('display', 'block');
							        //alert('added printable');
							        window.print();
							      }
							    </script>
						</div>
						<br /> <br /><br /> <br /></td>
					</tr>
				</table></td>
		</tr>
	</table>
	<br />
	<table width="1003" border="0" align="center" cellpadding="0"
		cellspacing="0">
		<tr>
			<td height="30" align="center" bgcolor="#8780b0" class="copyright">@copyright
				2013 . All Rights Reserved</td>
		</tr>
	</table>
	
</body>
</html>
