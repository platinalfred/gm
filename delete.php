<?php
session_start();
$_SESSION['staff_id'] = 1;
if(!isset($_SESSION['staff_id']))
	if(!is_numeric($_SESSION['staff_id']))
		die("Invalid access");

require_once("lib/Libraries.php");
$db = new Db();

if(isset($_GET['tbl'])){
	$msg = "Could not delete item";
	switch($_GET['tbl']){
		case "land_acquistion_category":
			require_once("lib/landAcquisitionCategory.php");
			$land_acquistion_category = new landAcquisitionCategory();
			if(isset($_GET['status']) && $_GET['status'] == "activate"){
				if($land_acquistion_category->activateStaff($_GET['id'])){
					$msg =  "Successfully activated staff.";
				}
			}else{
				if($land_acquistion_category->turnOff("land_access_project_category", "id=".$_GET['id'])){
					$msg =  "Successfully deleted category.";
				}
			}
		break;
		case "land_acquistion_category_unit":
			require_once("lib/landAcquisitionCategoryUnit.php");
			$dbObj = new landAcquisitionCategoryUnit();
			if($dbObj->deleteLandAcquisitionCategoryUnit($_GET['id'])){
				$msg =  "Success";
			}
		break;
		case "treeCropsTypes":
			if($db->del("tbl_tree_or_cropt_types", "id=".$_GET['id'])){
				$msg =  "Successfully deleted the crop type";
			}
		break;
		case "cropdescription":
			if($db->update_single("tbl_crop_description", "active", 0, "id=".$_GET['id'])){
				$msg =  "Successfully deleted  crop description.";
			}else{
				$msg =  "Ooups! Could not delete crop description.";
			}
		break;
		case "propertydescription":
			if($db->update_single("tbl_property_description", "active", 0, "id=".$_GET['id'])){
				$msg =  "Successfully deleted  property description.";
			}else{
				$msg =  "Ooups! Could not delete property description.";
			}
		break;
		case "tbl_client":
			/* require_once("lib/Client.php");
			$clientObj = new Client();
			if($clientObj->deleteClient($_GET['id'])){
				$msg =  "Success";
			} */
			if($db->turnOff("tbl_client", "id=".$_GET['id'])){
				$msg =  "Success";
			}
		break;
		case "tblProjectCoverage":
			require_once("lib/ProjectCoverage.php");
			$project_coverage_obj = new ProjectCoverage();
			if($project_coverage_obj->deleteProjectCoverage("tbl_project_coverage", "id=".$_GET['id'])){
				$msg =  "Success";
			}
		break;
		case "tblPapCrop":
			require_once("lib/PAP_CropTree.php");
			$pap_crop_tree_obj = new PAP_CropTree();
			if($pap_crop_tree_obj->deletePapCropTree($_GET['id'])){
				$msg =  "Success";
			}
		break;
		case "tblPapImprovement":
			require_once("lib/PAP_Improvementphp");
			$pap_improvement_obj = new PAP_Improvement();
			if($pap_improvement_obj->deletePapImprovement($_GET['id'])){
				$msg =  "Success";
			}
		break;
		case "expense_types":
			if($db->turnOff("expensetypes", "id=".$_GET['id'])){
				$msg =  "Success";
			}
		break;
		case "staff":
			if($db->turnOff("staff", "id=".$_GET['id'])){
				$msg =  "Success";
			}
		break;
		
		/*case "":
		break; */
		default:
			$msg =  "No data submited!";
		break;
	}
	echo $msg;
}else{
	echo "No data was submitted.please try again!";
}

?>