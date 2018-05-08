<?php

$curdir = dirname(__FILE__);
require_once($curdir . '/Db.php');

class landAcquisitionCategory extends Db {

    protected static $table_name = "land_access_project_category";
    protected static $db_fields = array("id", "title", "description", "date_added", "active");

    public function findById($id) {
        $result = $this->getrec(self::$table_name, "id=" . $id, "");
        return !empty($result) ? $result : false;
    }

    public function findAll() {
        $result_array = $this->getarray(self::$table_name, "active=1", "", "");
        return !empty($result_array) ? $result_array : false;
    }

    public function findLandAcquisitionCategory($id) {
        $result = $this->getfrec("land_access_project_category", "name", "id=" . $id, "", "");
        return !empty($result) ? $result['name'] : false;
    }

    public function addLandAcquisitionCategory($data) {
        $fields = array_slice(self::$db_fields, 1);
        $data['date_added'] = date("Y-m-d H:i:s");
        if ($this->add(self::$table_name, $fields, $this->generateAddFields($fields, $data))) {
            return true;
        }
        return false;
    }

    public function updateLandAccessCategory($data) {
        $id = $data['id'];
        unset($data['id']);
        if (is_numeric($this->update(self::$table_name, array("title", "description"), array("title" => $data['title'], "description" => $data['description']), "id=" . $id))) {
            return true;
        }
        return false;
    }

}