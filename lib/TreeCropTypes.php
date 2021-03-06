<?php

$curdir = dirname(__FILE__);
require_once($curdir . '/Db.php');

class TreeCropTypes extends Db {

    protected static $table_name = "tbl_tree_or_crop_types";
    protected static $db_fields = array("id", "title", "description", "measure_unit_id");

    public function findById($id) {
        $result = $this->getrec(self::$table_name, "id=" . $id, "");
        return !empty($result) ? $result : false;
    }

    public function findAll() {
        $table = self::$table_name." LEFT JOIN `tbl_measure_unit` ON `measure_unit_id` = `tbl_measure_unit`.`id`";
        $fields = "tbl_tree_or_crop_types.id, title, description, measure_unit_id, measure_unit, short_form";
        $result_array = $this->getfarray($table, $fields, "", "", "");
        return !empty($result_array) ? $result_array : false;
    }

    public function findTreeName($id) {
        $result = $this->getfrec(self::$table_name, "title", "id=" . $id, "", "");
        return !empty($result) ? $result['title'] : false;
    }

    public function treecropTypeExist($data) {
        if ($this->countRecords(self::$table_name, "title='" . $data['title'] . "'") > 0) {
            return true;
        }
        return false;
    }

    public function addTreeCropType($data) {
        $fields = array_slice(self::$db_fields, 1);
        if ($this->add(self::$table_name, $fields, $this->generateAddFields($fields, $data))) {
            return true;
        }
        return false;
    }

    public function updateTreeCropType($data) {
        $fields = array_slice(self::$db_fields, 1);
        $id = $data['id'];
        unset($data['id']);
        if (is_numeric($this->update(self::$table_name, $fields, $this->generateAddFields($fields, $data), "id=" . $id))) {
            return true;
        }
        return false;
    }

}
