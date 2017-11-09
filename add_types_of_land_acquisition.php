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
				<div class="heading">
					<i class="fa fa-bars"></i>Land Acquisition Categories
				</div>
				<div class="widget-content padded">
					<form action="#" class="form-horizontal">
						<div class="form-group">
							<label class="control-label col-md-2">Title</label>
							<div class="col-md-7">
							  <input class="form-control" placeholder="Text" type="text">
							</div>
						</div>
						<div class="form-group">
							<label class="control-label col-md-2">Land Acquisition Category</label>
							<div class="col-md-7">
								<select class="select2able">
									<option value="Category 1">Option 1</option><option value="Category 2">Option 2</option><option value="Category 3">Option 3</option><option value="Category 4">Option 4</option>
								</select>
							</div>
						</div>
						<div class="form-group">
							<label class="control-label col-md-2">Description</label>
							<div class="col-md-7">
							  <textarea class="form-control" rows="3"></textarea>
							</div>
						</div>
						<div class="form-group">
							<label class="control-label col-md-2"></label>
							<div class="col-md-7">
							  <button class="btn btn-primary" type="submit">Submit</button>
							  <button class="btn btn-default-outline">Cancel</button>
							</div>
						</div>
					</form>
				</div>
			</div>
		</div>
	</div>
</div>
<?php 
include("include/footer.php");
?>