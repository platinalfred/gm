<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<title>Import CSV</title>
</head>

<body>
<?php 
 ini_set('max_execution_time', 892801);
 ini_set('memory_limit','1000M');
require_once("lib/Db.php");
$db = new Db();
if(isset($_POST['submit'])){
	//set_time_limit(892801);
     $filename=$_POST['filename'];
     $handle = fopen("$filename", "r");
	 $run = $count = 0;
	// $fields  = array("total_take");
     while (($data = fgetcsv($handle, 90048576, ",")) !== FALSE){
		$run++;
		$data = $db->sanitizeAttributes($data);
		/* $names = explode(" ", $data[1]);
		$firstname = @$names[1];
		$lastname = $names[0];
		$othername = @$names[2];
		$interest =  (int) substr($data[6], 0, -1);
		$project_id = 10;
		$district = 24;
		$sub = 18;
		$parish = 60;
		$village = 97;
		if($firstname == ""){
			continue;
		} */
		$tenure = "";
		switch(strtolower(trim($data[2]))){
			case "mailo":
				$tenure = 7;
			break;
			case "customary":
				$tenure = 8;
			break;
			case "tenant":
				$tenure = 13;
			break;
			case "kibanja":
				$tenure = 11;
			break;
			case "licencee":
				$tenure = 9;
			break;
			
			case "freehold":
				$tenure = 10;
			break;
		
		}
		//
		$interest =  (int) substr($data[1], 0, -1);
		/* $add_d = array("project_id"=>$project_id, "pap_ref"=>$data[0],"firstname"=>$firstname,"lastname"=>$lastname,"othername"=>$othername,"phone_contact"=>$data[2],"rate_per_acre"=>$data[5], "total_take"=>$data[4], "land_interest"=>$interest, "district_id"=>$district, "subcounty_id"=>$sub, "parish_id"=>$parish, "village_id"=>$village, "tenure"=>$tenure, "comment"=>$data[7]); */
		 if($data[0] != ""){
			/*  if($db->add("tbl_paps", array("project_id", "pap_ref", "firstname", "lastname", "othername", "phone_contact", "rate_per_acre", "total_take", "land_interest", "district_id", "subcounty_id", "parish_id", "village_id", "tenure", "comment"), $add_d)){
				$run++; $count++;   //,"pap_ref='".$data[0]."'")
				//echo $run."<br/>";
			} */
			if($db->update("tbl_paps", array("comment"), array("comment"=>$data[1]), "pap_ref='".$data[0]."'")){
				$run++; $count++;   //,"pap_ref='".$data[0]."'")
				//echo $run."<br/>";
			}    
		}else{
			print_r($data); echo "<br/>";
		}   
		
	}
	echo $run ." - ". count($data);
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