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
		case "staff":
			$staff_obj = new Staff();
			$output['data'] = $staff_obj->findStaffDetails();
		break;
		case "project_setup":
			$client_obj = new Client();
			$output['clients'] = $client_obj->getSelectList();
		break;
		case "project_details":
			$project_coverage_obj = new ProjectCoverage();
			$district_property_rate_obj = new DistrictPropertyRate();
			$district_crop_rate_obj = new DistrictCropRate();
			$output['available_districts'] = $project_coverage_obj->findAvailableDistricts($_POST['project_id']);
			$output['district_property_rates'] = $district_property_rate_obj->findDistrictPropertyRates();
			$output['district_crop_rates'] = $district_crop_rate_obj->findDistrictCropRates();
		break;
		case "project_coverage":
			$project_coverage_obj = new ProjectCoverage();
			$output['data'] = $project_coverage_obj->findAll("`project_id`=".$_POST['project_id']);
		break;
		case "paps":
			$pap_obj = new ProjectAffectedPerson();
			$output['data'] = $pap_obj->findAll("`project_id`=".$_POST['project_id']);
		break;
		case "pap_details":
			$pap_crop_tree_obj = new PAP_CropTree();
			$pap_improvement_obj = new PAP_Improvement();
			$output['pap_improvements'] = $pap_crop_tree_obj->findPapImprovements("pap_id".$_POST['pap_id']);
			$output['pap_crop_trees'] = $pap_improvement_obj->findPapCropTrees("pap_id".$_POST['pap_id']);
		break;
		default:
			echo "No data found!"; 
		break;
	}
	echo json_encode($output);
}
?>