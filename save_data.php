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
		case "add_share":
			$shares = new Shares();
			if($shares->addShares($data)){
				$output = "success";
			}else{ 
				$output = "Member Share could not be added. Please try again or contact admin for assistance!";
			}
		break;
		case "share_rate":
			$shares = new Shares();
			if($shares->addShareRate($data)){
				$output = "success";
			}else{ 
				$output = "Share rate could not be added. Please try again or contact admin for assistance!";
			}
		break;
		case "add_group":
			$sacco_group = new SaccoGroup();
			$group_id = $sacco_group->addSaccoGroup($data);
			if($group_id){
				$data['groupId'] = $group_id;
				if(!empty($data['members'])){
					foreach($data['members'] as $single){
						$data['memberId'] = $single['memberId'];
						$sacco_group->addSaccoGroupMembers($data);
					}
				}
				$output = "success";
			}else{ 
				$output = "Group details could not be added. Please try again or contact admin for assistance!";
			} 
		break;
		case "update_group":
			$sacco_group = new SaccoGroup();
			if($sacco_group->updateSaccoGroup($data)){
				if(!empty($data['members'])){
					foreach($data['members'] as $single){
						$data['memberId'] = $single['memberId'];
						$sacco_group->addSaccoGroupMembers($data);
					}
				}
				$output = "success";
			}else{ 
				$output = "Group details could not be added. Please try again or contact admin for assistance!";
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