<?php
$needed_files = array("dataTables", "iCheck", "jasny", "knockout", "moment");
include("includes/header.php");
?>
<div class="container-fluid main-content">
	<div class="page-title"><h4>General Administration</h4></div>
	<div class="row">
		<div class="col-lg-12">
			<div class="widget-container fluid-height clearfix">
				<div class="tabs-container">
					<ul class="nav nav-tabs">
						<li class="active"><a data-toggle="tab" href="#tab-2"><i class="fa fa-group"></i> Staff</a></li>
						<li><a data-toggle="tab" href="#tab-3"><i class="fa fa-globe"></i> Coverage</a></li>
					</ul>
					<div class="tab-content">
						<!-- Project Affected Persons section -->
						<div id="tab-2" class="tab-pane active">
							<div class="col-lg-12">
								<div class="action-buttons">
									<a  data-toggle="modal" href="#staffModal"><i class="fa fa-plus"></i> Add New</a>
								</div>
								<div class="modal fade col-sm-7 col-sm-offset-2" id="staffModal">
									<div class="modal-content">
										<div class="modal-header">
											<button aria-hidden="true" class="close" data-dismiss="modal" type="button">&times;</button>
											<h4 class="modal-title">Add Staff</h4>
										</div>
										<div class="modal-body">
											<?php include("add_staff_modal.php"); ?>
										</div>
									</div>
								</div>
							
							</div>
							<div class="heading">
								<i class="fa fa-group"></i>Staff Details
							</div>
							<div class="widget-content padded">
								<table class="table table-bordered table-striped" id="tblStaff">
									<thead>
										<th>Staff Type</th>
										<th>Name</th>
										<th>Position</th>
										<th>Email</th>
										<th>Phone Contact</th>
										<th>Phone Contact 2</th>
										<th>Address</th>
										<th>Date Added</th>
										<th></th>
									</thead>
									<tbody>
										
									</tbody>
								</table>
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
											</div>
										</div>
									</div>
								</div>
								<div class="widget-content padded">
									<table class="table table-bordered table-striped" id="tblProjectCoverage">
										<thead>
											<th>District</th>
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
include("js/administration_js.php");
include("includes/footer.php");

?>