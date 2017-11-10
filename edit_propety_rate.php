<?php 
require_once("lib/PropertyDescription.php");
require_once("lib/Districts.php");
require_once("lib/PropertyTypeDescription.php");
require_once("lib/DistrictPropertyRate.php");
$districts = new Districts();
$propertytypedescription = new PropertyTypeDescription();
$district_property_rate  = new DistrictPropertyRate();
$rate = $district_property_rate->findById($_GET['id']);
?>
<div class="row">
	<div class="col-sm-12">
		<div class="ibox-content">
			<p><b>Update Property Rate</b></p>
			<form class="form-horizontal" method="post" id="tblPropertyRate">
				<input type="hidden" name="tbl" value="property_rate">
				<input type="hidden" name="id" value="<?php echo $_GET['id']; ?>">
				<div class="form-group">
					<label class="control-label col-md-2">District</label>
					<div class="col-lg-10">
					  <select class="select2able" name="district_id" >
							<?php 
							$all_ditricts = $districts->findAll();
							if($all_ditricts){
								foreach($all_ditricts as $single){ ?>
									<option <?php if($single['id'] == $rate['district_id']){ echo "selected"; } ?>  value="<?php echo $single['id']; ?>"><?php echo $single['district_name']; ?></option>
								<?php	
								}
							}?>
						</select>
					</div>
				</div>
				<div class="form-group"><label class="col-lg-2 control-label">Poperty Type description</label>
					<div class="col-lg-10">
						 <select class="select2able" name="propertytypedescription_id">
							<?php 
							$alldata = $propertytypedescription->findPropertyTypeDescription();
							if($alldata){
								foreach($alldata as $single){ ?>
									<option <?php if($single['id'] == $rate['propertytypedescription_id']){ echo "selected;"; } ?>value="<?php echo $single['id']; ?>"><?php echo $single['propertytype']." - ".$single['propertydescription']; ?></option>
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
				dTable["tblPropertyRate"].ajax.reload();
				//alert(response);
				if(response.trim() == "success"){
					showStatusMessage("Property type descriptions successfully updated, " ,"success");
					setTimeout(function(){ window.location = "settings.php#tab-8"; }, 3000);
				}else{
					showStatusMessage("Your property type description could not be updated" ,"fail");
				}
				
			}
		});
		return false;
	});
});
</script>
									