<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
	pageEncoding="ISO-8859-1"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
<title>Ifill : DailyReadings HSD</title>
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
						// pull pumps and populate the form
						//alert('On load');
						$.ajax({
							type : "GET",
							url : "/ifill/metadata/HSD/pumps",
							contentType : 'application/json',
							dataType : "text",
							success : function(ldr) {
								var finalData = jQuery.parseJSON(ldr);
								$.each(finalData, function(index, value) {
								//alert(value);
								$("#pumpId").append(
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
						
					// validations
					$('#pumpId').change(function(e){
						var val = $('#pumpId option:selected').val();
						if(val == "XXX"){
							alert('Please select a Pump to proceed.');
						}else{
								$('#quantity').val("");
								$('#pumpTest').val("");
								$('#ldsale').val("");
								$('#ldsalers').val("");
								$('#dayDate').val("");
						}
					});
					
					$('#quantity').blur(function(e){
						var val = $('#quantity').val();
						if(val.length < 1 || !$.isNumeric(val)){
							alert('Please provide a valid number for Reading.');
						}
					});
					
					
					// Submision of values
					$('#submit_row').click(function(){
						var pump = $('#pumpId').val();
						var quantity = $('#quantity').val();
						var pumpTest = $('#pumpTest').val();
						var date = $('#dayDate').val();
						
						//alert(JSON.stringify($('#dailyReadings').serializeObject()));
						if(pump == 'XXX' || quantity.length < 1 || pumpTest.length < 1 || date.length < 1){
							alert('Please provide values for all the fields before submitting.');
						}else {
							$.ajax({
								type : "POST",
								url : $('#dailyReadings').attr('action'),
								data : JSON.stringify($('#dailyReadings').serializeObject()),
								contentType : 'application/json',
								dataType : "text",
								success : proceed,
								error : function(xhr) {
									alert("Opps !!!! Somethings went wrong at the server. Please contact admin for further help : "
											+ xhr.status);
								}
							});
						}
					});
					
					var KEY_SEPERATOR = "~";
					
var readings = 1;
					function proceed(response) {
						//alert('submited values');
						var pump = $('#pumpId').val();
						var quantity = $('#quantity').val();
						var pumpTest = $('#pumpTest').val();
						var ldsale = $('#ldsale').val();
						var ldsalers = $('#ldsalers').val();
						var date = $('#dayDate').val();
						
						var key = "readingsGrid"+readings+ KEY_SEPERATOR +pump+ KEY_SEPERATOR +date;
						/* $('#readingsGrid'+readings).append("<td><div class='col-md-offset-1 col-md-10'><input type='checkbox' name="+key+" id="+key+" /></div></td>");
						 */
						$('#readingsGrid'+readings).append("<td><div class='col-md-offset-1 col-md-10'><a href='#' id="+key+" name="+key+"  onClick='deleteRow(this)'><img src='${pageContext.request.contextPath}/images/delete_btn.png' alt='delete_btn.png' width='15' height='15'/> </a></div></td>");
						$('#readingsGrid'+readings).append("<td><div class='col-md-offset-1 col-md-10'>"+pump+"</div></td>");
						$('#readingsGrid'+readings).append("<td><div class='col-md-offset-1 col-md-10'>"+date+"</div></td>");
						$('#readingsGrid'+readings).append("<td><div class='col-md-offset-1 col-md-10'>"+quantity+"</div></td>");
						$('#readingsGrid'+readings).append("<td><div class='col-md-offset-1 col-md-10'>"+pumpTest+"</div></td>");
						$('#readingsGrid'+readings).append("<td><div class='col-md-offset-1 col-md-10'>"+ldsale+"</div></td>");
						$('#readingsGrid'+readings).append("<td><div class='col-md-offset-1 col-md-10'>"+ldsalers+"</div></td>");
												
						readings = readings + 1;
						$('#tab-logic').append("<tr id='readingsGrid"+readings+"' ></tr>");
						
						// clear values
						$('#pumpId').val("XXX");
						$('#quantity').val("");
						$('#pumpTest').val("");
						$('#ldsale').val("");
						$('#ldsalers').val("");
						$('#dayDate').val("");
					}
					
					$('#pumpTest').keyup(function(e){
						var val = this.value;
						if($.isNumeric(val)){
							$.ajax({
								type : "GET",
								url : "/ifill/inventory/"+$('#pumpId').val()+"/"+$('#dayDate').val()+"/lastDayReading",
								contentType : 'application/json',
								dataType : "text",
								success : function(ldr) {
									var quantity = $('#quantity').val();
									var pumpTest = $('#pumpTest').val();
									var effectiveSaleInLtrs = quantity-ldr-pumpTest;
									$('#ldsale').val(effectiveSaleInLtrs);
									$('#effcSaleLtrs').val(effectiveSaleInLtrs);
									
									// get the price
									$.ajax({
										type : "GET",
										url : "/ifill/metadata/HSD/itemprice",
										contentType : 'application/json',
										dataType : "text",
										success : function(price) {												
											var effectiveSalesInRupees = effectiveSaleInLtrs * price ; 
											var roundedRs = (Math.round(effectiveSalesInRupees * 100)/100).toFixed(2);
											$('#ldsalers').val(roundedRs);
											$('#effcSaleRs').val(roundedRs);
										},
										error : function(xhr) {
											alert("Opps !!!! Somethings went wrong at the server. Please contact admin for further help : "
													+ xhr.status);
										}
									});	
									
								},
								error : function(xhr) {
									alert("Opps !!!! Somethings went wrong at the server. Please contact admin for further help : "
											+ xhr.status);
								}
							});
						}else{
							alert("Please enter a valid numeric value !!");
						}
					});
					
					var today = new Date();
					var previousDate = new Date(today);
					previousDate.setDate(today.getDate() - 7);
					
					//alert(previousDate);
					//alert(today);
					$('#dayDate').datepicker({
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
						
						var key = tokens[1]+ "~" +tokens[2];
						// delete call
						$.ajax({
							type : "DELETE",
							url : "/ifill/inventory/"+key+"/deleteDailyReadings",
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
				</div> --%></td>
		</tr>
	</table>
	<br />
	<table width="1003" border="0" align="center" cellpadding="0"
		cellspacing="0">
		<tr>
			<td width="263" height="40" align="left"
				style="background-image: url(${pageContext.request.contextPath}/images/report_button.png); background-repeat: no-repeat"
				class="subheading">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;DailyReadings HSD</td>
			<td width="740">&nbsp;</td>
		</tr>
	</table>
	<div class="container">
		<div class="row clearfix">
			<div class="col-md-offset-1 col-md-10 column">
			<form action="/ifill/inventory/postDailyReadings" method="POST" id="dailyReadings" >
				<table class="table table-bordered table-striped" >
					<thead>
						<tr>
							<th class="text-center">Select a Pump   </th>
							<th class="text-center">Date</th>
							<th class="text-center">Closing Reading (Liters)</th>
							<th class="text-center">Pump Test (Liters)</th>
							<th class="text-center">Sale in Liters</th>
							<th class="text-center">Sale in Rs</th>
						</tr>
					</thead>
					<tbody>
						<tr id='addr0'>
							<td><div class="col-md-12">
									<select name="pumpId" id="pumpId" class="form-control" >
									<option value="XXX">Select&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;</option>
									
							</select></div></td>
							<td><div class="col-md-offset-1 col-md-10"><input type="text" size="25" class="form-control datepicker" id="dayDate" name="dayDate"  data-date-format="dd-mm-yyyy"/></div></td>
							<td><div class="col-md-offset-1 col-md-10"><input type="text" size="25"  name='quantity' id='quantity' class="form-control" /></div></td>
							<td><div class="col-md-offset-1 col-md-10"><input type="text" size="10" name='pumpTest' id='pumpTest' class="form-control" /></div></td>
							<td><div class="col-md-offset-1 col-md-10">
									<input type="text" id='ldsale' disabled="disabled" class="form-control" />
									<input type="hidden" id='effcSaleLtrs' name="effcSaleLtrs" class="form-control" />
								</div>
							</td>
							<td><div class="col-md-offset-1 col-md-10">
									<input type="text" id='ldsalers' disabled="disabled" size="25" class="form-control" />
									<input type="hidden" id='effcSaleRs' name="effcSaleRs" class="form-control" />
								</div>
							</td>
						</tr>
						<tr id='addr1'></tr>
					</tbody>
				</table>
				<table ><tr><td class="col-md-offset-1 col-md-10"></td>
						<td class="col-md-offset-1 col-md-10"></td>
						<td class="col-md-offset-1 col-md-10"></td>
						<td class="col-md-offset-1 col-md-10"></td>
						<td><a id='submit_row' class="pull-right btn btn-default">Submit Values</a></td></tr></table>
			</form>
			</div>
			
		</div>
		<hr width="75%">
	</div>
	
	<div class="container">
		<div class="row clearfix">
			<div class="col-md-offset-1 col-md-10 column" >
			<table class="table table-condensed table-striped table-bordered "  id="tab-logic">
				<thead>
					<th class="text-center"></th>
					<th class="text-center">Pump</th>
					<th class="text-center">Date</th>
					<th class="text-center">Closing Reading (Liters)</th>
					<th class="text-center">Pump Test (Liters)</th>
					<th class="text-center">Sale in Liters</th>
					<th class="text-center">Sale in Rs</th>
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
			
	<br /><br />
	<br />
		<br /><br />
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