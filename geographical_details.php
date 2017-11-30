<?php 
require_once("lib/Libraries.php");
if(isset($_POST['origin'])){
	$data = $_POST;
	$districts = new Districts();
	$counties = new Counties();
	$subcounties = new SubCounties();
	$parishes = new Parish();
	switch($data['origin']){
		/* case "counties":
			$districts = new Districts();
			$result['districts'] =  $districts->findAll();
		break; */
		case "subcounties":
			$result['districts'] =  $districts->findAll();
			//$result['counties'] =  $counties->findAll();
		break;
		
		case "parishes":
			$result['districts'] =  $districts->findAll();
			//$result['counties'] =  $counties->findAll();
			$result['subcounties'] =  $subcounties->findAll();
		break;
		case "villages":
			$result['districts'] =  $districts->findAll();
			//$result['counties'] =  $counties->findAll();
			$result['subcounties'] =  $subcounties->findAll();
			$result['parishes'] =  $parishes->findAll();
		break;
	}
	echo json_encode($result);
}
//print_r($_GET);
?>