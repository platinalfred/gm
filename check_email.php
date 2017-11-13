<?php
require_once("lib/Staff.php");
$staff = new Staff();
if(isset($_POST['email'])) {
	$staff->doesMailExist($_POST['email']);
}
?>