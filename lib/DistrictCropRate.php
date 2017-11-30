<?php
$curdir = dirname(__FILE__);
require_once($curdir.'/Db.php');
class DistrictCropRate extends Db {
	protected static $table_name  = "tbl_district_croptree_rate";
	protected static $db_fields = array("id", "district_id",  "croptree_id", "rate");
	
	public function findById($id){
		$result = $this->getrec(self::$table_name, "id=".$id, "", "");
		return !empty($result) ? $result:false;
	}
	
	public function findDistrictCropRates($where = ""){
		/*dr = tbl_district_croptree_rate
		ctd = tree_crop_types_description
		cd = tbl_crop_description
		tct = tbl_tree_or_crop_types
		d = tbl_district
		*/
		$table = self::$table_name . " dr JOIN tree_crop_types_description ctd ON dr.croptree_id = ctd.id JOIN tbl_crop_description cd ON ctd.crop_description_id = cd.id JOIN tbl_tree_or_crop_types tct ON ctd.tree_crop_id = tct.id JOIN tbl_district d ON  dr.district_id = d.id";
		$fields = "`dr`.`id`, dr.rate, d.district_name, tct.`title` as croptype, cd.`title` as cropdescription";
		$result = $this->getfarray($table, $fields, $where, "district_name", "");
		return !empty($result) ? $result : false;
	}
	public function findAll(){
		$result_array = $this->getarray(self::$table_name, "", "", "");
		return !empty($result_array) ? $result_array : false;
	}
	/* 
	public function findTreeName($id){
		$result = $this->getfrec(self::$table_name, "title", "id=".$id, "", "");
		return !empty($result) ? $result['title'] : false;
	} */
	public function addDistrictCropRate($data){
		$fields =array_slice(self::$db_fields, 1);
		if($this->add(self::$table_name, $fields, $this->generateAddFields($fields, $data))){
			return true;
		}
		return false;
	}
	public function updateDistrictCropRate($data){
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