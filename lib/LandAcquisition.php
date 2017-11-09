<?php
$curdir = dirname(__FILE__);
require_once($curdir.'/Db.php');
class LandAcquisition extends Db {
	protected static $table_name  = "land_access_project";
	protected static $db_fields = array("id","date_added","client_name", "title", "project_category", "project_category_unit", "project_reference", "date_added", "modified_by", "active");
	
	public function findById($id){
		$result = $this->getrec(self::$table_name, "id=".$id, "");
		return !empty($result) ? $result:false;
	}
	public function findAllAccess(){
		$result_array = $this->queryData("SELECT a.title, a.client_name,a.project_reference, a.date_added,  b.title as project_category, c.title as project_category_unit  FROM land_access_project a, land_access_project_category_unit c, land_access_project_category b WHERE a.project_category = b.id AND a.project_category_unit = c.id");
		return !empty($result_array) ? $result_array : false;
	}
	public function findAll(){
		$result_array = $this->getarray(self::$table_name, "active=1", "", "");
		return !empty($result_array) ? $result_array : false;
	}
	
	public function findProjectName($id){
		$result = $this->getfrec(self::$table_name, "title", "id=".$id, "", "");
		return !empty($result) ? $result['title'] : false;
	}
	public function addProject($data){
		$fields =array_slice(self::$db_fields, 1);
		$data['date_added'] = date("Y-m-d");
		if($this->add(self::$table_name, $fields, $this->generateAddFields($fields, $data))){
			return true;
		}
		return false;
	}
	public function updatePosition($data){
		$fields = array_slice(self::$db_fields, 1);
		$id = $data['id'];
		unset($data['id']);
		if($this->update(self::$table_name, $fields, $this->generateAddFields($fields, $data), "id=".$id)){
			return true;
		}
		return false;
	}
}
?>