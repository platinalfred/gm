<?php
$curdir = dirname(__FILE__);
require_once($curdir.'/Db.php');
class ProjectAffectedPerson extends Db {
	protected static $table_name  = "tbl_paps";
	protected static $db_fields = array("id","project_id", "pap_ref", "firstname", "othername", "lastname", "phone_contact", "district_id", "subcounty_id", "tenure", "parish_id", "village_id", "way_leave", "rightofway", "total_take", "chainage", "created_by","comment","date_created","modified_by");
	
	public function findById($id){
		$result = $this->getrec(self::$table_name, "id=".$id, "", "");
		return !empty($result) ? $result:false;
	}
	
	public function findPapData($where = 1){
		$improvements = "(SELECT `pap_id`, COUNT(`id`) `improvement_cnt` FROM `tbl_pap_improvement` GROUP BY `pap_id`) `improvements`";
		$crop_trees = "(SELECT `pap_id`, COUNT(`id`) `crop_tree_cnt` FROM `tbl_pap_crop_tree` GROUP BY `pap_id`) `crop_trees`";
		$tables = "tbl_paps LEFT JOIN `tenure` ON `tenure` = `tenure`.`id` JOIN `tbl_district` ON `district_id` = `tbl_district`.`id` LEFT JOIN $improvements ON `tbl_paps`.`id` = `improvements`.`pap_id` LEFT JOIN $crop_trees ON `tbl_paps`.`id` = `crop_trees`.`pap_id` LEFT JOIN `tbl_village` ON `village_id` = `tbl_village`.`id` LEFT JOIN tbl_subcounty ON `subcounty_id` = tbl_subcounty.`id` LEFT JOIN tbl_parish ON `parish_id` = tbl_parish.`id`";
		
		// LEFT JOIN `tbl_county` ON `county_id` = `tbl_county`.`id` LEFT JOIN `tbl_subcounty` ON `subcounty_id` = `tbl_subcounty`.`id` LEFT JOIN `tbl_parish` ON `parish_id` = `tbl_parish`.`id`
		
		$fields = "`tbl_paps`.`id`, `project_id`, `pap_ref`,`comment`, `photo_url` `profile_pic`, `firstname`, `othername`, `lastname`, `phone_contact`, `district_id`, `district_name`, `county_id`, `subcounty_id`, `parish_id`, `village_id`, `village_name`,`subcounty_name`,`parish_name`, `way_leave`, `tenure`,  `tenure`.`title` `tenure_desc`, `rightofway`, `total_take`, `chainage`, `crop_tree_cnt`, `land_interest`,`rate_per_acre`,`diminution_rate`, `improvement_cnt`";
		
		$result_array = $this->getfarray($tables, $fields, $where, "", "");
		return !empty($result_array) ? $result_array : false;
	}
	public function findAll($where = 1){
		$improvements = "(SELECT `pap_id`, COUNT(`id`) `improvement_cnt`,SUM(`rate`*`quantity`) `improvement_sum` FROM `tbl_pap_improvement` WHERE `district_property_rate_id` IN (SELECT `id` FROM `tbl_district_property_rate`) GROUP BY `pap_id`) `improvements`";
		$crop_trees = "(SELECT `pap_id`, COUNT(`id`) `crop_tree_cnt`,SUM(`rate`*`quantity`) `crop_tree_sum` FROM `tbl_pap_crop_tree` WHERE `crop_description_rate_id` IN (SELECT `id` FROM `tbl_district_croptree_rate`) GROUP BY `pap_id`) `crop_trees`";
		$tables = "tbl_paps LEFT JOIN `tenure` ON `tenure` = `tenure`.`id` JOIN `tbl_district` ON `district_id` = `tbl_district`.`id` LEFT JOIN `tbl_subcounty` ON `subcounty_id` = `tbl_subcounty`.`id` LEFT JOIN `tbl_parish` ON `parish_id` = `tbl_parish`.`id` LEFT JOIN $improvements ON `tbl_paps`.`id` = `improvements`.`pap_id` LEFT JOIN $crop_trees ON `tbl_paps`.`id` = `crop_trees`.`pap_id` LEFT JOIN `tbl_village` ON `village_id` = `tbl_village`.`id`";
		
		// LEFT JOIN `tbl_county` ON `county_id` = `tbl_county`.`id` LEFT JOIN `tbl_subcounty` ON `subcounty_id` = `tbl_subcounty`.`id` LEFT JOIN `tbl_parish` ON `parish_id` = `tbl_parish`.`id`
		
		$fields = "`tbl_paps`.`id`,`tbl_paps`.`id` as pap_d, `project_id`, `pap_ref`, `photo_url` `profile_pic`, `firstname`, `othername`, `lastname`, `phone_contact`, `district_id`, `district_name`, `county_id`, `subcounty_id`, `subcounty_name`, `tenure`, `tenure`.`title` `tenure_desc`, `comment`, `parish_id`, `parish_name` ,`village_id`, `village_name`, `way_leave`, `rightofway`, `total_take`, `chainage`, `crop_tree_cnt`, `crop_tree_sum`,`land_interest`,`rate_per_acre`,`diminution_rate`, `improvement_cnt`, `improvement_sum`";
		
		$result_array = $this->getfarray($tables, $fields, $where, "", "");
		return !empty($result_array) ? $result_array : false;
	}
	public function getSelectList(){
		$fields = "`id`, CONCAT(`lastname`,' ',`firstname`,' ',`othername`) `client_names`";
		$result_array = $this->getfarray(self::$table_name, $fields, "", "", "");
		return !empty($result_array) ? $result_array : false;
	}
	public function addPap($data){
		$fields =array_slice(self::$db_fields, 1);
		//$data['pap_ref'] = "PAP_".time();
		$data['date_created'] = time();
		if(isset($data['rate_per_acre']) &&  $data['rate_per_acre'] != ""){
			$data['rate_per_acre'] = $this->stripCommasOnNumber($data['rate_per_acre']);
		}
		$data['created_by'] = $data['modified_by'] = isset($_SESSION['staffId'])?$_SESSION['staffId']:1;
		return $this->addSpecial(self::$table_name, $data);
	}
	public function updatePap($data){
		$id = $data['id'];
		unset($data['id'], $data['tbl']);
		if(isset($data['rate_per_acre']) && $data['rate_per_acre'] != ""){
			$data['rate_per_acre'] = $this->stripCommasOnNumber($data['rate_per_acre']);
		}
		if($this->updateSpecial(self::$table_name, $data, "id=".$id)){
			return true;
		}
		return false;
	}
	public function deletePap($id){
		if($this->del(self::$table_name, "id=".$id)){
			return true;
		}
		return false;
	}
	public function turnOffPap($id){
		if($this->turnOff(self::$table_name, "id=".$id)){
			return true;
		}
		return false;
	}
	public function getPapPhotoById($id){
		$result = $this->getrec('tbl_pap_photos', "`id`=" . $id, "", "");
		return !empty($result) ? $result : false;
	}
	public function getPapPhotos($where = ""){
		$result_array = $this->getarray('tbl_pap_photos', $where, "", "");
		return !empty($result_array) ? $result_array : false;
	}
	public function savePapPhotoDetails($data){
		$data['date_created'] = time();
		$data['created_by'] = $data['modified_by'] = isset($_SESSION['staffId'])?$_SESSION['staffId']:1;
		return $this->addSpecial('tbl_pap_photos', $data);
	}
	public function updatePapPhotoDetails($data){
		$id = $data['id'];
		unset($data['id'], $data['tbl']);
		return $this->updateSpecial('tbl_pap_photos', $data, "id=".$id);
	}
	public function addLandValuation($data){
		$id = $data['id'];
		unset($data['id'], $data['tbl']);
		$data['rate_per_acre'] = $this->cleanData($data['rate_per_acre']);
		return $this->updateSpecial(self::$table_name, $data, "id=".$id);
	}
	public function deletePapPhoto($id){
		if($this->del('tbl_pap_photos', "id=".$id)){
			return true;
		}
		return false;
	}
}
?>