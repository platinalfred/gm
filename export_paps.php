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
     $filename=$_POST['filename'];
     $handle = fopen("$filename", "r");
	 $run = $count = 0;
	 $fields  = array("total_take");
     while (($data = fgetcsv($handle, 90048576, ",")) !== FALSE){
		 $run++;
		$data = $db->sanitizeAttributes($data);
		if($data[0] != ""){
			if(trim($data[1]) == "-"){
				$data[1] = 0;
			}
			if($db->update("tbl_paps", array("rate_per_acre"),array("rate_per_acre"=>(int) str_replace(",","",$data['1'])),"pap_ref='".$data[0]."'")){
				$run++; $count++;
			} 
		}else{
			print_r($data); echo "<br/>";
		}   
		
	}
	//echo $run ." - ". count($data);
	/* $import= "INSERT into  members(InvoiceID, InvoiceType, CustID, dtInvoice, OrigDocID, dtDue, cySaleOnly) values('$data[0]','$data[1]','$data[2]','$data[3]','$data[4]','$data[5]','$data[6]')";		
       mysql_query($import) or die(mysql_error());
     }
     fclose($handle); */
     print "Import done\n $count records updated";
}else{
	print "<form action='' method='post'>";

	print "Type file name to import:<br>";

	print "<input type='text' name='filename' size='20'><br>";

	print "<input type='submit' name='submit' value='submit'></form>";
	}
   
   ?>
</body>
</html>