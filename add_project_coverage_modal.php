<div class="row">
    <div class="col-lg-12">
        <div class="widget-container fluid-height clearfix">
            <div class="heading">
                <i class="fa fa-globe"></i> Project Coverage
            </div>
            <div class="widget-content padded">
                <form  id="projectCoverageForm" action="#" method="post" class="form-horizontal">
					<input type="hidden" name="tbl" value="tblProjectCoverage">
					<input name="project_id" type="hidden" value="<?php echo $_GET['id']; ?>"/>
					<!-- ko foreach: selectedDistricts -->
                    <div class="form-group">
                        <label class="control-label col-md-2">District <span data-bind="text: ($index()+1)"></span></label>
                        <div class="col-md-7">
							<select name="district_id[]" class="form-control" data-bind="options: $root.available_districts, optionsText: 'district_name', optionsCaption: 'Select customer...', optionsAfterRender: $root.setOptionValue('id')"></select>
                        </div>
                        <div class="col-md-1">
							<a href="#" data-bind="click: $root.removeSelectedDistrict" class="text-danger"><i class="fa fa-times"></i></a>
                        </div>
                    </div>
					<!--/ko-->
                    <div class="form-group">
                        <label class="control-label col-md-2">&nbsp;</label>
                        <div class="col-md-7">
                            <button class="btn btn-info" type="button" data-bind="click: addDistrict, enable: available_districts().length>0"><i class="fa fa-plus"></i> Add</button>
                            <button class="btn btn-primary save" type="submit" data-bind="enable: selectedDistricts().length>0">Submit</button>
                            <button class="btn btn-default-outline" data-dismiss="modal" >Cancel </button>
                        </div>
                    </div>
                </form>
            </div>
        </div>
    </div>
</div>