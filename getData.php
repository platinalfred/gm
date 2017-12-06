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
		case "project_report":
			$report_obj = new Report();
			$output['data'] = $report_obj->getProjectReport();
		break;
		case "project_details":
			//geography
			$project_coverage_obj = new ProjectCoverage();
			$district_property_rate_obj = new DistrictPropertyRate();
			$district_crop_rate_obj = new DistrictCropRate();case "crops_props":
			$pap_tree = new PAP_CropTree();
			$pap_improvement = new PAP_Improvement();
                        
			$output['pap_improvements'] = $pap_improvement->findByImprovements("`pap_id` IN (SELECT `id` FROM `tbl_paps` WHERE `project_id` =".$_POST['project_id'].")");
			$output['pap_crops'] = $pap_tree->findByPapCropTrees("`pap_id` IN (SELECT `id` FROM `tbl_paps` WHERE `project_id` =".$_POST['project_id'].")");
			
			$output['available_districts'] = $project_coverage_obj->findAvailableDistricts($_POST['project_id']);
			$output['available_districts'] = $project_coverage_obj->findAvailableDistricts($_POST['project_id']);
			$output['available_districts'] = $project_coverage_obj->findAvailableDistricts($_POST['project_id']);
			$output['district_property_rates'] = $district_property_rate_obj->findDistrictPropertyRates("`district_id` IN (SELECT `district_id` FROM `tbl_project_coverage` WHERE `project_id` = ".$_POST['project_id'].")");
			$output['district_crop_rates'] = $district_crop_rate_obj->findDistrictCropRates("`district_id` IN (SELECT `district_id` FROM `tbl_project_coverage` WHERE `project_id` = ".$_POST['project_id'].")");
		break;
		case "project_coverage":
			$project_coverage_obj = new ProjectCoverage();
			$output['data'] = $project_coverage_obj->findAll("`project_id`=".$_POST['project_id']);
		break;
		case "project_paps":
			$pap_obj = new ProjectAffectedPerson();
			$output['data'] = $pap_obj->findAll("`project_id`=".$_POST['project_id']);
		break;
		case "project_paps_reports":
			$pap_obj = new ProjectAffectedPerson();
			$output['data'] = $pap_obj->findAll("`project_id`=".$_POST['project_id']);
		break;
		case "pap_details":
			$pap_crop_tree_obj = new PAP_CropTree();
			$pap_improvement_obj = new PAP_Improvement();
			$output['pap_crop_trees'] = $pap_crop_tree_obj->findPapCropTrees("pap_id=".$_POST['pap_id']);
			$output['pap_improvements'] = $pap_improvement_obj->findPapImprovements("pap_id=".$_POST['pap_id']);
		break;
		case "pap_crops":
			$pap_crop_tree_obj = new PAP_CropTree();
			$output['data'] = $pap_crop_tree_obj->findPapCropTrees("pap_id=".$_POST['pap_id']);
		break;
		case "pap_improvements":
			$pap_improvement_obj = new PAP_Improvement();
			$output['data'] = $pap_improvement_obj->findPapImprovements("pap_id=".$_POST['pap_id']);
		break;
		case "crop_types":
			$treecroptypedescription = new TreeCropTypesDescription();
			$crop_description = new CropDescription();
			$output['all_attached'] = $treecroptypedescription->findCropTreeDescription("`tree_crop_id`=" . $_POST['crop_id']);
			$output['all_crop_descriptions'] = $crop_description->findAll("id NOT IN (SELECT `crop_description_id` FROM `tree_crop_types_description` WHERE `tree_crop_id`=".$_POST['crop_id'].")");
		break;
		case "improvement_desc":
			$propertytypedescription = new PropertyTypeDescription();
			$propertydescription = new PropertyDescription();
			$output['all_attached_improvements'] = $propertytypedescription->findPropertyTypeDescription("`property_type_id`=" . $_POST['property_id']);
			$output['all_improvements_description'] = $propertydescription->findAll("id NOT IN (SELECT `property_description_id` FROM `tbl_property_types_description` WHERE `property_type_id`=".$_POST['property_id'].")");
		break;
		default:
			echo "No data found!"; 
		break;
	}
	echo json_encode($output);
}