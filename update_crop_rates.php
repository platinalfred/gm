<?php
$needed_files = array();
include("includes/header.php");
?>
<div class="container-fluid main-content">
    <div class="page-title"><h1>Copy crop rates</h1></div>
    <div class="row">
        <div class="col-lg-12">
            <div class="widget-container fluid-height clearfix">
                <?php
                if (isset($_POST['submit'])) {
                    if ($_POST['from'] !== $_POST['to']) {
                        require_once("lib/Db.php");
                        $db = new Db();
                        $district_croptree_rates = $db->getfarray("tbl_district_croptree_rate", "id, rate", "district_id=" . $_POST['from'], "", "");
                        if (!empty($district_croptree_rates)) {
                            $count = 0;
                            $fields = array("rate");
                            foreach ($district_croptree_rates as $district_croptree_rate) {
                                if ($db->update("tbl_district_croptree_rate", $fields, array("rate" => $district_croptree_rate['rate']), "`district_id`=" . $_POST['to'] . " AND `id`=" . $district_croptree_rate['id'])) {
                                    $count++;
                                }
                            }
                            print "Update done, $count records updated";
                        } else {
                            print "<h3><em>No crop rates found/to be updated!!</em></h3>";
                        }
                    } else {
                        print "<h3><em>You can not copy to the same district!!</em></h3>";
                    }
                }
                print_html_form();

                function print_html_form() {
                    require_once("lib/Districts.php");
                    $district_obj = new Districts();
                    $districts = $district_obj->findAll();

                    print "<p>Select the districts whose crop rates to be copied and copied from respectively</p>";
                    
                    print '<form id="copy_rates" action="#" method="post" class="form-horizontal">
                    <div class="form-group">
                        <label class="control-label col-md-4">District from:</label>
                        <div class="col-md-7">
                        <select class="form-control" id="from" name="from">';
                    gen_opts($districts);
                    print "</select></div></div>";
                    
                    print '<form id="copy_rates" action="#" method="post" class="form-horizontal">
                    <div class="form-group">
                        <label class="control-label col-md-4">District to:&nbsp;&nbsp;</label>
                        <div class="col-md-7">
                        <select class="form-control" id="to" name="to">';
                    gen_opts($districts);
                    print "</select></div></div>";

                    print "<div class=\"form-group\"><label class=\"control-label col-md-4\">&nbsp;</label><div class=\"col-md-7\"><input type=\"submit\" name=\"submit\" value=\"Copy\"><input type=\"reset\" value=\"Cancel\"></div></div></form>";
                }

                function gen_opts($data) {
                    foreach ($data as $data_item) {
                        print "<option value=\"" . $data_item['id'] . "\">" . $data_item['district_name'] . "</option>";
                    }
                }
                ?>
            </div>
        </div>
    </div>
</div>
<?php
include("includes/footer.php");
