<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
<title>Ifill : Change Price</title>
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
							url : "/ifill/metadata/MS/pumps",
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
					var readings = 1;		
					var KEY_SEPERATOR = "~";			
					$('#submit_row').click(function(){
						var pump = $('#pumpId').val();
						var quantity = $('#quantity').val();
						var pumpTest = $('#pumpTest').val();
						var date = $('#dayDate').val();
						
						if(pump == 'XXX' || quantity.length < 1 || pumpTest.length < 1 || date.length < 1){
							alert('Please provide values for all the fields before submitting.');
						}else {
							console.log('submiting');
							//alert(JSON.stringify($('#dailyReadings').serializeObject()));
							console.log($('#dailyReadings').attr('action'));
							$.ajax({
								type : "POST",
								url : $('#dailyReadings').attr('action'),
								data : JSON.stringify($('#dailyReadings').serializeObject()),
								contentType : 'application/json',
								dataType : "text",
								success : function(loggedIn) {
									
									var ldsale = $('#ldsale').val();
									var ldsalers = $('#ldsalers').val();
									
									var key = "readingsGrid"+readings+ KEY_SEPERATOR +pump+ KEY_SEPERATOR +date;
									$('#readingsGrid'+readings).append("<td><div class='col-md-offset-1 col-md-10'><a href='#' id="+key+" name="+key+"  onClick='deleteRow(this)'><img src='${pageContext.request.contextPath}/images/delete_btn.png' alt='delete_btn.png' width='15' height='15'/> </a></div></td>");
						
									$('#readingsGrid'+readings).append("<td><div class='col-md-offset-1 col-md-10'>"+pump+"</div></td>");									
									$('#readingsGrid'+readings).append("<td><div class='col-md-offset-1 col-md-10'>"+date+"</div></td>");
									$('#readingsGrid'+readings).append("<td><div class='col-md-offset-1 col-md-10'>"+quantity+"</div></td>");
									$('#readingsGrid'+readings).append("<td><div class='col-md-offset-1 col-md-10'>"+pumpTest+"</div></td>");
									$('#readingsGrid'+readings).append("<td><div class='col-md-offset-1 col-md-10'>"+ldsale+"</div></td>");
									$('#readingsGrid'+readings).append("<td><div class='col-md-offset-1 col-md-10'>"+ldsalers+"</div></td>");
									
									readings = readings + 1;
									$('#tab_logic').append("<tr id='readingsGrid"+readings+"' ></tr>");
									
									// clear values
									$('#pumpId').val("XXX");
									$('#quantity').val("");
									$('#pumpTest').val("");
									$('#ldsale').val("");
									$('#ldsalers').val("");
								},
								error : function(xhr) {
									alert("Opps !!!! Somethings went wrong at the server. Please contact admin for further help : "
											+ xhr.status);
								}
							});
							return false;
						}
					

					});
					
					
					$('#pumpTest').keyup(function(e){
						var val = this.value;
						if($.isNumeric(val)){
							console.log('calculating sales values');
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
									//alert('effectiveSaleInLtrs : '+effectiveSaleInLtrs);
									//alert($('#pumpId').val());
									//ifill/metadata/MS/itemprice
									// get the price
									$.ajax({
										type : "GET",
										url : "/ifill/metadata/MS/itemprice",
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
					previousDate.setDate(today.getDate() - 7); // this value has to come from a property file
					
					//alert(previousDate);
					//alert(today);
					$('#dayDate').datepicker({
						startDate : previousDate,
						endDate : today,
					    autoclose : true,
					    todayBtn : true
					});
				
			});
			
			function deleteRow(e){
						alert(e);
						alert(e.id);
						var id = e.id;
						var tokens = id.split("~");
						alert("1 : "+tokens[0]);
						alert("2 : "+tokens[1]);
						alert("3 : "+tokens[2]);
						//alert("4 : "+tokens[3]);
						
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
			<td width="399" height="45" align="right" valign="top"><img
				src="${pageContext.request.contextPath}/images/logout.png" alt="logout.png" width="120" height="40" /></td>
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
		<%-- <tr>
			<td width="263" height="40" align="left"
				style="background-image: url(${pageContext.request.contextPath}/images/report_button.png); background-repeat: no-repeat"
				class="subheading">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;Daily Readings </td>
			<td width="740">&nbsp;</td>
		</tr> --%>
		<tr>
			<td width="263" height="40" align="left"
				style="background-image: url(${pageContext.request.contextPath}/images/report_button.png); background-repeat: no-repeat"
				class="subheading">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;Change Price</td>
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
							<th class="text-center">Select a Product  </th>
							<th class="text-center">Date</th>
							<th class="text-center">Current Price</th>
							<th class="text-center">New Price</th>
						</tr>
					</thead>
					<tbody>
						<tr id='addr0'>
							<td><div class="col-md-offset-1 col-md-12">
									<select class='form-control' id='pumpId' name='pumpId' ><option value="XXX">Select&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;</option></select>
									</div></td>
							<td><div class="col-md-offset-1 col-md-10"><input type="text" class="form-control datepicker" id="dayDate" name="dayDate"  data-date-format="dd-mm-yyyy"/></div></td>
							<td><div class="col-md-offset-1 col-md-10"><input type="text" name='quantity' id='quantity' class="form-control" disabled="disabled"/></div></td>
							<td><div class="col-md-offset-1 col-md-10"><input type="text" name='pumpTest' id='pumpTest' class="form-control" /></div></td>
						</tr>
						<tr id='addr1'></tr>
					</tbody>
				</table>
				<table ><tr><td class="col-md-offset-1 col-md-10"></td>
						<td class="col-md-offset-1 col-md-10"></td>
						<td class="col-md-offset-1 col-md-10"></td>
						<td class="col-md-offset-1 col-md-10"></td>
						<td><a id='submit_row' href="" class="pull-right btn btn-default">Update Values</a></td></table>
			</form>
			</div>
			
		</div>
		<hr width="35%">
	</div>
	
	<div class="container">
		<div class="row clearfix">
			<div class="col-md-offset-1 col-md-10 column" >
			<table class="table table-condensed table-striped table-bordered " id="tab_logic">
				<thead>
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
	
<%-- 	<table width="100%">
		<tr height="60">
			<td style="width: 521px; ">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;</td>
			<td height="40" align="right" ><button style="background-image:url(${pageContext.request.contextPath}/images/backbutton.png); background-repeat:no-repeat"><</button></td>
		</tr>
	</table> --%>

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