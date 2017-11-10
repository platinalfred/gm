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
                        <label class="control-label col-md-4">Phone contact</label>
                        <div class="col-md-7">
							<input name="phone_contact1" type="text" class="form-control" pattern="(0|\+256)[2347]([0-9]{8})" required />
                        </div>
                    </div>
					
                    <div class="form-group">
                        <label class="control-label col-md-4">Phone contact2</label>
                        <div class="col-md-7">
							<input name="phone_contact2" type="text" class="form-control" pattern="(0|\+256)[2347]([0-9]{8})" />
                        </div>
                    </div>
					
                    <div class="form-group">
                        <label class="control-label col-md-4">Email contact</label>
                        <div class="col-md-7">
							<input name="email_contact1" type="email" class="form-control" required />
                        </div>
                    </div>
					
                    <div class="form-group">
                        <label class="control-label col-md-4">Email contact2</label>
                        <div class="col-md-7">
							<input name="email_contact2" type="email" class="form-control" />
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