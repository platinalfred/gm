<div class="row">
    <div class="col-lg-12">
        <div class="widget-container fluid-height clearfix">
            <div class="heading">
                <i class="fa fa-bars"></i>Types of Land Acquisition
            </div>
            <div class="widget-content padded">
                <form  id="landAcquisitionUnit"action="#" method="post" class="form-horizontal">
					<input type="hidden" name="tbl" value="land_acquisition_unit">
					<input type="hidden" name="active" value="1">
					<input type="hidden" name="id" >
                    <div class="form-group" >
                        <label class="control-label col-md-2">Title</label>
                        <div class="col-md-7">
							<textarea name="title" class="form-control" rows="2"></textarea>
                        </div>
                    </div>
					<div class="form-group" >
                        <label class="control-label col-md-2">Category Unit</label>
                        <div class="col-md-7">
							<?php 
							$land_acquisition_category = new landAcquisitionCategory();
							$land_acquisition_categories = $land_acquisition_category->findAll();
							?>
							<select name="category" class="form-control" rows="2">
								<?php
								if($land_acquisition_categories){ 
									foreach($land_acquisition_categories as $single){ ?>
										<option value="<?php echo $single['id']; ?>"><?php echo $single['title']; ?></option>
									<?php
									}
								}
								?>
							</select>
                        </div>
                    </div>
					
                    <div class="form-group">
                        <label class="control-label col-md-2">Description</label>
                        <div class="col-md-7">
							<textarea name="description" class="form-control" rows="2"></textarea>
                           
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