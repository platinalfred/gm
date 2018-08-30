<?php
$show_main = false;
$needed_files = array("dataTables", "iCheck", "jasny", "knockout", "moment");
include("includes/header.php");
$tree_crop_description = new TreeCropTypesDescription();
$districts = new Districts();
$counties = new Counties();
$subcounties = new SubCounties();
$parishes = new Parish();
$villages = new Village();
$propertytypedescription = new PropertyTypeDescription();
$unit_of_measure_obj = new UnitOfMeasure();
$all_districts = $districts->findAll();
$units_of_measure = $unit_of_measure_obj->findAll();
//$all_counties = $counties->findAll();							
//$all_subcounties = $subcounties->findAll();							
//$all_parishes = $parishes->findAll();							
//$all_villages = $villages->findAll();							
?>
<div class="container-fluid main-content">
    <div class="page-title">
        <h1>Settings</h1>
    </div>
    <div class="row">
        <div class="col-lg-12">
            <div class="widget-container fluid-height clearfix">
                <div class="tabs-container">
                    <ul class="nav nav-tabs">

                        <li  class="active"><a data-toggle="tab" href="#tab-2" >Land Acquisition Types</a></li>
                        <li><a data-toggle="tab" href="#tab-5" >Crop/Tree Description</a></li>
                        <li class=""><a data-toggle="tab" href="#tab-3" >Crop/Tree Types</a></li>
                        <li class=""><a data-toggle="tab" role="tab" href="#tab-11" href="#">Crop/Tree Rates</a></li>

                        <li class=""><a data-toggle="tab"  href="#tab-7" href="#">Improvement Description</a></li>
                        <li class=""><a data-toggle="tab"  href="#tab-8" href="#">Improvement</a></li>
                        <li class=""><a data-toggle="tab" role="tab" href="#tab-12" href="#">Improvement Rates</a></li>
                        <li class=""><a role="tab" data-toggle="tab" href="#tab-6" >Districts</a></li>
                        <li><a data-toggle="tab" role="tab" href="#tab-17" >Expense Types</a></li>
                        <li class="dropdown">
                            <a class="dropdown-toggle" data-toggle="dropdown" href="#">More <b class="caret"></b></a>
                            <ul class="dropdown-menu">
                                <li><a data-toggle="tab" role="tab" href="#tab-24" >Comments</a></li>
                                <li><a data-toggle="tab" role="tab" href="#tab-23" >Positions</a></li>
                                <li class=""><a data-toggle="tab"  href="#tab-9" >Access Levels</a></li>
                                <li class=""><a data-toggle="tab"  href="#tab-banks" >Banks</a></li>
                                <!---->
                                <!--<li class=""><a data-toggle="tab" role="tab" href="#tab-15" href="#">Repayment Duration</a></li> -->

                                <!--li class=""><a data-toggle="tab" role="tab" href="#tab-16" href="#">Security Types</a></li>
                                
                                <li class=""><a data-toggle="tab" role="tab" href="#tab-19" href="#">Marital Status</a></li>
                                <li class=""><a data-toggle="tab" role="tab" href="#tab-22" href="#">Expense Type</a></li !-->
                            </ul>
                        </li>
                    </ul>
                    <div class="tab-content">
                        <!---  Land Access Category Unit   --->
                        <div id="tab-2" class="tab-pane active">
                            <div class="col-lg-12">
                                <div class="action-buttons">
                                    <a  data-toggle="modal" href="#categoryUnitModal"><i class="fa fa-plus"></i> Add New</a>
                                </div>
                                <div class="modal fade" id="categoryUnitModal">
                                    <div class="modal-dialog">
                                        <div class="modal-content">
                                            <div class="modal-header">
                                                <button aria-hidden="true" class="close" data-dismiss="modal" type="button">&times;</button>
                                                <h4 class="modal-title">Land Acquisition Category Unit</h4>
                                            </div>
                                            <div class="modal-body">
                                                <?php include("add_acquisition_category_unit.php"); ?>
                                            </div>
                                        </div>
                                    </div>
                                </div>

                            </div>
                            <div class="heading">
                                <i class="fa fa-bars"></i>Land Acquisition Category Unit
                            </div>
                            <div class="widget-content padded">
                                <table class="table table-bordered table-striped" id="land_acquistion_category_unit">
                                    <thead>
                                    <th>Title</th>
                                    <th>Description</th>
                                    <th></th>
                                    </thead>
                                    <tbody>

                                    </tbody>
                                </table>
                            </div>

                        </div>
                        <!---  Districts   --->
                        <div id="tab-6" class="tab-pane">
                            <br/>
                            <div class="tabs-container">
                                <ul class="nav nav-tabs">
                                    <li class="active"><a data-toggle="tab" href="#district_tab"><i class="fa fa-list"></i> Districts</a></li>
                                    <!--<li><a data-bind='click:function(){ getServerData("counties") }' data-toggle="tab" href="#county_tab" ><i class="fa fa-briefcase"></i> Counties</a></li> -->
                                    <li><a data-bind='click:function(){ getServerData("subcounties") } ' data-toggle="tab" href="#subcounty_tab" ><i class="fa fa-briefcase"></i> Sub Counties</a></li>
                                    <li><a data-bind='click:function(){ getServerData("parishes") }' data-toggle="tab" href="#parish_tab" ><i class="fa fa-briefcase"></i> Parishes</a></li>
                                    <li><a data-bind='click:function(){ getServerData("villages") }' data-toggle="tab" href="#village_tab" ><i class="fa fa-briefcase"></i> Villages</a></li>
                                </ul>
                                <div class="tab-content">
                                    <div id="district_tab" class="tab-pane active">
                                        <div class="col-lg-12">
                                            <div class="action-buttons">
                                                <a  data-toggle="modal" href="#districts"><i class="fa fa-plus"></i> Add New</a>
                                            </div>
                                            <div id="districts" class="modal fade" aria-hidden="true">
                                                <div class="modal-dialog">
                                                    <div class="modal-content">
                                                        <div class="modal-body">
                                                            <div class="row">
                                                                <div class="col-sm-12">
                                                                    <p>Add /Update District</p>
                                                                    <div class="ibox-content">
                                                                        <form class="form-horizontal form_validate" id="tblDistricts">
                                                                            <input type="hidden" name="id" >
                                                                            <input type="hidden" name="tbl" value="tblDistricts">
                                                                            <div class="form-group"><label class="col-lg-2 control-label">Name</label>
                                                                                <div class="col-lg-10">
                                                                                    <input type="text" name="district_name" placeholder="Name" class="form-control"> 
                                                                                </div>
                                                                            </div>
                                                                            <div class="form-group">
                                                                                <div class="col-lg-offset-2 col-lg-10">
                                                                                    <button class="btn btn-sm btn-primary save" type="submit">Submit</button>
                                                                                </div>
                                                                            </div>
                                                                        </form>
                                                                    </div>
                                                                </div>

                                                            </div>
                                                        </div>
                                                    </div>
                                                </div>
                                            </div>
                                        </div>
                                        <div class="heading">
                                            <i class="fa fa-bars"></i>Districts
                                        </div>
                                        <div class="widget-content padded">
                                            <table class="table table-bordered table-striped" id="tblDistrict">
                                                <thead>
                                                <th>Name</th>
                                                <th></th>
                                                </thead>
                                                <tbody>

                                                </tbody>
                                            </table>
                                        </div>
                                    </div>
                                    <div id="county_tab" class="tab-pane">
                                        <div class="col-lg-12">
                                            <div class="action-buttons">
                                                <a  data-toggle="modal" href="#county"><i class="fa fa-plus"></i> Add New</a>
                                            </div>
                                            <div id="county" class="modal fade" aria-hidden="true">
                                                <div class="modal-dialog">
                                                    <div class="modal-content">
                                                        <div class="modal-body">
                                                            <div class="row">
                                                                <div class="col-sm-12">
                                                                    <p>Add /Update County</p>
                                                                    <div class="ibox-content">
                                                                        <form class="form-horizontal form_validate" id="tblCountys">
                                                                            <input type="hidden" name="id" >
                                                                            <input type="hidden" name="tbl"  value="county">
                                                                            <div class="form-group"><label class="col-lg-2 control-label">District</label>
                                                                                <div class="col-lg-10">
                                                                                    <select class="select2able" id="village_district" name="district"data-bind='options: districtsList, optionsText: "district_name", optionsCaption: "Select distict...", optionsAfterRender: setOptionValue("id"), value: district'>
                                                                                    </select>
                                                                                </div>
                                                                            </div>
                                                                            <div class="form-group"><label class="col-lg-2 control-label">Name</label>
                                                                                <div class="col-lg-10"><input type="text" name="county_name" placeholder="Name" class="form-control"> 
                                                                                </div>
                                                                            </div>
                                                                            <div class="form-group">
                                                                                <div class="col-lg-offset-2 col-lg-10">
                                                                                    <button class="btn btn-sm btn-primary save" type="submit">Submit</button>
                                                                                </div>
                                                                            </div>
                                                                        </form>
                                                                    </div>
                                                                </div>

                                                            </div>
                                                        </div>
                                                    </div>
                                                </div>
                                            </div>
                                        </div>
                                        <div class="heading">
                                            <i class="fa fa-bars"></i>Counties
                                        </div>
                                        <div class="widget-content padded">
                                            <table class="table table-bordered table-striped" id="tblCounty">
                                                <thead>
                                                    <tr>
                                                        <th id="county0">&nbsp;</th>
                                                        <th id="county1">&nbsp;</th>
                                                        <th></th>
                                                        <th></th>
                                                    </tr>
                                                    <tr>
                                                        <th>County Name</th>
                                                        <th>District Name</th>
                                                        <th>Id</th>
                                                        <th></th>
                                                    </tr>
                                                </thead>
                                                <tbody>

                                                </tbody>
                                            </table>
                                        </div>
                                    </div>
                                    <div id="subcounty_tab" class="tab-pane">
                                        <div class="col-lg-12">
                                            <div class="action-buttons">
                                                <a  data-toggle="modal" href="#subcounty"><i class="fa fa-plus"></i> Add New</a>
                                            </div>
                                            <div id="subcounty" class="modal fade" aria-hidden="true">
                                                <div class="modal-dialog">
                                                    <div class="modal-content">
                                                        <div class="modal-body">
                                                            <div class="row">
                                                                <div class="col-sm-12">
                                                                    <p>Add /Update SubCounty</p>
                                                                    <div class="ibox-content">
                                                                        <form class="form-horizontal form_validate" id="tblSubCountys">
                                                                            <input type="hidden" name="id" >
                                                                            <input type="hidden" name="noreset" >
                                                                            <input type="hidden" name="tbl"  value="tblSubCounty">
                                                                            <div class="form-group">	
                                                                                <label class="col-lg-2 control-label">District</label>
                                                                                <div class="col-lg-10">
                                                                                    <select class="select2able"  name="district"data-bind='options: districtsList, optionsText: "district_name", optionsCaption: "Select distict...", optionsAfterRender: setOptionValue("id"), value: district'>
                                                                                    </select>
                                                                                </div>
                                                                            </div>
                                                                            <!--div class="form-group"><label class="col-lg-2 control-label">County</label>
                                                                                    <div class="col-lg-10">
                                                                                            <select class="select2able" id="village_county" name="county"   data-bind='options: filteredCountiesList, optionsText: "county_name", optionsCaption: "Select county...", optionsAfterRender: setOptionValue("id"), value: county'>
                                                                                            </select>
                                                                                    </div>
                                                                            </div -->

                                                                            <div class="form-group"><label class="col-lg-2 control-label">Name</label>
                                                                                <div class="col-lg-10"><input required type="text" name="subcounty_name" placeholder="Name" class="form-control" > 
                                                                                </div>
                                                                            </div>
                                                                            <div class="form-group">
                                                                                <div class="col-lg-offset-2 col-lg-10">
                                                                                    <button class="btn btn-sm btn-primary save" type="submit">Submit</button>
                                                                                </div>
                                                                            </div>
                                                                        </form>
                                                                    </div>
                                                                </div>

                                                            </div>
                                                        </div>
                                                    </div>
                                                </div>
                                            </div>
                                        </div>
                                        <div class="heading">
                                            <i class="fa fa-bars"></i>SubCounties
                                        </div>
                                        <div class="widget-content padded">
                                            <table class="table table-bordered table-striped" id="tblSubCounty">
                                                <thead>
                                                    <tr>
                                                        <th id="subcounty0">&nbsp;</th>
                                                        <!--<th id="subcounty1">&nbsp;</th>-->
                                                        <th id="subcounty1">&nbsp;</th>
                                                        <th></th>
                                                        <th></th>
                                                    </tr>
                                                    <tr>
                                                        <th>Subcounty</th>
                                                        <!--<th >County</th>-->
                                                        <th >District</th>
                                                        <th>Id</th>
                                                        <th></th>
                                                    </tr>
                                                </thead>
                                                <tbody>

                                                </tbody>
                                            </table>
                                        </div>
                                    </div>
                                    <div id="parish_tab" class="tab-pane">
                                        <div class="col-lg-12">
                                            <div class="action-buttons">
                                                <a  data-toggle="modal" href="#parish"><i class="fa fa-plus"></i> Add New</a>
                                            </div>
                                            <div id="parish" class="modal fade" aria-hidden="true">
                                                <div class="modal-dialog">
                                                    <div class="modal-content">
                                                        <div class="modal-body">
                                                            <div class="row">
                                                                <div class="col-sm-12">
                                                                    <p>Add /Update Parish</p>
                                                                    <div class="ibox-content">
                                                                        <form class="form-horizontal form_validate" id="tblParishs">
                                                                            <input type="hidden" name="id" >
                                                                            <input type="hidden" name="noreset" >
                                                                            <input type="hidden" name="tbl" value="tblParishs">
                                                                            <div class="form-group">	
                                                                                <label class="col-lg-2 control-label">District</label>
                                                                                <div class="col-lg-10">
                                                                                    <select class="select2able" id="parish_district" name="district" data-bind='options: districtsList, optionsText: "district_name", optionsCaption: "Select distict...", optionsAfterRender: setOptionValue("id"), value: district'>
                                                                                    </select>
                                                                                </div>
                                                                            </div>
                                                                            <!--div class="form-group"><label class="col-lg-2 control-label">County</label>
                                                                                    <div class="col-lg-10">
                                                                                            <select class="select2able" id="village_county" name="county"   data-bind='options: filteredCountiesList, optionsText: "county_name", optionsCaption: "Select county...", optionsAfterRender: setOptionValue("id"), value: county'>
                                                                                            </select>
                                                                                    </div>
                                                                            </div -->
                                                                            <div class="form-group">
                                                                                <label class="col-lg-2 control-label">Sub county</label>
                                                                                <div class="col-lg-10">
                                                                                    <select class="select2able" id="parish_subcounty" name="subcounty" data-bind='options: filteredSCountiesList, optionsText: "subcounty_name", optionsCaption: "Select subcounty...", optionsAfterRender: setOptionValue("id"), value: scounty'>
                                                                                    </select>
                                                                                </div>
                                                                            </div>
                                                                            <div class="form-group"><label class="col-lg-2 control-label">Name</label>
                                                                                <div class="col-lg-10"><input type="text" name="parish_name" placeholder="Name" class="form-control"> 
                                                                                </div>
                                                                            </div>
                                                                            <div class="form-group">
                                                                                <div class="col-lg-offset-2 col-lg-10">
                                                                                    <button class="btn btn-sm btn-primary save" type="submit">Submit</button>
                                                                                </div>
                                                                            </div>
                                                                        </form>
                                                                    </div>
                                                                </div>

                                                            </div>
                                                        </div>
                                                    </div>
                                                </div>
                                            </div>
                                        </div>
                                        <div class="heading">
                                            <i class="fa fa-bars"></i>Parishes
                                        </div>
                                        <div class="widget-content padded">
                                            <table class="table table-bordered table-striped" id="tblParish">
                                                <thead>
                                                    <tr>
                                                        <th id="parish0">&nbsp;</th>
                                                        <th id="parish1">&nbsp;</th>
                                                        <!--<th id="parish2">&nbsp;</th>-->
                                                        <th id="parish2">&nbsp;</th>
                                                        <th></th>
                                                        <th></th>
                                                    </tr>
                                                    <tr>
                                                        <th>Parish</th>
                                                        <th>Subcounty</th>
                                                        <!--<th >County</th>-->
                                                        <th >District</th>
                                                        <th></th>
                                                        <th></th>
                                                    </tr>
                                                </thead>
                                                <tbody>

                                                </tbody>
                                            </table>
                                        </div>
                                    </div>
                                    <div id="village_tab" class="tab-pane">
                                        <div class="col-lg-12">
                                            <div class="action-buttons">
                                                <a  data-toggle="modal" href="#villages"><i class="fa fa-plus"></i> Add New</a>
                                            </div>
                                            <div id="villages" class="modal fade" aria-hidden="true">
                                                <div class="modal-dialog">
                                                    <div class="modal-content">
                                                        <div class="modal-body">
                                                            <div class="row">
                                                                <div class="col-sm-12">
                                                                    <p>Add /Update Village</p>
                                                                    <div class="ibox-content">
                                                                        <form class="form-horizontal form_validate"id="tblVillages">
                                                                            <input type="hidden" name="id" >
                                                                            <input type="hidden" name="tbl" value="tblVillages">
                                                                            <div class="form-group">
                                                                                <label class="col-lg-2 control-label">District</label>
                                                                                <div class="col-lg-10">
                                                                                    <select class="select2able" id="village_district" name="district"data-bind='options: districtsList, optionsText: "district_name", optionsCaption: "Select distict...", optionsAfterRender: setOptionValue("id"), value: district'>
                                                                                    </select>
                                                                                </div>
                                                                            </div>
                                                                            <!--<div class="form-group"><label class="col-lg-2 control-label">County</label>
                                                                                    <div class="col-lg-10">
                                                                                            <select class="select2able" id="village_county" name="county"   data-bind='options: filteredCountiesList, optionsText: "county_name", optionsCaption: "Select county...", optionsAfterRender: setOptionValue("id"), value: county'>
                                                                                            </select>
                                                                                    </div>
                                                                            </div>-->
                                                                            <div class="form-group"><label class="col-lg-2 control-label">Sub county</label>
                                                                                <div class="col-lg-10">
                                                                                    <select class="select2able" id="village_subcounty" name="subcounty" data-bind='options: filteredSCountiesList, optionsText: "subcounty_name", optionsCaption: "Select subcounty...", optionsAfterRender: setOptionValue("id"), value: scounty'>
                                                                                    </select>
                                                                                </div>
                                                                            </div>
                                                                            <div class="form-group"><label class="col-lg-2 control-label">Parish</label>
                                                                                <div class="col-lg-10">
                                                                                    <select class="select2able" id="village_parish" name="parish"   data-bind='options: filteredParishesList, optionsText: "parish_name", optionsCaption: "Select parish...", optionsAfterRender: setOptionValue("id"), value: parish'>
                                                                                    </select>
                                                                                </div>
                                                                            </div>
                                                                            <div class="form-group"><label class="col-lg-2 control-label">Name</label>
                                                                                <div class="col-lg-10"><input type="text" name="village_name" placeholder="Name" class="form-control"> 
                                                                                </div>
                                                                            </div>
                                                                            <div class="form-group">
                                                                                <div class="col-lg-offset-2 col-lg-10">
                                                                                    <button class="btn btn-sm btn-primary save" type="submit">Submit</button>
                                                                                </div>
                                                                            </div>
                                                                        </form>
                                                                    </div>
                                                                </div>

                                                            </div>
                                                        </div>
                                                    </div>
                                                </div>
                                            </div>
                                        </div>
                                        <div class="heading">
                                            <i class="fa fa-bars"></i>Villages
                                        </div>
                                        <div class="widget-content padded">
                                            <table class="table table-bordered table-striped" id="tblVillage">
                                                <thead>
                                                    <tr>
                                                        <th id="village0">&nbsp;</th>
                                                        <th id="village1">&nbsp;</th>
                                                        <th id="village2">&nbsp;</th>
                                                        <!--<th id="village3">&nbsp;</th>-->
                                                        <th id="village3">&nbsp;</th>
                                                        <th></th>
                                                        <th></th>
                                                    </tr>
                                                    <tr>
                                                        <th>Village</th>
                                                        <th>Parish</th>
                                                        <th>Subcounty</th>
                                                        <!--<th >County</th>-->
                                                        <th >District</th>
                                                        <th>Id</th>
                                                        <th></th>
                                                    </tr>
                                                </thead>
                                                <tbody>

                                                </tbody>
                                            </table>
                                        </div>
                                    </div>
                                </div>
                            </div>
                        </div>
                        <!-- Tree or Crop Types -->
                        <div id="tab-3" class="tab-pane">
                            <div class="panel-body">
                                <div class="col-lg-2 col-offset-sm-8">
                                    <div class="action-buttons">
                                        <a  data-toggle="modal" href="#treecrops"><i class="fa fa-plus"></i> Add New</a>
                                    </div>
                                    <div id="treecrops" class="modal fade" aria-hidden="true">
                                        <div class="modal-dialog">
                                            <div class="modal-content">
                                                <div class="modal-body">
                                                    <div class="row">
                                                        <div class="col-sm-12">
                                                            <p>Add /Update Tree or Crop Type</p>
                                                            <div class="ibox-content">
                                                                <form class="form-horizontal form_validate" id="tblTreeCrops">
                                                                    <input type="hidden" name="id" >
                                                                    <input type="hidden" name="tbl"  value="treecroptypes">
                                                                    <div class="form-group"><label class="col-lg-2 control-label">Title</label>
                                                                        <div class="col-lg-10"><input type="text" name="title" placeholder="Title" class="form-control"> 
                                                                        </div>
                                                                    </div>
                                                                    <div class="form-group"><label class="col-lg-2 control-label">Unit of measure</label>
                                                                        <div class="col-lg-10">
                                                                            <select id="measure_id" name="measure_id" class="select2able">
                                                                                <?php
                                                                                $units_of_measure_options = "";
                                                                                if ($units_of_measure) {
                                                                                    foreach ($units_of_measure as $single) {
                                                                                        $units_of_measure_options .= "<option value=\"".$single['id']."\">".$single['measure_unit']." (".$single['short_form'].")</option>";
                                                                                    }
                                                                                    echo $units_of_measure_options;
                                                                                }
                                                                                ?>
                                                                            </select>
                                                                        </div>
                                                                    </div>
                                                                    <div class="form-group"><label class="col-lg-2 control-label">Notes</label>
                                                                        <div class="col-lg-10"><textarea  name="description" placeholder="add Note" class="form-control"></textarea></div>
                                                                    </div>
                                                                    <div class="form-group">
                                                                        <div class="col-lg-offset-2 col-lg-10">
                                                                            <button class="btn btn-sm btn-primary save" type="submit">Submit</button>
                                                                        </div>
                                                                    </div>
                                                                </form>
                                                            </div>
                                                        </div>

                                                    </div>
                                                </div>
                                            </div>
                                        </div>
                                    </div>
                                    <div id="croptypes_desc" class="modal fade" aria-hidden="true">
                                        <div class="modal-dialog">
                                            <div class="modal-content">
                                                <div class="modal-body">
                                                    <div class="row" id="tree_crop_description">
                                                                <form class="form-horizontal form_validate" >
                                                        <div class="col-sm-12" data-bind="with:tree_crop_type">
                                                            <h3><span data-bind="text:title"></span> Tree/Crop Type</h3>
                                                            <div data-bind="foreach: $parent.all_attached">
                                                                <span data-bind="text:cropdescription"></span> &nbsp;<i class="fa fa-trash-o warning" style="color:red;cursor:pointer;" title="Remove description" data-bind="confirmClick: { message: 'Are you sure you would like to delete this item?', click: $root.removeCropDescription } "></i><br/><br/>

                                                            </div>
                                                            <div class="ibox-content">
                                                                <p><b>Attach possible description to <span data-bind="text:title"></span> crop/tree type</b></p>
                                                                    <input type="hidden" value="treecroptypedescription" name="tbl">
                                                                    <input type="hidden" data-bind="value:id" name="id">
                                                                    <div class="form-group">
                                                                        <div class=" col-md-12">Choose description</div>
                                                                        <!--ko foreach: $parent.all_crop_descriptions-->
                                                                        <div class="col-md-4">
                                                                            <label class="checkbox"><input data-bind="value:id" type="checkbox" name="crop_description_id[]"><span data-bind="text: title"></span></label>
                                                                        </div>
                                                                        <!--/ko-->
                                                                    </div>
                                                                    <div class="form-group">
                                                                        <div class="col-lg-offset-2 col-lg-10">
                                                                            <button class="btn btn-sm btn-primary" type="submit">Attach description</button>
                                                                        </div>
                                                                    </div>
                                                            </div>
                                                        </div>
                                                                </form>
                                                    </div>										
                                                </div>
                                            </div>
                                        </div>
                                    </div>
                                </div>
                                <div class="col-lg-12" style="margin-top:10px;">
                                    <div class="ibox-content">
                                        <div class="table-responsive">
                                            <table class="table table-striped table-bordered table-hover" id="treeCropsTypes">
                                                <thead>
                                                    <tr>
                                                        <th>ID</th>
                                                        <th>Title</th>
                                                        <th>Unit of Measure</th>
                                                        <th>Notes</th>
                                                        <th>&nbsp;</th>
                                                    </tr>
                                                </thead>
                                                <tbody></tbody>
                                                <tfoot>
                                                    <tr>
                                                        <th>ID</th>
                                                        <th>Title</th>
                                                        <th>Unit of measure</th>
                                                        <th>Notes</th>
                                                        <th>&nbsp;</th>
                                                    </tr>
                                                </tfoot>
                                            </table>
                                        </div>
                                    </div>
                                </div>
                            </div>
                        </div>
                        <!-- End Tree or Crop Types -->

                        <!-- Tree Crop Descriptions -->
                        <div id="tab-5" class="tab-pane">
                            <div class="panel-body">
                                <div class="col-lg-2 col-offset-sm-8">
                                    <div class="action-buttons">
                                        <a  data-toggle="modal" href="#cropdescription"><i class="fa fa-plus"></i> Add New</a>
                                    </div>
                                    <div id="cropdescription" class="modal fade" aria-hidden="true">
                                        <div class="modal-dialog">
                                            <div class="modal-content">
                                                <div class="modal-body">
                                                    <div class="row">
                                                        <div class="col-sm-12">
                                                            <p>Add /Update Crop Description</p>
                                                            <div class="ibox-content">
                                                                <form class="form-horizontal form_validate" id="tblCropDescription">
                                                                    <input type="hidden" name="id" >
                                                                    <input type="hidden" name="tbl"  value="CropDescription">
                                                                    <div class="form-group"><label class="col-lg-2 control-label">Title</label>
                                                                        <div class="col-lg-10"><input type="text" name="title" placeholder="Title" class="form-control"> 
                                                                        </div>
                                                                    </div>
                                                                    <div class="form-group"><label class="col-lg-2 control-label">Notes</label>
                                                                        <div class="col-lg-10"><textarea  name="description" placeholder="add note" class="form-control"></textarea></div>
                                                                    </div>
                                                                    <div class="form-group">
                                                                        <div class="col-lg-offset-2 col-lg-10">
                                                                            <button class="btn btn-sm btn-primary save" type="submit">Submit</button>
                                                                        </div>
                                                                    </div>
                                                                </form>
                                                            </div>
                                                        </div>

                                                    </div>
                                                </div>
                                            </div>
                                        </div>
                                    </div>
                                </div>
                                <div class="col-lg-12" style="margin-top:10px;">
                                    <div class="ibox-content">
                                        <div class="table-responsive">
                                            <table class="table table-striped table-bordered table-hover" id="cropDescription">
                                                <thead>
                                                    <tr>
                                                        <th>Title</th>
                                                        <th>Notes</th>
                                                        <th></th>
                                                    </tr>
                                                </thead>
                                                <tbody></tbody>
                                                <tfoot>
                                                    <tr>
                                                        <th>Title</th>
                                                        <th>Notes</th>
                                                        <th></th>
                                                    </tr>
                                                </tfoot>
                                            </table>
                                        </div>
                                    </div>
                                </div>
                            </div>
                        </div>
                        <!-- End Tree Crop Descriptions -->
                        <!-- Property Descriptions -->
                        <div id="tab-7" class="tab-pane">
                            <div class="panel-body">
                                <div class="col-lg-2 col-offset-sm-8">
                                    <div class="action-buttons">
                                        <a  data-toggle="modal" href="#propertydescription"><i class="fa fa-plus"></i> Add New</a>
                                    </div>
                                    <div id="propertydescription" class="modal fade" aria-hidden="true">
                                        <div class="modal-dialog">
                                            <div class="modal-content">
                                                <div class="modal-body">
                                                    <div class="row">
                                                        <div class="col-sm-12">
                                                            <p>Add /Update Property Description</p>
                                                            <div class="ibox-content">
                                                                <form class="form-horizontal form_validate" id="tblPropertyDescription">
                                                                    <input type="hidden" name="id" >
                                                                    <input type="hidden" name="tbl"  value="propertyDescription">
                                                                    <div class="form-group"><label class="col-lg-2 control-label">Title</label>
                                                                        <div class="col-lg-10"><input type="text" name="title" placeholder="Title" class="form-control"> 
                                                                        </div>
                                                                    </div>
                                                                    <div class="form-group"><label class="col-lg-2 control-label">Notes</label>
                                                                        <div class="col-lg-10"><textarea  name="description" placeholder="notes" class="form-control"></textarea></div>
                                                                    </div>
                                                                    <div class="form-group">
                                                                        <div class="col-lg-offset-2 col-lg-10">
                                                                            <button class="btn btn-sm btn-primary save" type="submit">Submit</button>
                                                                        </div>
                                                                    </div>
                                                                </form>
                                                            </div>
                                                        </div>

                                                    </div>
                                                </div>
                                            </div>
                                        </div>
                                    </div>
                                </div>
                                <div class="col-lg-12" style="margin-top:10px;">
                                    <div class="ibox-content">
                                        <div class="table-responsive">
                                            <table class="table table-striped table-bordered table-hover" id="propertyDescription">
                                                <thead>
                                                    <tr>
                                                        <th>Title</th>
                                                        <th>Notes</th>
                                                        <th></th>
                                                    </tr>
                                                </thead>
                                                <tbody></tbody>
                                                <tfoot>
                                                    <tr>
                                                        <th>Title</th>
                                                        <th>Notes</th>
                                                        <th></th>
                                                    </tr>
                                                </tfoot>
                                            </table>
                                        </div>
                                    </div>
                                </div>
                            </div>
                        </div>
                        <!-- End Property Descriptions -->
                        <!-- Property -->
                        <div id="tab-8" class="tab-pane">
                            <div class="panel-body">
                                <div class="col-lg-2 col-offset-sm-8">
                                    <div class="action-buttons">
                                        <a  data-toggle="modal" href="#propertytype"><i class="fa fa-plus"></i> Add New</a>
                                    </div>
                                    <div id="propertytype" class="modal fade" aria-hidden="true">
                                        <div class="modal-dialog">
                                            <div class="modal-content">
                                                <div class="modal-body">
                                                    <div class="row">
                                                        <div class="col-sm-12">
                                                            <p>Add /Update  Property</p>
                                                            <div class="ibox-content">
                                                                <form class="form-horizontal form_validate" id="tblPropertyTypes">
                                                                    <input type="hidden" name="id" >
                                                                    <input type="hidden" name="tbl"  value="propertytypes">
                                                                    <div class="form-group"><label class="col-lg-2 control-label">Title</label>
                                                                        <div class="col-lg-10"><input type="text" name="title" placeholder="Title" class="form-control"> 
                                                                        </div>
                                                                    </div>
                                                                    <div class="form-group"><label class="col-lg-2 control-label">Unit of measure</label>
                                                                        <div class="col-lg-10">
                                                                            <select class="select2able" name="measure_unit_id" >
                                                                                <?php echo $units_of_measure_options;?>
                                                                            </select>
                                                                        </div>
                                                                    </div>
                                                                    <div class="form-group"><label class="col-lg-2 control-label">Note</label>
                                                                        <div class="col-lg-10"><textarea  name="description" placeholder="Description" class="form-control"></textarea></div>
                                                                    </div>
                                                                    <div class="form-group">
                                                                        <div class="col-lg-offset-2 col-lg-10">
                                                                            <button class="btn btn-sm btn-primary save" type="submit">Submit</button>
                                                                        </div>
                                                                    </div>
                                                                </form>
                                                            </div>
                                                        </div>

                                                    </div>
                                                </div>
                                            </div>
                                        </div>
                                    </div>
                                    <div id="property_d" class="modal fade" aria-hidden="true">
                                        <div class="modal-dialog">
                                            <div class="modal-content">
                                                <div class="modal-body">
                                                    <div class="row" id="improvement_type_desc">
                                                                <form class="form-horizontal form_validate" >
                                                        <div class="col-sm-12" data-bind="with:improvement_type">
                                                            <h3><span data-bind="text:title"></span> Property Type</h3>
                                                            <div data-bind="foreach: $parent.all_attached_improvements"><span data-bind="text:propertydescription"></span> &nbsp;<i class="fa fa-trash-o warning" style="color:red;cursor:pointer;" title="Remove description" data-bind="confirmClick: { message: 'Are you sure you would like to delete this item?', click: $root.removePropertyDescription } "></i><br/><br/></div>
                                                            <div class="ibox-content">
                                                                <p><b>Attach possible description to <span data-bind="text:title"></span> crop/tree type</b></p>
                                                                    <input type="hidden" value="improvementtypedescription" name="tbl">
                                                                    <input type="hidden" data-bind="value:id" name="id">
                                                                    <div class="form-group">
                                                                        <div class=" col-md-12">Choose description</div>
                                                                        <!--ko foreach: $parent.all_improvements_description-->
                                                                        <div class="col-md-4">
                                                                            <label class="checkbox"><input data-bind="value:id" type="checkbox" name="improvement_description_id[]"><span data-bind="text: title"></span></label>
                                                                        </div>
                                                                        <!--/ko-->
                                                                    </div>
                                                                    <div class="form-group">
                                                                        <div class="col-lg-offset-2 col-lg-10">
                                                                            <button class="btn btn-sm btn-primary" type="submit">Attach description</button>
                                                                        </div>
                                                                    </div>
                                                            </div>
                                                        </div>
                                                                </form>
                                                    </div>										

                                                </div>
                                            </div>
                                        </div>
                                    </div>
                                </div>
                                <div class="col-lg-12" style="margin-top:10px;">
                                    <div class="ibox-content">
                                        <div class="table-responsive">
                                            <table class="table table-striped table-bordered table-hover" id="tblPropertyType">
                                                <thead>
                                                    <tr>
                                                        <th>ID</th>
                                                        <th>Title</th>
                                                        <th>Unit of measure</th>
                                                        <th>Description</th>
                                                        <th>&nbsp;</th>
                                                    </tr>
                                                </thead>
                                                <tbody></tbody>
                                                <tfoot>
                                                    <tr>
                                                        <th>ID</th>
                                                        <th>Title</th>
                                                        <th>Unit of measure</th>
                                                        <th>Description</th>
                                                        <th>&nbsp;</th>
                                                    </tr>
                                                </tfoot>
                                            </table>
                                        </div>
                                    </div>
                                </div>
                            </div>
                        </div>
                        <!-- End Property -->
                        <!-- District Crop Rate -->
                        <div id="tab-11" class="tab-pane">
                            <div class="panel-body">
                                <div class="col-lg-2 col-offset-sm-8">
                                    <div class="action-buttons">
                                        <a  data-toggle="modal" href="#districtrate"><i class="fa fa-plus"></i> Add Crop/Tree Rate</a> &nbsp;
                                        <a  data-toggle="modal" href="#copydistrictrate"><i class="fa fa-files-o"></i> Copy Rates</a>
                                    </div>
                                    <div id="copydistrictrate" class="modal fade" aria-hidden="true">
                                        <div class="modal-dialog">
                                            <div class="modal-content">
                                                <div class="modal-body">
                                                    <div class="row">
                                                        <div class="col-sm-12">
                                                            <p>Copy Rate</p>			
                                                            <div class="ibox-content">
                                                                <form class="form-horizontal form_validate" method="post" id="tblDistrictCropRate">
                                                                    <input type="hidden" name="tbl" value="copy_district_rate">
                                                                    <div class="form-group">
                                                                        <label class="control-label col-md-2">From District</label>
                                                                        <div class="col-lg-10">
                                                                            <select class="select2able" name="district_from" >
                                                                                <?php
                                                                                $district_options = "";
                                                                                if ($all_districts) {
                                                                                    foreach ($all_districts as $single) {
                                                                                        $district_options .= "<option value=\"".$single['id']."\">".$single['district_name']."</option>";
                                                                                    }
                                                                                    echo $district_options;
                                                                                }
                                                                                ?>
                                                                            </select>
                                                                        </div>
                                                                    </div>
                                                                    <div class="form-group">
                                                                        <label class="control-label col-md-2">To District</label>
                                                                        <div class="col-lg-10">
                                                                            <select class="select2able" name="district_to" >
                                                                                <?php echo $district_options; ?>
                                                                            </select>
                                                                        </div>
                                                                    </div>
                                                                    <div class="form-group">
                                                                        <div class="col-lg-offset-2 col-lg-10">
                                                                            <button class="btn btn-sm btn-primary save" type="submit">Copy</button>
                                                                        </div>
                                                                    </div>
                                                                </form>
                                                            </div>
                                                        </div>

                                                    </div>
                                                </div>
                                            </div>
                                        </div>
                                    </div>
                                    <div id="districtrate" class="modal fade" aria-hidden="true">
                                        <div class="modal-dialog">
                                            <div class="modal-content">
                                                <div class="modal-body">
                                                    <div class="row">
                                                        <div class="col-sm-12">
                                                            <p>Add Rate</p>
                                                            <div class="ibox-content">
                                                                <form class="form-horizontal form_validate" method="post" id="tblDistrictCropRate">
                                                                    <input type="hidden" name="tbl" value="district_rate">
                                                                    <input type="hidden" name="id" value="">
                                                                    <div class="form-group">
                                                                        <label class="control-label col-md-2">District</label>
                                                                        <div class="col-lg-10">
                                                                            <select class="select2able" name="district_id" >
                                                                                <?php echo $district_options;?>
                                                                            </select>
                                                                        </div>
                                                                    </div>
                                                                    <div class="form-group"><label class="col-lg-2 control-label">Crop/Tree </label>
                                                                        <div class="col-lg-10">
                                                                            <select class="select2able" name="croptree_id">
                                                                                <?php
                                                                                $alldata = $tree_crop_description->findCropTreeDescription();
                                                                                if ($alldata) {
                                                                                    foreach ($alldata as $single) {
                                                                                        ?>
                                                                                        <option value="<?php echo $single['id']; ?>"><?php echo $single['cropname'] . " - " . $single['cropdescription']; ?></option>
        <?php
    }
}
?>
                                                                            </select>
                                                                        </div>
                                                                    </div>
                                                                    <div class="form-group"><label class="col-lg-2 control-label"> Rate</label>
                                                                        <div class="col-lg-10">
                                                                            <input name="rate" placeholder="rate" class="form-control athousand_separator" required></input>
                                                                        </div>
                                                                    </div>
                                                                    <div class="form-group">
                                                                        <div class="col-lg-offset-2 col-lg-10">
                                                                            <button class="btn btn-sm btn-primary save" type="submit">Submit</button>
                                                                        </div>
                                                                    </div>
                                                                </form>
                                                            </div>
                                                        </div>

                                                    </div>
                                                </div>
                                            </div>
                                        </div>
                                    </div>
                                    <div id="district_rate_edit" class="modal fade" aria-hidden="true">
                                        <div class="modal-dialog">
                                            <div class="modal-content">
                                                <div class="modal-body">
                                                </div>
                                            </div>
                                        </div>
                                    </div>
                                </div>
                                <div class="col-lg-12" style="margin-top:10px;">
                                    <div class="ibox-content">
                                        <div class="table-responsive">
                                            <table class="table table-striped table-bordered table-hover" id="tblDistrictCropRates">
                                                <thead>
                                                    <tr>
                                                        <th id="selector0">&nbsp;</th>
                                                        <th id="selector1">&nbsp;</th>
                                                        <th id="selector2">&nbsp;</th>
                                                        <th></th>
                                                        <th></th>
                                                        <th></th>
                                                    </tr>
                                                    <tr>
                                                        <th>District</th>
                                                        <th>Crop/Tree Type</th>
                                                        <th>Crop Description</th>
                                                        <th>Rate</th>
                                                        <th>Id</th>
                                                        <th></th>

                                                    </tr>
                                                </thead>
                                                <tbody></tbody>
                                                <tfoot>
                                                    <tr>
                                                        <th>Title</th>
                                                        <th>Description</th>
                                                        <th></th>
                                                        <th></th>
                                                        <th></th>
                                                        <th></th>
                                                    </tr>
                                                </tfoot>
                                            </table>
                                        </div>
                                    </div>
                                </div>
                            </div>
                        </div>
                        <!-- End District Crop Rate -->

                        <!-- District Property Rates -->
                        <div id="tab-12" class="tab-pane">
                            <div class="panel-body">
                                <div class="col-lg-2 col-offset-sm-8">
                                    <div class="action-buttons">
                                        <a  data-toggle="modal" href="#propertyrate"><i class="fa fa-plus"></i> Add improvement rate</a>&nbsp;&nbsp;
                                        <a  data-toggle="modal" href="#copypropertyrate"><i class="fa fa-files-o"></i> Copy Rate</a>
                                    </div>
                                    <div id="copypropertyrate" class="modal fade" aria-hidden="true">
                                        <div class="modal-dialog">
                                            <div class="modal-content">
                                                <div class="modal-body">
                                                    <div class="row">
                                                        <div class="col-sm-12">
                                                            <p>Copy Rate</p>
                                                            <div class="ibox-content">
                                                                <form class="form-horizontal form_validate" method="post" id="tblPropertyRate">
                                                                    <input type="hidden" name="tbl" value="copy_property_rate">
                                                                    <div class="form-group">
                                                                        <label class="control-label col-md-2">Copy From District</label>
                                                                        <div class="col-lg-10">
                                                                            <select class="select2able" name="district_from" >
                                                                                <?php echo $district_options; ?>
                                                                            </select>
                                                                        </div>
                                                                    </div>
                                                                    <div class="form-group">
                                                                        <label class="control-label col-md-2">Copy to District</label>
                                                                        <div class="col-lg-10">
                                                                            <select class="select2able" name="district_to" >
                                                                                <?php echo $district_options; ?>
                                                                            </select>
                                                                        </div>
                                                                    </div>

                                                                    <div class="form-group">
                                                                        <div class="col-lg-offset-2 col-lg-10">
                                                                            <button class="btn btn-sm btn-primary save" type="submit">Submit</button>
                                                                        </div>
                                                                    </div>
                                                                </form>
                                                            </div>
                                                        </div>

                                                    </div>
                                                </div>
                                            </div>
                                        </div>
                                    </div>
                                    <div id="propertyrate" class="modal fade" aria-hidden="true">
                                        <div class="modal-dialog">
                                            <div class="modal-content">
                                                <div class="modal-body">
                                                    <div class="row">
                                                        <div class="col-sm-12">
                                                            <p>Add Rate</p>
                                                            <div class="ibox-content">
                                                                <form class="form-horizontal form_validate" method="post" id="tblPropertyRate">
                                                                    <input type="hidden" name="tbl" value="property_rate">
                                                                    <input type="hidden" name="id" value="">
                                                                    <div class="form-group">
                                                                        <label class="control-label col-md-2">District</label>
                                                                        <div class="col-lg-10">
                                                                            <select class="select2able" name="district_id" >
                                                                                <?php echo $district_options; ?>
                                                                            </select>
                                                                        </div>
                                                                    </div>
                                                                    <div class="form-group"><label class="col-lg-2 control-label">Improvement Type </label>
                                                                        <div class="col-lg-10">
                                                                            <select class="select2able" name="propertytypedescription_id">
<?php
$alldata = $propertytypedescription->findPropertyTypeDescription();
if ($alldata) {
    foreach ($alldata as $single) {
        ?>
                                                                                        <option value="<?php echo $single['id']; ?>"><?php echo $single['improvementtypename'] . " - " . $single['propertydescription']; ?></option>
        <?php
    }
}
?>
                                                                            </select>
                                                                        </div>
                                                                    </div>
                                                                    <div class="form-group"><label class="col-lg-2 control-label"> Rate</label>
                                                                        <div class="col-lg-10">
                                                                            <input type="text" name="rate" placeholder="rate" class="form-control athousand_separator" required></input>
                                                                        </div>
                                                                    </div>
                                                                    <div class="form-group">
                                                                        <div class="col-lg-offset-2 col-lg-10">
                                                                            <button class="btn btn-sm btn-primary save" type="submit">Submit</button>
                                                                        </div>
                                                                    </div>
                                                                </form>
                                                            </div>
                                                        </div>

                                                    </div>
                                                </div>
                                            </div>
                                        </div>
                                    </div>
                                    <div id="propertyrate_edt" class="modal fade" aria-hidden="true">
                                        <div class="modal-dialog">
                                            <div class="modal-content">
                                                <div class="modal-body">
                                                </div>
                                            </div>
                                        </div>
                                    </div>
                                </div>
                                <div class="col-lg-12" style="margin-top:10px;">
                                    <div class="ibox-content">
                                        <div class="table-responsive">
                                            <table class="table table-striped table-bordered table-hover" id="tblPropertyRates">
                                                <thead>
                                                    <tr>
                                                        <th id="selector3">&nbsp;</th>
                                                        <th id="selector4">&nbsp;</th>
                                                        <th id="selector5">&nbsp;</th>
                                                        <th></th>
                                                        <th></th>
                                                    </tr>
                                                    <tr>
                                                        <th>District</th>
                                                        <th>Property Type</th>
                                                        <th>Property Description</th>
                                                        <th>Rate</th>
                                                        <th></th>

                                                    </tr>
                                                </thead>
                                                <tbody></tbody>
                                                <!--<tfoot>
                                                        <tr>
                                                                <th></th>
                                                                <th></th>
                                                                <th></th>
                                                                <th></th>
                                                                <th></th>
                                                        </tr>
                                                </tfoot> -->
                                            </table>
                                        </div>
                                    </div>
                                </div>
                            </div>
                        </div>
                        <!-- End Property  Rate -->

                        <!-- Land access category -->
                        <div id="tab-21" class="tab-pane">
                            <div class="col-lg-12">
                                <div class="action-buttons">
                                    <a  data-toggle="modal" href="#categoryModal"><i class="fa fa-plus"></i> Add New</a>
                                </div>
                                <div class="modal fade" id="categoryModal">
                                    <div class="modal-dialog">
                                        <div class="modal-content">
                                            <div class="modal-header">
                                                <button aria-hidden="true" class="close" data-dismiss="modal" type="button">&times;</button>
                                                <h4 class="modal-title">Land Acquisition Category</h4>
                                            </div>
                                            <div class="modal-body">
<?php include("add_acquisition_category.php"); ?>
                                            </div>
                                        </div>
                                    </div>
                                </div>

                            </div>
                            <div class="heading">
                                <i class="fa fa-bars"></i>Land Acquisition Categories
                            </div>
                            <div class="widget-content padded">
                                <table class="table table-bordered table-striped" id="land_acquistion_category">
                                    <thead>
                                    <th >Title</th>
                                    <th>Description</th>
                                    <th></th>
                                    </thead>
                                    <tbody>

                                    </tbody>
                                </table>
                            </div>
                        </div>
                        <!-- End Land Access Category -->
                        <!-- Access Level -->
                        <div id="tab-9" class="tab-pane">
                            <div class="panel-body">
                                <div class="col-lg-2 col-offset-sm-8">
                                    <div class="action-buttons">
                                        <a  data-toggle="modal" href="#access_level"><i class="fa fa-plus"></i> Add New</a>
                                    </div>
                                    <div id="access_level" class="modal fade" aria-hidden="true">
                                        <div class="modal-dialog">
                                            <div class="modal-content">
                                                <div class="modal-body">
                                                    <div class="row">
                                                        <div class="col-sm-12">
                                                            <p>Add Access Level.</p>
                                                            <div class="ibox-content">
                                                                <form class="form-horizontal form_validate" method="post" id="tblAccessLevel">
                                                                    <input type="hidden" name="tbl" value="tblAccessLevel">
                                                                    <input type="hidden" name="id" value="">
                                                                    <div class="form-group"><label class="col-lg-2 control-label">Name</label>

                                                                        <div class="col-lg-10"><input name="name" type="text" placeholder="Name" class="form-control"> <span class="help-block m-b-none">Access Level name (e.g Administrator).</span>
                                                                        </div>
                                                                    </div>
                                                                    <div class="form-group"><label class="col-lg-2 control-label">Description</label>
                                                                        <div class="col-lg-10"><textarea name="description" placeholder="Description" class="form-control"></textarea></div>
                                                                    </div>
                                                                    <div class="form-group">
                                                                        <div class="col-lg-offset-2 col-lg-10">
                                                                            <button class="btn btn-sm btn-primary save" type="submit">Submit</button>
                                                                        </div>
                                                                    </div>
                                                                </form>
                                                            </div>
                                                        </div>

                                                    </div>
                                                </div>
                                            </div>
                                        </div>
                                    </div>
                                </div>
                                <div class="col-lg-12" style="margin-top:10px;">
                                    <div class="ibox-content">
                                        <div class="table-responsive">
                                            <table class="table table-striped table-bordered table-hover" id="access_levels" >
                                                <thead>
                                                    <tr>
                                                        <th>Name</th>
                                                        <th>Description</th>
                                                        <th></th>
                                                    </tr>
                                                </thead>
                                                <tbody>

                                                </tbody>
                                                <tfoot>
                                                    <tr>
                                                        <th>Name</th>
                                                        <th>Description</th>
                                                        <th></th>
                                                    </tr>
                                                </tfoot>
                                            </table>
                                        </div>
                                    </div>
                                </div>

                            </div>
                        </div>
                        <!-- Access Level -->
                        <div id="tab-banks" class="tab-pane">
                            <div class="panel-body">
                                <div class="col-lg-2 col-offset-sm-8">
                                    <div class="action-buttons">
                                        <a  data-toggle="modal" href="#add_bank-modal"><i class="fa fa-plus"></i> Add New</a>
                                    </div>
                                    <div id="add_bank-modal" class="modal fade" aria-hidden="true">
                                        <div class="modal-dialog">
                                            <div class="modal-content">
                                                <div class="modal-body">
                                                    <div class="row">
                                                        <div class="col-sm-12">
                                                            <p>Add Bank</p>
                                                            <div class="ibox-content">
                                                                <form class="form-horizontal form_validate" method="post" id="tblBank">
                                                                    <input type="hidden" name="tbl" value="tblBank">
                                                                    <input type="hidden" name="id" value="">
                                                                    <div class="form-group"><label class="col-lg-4 control-label">Bank Name</label>

                                                                        <div class="col-lg-8">
                                                                            <input name="bank_name" name="bank_name" type="text" placeholder="Name" class="form-control">
                                                                            <span class="help-block m-b-none">Bank name (e.g Barclays).</span>
                                                                        </div>
                                                                    </div>
                                                                    <div class="form-group"><label class="col-lg-4 control-label">Bank Code</label>
                                                                        <div class="col-lg-8"><input name="bank_code" placeholder="Bank Code" class="form-control" /></div>
                                                                    </div>
                                                                    <div class="form-group">
                                                                        <div class="col-lg-offset-4 col-lg-8">
                                                                            <button class="btn btn-sm btn-primary save" type="submit">Submit</button>
                                                                        </div>
                                                                    </div>
                                                                </form>
                                                            </div>
                                                        </div>

                                                    </div>
                                                </div>
                                            </div>
                                        </div>
                                    </div>
                                </div>
                                <div class="col-lg-12" style="margin-top:10px;">
                                    <div class="ibox-content">
                                        <div class="table-responsive">
                                            <table class="table table-striped table-bordered table-hover" id="tblBanks" >
                                                <thead>
                                                    <tr>
                                                        <th>Bank</th>
                                                        <th>Code</th>
                                                        <th></th>
                                                    </tr>
                                                </thead>
                                                <tbody>

                                                </tbody>
                                                <tfoot>
                                                    <tr>
                                                        <th>Bank</th>
                                                        <th>Code</th>
                                                        <th></th>
                                                    </tr>
                                                </tfoot>
                                            </table>
                                        </div>
                                    </div>
                                </div>

                            </div>
                        </div>
                        <!---  Position   --->
                        <div id="tab-23" class="tab-pane">
                            <div class="panel-body">
                                <div class="col-lg-2 col-offset-sm-8">
                                    <div class="action-buttons">
                                        <a  data-toggle="modal" href="#position"><i class="fa fa-plus"></i> Add New</a>
                                    </div>
                                    <div id="position" class="modal fade" aria-hidden="true">
                                        <div class="modal-dialog">
                                            <div class="modal-content">
                                                <div class="modal-body">
                                                    <div class="row">
                                                        <div class="col-sm-12">
                                                            <p>Add /Update Position</p>
                                                            <div class="ibox-content">
                                                                <form class="form-horizontal form_validate" id="tblPosition">
                                                                    <input type="hidden" name="id" >
                                                                    <input type="hidden" name="tbl" value="tblPosition">
                                                                    <div class="form-group"><label class="col-lg-2 control-label">Name</label>
                                                                        <div class="col-lg-10"><input type="text" name="title" placeholder="Name" class="form-control"> 
                                                                        </div>
                                                                    </div>
                                                                    <div class="item form-group">
                                                                        <label class="control-label col-md-3 col-sm-3 col-xs-12 no_padding" for="id_type">Access Level <span class="required">*</span>
                                                                        </label>
                                                                        <div class="col-md-9 col-sm-9 col-xs-12">
                                                                            <select class="form-control m-b" name="access_level" required >
                                                                                <option>Please select</option>
<?php
$access_level_obj = new AccessLevel();
$access_level = $access_level_obj->findAll();
if ($access_level) {
    foreach ($access_level as $single) {
        ?>
                                                                                        <option value="<?php echo $single['id']; ?>" ><?php echo $single['name']; ?></option>
        <?php
    }
}
?>
                                                                            </select>
                                                                        </div>
                                                                    </div>
                                                                    <div class="form-group"><label class="col-lg-2 control-label">Description</label>
                                                                        <div class="col-lg-10"><textarea  name="description" placeholder="Description" class="form-control"></textarea></div>
                                                                    </div>
                                                                    <div class="form-group">
                                                                        <div class="col-lg-offset-2 col-lg-10">
                                                                            <button class="btn btn-sm btn-primary save" type="submit">Submit</button>
                                                                        </div>
                                                                    </div>
                                                                </form>
                                                            </div>
                                                        </div>

                                                    </div>
                                                </div>
                                            </div>
                                        </div>
                                    </div>
                                </div>
                                <div class="col-lg-12" style="margin-top:10px;">
                                    <div class="ibox-content">
                                        <div class="table-responsive">
                                            <table class="table table-striped table-bordered table-hover" id="positions">
                                                <thead>
                                                    <tr>
                                                        <th>Name</th>
                                                        <th>Access Level</th>
                                                        <th>Description</th>
                                                        <th></th>
                                                    </tr>
                                                </thead>
                                                <tbody></tbody>
                                                <tfoot>
                                                    <tr>
                                                        <th>Name</th>
                                                        <th>Access Level</th>
                                                        <th>Description</th>
                                                        <th></th>
                                                    </tr>
                                                </tfoot>
                                            </table>
                                        </div>
                                    </div>
                                </div>
                            </div>
                        </div>
                        <!-- End Position -->
                        <!-- Expense Type -->
                        <div id="tab-17" class="tab-pane">
                            <div class="panel-body">
                                <div class="col-lg-2 col-offset-sm-8">
                                    <div class="action-buttons">
                                        <a  data-toggle="modal" href="#expense_type"><i class="fa fa-plus"></i> Add New</a>
                                    </div>
                                    <div id="expense_type" class="modal fade" aria-hidden="true">
                                        <div class="modal-dialog">
                                            <div class="modal-content">
                                                <div class="modal-body">
                                                    <div class="row">
                                                        <div class="col-sm-12">
                                                            <p>Expense Type</p>
                                                            <div class="ibox-content">
                                                                <form class="form-horizontal form_validate" id="tblExpenseType">
                                                                    <input type="hidden" name="tbl"  value="expense_type">
                                                                    <input type="hidden" name="id" id="id_field">
                                                                    <div class="form-group"><label class="col-lg-2 control-label">Name</label>
                                                                        <div class="col-lg-10"><input type="text" name="name" placeholder="Expense Type" class="form-control"> 
                                                                        </div>
                                                                    </div>
                                                                    <div class="form-group"><label class="col-lg-2 control-label">Description</label>
                                                                        <div class="col-lg-10"><textarea  name="description" placeholder="Description" class="form-control"></textarea></div>
                                                                    </div>
                                                                    <div class="form-group">
                                                                        <div class="col-lg-offset-2 col-lg-10">
                                                                            <button class="btn btn-sm btn-primary save" type="submit">Submit</button>
                                                                        </div>
                                                                    </div>
                                                                </form>
                                                            </div>
                                                        </div>

                                                    </div>
                                                </div>
                                            </div>
                                        </div>
                                    </div>

                                </div>
                                <div class="col-lg-12" style="margin-top:10px;">
                                    <div class="ibox-content">
                                        <div class="table-responsive">
                                            <table class="table table-striped table-bordered table-hover" id="expense_types">
                                                <thead>
                                                    <tr>
                                                        <th>Name</th>
                                                        <th>Description</th>
                                                        <th>Edit / Delete</th>
                                                    </tr>
                                                </thead>
                                                <tbody></tbody>
                                                <tfoot>
                                                    <tr>
                                                        <th>Name</th>
                                                        <th>Description</th>
                                                        <th></th>
                                                    </tr>
                                                </tfoot>
                                            </table>
                                        </div>
                                    </div>
                                </div>

                            </div>
                        </div>
                        <!-- End Expense Type-->

                        <!---  Comments   --->
                        <div id="tab-24" class="tab-pane">
                            <div class="panel-body">
                                <div class="col-lg-2 col-offset-sm-8">
                                    <div class="action-buttons">
                                        <a  data-toggle="modal" href="#comment"><i class="fa fa-plus"></i> Add New</a>
                                    </div>
                                    <div id="comment" class="modal fade" aria-hidden="true">
                                        <div class="modal-dialog">
                                            <div class="modal-content">
                                                <div class="modal-body">
                                                    <div class="row">
                                                        <div class="col-sm-12">
                                                            <p>Add /Update Comment</p>
                                                            <div class="ibox-content">
                                                                <form class="form-horizontal form_validate" id="tblComment">
                                                                    <input type="hidden" name="id" >
                                                                    <input type="hidden" name="tbl"  value="tblComment">
                                                                    <div class="form-group"><label class="col-lg-2 control-label">Comments</label>
                                                                        <div class="col-lg-10">
                                                                            <textarea name="details" placeholder="comments" class="form-control"></textarea> 
                                                                        </div>
                                                                    </div>
                                                                    <div class="form-group">
                                                                        <div class="col-lg-offset-2 col-lg-10">
                                                                            <button class="btn btn-sm btn-primary save" type="submit">Submit</button>
                                                                        </div>
                                                                    </div>
                                                                </form>
                                                            </div>
                                                        </div>

                                                    </div>
                                                </div>
                                            </div>
                                        </div>
                                    </div>
                                </div>
                                <div class="col-lg-12" style="margin-top:10px;">
                                    <div class="ibox-content">
                                        <div class="table-responsive">
                                            <table class="table table-striped table-bordered table-hover" id="tblComments">
                                                <thead>
                                                    <tr>
                                                        <th>Comment</th>
                                                        <th></th>
                                                    </tr>
                                                </thead>
                                                <tbody></tbody>
                                                <tfoot>
                                                    <tr>
                                                        <th>Comment</th>
                                                        <th></th>
                                                    </tr>
                                                </tfoot>
                                            </table>
                                        </div>
                                    </div>
                                </div>
                            </div>
                        </div>
                        <!-- End Comments -->
                    </div>
                </div>
            </div>
        </div>
    </div>
</div>

<?php
include("js/settings_js.php");
include("includes/footer.php");
