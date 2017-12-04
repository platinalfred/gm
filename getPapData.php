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
						<p>'. $single['crop_description'].'(<span class="text-danger">'.$single['quantity'].'</span>)</p>
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