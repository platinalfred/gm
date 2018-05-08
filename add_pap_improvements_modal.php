<div class="row">
	<div class="widget-container fluid-height clearfix">
		<div class="widget-content padded">
			<form  id="tblPapImprovementForm" action="#" method="post" class="form-horizontal">
				<fieldset>
					<div class="col-lg-12">
						<input type="hidden" name="tbl" value="tblPapImprovement">
						<input type="hidden" name="id" id="id" >
						<input type="hidden" name="pap_id" value="<?=$_GET['pap_id']?>" >
						<div class="form-group">
							<label class="control-label col-md-2">Property</label>
							<div class="col-md-10">
								<select class="select2able" name="district_property_rate_id" data-bind="options: $root.filteredDistrictPropertyRates(), optionsText: function(item){ return item.propertytype + ' - ' + item.propertydescription;}, optionsCaption: 'Select improvement...', optionsAfterRender: $root.setOptionValue('id'), value:property_rate_description" data-msg-required="An option must be selected" required></select>
							</div>
						</div>
						<div class="form-group" >
							<label class="control-label col-md-2">Quantity</label>
							<div class="col-md-10">
								<input class="form-control" placeholder="Quantity" name='quantity'  data-msg-required="Enter Quantity" required />
								<!--ko with:property_rate_description-->
								<input type="hidden" name="rate" data-bind="value:rate" />
								<!--/ko-->
							</div>
						</div>
					</div>
				</fieldset>
				<div class="col-lg-12"><hr/></div>
				<div class="col-lg-6 col-lg-offset-3">
					<div class="form-group">
						<label class="control-label col-md-2">&nbsp;</label>
						<div class="col-md-10">
							<button class="btn btn-primary save" type="submit">Submit</button>
							<button class="btn btn-default-outline" type="reset" data-dismiss="modal" >Cancel </button>
						</div>
					</div>
				</div>
			</form>
		</div>
	</div>
</div>