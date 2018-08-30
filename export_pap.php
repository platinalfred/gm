<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
        <title>Import CSV</title>
    </head>

    <body>
        <?php
        ini_set('max_execution_time', 3000);
        ini_set('memory_limit', '1000M');
        require_once("lib/Db.php");
        $db = new Db();
        if (isset($_POST['submit'])) {
            //set_time_limit(892801);
            $filename = $_POST['filename'];
            $handle = fopen("$filename", "r");
            $run = $count = 0;
            // $fields  = array("total_take");
            $fields = array();
            while (($data = fgetcsv($handle, 90048576, ",")) !== FALSE) {
                $run++;
                $data = $db->sanitizeAttributes($data);

                if ($count == 0) {
                    for ($a = 0; $a < count($data); $a++) {
                        $fields[] = $data[$a];
                    }
                } else {
                    for ($i = 0; $i < count($data); $i++) {

                        if ($i == 4) {
                            $customery = strtolower($data[4]);
                            switch ($customery) {
                                case "license":
                                    $tenure = 9;
                                    break;
                                case "mailo":
                                    $tenure = 7;
                                    break;
                                case "customary":
                                    $tenure = 8;
                                    break;
                                case "frehold":
                                    $tenure = 10;
                                    break;
                                case "kibanja":
                                    $tenure = 11;
                                    break;
                                case "leasehold":
                                    $tenure = 12;
                                    break;
                                case "tenant":
                                    $tenure = 13;
                                    break;
                            }
                            $fielddata[$fields[4]] = $tenure;
                        } else {
                            $fielddata[$fields[$i]] = $data[$i];
                        }
                    }
                    if ($data[0] != "") {
                        if ($db->update("tbl_paps", $fields, $fielddata, "pap_ref='" . $data[0] . "'")) {
                            $run++;
                        }
                    } else {
                        print_r($data);
                        echo "<br/>";
                    }
                }
                $count++;
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