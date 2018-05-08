<?php

$curdir = dirname(__FILE__);
require_once($curdir . '/Db.php');

class PropertyTypeDescription extends Db {

    protected static $table_name = "tbl_property_types_description";
    protected static $db_fields = array("id", "property_type_id", "property_description_id");

    public function findByPropertyTypeId($id) {
        $result = $this->getarray(self::$table_name, "property_type_id=" . $id, "", "");
        return !empty($result) ? $result : false;
    }

    public function findByCropDescriptionId($id) {
        $result = $this->getarray(self::$table_name, "property_description_id=" . $id, "", "");
        return !empty($result) ? $result : false;
    }

    public function findPropertyTypeDescription($where = "") {
        $table = self::$table_name . " JOIN tbl_property_type ON property_type_id = tbl_property_type.id JOIN tbl_property_description ON property_description_id = tbl_property_description.id";
        $fields = "`tbl_property_types_description`.`id`, tbl_property_type.`id` as property_id, tbl_property_type.`title` as improvementtypename, tbl_property_description.`title` as propertydescription";
        $result = $this->getfarray($table, $fields, $where, "improvementtypename", "");
        return !empty($result) ? $result : false;
    }

    public function findAll() {
        $result_array = $this->getarray(self::$table_name, "", "", "");
        return !empty($result_array) ? $result_array : false;
    }

    public function findTreeName($id) {
        $result = $this->getfrec(self::$table_name, "title", "id=" . $id, "", "");
        return !empty($result) ? $result['title'] : false;
    }

    public function addPropertyTypeDescription($data) {
        $fields = array_slice(self::$db_fields, 1);
        if ($this->add(self::$table_name, $fields, $this->generateAddFields($fields, $data))) {
            return true;
        }
        return false;
    }

    public function updatePropertyTypeDescription($data) {
        $fields = array_slice(self::$db_fields, 1);
        $id = $data['id'];
        unset($data['id']);
        if (is_numeric($this->update(self::$table_name, $fields, $this->generateAddFields($fields, $data), "id=" . $id))) {
            return true;
        }
        return false;
    }

}