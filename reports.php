<?php
$needed_files = array("dataTables", "iCheck", "jasny", "knockout", "select2", "moment");
include("includes/header.php");
?>
<div class="container-fluid main-content">
	<div class="page-title" > <h4 >Reports</h4> </div>
	<div style="clear:float;"></div>
	<div class="row">
		<div class="col-lg-12">
			<div class="widget-container fluid-height clearfix">
				<div class="tabs-container" id="project_page">
					<ul class="nav nav-tabs">
						<li class="active"><a data-toggle="tab" href="#tab-3"><i class="fa fa-globe"></i> Coverage</a></li>
						<li ><a data-toggle="tab" href="#tab-1"><i class="fa fa-group"></i> PAPs</a></li>
						<li><a data-toggle="tab" href="#tab-2" ><i class="fa fa-briefcase"></i> Client</a></li>
						
					</ul>
					<div class="tab-content">
						<!-- Project Affected Persons section -->
						<div id="tab-1" class="tab-pane ">
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
										<tr>
											<th>PAP Ref</th>
											<th>Names</th>
											<th>District</th>
											<!--th>County</th>
											<th>SubCounty</th>
											<th>Parish</th-->
											<th>Village</th>
											<th>Telephone</th>
											<?php if( $projectDetails['project_category_unit'] == 2 || $projectDetails['project_category_unit'] == 4 ):?>
											<th>Way Leave</th>
											<?php endif;?>
											<?php if( $projectDetails['project_category_unit'] == 1 || $projectDetails['project_category_unit'] == 4 ):?>
											<th>Right of Way</th>
											<?php endif;?>
											<?php if( $projectDetails['project_category_unit'] == 5 ):?>
											<th>Total Size</th>
											<?php endif;?>
											<th>Chainage</th>
											<th>Improvements</th>
											<th>Crops/Trees</th>
											<th></th>
										</tr>
									</thead>
									<tbody>
									</tbody>
									<tfoot>
										<tr>
											<th>Total</th>
											<th colspan="4">&nbsp;</th>
											<?php if( $projectDetails['project_category_unit'] == 2 || $projectDetails['project_category_unit'] == 4 ):?>
											<th>0</th>
											<?php endif;?>
											<?php if( $projectDetails['project_category_unit'] == 1 || $projectDetails['project_category_unit'] == 4 ):?>
											<th>0</th>
											<?php endif;?>
											<?php if( $projectDetails['project_category_unit'] == 5 ):?>
											<th>0</th>
											<?php endif;?>
											<th>&nbsp;</th>
											<th>0</th>
											<th>0</th>
											<th>&nbsp;</th>
										</tr>
									</tfoot>
								</table>
							</div>
						</div>
						<!-- end Projects content pane -->
						<!-- Projects -->
						<div id="tab-2" class="tab-pane ">
							<!-- Client Details pane -->
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
</div>
<?php
include("js/project_details_js.php");
include("includes/footer.php");

?>