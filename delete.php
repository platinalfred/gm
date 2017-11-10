<?php
session_start();
if(!isset($_SESSION['staff_id']))
	if(!is_numeric($_SESSION['staff_id']))
		die("Invalid access");

require_once("lib/Db.php");
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
		case "account_type":
			if($db->turnOff("accounttype", "id=".$_GET['id'])){
				$msg =  "Successfully deleted the account type";
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
		case "expense_types":
			if($db->turnOff("expensetypes", "id=".$_GET['id'])){
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