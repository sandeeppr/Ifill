<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
	pageEncoding="ISO-8859-1"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
<title>Ifill : Lubes Sale</title>
<link href="${pageContext.request.contextPath}/css/datepicker.css" rel="stylesheet" type="text/css" />
<link href="${pageContext.request.contextPath}/css/bootstrap.css" rel="stylesheet" media="screen">
<link href="${pageContext.request.contextPath}/css/style.css" rel="stylesheet" type="text/css" />
<script src="${pageContext.request.contextPath}/js/jquery-2.1.0.min.js" type="text/javascript"></script>
<script src="${pageContext.request.contextPath}/js/bootstrap.min.js"></script>
<script src="${pageContext.request.contextPath}/js/bootstrap-datepicker.js" type="text/javascript"></script>
<script type="text/javascript">
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
<script type="text/javascript">
	$(document)
			.ready(
					function() {
					
						// writing on load. 
						// pull lubes and populate the form
						//alert('On load');
						$.ajax({
							type : "GET",
							url : "/ifill/metadata/lubes",
							contentType : 'application/json',
							dataType : "text",
							success : function(ldr) {
								var finalData = jQuery.parseJSON(ldr);
								$.each(finalData, function(index, value) {
								//alert(value);
								$("#product").append(
										'<option value="'+value+'">' + value
												+ '</option>');
								
								});
							},
							error : function(xhr) {
								alert("Opps !!!! Somethings went wrong at the server. Please contact admin for further help : "
										+ xhr.status);
							}
						});
						
					
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
						
					$('#quantity').blur(function(e){
						var val = $('#quantity').val();
						if(val.length < 1 || !$.isNumeric(val)){
							alert('Please provide a valid number for Quantity.');
						}
					});

				$('#submit_row').click(function(){
				
						var product = $('#product').val();
						var reading = $('#quantity').val();
						var date = $('#date').val();
						
						if(product == "XXX" || reading.length < 1 || !$.isNumeric(reading) || date.length < 1){
							alert('Please fill all valid values before submitting.');
						}else{
							// now submit values
							//alert(JSON.stringify($('#lubeSales').serializeObject()));
							//alert($('#lubeSales').attr('action'));
							$.ajax({
								type : "POST",
								url : $('#lubeSales').attr('action'),
								data : JSON.stringify($('#lubeSales').serializeObject()),
								contentType : 'application/json',
								dataType : "text",
								success : proceed,
								error : function(xhr) {
									alert("Opps !!!! Somethings went wrong at the server. Please contact admin for further help : "
											+ xhr.status);
									console.log(xhr);
								}
							});
						}
					});
					
					$('#quantity').keyup(function(e){					
						var val = $('#quantity').val();
						if(val.length < 1 || !$.isNumeric(val)){
							alert('Please provide a number for quantity.');
						}else{
							//alert('calculating price');
							$.ajax({
								type : "GET",
								url : "/ifill/metadata/"+$('#product').val()+"/itemprice",
								contentType : 'application/json',
								dataType : "text",
								success : function(price) {	
									var units = $('#quantity').val();											
									var saleInRs = units * price ; 
									//alert("price:"+saleInRs);
									$('#saleInRs').val(saleInRs);
								},
								error : function(xhr) {
									alert("Opps !!!! Somethings went wrong at the server. Please contact admin for further help : "
											+ xhr.status);
								}
							});
						}
						//alert('calculted');						
					})
					
					var readings = 1;
					var KEY_SEPERATOR = "~";
					function proceed(response) {
						//alert('submited values');
						//alert(response);
						var product = $('#product').val();
						var reading = $('#quantity').val();
						var date = $('#date').val();
						
						//alert(readings);
						var key = "readingsGrid"+readings+ KEY_SEPERATOR +response;
						$('#readingsGrid'+readings).append("<td><div class='col-md-offset-1 col-md-10'><a href='#' id="+key+" name="+key+"  onClick='deleteRow(this)'><img src='${pageContext.request.contextPath}/images/delete_btn.png' alt='delete_btn.png' width='15' height='15'/> </a></div></td>");
						
						$('#readingsGrid'+readings).append("<td><div class='col-md-offset-1 col-md-10'>"+readings+"</div></td>");
						$('#readingsGrid'+readings).append("<td><div class='col-md-offset-1 col-md-10'>"+product+"</div></td>");
						$('#readingsGrid'+readings).append("<td><div class='col-md-offset-1 col-md-10'>"+date+"</div></td>");
						$('#readingsGrid'+readings).append("<td><div class='col-md-offset-1 col-md-10'>"+reading+"</div></td>");
						
						readings = readings + 1;
						//alert(readings);
						$('#tab_logic').append("<tr id='readingsGrid"+readings+"' ></tr>");
						
						 $('#product').val("XXX");
						 $('#quantity').val("");
						 $('#date').val("");
					}

					var today = new Date();
					var previousDate = new Date(today);
					previousDate.setDate(today.getDate() - 7);
					
					//alert(previousDate);
					//alert(today);
					$('#date').datepicker({
						startDate : previousDate,
						endDate : today,
					    autoclose : true,
					    todayBtn : true
					});
					
							
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
					
			function deleteRow(e){
						
						var id = e.id;
						var tokens = id.split("~");
						
						var key = tokens[1];//+ "~" +tokens[2];
						// delete call
						$.ajax({
							type : "DELETE",
							url : "/ifill/inventory/"+key+"/deleteLubeSales",
							contentType : 'application/json',
							dataType : "text",
							success : function(status) {												
								document.getElementById(tokens[0]).remove();								
								alert('Row successfully deleted !!');
							},
							error : function(xhr) {
								alert("Opps !! We could not delete the row now. Please try again. Please find the cause : "
										+ xhr.status);
							}
						});
						
					}
</script>
</head>
<body>
	<table width="1003" border="0" align="center" cellpadding="0"
		cellspacing="0">
		<tr>
			<td width="604" height="30"><span class="logo">I-</span><span
				class="logo1">fill </span></td>
			<td width="399" height="45" align="right" valign="top"><a href="#" id='logoutButton'><img src="${pageContext.request.contextPath}/images/logout.png" alt="logout.png" width="120" height="40" /></a></td>
		</tr>
	</table>
	<table width="1003" border="0" align="center" cellpadding="0"
		cellspacing="0">
		<tr>
			<td><img src="${pageContext.request.contextPath}/images/banner2.jpg" alt="image2" width="1003" height="150" /></td>
			
			<%-- <div id="innerflash">
					<!--innerflash starts-->
					<div class="joomla_ass" align="center">

						<div class="border_box">

							<div class="box_skitter box_skitter_large44">

								<ul style="display: none;">

									<li><img src="${pageContext.request.contextPath}/images/banner2.jpg" alt="image2"
										width="1003" height="300" /></li>
									<li><img src="${pageContext.request.contextPath}/images/banner1.jpg" alt="image1"
										width="1003" height="300" /></li>
									<li><img src="${pageContext.request.contextPath}/images/banner3.jpg" alt="image3"
										width="1003" height="300" /></li>
								</ul>
							</div>
						</div>
					</div>
				</div> --%>
		</tr>
	</table>
	<br />
	<table width="1003" border="0" align="center" cellpadding="0"
		cellspacing="0">
		<tr>
			<td width="263" height="40" align="left"
				style="background-image: url(${pageContext.request.contextPath}/images/report_button.png); background-repeat: no-repeat"
				class="subheading">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;Lubes Sale</td>
			<td width="740">&nbsp;</td>
		</tr>
	</table>
	<div class="container">
		<div class="row clearfix">
			<div class="col-md-offset-1 col-md-10 column">
			<form method="POST" id="lubeSales" action="/ifill/inventory/postLubeSales">
				<table class="table  table-striped" >
					
					<tbody>
						<tr id='addr0'>
							<td></td>
							<td><div class="col-md-offset-4 col-md-6"><label for='product' class='col-md-3 control-label'>Lube </label></div></td>
							<td><div class="col-md-offset-1 col-md-10">
									<select name="product" id="product" class="form-control" >
									<option value="XXX">Select</option>
									<!-- <option value="SampleLube1">Sample Lube 1</option>
									<option value="SampleLube2">Sample Lube 2</option> -->
									
							</select></div></td>
							<td><div class="col-md-offset-4 col-md-6"><label for='product' class='col-md-3 control-label'>Date</label></div></td>
							<td><div class="col-md-offset-1 col-md-10"><input type="text" class="form-control datepicker" size="25" placeholder='Report Date' id="date" name="date"  data-date-format="dd-mm-yyyy"/></div></td>
							<td><div class="col-md-offset-4 col-md-6"><label for='quantity' class='col-md-3 control-label'>Quantity (units)</label></div></td>
							<td><div class="col-md-offset-1 col-md-10">
								<input type="text" id='quantity' name='quantity' size="25" placeholder='Units' class="form-control" />
								<input type="hidden" id="saleInRs" name="saleInRs" />
							</div></td>
						</tr>
						<tr id='addr1'></tr>
					</tbody>
				</table>
				<table ><tr><td class="col-md-offset-1 col-md-10"></td>
						<td class="col-md-offset-1 col-md-10"></td>
						<td class="col-md-offset-1 col-md-10"></td>
						<td class="col-md-offset-1 col-md-10"></td>
						<td><a id='submit_row' class="pull-right btn btn-default">&nbsp;&nbsp;&nbsp; Add &nbsp;&nbsp;&nbsp;</a></td></tr></table>
			</form>
			</div>
			
		</div>
		<hr width="75%">
	</div>
	
	<div class="container">
		<div class="row clearfix">
			<div class="col-md-offset-1 col-md-10 column" >
			<table class="table table-condensed table-striped table-bordered " id="tab_logic">
				<thead>
					<th class="text-center"></th>
					<th class="text-center">#</th>
					<th class="text-center">Product</th>
					<th class="text-center">Date</th>
					<th class="text-center">Units</th>
				</thead>
  				<tr id="readingsGrid1"></tr>
			</table>
			<table ><tr><td class="col-md-offset-1 col-md-10"></td>
						<td class="col-md-offset-1 col-md-10"></td>
						<td class="col-md-offset-1 col-md-10"></td>
						<td class="col-md-offset-1 col-md-10"></td>
						<td><a id='backbutton' href="/ifill/inventory/showHomePage" class="pull-right btn btn-default">Go Back</a></td></table>
			</div>
		</div>
	</div>
			
	<br />
	<br />
	<br />	
	<br />
	<br />
	<br />
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