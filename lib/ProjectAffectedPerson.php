<?php
$curdir = dirname(__FILE__);
require_once($curdir.'/Db.php');
class ProjectAffectedPerson extends Db {
	protected static $table_name  = "tbl_paps";
	protected static $db_fields = array("id","project_id", "pap_ref", "firstname", "othername", "lastname", "phone_contact", "district_id", "subcounty_id", "parish", "village", "way_leave", "rightofway", "total_take", "chainage", "created_by","date_created","modified_by");
	
	public function findById($id){
		$result = $this->getrec(self::$table_name, "id=".$id, "", "");
		return !empty($result) ? $result:false;
	}
	public function findAll($where = 1){
		$improvements = "(SELECT `pap_id`, COUNT(`id`) `improvement_cnt`,SUM(`amount`) `improvement_sum` FROM `tbl_pap_improvement` GROUP BY `pap_id`) `improvements`";
		$crop_trees = "(SELECT `pap_id`, COUNT(`id`) `crop_tree_cnt`,SUM(`amount`) `crop_tree_sum` FROM `tbl_pap_crop_tree` GROUP BY `pap_id`) `crop_trees`";
		$tables = "tbl_paps LEFT JOIN $improvements ON `id` = `improvements`.`pap_id` LEFT JOIN $crop_trees ON `id` = `crop_trees`.`pap_id`";
		
		$fields = "id, project_id, pap_ref, firstname, othername, lastname, phone_contact, district_id, subcounty_id, parish_id, village, way_leave, rightofway, total_take, chainage, crop_tree_cnt, crop_tree_sum, improvement_cnt, improvement_sum";
		
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
		$data['date_created'] = time();
		$data['created_by'] = $data['modified_by'] = isset($_SESSION['staffId'])?$_SESSION['staffId']:1;
		if($this->add(self::$table_name, $fields, $this->generateAddFields($fields, $data))){
			return true;
		}
		return false;
	}
	public function updatePap($data){
		$fields = array_slice(self::$db_fields, 1);
		$id = $data['id'];
		unset($data['id'], $data['tbl']);
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
}
?>