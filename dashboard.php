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
						6<small></small>
					</div>
					<div class="text">
						Total Projects
					</div>
				</div>
				<div class="col-md-3">
					<div class="number">
						<div class="icon globe"></div>
						6<small></small>
					</div>
					<div class="text">
						On going Projects
					</div>
				</div>
				
				<div class="col-md-3">
					<div class="number">
						<div class="icon money"></div>
						<small>$</small>924
					</div>
					<div class="text">
						Sales
					</div>
				</div>
				
				<div class="col-md-3">
					<div class="number">
						<div class="icon users"></div>
						325
					</div>
					<div class="text">
					   Staff
					</div>
				</div>
			</div>
		</div>
	</div>
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
		<!-- Chat -->
		<div class="col-md-6">
		   <div class="widget-container fluid-height">
				<div class="heading">
					<i class="fa fa-bar-chart-o"></i>Donut Charts
				</div>
				<div class="widget-content clearfix">
					<div class="col-sm-6">
						<div class="pie-chart1 pie-chart pie-number" data-percent="87">
							87%
						</div>
					</div>
					<div class="col-sm-6">
						<div class="pie-chart2 pie-chart pie-number" data-percent="26">
							26%
						</div>
					</div>
				</div>
			</div>
		</div>
		<!-- End Chat -->
	</div>
</div>
<?php 
include("includes/footer.php");
?>