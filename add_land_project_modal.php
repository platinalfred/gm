
<div class="row">
    <div class="col-lg-12">
        <div class="widget-container fluid-height clearfix">
            <div class="heading">
                <i class="fa fa-bars"></i>Basic Components
            </div>
            <div class="widget-content padded">
                <form id="tblLandProjectForm" action="#" method="post" class="form-horizontal">
					<input type="hidden" name="tbl" value="tblLandProject">
					<input type="hidden" name="id" >
                    <div class="form-group">
                        <label class="control-label col-md-4">Project Title</label>
                        <div class="col-md-7">
							<textarea name="project_title" class="form-control" rows="2"></textarea>
                        </div>
                    </div>
					<div class="form-group">
                        <label class="control-label col-md-4">Project Reference</label>
                        <div class="col-md-7">
                            <div class="input-group">
                                <input class="form-control" placeholder="Project reference" name="project_reference" type="text">
                            </div>
                        </div>
                    </div>
                    <div class="form-group">
                        <label class="control-label col-md-4">Project Category Unit</label>
						<?php 
						$land_acquisition_category = new LandAcquisitionCategory(); 
						$land_acquisition_category_unit = new landAcquisitionCategoryUnit();
						?>
                        <div class="col-md-7">
                            <select class="form-control" name="project_category_unit">
								<?php 
								$all_categories_units = $land_acquisition_category_unit->findAll();
								print_r($all_categories_units);
								if($all_categories_units){
									foreach($all_categories_units as $single){ ?>
										<option value="<?php echo $single['id']; ?>"><?php echo $single['title']; ?></option>
									<?php 
									}
								}
								?>								
                            </select>
                        </div>
                    </div>
                    
                    <div class="form-group">
                        <label class="control-label col-md-4">Client Name</label>
                        <div class="col-md-7">
							<select name="client_id" class="form-control" data-placeholder="Select client..." class="form-control chosen-select" data-bind='options: clients, optionsText: "client_names", optionsCaption: "Select customer...", optionsAfterRender: $root.setOptionValue("id")' data-msg-required="Client name is required" required></select>
                        </div>
						<!--, value: $root.client-->
                    </div>
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