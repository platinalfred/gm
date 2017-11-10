<?php 
require_once("lib/PropertyDescription.php");
require_once("lib/Districts.php");
require_once("lib/TreeCropTypesDescription.php");
require_once("lib/DistrictCropRate.php");
$districts = new Districts();
$treecropdescription = new TreeCropTypesDescription();
$district_croptree_rate  = new DistrictCropRate();
$rate = $treecropdescription->findById($_GET['id']);
?>
<div class="row">
	<div class="col-sm-12">
		<div class="ibox-content">
			<p><b>Update Property Rate</b></p>
				<form class="form-horizontal" method="post" id="tblDistrictCropRate">
					<input type="hidden" name="tbl" value="district_rate">
					<input type="hidden" name="id" value="<?php echo $_GET['id']; ?>">
					<div class="form-group">
						<label class="control-label col-md-2">District</label>
						<div class="col-lg-10">
						  <select class="select2able" name="district_id" >
								<?php 
								$all_ditricts = $districts->findAll();
								if($all_ditricts){
									foreach($all_ditricts as $single){ ?>
										<option  <?php if($single['id'] == $rate['district_id']){ echo "selected"; } ?> value="<?php echo $single['id']; ?>"><?php echo $single['district_name']; ?></option>
									<?php	
									}
								}?>
							</select>
						</div>
					</div>
					<div class="form-group"><label class="col-lg-2 control-label">Crop/Tree Rate</label>
						<div class="col-lg-10">
							 <select class="select2able" name="croptree_id">
								<?php 
								$alldata = $tree_crop_description->findCropTreeDescription();
								if($alldata){
									foreach($alldata as $single){ ?>
										<option <?php if($single['id'] == $rate['croptree_id']){ echo "selected;"; } ?> value="<?php echo $single['id']; ?>"><?php echo $single['cropname']." - ".$single['cropdescription']; ?></option>
									<?php	
									}
								}?>
							</select>
						</div>
					</div>
					<div class="form-group"><label class="col-lg-2 control-label">Property Rate</label>
						<div class="col-lg-10">
							<input name="rate" placeholder="rate" value="<?php echo $rate['rate']; ?>" class="form-control" required></input>
						</div>
					</div>
					<div class="form-group">
						<div class="col-lg-offset-2 col-lg-10">
							<button class="btn btn-sm btn-primary save" type="button">Submit</button>
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
				dTable["tblDistrictCropRate"].ajax.reload();
				//alert(response);
				if(response.trim() == "success"){
					showStatusMessage("Crop/Tree type descriptions rate successfully updated, " ,"success");
					setTimeout(function(){ window.location = "settings.php#tab-8"; }, 3000);
				}else{
					showStatusMessage("Your Crop/Tree type descriptions rate could not be updated" ,"fail");
				}
				
			}
		});
		return false;
	});
});
</script>
									