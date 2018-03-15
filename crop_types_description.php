<?php 
require_once("lib/TreeCropTypesDescription.php");
require_once("lib/TreeCropTypes.php");
require_once("lib/CropDescription.php");
$treecroptypedescription = new TreeCropTypesDescription();
$crop_description = new CropDescription();
$treecroptypes = new TreeCropTypes();
?>
<div class="row">
	<div class="col-sm-12">
		<h3><?php echo $treecroptypes->findTreeName($_GET['id']); ?> Tree/Crop Type</h3>
		<?php
		$all_attached = $treecroptypedescription->findByTreeCropId($_GET['id']);
		$existing = array();
		if($all_attached){
			foreach($all_attached as $single){
				echo "<p>". $treecroptypes->findTreeName($_GET['id'])." - <b>".$crop_description->findDescriptionName($single['crop_description_id']) ."</b></p>";
				$existing[] = $single['crop_description_id'];
			}
		}
		?>
		<div class="ibox-content">
			<p><b>Attach possible description to <?php echo $treecroptypes->findTreeName($_GET['id']); ?> crop/tree type</b></p>
			<form class="form-horizontal" >
				<input type="hidden" value="treecroptypedescription" name="tbl">
				<input type="hidden" value="<?php echo $_GET['id']; ?>" name="tree_crop_id">
				<div class="form-group">
					<div class=" col-md-12">Choose description</div>
					
						<?php 
						$all_crop_descriptions = $crop_description->findAll();
						if($all_crop_descriptions){
							foreach($all_crop_descriptions as $single){ 
								if(in_array( $single['id'], $existing)){
									continue;
								}
								?>
								<div class="col-md-4">
								 <label class="checkbox"><input value="<?php echo $single['id']; ?>" type="checkbox" name="crop_description_id[]"><span><?php echo $single['title']; ?></span></label>
								 </div>
							<?php
							}
						}?>
					
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
					setTimeout(function(){ window.location = "settings.php#tab-3"; }, 3000);
					 $('#croptypes_desc').modal('toggle');
				}else{
					showStatusMessage("Your description could not be saved, Please refresh the page anad try again or contact administrator for assistance." ,"fail");
				}
				
			}
		});
		return false;
	});
});
</script>
									