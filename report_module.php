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
                           <li class="active"><a data-toggle="tab" href="#tabProjectReport" ><i class="fa fa-pie-chart"></i> Project Report</a></li>
                           <li><a data-toggle="tab" href="#tabPapCompensation" ><i class="fa fa-pie-chart"></i> PAP Compensation</a></li>
                           <li><a data-toggle="tab" href="#tabCropsReport" ><i class="fa fa-pie-chart"></i> Crops Report</a></li>
                           <li><a data-toggle="tab" href="#tabImprovementsReport" ><i class="fa fa-pie-chart"></i> Improvements Report</a></li>
                           <li><a data-toggle="tab" href="#tabVillageReport" ><i class="fa fa-pie-chart"></i> Village Report</a></li>
                        </ul>
                        <div class="tab-content">
                            <!-- Project Affected Persons Report section -->
                             <?php include("project_report.php"); ?>
                            <!-- end PAPs Report section -->
                            <!-- PAPs Compensation Report section -->
                            <div id="tabPapCompensation" class="tab-pane">
                                <div class="heading">
                                    <i class="fa fa-pie-chart"></i>PAPs Compensation Summary Report
                                </div>
                                <div class="widget-content padded">
                                    <div class="table-responsive">
                                        <table class="table table-bordered table-striped widerTable" id="tblPapCompenstation" width="100%">
                                            <thead>
                                                <tr>
                                                    <th>PAP REF</th>
                                                    <th>PAP NAME</th>
                                                    <th>TELEPHONE</th>
                                                    <th>DISTRICT, SUBCOUNTY, PARISH, VILLAGE</th>
                                                    <th>X COORD</th>
                                                    <th>Y COORD</th>
                                                    <th>CHAINAGE</th>
                                                    <th>LAND TENURE</th>
                                                    <?php
                                                    //Way Leave or both ROW and WL
                                                    if ($projectDetails['project_category_unit'] == 2 || $projectDetails['project_category_unit'] == 4):
                                                        ?>
                                                        <th>WAY LEAVE</th>
                                                    <?php endif; ?>
                                                    <?php
                                                    //ROW or Both ROW and WL
                                                    if ($projectDetails['project_category_unit'] == 1 || $projectDetails['project_category_unit'] == 4):
                                                        ?>
                                                        <th>RIGHT OF WAY</th>
                                                    <?php endif; ?>
                                                    <?php
                                                    //Total Take/Size OR Both ROW and WL Project
                                                    if ($projectDetails['project_category_unit'] == 5 || $projectDetails['project_category_unit'] == 4):
                                                        ?>
                                                        <th>TOTAL SIZE</th>
                                                    <?php endif; ?>
                                                    <?php //if ($projectDetails['project_category_unit'] == 1 || $projectDetails['project_category_unit'] == 4 || $projectDetails['project_category_unit'] == 5):
                                                        ?>
                                                        <th>RATE PER ACRE(U.Shs)</th>	
                                                        <th>LAND INTEREST(%)</th>
                                                        <?php //endif; ?>
                                                    <?php if ($projectDetails['project_category_unit'] == 4):
                                                        ?>
                                                        <th>Diminution(%)</th>
                                                    <?php endif; ?>
                                                    <?php
                                                    //Right of Way or Both ROW and WL
                                                    if ($projectDetails['project_category_unit'] == 1 || $projectDetails['project_category_unit'] == 4):
                                                        ?>
                                                        <th>ROW Land Value</th>
                                                    <?php endif; ?>
                                                    <?php
                                                    //Way Leave or both ROW and WL
                                                    if ($projectDetails['project_category_unit'] == 2 || $projectDetails['project_category_unit'] == 4):
                                                        ?>
                                                        <th>WL Land Value</th>
                                                    <?php endif; ?>
                                                    <?php
                                    //Total land value, applies to ROW, (Both ROW and WL) and Total Take/Size
                                                    if ($projectDetails['project_category_unit'] == 4 || $projectDetails['project_category_unit'] == 5):
                                                        ?>
                                                        <th>LAND VALUE (U.Shs)</th>
                                                    <?php endif; ?>
                                                    <th>IMPROVEMENT VALUE(U.Shs)</th>
                                                    <th>CROP/TREE VALUE(U.Shs)</th>
                                                    <th>SUB. TOTAL(U.Shs)</th>
                                                    <th>DISTURBANCE ALLOWANCE (<?php echo $projectDetails['disturbance_allowance']; ?>%)(U.Shs)</th>
                                                    <th>TOTAL COMPENSATION(U.Shs)</th>
                                                    <th>REMARKS</th>
                                                </tr>
                                            </thead>
                                            <tbody>
                                            </tbody>
                                            <tfoot>
                                                <tr>
                                                    <th>Total</th>
                                                    <th colspan="7">&nbsp;</th>
                                                    <?php if ($projectDetails['project_category_unit'] == 2 || $projectDetails['project_category_unit'] == 4): ?>
                                                        <th>&nbsp;</th>
                                                    <?php endif; ?>
                                                    <?php if ($projectDetails['project_category_unit'] == 1 || $projectDetails['project_category_unit'] == 4): ?>
                                                        <th>&nbsp;</th>
                                                    <?php endif; ?>
                                                    <?php if ($projectDetails['project_category_unit'] == 5 || $projectDetails['project_category_unit'] == 4): ?>
                                                        <th>&nbsp;</th>
                                                        <?php endif; ?>
                                                    <?php 
                                                    //if ($projectDetails['project_category_unit'] == 1 || $projectDetails['project_category_unit'] == 4 || $projectDetails['project_category_unit'] == 5):
                                                        ?>
                                                        <th>&nbsp;</th>	
                                                        <th>&nbsp;</th>
                                                    <?php //endif; ?>
                                                    <?php if ($projectDetails['project_category_unit'] == 4): ?>
                                                        <th>&nbsp;</th>	
                                                    <?php endif; ?>
                                                    <?php
                                                    //Right of Way or Both ROW and WL
                                                    if ($projectDetails['project_category_unit'] == 1 || $projectDetails['project_category_unit'] == 4):
                                                        ?>
                                                        <th>&nbsp;</th>
                                                    <?php endif; ?>
                                                    <?php
                                                    //Way Leave or both ROW and WL
                                                    if ($projectDetails['project_category_unit'] == 2 || $projectDetails['project_category_unit'] == 4): ?>
                                                        <th>&nbsp;</th>
                                                    <?php endif; ?>
                                                    <?php if ($projectDetails['project_category_unit'] == 4 || $projectDetails['project_category_unit'] == 5): ?>	
                                                    <th>&nbsp;</th>
                                                    <?php endif; ?>
                                                    <th>&nbsp;</th>
                                                    <th>&nbsp;</th>
                                                    <th>&nbsp;</th>
                                                    <th>&nbsp;</th>
                                                    <th>&nbsp;</th>
                                                    <th>&nbsp;</th>
                                                </tr>
                                            </tfoot>
                                            </table>
                                    </div>
                                </div>
                            </div>
                            <div id="tabCropsReport" class="tab-pane">
                                <div class="heading">
                                    <i class="fa fa-pie-chart"></i>Crops Summary Report
                                </div>
                                <div class="widget-content padded">
                                    <div class="table-responsive">
                                        <table class="table table-bordered table-striped widerTable" id="tblCropsReport" width="100%">
                                            <thead>
                                                <tr>
                                                    <th>CROP/TREE TYPE</th>
                                                    <th>DESCRIPTION</th>
                                                    <th>COUNT</th>
                                                    <th>MEASURE</th>
                                                    <th>RATE(U.Shs)</th>
                                                    <th>CROP/TREE VALUE(U.Shs)</th>
                                                </tr>
                                            </thead>
                                            <tbody>
                                            </tbody>
                                            <tfoot>
                                                    <th>TOTAL</th>
                                                    <th colspan="4">&nbsp;</th>
                                                    <th>0</th>
                                            </tfoot>
                                            </table>
                                    </div>
                                </div>
                            </div>
                            <div id="tabImprovementsReport" class="tab-pane">
                                <div class="heading">
                                    <i class="fa fa-pie-chart"></i>Improvements Summary Report
                                </div>
                                <div class="widget-content padded">
                                    <div class="table-responsive">
                                        <table class="table table-bordered table-striped widerTable" id="tblImprovementsReport" width="100%">
                                            <thead>
                                                <tr>
                                                    <th>PROPERTY TYPE</th>
                                                    <th>DESCRIPTION</th>
                                                    <th>COUNT</th>
                                                    <th>MEASURE</th>
                                                    <th>RATE(U.Shs)</th>
                                                    <th>IMPROVEMENT VALUE(U.Shs)</th>
                                                </tr>
                                            </thead>
                                            <tbody>
                                            </tbody>
                                            <tfoot>
                                                    <th>TOTAL</th>
                                                    <th colspan="4">&nbsp;</th>
                                                    <th>0</th>
                                            </tfoot>
                                            </table>
                                    </div>
                                </div>
                            </div>
                            <div id="tabVillageReport" class="tab-pane">
                                <div class="heading">
                                    <i class="fa fa-pie-chart"></i>Village Summary Report
                                </div>
                                <div class="widget-content padded">
                                    <div class="table-responsive">
                                        <table class="table table-bordered table-striped widerTable" id="tblVillageReport" width="100%">
                                            <thead>
                                                <tr>
                                                    <th>DISTRICT</th>
                                                    <th>SUBCOUNTY</th>
                                                    <th>PARISH</th>
                                                    <th>VILLAGE</th>
                                                    <th>No. of PAPs</th>
                                                    <th>CROPs VALUE (U. Shs)</th>
                                                    <th>IMPROVEMENTS VALUE (U. Shs)</th>
                                                    <th>LAND VALUE (U. Shs)</th>
                                                    <th>SUB TOTAL (U. Shs)</th>
                                                    <th>DISTURBANCE ALLOWANCE (<?php echo $projectDetails['disturbance_allowance']; ?>%) (U. Shs)</th>
                                                    <th>TOTAL COMPENSATION (U. Shs)</th>
                                                </tr>
                                            </thead>
                                            <tbody>
                                            </tbody>
                                            <tfoot>
                                                    <th>TOTALs</th>
                                                    <th colspan="3">&nbsp;</th>
                                                    <th>0</th>
                                                    <th>0</th>
                                                    <th>0</th>
                                                    <th>0</th>
                                                    <th>0</th>
                                                    <th>0</th>
                                                    <th>0</th>
                                            </tfoot>
                                            </table>
                                    </div>
                                </div>
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
include("js/reports_js.php");
include("includes/footer.php");
?>
