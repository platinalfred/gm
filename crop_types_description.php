<div class="row" id="tree_crop_description">
	<div class="col-sm-12" data-bind="with:tree_crop_type">
		<h3><span data-bind="text:title"></span> Tree/Crop Type</h3>
		<div data-bind="foreach: $parent.all_attached"><p data-bind="text:cropdescription"></p></div>
		<div class="ibox-content">
			<p><b>Attach possible description to <span data-bind="text:title"></span> crop/tree type</b></p>
			<form class="form-horizontal" >
				<input type="hidden" value="treecroptypedescription" name="tbl">
				<input type="hidden" value="<?php echo $_GET['id']; ?>" name="tree_crop_id">
				<div class="form-group">
					<div class=" col-md-12">Choose description</div>
					<!--ko foreach: $parent.all_crop_descriptions-->
						<div class="col-md-4">
						 <label class="checkbox"><input data-bind="value:id" type="checkbox" name="crop_description_id[]"><span data-bind="text: title"></span></label>
						 </div>
					<!--/ko-->
				</div>
				<div class="form-group">
					<div class="col-lg-offset-2 col-lg-10">
						<button class="btn btn-sm btn-primary save" type="button">Attach description</button>
					</div>
				</div>
			</form>
		</div>
	</div>
	
</div>
<script>
$(document).ready(function(){
	var ViewModel = function(){
		var self = this;
		self.tree_crop_type = ko.observable();
		self.all_attached = ko.observableArray();
		self.all_crop_descriptions = ko.observableArray();
		
		self.getServerData = function(crop_tree_id){
			$.post({
				url:"getData.php",
				data:{crop_id:crop_tree_id},
				dataType:'json',
				success: function(response){
					if(response.success){
						self.all_attached(reponse.all_attached);
						self.all_crop_descriptions(reponse.all_crop_descriptions);
					}
				}
			});
		};
	};
	var viewModel = new ViewModel();
	ko.applyBindings(viewModel, $("#tree_crop_description")[0]);
	
	$(".save").click(function(){
		var frm = $(this).closest("form");
		var frmdata = frm.serialize();
		$.ajax({
			url: "save_data.php",
			type: 'POST',
			data: frmdata,
			success: function (response) {
				if(response.trim() == "success"){
					showStatusMessage("Descriptions successfully saved, Please re-open the crop/tree type to see your selections" ,"success");
					setTimeout(function(){
						viewModel.getServerData();
					}, 2000);
				}else{
					showStatusMessage("Your description could not be saved, Please refresh the page anad try again or contact administrator for assistance." ,"fail");
				}
				
			}
		});
		return false;
	});
});
</script>
									