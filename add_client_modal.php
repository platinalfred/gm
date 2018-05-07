<div class="row">
    <div class="col-lg-12">
        <div class="widget-container fluid-height clearfix">
            <div class="heading">
                <i class="fa fa-bars"></i>Add New Client
            </div>
            <div class="widget-content padded">
                <form  id="tblClientForm"action="#" method="post" class="form-horizontal">
					<input type="hidden" name="tbl" value="tblClient">
					<input type="hidden" name="id" >
                    <div class="form-group" >
                        <label class="control-label col-md-4">Client Names</label>
                        <div class="col-md-7">
							<textarea name="client_names" class="form-control" rows="2" required ></textarea>
                        </div>
                    </div>
					
                    <div class="form-group">
                        <label class="control-label col-md-4">Primary phone contact</label>
                        <div class="col-md-7">
							<input name="phone_contact1" type="text" class="form-control" data-rule-phoneUg="true" data-msg-phoneUg="Start number with 0 or +" data-msg-required="Primary phone contact is required" required />
                        </div>
                    </div>
					
                    <div class="form-group">
                        <label class="control-label col-md-4">Secondary phone contact</label>
                        <div class="col-md-7">
							<input name="phone_contact2" type="text" class="form-control" data-rule-phoneUg="true" data-msg-phoneUg="Start number with 0 or +" />
                        </div>
                    </div>
					
                    <div class="form-group">
                        <label class="control-label col-md-4">Primary email contact</label>
                        <div class="col-md-7">
							<input name="email_contact1" type="email" class="form-control" required />
                        </div>
                    </div>
					
                    <div class="form-group">
                        <label class="control-label col-md-4">Secondary email contact</label>
                        <div class="col-md-7">
							<input name="email_contact2" type="email" class="form-control" />
                        </div>
                    </div>
					
                    <div class="form-group">
                        <label class="control-label col-md-4">Website</label>
                        <div class="col-md-7">
							<input name="website" type="url" class="form-control" />
                        </div>
                    </div>
					<div class="form-group">
                        <label class="control-label col-md-4">Postal Address</label>
                        <div class="col-md-7">
							<textarea name="postal_address" class="form-control" rows="2" required ></textarea>
                        </div>
                    </div>
					<div class="form-group">
                        <label class="control-label col-md-4">Physical Address</label>
                        <div class="col-md-7">
							<textarea name="physical_address" class="form-control" rows="2" required ></textarea>
                        </div>
                    </div>
                    <div class="form-group">
                        <label class="control-label col-md-4">&nbsp;</label>
                        <div class="col-md-7">
                            <button class="btn btn-primary save" type="submit">Submit</button>
                            <button class="btn btn-default-outline" type="reset" data-dismiss="modal" >Cancel </button>
                        </div>
                    </div>
                </form>
            </div>
        </div>
    </div>
</div>