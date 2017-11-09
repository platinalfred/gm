<?php 
$needed_files = array("dataTables", "iCheck", "jasny", "knockout", "moment");
include("includes/header.php");
?>

<div class="container-fluid main-content">
	<div class="page-title"><h1>Projects</h1></div>
	<div class="row">
		<div class="action-buttons">
			<a  data-toggle="modal" href="#myModal"><i class="fa fa-plus"></i> Add New</a>
		</div>
		<div class="modal fade" id="myModal">
			<div class="modal-dialog">
				<div class="modal-content">
					<div class="modal-header">
						<button aria-hidden="true" class="close" data-dismiss="modal" type="button">&times;</button>
						<h4 class="modal-title">Land Acess Project</h4>
					</div>
					<div class="modal-body">
						<?php include("add_land_project_modal.php"); ?>
					</div>
				</div>
			</div>
		</div>
	</div>
	<!-- DataTables Example -->
	<div class="row">
		<div class="col-lg-12">
            <div class="widget-container fluid-height clearfix">
				<div class="heading">
					<i class="fa fa-table"></i>Project details
				</div>
				<div class="widget-content padded clearfix">
					<table class="table table-bordered table-striped" id="landAccessTable">
						<thead>
							<th >Title</th>
							<th>Client Name</th>
							<th class="hidden-xs">Project Reference</th>
							<th class="hidden-xs">Project Category</th>
							<th class="hidden-xs">Project Category Unit</th>
							<th class="hidden-xs">Date Added</th>
							<th></th>
						</thead>
						<tbody>
							
						</tbody>
					</table>
				</div>
            </div>
		</div>
	</div>
      <!-- end DataTables Example -->
</div>
<?php
include("js/land_access_project.php");
include("includes/footer.php");

?>