<div class="row">
        <div class="widget-container fluid-height clearfix">
            <div class="heading">
                <i class="fa fa-bars"></i>Add Project Affected Person
            </div>
            <div class="widget-content padded">
                <form  id="tblPapForm" action="#" method="post" class="form-horizontal">
						<fieldset>
							<legend>Personal Details</legend>
						<div class="col-lg-6">
							<input type="hidden" name="tbl" value="tblPap">
							<input type="hidden" name="id" >
							<div class="form-group" >
								<label class="control-label col-md-5">First name</label>
								<div class="col-md-7">
									<input name="firstname" type="text" class="form-control" required />
								</div>
							</div>
							<div class="form-group" >
								<label class="control-label col-md-5">First name</label>
								<div class="col-md-7">
									<input name="lastname" type="text" class="form-control" required />
								</div>
							</div>
							<div class="form-group" >
								<label class="control-label col-md-5">Other name</label>
								<div class="col-md-7">
									<input name="othername" type="text" class="form-control" />
								</div>
							</div>
							
							<div class="form-group">
								<label class="control-label col-md-5">Phone contact</label>
								<div class="col-md-7">
									<input name="phone_contact" type="text" class="form-control" pattern="(0|\+256)[2347]([0-9]{8})" required />
								</div>
							</div>
							<div class="form-group">
								<label class="control-label col-md-5">Physical Address</label>
								<div class="col-md-7">
									<textarea name="physical_address" class="form-control" rows="2" required ></textarea>
								</div>
							</div>
						</div>
						<div class="col-lg-6">
						
							<div class="form-group">
								<label class="control-label col-md-5">District</label>
								<div class="col-md-7">
									<select name="district_id" class="form-control" class="form-control chosen-select" data-bind="options: available_districts, optionsText: 'district_name', optionsCaption: 'Select district...', optionsAfterRender: $root.setOptionValue('id')" required ></select>
								</div>
							</div>
						
							<div class="form-group">
								<label class="control-label col-md-5">County</label>
								<div class="col-md-7">
									<select name="district_id" class="form-control" class="form-control" data-bind='options: available_districts, optionsText: "district_name", optionsCaption: "Select county...", optionsAfterRender: $root.setOptionValue("id")'></select>
								</div>
							</div>
						
							<div class="form-group">
								<label class="control-label col-md-5">Subcounty</label>
								<div class="col-md-7">
									<select name="district_id" class="form-control" class="form-control" data-bind='options: available_districts, optionsText: "district_name", optionsCaption: "Select subcounty...", optionsAfterRender: $root.setOptionValue("id")'></select>
								</div>
							</div>
						
							<div class="form-group">
								<label class="control-label col-md-5">Parish</label>
								<div class="col-md-7">
									<select name="district_id" class="form-control" class="form-control" data-bind='options: available_districts, optionsText: "district_name", optionsCaption: "Select county...", optionsAfterRender: $root.setOptionValue("id")'></select>
								</div>
							</div>
							<div class="form-group" >
								<label class="control-label col-md-5">Village</label>
								<div class="col-md-7">
									<input name="village" type="text" class="form-control" required />
								</div>
							</div>
						</div>
					</fieldset>
						<div class="col-lg-3">
					<fieldset>
						<legend>Way Leave</legend>
							<div class="form-group" >
								<div class="col-md-8">
									<input name="way_leave" type="text" class="form-control" required />
								</div>
								<label class="control-label col-md-4">Sq. Mtrs</label>
							</div>
					</fieldset>
						</div>
						<div class="col-lg-3">
					<fieldset>
						<legend>Right of way</legend>
							<div class="form-group" >
								<div class="col-md-8">
									<input name="rightofway" type="text" class="form-control" required />
								</div>
								<label class="control-label col-md-4">Sq. Mtrs</label>
							</div>
					</fieldset>
						</div>
						<div class="col-lg-3">
					<fieldset>
						<legend>Total Take</legend>
							<div class="form-group" >
								<div class="col-md-8">
									<input name="total_take" type="text" class="form-control" required />
								</div>
								<label class="control-label col-md-4">Sq. Mtrs</label>
							</div>
					</fieldset>
						</div>
						<div class="col-lg-3">
					<fieldset>
						<legend>Chainage</legend>
							<div class="form-group" >
								<label class="control-label col-md-5">Km</label>
								<div class="col-md-7">
									<input name="chainage" type="text" class="form-control" required />
								</div>
							</div>
					</fieldset>
						</div>
					<div class="col-lg-7">
						<fieldset>
							<legend>Improvements <a href="#" class="pull-right" data-bind="click: addImprovement, enable: available_districts().length>0" title="Add another item"><i class="fa fa-plus"></i></a></legend>
							<div class="form-group">
								<label class="col-md-5">Improvement</label>
								<label class="col-md-4">Unit</label>
								<label class="col-md-2">Quantity</label>
								<div class="col-md-1">
								</div>
							</div>
							<!-- ko foreach: serverDataImprovements -->
							<div class="form-group">
								<div class="col-md-5">
									<input type="hidden" data-bind="attr:{name:'improvement['+$index()+'][id]'}, value:id" />
									<input type="hidden" data-bind="attr:{name:'improvement['+$index()+'][district_property_rate_id]'}, value:district_property_rate_id" />
									<label class="form-control" data-bind="text: propertytype + ' ' + propertydescription"></label>
								</div>
								<div class="col-md-4">
									<input class="form-control" placeholder="Unit of measure" data-bind="attr:{name:'improvement['+$index()+'][unit]'}, value:unit" required />
								</div>
								<div class="col-md-2">
									<input class="form-control" placeholder="Quantity" data-bind="attr:{name:'improvement['+$index()+'][quantity]'}, value:quantity" required />
									<input type="hidden" data-bind="attr:{name:'improvement['+$index()+'][rate]'}, value:rate" />
								</div>
								<div class="col-md-1">
									<a href="#" data-bind="click: $root.removeServerDataImprovement" class="text-danger"><i class="fa fa-minus"></i></a>
								</div>
							</div>
							<!--/ko-->
							<!-- ko foreach: selectedImprovements -->
							<div class="form-group">
								<div class="col-md-5">
									<select class="form-control" data-bind="options: $root.district_property_rates, optionsText: function(item){ return item.propertytype + ' ' + item.propertydescription;}, optionsCaption: 'Select improvement...', optionsAfterRender: $root.setOptionValue('id'), attr:{name:'improvement['+($index()+$root.serverDataImprovements().length)+'][district_property_rate_id]'}"></select>
								</div>
								<div class="col-md-4"><input class="form-control" placeholder="Unit of measure" data-bind="attr:{name:'improvement['+($index()+$root.serverDataImprovements().length)+'][unit]'}" required /></div>
								<div class="col-md-2">
									<input class="form-control" placeholder="Quantity" data-bind="attr:{name:'improvement['+($index()+$root.serverDataImprovements().length)+'][quantity]'}" required />
									<input type="hidden" data-bind="attr:{name:'improvement['+($index()+$root.serverDataImprovements().length)+'][rate]'}, value:rate" />
								</div>
								<div class="col-md-1">
									<a href="#" data-bind="click: $root.removeSelectedImprovement" class="text-danger"><i class="fa fa-minus"></i></a>
								</div>
							</div>
							<!--/ko-->
						</fieldset>
					</div>
					<div class="col-lg-5">
						<fieldset>
							<legend>Crops/Trees <a href="#" class="pull-right" data-bind="click: addPlant, enable: available_districts().length>0" title="Add another item"><i class="fa fa-plus"></i></a></legend>
							<div class="form-group">
								<!--label class="col-md-4">Plant</label-->
								<label class="col-md-7">Description</label>
								<label class="col-md-4">Quantity</label>
								<div class="col-md-1">
								</div>
							</div>
							<!-- ko foreach: serverDataPlants -->
							<div class="form-group">
								<div class="col-md-7">
									<input type="hidden" data-bind="value:id, attr:{name:'plant['+($index()+$root.serverDataPlants().length)+'][id]'}" />
									<input type="hidden" data-bind="value:pap_id, attr:{name:'plant['+($index()+$root.serverDataPlants().length)+'][pap_id]'}" />
									<input type="hidden" data-bind="value:crop_description_rate_id, attr:{name:'plant['+($index()+$root.serverDataPlants().length)+'][crop_description_rate_id]'}" />
									<label class="form-control" data-bind="text: croptype + ' ' + cropdescription"></label>
								</div>
								<div class="col-md-4">
									<input class="form-control" placeholder="Quantity" data-bind="attr:{name:'plant['+($index()+$root.serverDataPlants().length)+'][quantity]'}" required />
									<input type="hidden" data-bind="attr:{name:'plant['+($index()+$root.serverDataPlants().length)+'][rate]'}, value:rate" />
								</div>
								<div class="col-md-1">
									<a href="#" data-bind="click: $root.removeSelectedPlant" class="text-danger"><i class="fa fa-minus"></i></a>
								</div>
							</div>
							<!--/ko-->
							<!-- ko foreach: selectedPlants -->
							<div class="form-group">
								<!--label class="control-label col-md-4">Plant <span data-bind="text: ($index()+1)"></span></label-->
								<div class="col-md-7">
									<select class="form-control" data-bind="options: $root.district_crop_rates, optionsText: function(item){ return item.croptype + ' ' + item.cropdescription;}, optionsCaption: 'Select crop/tree...', optionsAfterRender: $root.setOptionValue('id'), attr:{name:'plant['+($index()+$root.serverDataPlants().length)+'][crop_description_rate_id]'}"></select>
								</div>
								<div class="col-md-4">
									<input class="form-control" placeholder="Quantity" data-bind="attr:{name:'plant['+($index()+$root.serverDataPlants().length)+'][quantity]'}" required />
									<input type="hidden" data-bind="attr:{name:'plant['+($index()+$root.serverDataPlants().length)+'][rate]'}, value:rate" />
								</div>
								<div class="col-md-1">
									<a href="#" data-bind="click: $root.removeSelectedPlant" class="text-danger"><i class="fa fa-minus"></i></a>
								</div>
							</div>
							<!--/ko-->
						</fieldset>
					</div>
					<div class="col-lg-12"><hr/></div>
					<div class="col-lg-4 col-lg-offset-3">
						<div class="form-group">
							<label class="control-label col-md-5">&nbsp;</label>
							<div class="col-md-7">
								<button class="btn btn-primary save" type="submit">Submit</button>
								<button class="btn btn-default-outline" type="reset" data-dismiss="modal" >Cancel </button>
							</div>
						</div>
					</div>
                </form>
            </div>
        </div>
</div>