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
		case "cropdescription_rate":
			if($db->del("tbl_district_croptree_rate","id=".$_GET['id'])){
				$msg =  "Successfully deleted  crop description.";
			}else{
				$msg =  "Ooups! Could not delete crop description.";
			}
		break;
		case "propertydescription":
			if($db->update_single("tbl_property_description", "active", 0, "id=".$_GET['id'])){
				$msg =  "Successfully deleted  improvement description.";
			}else{
				$msg =  "Ooups! Could not delete improvement description.";
			}
		break;
		case "delete_property_description":
			if($db->del("tbl_property_types_description", "id=".$_GET['id'])){
				$msg = 'success';
			}else{
				$msg = "Ooups! Could not delete improvement type description.";
			}
		break;
		case "delete_crop_description":
			if($db->del("tree_crop_types_description", "id=".$_GET['id'])){
				$msg = 'success';
			}else{
				$msg = "Ooups! Could not delete crop type description.";
			}
		break;
		case "tblPropertyRates":
			if($db->del("tbl_district_property_rate",  "id=".$_GET['id'])){
				$msg =  "Successfully deleted  improvement rate.";
			}else{
				$msg =  "Ooups! Could not delete improvement rate.";
			}
		break;
		case "tblPropertyType":
			if($db->update_single("tbl_property_type", "active", 0, "id=".$_GET['id'])){
				$msg =  "Successfully deleted  improvement.";
			}else{
				$msg =  "Ooups! Could not delete improvement.";
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
			require_once("lib/PAP_Improvement.php");
			$pap_improvement_obj = new PAP_Improvement();
			if($pap_improvement_obj->deletePapImprovement($_GET['id'])){
				$msg =  "Success";
			}
		break;
		case "tblPapCondensedReport":
			$pap = new ProjectAffectedPerson();
			if(isset($_GET['turn_off'])){
				if($pap->turnOffPap($_GET['id'])){
					$msg =  "Success";
				}
			}else{
				if($pap->deletePap($_GET['id'])){
					$pap_improvement_obj = new PAP_Improvement();
					$pap_crop_tree_obj = new PAP_CropTree();
					
					$pap_crop_tree_obj->deletePapCropTree("`pap_id` = ".$_GET['id']);
					$pap_improvement_obj->deletePapImprovement("`pap_id` = ".$_GET['id']);
					
					$msg =  "Success";
				}
			}
		break;
		case "tblPapPhoto":
			require_once("lib/ProjectAffectedPerson.php");
			$pap_obj = new ProjectAffectedPerson();
				$response['success'] = false;
			//first delete the photo then also from the db
			$pap_photo = $pap_obj->getPapPhotoById($_GET['id']);
			$the_file = "img/paps/pap_" . $pap_photo['pap_id'] . "/" . $pap_photo['file_name'];
			//echo $the_file;
			if(file_exists($the_file)) //delete the file if it really exists in the file system
				unlink($the_file);
			if($pap_obj->deletePapPhoto($_GET['id'])){
				$response['success'] = true;
				$response['message'] = "Successfully deleted";
			}
			$msg = json_encode($response);
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
		case "tblDistrict":
			if($db->turnOff("tbl_district", "id=".$_GET['id'])){
				$msg =  "Success";
			}
		break;
		case "tblCounties":
			if($db->turnOff("tbl_county", "id=".$_GET['id'])){
				$msg =  "Success";
			}
		break;case "tblSubCounties":
			if($db->turnOff("tbl_subcounty", "id=".$_GET['id'])){
				$msg =  "Success";
			}
		break;
		case "tblParish":
			if($db->turnOff("tbl_parish", "id=".$_GET['id'])){
				$msg =  "Success";
			}
		break;
		case "tblVillage":
			if($db->turnOff("tbl_village", "id=".$_GET['id'])){
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