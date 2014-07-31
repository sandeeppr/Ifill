<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
<title>Insert title here</title>
</head>
<body>
<table width="100%" border="0" align="center" cellpadding="0"
		cellspacing="0">
		<tr>
			<td
				style="background-image: url(${pageContext.request.contextPath}/images/top.jpg); background-repeat: repeat-x">
				<table
					align="center" border="0" cellpadding="0" cellspacing="0"
					width="1003">
					<tbody>
						<tr>
							<td style="width: 646px;" class="menu_nav" height="40">
							<a href="/BaS" class="menu_nav" style="text-decoration:none;color:#fff;">Home</a>&nbsp;&nbsp;I&nbsp;&nbsp;&nbsp; 
							<a href="how_it_works.html" class="menu_nav" style="text-decoration:none;color:#fff;">How It Works </a>&nbsp;&nbsp;I&nbsp;&nbsp;&nbsp; 
							<a href="services.html" class="menu_nav" style="text-decoration:none;color:#fff;">Services</a>&nbsp;&nbsp;I&nbsp;&nbsp;&nbsp; 
							<a href="about_us.html" class="menu_nav" style="text-decoration:none;color:#fff;">About Us</a></td>
							<td style="width: 100px;" height="40"><a href="/BaS/sahaay/profileMgmt/loginRegister" class="subheading_link" style="text-decoration:none;color:#fff;">Login/Register</a></td>
							<td style="width: 160px;" height="40"><select
								name="listprofile"
								style="border: 1px solid rgb(255, 255, 255); width: 150px; height: 23px; background-color: rgb(255, 255, 255);"
								id="listcity"><option class="para" value="Hyderabad" >Hyderabad</option>
									<option class="para" value="Bangalore">Bangalore</option></select> <br /></td>
							<td style="width: 108px;" height="40"><table
									style="margin-left: 0px; width: 98px;" align="right" border="0"
									cellpadding="0" cellspacing="0" width="47%">
									<tbody>
										<tr>
											<td style="width: 23px;"><a
												href="https://www.facebook.com/sahaay"
												onmouseout="MM_swapImgRestore()"
												onmouseover="MM_swapImage('Image1','','${pageContext.request.contextPath}/images/facebook_a.jpg',1)"><img
													src="${pageContext.request.contextPath}/images/facebook.jpg" alt="facebook" name="Image1"
													id="Image1" border="0" height="15" width="10" /></a></td>
											<td style="width: 23px;"><a
												href="https://twitter.com/SahaayIndia"
												onmouseout="MM_swapImgRestore()"
												onmouseover="MM_swapImage('Image2','','${pageContext.request.contextPath}/images/twitter_a.jpg',1)"><img
													src="${pageContext.request.contextPath}/images/twitter.jpg" alt="twitter" name="Image2"
													id="Image2" border="0" height="16" width="18" /></a></td>
											<td style="width: 23px;" align="center"><a href="#"
												onmouseout="MM_swapImgRestore()"
												onmouseover="MM_swapImage('Image3','','${pageContext.request.contextPath}/images/google_plus_a.jpg',1)"><img
													src="${pageContext.request.contextPath}/images/google_plus.jpg" alt="google_plus"
													name="Image3" id="Image3" border="0" height="17" width="16" /></a></td>
											<td style="width: 23px;" align="right"><a
												href="http://sahaayindia.wordpress.com/"
												onmouseout="MM_swapImgRestore()"
												onmouseover="MM_swapImage('Image4','','${pageContext.request.contextPath}/images/rss_a.jpg',1)"><img
													src="${pageContext.request.contextPath}/images/rss.jpg" alt="rss" name="Image4" id="Image4"
													border="0" height="16" width="14" /></a></td>
										</tr>
									</tbody>
								</table></td>
						</tr>
					</tbody>
				</table></td>
		</tr>
	</table> <!--  header ends -->
	
	
<table width="100%" border="0" cellspacing="0" cellpadding="0">
		<tr>
			<td height="90"
				style="background-image: url(${pageContext.request.contextPath}/images/footer.jpg); background-repeat: repeat-x"><table
					width="1003" border="0" align="center" cellpadding="0"
					cellspacing="0">
					<tr>
						<td width="528" class="menu_nav"><strong>FAQ's
								&nbsp;&nbsp;Blog &nbsp;&nbsp;Carrers</strong>
							&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;<strong>Toll free</strong> +91 1800
							1234 5678</td>
						<td width="220"><table width="60%" border="0" cellspacing="0"
								cellpadding="3">
								<tr>
									<td colspan="2"><input type="text" name="txtlastname"
										id="txtlastname"
										style="width: 150px; height: 18px; border: 1px solid #fff; border-radius: 3px;" /></td>
								</tr>
								<tr>
									<td class="menu_nav"><span class="para"> <input
											type="checkbox" name="checkbox3" id="checkbox3" />
									</span></td>
									<td class="menu_nav">Keep Login</td>
								</tr>
							</table></td>
						<td width="126"><table width="60%" border="0" cellspacing="0"
								cellpadding="3">
								<tr>
									<td><input type="text" name="txtlastname2"
										id="txtlastname2"
										style="width: 150px; height: 18px; border: 1px solid #fff; border-radius: 3px;" /></td>
								</tr>
								<tr>
									<td class="menu_nav">Forget Password</td>
								</tr>
							</table></td>
						<td width="129" align="center" valign="top"><img
							src="${pageContext.request.contextPath}/images/login.png" alt="login" width="78" height="29" /></td>
					</tr>
				</table></td>
		</tr>
	</table>
</body>
</html>