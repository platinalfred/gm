<?php
$curdir = dirname(__FILE__);
require_once($curdir.'/Db.php');
class PAP_Improvement extends Db {
	protected static $table_name  = "tbl_pap_improvement";
	protected static $db_fields = array("id", "district_property_rate_id", "quantity", "rate", "pap_id", "date_created", "created_by","modified_by");
	
	public function findById($id){
		$result = $this->getrec(self::$table_name, "id=".$id, "", "");
		return !empty($result) ? $result:false;
	}
	public function findAll($where = ""){
		$result_array = $this->getarray(self::$table_name, $where, "", "");
		return !empty($result_array) ? $result_array : false;
	}
	public function findByImprovements($where = ""){
		//tt = tbl_property_type
		// cd tbl_property_description
		//pt = tbl_pap_improvement
                //tcd = tbl_property_types_description
		//"tbl_pap_improvement.pap_id=".$id
		$fields = "CONCAT(`tbl_property_type`.`title`,`tbl_property_description`.`title`) as improvement_description, `tbl_pap_improvement`.`quantity`, `tbl_pap_improvement`.`rate`, `pap_id`";
		$table_name = "tbl_pap_improvement JOIN tbl_district_property_rate ON tbl_pap_improvement.district_property_rate_id = tbl_district_property_rate.id JOIN tbl_property_types_description ON tbl_district_property_rate.propertytypedescription_id = tbl_property_types_description.id JOIN tbl_property_description ON tbl_property_types_description.property_description_id = tbl_property_description.id JOIN tbl_property_type ON tbl_property_types_description.property_type_id = tbl_property_type.id";
		$result_array = $this->getfarray($table_name, $fields, $where, "", "");
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
			return $this->addMultiple(self::$table_name, $fields, $data);
		}
		return false;
	}
	public function addPapImprovement($data){
		$fields =array_slice(self::$db_fields, 1);
		$data['pap_ref'] = "PAP_".time();
		$data['date_created'] = time();
		$data['created_by'] = $data['modified_by'] = isset($_SESSION['staffId'])?$_SESSION['staffId']:1;
		return $this->add(self::$table_name, $fields, $this->generateAddFields($fields, $data));
	}
	public function updatePapImprovements($data){
		if(!empty($data)){
			$fields = array_slice(self::$db_fields, 1);
			if($this->updateMultiple(self::$table_name, $data, "id")){
				return true;
			}
		}
		return false;
	}
	public function updatePapImprovement($data){
		$fields = array_slice(self::$db_fields, 1);
		$id = $data['id'];
		unset($data['id'], $data['tbl']);
		if($this->updateSpecial(self::$table_name, $data, "id=".$id)){
			return true;
		}
		return false;
	}
	public function deletePapImprovement($id){
		if($this->del(self::$table_name, (is_numeric($id)?("id=".$id):$id))){
			return true;
		}
		return false;
	}
}
?>