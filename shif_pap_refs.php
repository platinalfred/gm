<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<title>Import CSV</title>
</head>

<body>
<?php 
require_once("lib/Db.php");
$db = new Db();
if(isset($_POST['submit'])){
	set_time_limit(892801);
        $count = 0;
        for($i = 200; $i > 10; $i--){
            
            $result = $update_sql = "UPDATE `tbl_paps` SET `pap_ref` = 'MKR". sprintf("%03d", $i+1)."' WHERE `pap_ref` = 'MKR". sprintf("%03d", $i)."'";
            //$result = $db->update("tbl_paps", array("pap_ref"), array("pap_ref"=>"MKR". sprintf("%03d", $i+2)),"'MKR". sprintf("%03d", $i)."'");
            $update_db = $db->query($update_sql);//
            if($result){ $count++; }
        }
     /* $filename=$_POST['filename'];
     $handle = fopen("$filename", "r");
	 $run = $count = 0;
	 $fields  = array("total_take","land_interest","rate_per_acre");
     while (($data = fgetcsv($handle, 90048576, ",")) !== FALSE){
		 $run++;
		$data = $db->sanitizeAttributes($data);
		if($data[0] != ""){
			if(trim($data[3]) == "-"){
				$data[3] = 0;
			}
			if($db->update("tbl_paps", $fields,array("total_take"=>(double)$data[1],"land_interest"=>(int)$data[2],"rate_per_acre"=>(int) $data['3']),"pap_ref='".$data[0]."'")){
				$run++; $count++;
			} 
		}else{
			//print_r($data); echo "<br/>";
		}   
		
	}
	//echo $run ." - ". count($data);
	/* $import= "INSERT into  members(InvoiceID, InvoiceType, CustID, dtInvoice, OrigDocID, dtDue, cySaleOnly) values('$data[0]','$data[1]','$data[2]','$data[3]','$data[4]','$data[5]','$data[6]')";		
       mysql_query($import) or die(mysql_error());
     }
     fclose($handle); */
     print "Update done.<br/> $count records updated";
}else{
	print "<form action='' method='post'>";

	print "Type file name to import:<br>";

	print "<input type='text' name='filename' size='20'><br>";

	print "<input type='submit' name='submit' value='submit'></form>";
	}
   
   ?>
</body>
</html>