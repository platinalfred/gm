<div class="row">
	<div class="widget-container fluid-height clearfix">
		<div class="widget-content padded">
			<form  id="tblStaffForm" action="#" method="post" class="form-horizontal">
				<fieldset>
					<div class="col-lg-9">
						<input type="hidden" name="tbl" value="tblStaff">
						<input type="hidden" name="id" >
						<input type="hidden" name="<?php echo $_SESSION['gmt']; ?>" >
						<div class="form-group">
							<label class="control-label col-md-5">Staff Type</label>
							<div class="col-md-7">
								<select name="staff_type" class="form-control" class="form-control chosen-select"  required >
									<option value="1">Permanent Staff</option> 
									<option value="0">Temporary Staff</option> 
								</select>
							</div>
						</div>
						<div class="form-group" >
							<label class="control-label col-md-5">First name</label>
							<div class="col-md-7">
								<input name="firstname" type="text" class="form-control" required />
							</div>
						</div>
						<div class="form-group" >
							<label class="control-label col-md-5">Last name</label>
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
							<label class="control-label col-md-5">Email</label>
							<div class="col-md-7">
								<input name="email" id="email" autocomplete="off" type="email" class="form-control"  required />
							</div>
						</div>
						<div class="form-group">
							<label class="control-label col-md-5">Confirm email</label>
							<div class="col-md-7">
								<input name="email2" autocomplete="off" type="email" class="form-control"  required />
							</div>
						</div>
						<div class="form-group">
							<label class="control-label col-md-5">Password</label>
							<div class="col-md-7">
								<input name="password" id="password" autocomplete="off" type="password" class="form-control"  required />
							</div>
						</div><div class="form-group">
							<label class="control-label col-md-5">Confirm Password</label>
							<div class="col-md-7">
								<input name="confirm_password" autocomplete="off" type="password" class="form-control"  required />
							</div>
						</div>
						<div class="form-group">
							<label class="control-label col-md-5">Phone contact</label>
							<div class="col-md-7">
								<input name="phone_contact" type="text" class="form-control" pattern="(0|\+256)[2347]([0-9]{8})" required />
							</div>
						</div>
						<div class="form-group">
							<label class="control-label col-md-5">Phone contact 2</label>
							<div class="col-md-7">
								<input name="phone_contact2" type="text" class="form-control" pattern="(0|\+256)[2347]([0-9]{8})"  />
							</div>
						</div>
						
						
						<div class="form-group">
							<label class="control-label col-md-5">Position</label>
							<div class="col-md-7">
								<?php 
								$positions = new Position(); 
								$all_positions = $positions->findAll();
								?>
								<select name="position" class="form-control" class="form-control"  required >
									<?php
									if($all_positions){
										foreach($all_positions as $single){ ?>
											<option value="<?php echo $single['id']; ?>">
												<?php echo $single['title']; ?>
											</option> 
											<?php
										}
									}
									?>
								</select>
							</div>
						</div>
						
						<div class="form-group">
							<label class="control-label col-md-5">Physical Address</label>
							<div class="col-md-7">
								<textarea name="address" class="form-control" rows="2" required ></textarea>
							</div>
						</div>
					</div>
				</fieldset>
				<div class="col-lg-12"><hr/></div>
				<div class="col-lg-6 col-lg-offset-3">
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