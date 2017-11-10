<?php 
require_once("lib/Libraries.php");
$output = array();
if(isset($_POST['tbl'])){
	switch($_POST['tbl']){
		case "land_access_project":
			$land_acquistion = new landAcquisition();
			$output['data'] = $land_acquistion->findAllAccess();
		break;
		case "land_acquistion_category_unit":
			$land_acquistion_category_unit = new landAcquisitionCategoryUnit();
			$output['data'] = $land_acquistion_category_unit->findUnits();
		break;
		case "expense_type":
			$expense_type = new ExpenseTypes();
			$output['data'] = $expense_type->findAll();
		break;
		case "gmt_clients":
			$client_obj = new Client();
			$output['data'] = $client_obj->findAll();
		break;
		case "project_setup":
			$client_obj = new Client();
			$output['clients'] = $client_obj->getSelectList();
		break;
		default:
			echo "No data found!"; 
		break;
	}
	echo json_encode($output);
}
?>