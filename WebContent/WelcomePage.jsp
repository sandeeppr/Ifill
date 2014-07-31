<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
<title>IFill : Welcome</title>
<link href="${pageContext.request.contextPath}/css/bootstrap.css" rel="stylesheet" media="screen">
<link href="${pageContext.request.contextPath}/css/style.css" rel="stylesheet" type="text/css" />
<link rel="stylesheet" href="${pageContext.request.contextPath}/css/skitter.css" type="text/css">
<script src="${pageContext.request.contextPath}/js/jquery-2.1.0.min.js" type="text/javascript"></script>
<script src="${pageContext.request.contextPath}/js/bootstrap.min.js"></script>

<script type="text/javascript">
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
<table width="1003" border="0" align="center" cellpadding="0" cellspacing="0">
  <tr>
    <td width="604" height="30"><span class="logo">I-</span><span class="logo1">fill </span></td>
    <td width="199" height="45" align="right" valign="top">&nbsp;</td>
    <td width="200" align="right" valign="top"><a href="#" id='logoutButton'><img src="${pageContext.request.contextPath}/images/logout.png" alt="logout.png" width="120" height="40" /></a></td>
  </tr>
</table>
<table width="1003" border="0" align="center" cellpadding="0" cellspacing="0">
  <tr>
    <td><img src="${pageContext.request.contextPath}/images/banner2.jpg" alt="image2" width="1003" height="260" /></td>
  </tr>
</table>
<br /> 
<div>
<table width="1003" border="0" align="center" cellpadding="0" cellspacing="0" style="border:1px solid #fff;
    border-radius:0px;">
  <tr>
    <td width="887" style="background-image:url(${pageContext.request.contextPath}/images/login_bg.jpg); background-repeat:repeat-x" bgcolor="#f7f7f7">
    
    <table width="100%" border="0" align="center" cellpadding="3" cellspacing="0">
   
      <tr>
        <td height="50" align="left" class="welcome" valign="bottom">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;Welcome </span><strong>&nbsp;&nbsp; Supervisor</strong> ,</td>
      </tr>
      <tr height="40"><td></td><td></td></tr>
      <tr>
      <td >
      	<table width="80%" border="0" align="center" cellpadding="0" cellspacing="0">
          <tr>
			<td class="para5" align="center">
				<div id='cssmenu' class="para5">
					<ul>
						<li class='has-sub last'><a href='#'><span>Daily Readings</span></a>
							<ul>
								<li><a href='/ifill/inventory/showMS'><span>M S</span></a></li>
								<li><a href='/ifill/inventory/showHSD'><span>H S D</span></a></li>
								<li><a href='/ifill/inventory/showLubesSales'><span>Lubes Sale</span></a></li>
								<li><a href='/ifill/inventory/showCreditSale'><span>Credit Sales</span></a></li>
								<li><a href='/ifill/inventory/showCreditRecovery'><span>Credit Recovery</span></a></li>
								<li><a href='/ifill/inventory/showMiscExpenses'><span>Misc Expenses</span></a></li>
								<li class='last'><a href='/ifill/inventory/showDipReadings'><span>Periodic Dips</span></a></li>
							</ul>
						</li>
					</ul>
				</div>
			</td>
			<td class="para5" align="center">
				<div id='cssmenu' class="para5">
					<ul>
						<li class='has-sub last'><a href='#'><span>Daily Reports</span></a>
							<ul>
								<li><a href='/ifill/reports/showCashPositionStmt'><span>Cash Position</span></a></li>
								<li><a href='/ifill/reports/showSalesReport'><span>Sales Report</span></a></li>								
							</ul>
						</li>
					</ul>
				</div>
			</td>
          </tr>
        </table></td>
      </tr>
      <tr height="30"><td></td><td></td></tr>
      <tr>
        <td height="30">
        <table width="80%" border="0" align="center" cellpadding="0" cellspacing="0">
          <tr>
            <td class="para5" align="center"><div id='cssmenu' class="para5"> <ul><li><a href='/ifill/inventory/showStockReciept'><span>Stock Reciept</span></a></li> </ul></div> <!-- <a href="/ifill/inventory/showLubesSales" class="para5"> <strong>Lubes Sale</strong></a> --></td>
            <td class="para5" align="center"><div id='cssmenu' class="para5">
            			 <ul><li class='has-sub last'><a href='#'><span>Extra Reports</span></a>
								<ul>
									<li><a href='/ifill/reports/showMiscReport'><span>DateWise Reports</span></a></li>
									<li><a href='/ifill/reports/showCreditReport'><span>Credit Statements</span></a></li>								
								</ul>
						</li></ul></div> </td>
          </tr>
        </table></td>
      </tr>
      
    </table>
    <br />
    <br />
    <br />
    <br /></td>
  </tr>
</table>
<br /><br />
<table width="1003" border="0" align="center" cellpadding="0" cellspacing="0">
  <tr>
    <td height="30" align="center" bgcolor="#8780b0" class="copyright">@copyright 2013 . All Rights Reserved</td>
  </tr>
</table>
</body>
</html>