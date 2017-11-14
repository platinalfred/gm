<?php
require_once('lib/Libraries.php');
function save_file($files, $files_dir, $file_name){
	$feedback = true;
	//upload any file that came with this data
	if ($files['photo_url']['error'] == UPLOAD_ERR_OK) {
		$allowedExts = array("gif", "jpeg", "jpg", "png", "JPG", "PNG", "GIF");
		$extension = end(explode(".", $files['photo_url']["name"]));
		if(($files['photo_url']["size"] < 200000000) && in_array($extension, $allowedExts)){ 							
			if($files['photo_url']['error'] > 0){
				$feedback =  false;
			}else{
				if(!file_exists($files_dir)){
					mkdir($files_dir, 0777, true);
				}else{
					if(file_exists($files_dir.$file_name.".".$extension))
						unlink(file_exists($files_dir.$file_name.".".$extension));
				}
				$feedback = move_uploaded_file($files['photo_url']['tmp_name'], $files_dir.$file_name.".".$extension);
			}
		} 
	} 
	return $feedback;
}
$output = "";

if(isset($_POST['tbl'])){
	$data = $_POST;
	switch($data['tbl']){
		case "gmt103932092030932":
			print_r($_POST);
		break;
		case "tblClient":
			$client_obj = new Client();
			$response = array();
			if($data['id'] != ""){
				if($client_obj->updateClient($data)){
					$response['success'] = true;
				}else{ 
					$response['false'] = true;
					$response['message'] =  "Client data could not be updated. Please try again or contact admin for assistance!";
				}
			}else{
				if($client_obj->addClient($data)){
					$response['false'] = true;
				}else{ 
					$response['message'] = "Client data could not be added. Please try again or contact admin for assistance!";
				}
			}
			$output = json_encode($response);
		break;
		case "tblStaff":
			$staff_obj = new Staff();
			$response = array();
			
			if($data['id'] != ""){
				if($staff_obj->updateStaff($data)){
					$response['success'] = true;
				}else{ 
					$response['success'] = false;
					$response['message'] =  "Staff data could not be updated. Please try again or contact admin for assistance!";
				}
			}else{
				if($staff_obj->addStaff($data)){
					$response['success'] = true;
				}else{ 
					$response['success'] = false;
					$response['message'] = "Staff data could not be added. Please try again or contact admin for assistance!";
				}
			}
			$output = json_encode($response);
		break;
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
		case "tblLandProject":
			$land_project = new LandAcquisition();
			$response = "";
			if($data['id'] != ""){
				unset($data['tbl']);
				if($land_project->updateProject($data)){
					$response['success'] = true;
				}else{ 
					$response['success'] = false;
					$response['message'] = "Project details could not be updated. Please try again or contact admin for assistance!";
				}
			}else{
				$response['project_id'] = $land_project->addProject($data);
				if(is_numeric($response['project_id'])){
					$response['success'] = true;
				}else{ 
					$response['success'] = false;
					$response['message'] = "Project details could not be added. Please try again or contact admin for assistance!";
				}
			}
			$output = json_encode($response);
		break;
		case "tblProjectCoverage":
			$land_project = new ProjectCoverage();
			$response = array();
			foreach($data['district_id'] as $district_id){
				if(is_numeric($district_id)){
					$project_coverage_data['district_id'] = $district_id;
					$project_coverage_data['project_id'] = $data['project_id'];
					$response['project_coverage_ids'][] = $coverage_id = $land_project->addProjectCoverage($project_coverage_data);
					if($coverage_id){
						$response['success'] = true;
					}else{ 
						$response['success'] = false;
						$response['message'] = "Project details could not be added. Please try again or contact admin for assistance!";
					}
				}
			}
			$output = json_encode($response);
		break;
		case "tblPap": //Project affected persons details capture
			$pap_obj = new ProjectAffectedPerson();
			$pap_crop_tree_obj = new PAP_CropTree();
			$pap_improvement_obj = new PAP_Improvement();
			
			//lerts extract out the plants and the improvements from the array
			$improvements = $data['improvement'];
			$plants = $data['plant'];
			unset($data['tbl'], $data['plant'], $data['improvement']);
			
			$response = array();
			$response['success'] = false;
			$response['message'][] = "PAP details could not be saved. Please try again or contact admin for assistance!";
			$pap_id = "";
			if($data['id'] != ""){
				$pap_id = $data['id'];
				if($pap_obj->updatePap($data)){
					$add_multiple_data = $update_multiple_data = array();
					foreach($plants as $key=>$plant){ //we first deal with the plants
						if(isset($plant['id'])&&is_numeric($plant['id'])){
							$update_multiple_data[$key]['id'] = $plant['id'];
							if($plant['crop_description_rate_id']!=""&&$plant['rate']!=""&&$plant['quantity']!=""){
								$update_multiple_data[$key]['pap_id'] = $plant['pap_id'];
								$update_multiple_data[$key]['crop_description_rate_id'] = $plant['crop_description_rate_id'];
								$update_multiple_data[$key]['rate'] = $plant['rate'];
								$update_multiple_data[$key]['quantity'] = $plant['quantity'];
								$update_multiple_data[$key]['modified_by'] = isset($_SESSION['staffId'])?$_SESSION['staffId']:1;
							}
						}
						else{
							if($plant['crop_description_rate_id']!=""&&$plant['rate']!=""&&$plant['quantity']!=""){
								$add_multiple_data[$key]['pap_id'] = $plant['pap_id'];
								$add_multiple_data[$key]['crop_description_rate_id'] = $plant['crop_description_rate_id'];
								$add_multiple_data[$key]['rate'] = $plant['rate'];
								$add_multiple_data[$key]['quantity'] = $plant['quantity'];
								$add_multiple_data[$key]['date_created'] = time();
								$add_multiple_data[$key]['created_by'] = $add_multiple_data[$key]['modified_by'] = isset($_SESSION['staffId'])?$_SESSION['staffId']:1;
							}
						}
					}
					if($pap_crop_tree_obj->addPapCropTrees($add_multiple_data) && $pap_crop_tree_obj->updatePapCropTree($add_multiple_data)){
						$response['success'] = true;
						$response['message'][] = "PAP crops and trees successfully updated!";
					}
					//then the properties/improvements
					unset($add_multiple_data, $update_multiple_data);
					$add_multiple_data = $update_multiple_data = array();
					
					foreach($improvements as $key=>$improvement){
						if(isset($improvement['id'])&&is_numeric($improvement['id'])){
							if($improvement['district_property_rate_id']!=""&&$improvement['rate']!=""&&$improvement['quantity']!=""){
								$update_multiple_data[$key]['id'] = $improvement['id'];
								$update_multiple_data[$key]['pap_id'] = $improvement['pap_id'];
								$update_multiple_data[$key]['district_property_rate_id'] = $improvement['district_property_rate_id'];
								$update_multiple_data[$key]['rate'] = $improvement['rate'];
								$update_multiple_data[$key]['quantity'] = $improvement['quantity'];
								$update_multiple_data[$key]['modified_by'] = isset($_SESSION['staffId'])?$_SESSION['staffId']:1;
							}
						}
						else{
							if($improvement['district_property_rate_id']!=""&&$improvement['rate']!=""&&$improvement['quantity']!=""){
								$add_multiple_data[$key]['pap_id'] = $improvement['pap_id'];
								$add_multiple_data[$key]['district_property_rate_id'] = $improvement['district_property_rate_id'];
								$add_multiple_data[$key]['rate'] = $improvement['rate'];
								$add_multiple_data[$key]['quantity'] = $improvement['quantity'];
								$add_multiple_data[$key]['date_created'] = time();
								$add_multiple_data[$key]['created_by'] = $add_multiple_data[$key]['modified_by'] = isset($_SESSION['staffId'])?$_SESSION['staffId']:1;
							}
						}
					}
					if($pap_improvement_obj->addPapImprovements($add_multiple_data) && $pap_crop_tree_obj->updatePapCropTree($add_multiple_data)){
						$response['success'] = true;
						$response['message'][] = "PAP crops and properties successfully updated!";
					}
					if(!empty($_FILES)&&save_file($_FILES,"./img/paps/", "pap_".$pap_id)){
						$response['success'] = true;
						$response['message'][] = "PAP photo successfully updated!";
					}
				}
			}else{
				unset($data['id']);
				$pap_id = $pap_obj->addPap($data);
				if(is_numeric($pap_id)){
					//we first deal with the plants/crops
					foreach($plants as $key=>$plant){
						if($plant['crop_description_rate_id']!=""&&$plant['rate']!=""&&$plant['quantity']!=""){
							$plants[$key]['pap_id'] = $pap_id;
							$plants[$key]['date_created'] = time();
							$plants[$key]['created_by'] = $plants[$key]['modified_by'] = isset($_SESSION['staffId'])?$_SESSION['staffId']:1;
						}
					}
					if($pap_crop_tree_obj->addPapCropTrees($plants)){
						$response['success'] = true;
						$response['message'][] = "PAP crops successfully updated!";
					}
					
					//then the properties/improvements
					foreach($improvements as $key=>$improvement){
						if($improvement['district_property_rate_id']!=""&&$improvement['rate']!=""&&$improvement['quantity']!=""){
							$improvements[$key]['pap_id'] = $pap_id;
							$improvements[$key]['date_created'] = time();
							$improvements[$key]['created_by'] = $improvements[$key]['modified_by'] = isset($_SESSION['staffId'])?$_SESSION['staffId']:1;
						}
					}
					if($pap_improvement_obj->addPapImprovements($improvements)){
						$response['success'] = true;
						$response['message'][] = "PAP properties successfully updated!";
					}
					if(!empty($_FILES)&&save_file($_FILES,"./img/paps/", "pap_".$pap_id)){
						$response['success'] = true;
						$response['message'][] = "PAP photo successfully updated!";
					}
				}
			}
			$output = json_encode($response);
		break;
		case "district_rate":
			$districtcroprate = new DistrictCropRate();
			if($data['id'] != ""){
				if($districtcroprate->updateDistrictCropRate($data)){
					$output = "success";
				}else{ 
					$output = "District crop rate could not be updated. Please try again or contact admin for assistance!";
				}
			}else{
				$data['date_added'] = date("Y-m-d h:i:s");
				if($districtcroprate->addDistrictCropRate($data)){
					$output = "success";
				}else{ 
					$output = "District crop rate could not be added. Please try again or contact admin for assistance!";
				}
			}
			
		break;
		case "property_rate":
			$property_rate = new DistrictPropertyRate();
			if($data['id'] != ""){
				if($property_rate->updateDistrictPropertyRate($data)){
					$output = "success";
				}else{ 
					$output = "Property rate could not be updated. Please try again or contact admin for assistance!";
				}
			}else{
				$data['date_added'] = date("Y-m-d h:i:s");
				if($property_rate->addDistrictPropertyRate($data)){
					$output = "success";
				}else{ 
					$output = "Property rate could not be added. Please try again or contact admin for assistance!";
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
			if(!empty($_POST['property_type_id'])){
				$data['property_type_id'] = $_POST['property_type_id'];
				foreach($_POST['property_description_id'] as $single){
					$data['property_description_id'] = $single;
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