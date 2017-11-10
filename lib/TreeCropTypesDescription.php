<?php
$curdir = dirname(__FILE__);
require_once($curdir.'/Db.php');
class TreeCropTypesDescription extends Db {
	protected static $table_name  = "tree_crop_types_description";
	protected static $db_fields = array("id", "tree_crop_id",  "crop_description_id");
	
	public function findById($id){
		$result = $this->getrec(self::$table_name, "id=".$id, "", "");
		return !empty($result) ? $result:false;
	}
	public function findByTreeCropId($id){
		$result = $this->getarray(self::$table_name, "tree_crop_id=".$id, "", "");
		return !empty($result) ? $result:false;
	}
	public function findByCropDescriptionId($id){
		$result = $this->getarray(self::$table_name, "crop_description_id=".$id, "", "");
		return !empty($result) ? $result:false;
	}
	public function findCropTreeDescription(){
		$table = self::$table_name . " JOIN tbl_tree_or_crop_types ON tree_crop_id = tbl_tree_or_crop_types.id JOIN tbl_crop_description ON crop_description_id = tbl_crop_description.id";
		$fields = "`tree_crop_types_description`.`id`, tbl_tree_or_crop_types.`title` as cropname, tbl_crop_description.`title` as cropdescription";
		$result = $this->getfarray($table, $fields, "", "cropname", "");
		return !empty($result) ? $result : false;
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