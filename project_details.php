<?php
$needed_files = array("dataTables", "iCheck", "jasny", "knockout", "select2", "moment");
include("includes/header.php");
?>
<?php
if(!isset($_GET['id']))
	header('Location: error_404.php');
require_once('lib/LandAcquisition.php');
$land_acquisition_object = new LandAcquisition();
$projectDetails = $land_acquisition_object->findById($_GET['id']);
//if the request comes up empty, redirect to the invalid page-title
if(!$projectDetails)
	header("Location: error_404.php");
?>
<div class="container-fluid main-content">
	<div class="page-title"><h4><a href="project_details.php?id=<?=$_GET['id']?>"><?php echo $projectDetails['project_title']; ?></a></h4></div>
	<?php if(!isset($_GET['pap_id'])):?>
	<div class="row">
		<div class="col-lg-12">
			<div class="widget-container fluid-height clearfix">
				<div class="tabs-container" id="project_page">
					<ul class="nav nav-tabs">
						<li class="active"><a data-toggle="tab" href="#tab-1"><i class="fa fa-group"></i> PAPs</a></li>
						<li><a data-toggle="tab" href="#tab-2" ><i class="fa fa-briefcase"></i> Client</a></li>
						<li><a data-toggle="tab" href="#tab-3"><i class="fa fa-globe"></i> Coverage</a></li>
					</ul>
					<div class="tab-content">
						<!-- Project Affected Persons section -->
						<div id="tab-1" class="tab-pane active">
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
								<i class="fa fa-group"></i>Project Affected Persons
							</div>
							<div class="widget-content padded">
								<table class="table table-bordered table-striped" id="tblPap">
									<thead>
										<th>PAP Ref</th>
										<th>Names</th>
										<th>District</th>
										<!--th>County</th>
										<th>SubCounty</th>
										<th>Parish</th-->
										<th>Village</th>
										<th>Telephone</th>
										<th>Way Leave</th>
										<th>Right of Way</th>
										<th>Total Size</th>
										<th>Chainage</th>
										<th>Improvements</th>
										<th>Crops/Trees</th>
										<th></th>
									</thead>
									<tbody>
										
									</tbody>
								</table>
							</div>
						</div>
						<!-- end Projects content pane -->
						<!-- Projects -->
						<div id="tab-2" class="tab-pane">
							<!-- Client Details pane -->
							<?php 
								//retrieve the client's details
								require_once('lib\Client.php');
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
						<div id="tab-3" class="tab-pane">
							<div class="col-lg-5">
								<div class="action-buttons">
									<a  data-toggle="modal" href="#projectCoverageModal"><i class="fa fa-plus"></i> Add District</a>
								</div>
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
					</div>
				</div>
			</div>
		</div>
	</div>
	<?php else:?>
	<div class="row">
		<div class="col-lg-12">
			<div class="widget-container fluid-height clearfix">
				<?php
					$pap_obj = new ProjectAffectedPerson();
					$district_obj = new Districts();
					/* $county_obj = new County();
					$subcounty_obj = new SubCounty();
					$parish_obj = new Parish(); */
					$pap_details = $pap_obj->findById($_GET['pap_id']);
					if(!$pap_details)
						die("The page you are looking for does not exist");
					$district_details = $district_obj->findById($pap_details['district_id']);
				?>
				<div class="tabs-container" id="project_page">
					<ul class="nav nav-tabs">
						<li class="active"><a data-toggle="tab" href="#tab-1"><i class="fa fa-user"></i> <?=$pap_details['firstname']?> <?=$pap_details['lastname']?> <?=$pap_details['othername']?> - Details</a></li>
						<li><a data-toggle="tab" href="#tab-2" ><i class="fa fa-briefcase"></i> Crops</a></li>
						<li><a data-toggle="tab" href="#tab-3"><i class="fa fa-home"></i> Improvements</a></li>
						<li><a data-toggle="tab" href="#tab-4"><i class="fa fa-user"></i> Photos</a></li>
					</ul>
					<div class="tab-content">
						<!-- PAP Details -->
						<div id="tab-1" class="tab-pane active">
							<!-- Client Details pane -->
							<div class="col-lg-12">
								<div class="widget-container fluid-height clearfix">
									<div class="heading">
										<i class="fa fa-user"></i> <?=$pap_details['firstname']?> <?=$pap_details['lastname']?> <?=$pap_details['othername']?>
									</div>
									<div class="widget-content padded clearfix">
										<div class="col-md-4">
												<div class="col-md-2"><strong>REF#</strong></div>
												<div class="col-md-3"><?=$pap_details['pap_ref']?></div>
												<div class="col-md-7">&nbsp;</div>
											<div class="padded"><img src='img/paps/pap_<?=$pap_details['id']?>.jpg' class="img-thumbnail img-responsive" alt="<?=$pap_details['firstname']?> <?=$pap_details['lastname']?> <?=$pap_details['othername']?>" /></div>
										</div>
										<div class="col-md-8">
											<div class="row">
												<div class="col-md-2"><strong><i class="fa fa-mobile"></i> Telephone </strong></div>
												<div class="col-md-2"><a href="tel:<?php echo $pap_details['phone_contact']; ?>"><?php echo $pap_details['phone_contact']; ?></a></div>
												<div class="col-md-8">&nbsp;</div>
											</div>
											<div class="row">
												<div class="col-md-2"><strong><i class="fa fa-map-marker"></i> District </strong></div>
												<div class="col-md-2"><?=$district_details['district_name']?></div>
												<div class="col-md-2"><strong>Village:</strong> </div>
												<div class="col-md-2"><?=$pap_details['village']?></div>
												<div class="col-md-4" id="<?php=$pap_details['subcounty_id']; ?><?=$pap_details['parish_id']?>">&nbsp;
												</div>
											</div>
											<div class="row">
											<?php if( $projectDetails['project_category_unit'] == 1 || $projectDetails['project_category_unit'] == 3 ):?>
												<div class="col-md-2"><strong><i class="fa fa-map-marker"></i> Way Leave</strong></div>
												<div class="col-md-2"><?php echo $pap_details['way_leave']; ?> acres</div>
											<?php endif;?>
											<?php if( $projectDetails['project_category_unit'] == 2 || $projectDetails['project_category_unit'] == 3 ):?>
												<div class="col-md-2"><strong><i class="fa fa-envelope"></i> Right of Way</strong></div>
												<div class="col-md-2"><?php echo $pap_details['rightofway']; ?> acres</div>
											<?php endif;?>
											<?php if( $projectDetails['project_category_unit'] == 3 ):?>
												<div class="col-md-2"><strong><i class="fa fa-map-marker"></i> Total Take</strong></div>
												<div class="col-md-2"><?php echo $pap_details['total_take']; ?> acres</div>
											<?php endif;?>
												<div class="col-md-2"><strong><i class="fa fa-map-marker"></i> Chainage</strong></div>
												<div class="col-md-2">km <?php echo $pap_details['total_take']; ?></div>
											</div>
										</div>
									</div>
								</div>
							</div>
						</div>
						<!-- end PAP Details pane -->
						<!-- PAP crops section -->
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
										<th>#</th>
										<th>Crop</th>
										<th>Description</th>
										<th>Rate</th>
										<th>Quantity</th>
										<th>Amount</th>
										<th></th>
									</thead>
									<tbody>
									</tbody>
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
											<th>#</th>
											<th>Improvement</th>
											<th>Description</th>
											<th>Rate</th>
											<th>Quantity</th>
											<th>Amount</th>
											<th></th>
										</thead>
										<tbody>
											
										</tbody>
									</table>
								</div>
							</div>
						</div>
						<!-- end PAP Improvements pane -->
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