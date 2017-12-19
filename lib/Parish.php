<?php
$curdir = dirname(__FILE__);
require_once($curdir.'/Db.php');
class Parish extends Db {
	protected static $table_name  = "tbl_parish";
	protected static $db_fields = array("id", "parish_name", "subcounty");
	
	public function findById($id){
		$result = $this->getrec(self::$table_name, "id=".$id, "", "");
		return !empty($result) ? $result:false;
	}
	
	public function findAll(){
		$result_array = $this->getarray(self::$table_name, "", "", "");
		return !empty($result_array) ? $result_array : false;
	}
	
	public function findSubParishName($id){
		$result = $this->getfrec(self::$table_name, "parish_name", "id=".$id, "", "");
		return !empty($result) ? $result['parish_name'] : false;
	}
	public function doesParishExist($data){
		if($this->countRecords(self::$table_name, "parish_name='".$data['parish_name']."'") > 0){
			return true;
		}
		return false;
	}
	public function findParishes(){
		$table = self::$table_name . " p JOIN tbl_subcounty s ON p.subcounty = s.id JOIN tbl_district d ON s.district = d.id";
		$fields = "`p`.`id`,`p`.`parish_name`,`s`.`subcounty_name`,`d`.`district_name`";
		$result = $this->getfarray($table, $fields, "p.active=1", "district_name", "");
		return !empty($result) ? $result : false;
	}
	public function addParish($data){
		$fields =array_slice(self::$db_fields, 1);
		if($this->add(self::$table_name, $fields, $this->generateAddFields($fields, $data))){
			return true;
		}
		return false;
	}
	public function updateParish($data){
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