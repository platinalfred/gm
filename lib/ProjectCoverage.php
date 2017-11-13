<?php
$curdir = dirname(__FILE__);
require_once($curdir.'/Db.php');
class ProjectCoverage extends Db {
	protected static $table_name  = "tbl_project_coverage";
	protected static $db_fields = array("id","project_id", "district_id", "created_by","date_created","modified_by");
	
	public function findById($id){
		$result = $this->getrec(self::$table_name, "id=".$id, "", "");
		return !empty($result) ? $result:false;
	}
	public function findAll($where = ""){
		$result_array = $this->getarray(self::$table_name, "", "", "");
		return !empty($result_array) ? $result_array : false;
	}
	public function findAvailableDistricts($project_id){
		$where = "`id` NOT IN (SELECT `district_id` FROM tbl_project_coverage` WHERE `project_id`=$project_id)";
		$result_array = $this->getarray("tbl_district", $where, "", "");
		return !empty($result_array) ? $result_array : false;
	}
	public function addProjectCoverage($data){
		$fields =array_slice(self::$db_fields, 1);
		$data['date_created'] = time();
		$data['created_by'] = isset($_SESSION['staffId'])?$_SESSION['staffId']:1;
		$data['modified_by'] = isset($_SESSION['staffId'])?$_SESSION['staffId']:1;
		if($this->add(self::$table_name, $fields, $this->generateAddFields($fields, $data))){
			return true;
		}
		return false;
	}
	public function updateProjectCoverage($data){
		$fields = array_slice(self::$db_fields, 1);
		$id = $data['id'];
		unset($data['id'], $data['tbl']);
		if($this->updateSpecial(self::$table_name, $data, "id=".$id)){
			return true;
		}
		return false;
	}
	public function deleteProjectCoverage($id){
		if($this->del(self::$table_name, "id=".$id)){
			return true;
		}
		return false;
	}
}
?>