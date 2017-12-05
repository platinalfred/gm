<?php 
require_once("lib/Libraries.php");
if(isset($_POST['tbl'])){
	$msg = "";
	switch($_POST['tbl']){
		
		case "crops":
			$pap_tree = new PAP_CropTree();
			$details = $pap_tree->findByPapCropTrees($_POST['id']);
			if($details){
				foreach($details as $single){
					$msg .= '
						<p>'. $single['crop_description'].'(<span class="text-danger">'.$single['quantity'].' @ '.$single['rate']*1 .'</span>)</p>
						';
				}
			}
		break;
		case "improvements":
			$pap_improvement = new PAP_Improvement();
			$details = $pap_improvement->findByImprovements($_POST['id']);
			if($details){
				foreach($details as $single){
					$msg .= '
						<p>'. $single['improvement_description'] .'(<span class="text-danger">'.$single['quantity'].' @ '.$single['rate']*1 .'</span>)</p>
						';
				}
			}
		break;
		default:
			$msg =  "";
		break;
	}
	echo $msg;
}

?>