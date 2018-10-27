<?php

$curdir = dirname(__FILE__);
require_once($curdir . '/Db.php');

class Report extends Db {

    protected static $improvements_table_name = " `tbl_pap_improvement` "
            . "JOIN (SELECT `dpr`.`id`, tpt.`title` as propertytype, tpd.`title` as propertydescription, "
            . "`measure_unit`  `improv_mu`, `short_form`  `improv_msf`"
            . "FROM  tbl_property_type tpt "
            . "JOIN tbl_property_types_description tptd ON tptd.property_type_id = tpt.id "
            . "JOIN tbl_district_property_rate dpr ON dpr.propertytypedescription_id = tptd.id  "
            . "JOIN tbl_property_description tpd ON tptd.property_description_id = tpd.id "
            . "LEFT JOIN tbl_measure_unit tmu ON tpt.measure_unit_id = tmu.id) `tbl_dpr` ON `district_property_rate_id` = `tbl_dpr`.`id`";
    protected static $crops_table_name = " `tbl_pap_crop_tree`"
            . " JOIN (SELECT `tdcr`.`id`, tct.`title` as croptype, tcd.`title` as `cropdescription`, "
            . "`measure_unit`  `crop_mu`, `short_form` `crop_msf` "
            . "FROM  tbl_tree_or_crop_types tct "
            . "JOIN tree_crop_types_description tctd ON tctd.tree_crop_id = tct.id "
            . "JOIN tbl_district_croptree_rate tdcr ON tdcr.croptree_id = tctd.id  "
            . "JOIN tbl_crop_description tcd ON tctd.crop_description_id = tcd.id "
            . "LEFT JOIN tbl_measure_unit tmu ON tct.measure_unit_id = tmu.id) `tbl_dr` ON `crop_description_rate_id` = `tbl_dr`.`id`";

    public function getProjectReport($where = 1) {
        //the crops/trees
        $crop_fields = array("`pap_id`", "`quantity` `crop_qty`", "`tbl_pap_crop_tree`.`rate` `crop_rate`", "`crop_description_rate_id`", "`croptype`", "`cropdescription`",
            "`crop_mu`", "`crop_msf`");

        $crop_trees_query = "(SELECT " . implode(',', $crop_fields) . " FROM " . self::$crops_table_name . ") `crop_trees`";

        //the improvements
        $improvements_fields = array("`pap_id`", "`quantity` `improvement_qty`", "`tbl_pap_improvement`.`rate` `improvement_rate`", "`district_property_rate_id`",
            "`propertytype`", "`propertydescription`", "`improv_mu`", "`improv_msf`");

        $improvements_query = "(SELECT " . implode(',', $improvements_fields) . " FROM " . self::$improvements_table_name . ") `improvements`";


        $tables = "tbl_paps LEFT JOIN `tenure` ON `tenure` = `tenure`.`id` JOIN `tbl_district` ON `district_id` = `tbl_district`.`id`"
                . " LEFT JOIN $improvements_query ON `tbl_paps`.`id` = `improvements`.`pap_id`"
                . " LEFT JOIN $crop_trees_query ON `tbl_paps`.`id` = `crop_trees`.`pap_id` "
                . "LEFT JOIN `tbl_subcounty` ON `subcounty_id` = `tbl_subcounty`.`id` "
                . "LEFT JOIN `tbl_parish` ON `parish_id` = `tbl_parish`.`id` "
                . "LEFT JOIN `tbl_village` ON `village_id` = `tbl_village`.`id`";

        $fields = "`tbl_paps`.`id`, `project_id`, `pap_ref`, `firstname`, `othername`, `lastname`, `phone_contact`, `tenure`.`title` `tenure_desc`, `district_name`,"
                . " `subcounty_name`, `parish_name`, `village_name`, `way_leave`, `rightofway`, `total_take`, `diminution_rate`, `rate_per_acre`, `land_interest`, "
                . "`chainage`, `croptype`, `cropdescription`, `crop_qty`, `crop_rate`, `crop_mu`, `crop_msf`, `propertytype`, `propertydescription`, `comment`, `improvement_qty`, "
                . "`improvement_rate`, `improv_mu`, `improv_msf`";

        $result_array = $this->getfarray($tables, $fields, $where, "", "");
        return !empty($result_array) ? $result_array : false;
    }

    /**
     * 
     * summarized_report function enables the generation of an aggregated report providing summaries of PAPs' compensations at the villages. districts, subcounties and at the parish level
     * @param type $where is a string which provides a filter for the query
     */
    public function getPapSummarizedReport($where = FALSE) {
        $crop_trees_query = "(SELECT `pap_id`, SUM(`quantity`*`rate`) `crop_tree_sum` FROM `tbl_pap_crop_tree` GROUP BY `pap_id`) `crop_trees`";
        $improvements_query = "(SELECT `pap_id`, SUM(`quantity`*`rate`) `improvement_sum` FROM `tbl_pap_improvement` GROUP BY `pap_id`) `improvements`";

        $fields = "`tbl_paps`.`id`, `project_id`, `pap_ref`, `firstname`, `othername`, `lastname`, `phone_contact`, `tenure`.`title` `tenure_desc`, `district_name`,"
                . " `subcounty_name`, `parish_name`, `village_name`, `nid_no`, `bank_id`, `bank_name`, `acc_number`, `way_leave`, `rightofway`, `total_take`, `diminution_rate`, `rate_per_acre`, `land_interest`, "
                . "`chainage`, `x_coord`, `y_coord`, `crop_tree_sum`,  `improvement_sum`, `comment`";


        $tables = "tbl_paps LEFT JOIN `tenure` ON `tenure` = `tenure`.`id` JOIN `tbl_district` ON `district_id` = `tbl_district`.`id`"
                . " LEFT JOIN $improvements_query ON `tbl_paps`.`id` = `improvements`.`pap_id`"
                . " LEFT JOIN $crop_trees_query ON `tbl_paps`.`id` = `crop_trees`.`pap_id` "
                . "LEFT JOIN `tbl_subcounty` ON `subcounty_id` = `tbl_subcounty`.`id` "
                . "LEFT JOIN `tbl_parish` ON `parish_id` = `tbl_parish`.`id` "
                . "LEFT JOIN `tbl_village` ON `village_id` = `tbl_village`.`id`"
                . " LEFT JOIN `tbl_bank` ON `bank_id` = `tbl_bank`.`id`";

        $result_array = $this->getfarray($tables, $fields, $where, "", "");
        return !empty($result_array) ? $result_array : false;
    }

    public function getPapVillageSummary($where = 1) {
        $crop_trees_query = "(SELECT `pap_id`, SUM(`quantity`*`rate`) `crop_tree_sum` FROM `tbl_pap_crop_tree` GROUP BY `pap_id`) `crop_trees`";
        $improvements_query = "(SELECT `pap_id`, SUM(`quantity`*`rate`) `improvement_sum` FROM `tbl_pap_improvement` GROUP BY `pap_id`) `improvements`";
        $villages_query = " (SELECT `tbl_village`.`id`, `village_name`, `parish_name`,  `subcounty_name`, `district_name` FROM `tbl_village` "
                . "     LEFT JOIN `tbl_parish` ON `parish` = `tbl_parish`.`id`"
                . "    LEFT JOIN `tbl_subcounty`ON `tbl_subcounty`.`id` = `subcounty`"
                . "    JOIN `tbl_district`  ON `district`=`tbl_district`.`id`) "
                . "`villages`";

        $fields = "`no_paps`, `village_name`, `parish_name`,  `subcounty_name`, `district_name`,  `land_value`,  `crop_tree_value`,  `improvement_value`";

        $land_value = "SUM(((COALESCE(`way_leave`,0)*COALESCE(`diminution_rate`/100,0))+((COALESCE(`rightofway`,0)+COALESCE(`total_take`,0))*COALESCE(`land_interest`/100,0)))*COALESCE(`rate_per_acre`,0)) `land_value`";

        $tables = "$villages_query JOIN (SELECT `village_id`, COUNT(`tbl_paps`.`id`) `no_paps`, `project_id`, $land_value, SUM(`crop_tree_sum`) `crop_tree_value`,  SUM(`improvement_sum`) `improvement_value` FROM `tbl_paps` "
                . " LEFT JOIN $improvements_query ON `tbl_paps`.`id` = `improvements`.`pap_id`"
                . " LEFT JOIN $crop_trees_query ON `tbl_paps`.`id` = `crop_trees`.`pap_id` GROUP BY `project_id`,`village_id`) `village_paps`  ON `village_id` = `villages`.`id` ";

        $result_array = $this->getfarray($tables, $fields, $where, "", "");
        return !empty($result_array) ? $result_array : false;
    }

    public function getPropertiesSummary2($where = 1) {
        //the improvements
        $pap_improvements_summary = "(select district_property_rate_id, count(tbl_pap_improvement.id) `property_cnt`,sum(quantity) qty, max(rate) qty_rate "
                . "from tbl_pap_improvement WHERE $where group by district_property_rate_id) tpps ";

        $improvement_table_name = " `tbl_pap_improvement` "
                . " JOIN tbl_district_property_rate tdpr ON `district_property_rate_id` = `tdpr`.`id`  "
                . "JOIN tbl_property_types_description tptd ON tdpr.propertytypedescription_id = tptd.id "
                . "JOIN tbl_property_description tpd ON tptd.property_description_id = tpd.id "
                . "JOIN  tbl_property_type tpt ON tptd.property_type_id = tpt.id "
                . "JOIN $pap_improvements_summary ON tpps.district_property_rate_id = tdpr.id "
                . "LEFT JOIN tbl_measure_unit tmu ON tpt.measure_unit_id = tmu.id";

        $prop_fields = "`qty`, `qty_rate`,  `property_cnt`, tpt.`title` `propertytype`,tpd.`title` `propertydescription`,`measure_unit` `improv_mu`,`short_form` `improv_msf`";
        $result_array = $this->getfarray($improvement_table_name, $prop_fields, "", "", "");
        return !empty($result_array) ? $result_array : false;
    }

    public function getPropertiesSummary($where = 1) {
        //the improvements
        $pap_improvements_summary = "(select district_property_rate_id, count(tbl_pap_improvement.id) `property_cnt`,sum(quantity) qty, max(rate) qty_rate "
                . "from tbl_pap_improvement WHERE $where group by district_property_rate_id) tpps ";

        $improvement_table_name = " (SELECT tdpr.id,tpt.`title` `propertytype`, tpd.`title` `propertydescription`,`measure_unit` `improv_mu`,`short_form` `improv_msf` "
                . "FROM tbl_district_property_rate tdpr "
                . "JOIN tbl_property_types_description tptd ON tdpr.propertytypedescription_id = tptd.id "
                . "JOIN tbl_property_description tpd ON tptd.property_description_id = tpd.id "
                . "JOIN  tbl_property_type tpt ON tptd.property_type_id = tpt.id "
                . "LEFT JOIN tbl_measure_unit tmu ON tpt.measure_unit_id = tmu.id) dprs";
        //. "JOIN $pap_improvements_summary ON tpps.district_property_rate_id = tdpr.id "

        $table = $pap_improvements_summary . " JOIN $improvement_table_name ON dprs.id=district_property_rate_id";
        $result_array = $this->getarray($table, "", "", "");
        return !empty($result_array) ? $result_array : false;
    }

    public function getCropsSummary($where = 1) {
        //the crops
        $pap_crop_summary = "(select crop_description_rate_id, count(tbl_pap_crop_tree.id) `crop_cnt`, sum(quantity) qty, max(rate)  qty_rate "
                . "from tbl_pap_crop_tree WHERE $where group by  crop_description_rate_id) tpcs ";
        //$crop_fields = "`qty`, `qty_rate`, `crop_cnt`,tct.`title` `croptype`, tcd.`title` `cropdescription`,`measure_unit` `crop_mu`,`short_form` `crop_msf`";
        $crop_table_name = "(SELECT tdcr.id, tct.`title` `croptype`, tcd.`title` `cropdescription`,`measure_unit` `crop_mu`,`short_form` `crop_msf` "
                . "FROM tbl_district_croptree_rate tdcr "
                . "JOIN tree_crop_types_description tctd ON tdcr.croptree_id = tctd.id "
                . "JOIN tbl_crop_description tcd ON tctd.crop_description_id = tcd.id "
                . "JOIN  tbl_tree_or_crop_types tct ON tctd.tree_crop_id = tct.id "
                . "LEFT JOIN tbl_measure_unit tmu ON tct.measure_unit_id = tmu.id) dcrs";
        //. " JOIN $pap_crop_summary ON tpcs.crop_description_rate_id = tdcr.id ";

        $table = $pap_crop_summary . " JOIN $crop_table_name ON dcrs.id=crop_description_rate_id";
        $result_array = $this->getarray($table, "", "", "");
        return !empty($result_array) ? $result_array : false;
    }

}
