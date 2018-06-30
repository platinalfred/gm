<?php

$curdir = dirname(__FILE__);
require_once($curdir . '/Db.php');

class Report extends Db {
    
    protected static $improvements_table_name = " `tbl_pap_improvement` JOIN (SELECT `dpr`.`id`, tpt.`title` as propertytype, tpd.`title` as propertydescription, "
                . "`measure_unit`  `improv_mu`, `short_form`  `improv_msf`"
                . "FROM  tbl_property_type tpt "
                . "JOIN tbl_property_types_description tptd ON tptd.property_type_id = tpt.id "
                . "JOIN tbl_district_property_rate dpr ON dpr.propertytypedescription_id = tptd.id  "
                . "JOIN tbl_property_description tpd ON tptd.property_description_id = tpd.id "
                . "LEFT JOIN tbl_measure_unit tmu ON tpt.measure_unit_id = tmu.id) `tbl_dpr` ON `district_property_rate_id` = `tbl_dpr`.`id`";
    
        protected static $crops_table_name = " `tbl_pap_crop_tree` JOIN (SELECT `tdcr`.`id`, tct.`title` as croptype, tcd.`title` as `cropdescription`, "
                . "`measure_unit`  `crop_mu`, `short_form` `crop_msf` "
                . "FROM  tbl_tree_or_crop_types tct "
                . "JOIN tree_crop_types_description tctd ON tctd.tree_crop_id = tct.id "
                . "JOIN tbl_district_croptree_rate tdcr ON tdcr.croptree_id = tctd.id  "
                . "JOIN tbl_crop_description tcd ON tctd.crop_description_id = tcd.id "
                . "LEFT JOIN tbl_measure_unit tmu ON tct.measure_unit_id = tmu.id) `tbl_dr` ON `crop_description_rate_id` = `tbl_dr`.`id`";


        public function getProjectReport($where = 1) {
        //teh crops/trees
        $crop_fields = array("`pap_id`", "`quantity` `crop_qty`", "`tbl_pap_crop_tree`.`rate` `crop_rate`", "`crop_description_rate_id`", "`croptype`", "`cropdescription`", 
            "`crop_mu`", "`crop_msf`");

        $crop_trees_query = "(SELECT " . implode(',', $crop_fields) . " FROM " .self::$crops_table_name.") `crop_trees`";

        //the improvements
        $improvements_fields = array("`pap_id`", "`quantity` `improvement_qty`", "`tbl_pap_improvement`.`rate` `improvement_rate`", "`district_property_rate_id`", 
            "`propertytype`", "`propertydescription`", "`improv_mu`", "`improv_msf`");

        $improvements_query = "(SELECT " . implode(',', $improvements_fields) . " FROM " .self::$improvements_table_name.") `improvements`";


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
    public function getPapSummarizedReport($where = FALSE){
        $crop_trees_query = "(SELECT `pap_id`, SUM(`quantity`*`rate`) `crop_tree_sum` FROM `tbl_pap_crop_tree` GROUP BY `pap_id`) `crop_trees`";
        $improvements_query = "(SELECT `pap_id`, SUM(`quantity`*`rate`) `improvement_sum` FROM `tbl_pap_improvement` GROUP BY `pap_id`) `improvements`";
        
        $fields = "`tbl_paps`.`id`, `project_id`, `pap_ref`, `firstname`, `othername`, `lastname`, `phone_contact`, `tenure`.`title` `tenure_desc`, `district_name`,"
                . " `subcounty_name`, `parish_name`, `village_name`, `way_leave`, `rightofway`, `total_take`, `diminution_rate`, `rate_per_acre`, `land_interest`, "
                . "`chainage`, `x_coord`, `y_coord`, `crop_tree_sum`,  `improvement_sum`, `comment`";
        

        $tables = "tbl_paps LEFT JOIN `tenure` ON `tenure` = `tenure`.`id` JOIN `tbl_district` ON `district_id` = `tbl_district`.`id`"
                . " LEFT JOIN $improvements_query ON `tbl_paps`.`id` = `improvements`.`pap_id`"
                . " LEFT JOIN $crop_trees_query ON `tbl_paps`.`id` = `crop_trees`.`pap_id` "
                . "LEFT JOIN `tbl_subcounty` ON `subcounty_id` = `tbl_subcounty`.`id` "
                . "LEFT JOIN `tbl_parish` ON `parish_id` = `tbl_parish`.`id` "
                . "LEFT JOIN `tbl_village` ON `village_id` = `tbl_village`.`id`";

        $result_array = $this->getfarray($tables, $fields, $where, "", "");
        return !empty($result_array) ? $result_array : false;
    }
    public function getPapVillageSummary($where = 1){
        $crop_trees_query = "(SELECT `pap_id`, SUM(`quantity`*`rate`) `crop_tree_sum` FROM `tbl_pap_crop_tree` GROUP BY `pap_id`) `crop_trees`";
        $improvements_query = "(SELECT `pap_id`, SUM(`quantity`*`rate`) `improvement_sum` FROM `tbl_pap_improvement` GROUP BY `pap_id`) `improvements`";
        $villages_query = " (SELECT `tbl_village`.`id`, `village_name`, `parish_name`,  `subcounty_name`, `district_name` FROM `tbl_village` "
                . "     LEFT JOIN (SELECT `tbl_parish`.`id`, `parish_name`, `subcounty_name`, `district_name` FROM  `tbl_parish`"
                . "         LEFT JOIN (SELECT `tbl_subcounty`.`id`, `subcounty_name`, `district_name` FROM `tbl_subcounty` JOIN `tbl_district` ON `district`=`tbl_district`.`id`)  `subcounties` "
                . "         ON `subcounties`.`id` = `subcounty`) "
                . "     `parishes` ON `parish` = `parishes`.`id`) "
                . "`villages`";
        
        $fields = "`no_paps`, `village_name`, `parish_name`,  `subcounty_name`, `district_name`,  `crop_tree_value`,  `improvement_value`";

        $tables = "$villages_query JOIN (SELECT `village_id`, COUNT(`tbl_paps`.`id`) `no_paps`, MIN(`project_id`)`project_id`, SUM(`crop_tree_sum`) `crop_tree_value`,  SUM(`improvement_sum`) `improvement_value` FROM `tbl_paps` "
                . " LEFT JOIN $improvements_query ON `tbl_paps`.`id` = `improvements`.`pap_id`"
                . " LEFT JOIN $crop_trees_query ON `tbl_paps`.`id` = `crop_trees`.`pap_id` GROUP BY `village_id`) `village_paps`  ON `village_id` = `villages`.`id` ";

        $result_array = $this->getfarray($tables, $fields, $where, "", "");
        return !empty($result_array) ? $result_array : false;
    }
    public function getPropertiesSummary($where = 1){
        //the improvements
        $fields = "SUM(`quantity`) `quantity`, `rate`,  COUNT(`tbl_pap_improvement`.`id`) `property_cnt`,`propertytype`,`propertydescription`,`improv_mu`,`improv_msf`";
        $result_array = $this->getfarray(self::$improvements_table_name, $fields, $where, "", ""," GROUP BY `tbl_dpr`.`id`, `propertytype`,`propertydescription`,`improv_mu`,`improv_msf`, `rate`");
        return !empty($result_array) ? $result_array : false;
    }
    public function getCropsSummary($where = 1){
        //the crops
        $fields = "SUM(`quantity`) `quantity`, `rate`, COUNT(`tbl_pap_crop_tree`.`id`) `crop_cnt`,`croptype`,`cropdescription`,`crop_mu`,`crop_msf`";
        $result_array = $this->getfarray(self::$crops_table_name, $fields, $where, "", ""," GROUP BY `tbl_dr`.`id`, `croptype`,`cropdescription`,`crop_mu`,`crop_msf`, `rate` ");
        return !empty($result_array) ? $result_array : false;
    }
}
