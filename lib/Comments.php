<?php

$curdir = dirname(__FILE__);
require_once($curdir . '/Db.php');

class Comments extends Db {

    protected static $table_name = "tbl_comment";
    protected static $db_fields = array("id", "details");

    public function findById($id) {
        $result = $this->getrec(self::$table_name, "id=" . $id, "", "");
        return !empty($result) ? $result : false;
    }

    public function findAll() {
        $result_array = $this->getarray(self::$table_name, "", "", "");
        return !empty($result_array) ? $result_array : false;
    }

    public function findComment($id) {
        $result = $this->getfrec(self::$table_name, "details", "id=" . $id, "", "");
        return !empty($result) ? $result['details'] : false;
    }

    public function addComment($data) {
        $fields = array_slice(self::$db_fields, 1);
        if ($this->add(self::$table_name, $fields, $this->generateAddFields($fields, $data))) {
            return true;
        }
        return false;
    }

    public function doesCommentExist($data) {
        if ($this->countRecords(self::$table_name, "details='" . $data['details'] . "'") > 0) {
            return true;
        }
        return false;
    }

    public function updateComment($data) {
        $fields = array_slice(self::$db_fields, 1);
        $id = $data['id'];
        unset($data['id']);
        if (is_numeric($this->update(self::$table_name, $fields, $this->generateAddFields($fields, $data), "id=" . $id))) {
            return true;
        }
        return false;
    }

}

?>