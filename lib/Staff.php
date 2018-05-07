<?php
$curdir = dirname(__FILE__);
require_once($curdir.'/Db.php');
class Staff extends Db {
	protected static $table_name  = "staff";
	protected static $db_fields = array("id","firstname","lastname","othername","position","username","password", "email","phone_contact","phone_contact2","address","staff_type", "date_added", "added_by");
	
	public function findById($id){
		$result = $this->getrec(self::$table_name, "id=".$id, "");
		return !empty($result) ? $result:false;
	}
	public function findByPersonId($pno){
		$result = $this->getfrec(self::$table_name, "personId=".$pno, "");
		return !empty($result) ? $result:false;
	}
	
	public function doesMailExist($email){
		if($this->countRecords(self::$table_name, "email='".$email."'") > 0){
			echo "false";
		}else{
			echo "true";
		}
		
	}
	public function findAll(){
		$result_array = $this->getarray(self::$table_name, "", "id DESC","");
		return !empty($result_array) ? $result_array : false;
	}
	
	public function findStaffDetails(){
		$table = self::$table_name . " s JOIN  position p ON s.position = p.id ";
		$fields = "s.id, s.firstname, s.lastname, s.othername,s.position,s.username,s.password,s.email,s.phone_contact,s.phone_contact2,s.address,s.staff_type,s.date_added, s.added_by, p.title";
		$result = $this->getfarray($table, $fields, "s.active=1", "s.id DESC", "");
		return !empty($result) ? $result : false;
	}
	public function findNamesByPersonNumber($pno){
		$result = $this->getrec(self::$table_name, "first_name, p.last_name, p.other_names", "st.personId='$pno' AND p.id = st.personId", "", "");
		return !empty($result) ? $result['first_name']." ".$result['other_names']." ".$result['last_name'] : false;
	}
	public function findNamesById($id){
		$result = $this->getfrec(self::$table_name." st, person p", "p.first_name, p.last_name, p.other_names", "st.id=".$id." AND p.id = st.personId", "", "");
		return !empty($result) ? $result['first_name']." ".$result['other_names']." ".$result['last_name'] : false;
	}
	public function addStaffAccessLevels($data){
		$fields = array("role_id", "personId");
		if($this->add("staff_roles", $fields, $this->generateAddFields($fields, $data))){
			return true;
		}
		return false;
	}
	public function updateStaffAccessLevels($data){
		$this->del('staff_roles', 'personId='.$data['personId']);
		$fields = array("role_id", "personId");
		if($this->add("staff_roles", $fields, $this->generateAddFields($fields, $data))){
			return true;
		}
		return false;
	}
	public function addStaff($data){
		$fields = array_slice(self::$db_fields, 1);
		$data['password2'] = password_hash($data['password'], PASSWORD_DEFAULT, ['cost' => 12]);
		$data['date_added'] = time();
		if($this->add(self::$table_name, $fields, $this->generateAddFields($fields, $data))){
			return true;
		}
		return false;
	}
	public function updateStaff($data){
		$fields = array_slice(self::$db_fields, 1);
		$id = $data['id'];
		unset($data['id']);
		$data['password2'] = password_hash($data['password'], PASSWORD_DEFAULT, ['cost' => 12]);
		if($this->update(self::$table_name, $fields, $this->generateAddFields($fields, $data), "id=".$id)){
			return true;
		}
		return false;
                //ALTER TABLE `staff` ADD `password2` VARCHAR(255) NULL DEFAULT NULL AFTER `password`;
                //ALTER TABLE `staff` CHANGE `password` `password` TEXT CHARACTER SET latin1 COLLATE latin1_swedish_ci NULL DEFAULT NULL;
                //ALTER TABLE `users` CHANGE `password` `password` VARCHAR(100) NULL DEFAULT NULL;
	}
	public function updatePassword($data){
		$id = $data['id'];
		unset($data['id']);
		if($this->update(self::$table_name, ["password2"], ["password2"=>password_hash($data['password'], PASSWORD_DEFAULT, ['cost' => 12])], "id=".$id)){
			return true;
		}
		return false;
	}
	public function deleteStaff($id){
		if($this->update(self::$table_name, array("status"), array("status"=>0), "id=".$id)){
			return true;
		}
		return false;
	}
	public function activateStaff($id){
		if($this->update(self::$table_name, array("status"), array("status"=>1), "id=".$id)){
			return true;
		}
		return false;
	}
	
}
?>