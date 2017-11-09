
<div class="row">
    <div class="col-lg-12">
        <div class="widget-container fluid-height clearfix">
            <div class="heading">
                <i class="fa fa-bars"></i>Basic Components
            </div>
            <div class="widget-content padded">
                <form id="tblLandAccess" action="#" method="post" class="form-horizontal">
                    <div class="form-group">
                        <label class="control-label col-md-2">Title</label>
                        <div class="col-md-7">
							<textarea name="title" class="form-control" rows="2"></textarea>
                        </div>
                    </div>
					<div class="form-group">
                        <label class="control-label col-md-2">Project Reference</label>
                        <div class="col-md-7">
                            <div class="input-group">
                                <input class="form-control" placeholder="project_reference" type="text">
                            </div>
                        </div>
                    </div>
                    
					<div class="form-group">
                        <label class="control-label col-md-2">Project Category</label>
						<?php 
						$land_acquisition_category = new LandAcquisitionCategory(); 
						$land_acquisition_category_unit = new landAcquisitionCategoryUnit(); 
						$all_categories = $land_acquisition_category->findAll();
						?>
                        <div class="col-md-7">
							<?php 
							if($all_categories){
								foreach($all_categories as $single){ ?>
									<label class="radio-inline">
									<input name="project_category" type="radio" value="<?php echo $single['id']; ?>"><span><?php echo $single['title']; ?></span></label>
									<?php
								}
							}
							?>
                        </div>
                    </div>
                    <div class="form-group">
                        <label class="control-label col-md-2">Project Category Unit</label>
                        <div class="col-md-7">
                            <select class="form-control" multiple="" name="project_category_unit">
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
                        <label class="control-label col-md-2">Client Name</label>
                        <div class="col-md-7">
							<textarea name="client_name" class="form-control" rows="2"></textarea>
                           
                        </div>
                    </div>
                    <div class="form-group">
                        <label class="control-label col-md-2">&nbsp;</label>
                        <div class="col-md-7">
                            <button class="btn btn-primary save" type="button">Submit</button>
                            <button class="btn btn-default-outline" data-dismiss="modal" >Cancel </button>
                        </div>
                    </div>
                </form>
            </div>
        </div>
    </div>
</div>