<?php
$curdir = dirname(__FILE__);
require_once($curdir.'/Db.php');
class PAP_Improvement extends Db {
	protected static $table_name  = "tbl_pap_improvement";
	protected static $db_fields = array("id", "district_property_rate_id", "unit", "quantity", "rate", "pap_id", "date_created", "created_by","modified_by");
	
	public function findById($id){
		$result = $this->getrec(self::$table_name, "id=".$id, "", "");
		return !empty($result) ? $result:false;
	}
	public function findAll($where = ""){
		$result_array = $this->getarray(self::$table_name, $where, "", "");
		return !empty($result_array) ? $result_array : false;
	}
	public function findPapImprovements($where = ""){
		$fields = "`tbl_pap_improvement`.`id`, `pap_id`, `quantity`, `tbl_pap_improvement`.`rate` `old_rate`, `tbl_dpr`.`rate`, `district_property_rate_id`, propertytype, propertydescription";
		$table_name = self::$table_name . " JOIN (SELECT `dpr`.`id`, dpr.rate, pt.`title` as propertytype, pd.`title` as propertydescription FROM tbl_district_property_rate dpr JOIN tbl_property_types_description ptd ON dpr.propertytypedescription_id = ptd.id JOIN tbl_property_description pd ON ptd.property_description_id = pd.id JOIN tbl_property_type pt ON ptd.property_type_id = pt.id JOIN tbl_district d ON  dpr.district_id = d.id) `tbl_dpr` ON `district_property_rate_id` = `tbl_dpr`.`id`";
		$result_array = $this->getfarray($table_name, $fields, $where, "", "");
		return !empty($result_array) ? $result_array : false;
	}
	public function addPapImprovements($data){
		if(!empty($data)){
			$fields =array_slice(self::$db_fields, 1);
			if($this->addMultiple(self::$table_name, $fields, $data)){
				return true;
			}
		}
		return false;
	}
	public function updatePapImprovements($data){
		$fields = array_slice(self::$db_fields, 1);
		if($this->updateMultiple(self::$table_name, $data, "id")){
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