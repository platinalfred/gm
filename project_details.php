<?php
$needed_files = array("dataTables", "iCheck", "jasny", "knockout", "select2", "moment");
include("includes/header.php");
?>
<?php
if (!isset($_GET['id'])) {
    header('Location: error_404.php');
}
require_once('lib/LandAcquisition.php');
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
    <?php
    if (!isset($_GET['pap_id'])):
        $county_obj = new Counties();
        $subcounty_obj = new SubCounties();
        $parish_obj = new Parish();
        $village_obj = new Village();
        $tenure_obj = new Tenure();
        //administrative units lists
        $counties = $county_obj->findAll();
        $subcounties = $subcounty_obj->findAll();
        $parishes = $parish_obj->findAll();
        $villages = $village_obj->findAll();
        //land tenures
        $tenures = $tenure_obj->findAll();
        ?>
        <div class="row">
            <div class="col-lg-12">
                <div class="widget-container fluid-height clearfix">
                    <div class="tabs-container" id="project_page">
                        <ul class="nav nav-tabs">
                            <li class="active"><a data-toggle="tab" href="#tab-3"><i class="fa fa-globe"></i> Coverage</a></li>
							 <li ><a data-toggle="tab" href="#tab-5"><i class="fa fa-bar-chart-o"></i> PAPs</a></li>
                            <li><a data-toggle="tab" href="#tab-2" ><i class="fa fa-briefcase"></i> Client</a></li>
                           
                        </ul>
                        <div class="tab-content">
                            
                            <!-- end Projects content pane -->
                            <!-- Projects -->
                            <div id="tab-2" class="tab-pane ">
                                <!-- Client Details pane  -->
                                <?php
                                //retrieve the client's details
                                $client_obj = new Client();
                                $client_details = $client_obj->findById($projectDetails['client_id']);
                                ?>
                                <div class="col-lg-12">
                                    <div class="widget-container fluid-height clearfix">
                                        <div class="heading">
                                            <i class="fa fa-briefcase"></i>Client details
                                        </div>
                                        <div class="widget-content padded clearfix">
                                            <div class="row">
                                                <div class="col-md-3"><strong>Names</strong></div>
                                                <div class="col-md-9"><?php echo $client_details['client_names']; ?></div>
                                            </div>
                                            <div class="row">
                                                <div class="col-md-3"><strong><i class="fa fa-mobile"></i> Telephone Contacts</strong></div>
                                                <div class="col-md-2"><a href="tel:<?php echo $client_details['phone_contact1']; ?>"><?php echo $client_details['phone_contact1']; ?></a></div>
                                                <div class="col-md-2"><a href="tel:<?php echo $client_details['phone_contact1']; ?>"><?php echo $client_details['phone_contact2']; ?></a></div>
                                                <div class="col-md-5">&nbsp;</div>
                                            </div>
                                            <div class="row">
                                                <div class="col-md-3"><strong><i class="fa fa-email"></i> Email Contacts</strong></div>
                                                <div class="col-md-4"><a href="mailto:<?php echo $client_details['email_contact1']; ?>"><?php echo $client_details['email_contact1']; ?></a></div>
                                                <div class="col-md-5"><a href="mailto:<?php echo $client_details['email_contact2']; ?>"><?php echo $client_details['email_contact2']; ?></a></div>
                                            </div>
                                            <div class="row">
                                                <div class="col-md-3"><strong><i class="fa fa-globe"></i> Website</strong></div>
                                                <div class="col-md-4"><?php echo $client_details['website']; ?></div>
                                            </div>
                                            <div class="row">
                                                <div class="col-md-3"><strong><i class="fa fa-envelope"></i> Postal Address</strong></div>
                                                <div class="col-md-9"><?php echo $client_details['postal_address']; ?></div>
                                            </div>
                                            <div class="row">
                                                <div class="col-md-3"><strong><i class="fa fa-map-marker"></i> Physical Address</strong></div>
                                                <div class="col-md-9"><?php echo $client_details['physical_address']; ?></div>
                                            </div>
                                        </div>
                                    </div>
                                </div>
                            </div>
                            <!-- end Projects content pane -->
                            <!-- Coverage section -->
                            <div id="tab-3" class="tab-pane active">
                                <div class="col-lg-5">
									<?php 
									if(isset($_SESSION['admin']) || isset($_SESSION['management_staff'])){ ?>
                                    <div class="action-buttons">
                                        <a  data-toggle="modal" href="#projectCoverageModal"><i class="fa fa-plus"></i> Add District</a>
                                    </div>
									<?php 
									}
									?>
                                    <div class="modal fade" id="projectCoverageModal">
                                        <div class="modal-dialog">
                                            <div class="modal-content">
                                                <div class="modal-header">
                                                    <button aria-hidden="true" class="close" data-dismiss="modal" type="button">&times;</button>
                                                    <h4 class="modal-title">Project Coverage</h4>
                                                </div>
                                                <div class="modal-body">
													<?php include("add_project_coverage_modal.php"); ?>
                                                </div>
                                            </div>
                                        </div>
                                    </div>
                                    <div class="widget-content padded">
                                        <table class="table table-bordered table-striped" id="tblProjectCoverage">
                                            <thead>
                                            <th>District</th>
                                            <th>Action</th>
                                            </thead>
                                            <tbody>

                                            </tbody>
                                        </table>
                                    </div>
                                </div>
                            </div>
                            <!-- end Coverage pane -->
 						<!-- Project Affected Persons Report section -->
						<div id="tab-5" class="tab-pane ">
							<div class="col-lg-12">
								<div class="action-buttons">
									<a  data-toggle="modal" href="#papModal" data-bind="click: resetForm"><i class="fa fa-plus"></i> Add New</a>
								</div>
								<div class="modal fade col-sm-10 col-sm-offset-1" id="papModal">
									<div class="modal-content">
										<div class="modal-header">
											<button aria-hidden="true" class="close" data-dismiss="modal" type="button">&times;</button>
											<h4 class="modal-title">Project Affected Persons</h4>
										</div>
										<div class="modal-body">
										<?php include("add_pap_modal.php"); ?>
										</div>
									</div>
								</div>
							</div>
							<div class="heading">
								<i class="fa fa-group"></i>PAPs Condensed Report
							</div>
							<div class="widget-content padded">
								<table class="table table-bordered table-striped" id="tblPapCondensedReport">
									<thead>
										<tr>
											<th>PAP Ref</th>
											<th>Names</th>
											<th>District, Subcounty, Parish, Village</th>
											<th>Telephone</th>
											<th>Chainage</th>
											<?php 
											if ($projectDetails['project_category_unit'] == 2 || $projectDetails['project_category_unit'] == 4): ?>
												<th>Way Leave</th>
											<?php 
											endif;
											if ($projectDetails['project_category_unit'] == 1 || $projectDetails['project_category_unit'] == 4): ?>
												<th>Right of Way</th>
											<?php endif;
											if ($projectDetails['project_category_unit'] == 5): ?>
												<th>Total Take</th>
											<?php 
											endif;
											if ($projectDetails['project_category_unit'] == 1 || $projectDetails['project_category_unit'] == 4 || $projectDetails['project_category_unit'] == 5): ?>
												<th>Rate per Acre</th>	
												<th>Land Interest(%)</th>
											<?php endif;
											if ($projectDetails['project_category_unit'] == 4): ?>
												<th>Diminution(%)</th>
											<?php
											endif;
											/* if ($projectDetails['project_category_unit'] == 1 || $projectDetails['project_category_unit'] == 4 || $projectDetails['project_category_unit'] == 5):
											?>
												<th>Land Value(U.shs)</th>
											<?php 
											endif;  */
											?>
											<th>Tenure</th>
											<th>Tree Crops (Quantity @ Rate)</th>
											<th>Improvements (Quantity @ Rate)</th>
											
											<th>Comment</th>
											<th></th>
										</tr>
									</thead>
									<tbody>
									</tbody>
								</table>
							</div>
						</div>

						<!-- End PAP Report Section -->

                        </div>
                    </div>
                </div>
            </div>
        </div>
                <?php else: ?>
        <div class="row">
            <div class="col-lg-12">
                <div class="widget-container fluid-height clearfix">
                    <?php
                    $pap_obj = new ProjectAffectedPerson();
                    $district_obj = new Districts();
                    $county_obj = new Counties();
                    $subcounty_obj = new SubCounties();
                    $parish_obj = new Parish();
                    $village_obj = new Village();
                    $pap_crop_tree_obj = new PAP_CropTree();
                    $pap_improvement_obj = new PAP_Improvement();
                    
                    $pap_details = $pap_obj->findById($_GET['pap_id']);
                    if (!$pap_details)
                        die("The page you are looking for does not exist");
                    $pap_photos = $pap_obj->getPapPhotos("`pap_id`=" . $_GET['pap_id']); // the paps photos
                    $district_details = $district_obj->findById($pap_details['district_id']);
                    $county_details = $county_obj->findById($pap_details['county_id']);

                    $subcounty_details = $subcounty_obj->findById($pap_details['subcounty_id']);
                    $parish_details = $parish_obj->findById($pap_details['parish_id']);
                    $village_details = $village_obj->findById($pap_details['village_id']);
                    ?>
                    <div class="tabs-container" id="project_page">
                        <ul class="nav nav-tabs">
                            <li class="active"><a data-toggle="tab" href="#tab-1"><i class="fa fa-user"></i> <?= $pap_details['firstname'] ?> <?= $pap_details['lastname'] ?> <?= $pap_details['othername'] ?> - Details</a></li>
                            <?php if ($projectDetails['project_category_unit'] == 1 || $projectDetails['project_category_unit'] == 5 || $projectDetails['project_category_unit'] == 4) { ?>
                                <li><a data-toggle="tab" href="#tab-5"><i class="fa fa-globe"></i> Land</a></li>
                                <?php
                            }
                            ?>
                            <li><a data-toggle="tab" href="#tab-3"><i class="fa fa-home"></i> Improvements</a></li>
                            <li><a data-toggle="tab" href="#tab-2" ><i class="fa fa-pagelines"></i> Crops & Trees</a></li>
                            <li><a data-toggle="tab" href="#tab-4"><i class="fa fa-user"></i> Photos</a></li>
                        </ul>
                        <div class="tab-content">
                            <!-- PAP Details -->
                            <div id="tab-1" class="tab-pane active">
                                <!-- Client Details pane -->
                                <div class="col-lg-12">
                                    <div class="widget-container fluid-height clearfix">
                                        <div class="heading">
                                            <i class="fa fa-user"></i> <?= $pap_details['firstname'] ?> <?= $pap_details['lastname'] ?> <?= $pap_details['othername'] ?>
                                        </div>
                                        <div class="widget-content padded clearfix">
                                            <div class="col-md-4">
                                                <div class="col-md-2"><strong>REF#</strong></div>
                                                <div class="col-md-3"><?= $pap_details['pap_ref'] ?></div>
                                                <div class="col-md-7">&nbsp;</div>
                                                <div class="padded"><img src='img/paps/<?=$pap_details['photo_url'] ?>' class="img-thumbnail img-responsive" alt="<?= $pap_details['firstname'] ?> <?= $pap_details['lastname'] ?> <?= $pap_details['othername'] ?>" /></div>
                                            </div>
                                            <div class="col-md-8">
                                                <div class="row">
                                                    <div class="col-md-2"><strong><i class="fa fa-mobile"></i> Telephone </strong></div>
                                                    <div class="col-md-2"><a href="tel:<?php echo $pap_details['phone_contact']; ?>"><?php echo $pap_details['phone_contact']; ?></a></div>
                                                    <div class="col-md-8">&nbsp;</div>
                                                </div>
                                                <div class="row">
                                                    <div class="col-md-12"><strong><i class="fa fa-map-marker"></i> District </strong>: <?= $district_details['district_name'] ?>, 
                                                        <strong>Sub County </strong>: <?= $subcounty_details['subcounty_name'] ?>, 
                                                        <strong></i> Parish </strong>: <?= $parish_details['parish_name'] ?>, 
                                                        <strong>Village:</strong> <?= $village_details['village_name'] ?> </div>
                                                </div>
                                                <div class="row">
													<?php if ($projectDetails['project_category_unit'] == 1 || $projectDetails['project_category_unit'] == 3): ?>
                                                        <div class="col-md-2"><strong><i class="fa fa-map-marker"></i> Way Leave</strong></div>
                                                        <div class="col-md-2"><?php echo $pap_details['way_leave']; ?> acres</div>
                                                    <?php endif; ?>
													<?php if ($projectDetails['project_category_unit'] == 2 || $projectDetails['project_category_unit'] == 3): ?>
                                                        <div class="col-md-2"><strong><i class="fa fa-envelope"></i> Right of Way</strong></div>
                                                        <div class="col-md-2"><?php echo $pap_details['rightofway']; ?> acres</div>
                                                    <?php endif; ?>
													<?php if ($projectDetails['project_category_unit'] == 3): ?>
                                                        <div class="col-md-2"><strong><i class="fa fa-map-marker"></i> Total Take</strong></div>
                                                        <div class="col-md-2"><?php echo $pap_details['total_take']; ?> acres</div>
													<?php endif; ?>

                                                    <div class="col-md-2"><strong><i class="fa fa-map-marker"></i> Chainage</strong></div>
                                                    <div class="col-md-2">km <?php echo $pap_details['total_take']; ?></div>
                                                </div>
                                            </div>
                                        </div>
                                    </div>
                                </div>
                            </div>
                            <!-- end PAP Details pane -->
                            <?php if ($projectDetails['project_category_unit'] == 1 || $projectDetails['project_category_unit'] == 5 || $projectDetails['project_category_unit'] == 4) { ?>
                                <!-- Land crops section -->
                                <div id="tab-5" class="tab-pane">
                                    <div class="widget-content padded">
                                        <div class="row">
                                            <div class="col-lg-5">
                                                <div class="widget-container fluid-height clearfix">
                                                    <div class="heading">
                                                        <i class="fa fa-bars"></i>Land Valuation
                                                    </div>
                                                    <div class="widget-content padded">
                                                        <form id="tblLandPapForm" action="#" method="post" class="form-horizontal">
                                                            <input type="hidden" name="tbl" value="tblLandPap">
                                                            <input type="hidden" value="<?php echo $_GET['pap_id']; ?>" name="id" >
                                                            <?php 
															if ($projectDetails['project_category_unit'] == 1) { ?>
                                                                <div class="form-group">
                                                                    <label class="control-label col-md-4">Right of Way(Acres)</label>
                                                                    <div class="col-md-7"> 
                                                                        <?php echo $pap_details['rightofway'];
                                                                        ; ?></div>
                                                                </div>
                                                                <?php 
															} elseif ($projectDetails['project_category_unit'] == 4) {
                                                                ?>
                                                                <div class="form-group">
                                                                    <label class="control-label col-md-4">Right of Way (Acres)</label>
                                                                    <div class="col-md-7"> 
                                                                        <?php echo $pap_details['rightofway'];
                                                                        ; ?></div>
                                                                </div>
                                                                <div class="form-group">
                                                                    <label class="control-label col-md-4">Wayleave (Acres)</label>
                                                                    <div class="col-md-7">  <?php echo $pap_details['way_leave']; ?></div>
                                                                </div>
																<?php 
															} elseif ($projectDetails['project_category_unit'] == 5) {
																?>
                                                                <div class="form-group">
                                                                    <label class="control-label col-md-4">Total Take Size (Acres)</label>
                                                                    <div class="col-md-7"> 
                                                                <?php echo $pap_details['total_take']; ?></div>
                                                                </div>
                                                                <?php
                                                            }
                                                            ?>


                                                            <div class="form-group">
                                                                <label class="control-label col-md-4">Rate per Acre (U.shs)</label>
                                                                <div class="col-md-7">
                                                                    <input type="text" value="<?php echo $pap_details['rate_per_acre']; ?>" name="rate_per_acre" class="form-control athousand_separator" required >
                                                                </div>
                                                            </div>
                                                            <div class="form-group">
                                                                <label class="control-label col-md-4">Land Interest (%age)</label>
                                                                <div class="col-md-7">
                                                                    <input type="number" onkeyup="handleChange(this), checkInput(this);" name="land_interest" value="<?php echo $pap_details['land_interest']; ?>" class="form-control" required >
                                                                </div>
                                                            </div>
															<?php 
															if($projectDetails['project_category_unit'] == 2 || $projectDetails['project_category_unit'] == 4){ 
																?>
																<div class="form-group">
																	<label class="control-label col-md-4">Diminution Level (%age)</label>
																	<div class="col-md-7">
																		<input type="number"  onkeyup="handleChange(this), checkInput(this);" name="diminution_rate" value="<?php echo $pap_details['diminution_rate']; ?>"class="form-control" required >
																	</div>
																</div>
															<?php 
															}
															?>
                                                            <div class="form-group">
                                                                <label class="control-label col-md-4">&nbsp;</label>
                                                                <div class="col-md-7">
                                                                    <button class="btn btn-primary" type="submit">Submit</button>
                                                                    <button class="btn btn-default-outline" data-dismiss="modal" >Cancel </button>
                                                                </div>
                                                            </div>
                                                        </form>
                                                    </div>
                                                </div>
                                            </div>
                                        </div>
                                    </div>
                                </div>
                                <!-- end PAP crops pane -->
                                <?php
                            }
                            ?>
                            <div id="tab-2" class="tab-pane">
                                <div class="col-lg-12">
                                    <div class="action-buttons">
                                        <a  data-toggle="modal" href="#papCropModal" data-bind="click: resetForm"><i class="fa fa-plus"></i> Add New</a>
                                    </div>
                                    <div class="modal fade" id="papCropModal">
                                        <div class="modal-dialog">
                                            <div class="modal-content">
                                                <div class="modal-header">
                                                    <button aria-hidden="true" class="close" data-dismiss="modal" type="button">&times;</button>
                                                    <h4 class="modal-title">Pap Crops/Trees</h4>
                                                </div>
                                                <div class="modal-body">
    <?php include("add_pap_crop_modal.php"); ?>
                                                </div>
                                            </div>
                                        </div>
                                    </div>

                                </div>
                                <div class="heading">
                                    <i class="fa fa-group"></i>PAP crops
                                </div>
                                <div class="widget-content padded">
                                    <table class="table table-bordered table-striped" id="tblPapCrop">
                                        <thead>
                                            <tr>
                                                <th>#</th>
                                                <th>Crop</th>
                                                <th>Description</th>
                                                <th>Rate</th>
                                                <th>Quantity</th>
                                                <th>Amount</th>
                                                <th></th>
                                            </tr>
                                        </thead>
                                        <tbody>
                                        </tbody>
                                        <tfoot>
                                            <tr>
                                                <th>Total</th>
                                                <th colspan="4">&nbsp;</th>
                                                <th>Amount</th>
                                                <th></th>
                                            </tr>
                                        </tfoot>
                                    </table>
                                </div>
                            </div>
                            <!-- end PAP crops pane -->
                            <!-- PAP Improvements section -->
                            <div id="tab-3" class="tab-pane">
                                <div class="col-lg-12">
                                    <div class="action-buttons">
                                        <a  data-toggle="modal" href="#papImprovementModal"><i class="fa fa-plus"></i> Add Property</a>
                                    </div>
                                    <div class="heading">
                                        <i class="fa fa-group"></i>PAP Improvements
                                    </div>
                                    <div class="modal fade" id="papImprovementModal">
                                        <div class="modal-dialog">
                                            <div class="modal-content">
                                                <div class="modal-header">
                                                    <button aria-hidden="true" class="close" data-dismiss="modal" type="button">&times;</button>
                                                    <h4 class="modal-title">PAP Property</h4>
                                                </div>
                                                <div class="modal-body">
    <?php include("add_pap_improvements_modal.php"); ?>
                                                </div>
                                            </div>
                                        </div>
                                    </div>
                                    <div class="widget-content padded">
                                        <table class="table table-bordered table-striped" id="tblPapImprovement">
                                            <thead>
                                                <tr>
                                                    <th>#</th>
                                                    <th>Improvement</th>
                                                    <th>Description</th>
                                                    <th>Rate</th>
                                                    <th>Quantity</th>
                                                    <th>Amount</th>
                                                    <th></th>
                                                </tr>
                                            </thead>
                                            <tbody>
                                            </tbody>
                                            <tfoot>
                                                <tr>
                                                    <th>Total</th>
                                                    <th colspan="4">&nbsp;</th>
                                                    <th>Amount</th>
                                                    <th></th>
                                                </tr>
                                            </tfoot>
                                        </table>
                                    </div>
                                </div>
                            </div>
                            <!-- end PAP Improvements pane -->
                            <!-- PAP Photos section -->
                            <div id="tab-4" class="tab-pane">
                                <div class="col-lg-12">
                                    <div class="action-buttons">
                                        <a  data-toggle="modal" href="#papPhotosModal"><i class="fa fa-plus"></i> Add Photos</a>
                                    </div>
                                    <div class="heading">
                                        <i class="fa fa-group"></i>PAP Photos
                                    </div>
                                    <div class="modal fade" id="papPhotosModal">
                                        <div class="col-md-8 col-md-offset-2">
                                            <div class="modal-content">
                                                <div class="modal-header">
                                                    <button aria-hidden="true" class="close" data-dismiss="modal" type="button">&times;</button>
                                                    <h4 class="modal-title">PAP Photos</h4>
                                                </div>
                                                <div class="modal-body">
    <?php include("add_pap_photo.php"); ?>
                                                </div>
                                            </div>
                                        </div>
                                    </div>
                                    <div class="widget-content padded">
                                        <!--ko foreach: $root.serverPapPhotos-->
                                        <div class="col-md-3">
                                            <div class="img-thumbnail">
                                                <a href='#' data-bind="confirmClick: { message: 'Are you sure?', click: $root.removeServerPapPhoto }" class="pull-right" title="Delete this photo"><span class="fa fa-times danger"></span></a>
                                                <a  href="" data-toggle="modal" data-bind="attr: {'data-target':'#pap_photo'+$index()}" ><img data-bind="attr: {src: 'img/paps/pap_'+pap_id+'/'+file_name}" class="img-responsive img-thumbnail" /></a>

                                                <hr/>
                                                <p data-bind="text:description, click: $root.openTextArea" title="Click to edit"></p>
                                                <textarea class="form-control hideit" data-bind="value:description, event: {blur: $root.hideTextArea}" placeholder="Caption this photo"></textarea>
                                            </div>
                                            <div class="modal fade" tabindex="-1" data-bind="attr: {'id':'#pap_photo'+$index()}" role="dialog" aria-hidden="true">
                                                <div class="modal-dialog modal-xl">
                                                    <div class="modal-content">
                                                        <div class="modal-header">
                                                            <button aria-hidden="true" class="close" data-dismiss="modal" type="button">&times;</button>
                                                        </div>
                                                        <div class="modal-body">
                                                            <div class="img-thumbnail" style="text-align:center;">
                                                                <img data-bind="attr: {src: 'img/paps/pap_'+pap_id+'/'+file_name}" class="img-responsive img-thumbnail" />
                                                                <hr/>
                                                                <p data-bind="text:description, click: $root.openTextArea" title="Click to edit"></p>
                                                                <textarea class="form-control hideit" data-bind="value:description, event: {blur: $root.hideTextArea}" placeholder="Caption this photo"></textarea>
                                                            </div>
                                                        </div>
                                                    </div>
                                                </div>
                                            </div>
                                        </div>
                                        <!--ko if: (($index()+1)%4==0||($index()+1)==$root.serverPapPhotos.length) -->
                                        <div class="clearfix" style="border-top:5px;"></div><!-- close the row tag-->
                                        <!--/ko-->
                                        <!--/ko-->
                                    </div>
                                </div>
                            </div>
                            <!-- end PAP Photos pane -->
                        </div>
                    </div>
                </div>
            </div>
        </div>

<?php endif; ?>
</div>
<?php
include("js/project_details_js.php");
include("includes/footer.php");
?>
