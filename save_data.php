<?php
require_once('lib/Libraries.php');
//require_once("lib/SimpleImage.php");
//$images = new SimpleImage();
$output = "";
if(isset($_POST['tbl'])){
	$data = $_POST;
	switch($data['tbl']){
		case "land_acquisition":
			$lan_acquisition_category = new landAcquisitionCategory();
			if($data['id'] != ""){
				if($lan_acquisition_category->updateLandAccessCategory($data)){
					$output = "success";
				}else{ 
					$output = "Land Acquisition category could not be updated. Please try again or contact admin for assistance!";
				}
			}else{
				$data['date_added'] = date("Y-m-d h:i:s");
				if($lan_acquisition_category->addLandAcquisitionCategory($data)){
					$output = "success";
				}else{ 
					$output = "Land Acquisition category could not be added. Please try again or contact admin for assistance!";
				}
			}
			
		break;
		case "land_acquisition_unit":
			$lan_acquisition_category_unit = new landAcquisitionCategoryUnit();
			if($_POST['id'] != ""){
				if($lan_acquisition_category_unit->updateLandAccessCategory($data)){
					$output = "success";
				}else{ 
					$output = "Land Acquisition category unit could not be updated. Please try again or contact admin for assistance!";
				}
			}else{
				$data['date_added'] = date("Y-m-d h:i:s");
				if($lan_acquisition_category_unit->addLandAcquisitionCategoryUnit($data)){
					$output = "success";
				}else{ 
					$output = "Land Acquisition category unit  could not be added. Please try again or contact admin for assistance!";
				}
			}
			
		break;
		case "access_level":
			$access_level = new AccessLevel();
			if($_POST['id'] != ""){
				if($access_level->updateAccessLevel($data)){
					$output = "success";
				}else{ 
					$output = "Access level unsuccessfully updated!";
				}
			}else{
				$data['date_added'] = date("Y-m-d h:i:s");
				if($access_level->addAccessLevel($data)){
					$output = "success";
				}else{ 
					$output = "Could not add access level!";
				}
			}
			
		break;
		case "position":
			$position = new Position();
			if($_POST['id'] != ""){
				if($position->updatePosition($data)){
					$output = "success";
				}else{ 
					$output = "Position update failed,,please contact administrator for assistance.";
				}
			}else{
				if($position->addPosition($data)){
					$output = "success";
				}else{ 
					$output = "Could not add position,please contact administrator for assistance.";
				}
			}
			
		break;
		case "expense_type":
			$expense_type = new ExpenseTypes();
			if($_POST['id'] != ""){
				if($expense_type->updateExpenseType($data)){
					$output = "success";
				}else{ 
					$output = "Ooups! expense type not updated, please contact administrator for assistance.";
				}
			}else{
				if($expense_type->addExpenseType($data)){
					$output = "success";
				}else{ 
					$output = "Ooups! expense type not added, please contact administrator for assistance.";
				}
			}
			
		break;
		case "treecroptypes":
			$treecroptypes = new TreeCropTypes();
			if($_POST['id'] != ""){
				if($treecroptypes->updateTreeCropType($data)){
					$output = "success";
				}else{ 
					$output = "Ooups! Tree or crop type not updated, please contact administrator for assistance.";
				}
			}else{
				if($treecroptypes->addTreeCropType($data)){
					$output = "success";
				}else{ 
					$output = "Ooups! Tree or crop type not added, please contact administrator for assistance.";
				}
			}
			
		break;
		case "treecroptypedescription":
			$treecroptypedescription = new TreeCropTypesDescription();
			if(!empty($_POST['crop_description_id'])){
				$data['tree_crop_id'] = $_POST['tree_crop_id'];
				
				foreach($_POST['crop_description_id'] as $single){
					$data['crop_description_id'] = $single;
					$treecroptypedescription->addTreeCropTypesDescription($data);
				}
				$output =  "success";
			}else{
				$output = "There were no descriptions selected.";
			}
		break;
		case "propertytypesdescription":
			$propertytypedescription = new PropertyTypeDescription();
			if(!empty($_POST['crop_description_id'])){
				$data['tree_crop_id'] = $_POST['tree_crop_id'];
				
				foreach($_POST['crop_description_id'] as $single){
					$data['crop_description_id'] = $single;
					$propertytypedescription->addPropertyTypeDescription($data);
				}
				$output =  "success";
			}else{
				$output = "There were no descriptions selected.";
			}
		break;
		case "CropDescription":
			$crop_description = new CropDescription();
			if($_POST['id'] != ""){
				if($crop_description->updateCropDescription($data)){
					$output = "success";
				}else{ 
					$output = "Ooups! crop description not updated, please contact administrator for assistance.";
				}
			}else{
				if($crop_description->addCropDescription($data)){
					$output = "success";
				}else{ 
					$output = "Ooups! crop description not added, please contact administrator for assistance.";
				}
			}
			
		break;
		case "propertyDescription":
			$property_description = new PropertyDescription();
			if($_POST['id'] != ""){
				if($property_description->updatePropertyDescription($data)){
					$output = "success";
				}else{ 
					$output = "Ooups! property description not updated, please contact administrator for assistance.";
				}
			}else{
				if($property_description->addPropertyDescription($data)){
					$output = "success";
				}else{ 
					$output = "Ooups! property description not added, please contact administrator for assistance.";
				}
			}
			
		break;
		case "propertytypes":
			$propertytypes = new PropertyTypes();
			if($_POST['id'] != ""){
				if($propertytypes->updatePropertyTypes($data)){
					$output = "success";
				}else{ 
					$output = "Ooups! property type not updated, please contact administrator for assistance.";
				}
			}else{
				if($propertytypes->addPropertyTypes($data)){
					$output = "success";
				}else{ 
					$output = "Ooups! property type not added, please contact administrator for assistance.";
				}
			}
			
		break;
		//UPDATE STAFF
		case "update_staff":
			$staff = new Staff();
			$person = new Person();
			$data['id'] = $data['personId'];
			$data['dateofbirth'] = date("Y-m-d", strtotime($data['dateofbirth']));
			if($person->updatePerson($data)){
				if(!empty($data['access_levels'])){
					foreach($_POST['access_levels'] as $single){
						$data['role_id'] = $single;
						$staff->updateStaffAccessLevels($data);
					}
				}
				$data['id'] = $_POST['member_id'];
				if(!$staff->isValidMd5($data['password'])){
					$data['password'] = md5($data['password']);
				}
				if($staff->updateStaff($data)){
					$output = "success";
				}
			}else{ 
				$output = "Staff details could not be updated. Please try again!";
			} 
		break;
		//ADD STAFF
		case "add_staff":
			$staff = new Staff();
			$person = new Person();
			$data['dateofbirth'] = date("Y-m-d", strtotime($data['dateofbirth']));
			$data['date_added'] = date("Y-m-d");
			$data['photograph'] = "";
			$data['active']=1;
			$person_id = $person->addPerson($data);
			if($person_id){
				$data['personId'] = $person_id;
				$person->updateStaffNumber($person_id);
				if(!empty($_POST['access_levels'])){
					foreach($_POST['access_levels'] as $single){
						$data['role_id'] = $single;
						$staff->addStaffAccessLevels($data);
					}
				}
				$data['password'] = md5($data['password']);
				if($staff->addStaff($data)){
					$output = "success";
				}
			}else{ 
				$output = "Staff details could not be added. Please try again!";
			}  
		break;
		default:
			echo "No data submited!";
		break;
	}
	echo $output;
}
?>