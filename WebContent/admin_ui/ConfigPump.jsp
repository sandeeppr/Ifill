<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
<title>Ifill : Pump Configurations</title><link href="${pageContext.request.contextPath}/css/datepicker.css" rel="stylesheet" type="text/css" />
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
							url : "/ifill/metadata/fuels",
							contentType : 'application/json',
							dataType : "text",
							success : function(ldr) {
								var finalData = jQuery.parseJSON(ldr);
								$.each(finalData, function(index, value) {
								//alert(value);
								$("#fuelType").append(
										'<option value="'+value+'">' + value
												+ '</option>');
								
								});
							},
							error : function(xhr) {
								alert("Opps !!!! Somethings went wrong at the server. Please contact admin for further help : "
										+ xhr.status);
							}
						});
						
						// see if u can configure and pull these from server
						var statuses = [{"status" : "ACTIVE" },{"status" : "INACTIVE"}];
						$.each(statuses, function(index, value) {
							alert(value.status);
							$("#status").append(
											'<option value="'+value.status+'">' + value.status
													+ '</option>');
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
						//alert(JSON.stringify($('#dailydips').serializeObject()));
						//alert($('#dailydips').attr('action'));
						$.ajax({
							type : "POST",
							url : $('#dailydips').attr('action'),
							data : JSON.stringify($('#dailydips').serializeObject()),
							contentType : 'application/json',
							dataType : "text",
							success : proceed,
							error : function(xhr) {
								alert("Opps !!!! Somethings went wrong at the server. Please contact admin for further help : "
										+ xhr.status);
								console.log(xhr);
							}
						});
					
					});
					
					var readings = 1;
					var KEY_SEPERATOR = "~";
					function proceed(response) {
						//alert('submited values');
						var product = $('#product').val();
						var reading = $('#reading').val();
						var date = $('#date').val();
						
						//alert(readings);
						var key = "readingsGrid"+readings+ KEY_SEPERATOR +product+ KEY_SEPERATOR +date+ KEY_SEPERATOR +reading;
						$('#readingsGrid'+readings).append("<td><div class='col-md-offset-1 col-md-10'><a href='#' id="+key+" name="+key+"  onClick='deleteRow(this)'><img src='${pageContext.request.contextPath}/images/delete_btn.png' alt='delete_btn.png' width='15' height='15'/> </a></div></td>");
						
						$('#readingsGrid'+readings).append("<td><div class='col-md-offset-1 col-md-10'>"+readings+"</div></td>");
						$('#readingsGrid'+readings).append("<td><div class='col-md-offset-1 col-md-10'>"+product+"</div></td>");
						$('#readingsGrid'+readings).append("<td><div class='col-md-offset-1 col-md-10'>"+date+"</div></td>");
						$('#readingsGrid'+readings).append("<td><div class='col-md-offset-1 col-md-10'>"+reading+"</div></td>");
						
						readings = readings + 1;
						//alert(readings);
						$('#tab_logic').append("<tr id='readingsGrid"+readings+"' ></tr>");
						
						$('#product').val("");
						$('#reading').val("");
						$('#date').val("");
					}
				
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
		</tr>
	</table>
	<br />
	<table width="1003" border="0" align="center" cellpadding="0"
		cellspacing="0">
		<tr>
			<td width="263" height="40" align="left"
				style="background-image: url(${pageContext.request.contextPath}/images/report_button.png); background-repeat: no-repeat"
				class="subheading">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;Pump Configuration</td>
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
							<th class="text-center">Pump Id </th>
							<th class="text-center">Name </th>
							<th class="text-center">Fuel</th>
							<th class="text-center">Status</th>
						</tr>
					</thead>
					<tbody>
						<tr id='addr0'>
							<td><div class="col-md-offset-1 col-md-10"><input type="text" name='pumpid' id='pumpid' class="form-control" /></div></td>
							<td><div class="col-md-offset-1 col-md-10"><input type="text" name='name' id='name' class="form-control" /></div></td>
							<td><div class="col-md-offset-1 col-md-10">
									<select class='form-control' id='fuelType' name='fuelType' ><option value="XXX">Select&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;</option></select>
							</div></td>
							<td><div class="col-md-offset-1 col-md-10">
									<select class='form-control' id='status' name='status' ><option value="XXX">Select&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;</option></select>
							</div></td>
						</tr>
						<tr id='addr1'></tr>
					</tbody>
				</table>
				<table ><tr><td class="col-md-offset-1 col-md-10"></td>
						<td class="col-md-offset-1 col-md-10"></td>
						<td class="col-md-offset-1 col-md-10"></td>
						<td class="col-md-offset-1 col-md-10"></td>
						<td><a id='submit_row' href="" class="pull-right btn btn-default">Submit Values</a></td></table>
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
				<tr>
					<th class="text-center">PumpId</th>
					<th class="text-center">Desc/Name</th>
					<th class="text-center">Fuel Type</th>
				</tr>
				</thead>
				<tr id="readingsGrid1"></tr>
			</table>
			<table ><tr><td class="col-md-offset-1 col-md-10"></td>
						<td class="col-md-offset-1 col-md-10"></td>
						<td class="col-md-offset-1 col-md-10"></td>
						<td class="col-md-offset-1 col-md-10"></td>
						<td><a id='backbutton' href="/ifill/views/showHomePage" class="pull-right btn btn-default">Go Back</a></td></table>
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