<?php

require_once("lib/Libraries.php");
$output = array();
//print_r($_POST);
if (isset($_POST['tbl'])) {
    switch ($_POST['tbl']) {
        case "land_access_project":
            $land_acquistion = new landAcquisition();
            $output['data'] = $land_acquistion->findAllAccess();
            break;
        case "land_acquistion_category_unit":
            $land_acquistion_category_unit = new landAcquisitionCategoryUnit();
            $output['data'] = $land_acquistion_category_unit->findUnits();
            break;
        case "expense_type":
            $expense_type = new ExpenseTypes();
            $output['data'] = $expense_type->findAll();
            break;
        case "gmt_clients":
            $client_obj = new Client();
            $output['data'] = $client_obj->findAll();
            break;
        case "staff":
            $staff_obj = new Staff();
            $output['data'] = $staff_obj->findStaffDetails();
            break;
        case "project_setup":
            $client_obj = new Client();
            $output['clients'] = $client_obj->getSelectList();
            break;
        case "project_report":
            $report_obj = new Report();
            $output['data'] = $report_obj->getProjectReport();
            break;
        case "pap_compensation_report":
            $pap_report_obj = new Report();
            $where = isset($_POST['project_id'])?("`project_id`=".$_POST['project_id']):1;
            $output['data'] = $pap_report_obj->getPapSummarizedReport($where);
            break;
        case "pap_village_report":
            $pap_report_obj = new Report();
            $where = isset($_POST['project_id'])?("`project_id`=".$_POST['project_id']):1;
            $output['data'] = $pap_report_obj->getPapVillageSummary($where);
            break;
        case "project_improvements_report":
            $pap_report_obj = new Report();
            $where = isset($_POST['project_id'])?("`pap_id` IN (SELECT `id` FROM `tbl_paps` WHERE `project_id`=".$_POST['project_id'].")"):1;
            $output['data'] = $pap_report_obj->getPropertiesSummary($where);
            break;
        case "project_crops_report":
            $pap_report_obj = new Report();
            $where = isset($_POST['project_id'])?("`pap_id` IN (SELECT `id` FROM `tbl_paps` WHERE `project_id`=".$_POST['project_id'].")"):1;
            $output['data'] = $pap_report_obj->getCropsSummary($where);
            break;
        case "project_details":
            //geography
            $project_coverage_obj = new ProjectCoverage();
            $district_property_rate_obj = new DistrictPropertyRate();
            $district_crop_rate_obj = new DistrictCropRate();
            $pap_tree = new PAP_CropTree();
            $pap_improvement = new PAP_Improvement();

            $output['pap_improvements'] = $pap_improvement->findByImprovements("`pap_id` IN (SELECT `id` FROM `tbl_paps` WHERE `project_id` =" . $_POST['project_id'] . ")");
            $output['pap_crops'] = $pap_tree->findByPapCropTrees("`pap_id` IN (SELECT `id` FROM `tbl_paps` WHERE `project_id` =" . $_POST['project_id'] . ")");

            $output['available_districts'] = $project_coverage_obj->findAvailableDistricts($_POST['project_id']);
            $output['district_property_rates'] = $district_property_rate_obj->findDistrictPropertyRates("`district_id` IN (SELECT `district_id` FROM `tbl_project_coverage` WHERE `project_id` = " . $_POST['project_id'] . ")");
            $output['district_crop_rates'] = $district_crop_rate_obj->findDistrictCropRates("`district_id` IN (SELECT `district_id` FROM `tbl_project_coverage` WHERE `project_id` = " . $_POST['project_id'] . ")");
            break;
        case "project_coverage":
            $project_coverage_obj = new ProjectCoverage();
            $output['data'] = $project_coverage_obj->findAll("`project_id`=" . $_POST['project_id']);
            break;
        case "project_paps":
            $pap_obj = new ProjectAffectedPerson();
            $output['data'] = $pap_obj->findAll("`project_id`=" . $_POST['project_id']);
            break;
        case "project_paps_reports":
            /** $pap_obj = new ProjectAffectedPerson();
            $output['data'] = $pap_obj->findAll("`project_id`=" . $_POST['project_id']);*/
            require_once("lib/DatatablesJSON.php");
            $data_table = new DataTable();

            $improvements = "(SELECT `pap_id`, COUNT(`id`) `improvement_cnt`,SUM(`rate`*`quantity`) `improvement_sum` FROM `tbl_pap_improvement` WHERE `district_property_rate_id` IN (SELECT `id` FROM `tbl_district_property_rate`) GROUP BY `pap_id`) `improvements`";
            $crop_trees = "(SELECT `pap_id`, COUNT(`id`) `crop_tree_cnt`,SUM(`rate`*`quantity`) `crop_tree_sum` FROM `tbl_pap_crop_tree` WHERE `crop_description_rate_id` IN (SELECT `id` FROM `tbl_district_croptree_rate`) GROUP BY `pap_id`) `crop_trees`";
            $tables = "`tbl_paps` LEFT JOIN `tenure` ON `tenure` = `tenure`.`id` LEFT JOIN `tbl_bank` ON `bank_id` = `tbl_bank`.`id` JOIN `tbl_district` ON `district_id` = `tbl_district`.`id` LEFT JOIN `tbl_subcounty` ON `subcounty_id` = `tbl_subcounty`.`id` LEFT JOIN `tbl_parish` ON `parish_id` = `tbl_parish`.`id` LEFT JOIN `tbl_village` ON `village_id` = `tbl_village`.`id`";
            $primary_key = "`tbl_paps`.`id`";
            $where = "`project_id`=" . $_POST['project_id'];
            $columns = array("`pap_ref`",  "`firstname`", "`othername`", "`lastname`", "`phone_contact`",  "`bank_id`", "`bank_name`", "`acc_number`", "`nid_no`", "`district_id`", "`district_name`", "`county_id`", "`subcounty_id`", "`subcounty_name`", "`tenure`", "`tenure`.`title` `tenure_desc`", "`comment`", "`parish_id`", "`parish_name`", "`village_id`", "`village_name`", "`photo_url` `profile_pic`", "`tbl_paps`.`id`", "`tbl_paps`.`id` as pap_d", "`project_id`", "`way_leave`", "`rightofway`", "`total_take`", "`x_coord`", "`y_coord`", "`chainage`", "`land_interest`", "`rate_per_acre`", "`diminution_rate`");

            // Get the data
            $output = $data_table->get($tables, $primary_key, $columns, $where);
            break;
        case "pap_details":
            $pap_crop_tree_obj = new PAP_CropTree();
            $pap_improvement_obj = new PAP_Improvement();
            $output['pap_crop_trees'] = $pap_crop_tree_obj->findPapCropTrees("pap_id=" . $_POST['pap_id']);
            $output['pap_improvements'] = $pap_improvement_obj->findPapImprovements("pap_id=" . $_POST['pap_id']);
            break;
        case "pap_crops":
            $pap_crop_tree_obj = new PAP_CropTree();
            $output['data'] = $pap_crop_tree_obj->findPapCropTrees("pap_id=" . $_POST['pap_id']);
            break;
        case "pap_improvements":
            $pap_improvement_obj = new PAP_Improvement();
            $output['data'] = $pap_improvement_obj->findPapImprovements("pap_id=" . $_POST['pap_id']);
            break;
        case "crop_types":
            $treecroptypedescription = new TreeCropTypesDescription();
            $crop_description = new CropDescription();
            $output['all_attached'] = $treecroptypedescription->findCropTreeDescription("`tree_crop_id`=" . $_POST['crop_id']);
            $output['all_crop_descriptions'] = $crop_description->findAll("id NOT IN (SELECT `crop_description_id` FROM `tree_crop_types_description` WHERE `tree_crop_id`=" . $_POST['crop_id'] . ")");
            break;
        case "improvement_desc":
            $propertytypedescription = new PropertyTypeDescription();
            $propertydescription = new PropertyDescription();
            $output['all_attached_improvements'] = $propertytypedescription->findPropertyTypeDescription("`property_type_id`=" . $_POST['property_id']);
            $output['all_improvements_description'] = $propertydescription->findAll("id NOT IN (SELECT `property_description_id` FROM `tbl_property_types_description` WHERE `property_type_id`=" . $_POST['property_id'] . ")");
            break;
        default:
            echo "No data found!";
            break;
    }
    echo json_encode($output);
}