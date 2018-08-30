<?php

require_once("lib/Libraries.php");
if (isset($_POST['tbl'])) {
    $msg = "";
    switch ($_POST['tbl']) {

        case "crops_props":
            $pap_tree = new PAP_CropTree();
            $pap_improvement = new PAP_Improvement();
            $data['props'] = $pap_improvement->findByImprovements($_POST['id']);
            $data['crops'] = $pap_tree->findByPapCropTrees($_POST['id']);
            $msg = json_encode($data);
            /* if($details){
              foreach($details as $single){
              $msg .= '
              <p>'. $single['crop_description'].'(<span class="text-danger">'.$single['quantity'].' @ '.$single['rate']*1 .'</span>)</p>
              ';
              }
              } */
            break;

        default:
            $msg = "";
            break;
    }
    echo $msg;
}