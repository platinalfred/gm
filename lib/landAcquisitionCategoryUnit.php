<?php
$curdir = dirname(__FILE__);
require_once($curdir.'/Db.php');
class landAcquisitionCategoryUnit extends Db {
	protected static $table_name  = "land_access_project_category_unit";
	protected static $db_fields = array("id", "title", "category", "description", "active", "date_added");
	
	public function findById($id){
		$result = $this->getrec(self::$table_name, "id=".$id, "");
		return !empty($result) ? $result:false;
	}
	
	public function findAll(){
		$result_array = $this->getarray(self::$table_name, "active=1", "", "");
		return !empty($result_array) ? $result_array : false;
	}
	public function findUnits(){
		$result_array = $this->queryData("SELECT a.id, a.title, a.description,  b.title as category  FROM land_access_project_category_unit a, land_access_project_category b WHERE a.category = b.id");
		return !empty($result_array) ? $result_array : false;
	}
	public function findLandAcquisitionCategoryUnit($id){
		$result = $this->getfrec(self::$table_name, "name", "id=".$id, "", "");
		return !empty($result) ? $result['name'] : false;
	}
	public function findLandAcquisitionCategory($cid){
		$result = $this->getfrec("", "title", "cid=".$id, "", "");
		return !empty($result) ? $result['title'] : false;
	}
	public function addLandAcquisitionCategoryUnit($data){
		$fields = array_slice(self::$db_fields, 1);
		if($this->add(self::$table_name, $fields, $this->generateAddFields($fields, $data))){
			return true;
		}
		return false;
	}
	public function updateLandAccessCategoryUnit($data){
		$fields = array_slice(self::$db_fields, 1);
		$id = $data['id'];
		unset($data['id']);
		if($this->update(self::$table_name, $fields, $this->generateAddFields($fields, $data), "id=".$id)){
			return true;
		}
		return false;
	}
	public function deleteLandAcquisitionCategoryUnit($id){
		if($this->del(self::$table_name, "id=".$id)){
			return true;
			unset($id);
		}
		return false;
	}
}
?>