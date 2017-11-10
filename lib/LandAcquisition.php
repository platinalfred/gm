<?php
$curdir = dirname(__FILE__);
require_once($curdir.'/Db.php');
class LandAcquisition extends Db {
	protected static $table_name  = "land_access_project";
	protected static $db_fields = array("id","client_id", "project_title", "project_category_unit", "project_reference", "date_added", "modified_by", "active");
	
	public function findById($id){
		$result = $this->getrec(self::$table_name, "id=".$id, "");
		return !empty($result) ? $result:false;
	}
	public function findAllAccess(){
		//$result_array = $this->queryData("SELECT a.title, a.client_names,a.project_reference, a.date_added,  b.title as project_category, c.title as project_category_unit  FROM land_access_project a, land_access_project_category_unit c, land_access_project_category b WHERE a.project_category = b.id AND a.project_category_unit = c.id");
		
		$table = self::$table_name. " JOIN `land_access_project_category_unit` ON `land_access_project_category_unit`.`id` = `project_category_unit` JOIN `tbl_client` ON `tbl_client`.`id` = `client_id`";
		// JOIN `staff` ON `land_access_project`.`created_by` = `staff`.`id`
		
		$fields = "`land_access_project`.`id`, `project_title`, `client_id`, `client_names`, `project_title`, `project_reference`, `land_access_project`.`date_added`, `title` as `project_category`, `project_category_unit`";
		
		$result_array = $this->getfarray($table, $fields, "", "", "");
		
		return $result_array;
	}
	public function findAll(){
		$result_array = $this->getarray(self::$table_name, "active=1", "", "");
		return !empty($result_array) ? $result_array : false;
	}
	
	public function findProjectName($id){
		$result = $this->getfrec(self::$table_name, "project_title", "id=".$id, "", "");
		return !empty($result) ? $result['title'] : false;
	}
	public function addProject($data){
		$fields =array_slice(self::$db_fields, 1);
		$data['active'] = 1;
		$data['date_added'] = date("Y-m-d h:i:s");
		$data['modified_by'] = isset($_SESSION['staffId'])?$_SESSION['staffId']:1;
		if($this->add(self::$table_name, $fields, $this->generateAddFields($fields, $data))){
			return true;
		}
		return false;
	}
	public function updateProject($data){
		$fields = array_slice(self::$db_fields, 1);
		$id = $data['id'];
		unset($data['id']);
		if($this->updateSpecial(self::$table_name, $data, "id=".$id)){
			return true;
		}
		return false;
	}
}
?>