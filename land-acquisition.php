<?php 
$needed_files = array("dataTables", "iCheck", "jasny", "knockout", "moment");
include("includes/header.php");
?>

<div class="container-fluid main-content">
	<div class="page-title"><h1>Projects</h1></div>
	<div class="row">
		<div class="col-lg-12">
			<div class="widget-container fluid-height clearfix">
				<div class="tabs-container">
					<ul class="nav nav-tabs">
						<li class="active"><a data-toggle="tab" href="#tab-1"><i class="fa fa-list"></i> Projects</a></li>
						<li><a data-toggle="tab" href="#tab-2" ><i class="fa fa-briefcase"></i> Clients</a></li>
					</ul>
					<div class="tab-content">
						<!-- Projects -->
						<div id="tab-1" class="tab-pane active">
							<div class="col-lg-12">
								<div class="action-buttons">
									<a  data-toggle="modal" href="#projectModal"><i class="fa fa-plus"></i> Add New</a>
								</div>
								<div class="modal fade" id="projectModal">
									<div class="modal-dialog">
										<div class="modal-content">
											<div class="modal-header">
												<button aria-hidden="true" class="close" data-dismiss="modal" type="button">&times;</button>
												<h4 class="modal-title">Land Acess Project</h4>
											</div>
											<div class="modal-body">
												<?php include_once("add_land_project_modal.php"); ?>
											</div>
										</div>
									</div>
								</div>
							</div>
							<!-- Projects content pane -->
							<div class="col-lg-12">
								<div class="widget-container fluid-height clearfix">
									<div class="heading">
										<i class="fa fa-list"></i>Projects details
									</div>
									<div class="widget-content padded clearfix">
										<table class="table table-bordered table-striped non_responsive" id="tblLandProject">
											<thead>
												<th >Title</th>
												<th>Client Name</th>
												<th class="hidden-xs">Project Reference</th>
												<th class="hidden-xs">Project Category</th>
												<th class="hidden-xs">Disturbance Allowance</th>
												<th class="hidden-xs">Date Added</th>
												<?php 
												if(isset($_SESSION['admin']) || isset($_SESSION['management_staff'])){ ?>
												<th class="hidden-xs">Report</th>
												<th></th>
												<?php 
												}
												?>
												
											</thead>
											<tbody>
												
											</tbody>
										</table>
									</div>
								</div>
							</div>
						</div>
						<!-- end Projects content pane -->
						<!-- Clients section -->
						<div id="tab-2" class="tab-pane">
							<div class="col-lg-12">
								<?php 
								if(isset($_SESSION['admin']) || isset($_SESSION['management_staff'])){ ?>
									<div class="action-buttons">
										<a  data-toggle="modal" href="#clientModal"><i class="fa fa-plus"></i> Add New</a>
									</div>
								<?php 
								}
								?>
								<div class="modal fade" id="clientModal">
									<div class="modal-dialog">
										<div class="modal-content">
											<div class="modal-header">
												<button aria-hidden="true" class="close" data-dismiss="modal" type="button">&times;</button>
												<h4 class="modal-title">Clients</h4>
											</div>
											<div class="modal-body">
												<?php include("add_client_modal.php"); ?>
											</div>
										</div>
									</div>
								</div>
							
							</div>
							<?php 
							if(isset($_SESSION['admin']) || isset($_SESSION['management_staff'])){ ?>
								<div class="heading">
									<i class="fa fa-briefcase"></i>Clients
								</div>
								<div class="widget-content padded">
									<table class="table table-bordered table-striped" id="tblClient">
										<thead>
											<th>Client</th>
											<th>Postal Address</th>
											<th>Physical Address</th>
											<th>Telephone</th>
											<th>Telephone 2</th>
											<th>Email</th>
											<th>Email 2</th>
											<th></th>
										</thead>
										<tbody>
											
										</tbody>
									</table>
								</div>
							<?php 
							}
							?>
						</div>
						<!-- end Projects content pane -->
					</div>
				</div>
			</div>
		</div>
	</div>
</div>
<?php
include("js/land_access_project.php");
include("includes/footer.php");

?>