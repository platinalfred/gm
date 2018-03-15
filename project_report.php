<!-- Project Affected Persons Report section -->
<div id="tab-4" class="tab-pane active">
<div class="heading">
    <i class="fa fa-pie-chart"></i>Project Report
</div>
<div class="widget-content padded">
    <table class="table table-bordered table-striped widerTable" id="tblPapsReport" width="100%">
        <thead>
            <tr>
                <th>PAP REF</th>
                <th>PAP NAME</th>
                <th>TELEPHONE</th>
                <th>DISTRICT, SUBCOUNTY, PARISH, VILLAGE</th>
                <th>CHAINAGE</th>
                <th>IMPROVEMENT</th>
                <th>QTY/AREA/METRE RUN</th>
                <th>RATE(U.Shs)</th>
                <th>IMPROVEMENT VALUE(U.Shs)</th>
                <th>CROPS/TREES</th>
                <th>QTY</th>
                <th>RATE(U.Shs)</th>
                <th>CROP/TREE VALUE(U.Shs)</th>
                <th>LAND TENURE</th>
                <?php
                //Way Leave or both ROW and WL
                if ($projectDetails['project_category_unit'] == 2 || $projectDetails['project_category_unit'] == 4):
                    ?>
                    <th>WAY LEAVE</th>
                <?php endif; ?>
                <?php
                //ROW or Both ROW and WL
                if ($projectDetails['project_category_unit'] == 1 || $projectDetails['project_category_unit'] == 4):
                    ?>
                    <th>RIGHT OF WAY</th>
                <?php endif; ?>
                <?php
                //Total Take/Size OR Both ROW and WL Project
                if ($projectDetails['project_category_unit'] == 5 || $projectDetails['project_category_unit'] == 4):
                    ?>
                    <th>TOTAL SIZE</th>
                <?php endif; ?>
                <?php if ($projectDetails['project_category_unit'] == 1 || $projectDetails['project_category_unit'] == 4 || $projectDetails['project_category_unit'] == 5):
                    ?>
                    <th>RATE PER ACRE(U.Shs)</th>	
                    <th>LAND INTEREST(%)</th>
                    <?php
                endif;
                if ($projectDetails['project_category_unit'] == 4):
                    ?>
                    <th>Diminution(%)</th>
                <?php endif; ?>
                <?php
                //Way Leave or both ROW and WL
                if ($projectDetails['project_category_unit'] == 2 || $projectDetails['project_category_unit'] == 4):
                    ?>
                    <th>WL Land Value</th>
                <?php endif; ?>
                <?php
                //Right of Way or Both ROW and WL
                if ($projectDetails['project_category_unit'] == 1 || $projectDetails['project_category_unit'] == 4):
                    ?>
                    <th>ROW Land Value</th>
                <?php endif; ?>
                <?php
//Total land value, applies to ROW, (Both ROW and WL) and Total Take/Size
                if ($projectDetails['project_category_unit'] == 1 || $projectDetails['project_category_unit'] == 4 || $projectDetails['project_category_unit'] == 5):
                    ?>
                    <th>LAND VALUE (U.Shs)</th>
                <?php endif; ?>
                <th>IMPROVEMENT VALUE(U.Shs)</th>
                <th>CROP/TREE VALUE(U.Shs)</th>
                <th>SUB. TOTAL(U.Shs)</th>
                <th>DISTURBANCE ALLOWANCE (<?php echo $projectDetails['disturbance_allowance']; ?>%)(U.Shs)</th>
                <th>TOTAL COMPENSATION(U.Shs)</th>
                <th>REMARKS</th>
            </tr>
        </thead>
        <tbody>
            <?php //current_papId
            $pap_id = 0;
            $total_take_acreage = $wl_acreage = $row_acreage = 0;
            $row_land_value = $wl_land_value = 0;
            $project_land_value = $total_row_land_value = $total_wl_land_value = $total_crops_value = $total_properties_value = 0;
            foreach ($project_paps as $key => $project_pap):
                //lets get the crops and properties for this PAP
                $pap_crops = $pap_crop_tree_obj->findPapCropTrees("pap_id=".$project_pap['id']);
                $pap_properties = $pap_improvement_obj->findPapImprovements("pap_id=".$project_pap['id']);
                //total count of the crops
                $crops_count = $properties_count = $max_crop_props = 0;
                if($pap_crops !== FALSE){
                    $crops_count = count($pap_crops);
                }
                if($properties_count !== FALSE){
                    $properties_count = count($pap_properties);
                }

					//max count of properties or trees for the pap
					$max_crop_props_cnt = ($crops_count === $properties_count)?$crops_count:($crops_count > $properties_count?$crops_count:$properties_count);
					for($i = 0; $i<$max_crop_props_cnt; $i++):
					?>
					<tr>
						<td><?php echo ($i === 0)? ("<a href='project_details.php?id=".$project_pap['project_id']."&pap_id=".$project_pap['id']."'>".$project_pap['pap_ref']."</a>") :""; ?></td>
						<td><?php echo ($i === 0)?($project_pap['firstname']. " " . $project_pap['othername'] . " " . $project_pap['lastname']):""; ?></td>
						<td><?php echo ($i === 0)?$project_pap['phone_contact']:""; ?></td>
						<td><?php echo ($i === 0)?($project_pap['district_name']. ", " . $project_pap['subcounty_name'] . ", " . $project_pap['parish_name'] . ", " . $project_pap['village_name']):""; ?></td>
						<td><?php if($i === 0){echo $project_pap['chainage'];} ?></td>
						<td><?php if(isset($pap_properties[$i])){echo $pap_properties[$i]['propertytype']; ?> <?php echo $pap_properties[$i]['propertydescription'];} ?></td>
						<td><?php if(isset($pap_properties[$i])){echo $pap_properties[$i]['quantity'];} ?></td>
						<td><?php if(isset($pap_properties[$i])){echo number_format((int)$pap_properties[$i]['old_rate']);} ?></td>
						<td><?php if(isset($pap_properties[$i])){ $property_value = $pap_properties[$i]['old_rate'] * $pap_properties[$i]['quantity'];echo number_format($property_value);}?></td>
						<td><?php if(isset($pap_crops[$i])){ echo $pap_crops[$i]['croptype']; ?> <?php echo $pap_crops[$i]['cropdescription']; }?></td>
						<td><?php if(isset($pap_crops[$i])){ echo $pap_crops[$i]['quantity']; }?></td>
						<td><?php if(isset($pap_crops[$i])){ echo number_format((int)$pap_crops[$i]['old_rate']); }?></td>
						<td><?php if(isset($pap_crops[$i])){ $crop_value = $pap_crops[$i]['old_rate'] * $pap_crops[$i]['quantity']; echo number_format($crop_value); }?></td>
						<td><?php echo ($i === 0)?$project_pap['tenure_desc']:""; ?></td>
						<?php
						//ROW or Both ROW and WL
						if ($projectDetails['project_category_unit'] == 1 || $projectDetails['project_category_unit'] == 4):
							?>
							<td><?php if($i === 0){ echo $project_pap['rightofway']*1;  $row_acreage += $project_pap['rightofway']; } ?></td>
						<?php endif; ?>
						<?php
						//Way Leave or both ROW and WL
						if ($projectDetails['project_category_unit'] == 2 || $projectDetails['project_category_unit'] == 4):
							?>
							<td><?php if($i === 0){ echo $project_pap['way_leave']*1;  $wl_acreage += $project_pap['way_leave']; } ?></td>
						<?php endif; ?>
						<?php
						//Dimunintion - Both ROW and WL Project
						if($projectDetails['project_category_unit'] == 4):
							?>
							<td><?php if($i === 0){ echo ($project_pap['rightofway'] + $project_pap['way_leave'] ) * 1;  $total_take_acreage += ($project_pap['rightofway'] + $project_pap['way_leave'] ); } ?></td>
						<?php endif; ?>
						<?php
						//Total Take/Size Project
						if($projectDetails['project_category_unit'] == 5):
							?>
							<td><?php if($i === 0){ echo $project_pap['total_take'] * 1;  $total_take_acreage += $project_pap['total_take']; } ?></td>
						<?php endif; ?>
						<?php if ($projectDetails['project_category_unit'] == 1 || $projectDetails['project_category_unit'] == 4 || $projectDetails['project_category_unit'] == 5):
							?>
							<td><?php echo ($i === 0) ? number_format($project_pap['rate_per_acre']) : ""; ?></td>	
							<td><?php if($i === 0){echo $project_pap['land_interest']."%";} ?></td>
							<?php
						endif;
						if ($projectDetails['project_category_unit'] == 4):
							?>
							<td><?php echo ($i === 0)? (number_format($project_pap['diminution_rate'])."%"): ""; ?></td>
						<?php endif; ?>
						<?php
						//Way Leave or both ROW and WL
						if ($projectDetails['project_category_unit'] == 2 || $projectDetails['project_category_unit'] == 4):
							?>
							<td><?php if($i === 0){$total_land_value = $wl_land_value = $project_pap['way_leave'] * $project_pap['rate_per_acre'] * ($project_pap['land_interest'] / 100) * ($project_pap['diminution_rate'] / 100);
							echo number_format($wl_land_value); $total_wl_land_value += $wl_land_value; } ?></td>
						<?php endif; ?>
							<?php
							//Right of Way or Both ROW and WL
							if ($projectDetails['project_category_unit'] == 1 || $projectDetails['project_category_unit'] == 4):
								?>
							<td><?php if($i === 0){$row_land_value = $project_pap['rightofway'] * $project_pap['rate_per_acre'] * ($project_pap['land_interest'] / 100);
							echo number_format($row_land_value); $total_row_land_value += $row_land_value;}
								?></td>
							<?php endif; ?>
							<?php
						//Total land value, applies to ROW, (Both ROW and WL)
						if ($projectDetails['project_category_unit'] == 1 || $projectDetails['project_category_unit'] == 4 ):
							?>
							<td><?php if($i === 0){$total_land_value = (isset($wl_land_value) ? $wl_land_value : 0) + (isset($row_land_value) ? $row_land_value : 0);
							echo number_format($total_land_value); $project_land_value += $total_land_value;}
							?></td>
						<?php endif; 
						// Applicable to Total Take/Size
						if ($projectDetails['project_category_unit'] == 5):
							?>
							<td><?php if($i === 0){$total_land_value = $project_pap['total_take'] * $project_pap['rate_per_acre'] * ($project_pap['land_interest'] / 100);
							echo number_format($total_land_value); $project_land_value += $total_land_value;}
							?></td>
						<?php endif; ?>
						<td><?php if($i === 0){echo number_format($project_pap['improvement_sum']);} ?></td>
						<td><?php if($i === 0){; echo number_format($project_pap['crop_tree_sum']);} ?></td>
						<td><?php if($i === 0){$sub_total = $total_land_value + $project_pap['crop_tree_sum'] + $project_pap['improvement_sum']; echo number_format($sub_total);} ?></td>
						<td><?php if($i === 0){$disturbance_allowance = $sub_total * ($projectDetails['disturbance_allowance'] / 100); echo number_format($disturbance_allowance);} ?></td>
						<td><?php if($i === 0){$total_compensation = $sub_total + $disturbance_allowance; echo number_format($total_compensation);} ?></td>
						<td><?php if($i === 0){echo $project_pap['comment'];} ?></td>
						<?php //total sum for the properties and crops
						if($i === 0){
							 $total_crops_value += $project_pap['crop_tree_sum'];
							 $total_properties_value += $project_pap['improvement_sum'];
						}
						?>
					</tr>
					<?php endfor; ?>
					
					<tr>
						<td>&nbsp;</td>
						<td>&nbsp;</td>
						<td>&nbsp;</td>
						<td>&nbsp;</td>
						<td>&nbsp;</td>
						<td>&nbsp;</td>
						<td>&nbsp;</td>
						<td>&nbsp;</td>
						<td>&nbsp;</td>
						<td>&nbsp;</td>
						<td>&nbsp;</td>
						<td>&nbsp;</td>
						<td>&nbsp;</td>
						<td>&nbsp;</td>
						<?php
						//ROW or Both ROW and WL
						if ($projectDetails['project_category_unit'] == 1 || $projectDetails['project_category_unit'] == 4):
							?>
							<td>&nbsp;</td>
						<?php endif; ?>
						<?php
						//Way Leave or both ROW and WL
						if ($projectDetails['project_category_unit'] == 2 || $projectDetails['project_category_unit'] == 4):
							?>
							<td>&nbsp;</td>
						<?php endif; ?>
						<?php
						//Total Take/Size Project
						if ($projectDetails['project_category_unit'] == 5 || $projectDetails['project_category_unit'] == 4):
							?>
							<td>&nbsp;</td>
						<?php endif; ?>
						<?php if ($projectDetails['project_category_unit'] == 1 || $projectDetails['project_category_unit'] == 4 || $projectDetails['project_category_unit'] == 5):
							?>
							<td>&nbsp;</td>	
							<td>&nbsp;</td>
							<?php
						endif;
						if ($projectDetails['project_category_unit'] == 4):
							?>
							<td>&nbsp;</td>
						<?php endif; ?>
						<?php
						//Way Leave or both ROW and WL
						if ($projectDetails['project_category_unit'] == 2 || $projectDetails['project_category_unit'] == 4):
							?>
							<td>&nbsp;</td>
						<?php endif; ?>
							<?php
							//Right of Way or Both ROW and WL
							if ($projectDetails['project_category_unit'] == 1 || $projectDetails['project_category_unit'] == 4):
								?>
							<td>&nbsp;</td>
							<?php endif; ?>
							<?php
						//Total land value, applies to ROW, (Both ROW and WL) and Total Take/Size
						if ($projectDetails['project_category_unit'] == 1 || $projectDetails['project_category_unit'] == 4 || $projectDetails['project_category_unit'] == 5):
							?>
							<td>&nbsp;</td>
						<?php endif; ?>
						<td>&nbsp;</td>
						<td>&nbsp;</td>
						<td>&nbsp;</td>
						<td>&nbsp;</td>
						<td>&nbsp;</td>
						<td>&nbsp;</td>
						
					</tr>
                <?php endforeach; ?>
        </tbody>
        <tfoot>
            <tr>
                <th>Total</th>
                <th colspan="4">&nbsp;</th>
                <th>&nbsp;</th>
                <th>&nbsp;</th>
                <th>&nbsp;</th>
                <th><?php echo number_format($total_properties_value); ?></th>
                <th>&nbsp;</th>
                <th>&nbsp;</th>
                <th>&nbsp;</th>
                <th><?php echo number_format($total_crops_value)?></th>
                <td>&nbsp;</td>
                <?php if ($projectDetails['project_category_unit'] == 2 || $projectDetails['project_category_unit'] == 4): ?>
                    <th><?php echo number_format($wl_acreage,4)?></th>
                <?php endif; ?>
                <?php if ($projectDetails['project_category_unit'] == 1 || $projectDetails['project_category_unit'] == 4): ?>
                    <th><?php echo number_format($row_acreage,4)?></th>
                <?php endif; ?>
                <?php if ($projectDetails['project_category_unit'] == 5 || $projectDetails['project_category_unit'] == 4): ?>
                    <th><?php echo number_format($total_take_acreage,4)?></th>
                    <?php endif; ?>
                <?php 
                if ($projectDetails['project_category_unit'] == 1 || $projectDetails['project_category_unit'] == 4 || $projectDetails['project_category_unit'] == 5):
                    ?>
                    <th>&nbsp;</th>	
                    <th>&nbsp;</th>
                <?php endif; ?>
                <?php if ($projectDetails['project_category_unit'] == 4): ?>
                    <th>&nbsp;</th>	
                <?php endif; ?>
                <?php
                //Right of Way or Both ROW and WL
                if ($projectDetails['project_category_unit'] == 1 || $projectDetails['project_category_unit'] == 4):
                    ?>
                    <th><?php echo number_format($row_land_value); ?></th>
                <?php endif; ?>
                <?php
                //Way Leave or both ROW and WL
                if ($projectDetails['project_category_unit'] == 2 || $projectDetails['project_category_unit'] == 4): ?>
                    <th><?php echo number_format($wl_land_value); ?></th>
                <?php endif; ?>
                <?php if ($projectDetails['project_category_unit'] == 1 || $projectDetails['project_category_unit'] == 4 || $projectDetails['project_category_unit'] == 5): ?>	
                <th><?php echo number_format($project_land_value); ?></th>
                <?php endif; ?>
                <th><?php echo number_format($total_properties_value); ?></th>
                <th><?php echo number_format($total_crops_value)?></th>
                <th><?php $gsubTotal = $project_land_value+$total_crops_value+$total_properties_value; echo number_format($gsubTotal)?></th>
                <th><?php $diminutionVal = $gsubTotal * ($projectDetails['disturbance_allowance'] / 100); echo number_format( $diminutionVal )?></th>
                <th><?php echo number_format($gsubTotal+$diminutionVal)?></th>
                <th>&nbsp;</th>
            </tr>
	</tfoot>
    </table>
</div>
</div>
<!-- end PAPs Report section -->
