<?php
$curdir = dirname(__FILE__);
require_once($curdir.'/Db.php');
class ProjectAffectedPerson extends Db {
	protected static $table_name  = "tbl_paps";
	protected static $db_fields = array("id","project_id", "pap_ref", "firstname", "othername", "lastname", "phone_contact", "district_id", "county_id", "subcounty_id", "parish_id", "village", "way_leave", "rightofway", "total_take", "chainage", "created_by","date_created","modified_by");
	
	public function findById($id){
		$result = $this->getrec(self::$table_name, "id=".$id, "", "");
		return !empty($result) ? $result:false;
	}
	public function findAll($where = 1){
		$improvements = "(SELECT `pap_id`, COUNT(`id`) `improvement_cnt`,SUM(`rate`*`quantity`) `improvement_sum` FROM `tbl_pap_improvement` GROUP BY `pap_id`) `improvements`";
		$crop_trees = "(SELECT `pap_id`, COUNT(`id`) `crop_tree_cnt`,SUM(`rate`*`quantity`) `crop_tree_sum` FROM `tbl_pap_crop_tree` GROUP BY `pap_id`) `crop_trees`";
		$tables = "tbl_paps JOIN `tbl_district` ON `district_id` = `tbl_district`.`id` LEFT JOIN $improvements ON `tbl_paps`.`id` = `improvements`.`pap_id` LEFT JOIN $crop_trees ON `tbl_paps`.`id` = `crop_trees`.`pap_id`";
		
		// LEFT JOIN `tbl_county` ON `county_id` = `tbl_county`.`id` LEFT JOIN `tbl_subcounty` ON `subcounty_id` = `tbl_subcounty`.`id` LEFT JOIN `tbl_parish` ON `parish_id` = `tbl_parish`.`id`
		
		$fields = "`tbl_paps`.`id`, `project_id`, `pap_ref`, `firstname`, `othername`, `lastname`, `phone_contact`, `district_id`, `district_name`, `county_id`, `subcounty_id`, `parish_id`, `village`, `way_leave`, `rightofway`, `total_take`, `chainage`, `crop_tree_cnt`, `crop_tree_sum`, `improvement_cnt`, `improvement_sum`";
		
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
		$data['pap_ref'] = "PAP_".time();
		$data['project_id'] = 1;
		$data['county_id'] = 17;
		$data['subcounty_id'] = 451;
		$data['parish_id'] = 321;
		$data['date_created'] = time();
		$data['created_by'] = $data['modified_by'] = isset($_SESSION['staffId'])?$_SESSION['staffId']:1;
		return $this->add(self::$table_name, $fields, $this->generateAddFields($fields, $data));
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