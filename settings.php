<?php 
$show_main = false;
$needed_files = array("dataTables", "iCheck", "jasny", "knockout", "moment");
include("includes/header.php");
?>
<div class="container-fluid main-content">
	<div class="page-title">
		<h1>Settings</h1>
	</div>
	<div class="row">
		<div class="col-lg-12">
			<div class="widget-container fluid-height clearfix">
				<div class="tabs-container">
					<ul class="nav nav-tabs">
						<li class="active"><a data-toggle="tab" href="#tab-1" >Land Acquisition Categories</a></li>
						<li><a data-toggle="tab" href="#tab-2" >Land Acquisition Types</a></li>
						<li class=""><a data-toggle="tab"  href="#tab-9" >Access Levels</a></li>
						<li><a data-toggle="tab" href="#tab-23" >Positions</a></li>
						<li><a data-toggle="tab" href="#tab-17" >Expense Types</a></li>
						<!--<li class=""><a data-toggle="tab" href="#tab-2" href="#">Account Types</a></li>-->
						<li class=""><a data-toggle="tab" href="#tab-3" >Tree or Crop Types</a></li>
						<li class=""><a data-toggle="tab" href="#tab-5" >Crop Description</a></li>
						<li class=""><a data-toggle="tab"  href="#tab-7" href="#">Income Sources</a></li>
						<li class=""><a data-toggle="tab"  href="#tab-8" href="#">Individual Types</a></li>
						<li class="dropdown">
							<a class="dropdown-toggle" data-toggle="dropdown" href="#">More <b class="caret"></b></a>
							<ul class="dropdown-menu">
								<!--<li class=""><a data-toggle="tab" role="tab" href="#tab-11" href="#">Loan Types</a></li>-->
								
								
								<!--<li class=""><a data-toggle="tab" role="tab" href="#tab-15" href="#">Repayment Duration</a></li> -->
								<li class=""><a role="tab" data-toggle="tab" href="#tab-6" >Id Card Types</a></li>
								<li class=""><a data-toggle="tab" role="tab" href="#tab-16" href="#">Security Types</a></li>
								
								<!--<li class=""><a data-toggle="tab" role="tab" href="#tab-18" href="#">Address Type</a></li>-->
								<li class=""><a data-toggle="tab" role="tab" href="#tab-19" href="#">Marital Status</a></li>
								<li class=""><a data-toggle="tab" role="tab" href="#tab-22" href="#">Expense Type</a></li>
							</ul>
						</li>
					</ul>
					<div class="tab-content">
						<!-- Land access category -->
						<div id="tab-1" class="tab-pane active">
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
								<table class="table table-bordered table-striped" id="land_acquistion_category">
									<thead>
										<th >Title</th>
										<th>Description</th>
										<th></th>
									</thead>
									<tbody>
										
									</tbody>
								</table>
							</div>
						</div>
						<!-- End Land Access Category -->
						<!---  Land Access Category Unit   --->
						<div id="tab-2" class="tab-pane">
							<div class="col-lg-12">
								<div class="action-buttons">
									<a  data-toggle="modal" href="#categoryUnitModal"><i class="fa fa-plus"></i> Add New</a>
								</div>
								<div class="modal fade" id="categoryUnitModal">
									<div class="modal-dialog">
										<div class="modal-content">
											<div class="modal-header">
												<button aria-hidden="true" class="close" data-dismiss="modal" type="button">&times;</button>
												<h4 class="modal-title">Land Acquisition Category Unit</h4>
											</div>
											<div class="modal-body">
												<?php include("add_acquisition_category_unit.php"); ?>
											</div>
										</div>
									</div>
								</div>
							
							</div>
							<div class="heading">
								<i class="fa fa-bars"></i>Land Acquisition Category Unit
							</div>
							<div class="widget-content padded">
								<table class="table table-bordered table-striped" id="land_acquistion_category_unit">
									<thead>
										<th>Title</th>
										<th>Category</th>
										<th>Description</th>
										<th></th>
									</thead>
									<tbody>
										
									</tbody>
								</table>
							</div>
						
						</div>
						
						<div id="tab-3" class="tab-pane">
						</div>
						<!-- Access Level -->
						<div id="tab-5" class="tab-pane ">
						</div>
						<!-- Id Card Type-->
						<div id="tab-6" class="tab-pane ">
						</div>
						<!-- Income Source -->
						<div id="tab-7" class="tab-pane ">
						</div>
						<!-- Individual Type -->
						<div id="tab-8" class="tab-pane ">
						</div>
						<!-- Access Level -->
						<div id="tab-9" class="tab-pane">
							<div class="panel-body">
								<div class="col-lg-2 col-offset-sm-8">
									<div class="action-buttons">
										<a  data-toggle="modal" href="#access_level"><i class="fa fa-plus"></i> Add New</a>
									</div>
									<div id="access_level" class="modal fade" aria-hidden="true">
										<div class="modal-dialog">
											<div class="modal-content">
												<div class="modal-body">
													<div class="row">
														<div class="col-sm-12">
															<p>Add Access Level.</p>
															<div class="ibox-content">
																<form class="form-horizontal" method="post" id="tblAccessLevel">
																	<input type="hidden" name="tbl" value="access_level">
																	<input type="hidden" name="id" value="access_level">
																	<div class="form-group"><label class="col-lg-2 control-label">Name</label>

																		<div class="col-lg-10"><input name="name" type="text" placeholder="Name" class="form-control"> <span class="help-block m-b-none">Access Level name (e.g Administrator).</span>
																		</div>
																	</div>
																	<div class="form-group"><label class="col-lg-2 control-label">Description</label>
																		<div class="col-lg-10"><textarea name="description" placeholder="Description" class="form-control"></textarea></div>
																	</div>
																	<div class="form-group">
																		<div class="col-lg-offset-2 col-lg-10">
																			<button class="btn btn-sm btn-primary save" type="button">Submit</button>
																		</div>
																	</div>
																</form>
															</div>
														</div>
														
													</div>
												</div>
											</div>
										</div>
									</div>
								</div>
								<div class="col-lg-12" style="margin-top:10px;">
									<div class="ibox-content">
										<div class="table-responsive">
											<table class="table table-striped table-bordered table-hover" id="access_levels" >
												<thead>
												<tr>
													<th>Name</th>
													<th>Description</th>
													<th></th>
												</tr>
												</thead>
												<tbody>
													
												</tbody>
												<tfoot>
													<tr>
														<th>Name</th>
														<th>Description</th>
														<th></th>
													</tr>
												</tfoot>
											</table>
										</div>
									</div>
								</div>
								
							</div>
						</div>
						<!---  Position   --->
						<div id="tab-23" class="tab-pane">
							<div class="panel-body">
								<div class="col-lg-2 col-offset-sm-8">
									<div class="action-buttons">
										<a  data-toggle="modal" href="#position"><i class="fa fa-plus"></i> Add New</a>
									</div>
									<div id="position" class="modal fade" aria-hidden="true">
										<div class="modal-dialog">
											<div class="modal-content">
												<div class="modal-body">
													<div class="row">
														<div class="col-sm-12">
															<p>Add /Update Position</p>
															<div class="ibox-content">
																<form class="form-horizontal" id="tblPosition">
																	<input type="hidden" name="id" >
																	<input type="hidden" name="tbl"  value="position">
																	<div class="form-group"><label class="col-lg-2 control-label">Name</label>
																		<div class="col-lg-10"><input type="text" name="name" placeholder="Name" class="form-control"> 
																		</div>
																	</div>
																	<div class="item form-group">
																		<label class="control-label col-md-3 col-sm-3 col-xs-12 no_padding" for="id_type">Access Level <span class="required">*</span>
																		</label>
																		<div class="col-md-9 col-sm-9 col-xs-12">
																			<select class="form-control m-b" name="access_level" required >
																				<option>Please select</option>
																				<?php 
																				$access_level = new AccessLevel();
																				$access_level = $access_level->findAll();
																				if($access_level){
																					foreach($access_level as $single){ ?>
																						<option value="<?php echo $single['id']; ?>" ><?php echo $single['name']; ?></option>
																						<?php
																					}
																				}
																				?>
																			</select>
																		</div>
																	</div>
																	<div class="form-group"><label class="col-lg-2 control-label">Description</label>
																		<div class="col-lg-10"><textarea  name="description" placeholder="Description" class="form-control"></textarea></div>
																	</div>
																	<div class="form-group">
																		<div class="col-lg-offset-2 col-lg-10">
																			<button class="btn btn-sm btn-primary save" type="button">Submit</button>
																		</div>
																	</div>
																</form>
															</div>
														</div>
														
													</div>
												</div>
											</div>
										</div>
									</div>
								</div>
								<div class="col-lg-12" style="margin-top:10px;">
									<div class="ibox-content">
										<div class="table-responsive">
											<table class="table table-striped table-bordered table-hover" id="positions">
												<thead>
												<tr>
													<th>Name</th>
													<th>Access Level</th>
													<th>Description</th>
													<th></th>
												</tr>
												</thead>
												<tbody></tbody>
												<tfoot>
													<tr>
														<th>Name</th>
														<th>Access Level</th>
														<th>Description</th>
														<th></th>
													</tr>
												</tfoot>
											</table>
										</div>
									</div>
								</div>
							</div>
						</div>
						<!-- End Position -->
						<!-- Expense Type -->
						<div id="tab-17" class="tab-pane">
							<div class="panel-body">
								<div class="col-lg-2 col-offset-sm-8">
									<div class="action-buttons">
										<a  data-toggle="modal" href="#expense_type"><i class="fa fa-plus"></i> Add New</a>
									</div>
									<div id="expense_type" class="modal fade" aria-hidden="true">
										<div class="modal-dialog">
											<div class="modal-content">
												<div class="modal-body">
													<div class="row">
														<div class="col-sm-12">
															<p>Expense Type</p>
															<div class="ibox-content">
																<form class="form-horizontal" id="tblExpenseType">
																	<input type="hidden" name="tbl"  value="expense_type">
																	<input type="hidden" name="id" id="id_field">
																	<div class="form-group"><label class="col-lg-2 control-label">Name</label>
																		<div class="col-lg-10"><input type="text" name="name" placeholder="Expense Type" class="form-control"> 
																		</div>
																	</div>
																	<div class="form-group"><label class="col-lg-2 control-label">Description</label>
																		<div class="col-lg-10"><textarea  name="description" placeholder="Description" class="form-control"></textarea></div>
																	</div>
																	<div class="form-group">
																		<div class="col-lg-offset-2 col-lg-10">
																			<button class="btn btn-sm btn-primary save" type="button">Submit</button>
																		</div>
																	</div>
																</form>
															</div>
														</div>
														
													</div>
												</div>
											</div>
										</div>
									</div>
									
								</div>
								<div class="col-lg-12" style="margin-top:10px;">
									<div class="ibox-content">
										<div class="table-responsive">
											<table class="table table-striped table-bordered table-hover" id="expense_types">
												<thead>
												<tr>
													<th>Name</th>
													<th>Description</th>
													<th>Edit / Delete</th>
												</tr>
												</thead>
												<tbody></tbody>
												<tfoot>
													<tr>
														<th>Name</th>
														<th>Description</th>
														<th></th>
													</tr>
												</tfoot>
											</table>
										</div>
									</div>
								</div>
								
							</div>
						</div>
						<!-- End Expense Type-->
						<!-- Penalty Calculation Method Start -->		
						<div id="tab-12" class="tab-pane ">
						</div>
						<!--End Loan Product penality-->
						
						<div id="tab-14" class="tab-pane">
						</div>
						<!-- End Security Type-->
						<!-- Security Type-->
						<div id="tab-16" class="tab-pane">
						</div>
						<!-- End Security Type-->
						
						<!-- Adress Type -->
						<div id="tab-18" class="tab-pane">
						</div>
						<!-- End Adress Type -->
						<!-- Marital Status -->
						<div id="tab-19" class="tab-pane">
						</div>
						<!-- End Marital Status -->
						<!-- Expense Type -->
						<div id="tab-22" class="tab-pane">
						</div>
						<!-- End Marital Status -->
						
						<!-- Deposit Products -->
						<div id="tab-21" class="tab-pane">
						</div>
						<!-- End Deposit Products -->
					</div>
				</div>
			</div>
		</div>
	</div>
</div>

<?php
include("js/settings_js.php"); 
include("includes/footer.php");
?>
