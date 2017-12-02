<?php
$curdir = dirname(__FILE__);
require_once($curdir.'/Db.php');
class Report extends Db {
	
	public function getProjectReport($where = 1){
		//teh crops/trees
		$crop_fields = array("`tbl_pap_crop_tree`.`id`", "`pap_id`", "`quantity` `crop_quantity`", "`tbl_pap_crop_tree`.`rate` `crop_rate`", "`crop_description_rate_id`", "`croptype`", "`cropdescription`");
		
		$crops_table_name = " `tbl_pap_crop_tree` JOIN (SELECT `dr`.`id`, dr.rate, d.district_name, tct.`title` as croptype, cd.`title` as cropdescription FROM tbl_district_croptree_rate dr JOIN tree_crop_types_description ctd ON dr.croptree_id = ctd.id JOIN tbl_crop_description cd ON ctd.crop_description_id = cd.id JOIN tbl_tree_or_crop_types tct ON ctd.tree_crop_id = tct.id JOIN tbl_district d ON  dr.district_id = d.id) `tbl_dr` ON `crop_description_rate_id` = `tbl_dr`.`id`";
		
		$crop_trees_query = "(SELECT ".implode(',',$crop_fields)." FROM $crops_table_name) `crop_trees`";
		
		//the improvements
		$improvements_fields = array("`tbl_pap_improvement`.`id`", "`pap_id`", "`quantity` `improvement_quantity`", "`tbl_pap_improvement`.`rate` `improvement_rate`", "`district_property_rate_id`", "`propertytype`", "`propertydescription`");
		
		$improvements_table_name = " `tbl_pap_improvement` JOIN (SELECT `dpr`.`id`, dpr.rate, pt.`title` as propertytype, pd.`title` as propertydescription FROM tbl_district_property_rate dpr JOIN tbl_property_types_description ptd ON dpr.propertytypedescription_id = ptd.id JOIN tbl_property_description pd ON ptd.property_description_id = pd.id JOIN tbl_property_type pt ON ptd.property_type_id = pt.id JOIN tbl_district d ON  dpr.district_id = d.id) `tbl_dpr` ON `district_property_rate_id` = `tbl_dpr`.`id`";
		
		$improvements_query = "(SELECT ".implode(',',$improvements_fields)." FROM $improvements_table_name) `improvements`";
		
		
		$tables = "tbl_paps JOIN `tbl_district` ON `district_id` = `tbl_district`.`id` LEFT JOIN $improvements_query ON `tbl_paps`.`id` = `improvements`.`pap_id` LEFT JOIN $crop_trees_query ON `tbl_paps`.`id` = `crop_trees`.`pap_id` LEFT JOIN `tbl_county` ON `county_id` = `tbl_county`.`id` LEFT JOIN `tbl_subcounty` ON `subcounty_id` = `tbl_subcounty`.`id` LEFT JOIN `tbl_parish` ON `parish_id` = `tbl_parish`.`id` LEFT JOIN `tbl_village` ON `village_id` = `tbl_village`.`id`";
		
		$fields = "`tbl_paps`.`id`, `project_id`, `pap_ref`, `firstname`, `othername`, `lastname`, `phone_contact`, `district_id`, `district_name`, `county_id`, `county_name`, `subcounty_id`, `subcounty_name`, `parish_id`, `parish_name`, `village_id`, `village_name`, `way_leave`, `rightofway`, `total_take`, `diminution_rate`, `rate_per_acre`, `land_interest`, (`wayleave`*`rate_per_acre`*`land_interest`*`diminution_rate`) `wl_value`, (`rightofway`*`rate_per_acre`*`land_interest`) `row_value`, `chainage`, `crop_tree_cnt`, `crop_tree_sum`, `improvement_cnt`, `improvement_sum`, ".implode(',',array_slice($crop_fields, 2)).", ".implode(',',array_slice($improvements_fields, 2)).", `crop_quantity`*`crop_rate` `crop_tree_value`, `improvement_quantity`*`improvement_rate` `improvement_value`";
		
		$result_array = $this->getfarray($tables, $fields, $where, "", "");
		return !empty($result_array) ? $result_array : false;
	}
}