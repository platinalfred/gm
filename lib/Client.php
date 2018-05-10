<?php

$curdir = dirname(__FILE__);
require_once($curdir . '/Db.php');

class Client extends Db {

    protected static $table_name = "tbl_client";
    protected static $db_fields = array("id", "client_names", "physical_address", "postal_address", "phone_contact1", "phone_contact2", "email_contact1", "email_contact2", "website", "created_by", "date_created", "modified_by");

    public function findById($id) {
        $result = $this->getrec(self::$table_name, "id=" . $id, "", "");
        return !empty($result) ? $result : false;
    }

    public function findAll() {
        /* $table = self::$table_name. " JOIN `staff` ON `tbl_client`.`created_by` = `staff`.`id`";
          $fields = "`member`.`id`, CONCAT(`lastname`,' ',`firstname`,' ',`othername`) `clientNames`, 1 `clientType`";
          $result_array = $this->getfarray($table, $fields, $where, "", ""); */
        $result_array = $this->getarray(self::$table_name, "", "", "");
        return !empty($result_array) ? $result_array : false;
    }

    public function getSelectList() {
        $fields = "`id`, `client_names`";
        $result_array = $this->getfarray(self::$table_name, $fields, "", "", "");
        return !empty($result_array) ? $result_array : false;
    }

    public function addClient($data) {
        $fields = array_slice(self::$db_fields, 1);
        $data['date_created'] = time();
        $data['modified_by'] = isset($_SESSION['staffId']) ? $_SESSION['staffId'] : 1;
        if ($this->add(self::$table_name, $fields, $this->generateAddFields($fields, $data))) {
            return true;
        }
        return false;
    }

    public function updateClient($data) {
        $fields = array_slice(self::$db_fields, 1);
        $id = $data['id'];
        unset($data['id'], $data['tbl']);
        if (is_numeric($this->updateSpecial(self::$table_name, $data, "id=" . $id))) {
            return true;
        }
        return false;
    }

    public function deleteClient($id) {
        if ($this->del(self::$table_name, "id=" . $id)) {
            return true;
        }
        return false;
    }

}

?>