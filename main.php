<?php 
$needed_files = array("dataTables", "iCheck", "jasny", "knockout", "moment");
include("includes/header.php");
?>
    <div class="container-fluid main-content">
            <!-- Statistics -->
            <div class="row">
                <div class="col-lg-12">
                    <div class="widget-container stats-container">
                        <div class="col-md-3">
                            <div class="number">
                                <div class="icon globe"></div>
                                86<small>%</small>
                            </div>
                            <div class="text">
                                Projects
                            </div>
                        </div>
                        <div class="col-md-3">
                            <div class="number">
                                <div class="icon money"></div>
                                <small>$</small>61,000,000
                            </div>
                            <div class="text">
                                Total Income
                            </div>
                        </div>
						<div class="col-md-3">
                            <div class="number">
                                <div class="icon money"></div>
                                <small>$</small>11,000,000
                            </div>
                            <div class="text">
                                Total Expenses
                            </div>
                        </div>
                        <div class="col-md-3">
                            <div class="number">
                                <div class="icon chat-bubbles"></div>
                                325
                            </div>
                            <div class="text">
                                New followers
                            </div>
                        </div>
                    </div>
                </div>
            </div>
            <!-- End Statistics -->
            <div class="row">
				<!-- Area Charts:Morris -->
                <div class="col-md-6">
                    <div class="widget-container fluid-height">
                        <div class="heading">
                            <i class="fa fa-bar-chart-o"></i>Area Chart
                        </div>
                        <div class="widget-content padded text-center">
                            <div class="graph-container">
                                <div class="caption"></div>
                                <div class="graph" id="hero-area"></div>
                            </div>
                        </div>
                    </div>
                </div>
                <!-- Area Charts:Morris -->
                 <div class="col-lg-6">
                    <div class="widget-container fluid-height">
                        <!-- Table -->
                        <table class="table table-filters">
                            <tbody>
                                <tr>
                                    <td class="filter-category blue">
                                        <div class="arrow-left"></div>
                                        <i class="fa fa-stethoscope"></i>
                                    </td>
                                    <td>
                                        National Distribution Co.
                                    </td>
                                    <td>
                                        $9204
                                    </td>
                                    <td class="hidden-xs">
                                        <div class="sparkslim">
                                            50,55,60,40,30,35,30,20,25,30,40,20,15
                                        </div>
                                    </td>
                                    <td>
                                        <div class="danger">
                                            -4%
                                        </div>
                                    </td>
                                </tr>
                                <tr>
                                    <td class="filter-category green">
                                        <div class="arrow-left"></div>
                                        <i class="fa fa-coffee"></i>
                                    </td>
                                    <td>
                                        Star Organization Co.
                                    </td>
                                    <td>
                                        $23,890
                                    </td>
                                    <td class="hidden-xs">
                                        <div class="sparkslim">
                                            5,10,15,50,80,50,40,30,50,60,70,75,75
                                        </div>
                                    </td>
                                    <td>
                                        <div class="success">
                                            +12%
                                        </div>
                                    </td>
                                </tr>
                                <tr>
                                    <td class="filter-category orange">
                                        <div class="arrow-left"></div>
                                        <i class="fa fa-gamepad"></i>
                                    </td>
                                    <td>
                                        Companysoft, LLC
                                    </td>
                                    <td>
                                        $10,995
                                    </td>
                                    <td class="hidden-xs">
                                        <div class="sparkslim">
                                            100,100,80,70,40,20,20,40,50,60,70
                                        </div>
                                    </td>
                                    <td>
                                        <div class="success">
                                            +5%
                                        </div>
                                    </td>
                                </tr>
                                <tr>
                                    <td class="filter-category red">
                                        <div class="arrow-left"></div>
                                        <i class="fa fa-gift"></i>
                                    </td>
                                    <td>
                                        Craft Co.
                                    </td>
                                    <td>
                                        $6,790
                                    </td>
                                    <td class="hidden-xs">
                                        <div class="sparkslim">
                                            5,10,15,20,30,40,80,100,120,120,140
                                        </div>
                                    </td>
                                    <td>
                                        <div class="success">
                                            +26%
                                        </div>
                                    </td>
                                </tr>
                                <tr>
                                    <td class="filter-category blue">
                                        <div class="arrow-left"></div>
                                        <i class="fa fa-stethoscope"></i>
                                    </td>
                                    <td>
                                        National Distribution Co.
                                    </td>
                                    <td>
                                        $9204
                                    </td>
                                    <td class="hidden-xs">
                                        <div class="sparkslim">
                                            50,55,60,40,30,35,30,20,25,30,40,20,15
                                        </div>
                                    </td>
                                    <td>
                                        <div class="danger">
                                            -4%
                                        </div>
                                    </td>
                                </tr>
                                <tr>
								<tr>
                                    <td class="filter-category blue">
                                        <div class="arrow-left"></div>
                                        <i class="fa fa-stethoscope"></i>
                                    </td>
                                    <td>
                                        National Distribution Co.
                                    </td>
                                    <td>
                                        $9204
                                    </td>
                                    <td class="hidden-xs">
                                        <div class="sparkslim">
                                            50,55,60,40,30,35,30,20,25,30,40,20,15
                                        </div>
                                    </td>
                                    <td>
                                        <div class="danger">
                                            -4%
                                        </div>
                                    </td>
                                </tr>
                                <tr>
								<tr>
                                    <td class="filter-category blue">
                                        <div class="arrow-left"></div>
                                        <i class="fa fa-stethoscope"></i>
                                    </td>
                                    <td>
                                        National Distribution Co.
                                    </td>
                                    <td>
                                        $9204
                                    </td>
                                    <td class="hidden-xs">
                                        <div class="sparkslim">
                                            50,55,60,40,30,35,30,20,25,30,40,20,15
                                        </div>
                                    </td>
                                    <td>
                                        <div class="danger">
                                            -4%
                                        </div>
                                    </td>
                                </tr>
                                <tr>
                                    <td class="filter-category magenta">
                                        <div class="arrow-left"></div>
                                        <i class="fa fa-trophy"></i>
                                    </td>
                                    <td>
                                        Fastnation Co.
                                    </td>
                                    <td>
                                        $22,156
                                    </td>
                                    <td class="hidden-xs">
                                        <div class="sparkslim">
                                            20,40,50,60,70,80,90,95,100,80,70,60
                                        </div>
                                    </td>
                                    <td>
                                        <div class="danger">
                                            -4%
                                        </div>
                                    </td>
                                </tr>
                            </tbody>
                        </table>
                    </div>
                </div>
                <!-- End Pie Graph 1 -->
				
            </div>
           
        </div>
    </div>
<?php 
include("includes/footer.php");
?>