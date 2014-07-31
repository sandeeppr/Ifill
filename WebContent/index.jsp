<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
<title>IFill : Welcome</title>
<%-- <link href="${pageContext.request.contextPath}/css/bootstrap.css" rel="stylesheet" media="screen"> --%>
<link href="${pageContext.request.contextPath}/css/style.css" rel="stylesheet" type="text/css" />
<link rel="stylesheet" href="${pageContext.request.contextPath}/css/skitter.css" type="text/css">
<script src="${pageContext.request.contextPath}/js/jquery-2.1.0.min.js" type="text/javascript"></script>
<!-- <script src="${pageContext.request.contextPath}/js/bootstrap.min.js"></script> -->

<script type="text/javascript">
	function signIn(e){
		alert('clicked');
	}
	$(document).ready(function() {
	
	(function($) {
								$.fn.serializeObject = function() {
									var self = this, json = {}, push_counters = {}, patterns = {
										"validate" : /^[a-zA-Z][a-zA-Z0-9_]*(?:\[(?:\d*|[a-zA-Z0-9_]+)\])*$/,
										"key" : /[a-zA-Z0-9_]+|(?=\[\])/g,
										"push" : /^$/,
										"fixed" : /^\d+$/,
										"named" : /^[a-zA-Z0-9_]+$/
									};
									this.build = function(base, key, value) {
										base[key] = value;
										return base;
									};
									this.push_counter = function(key) {
										if (push_counters[key] === undefined) {
											push_counters[key] = 0;
										}
										return push_counters[key]++;
									};
						$.each($(this).serializeArray(),
							function() {
								// skip invalid keys
								if (!patterns.validate.test(this.name)) {
									return;
								}
								var k, keys = this.name.match(patterns.key), merge = this.value, reverse_key = this.name;
								while ((k = keys.pop()) !== undefined) {
									// adjust reverse_key
									reverse_key = reverse_key.replace(
											new RegExp("\\[" + k + "\\]$"), '');
									// push
									if (k.match(patterns.push)) {
										merge = self.build([], self
												.push_counter(reverse_key),
												merge);
									}
									// fixed
									else if (k.match(patterns.fixed)) {
										merge = self.build([], k, merge);
									}
									// named
									else if (k.match(patterns.named)) {
										merge = self.build({}, k, merge);
									}
								}
								json = $.extend(true, json, merge);
							});
			return json;
		};
	})(jQuery);
		$('#signIn').click(function(){
			//alert("signing in");
			
			// validation
			var username = $("#userId").val();
			var pwd = $("#password").val();
			var isAdmin = $("input[id='isAdmin']").is(':checked');
			//alert(username);
			//alert(pwd);
			//alert(isAdmin);
			var hasError = false;
			var fields = "";
			if(username.length < 3){
				hasError = true;
				fields = 'UserName';
			} 
			if(pwd.length < 3){
				hasError = true;
				if(fields.length > 1)
					fields = fields + ",";
				fields = fields+"Password";
			}
			
			if(!hasError){
				$.ajax({
					type : "POST",
					url : $('#authorizeForm').attr('action'),
					data : JSON.stringify($('#authorizeForm').serializeObject()),
					contentType : 'application/json',
					dataType : "text",
					success : function(xhr) {
							//alert(xhr);
							if(xhr == "SUCCESS"){
								if(isAdmin){
									window.location.href="/ifill/views/showAdminHome";
								}else{
									window.location.href="/ifill/views/showHomePage";
								}
							}else
								alert("Login failed. The UserName and Password does not match.");
					},
					error : function(xhr) {
						alert("Opps !!!! Somethings went wrong at the server. Please contact admin for further help : "
								+ xhr.status);
					}
				});
			}else{
				alert('Please provide valid values for '+fields+' !!');
			}
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
    <td width="399" height="45" align="right" valign="top"></td>
  </tr>
</table>
<table width="1003" border="0" align="center" cellpadding="0" cellspacing="0">
  <tr>
    <td><img src="${pageContext.request.contextPath}/images/banner2.jpg" alt="image2" width="1003" height="250" /></td>
  </tr>
</table>
<br />
<table width="1003" border="0" align="center" cellpadding="0" cellspacing="0" >
  <tr>
    <td width="887"><table width="100%" border="0" align="center" cellpadding="0" cellspacing="0" style="border:1px solid #cccccc;
    border-radius:5px; background-image:url(images/login_bg.jpg); background-repeat:repeat-x" bgcolor="#f7f7f7">
      <tr>
        <td height="42" align="center" valign="middle"  style="">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; <br />
           <span class="subheading2">Sign in for </span><span class="welcome">I-fill</span><br />
            <br />
            <form action="/ifill/profile/authorizeUser" method="POST" id="authorizeForm">
            <table width="70%" border="0" align="center" cellpadding="0" cellspacing="0">
              <tr>
                <td width="36%"><img src="${pageContext.request.contextPath}/images/login1.png" alt="login.png" width="125" height="120" /></td>
                <td width="10%"><img src="${pageContext.request.contextPath}/images/line.png" alt="line1.png" width="1" height="200" /></td>
                <td width="54%" align="center" valign="top"><table width="94%" border="0" cellspacing="0" cellpadding="0">
                <tr>
                      <td>&nbsp;</td>
                    </tr>
                    <tr>
                      <td height="40"><table width="99%" border="0" cellspacing="0" cellpadding="0"  style="border:1px solid #cccccc;
    border-radius:3px;">
                          <tr>
                            <td width="88%" height="30"><input name="userId" id="userId" type="text" class="text_feld" style="border-color:#FFFFFF; border-style:none; background-color:#FFFFFF; background:none; height:26; font:Arial, Helvetica, sans-serif; font-size:16px; width:250px" size="35"  placeholder="User Name" /></td>
                            <td width="12%" align="center"><img src="${pageContext.request.contextPath}/images/email_icon.png" alt="email_icon.png" width="20" height="20" /></td>
                          </tr>
                      </table></td>
                    </tr>
                    <tr>
                      <td height="40">
                      <table width="99%" border="0" cellspacing="0" cellpadding="0"  style="border:1px solid #cccccc; border-radius:3px;">
                          <tr>
                            <td width="88%" height="30"><input name="password" type="password" class="text_feld" id="password" style="border-color:#FFFFFF; border-style:none; background-color:#FFFFFF; background:none; height:26; font:Arial, Helvetica, sans-serif; font-size:16px;  width:250px" size="35"  placeholder="Password" />                            </td>
                            <td width="12%" align="center"><img src="${pageContext.request.contextPath}/images/password.png" alt="password.png" width="22" height="26" /></td>
                          </tr>
                      </table></td>
                    </tr>
                    <tr>
                      <td height="40">
                      <table width="99%" border="0" cellspacing="0" cellpadding="0"  style="border:0px solid #cccccc; border-radius:3px;">
                          <tr>
                            <td width="88%" height="30"><input type="checkbox" id="isAdmin" name="isAdmin"/> Admin User</td>
                          </tr>
                      </table></td>
                    </tr>
                    <tr>
                      <td>&nbsp;</td>
                    </tr>
                    <tr>
                      <td height="35" ><table width="100%" border="0" cellspacing="0" cellpadding="0">
                          <tr>
                            <td width="50%" align="center" colspan="2" height="28" style="background-image:url(${pageContext.request.contextPath}/images/sign_up2.png); background-repeat:no-repeat; background-position:center; ">&nbsp;&nbsp;<strong><span class="para"><a href="#" class="para" id="signIn" >Login</a></span></strong></td>
                          </tr>
                      </table></td>
                    </tr>
                </table></td>
              </tr>
            </table>
            </form>
          <br /></td>
      </tr>
    </table></td>
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
