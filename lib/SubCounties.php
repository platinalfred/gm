<?php

$curdir = dirname(__FILE__);
require_once($curdir . '/Db.php');

class SubCounties extends Db {

    protected static $table_name = "tbl_subcounty";
    protected static $db_fields = array("id", "subcounty_name", "district");

    public function findById($id) {
        $result = $this->getrec(self::$table_name, "id=" . $id, "", "");
        return !empty($result) ? $result : false;
    }

    public function findSubCounties() {
        $table = self::$table_name . " s JOIN tbl_district d ON s.district = d.id";
        $fields = "`s`.`id`,`s`.`subcounty_name`,`d`.`district_name`, district";
        $result = $this->getfarray($table, $fields, "s.active=1", "district_name", "");
        return !empty($result) ? $result : false;
    }

    public function findAll() {
        $result_array = $this->getarray(self::$table_name, "", "", "");
        return !empty($result_array) ? $result_array : false;
    }

    public function findSubCountyName($id) {
        $result = $this->getfrec(self::$table_name, "subcounty_name", "id=" . $id, "", "");
        return !empty($result) ? $result['subcounty_name'] : false;
    }

    public function addSubCounty($data) {
        $fields = array_slice(self::$db_fields, 1);
        if ($this->add(self::$table_name, $fields, $this->generateAddFields($fields, $data))) {
            return true;
        }
        return false;
    }

    public function doesSubCountyExist($data) {
        if ($this->countRecords(self::$table_name, "subcounty_name='" . $data['subcounty_name'] . "' AND district=" . $data['district'] . " AND active != 0") > 0) {
            return true;
        }
        return false;
    }

    public function updateSubCounty($data) {
        $fields = array_slice(self::$db_fields, 1);
        $id = $data['id'];
        unset($data['id']);
        if (is_numeric($this->update(self::$table_name, $fields, $this->generateAddFields($fields, $data), "id=" . $id))) {
            return true;
        }
        return false;
    }

}
