<?php
$needed_files = array();
include("includes/header.php");
?>
<div class="container-fluid main-content">
    <div class="page-title"><h1>Update crop rates</h1></div>
    <div class="row">
        <div class="col-lg-12">
            <div class="widget-container fluid-height clearfix">
                <?php
                if (isset($_POST['submit'])) {
                    if (isset($_POST['from']) && is_numeric($_POST['from'])) {
                        require_once("lib/Db.php");
                        $db = new Db();
                        $district_croptree_rates = $db->getfarray("`tbl_district_croptree_rate`", "`id`, `rate`", "`district_id`=" . $_POST['from'], "", "");
                        $district_property_rates = $db->getfarray("`tbl_district_property_rate`", "`id`, `rate`", "`district_id`=" . $_POST['from'], "", "");

                        if (!empty($district_croptree_rates)) {
                            $count = 0;
                            if (isset($_POST['to']) && is_numeric($_POST['to']) && $_POST['from'] !== $_POST['to']) {
                                $fields = array("`rate`");
                                foreach ($district_croptree_rates as $district_croptree_rate) {
                                    if (($affected_rows = $db->update("`tbl_district_croptree_rate`", $fields, array("`rate`" => $district_croptree_rate['rate']), "`district_id`=" . $_POST['to'] . " AND `id`=" . $district_croptree_rate['id']))) {
                                        $count += $affected_rows;
                                    }
                                }
                                print "<h3><em>Update done, $count district crop rate records successfully updated.</em></h3>";
                            } elseif (isset($_POST['project_id']) && is_numeric($_POST['project_id'])) {
                                $fields = array("`rate`");
                                foreach ($district_croptree_rates as $district_croptree_rate) {
                                    if (($affected_rows = $db->update("`tbl_pap_crop_tree`", $fields, array("`rate`" => $district_croptree_rate['rate']), "`crop_description_rate_id`=" . $district_croptree_rate['id'] . " AND `pap_id` IN (SELECT `id` FROM `tbl_paps` WHERE `project_id`=" . $_POST['project_id'] . ")"))) {
                                        $count += $affected_rows;
                                    }
                                }
                                print "<h3><em>Update done, $count pap crop records updated.</em></h3>";
                            } else {
                                print "<h3><em>Please select district/project to be copied to!</em></h3>";
                            }
                        } else {
                            print "<h3><em>No crop rates found/to be updated!!</em></h3>";
                        }

                        if (!empty($district_property_rates)) {
                            $count = 0;
                            if (isset($_POST['to']) && is_numeric($_POST['to']) && $_POST['from'] !== $_POST['to']) {
                                $fields = array("`rate`");
                                foreach ($district_property_rates as $district_property_rate) {
                                    if (($affected_rows = $db->update("`tbl_district_property_rate`", $fields, array("`rate`" => $district_property_rate['rate']), "`district_id`=" . $_POST['to'] . " AND `id`=" . $district_property_rate['id']))) {
                                        $count += $affected_rows;
                                    }
                                }
                                print "<h3><em>Update done, $count district property rate records successfully updated.</em></h3>";
                            } elseif (isset($_POST['project_id']) && is_numeric($_POST['project_id'])) {
                                $fields = array("`rate`");
                                foreach ($district_property_rates as $district_property_rate) {
                                    if (($affected_rows = $db->update("tbl_pap_improvement", $fields, array("`rate`" => $district_property_rate['rate']), "`district_property_rate_id`=" . $district_property_rate['id'] . " AND `pap_id` IN (SELECT `id` FROM `tbl_paps` WHERE `project_id`=" . $_POST['project_id'] . ")"))) {
                                        $count += $affected_rows;
                                    }
                                }
                                print "<h3><em>Update done, $count pap property records updated.</em></h3>";
                            } else {
                                print "<h3><em>Please select district/project to be copied to!</em></h3>";
                            }
                        } else {
                            print "<h3><em>No property rates found/to be updated!!</em></h3>";
                        }
                    }
                }
                print_html_form();

                function print_html_form() {
                    require_once("lib/Districts.php");
                    require_once("lib/LandAcquisition.php");
                    $district_obj = new Districts();
                    $project_obj = new LandAcquisition();
                    $districts = $district_obj->findAll();
                    $projects = $project_obj->findAll();

                    print "<div class=\"col-md-10 col-md-offset-1\">"
                            . "<p>Select the districts whose crop rates to be copied first.</p>"
                            . "<p>If you are planning on copying the rates to another district, select the district to be copied to.</p>"
                            . "<p>If you are planning on applying the rates to an existing project, then select the project the updated rates should be applied to.</p>";

                    print '<form id="copy_rates" action="#" method="post" class="form-horizontal">
                    <div class="form-group">
                        <label class="control-label col-md-2" for="from">District from:</label>
                        <div class="col-md-4">
                        <select class="form-control" id="from" name="from"><option value="">--Select--</option>';
                    gen_opts($districts, 'district_name');
                    print "</select></div></div>";

                    print '<div class="form-group">
                        <label class="control-label col-md-2" for="to">District to:&nbsp;&nbsp;</label>
                        <div class="col-md-4">
                        <select class="form-control" id="to" name="to"><option value="">--Select--</option>';
                    gen_opts($districts, 'district_name');
                    print "</select></div></div>";

                    print '<div class="form-group">
                        <label class="control-label col-md-2" for="project_id">To project:&nbsp;&nbsp;</label>
                        <div class="col-md-10">
                        <select class="form-control" id="project_id" name="project_id"><option value="">--Select--</option>';
                    gen_opts($projects, 'project_title');
                    print "</select></div></div>";

                    print "<div class=\"form-group\"><label class=\"control-label col-md-4\">&nbsp;</label><div class=\"col-md-7\"><input type=\"submit\" name=\"submit\" value=\"Update\"><input type=\"reset\" value=\"Cancel\"></div></div></div></form>";
                }

                function gen_opts($data, $title_key) {
                    foreach ($data as $data_item) {
                        print "<option value=\"" . $data_item['id'] . "\">" . $data_item[$title_key] . "</option>";
                    }
                }
                ?>
            </div>
        </div>
    </div>
</div>
<?php
include("includes/footer.php");
