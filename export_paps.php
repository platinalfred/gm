<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
        <title>Import CSV</title>
    </head>

    <body>
        <?php
        ini_set('max_execution_time', 892801);
        ini_set('memory_limit', '1000M');
        require_once("lib/Db.php");
        $db = new Db();
        if (isset($_POST['submit'])) {
            //set_time_limit(892801);
            $filename = $_POST['filename'];
            $handle = fopen("$filename", "r");
            $run = $count = 0;
            // $fields  = array("total_take");
            while (($data = fgetcsv($handle, 90048576, ",")) !== FALSE) {
                $run++;
                $data1 = $db->sanitizeAttributes($data);
                //$interest = (int) substr($data1[7], 0, -1);
                if ($data1[0] != "") {
                    /*if (trim($data1[1]) == "-") {
                        $data1[1] = 0;
                    }*/
                    //if ($db->update("tbl_paps", array("rate_per_acre", "total_take", "land_interest"), array("rate_per_acre" => (int) str_replace(",", "", $data1[3]), "total_take" => $data1[1], "land_interest" => $interest), "pap_ref='" . $data1[0] . "'")) {
                    if ($db->update("tbl_paps", array("pap_ref", "rightofway", "way_leave", "rate_per_acre", "land_interest", "diminution_rate"), array("pap_ref" => $data1[2], "rightofway" => (float) $data1[4], "way_leave" => (float) $data1[5], "rate_per_acre" => (int) $data1[6], "land_interest" => (float) $data1[7], "diminution_rate" => (float) $data1[8]), "id=" . $data1[0] )) {
                        $run++;
                        $count++;
                    }
                } else {
                    print_r($data1);
                    echo "<br/>";
                }
            }
            //echo $run ." - ". count($data);
            /* $import= "INSERT into  members(InvoiceID, InvoiceType, CustID, dtInvoice, OrigDocID, dtDue, cySaleOnly) values('$data[0]','$data[1]','$data[2]','$data[3]','$data[4]','$data[5]','$data[6]')";		
              mysql_query($import) or die(mysql_error());
              }
              fclose($handle); */
            print "Import done\n $count records updated";
        } else {
            print "<form action='' method='post'>";

            print "Type file name to import:<br>";

            print "<input type='text' name='filename' size='20'><br>";

            print "<input type='submit' name='submit' value='submit'></form>";
        }
        ?>
    </body>
</html>