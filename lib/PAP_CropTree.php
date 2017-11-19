<?php
$curdir = dirname(__FILE__);
require_once($curdir.'/Db.php');
class PAP_CropTree extends Db {
	protected static $table_name  = "tbl_pap_crop_tree";
	protected static $db_fields = array("id", "crop_description_rate_id", "quantity", "rate", "pap_id", "date_created", "created_by","modified_by");
	
	public function findById($id){
		$result = $this->getrec(self::$table_name, "id=".$id, "", "");
		return !empty($result) ? $result:false;
	}
	public function findAll($where = 1){
		$result_array = $this->getarray(self::$table_name, $where, "", "");
		return !empty($result_array) ? $result_array : false;
	}
	public function findPapCropTrees($where = 1){
		$fields = "`tbl_pap_crop_tree`.`id`, `pap_id`, `quantity`, `tbl_pap_crop_tree`.`rate` `old_rate`, `tbl_dr`.`rate`, `crop_description_rate_id`, croptype, cropdescription";
		$table_name = self::$table_name . " JOIN (SELECT `dr`.`id`, dr.rate, d.district_name, tct.`title` as croptype, cd.`title` as cropdescription FROM tbl_district_croptree_rate dr JOIN tree_crop_types_description ctd ON dr.croptree_id = ctd.id JOIN tbl_crop_description cd ON ctd.crop_description_id = cd.id JOIN tbl_tree_or_crop_types tct ON ctd.tree_crop_id = tct.id JOIN tbl_district d ON  dr.district_id = d.id) `tbl_dr` ON `crop_description_rate_id` = `tbl_dr`.`id`";
		$result_array = $this->getfarray($table_name, $fields, $where, "", "");
		return !empty($result_array) ? $result_array : false;
	}
	public function addPapCropTrees($data){
		if(!empty($data)){
			$fields =array_slice(self::$db_fields, 1);
			if($this->addMultiple(self::$table_name, $fields, $data)){
				return true;
			}
		}
		return false;
	}
	public function addPapCropTree($data){
		$fields =array_slice(self::$db_fields, 1);
		$data['pap_ref'] = "PAP_".time();
		$data['date_created'] = time();
		$data['created_by'] = $data['modified_by'] = isset($_SESSION['staffId'])?$_SESSION['staffId']:1;
		return $this->add(self::$table_name, $fields, $this->generateAddFields($fields, $data));
	}
	public function updatePapCropTrees($data){
		if(!empty($data)){
			$fields = array_slice(self::$db_fields, 1);
			return $this->updateMultiple(self::$table_name, $data, "id");
		}
		return false;
	}
	public function updatePapCropTree($data){
		$fields = array_slice(self::$db_fields, 1);
		$id = $data['id'];
		unset($data['id'], $data['tbl']);
		if($this->updateSpecial(self::$table_name, $data, "id=".$id)){
			return true;
		}
		return false;
	}
	public function deletePapCropTree($id){
		if($this->del(self::$table_name, "id=".$id)){
			return true;
		}
		return false;
	}
}
?>