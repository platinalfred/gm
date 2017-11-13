<?php 
$show_main = false;
$needed_files = array("dataTables", "iCheck", "jasny", "knockout", "moment");
include("includes/header.php");
$tree_crop_description = new TreeCropTypesDescription();
$districts = new Districts();
$propertytypedescription = new PropertyTypeDescription();
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
						
						<li  class="active"><a data-toggle="tab" href="#tab-2" >Land Acquisition Types</a></li>
						<li class=""><a data-toggle="tab" href="#tab-3" >Tree or Crop Types</a></li>
						<li><a data-toggle="tab" href="#tab-5" >Crop Description</a></li>
						
						<li class=""><a data-toggle="tab" role="tab" href="#tab-11" href="#">District Crop/Tree Rates</a></li>
						<li class=""><a data-toggle="tab"  href="#tab-7" href="#">Property Description</a></li>
						<li class=""><a data-toggle="tab"  href="#tab-8" href="#">Property</a></li>
						<li class=""><a data-toggle="tab"  href="#tab-9" >Access Levels</a></li>
						<li><a data-toggle="tab" href="#tab-23" >Positions</a></li>
						<li><a data-toggle="tab" href="#tab-17" >Expense Types</a></li>
						<li class=""><a data-toggle="tab" role="tab" href="#tab-12" href="#">District Property Rates</a></li>
						<li class="dropdown">
							<a class="dropdown-toggle" data-toggle="dropdown" href="#">More <b class="caret"></b></a>
							<ul class="dropdown-menu">
								<!---->
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
						<!---  Land Access Category Unit   --->
						<div id="tab-2" class="tab-pane active">
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
										<th>Description</th>
										<th></th>
									</thead>
									<tbody>
										
									</tbody>
								</table>
							</div>
						
						</div>
						<!-- Tree or Crop Types -->
						<div id="tab-3" class="tab-pane">
							<div class="panel-body">
								<div class="col-lg-2 col-offset-sm-8">
									<div class="action-buttons">
										<a  data-toggle="modal" href="#treecrops"><i class="fa fa-plus"></i> Add New</a>
									</div>
									<div id="treecrops" class="modal fade" aria-hidden="true">
										<div class="modal-dialog">
											<div class="modal-content">
												<div class="modal-body">
													<div class="row">
														<div class="col-sm-12">
															<p>Add /Update Tree or Crop Type</p>
															<div class="ibox-content">
																<form class="form-horizontal" id="tblTreeCrops">
																	<input type="hidden" name="id" >
																	<input type="hidden" name="tbl"  value="treecroptypes">
																	<div class="form-group"><label class="col-lg-2 control-label">Title</label>
																		<div class="col-lg-10"><input type="text" name="title" placeholder="Title" class="form-control"> 
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
									<div id="croptypes_desc" class="modal fade" aria-hidden="true">
										<div class="modal-dialog">
											<div class="modal-content">
												<div class="modal-body">
												</div>
											</div>
										</div>
									</div>
								</div>
								<div class="col-lg-12" style="margin-top:10px;">
									<div class="ibox-content">
										<div class="table-responsive">
											<table class="table table-striped table-bordered table-hover" id="treeCropsTypes">
												<thead>
												<tr>
													<th>Title</th>
													<th>Description</th>
													<th></th>
												</tr>
												</thead>
												<tbody></tbody>
												<tfoot>
													<tr>
														<th>Title</th>
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
						<!-- End Tree or Crop Types -->
						
						<!-- Crop Descriptions -->
						<div id="tab-5" class="tab-pane">
							<div class="panel-body">
								<div class="col-lg-2 col-offset-sm-8">
									<div class="action-buttons">
										<a  data-toggle="modal" href="#cropdescription"><i class="fa fa-plus"></i> Add New</a>
									</div>
									<div id="cropdescription" class="modal fade" aria-hidden="true">
										<div class="modal-dialog">
											<div class="modal-content">
												<div class="modal-body">
													<div class="row">
														<div class="col-sm-12">
															<p>Add /Update Crop Description</p>
															<div class="ibox-content">
																<form class="form-horizontal" id="tblCropDescription">
																	<input type="hidden" name="id" >
																	<input type="hidden" name="tbl"  value="CropDescription">
																	<div class="form-group"><label class="col-lg-2 control-label">Title</label>
																		<div class="col-lg-10"><input type="text" name="title" placeholder="Title" class="form-control"> 
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
											<table class="table table-striped table-bordered table-hover" id="cropDescription">
												<thead>
												<tr>
													<th>Title</th>
													<th>Description</th>
													<th></th>
												</tr>
												</thead>
												<tbody></tbody>
												<tfoot>
													<tr>
														<th>Title</th>
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
						<!-- End Tree Crop Descriptions -->
						<!-- Property Descriptions -->
						<div id="tab-7" class="tab-pane">
							<div class="panel-body">
								<div class="col-lg-2 col-offset-sm-8">
									<div class="action-buttons">
										<a  data-toggle="modal" href="#propertydescription"><i class="fa fa-plus"></i> Add New</a>
									</div>
									<div id="propertydescription" class="modal fade" aria-hidden="true">
										<div class="modal-dialog">
											<div class="modal-content">
												<div class="modal-body">
													<div class="row">
														<div class="col-sm-12">
															<p>Add /Update Property Description</p>
															<div class="ibox-content">
																<form class="form-horizontal" id="tblPropertyDescription">
																	<input type="hidden" name="id" >
																	<input type="hidden" name="tbl"  value="propertyDescription">
																	<div class="form-group"><label class="col-lg-2 control-label">Title</label>
																		<div class="col-lg-10"><input type="text" name="title" placeholder="Title" class="form-control"> 
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
											<table class="table table-striped table-bordered table-hover" id="propertyDescription">
												<thead>
												<tr>
													<th>Title</th>
													<th>Description</th>
													<th></th>
												</tr>
												</thead>
												<tbody></tbody>
												<tfoot>
													<tr>
														<th>Title</th>
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
						<!-- End Property Descriptions -->
						<!-- Propery -->
						<div id="tab-8" class="tab-pane">
							<div class="panel-body">
								<div class="col-lg-2 col-offset-sm-8">
									<div class="action-buttons">
										<a  data-toggle="modal" href="#propertytype"><i class="fa fa-plus"></i> Add New</a>
									</div>
									<div id="propertytype" class="modal fade" aria-hidden="true">
										<div class="modal-dialog">
											<div class="modal-content">
												<div class="modal-body">
													<div class="row">
														<div class="col-sm-12">
															<p>Add /Update  Property</p>
															<div class="ibox-content">
																<form class="form-horizontal" id="tblPropertyTypes">
																	<input type="hidden" name="id" >
																	<input type="hidden" name="tbl"  value="propertytypes">
																	<div class="form-group"><label class="col-lg-2 control-label">Title</label>
																		<div class="col-lg-10"><input type="text" name="title" placeholder="Title" class="form-control"> 
																		</div>
																	</div>
																	<div class="form-group"><label class="col-lg-2 control-label">Crop Rate</label>
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
									<div id="property_d" class="modal fade" aria-hidden="true">
										<div class="modal-dialog">
											<div class="modal-content">
												<div class="modal-body">
												</div>
											</div>
										</div>
									</div>
								</div>
								<div class="col-lg-12" style="margin-top:10px;">
									<div class="ibox-content">
										<div class="table-responsive">
											<table class="table table-striped table-bordered table-hover" id="tblPropertyType">
												<thead>
												<tr>
													<th>Title</th>
													<th>Description</th>
													<th></th>
												</tr>
												</thead>
												<tbody></tbody>
												<tfoot>
													<tr>
														<th>Title</th>
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
						<!-- End Property -->
						<!-- District Crop Rate -->
						<div id="tab-11" class="tab-pane">
							<div class="panel-body">
								<div class="col-lg-2 col-offset-sm-8">
									<div class="action-buttons">
										<a  data-toggle="modal" href="#districtrate"><i class="fa fa-plus"></i> Add Crop/Tree Rate</a>
									</div>
									<div id="districtrate" class="modal fade" aria-hidden="true">
										<div class="modal-dialog">
											<div class="modal-content">
												<div class="modal-body">
													<div class="row">
														<div class="col-sm-12">
															<p>Add Rate</p>
															<div class="ibox-content">
																<form class="form-horizontal" method="post" id="tblDistrictCropRate">
																	<input type="hidden" name="tbl" value="district_rate">
																	<input type="hidden" name="id" value="">
																	<div class="form-group">
																		<label class="control-label col-md-2">District</label>
																		<div class="col-lg-10">
																		  <select class="select2able" name="district_id" >
																				<?php 
																				$all_ditricts = $districts->findAll();
																				if($all_ditricts){
																					foreach($all_ditricts as $single){ ?>
																						<option value="<?php echo $single['id']; ?>"><?php echo $single['district_name']; ?></option>
																					<?php	
																					}
																				}?>
																			</select>
																		</div>
																	</div>
																	<div class="form-group"><label class="col-lg-2 control-label">Crop/Tree Rate</label>
																		<div class="col-lg-10">
																			 <select class="select2able" name="croptree_id">
																				<?php 
																				$alldata = $tree_crop_description->findCropTreeDescription();
																				if($alldata){
																					foreach($alldata as $single){ ?>
																						<option value="<?php echo $single['id']; ?>"><?php echo $single['cropname']." - ".$single['cropdescription']; ?></option>
																					<?php	
																					}
																				}?>
																			</select>
																		</div>
																	</div>
																	<div class="form-group"><label class="col-lg-2 control-label">Property Rate</label>
																		<div class="col-lg-10">
																			<input name="rate" placeholder="rate" class="form-control" required></input>
																		</div>
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
									<div id="district_rate_edit" class="modal fade" aria-hidden="true">
										<div class="modal-dialog">
											<div class="modal-content">
												<div class="modal-body">
												</div>
											</div>
										</div>
									</div>
								</div>
								<div class="col-lg-12" style="margin-top:10px;">
									<div class="ibox-content">
										<div class="table-responsive">
											<table class="table table-striped table-bordered table-hover" id="tblDistrictCropRates">
												<thead>
													<tr>
														<th id="selector0">&nbsp;</th>
														<th id="selector1">&nbsp;</th>
														<th id="selector2">&nbsp;</th>
														<th></th>
														<th></th>
													</tr>
													<tr>
														<th>District</th>
														<th>Crop/Tree Type</th>
														<th>Crop Description</th>
														<th>Rate</th>
														<th></th>
														
													</tr>
												</thead>
												<tbody></tbody>
												<tfoot>
													<tr>
														<th>Title</th>
														<th>Description</th>
														<th></th>
														<th></th>
														<th></th>
													</tr>
												</tfoot>
											</table>
										</div>
									</div>
								</div>
							</div>
						</div>
						<!-- End District Crop Rate -->
						
						<!-- District Property Rates -->
						<div id="tab-12" class="tab-pane">
							<div class="panel-body">
								<div class="col-lg-2 col-offset-sm-8">
									<div class="action-buttons">
										<a  data-toggle="modal" href="#propertyrate"><i class="fa fa-plus"></i> Add Property rate</a>
									</div>
									<div id="propertyrate" class="modal fade" aria-hidden="true">
										<div class="modal-dialog">
											<div class="modal-content">
												<div class="modal-body">
													<div class="row">
														<div class="col-sm-12">
															<p>Add Rate</p>
															<div class="ibox-content">
																<form class="form-horizontal" method="post" id="tblPropertyRate">
																	<input type="hidden" name="tbl" value="property_rate">
																	<input type="hidden" name="id" value="">
																	<div class="form-group">
																		<label class="control-label col-md-2">District</label>
																		<div class="col-lg-10">
																		  <select class="select2able" name="district_id" >
																				<?php 
																				$all_ditricts = $districts->findAll();
																				if($all_ditricts){
																					foreach($all_ditricts as $single){ ?>
																						<option value="<?php echo $single['id']; ?>"><?php echo $single['district_name']; ?></option>
																					<?php	
																					}
																				}?>
																			</select>
																		</div>
																	</div>
																	<div class="form-group"><label class="col-lg-2 control-label">Poperty Type description</label>
																		<div class="col-lg-10">
																			 <select class="select2able" name="propertytypedescription_id">
																				<?php 
																				$alldata = $propertytypedescription->findPropertyTypeDescription();
																				if($alldata){
																					foreach($alldata as $single){ ?>
																						<option value="<?php echo $single['id']; ?>"><?php echo $single['propertytype']." - ".$single['propertydescription']; ?></option>
																					<?php	
																					}
																				}?>
																			</select>
																		</div>
																	</div>
																	<div class="form-group"><label class="col-lg-2 control-label">Property Rate</label>
																		<div class="col-lg-10">
																			<input name="rate" placeholder="rate" class="form-control" required></input>
																		</div>
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
									<div id="propertyrate_edt" class="modal fade" aria-hidden="true">
										<div class="modal-dialog">
											<div class="modal-content">
												<div class="modal-body">
												</div>
											</div>
										</div>
									</div>
								</div>
								<div class="col-lg-12" style="margin-top:10px;">
									<div class="ibox-content">
										<div class="table-responsive">
											<table class="table table-striped table-bordered table-hover" id="tblPropertyRates">
												<thead>
													<tr>
														<th id="selector3">&nbsp;</th>
														<th id="selector4">&nbsp;</th>
														<th id="selector5">&nbsp;</th>
														<th></th>
														<th></th>
													</tr>
													<tr>
														<th>District</th>
														<th>Property Type</th>
														<th>Property Description</th>
														<th>Rate</th>
														<th></th>
														
													</tr>
												</thead>
												<tbody></tbody>
												<!--<tfoot>
													<tr>
														<th></th>
														<th></th>
														<th></th>
														<th></th>
														<th></th>
													</tr>
												</tfoot> -->
											</table>
										</div>
									</div>
								</div>
							</div>
						</div>
						<!-- End Property  Rate -->
						
						
						<!-- Land access category -->
						<div id="tab-21" class="tab-pane">
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
