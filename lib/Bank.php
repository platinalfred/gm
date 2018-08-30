<?php

$curdir = dirname(__FILE__);
require_once($curdir . '/Db.php');

class Bank extends Db {

    protected static $table_name = "tbl_bank";
    protected static $db_fields = array("id", "bank_name","bank_code");

    public function findById($id) {
        $result = $this->getrec(self::$table_name, "id=" . $id, "", "");
        return !empty($result) ? $result : false;
    }

    public function findAll() {
        $result_array = $this->getarray(self::$table_name, "", "", "");
        return !empty($result_array) ? $result_array : false;
    }

    public function findBankName($id) {
        $result = $this->getfrec(self::$table_name, "bank_name", "id=" . $id, "", "");
        return !empty($result) ? $result['bank_name'] : false;
    }

    public function addBank($data) {
        unset($data['id']);
        $data['date_created'] = time();
        $data['created_by'] = $data['modified_by'] = isset($_SESSION['staffId']) ? $_SESSION['staffId'] : 1;
        if ($this->addSpecial(self::$table_name, $data)) {
            echo mysqli_error($this->conn);
            return true;
        }
        return false;
    }

    public function updateBank($data) {
        $fields = array_slice(self::$db_fields, 1);
        $id = $data['id'];
        unset($data['id']);
        if (is_numeric($this->update(self::$table_name, $fields, $this->generateAddFields($fields, $data), "id=" . $id))) {
            return true;
        }
        return false;
    }

}