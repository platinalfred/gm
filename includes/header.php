<?php 
session_start();
include("lib/Libraries.php");
if(!isset($_SESSION['logged'])){ 
	header("location:logout.php");
}
?>
<!DOCTYPE html>
<html>
<head>
    <title>
       GMIS
    </title>
	<meta charset="UTF-8" />
	<link rel="shortcut icon" href="images/favicon.ico" />
    <link href="stylesheets/bootstrap.min.css" media="all" rel="stylesheet" type="text/css" />
    <link href="stylesheets/font-awesome.min.css" media="all" rel="stylesheet" type="text/css" />
    <link href="stylesheets/hightop-font.css" media="all" rel="stylesheet" type="text/css" />
    <link href="stylesheets/isotope.css" media="all" rel="stylesheet" type="text/css" />
    <link href="stylesheets/jquery.fancybox.css" media="all" rel="stylesheet" type="text/css" />
    <link href="stylesheets/fullcalendar.css" media="all" rel="stylesheet" type="text/css" />
    <link href="stylesheets/wizard.css" media="all" rel="stylesheet" type="text/css" />
    <link href="stylesheets/select2.css" media="all" rel="stylesheet" type="text/css" />
    <link href="stylesheets/morris.css" media="all" rel="stylesheet" type="text/css" />
    <link href="stylesheets/datatables.css" media="all" rel="stylesheet" type="text/css" />
    <link href="stylesheets/datepicker.css" media="all" rel="stylesheet" type="text/css" />
    <link href="stylesheets/timepicker.css" media="all" rel="stylesheet" type="text/css" />
    <link href="stylesheets/colorpicker.css" media="all" rel="stylesheet" type="text/css" />
    <link href="stylesheets/bootstrap-switch.css" media="all" rel="stylesheet" type="text/css" />
    <link href="stylesheets/bootstrap-editable.css" media="all" rel="stylesheet" type="text/css" />
    <link href="stylesheets/daterange-picker.css" media="all" rel="stylesheet" type="text/css" />
    <link href="stylesheets/typeahead.css" media="all" rel="stylesheet" type="text/css" />
    <link href="stylesheets/summernote.css" media="all" rel="stylesheet" type="text/css" />
    <link href="stylesheets/ladda-themeless.min.css" media="all" rel="stylesheet" type="text/css" />
    <link href="stylesheets/social-buttons.css" media="all" rel="stylesheet" type="text/css" />
    <link href="stylesheets/jquery.fileupload-ui.css" media="screen" rel="stylesheet" type="text/css" />
    <link href="stylesheets/dropzone.css" media="screen" rel="stylesheet" type="text/css" />
    <link href="stylesheets/nestable.css" media="screen" rel="stylesheet" type="text/css" />
    <link href="stylesheets/pygments.css" media="all" rel="stylesheet" type="text/css" />
    <link href="stylesheets/style.css" media="all" rel="stylesheet" type="text/css" />
    <link href="stylesheets/color/green.css" media="all" rel="alternate stylesheet" title="green-theme" type="text/css" />
    <link href="stylesheets/color/orange.css" media="all" rel="alternate stylesheet" title="orange-theme" type="text/css" />
    <link href="stylesheets/color/magenta.css" media="all" rel="alternate stylesheet" title="magenta-theme" type="text/css" />
    <link href="stylesheets/color/gray.css" media="all" rel="alternate stylesheet" title="gray-theme" type="text/css" />
    <link href="css/general.css" media="all" rel="alternate stylesheet" title="gray-theme" type="text/css" />
	
	<link href="js/plugins/pnotify/dist/pnotify.css" rel="stylesheet">
	<link href="js/plugins/pnotify/dist/pnotify.buttons.css" rel="stylesheet">
	<link href="js/plugins/pnotify/dist/pnotify.nonblock.css" rel="stylesheet">
	
	<?php
	 if(in_array("dataTables", $needed_files)){
		?>
		<link href="css/plugins/dataTables/datatables.min.css" rel="stylesheet">
		<!--<link href="css/plugins/dataTables/jquery.dataTables.css" rel="stylesheet">-->
		<link href="css/plugins/dataTables/buttons.dataTables.min.css" rel="stylesheet">
	<?php 
	 }
	 ?>
	<script src="js/jquery-2.1.1.js" type="text/javascript"></script>
    <script src="js/ui/1.10.3/jquery-ui.js" type="text/javascript"></script>
    <script src="js/bootstrap.min.js" type="text/javascript"></script>
    <script src="javascripts/raphael.min.js" type="text/javascript"></script>
    <script src="javascripts/selectivizr-min.js" type="text/javascript"></script>
    <script src="javascripts/jquery.mousewheel.js" type="text/javascript"></script>
    <script src="javascripts/jquery.vmap.min.js" type="text/javascript"></script>
    <script src="javascripts/jquery.vmap.sampledata.js" type="text/javascript"></script>
    <script src="javascripts/jquery.vmap.world.js" type="text/javascript"></script>
    <script src="javascripts/jquery.bootstrap.wizard.js" type="text/javascript"></script>
    <script src="javascripts/fullcalendar.min.js" type="text/javascript"></script>
    <script src="javascripts/gcal.js" type="text/javascript"></script>
    <script src="javascripts/jquery.easy-pie-chart.js" type="text/javascript"></script>
    <script src="javascripts/excanvas.min.js" type="text/javascript"></script>
    <script src="javascripts/jquery.isotope.min.js" type="text/javascript"></script>
    <script src="javascripts/isotope_extras.js" type="text/javascript"></script>
    <script src="javascripts/modernizr.custom.js" type="text/javascript"></script>
    <script src="javascripts/jquery.fancybox.pack.js" type="text/javascript"></script>
    <script src="javascripts/select2.js" type="text/javascript"></script>
    <script src="javascripts/styleswitcher.js" type="text/javascript"></script>
    <script src="javascripts/wysiwyg.js" type="text/javascript"></script>
    <script src="javascripts/typeahead.js" type="text/javascript"></script>
    <script src="javascripts/summernote.min.js" type="text/javascript"></script>
    <script src="javascripts/jquery.inputmask.min.js" type="text/javascript"></script>
    <script src="javascripts/jquery.validate.js" type="text/javascript"></script>
    <script src="javascripts/bootstrap-fileupload.js" type="text/javascript"></script>
    <script src="javascripts/bootstrap-datepicker.js" type="text/javascript"></script>
    <script src="javascripts/bootstrap-timepicker.js" type="text/javascript"></script>
    <script src="javascripts/bootstrap-colorpicker.js" type="text/javascript"></script>
    <script src="javascripts/bootstrap-switch.min.js" type="text/javascript"></script>
    <script src="javascripts/typeahead.js" type="text/javascript"></script>
    <script src="javascripts/spin.min.js" type="text/javascript"></script>
    <script src="javascripts/ladda.min.js" type="text/javascript"></script>
    <script src="javascripts/moment.js" type="text/javascript"></script>
    <script src="javascripts/mockjax.js" type="text/javascript"></script>
    <script src="javascripts/bootstrap-editable.min.js" type="text/javascript"></script>
    <script src="javascripts/xeditable-demo-mock.js" type="text/javascript"></script>
    <script src="javascripts/xeditable-demo.js" type="text/javascript"></script>
    <script src="javascripts/address.js" type="text/javascript"></script>
    <script src="javascripts/daterange-picker.js" type="text/javascript"></script>
    <script src="javascripts/date.js" type="text/javascript"></script>
    <script src="javascripts/morris.min.js" type="text/javascript"></script>
    <script src="javascripts/skycons.js" type="text/javascript"></script>
    <script src="javascripts/fitvids.js" type="text/javascript"></script>
    <script src="javascripts/jquery.sparkline.min.js" type="text/javascript"></script>
    <script src="javascripts/dropzone.js" type="text/javascript"></script>
    <script src="javascripts/jquery.nestable.js" type="text/javascript"></script>
    <script src="javascripts/main.js" type="text/javascript"></script>
    <script src="javascripts/respond.js" type="text/javascript"></script>
	<!-- PNotify -->
	<script src="js/plugins/pnotify/dist/pnotify.js"></script>
	<script src="js/plugins/pnotify/dist/pnotify.buttons.js"></script>
	<script src="js/plugins/pnotify/dist/pnotify.nonblock.js"></script>
	
    <script src="js/jquery-3.2.1.min.js" integrity="sha256-hwg4gsxgFZhOsEEamdOYGBf13FyQuiTwlAQgxVSNgt4=" crossorigin="anonymous"></script>
    <script src="javascripts/knockout-3.4.2.js" type="text/javascript"></script>
	<?php
	if(in_array("dataTables", $needed_files)){
		?>
		<script src="js/plugins/dataTables/datatables.min.js"></script>
		<script src="js/plugins/dataTables/dataTables.responsive.min.js"></script>
		<script src="js/plugins/dataTables/dataTables.buttons.min.js"></script>
		<script src="js/plugins/dataTables/buttons.print.min.js"></script>
		<script src="js/plugins/dataTables/buttons.colVis.min.js"></script>
		<!--
     -->
		<script type="text/javascript">
			$(document).ready(function () {
				jQuery.fn.dataTable.Api.register( 'sum()', function ( ) {
					return this.flatten().reduce( function ( a, b ) {
						if ( typeof a === 'string' ) {
							a = a.replace(/[^\d.-]/g, '') * 1;
						}
						if ( typeof b === 'string' ) {
							b = b.replace(/[^\d.-]/g, '') * 1;
						}
				 
						return a + b;
					}, 0 );
				} );
			} );
			ko.bindingHandlers.confirmClick = {
				init: function(element, valueAccessor, allBindings, viewModel) {
					var value = valueAccessor();
					var message = ko.unwrap(value.message);
					var click = value.click;
					ko.applyBindingsToNode(element, { click: function () {
						if (confirm(message))
							return click.apply(this, Array.prototype.slice.apply(arguments));
					}}, viewModel);
				}
			}
		</script>
	<?php 
	}
	?>
	<style>
		.hideit{
		  display: none;
		}
	</style>
	<script src="js/plugins/moment/min/moment.min.js"></script>
    <meta content="width=device-width, initial-scale=1.0, maximum-scale=1.0, user-scalable=no" name="viewport">
</head>
<body class="page-header-fixed bg-1">
    <div class="modal-shiftfix">
        <!-- Navigation -->
        <div class="navbar navbar-fixed-top scroll-hide">
            <div class="container-fluid top-bar">
                <div class="pull-right">
                    <ul class="nav navbar-nav pull-right">
                       <li class="dropdown user hidden-xs">
                            <a data-toggle="dropdown" class="dropdown-toggle" href="#"><?php  echo $_SESSION['firstname']; ?><b class="caret"></b></a>
                            <ul class="dropdown-menu">
                                <li>
                                    <a href="#">
                                        <i class="fa fa-user"></i>My Account</a>
                                </li>
                                <li>
                                    <a href="logout.php">
                                        <i class="fa fa-sign-out"></i>Logout</a>
                                </li>
                            </ul>
                        </li>
                    </ul>
                </div>
                <button class="navbar-toggle"><span class="icon-bar"></span><span class="icon-bar"></span><span class="icon-bar"></span></button><a class="logo" href="dashboard.php"><img width="" height="35" src="images/logo.png" /></a>
            </div>
            <div class="container-fluid main-nav clearfix">
                <div class="nav-collapse">
					 <ul class="nav">
                        <li>
                            <a class="current" href="dashboard.php"><span aria-hidden="true" class="hightop-home"></span>Dashboard</a>
                        </li>
						<li>
                            <a href="reports.php">
                                <span aria-hidden="true" class="hightop-charts"></span>Reports</a>
                        </li>
                        <li>
                            <a href="administration.php"><span aria-hidden="true" class="hightop-feed"></span>Administration</a>
                        </li>
                        <li>
                            <a data-toggle="dropdown" href="#"><span aria-hidden="true" class="hightop-assign"></span>Assignments</a>
                            <!-- class="dropdown" <b class="caret"></b> <ul class="dropdown-menu">
                                <li>
                                    <a href="buttons.html">Buttons</a>
                                </li>
                                <li>
                                    <a href="fontawesome.html">Font Awesome Icons</a>
                                </li>
                                <li>
                                    <a href="glyphicons.html">Glyphicons</a>
                                </li>
                                <li>
                                    <a href="components.html">Components</a>
                                </li>
                                <li>
                                    <a href="widgets.html">Widgets</a>
                                </li>
                                <li>
                                    <a href="nestable-lists.html">Nestable Lists</a>
                                </li>
                                <li>
                                    <a href="typo.html">Typography</a>
                                </li>
                                <li>
                                    <a href="grid.html">Grid Layout</a>
                                </li>
                            </ul>
							-->
						</li>
                        <li>
                            <a href="land-acquisition.php">
                                <span aria-hidden="true" class="hightop-forms"></span>Land Acquisition
							</a>
                        </li>
                        <li >
                            <a data-toggle="dropdown" href="#">
                                <span aria-hidden="true" class="hightop-money"></span>Income
							</a>
                        </li>
                        <li>
                            <a href="">
                                <span aria-hidden="true" class="hightop-pages"></span>Expenses</a>
                        </li>
                        <li>
							<a  href="settings.php">
                                <span aria-hidden="true" class="hightop-gear"></span>Settings</b>
							</a>
                        </li>
                    </ul>
                
                </div>
            </div>
        </div>
        <!-- <b class="caret"> End Navigation -->
    