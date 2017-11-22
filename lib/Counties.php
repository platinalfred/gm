<?php
$curdir = dirname(__FILE__);
require_once($curdir.'/Db.php');
class Counties extends Db {
	protected static $table_name  = "tbl_county";
	protected static $db_fields = array("id", "county_name", "district");
	
	public function findById($id){
		$result = $this->getrec(self::$table_name, "id=".$id, "", "");
		return !empty($result) ? $result:false;
	}
	public function findCounties(){
		$table = self::$table_name . " c JOIN tbl_district d ON c.district = d.id";
		$fields = "`c`.`id`,`c`.`county_name`,`d`.`district_name`";
		$result = $this->getfarray($table, $fields, "c.active=1", "district_name", "");
		return !empty($result) ? $result : false;
	}
	public function findAll(){
		$result_array = $this->getarray(self::$table_name, "", "", "");
		return !empty($result_array) ? $result_array : false;
	}
	public function findByDistrict($id){
		$result_array = $this->getarray(self::$table_name, "district=".$id, "", "");
		return !empty($result_array) ? $result_array : false;
	}
	
	
	public function findCountyName($id){
		$result = $this->getfrec(self::$table_name, "county_name", "id=".$id, "", "");
		return !empty($result) ? $result['county_name'] : false;
	}
	public function addCounty($data){
		$fields =array_slice(self::$db_fields, 1);
		if($this->add(self::$table_name, $fields, $this->generateAddFields($fields, $data))){
			return true;
		}
		return false;
	}
	public function updateCounty($data){
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