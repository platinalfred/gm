<?php
$curdir = dirname(__FILE__);
require_once($curdir.'/Db.php');
class DistrictPropertyRate extends Db {
	protected static $table_name  = "tbl_district_property_rate";
	protected static $db_fields = array("id", "district_id",  "propertytypedescription_id", "rate");
	
	public function findById($id){
		$result = $this->getrec(self::$table_name, "id=".$id, "", "");
		return !empty($result) ? $result:false;
	}
	public function copyDistrictImprovementRates($copy_from, $copy_to){
		$results  = $result_array = $this->getarray(self::$table_name, "district_id=".$copy_from, "", "");
		if($results){
			$d = 0;
			foreach($results as $single){
				if(!$this->doesRateExist($copy_to, $single['propertytypedescription_id'])){
					$d++;
					$this->add(self::$table_name, array("district_id",  "propertytypedescription_id", "rate"), array("district_id"=>$copy_to,  "propertytypedescription_id"=>$single['propertytypedescription_id'], "rate"=>$single['rate']));
					if($d == count($results)){
						return true;
					}
				}
			}
			
		}
		return false;
	}
	public function doesRateExist($district_id, $propertytypedescription_id){
		if($this->countRecords(self::$table_name, "district_id=".$district_id. " AND croptree_id = ".$propertytypedescription_id) > 0){
			return true;
		}
		return false;
	}
	public function findDistrictPropertyRates(){
		/*dpr = tbl_district_property_rate
		ptd = tbl_property_types_description
		pd = tbl_property_description
		pt = tbl_property_type
		d = tbl_district
		*/
		$table = self::$table_name . " dpr JOIN tbl_property_types_description ptd ON dpr.propertytypedescription_id = ptd.id JOIN tbl_property_description pd ON ptd.property_description_id = pd.id JOIN tbl_property_type pt ON ptd.property_type_id = pt.id JOIN tbl_district d ON  dpr.district_id = d.id";
		$fields = "`dpr`.`id`, dpr.rate, d.district_name, district_id, pt.`title` as propertytype, pd.`title` as propertydescription";
		$result = $this->getfarray($table, $fields, "", "district_name", "");
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
	public function addDistrictPropertyRate($data){
		$fields =array_slice(self::$db_fields, 1);
		$data['rate'] = $this->stripCommasOnNumber($data['rate']);
		if(!$this->doesRateExist($data['district_id'], $data['croptree_id'])){
			if($this->add(self::$table_name, $fields, $this->generateAddFields($fields, $data))){
				return true;
			}
		}
		return false;
	}
	public function updateDistrictPropertyRate($data){
		$fields = array_slice(self::$db_fields, 1);
		$id = $data['id'];
		unset($data['id']);
		$data['rate'] = $this->stripCommasOnNumber($data['rate']);
		if($this->update(self::$table_name, $fields, $this->generateAddFields($fields, $data), "id=".$id)){
			return true;
		}
		return false;
	}
}
?>