<?php 
require_once("lib/DistrictPropertyRate.php");
$a  = new DistrictPropertyRate();
$b = $a->findDistrictPropertyRates();
print_r($b);
echo "M<";
?>