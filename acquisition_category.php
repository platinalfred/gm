<?php 
include("include/header.php");
?>
<div class="container-fluid main-content">
	<div class="page-title">
		<h1>Settings</h1>
	</div>
	<div class="row">
		<div class="col-lg-12">
			
			<div class="widget-container fluid-height clearfix">
				
				<div class="col-lg-12">
					<div class="action-buttons">
						<a  data-toggle="modal" href="#categoryModal"><i class="fa fa-plus"></i> Add New</a>
					</div>
					<div class="modal fade" id="categoryModal">
						<div class="modal-dialog">
							<div class="modal-content">
								<div class="modal-header">
									<button aria-hidden="true" class="close" data-dismiss="modal" type="button">&times;</button>
									<h4 class="modal-title">Land Acquisition Category</h4>
								</div>
								<div class="modal-body">
									<?php include("add_acquisition_category.php"); ?>
								</div>
							</div>
						</div>
					</div>
				
				</div>
				<div class="heading">
					<i class="fa fa-bars"></i>Land Acquisition Categories
				</div>
				<div class="widget-content padded">
					<table class="table table-bordered table-striped" id="dataTable1">
						<thead>
							<th >Title</th>
							<th>Client Name</th>
							<th></th>
						</thead>
						<tbody>
							
						</tbody>
					</table>
				</div>
			</div>
		</div>
	</div>
</div>
<?php 
include("include/footer.php");
?>