<div class="row">
	<div class="widget-container fluid-height clearfix">
		<div class="widget-content padded">
			<form  id="tblPapCropForm" action="#" method="post" class="form-horizontal">
				<fieldset>
					<div class="col-lg-12">
						<input type="hidden" name="tbl" value="tblPapCrop">
						<input type="hidden" name="id" id="id">
						<input type="hidden" name="pap_id" value="<?=$_GET['pap_id']?>" >
						<div class="form-group">
							<label class="control-label col-md-3">Crop/Tree</label>
							<div class="col-md-9">
								<select class="select2able" name="crop_description_rate_id" data-bind="options: $root.filteredDistrictCropRates(), optionsText: function(item){ return item.croptype + ' - ' + item.cropdescription;}, optionsCaption: 'Select crop...', optionsAfterRender: $root.setOptionValue('id'), value:crop_rate_description" data-msg-required="An option must be selected" required></select>
							</div>
						</div>
						<div class="form-group" >
							<label class="control-label col-md-3">Quantity</label>
							<div class="col-md-9">
								<input class="form-control" placeholder="Quantity" name='quantity'  data-msg-required="Enter Quantity" required />
								<!--ko with:crop_rate_description-->
								<input type="hidden" name="rate" data-bind="value:rate" />
								<!--/ko-->
							</div>
						</div>
					</div>
				</fieldset>
				<div class="col-lg-12"><hr/></div>
				<div class="col-lg-6 col-lg-offset-3">
					<div class="form-group">
						<label class="control-label col-md-3">&nbsp;</label>
						<div class="col-md-9">
							<button class="btn btn-primary save" type="submit">Submit</button>
							<button class="btn btn-default-outline" type="reset" data-dismiss="modal" >Cancel </button>
						</div>
					</div>
				</div>
			</form>
		</div>
	</div>
</div>