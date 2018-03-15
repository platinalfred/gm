<?php
$needed_files = array("dataTables", "iCheck", "jasny", "knockout", "select2", "moment");
include("includes/header.php");
?>
<?php
if (!isset($_GET['id'])) {
    header('Location: error_404.php');
}
$land_acquisition_object = new LandAcquisition();
$projectDetails = $land_acquisition_object->findById($_GET['id']);
//if the request comes up empty, redirect to the invalid page-title
if (!$projectDetails) {
    header("Location: error_404.php");
}
?>
<div class="container-fluid main-content">
    <div class="page-title" > <h4 ><a href="project_details.php?id=<?= $_GET['id'] ?>"><?php echo $projectDetails['project_title']; ?></a><?php if (isset($_GET['pap_id'])) { ?> <i class="fa fa-chevron-right"></i> <a href="project_details.php?id=<?php echo $_GET['id']; ?>#tab-1"> Paps</a> <i class="fa fa-chevron-right"></i> Pap detais <?php } ?></h4> </div>
    <div style="clear:float;"></div>
    <?php if (!isset($_GET['pap_id'])):
        $paps_obj = new ProjectAffectedPerson();
        $pap_crop_tree_obj = new PAP_CropTree();
        $pap_improvement_obj = new PAP_Improvement();
        //Project Report
        $project_paps = $paps_obj->findAll("`project_id` = " . $_GET['id']);
        ?>
        <div class="row">
            <div class="col-lg-12">
                <div class="widget-container fluid-height clearfix">
                    <div class="tabs-container" id="project_page">
                        <ul class="nav nav-tabs">
                            <li class="active"><a data-toggle="tab" href="#tab-4" ><i class="fa fa-pie-chart"></i> Project Report</a></li>
                           
                        </ul>
                        <div class="tab-content">
                             <?php 
                            //print_r($project_paps);
                            include("project_report.php"); ?>
                        </div>
                    </div>
                </div>
            </div>
        </div>
                <?php else: ?>

<?php endif; ?>
</div>
<?php
include("js/report_module_js.php");
include("includes/footer.php");
?>
