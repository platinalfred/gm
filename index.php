<?php 
session_start();
?>
<!DOCTYPE html>
<html>

<head>
    <title>
        GMT CONSULTS LIMITED
    </title>
	<meta charset="UTF-8" />
	<link rel="shortcut icon" href="images/favicon.ico" />
    <link href="stylesheets/bootstrap.min.css" media="all" rel="stylesheet" type="text/css" />
    <link href="stylesheets/font-awesome.min.css" media="all" rel="stylesheet" type="text/css" />
    <link href="stylesheets/hightop-font.css" media="all" rel="stylesheet" type="text/css" />
    <link href="stylesheets/style.css" media="all" rel="stylesheet" type="text/css" />
	<script src="js/jquery-2.1.1.js" type="text/javascript"></script>
    <script src="js/ui/1.10.3/jquery-ui.js" type="text/javascript"></script>
    <script src="js/bootstrap.min.js" type="text/javascript"></script>
    <script src="javascripts/bootstrap.min.js" type="text/javascript"></script>
	
    <script src="javascripts/jquery.validate.js" type="text/javascript"></script>
    <script src="javascripts/respond.js" type="text/javascript"></script>
    <meta content="width=device-width, initial-scale=1.0, maximum-scale=1.0, user-scalable=no" name="viewport">
</head>

<body class="login1 signup">
	<?php 
	if(isset($_POST['tbl']) && $_POST['tbl'] == "gmt103932092030932"){
           
		$email = $_POST['email'];
		$password = $_POST['password'];
		require_once("lib/Staff.php");
		$staff = new Staff();
		if($staff->getLogin($email, $password)){
                     /*print_r($_SESSION);
                     die();*/
			if(isset($_SESSION['field_officer'])){ ?>
				<script>
					window.location = "land-acquisition.php";
				</script>
				<?php
				//header("Location:land-acquisition.php");
			}else{ ?>
				<script>
				window.location = "main.php";
				
				</script>
				<?php
			}
			
		}else{
			$msg =  "Incorrect Email / Password.";
			?>
			<script>
			setTimeout(function(){ document.getElementById("message").innerHTML =  ""; }, 3000);
			</script>
			<?php
		}
	}
	?>
    <!-- Login Screen -->
    <div class="login-wrapper">
		<div class="col-md-8" style="width: 70%;margin: 20% 20%;">
			<div class="col-md-4" style="margin-top: -50px;">
				<div class="social-login clearfix">
					<h2 class="font-bold">Welcome to GMT Finance, Administration and Project Management System</h2>
					<p></p>
				</div>
				<p class="signup">
					An easy way to manage company and project records 
				</p>
			</div>
			<div class="col-md-6">
				<div class="login-container">
					<h1>
					  <a href="#"><img src="images/logo.png" style="width:80%;"></a>
					</h1>
					<p style="color:#ff0000;" id="message"><?php echo @$msg; ?></p>
					<form id="tblLoginForm" method="post" action="">
					
						<input type="hidden" name="tbl" value="gmt103932092030932">
						<div class="form-group">
							<input autocomplete="off" class="form-control" type="email" name="email" autocomplete="Enter your email address" placeholder="Enter your email address">
						</div>
						<div class="form-group">
							&nbsp;
						</div>
						<div class="form-group">
							<input class="form-control" autocomplete="off" type="password" placeholder="password" name="password" type="password" value="">
							<input type="submit" value="&#xf054;">
						</div>
						<div class="form-options">
							<label class="checkbox">
								<input type="checkbox"><span>Remember Me.</span></label>
						</div>
					</form>
				</div>
			</div>
		</div>
    </div>
    <!-- End Login Screen -->
	<script>
		$(document).ready(function(){
			$(window).load(function() {
			  return $(".login-container").addClass("active");
			});
			function showStatusMessage(message='', display_type='success'){
				new PNotify({
					  title: "Action response",
					  text: message,
					  type: display_type,
					  styling: 'bootstrap3',
					  sound: true,
					  hide:true,
					  buttons: {
						closer_hover: false,
					},
					confirm: {
						confirm: true,
						buttons: [{
							text: 'Ok',
							addClass: 'btn-primary',
							click: function(notice) {
								notice.remove();
							}
						},
						null]
					},
					animate: {
						animate: true,
						in_class: 'zoomInLeft',
						out_class: 'zoomOutRight'
					},
					  nonblock: {
						  nonblock: true
					  }
					  
				  });
				
			}
			$("#tblLoginForm").validate({
				rules: {
					email: {
						required: true,
						// Specify that email should be validated
						// by the built-in "email" rule
						email: true
					},
					password: {
						required: true
					}
				},
				 messages: {
					password: {
						required: "Please provide a password"
					},
					email: {
						required: "Please enter your email to login"
					}
				 },
				submitHandler: function(form) {
					form.submit();
				}
			});
			
		});
		function saveData(form,event){
			event.preventDefault();
			//var frm = 
			$(form).closest("form").submit();
			/* 
			var frmdata = frm.serialize();
			var id_input = frm.find("input[name = 'id']").val();;
			var frmId = frm.attr('id');
			$.ajax({
				url: "save_data.php",
				type: 'POST',
				dataType:'json',
				data: frmdata,
				success: function (response) {
					alert(response);
					console.log(response);
					if(response.success){
						showStatusMessage("Data successfully saved" ,"success");
						setTimeout(function(){
							if(id_input == ""){
								document.getElementById(frmId).reset();
								//$(frmId).reset();
							}
							dTable[frmId].ajax.reload();
							
						}, 2000);
					}else{
						showStatusMessage(response.message, "fail");
					} 
					
				}
			});
			return false; */
			//});
		}
	</script>
</body>

</html>