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
var hsd =  "";
var ms =  "";
var credit_ms = "";
var credit_hsd = ""; 
var lubes = "";
var recovery = "";
function onLoad() {

		//alert('On load f');
		
		  hsd =  '<%= session.getAttribute("HSD")%>';
		  ms =  '<%= session.getAttribute("MS")%>';
		  credit_ms =  '<%= session.getAttribute("CREDITS")%>';
		  credit_hsd =  '<%= session.getAttribute("HSD_CREDIT")%>';
		  lubes =  '<%= session.getAttribute("LUBES")%>';
		  recovery =  '<%= session.getAttribute("CREDIT_RECOVERY")%>';
		
		//alert(ms +":"+hsd+":"+credit_ms+":"+credit_hsd+":"+lubes+":"+recovery+":"+lubes);					
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
				style="background-image: url(${pageContext.request.contextPath}/images/report_button.png); background-repeat: no-repeat">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;Daily
				Cash Position</td>
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
									<td width="418"></td>
									<td width="562" height="25" align="center" valign="center">
											&nbsp;&nbsp;<span class="para5">Date : <u><%= session.getAttribute("Date").toString() %></u></span>
										</td>
								</tr>
							</table><hr width="75%" align="center" /></br>
							<table width="980" border="1" align="center" cellpadding="2" cellspacing="1">
								
								<tr>
									<td height="30" align="center" bgcolor="#c9dba2"><span class="para"><strong>S.No</strong></span>.</td>
									<td height="30" align="left" bgcolor="#c9dba2" class="para"><strong>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;STOCK</strong></td>
									<td height="30" align="right" bgcolor="#c9dba2" class="para"><strong>Effective Sales&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;</strong></td>
									<td height="30" align="right" bgcolor="#c9dba2" class="para"><strong>Deductions&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;</strong></td>
								</tr>
								<% 
									double ms = Math.round(Double.parseDouble(session.getAttribute("MS").toString()));
									double hsd = Math.round(Double.parseDouble(session.getAttribute("HSD").toString()));
									double ms_credit = Math.round(Double.parseDouble(session.getAttribute("CREDITS").toString()));
									/* double hsd_credit = Math.round(Double.parseDouble(session.getAttribute("HSD_CREDIT").toString())); */
									double lubes = Math.round(Double.parseDouble(session.getAttribute("LUBES").toString()));
									double recovery = Math.round(Double.parseDouble(session.getAttribute("CREDIT_RECOVERY").toString()));
									double expenses = Math.round(Double.parseDouble(session.getAttribute("MISC_EXPENSES").toString()));
									
									double sales = ms + hsd + lubes + recovery;
									double deductions = ms_credit + expenses;
									double cash_position = sales - deductions;
								%>
								<tr>
									<td height="25" align="center" bgcolor="#efeefc" class="para5">1.</td>
									<td height="25" bgcolor="#efeefc" class="para5">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
										&nbsp;Petrol</td>
									<td height="25" bgcolor="#efeefc" class="para5" align="right" ><%= ms %>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;</td>
									<td height="25" bgcolor="#efeefc">&nbsp;</td>

								</tr>
								
								<tr>
									<td height="25" align="center" bgcolor="#e4feea" class="para5">2.</td>
									<td height="25" bgcolor="#e4feea" class="para5">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;Diesel</td>
									<td height="25" bgcolor="#e4feea" class="para5" align="right"><%= hsd %>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;</td>
									<td height="25" bgcolor="#e4feea">&nbsp;</td>
								</tr>
								
								<tr>
									<td height="25" align="center" bgcolor="#efeefc" class="para5">3.</td>
									<td height="25" bgcolor="#efeefc" class="para5">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;Credit
										Sales</td>
									<td height="25" bgcolor="#efeefc" class="para5">&nbsp;</td>
									<td height="25" bgcolor="#efeefc" align="right" class="para5"><%= ms_credit %>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;</td>

								</tr>
								
								<%-- <tr>
									<td height="25" align="center" bgcolor="#e4feea" class="para5">4.</td>
									<td height="25" bgcolor="#e4feea" class="para5">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;Credit
										Sales - HSD</td>
									<td height="25" bgcolor="#e4feea" class="para5">&nbsp;</td>
									<td height="25" bgcolor="#e4feea" align="right" class="para5"><%= hsd_credit %>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;</td>
								</tr> --%>
								<tr>
									<td height="25" align="center" bgcolor="#e4feea" class="para5">4.</td>
									<td height="25" bgcolor="#e4feea" class="para5">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
										Lubes</td>
									<td height="25" bgcolor="#e4feea" class="para5" align="right"><%= lubes %>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;</td>
									<td height="25" bgcolor="#e4feea">&nbsp;</td>
								</tr>
								<tr>
									<td height="25" align="center" bgcolor="#efeefc" class="para5">5.</td>
									<td height="25" bgcolor="#efeefc" class="para5">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
										Credit Recovery</td>
									<td height="25" bgcolor="#efeefc" class="para5" align="right"><%= recovery %>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;</td>
									<td height="25" bgcolor="#efeefc">&nbsp;</td>

								</tr>
								
								<tr>
									<td height="25" align="center" bgcolor="#e4feea" class="para5">6.</td>
									<td height="25" bgcolor="#e4feea" class="para5">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;Misc Expenses</td>
									<td height="25" bgcolor="#e4feea">&nbsp;</td>
									<td height="25" bgcolor="#e4feea" class="para5" align="right"><%= expenses %>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;</td>									
								</tr>
								
								<tr>
									<td height="25" align="center" bgcolor="#efeefc" class="para5" colspan = "2"></td>
									<td height="25" bgcolor="#efeefc" align="right"  class="para5"><strong ><%= sales %>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;</strong></td>
									<td height="25" bgcolor="#efeefc" align="right"  class="para5"><strong >(-)&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;<%= deductions %>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;</strong></td>
								</tr>
								<tr>
									<td height="25" align="center" bgcolor="#e4feea" class="para5" colspan = "2"></td>
									<td height="25" bgcolor="#e4feea" style="border: solid #000 2px;" align="center"><font size="2"><strong>Total Cash</strong></font></td>
									<td height="25" bgcolor="#e4feea" style="border: solid #000 2px;" align="center"><font size="2"><strong><%= cash_position %></strong></font>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;</td>

								</tr>
								
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
