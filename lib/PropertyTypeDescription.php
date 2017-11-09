<?php
$curdir = dirname(__FILE__);
require_once($curdir.'/Db.php');
class PropertyTypeDescription extends Db {
	protected static $table_name  = "tbl_property__types_description";
	protected static $db_fields = array("id", "property_type_id",  "property_description_id");
	
	public function findByTreeCropId($id){
		$result = $this->getarray(self::$table_name, "property_type_id=".$id, "", "");
		return !empty($result) ? $result:false;
	}
	public function findByCropDescriptionId($id){
		$result = $this->getarray(self::$table_name, "property_description_id=".$id, "", "");
		return !empty($result) ? $result:false;
	}
	
	public function findAll(){
		$result_array = $this->getarray(self::$table_name, "", "", "");
		return !empty($result_array) ? $result_array : false;
	}
	
	public function findTreeName($id){
		$result = $this->getfrec(self::$table_name, "title", "id=".$id, "", "");
		return !empty($result) ? $result['title'] : false;
	}
	public function addTreeCropTypesDescription($data){
		$fields =array_slice(self::$db_fields, 1);
		if($this->add(self::$table_name, $fields, $this->generateAddFields($fields, $data))){
			return true;
		}
		return false;
	}
	public function updateTreeCropTypesDescription($data){
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