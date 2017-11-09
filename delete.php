<?php
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
		case "marital_status":
			if($db->turnOff("marital_status", "id=".$_GET['id'])){
				$msg =  "Successfully deleted";
			}
		break;
		case "expense_types":
			if($db->turnOff("expensetypes", "id=".$_GET['id'])){
				$msg =  "Success";
			}
		break;
		case "securitytypes":
			if($db->turnOff("securitytype", "id=".$_GET['id'])){
				$msg =  "Success";
			}
		break;
		case "branch":
			if($db->turnOff("branch", "id=".$_GET['id'])){
				$msg =  "Success";
			}
		break;
		case "income_sources":
			if($db->turnOff("income_sources", "id=".$_GET['id'])){
				 $msg = "Success";
			}
		break;
		case "loan_types":
			if($db->turnOff("loan_type", "id=".$_GET['id'])){
				$msg = "Success";
			}
		break;
		case "access_level":
			if($db->turnOff("accesslevel", "id=".$_GET['id'])){
				$msg =  "Success";
			}
		break;
		case "saccogroup":
			if($db->turnOff("saccogroup", "id=".$_GET['id'])){
				$msg = "Success";
			}
		break;
		case "individual_types":
			if($db->turnOff("individual_type", "id=".$_GET['id'])){
				$msg = "Success";
			}
		break;
		case "expense":
			if($db->turnOff("expense", "id=".$_GET['id'])){
				$msg = "Success";
			}
		break;
		case "repaymentduration":
		break;
		case "position":
			if($db->turnOff("position", "id=".$_GET['id'])){
				$msg = "Success";
			}
		break;
		case "id_card_types":
			if($db->turnOff("id_card_types", "id=".$_GET['id'])){
				$msg = "Success";
			}
		break;
		case "loan_product_types":
			
		break;
		case "relationship_type":
			if($db->turnOff("relationship_type", "id=".$_GET['id'])){
				$msg = "success";
			}
		break;
		case "person_type":
			if($db->turnOff("persontype", "id=".$_GET['id'])){
				$msg = "success";
			}
		break;
		case "security_types":
			if($db->turnOff("securitytype", "id=".$_GET['id'])){
				$msg = "success";
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