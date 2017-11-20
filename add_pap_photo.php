<div class="row">
        <div class="widget-container fluid-height clearfix">
            <div class="heading">
                <i class="fa fa-bars"></i>Add PAP Photo
            </div>
            <div class="widget-content padded">
                <form  id="tblPapPhotoForm" action="#" method="post" class="form-horizontal">
					<div class="col-lg-12">
							<input type="hidden" name="tbl" value="tblPapPhotos" />
							<input type="hidden" name="pap_id" value="<?php echo $_GET['pap_id']; ?>" />
						<fieldset>
							<legend>PAP photos <a href="#" class="pull-right" data-bind="click: addPapPhoto" title="Add another photo"><i class="fa fa-plus"></i></a></legend>
							<div class="form-group">
						<!-- ko foreach: papPhotos -->
						<div class="col-xs-12 col-md-4">
							<div class="img-thumbnail">
								<a href='#' class="pull-right" data-bind='click: $parent.removePapPhoto' title="Delete photo"><span class="fa fa-times danger"></span></a>
								<!--div class="col-sm-11">
								</div-->
									<input type="file" data-bind='attr:{name:"pap_photos["+($index())+"]"}' accept=".png,.jpeg,.gif,.jpg, image/gif,image/jpg,image/jpeg,image/pjpeg,image/png)" id="input-fil" class="form-control" required />
								<div class="col-sm-12">
									<textarea data-bind='attr:{name:"pap_photos["+($index())+"][description]"}' class="form-control" type="text" placeholder="Caption this photo" required></textarea>
								</div>
							</div>
						</div>
							<!--ko if: (($index()+1)%3==0||($index()+1)==$root.papPhotos().length) -->
								<div class="clearfix" style="border-top:5px;"></div><!-- close the row tag-->
							<!--/ko-->
						<!--/ko-->
						<div class="clearfix"></div>
							</div>
						</fieldset>
					</div>
					<div class="col-lg-12"><hr/></div>
					<div class="col-lg-8 col-lg-offset-1">
						<div class="form-group">
							<label class="control-label col-md-5">&nbsp;</label>
							<div class="col-md-7">
								<button class="btn btn-primary save" data-bind="enable: $root.papPhotos().length>0" type="submit">Submit</button>
								<button class="btn btn-default-outline" type="reset" data-dismiss="modal" >Cancel </button>
							</div>
						</div>
					</div>
                </form>
            </div>
        </div>
</div>