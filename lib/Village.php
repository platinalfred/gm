<?php
$curdir = dirname(__FILE__);
require_once($curdir.'/Db.php');
class Village extends Db {
	protected static $table_name  = "tbl_village";
	protected static $db_fields = array("id", "village_name", "parish");
	
	public function findById($id){
		$result = $this->getrec(self::$table_name, "id=".$id, "", "");
		return !empty($result) ? $result:false;
	}
	
	public function findAll(){
		$result_array = $this->getarray(self::$table_name, "", "", "");
		return !empty($result_array) ? $result_array : false;
	}
	public function findVillages(){
		$table = self::$table_name . " v JOIN tbl_parish p ON v.parish = p.id  JOIN tbl_subcounty s ON p.subcounty = s.id JOIN tbl_county c ON s.county = c.id JOIN tbl_district d ON c.district = d.id";
		$fields = "`v`.`id`,`v`.`village_name`,`p`.`parish_name`,`s`.`subcounty_name`,`c`.`county_name`,`d`.`district_name`";
		$result = $this->getfarray($table, $fields, "v.active=1", "district_name", "");
		return !empty($result) ? $result : false;
	}
	public function findVillageName($id){
		$result = $this->getfrec(self::$table_name, "parish_name", "id=".$id, "", "");
		return !empty($result) ? $result['parish_name'] : false;
	}
	public function addVillage($data){
		$fields =array_slice(self::$db_fields, 1);
		if($this->add(self::$table_name, $fields, $this->generateAddFields($fields, $data))){
			return true;
		}
		return false;
	}
	public function updateVillage($data){
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