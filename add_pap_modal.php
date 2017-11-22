<div class="row">
        <div class="widget-container fluid-height clearfix">
            <div class="heading">
                <i class="fa fa-bars"></i>Add Project Affected Person
            </div>
            <div class="widget-content padded">
                <form  id="tblPapForm" action="#" method="post" class="form-horizontal">
						<fieldset>
							<legend>PAP Details</legend>
						<div class="col-lg-3">
							<input type="hidden" name="tbl" value="tblPap">
							<input type="hidden" name="id" >
							<input type="hidden" name="project_id" value="<?php echo $_GET['id']; ?>" />
							<div class="form-group" >
								<label class="control-label">Attach PAP Photo</label>
								<input name="photo_url" type="file" accept=".png,.jpeg,.gif,.jpg, image/gif,image/jpg,image/jpeg,image/pjpeg,image/png)" class="form-control"/>
								<div data-bind="with:pap_details">
									<img data-bind="attr:{src:'img/paps/pap_'+id+'.jpg'}" class="img-thumbnail img-responsive"/>
								</div>
							</div>
						</div>
						<div class="col-lg-5">
							<div class="form-group" >
								<label class="control-label col-md-5">First Name</label>
								<div class="col-md-7">
									<input name="firstname" type="text" class="form-control" data-msg-required="Firstname must be entered" required />
								</div>
							</div>
							<div class="form-group" >
								<label class="control-label col-md-5">Surname</label>
								<div class="col-md-7">
									<input name="lastname" type="text" class="form-control" data-msg-required="Last name must be entered" required />
								</div>
							</div>
							<div class="form-group" >
								<label class="control-label col-md-5">Other Name</label>
								<div class="col-md-7">
									<input name="othername" type="text" class="form-control" />
								</div>
							</div>
							
							<div class="form-group">
								<label class="control-label col-md-5">Phone Contact</label>
								<div class="col-md-7">
									<input name="phone_contact" type="text" class="form-control" data-msg-required="Phone number must be entered" data-msg-phoneUg="Start number with 07 or +256" required />
								</div>
							</div><!--
							<div class="form-group">
								<label class="control-label col-md-5">Phone Contact 2</label>
								<div class="col-md-7">
									<input name="phone_contact2" type="text" class="form-control" data-msg-required="Phone number must be entered" data-msg-phoneUg="Start number with 07 or +256" required />
								</div>
							</div>-->
						</div>
						<div class="col-lg-4">
						
							<div class="form-group">
								<label class="control-label col-md-5">District</label>
								<div class="col-md-7">
									<select id="district_id" name="district_id" class="select2able" data-bind="options: project_districts, optionsText: 'district_name', optionsCaption: 'Select district...', optionsAfterRender: $root.setOptionValue('id'), value:district" data-msg-required="District must be selected" required ></select>
								</div>
							</div>
						
							<div class="form-group">
								<label class="control-label col-md-5">County</label>
								<div class="col-md-7">
									<select id="county_id" name="county_id" class="select2able" data-bind='options: filteredCountiesList(), optionsText: "county_name", optionsCaption: "Select county...", optionsAfterRender: $root.setOptionValue("id"), value:county, select2:{dropdownParent:"#papModal"}'></select>
								</div>
							</div>
						
							<div class="form-group">
								<label class="control-label col-md-5">Subcounty</label>
								<div class="col-md-7">
									<select id="subcounty_id" name="subcounty_id" class="select2able" data-bind='options: filteredSCountiesList, optionsText: "subcounty_name", optionsCaption: "Select subcounty...", optionsAfterRender: $root.setOptionValue("id"), value:scounty'></select>
								</div>
							</div>
						
							<div class="form-group">
								<label class="control-label col-md-5">Parish</label>
								<div class="col-md-7">
									<select id="parish_id" name="parish_id" class="select2able" data-bind='options: filteredParishesList, optionsText: "parish_name", optionsCaption: "Select parish...", optionsAfterRender: $root.setOptionValue("id"), value:parish'></select>
								</div>
							</div>
						
							<div class="form-group">
								<label class="control-label col-md-5">Village</label>
								<div class="col-md-7">
									<select id="village_id" name="village_id" class="select2able" data-bind='options: filteredVillagesList, optionsText: "village_name", optionsCaption: "Select village...", optionsAfterRender: $root.setOptionValue("id"), value:village'></select>
								</div>
							</div>
						</div>
					</fieldset>
						<div class="col-lg-3">
					<fieldset>
						<legend>Land Tenure</legend>
							<div class="form-group" >
								<div class="col-md-8">
									<select name="tenure" id="tenure" data-bind="value: tenure" class="form-control">
										<?php foreach($tenures as $tenure):?>
											<option value="<?=$tenure['id']?>"><?=$tenure['title']?></value>
										<?php endforeach;?>
									</select>
								</div>
								<label class="control-label col-md-4">Acres</label>
							</div>
					</fieldset>
					<?php if( $projectDetails['project_category_unit'] == 2 || $projectDetails['project_category_unit'] == 4 ):?>
						<div class="col-lg-3">
					<fieldset>
						<legend>Way Leave</legend>
							<div class="form-group" >
								<div class="col-md-8">
									<input name="way_leave" type="text" class="form-control" data-msg-required="Way leave must be entered" required />
								</div>
								<label class="control-label col-md-4">Acres</label>
							</div>
					</fieldset>
						</div>
					<?php endif;?>
					<?php if( $projectDetails['project_category_unit'] == 1 || $projectDetails['project_category_unit'] == 4 ):?>
						<div class="col-lg-3">
					<fieldset>
						<legend>Right of way</legend>
							<div class="form-group" >
								<div class="col-md-8">
									<input name="rightofway" type="text" class="form-control" data-msg-required="Required field" required />
								</div>
								<label class="control-label col-md-4">Acres</label>
							</div>
					</fieldset>
						</div>
					<?php endif;?>
					<?php if( $projectDetails['project_category_unit'] == 5 ):?>
						<div class="col-lg-3">
					<fieldset>
						<legend>Total Size</legend>
							<div class="form-group" >
								<div class="col-md-8">
									<input name="total_take" type="text" class="form-control" />
								</div>
								<label class="control-label col-md-4">Acres</label>
							</div>
					</fieldset>
						</div>
					<?php endif;?>
						<div class="col-lg-3">
					<fieldset>
						<legend>Chainage</legend>
							<div class="form-group" >
								<label class="control-label col-md-5">Km</label>
								<div class="col-md-7">
									<input name="chainage" type="text" class="form-control" data-msg-required="Chainage point must be entered" required />
								</div>
							</div>
					</fieldset>
						</div>
					<div class="clearfix"></div>
					<div class="col-lg-6">
						<fieldset>
							<legend>Improvements <a href="#" class="pull-right" data-bind="click: addImprovement, enable: available_districts().length>0" title="Add another item"><i class="fa fa-plus"></i></a></legend>
							<div class="form-group">
								<label class="col-md-7">Improvement</label>
								<label class="col-md-4">Quantity</label>
								<div class="col-md-1">
								</div>
							</div>
							<!-- ko foreach: serverDataImprovements -->
							<div class="form-group">
								<div class="col-md-7">
									<input type="hidden" data-bind="attr:{name:'improvement['+$index()+'][id]'}, value:id" />
									<input type="hidden" data-bind="attr:{name:'improvement['+$index()+'][district_property_rate_id]'}, value:district_property_rate_id" />
									<label class="control-label" data-bind="text: propertytype + ' - ' + propertydescription"></label>
								</div>
								<div class="col-md-4">
									<input class="form-control" placeholder="Quantity" data-bind="attr:{name:'improvement['+$index()+'][quantity]'}, value:quantity" data-msg-required="Enter quantity"  />
									<input type="hidden" data-bind="attr:{name:'improvement['+$index()+'][rate]'}, value:rate" />
								</div>
								<div class="col-md-1">
									<a href="#" data-bind="click: $root.removeServerDataImprovement" class="text-danger"><i class="fa fa-minus"></i></a>
								</div>
							</div>
							<!--/ko-->
							<!-- ko foreach: selectedImprovements -->
							<div class="form-group">
								<div class="col-md-7">
									<select class="select2able" data-bind="options: $root.district_property_rates, optionsText: function(item){ return item.propertytype + ' - ' + item.propertydescription;}, optionsCaption: 'Select improvement...', optionsAfterRender: $root.setOptionValue('id'), value:rate_description, attr:{name:'improvement['+($index()+($root.serverDataImprovements()?$root.serverDataImprovements().length:0))+'][district_property_rate_id]'}, select2:{dropdownParent:'#papModal'}" data-msg-required="An option must be selected" ></select>
								</div>
								<div class="col-md-4">
									<input class="form-control" placeholder="Quantity" data-bind="attr:{name:'improvement['+($index()+($root.serverDataImprovements()?$root.serverDataImprovements().length:0))+'][quantity]'}"  data-msg-required="Enter Quantity"  />
									<!--ko with:rate_description-->
									<input type="hidden" data-bind="attr:{name:'improvement['+($parentContext.$index()+($root.serverDataImprovements()?$root.serverDataImprovements().length:0))+'][rate]'}, value:rate" />
									<!--/ko-->
								</div>
								<div class="col-md-1">
									<a href="#" data-bind="click: $root.removeSelectedImprovement" class="text-danger"><i class="fa fa-minus"></i></a>
								</div>
							</div>
							<!--/ko-->
						</fieldset>
					</div>
					<div class="col-lg-6">
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
									<label class="control-label" data-bind="text: croptype + ' - ' + cropdescription"></label>
								</div>
								<div class="col-md-4">
									<input class="form-control" placeholder="Quantity" data-bind="attr:{name:'plant['+($index()+$root.serverDataPlants().length)+'][quantity]'}, value:quantity" required data-msg-required="Enter quantity" />
									<input type="hidden" data-bind="attr:{name:'plant['+($index()+$root.serverDataPlants().length)+'][rate]'}, value:rate" />
								</div>
								<div class="col-md-1">
									<a href="#" data-bind="click: $root.removeServerDataPlant" class="text-danger"><i class="fa fa-minus"></i></a>
								</div>
							</div>
							<!--/ko-->
							<!-- ko foreach: selectedPlants -->
							<div class="form-group">
								<!--label class="control-label col-md-4">Plant <span data-bind="text: ($index()+1)"></span></label-->
								<div class="col-md-7">
									<select class="select2able" data-bind="options: $root.district_crop_rates, optionsText: function(item){ return item.croptype + ' - ' + item.cropdescription;}, optionsCaption: 'Select crop/tree...', optionsAfterRender: $root.setOptionValue('id'), value:rate_description, attr:{name:'plant['+($index()+$root.serverDataPlants().length)+'][crop_description_rate_id]'}, select2:{dropdownParent:'#papModal'}" data-msg-required="Select an option" required></select>
								</div>
								<div class="col-md-4">
									<input class="form-control" placeholder="Quantity" data-bind="attr:{name:'plant['+($index()+$root.serverDataPlants().length)+'][quantity]'}" data-msg-required="Enter quantity" required />
									<!--ko with:rate_description-->
									<input type="hidden" data-bind="attr:{name:'plant['+($parentContext.$index()+$root.serverDataPlants().length)+'][rate]', value:rate}" />
									<!--/ko-->
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