<script>
//the view model for the page
var DummyObject = function(){
	var self = this;
	self.rate_description = ko.observable(0);
}
var ViewModel = function() {
		var self = this;
		self.pap_details = ko.observable(); //pap_details_obj
		self.project_districts = ko.observableArray(); //list of districts covered by this project
		self.available_districts = ko.observableArray(); //list of districts available to be added to this project
		self.district_property_rates = ko.observableArray(); //list of district property rates
		self.district_crop_rates = ko.observableArray(); //list of district crop rates
		self.district = ko.observable(<?php echo isset($district_details)?json_encode($district_details):""; ?>);
		self.crop_rate_description = ko.observable(); //crop rate object when adding or saving crops
		self.property_rate_description = ko.observable(); //property rate object when adding or saving properties
		
		<?php if(isset($_GET['pap_id'])):?> //this should only appear when we are in the pap details page
		//photos
		self.papPhotos = ko.observableArray([new DummyObject()]);
		self.serverPapPhotos = ko.observableArray(<?=json_encode($pap_photos)?>); //data returned from the serve upon clicking the edit button
		self.addPapPhoto = function(){self.papPhotos.push(new DummyObject());};
		self.removePapPhoto = function(papPhoto){self.papPhotos.remove(papPhoto);};
		
		self.removeServerPapPhoto = function(serverPapPhoto){
			//first delete from the server, if successful, then delete from the local copy of the array if successful
			$.ajax({
				url:'delete.php',
				type:'get',
				data:{tbl:'tblPapPhoto', id:serverPapPhoto.id},
				dataType:'json',
				success:function(result){
					if( result.success )
						self.serverPapPhotos.remove(serverPapPhoto);
					else
						alert("Photo could not be deleted");
				}			
			});
		};
		self.openTextArea = function(serverPapPhoto, event) {
			$(event.target).addClass('hideit').next().removeClass('hideit');
		};
		self.hideTextArea = function(serverPapPhoto, event) {
			//send the content to the server to be updated, if description was changed
			$.ajax({
				url:'save_data.php',
				type:'post',
				data:{tbl: 'tblPapPhotos', id:serverPapPhoto.id, description:serverPapPhoto.description},
				dataType:'json',
				success:function(response){
					if( response.success ){
						console.log(response.message);
						showStatusMessage("Photo details successfully saved" ,"success");
						setTimeout(function(){
						}, 500);
					}else{
						
						showStatusMessage("Photo could not be updated:\n" + response.message, "fail");
					}
				}			
			});
			$(event.target).addClass('hideit').prev().removeClass('hideit').text(serverPapPhoto.description);
		};
		<?php else:?>
		self.subcountiesList = ko.observableArray(<?=json_encode($subcounties)?>);	
		self.parishesList = ko.observableArray(<?=json_encode($parishes)?>);
		self.villagesList = ko.observableArray(<?=json_encode($villages)?>);
                //these are from the getServerData
		self.pap_improvements = ko.observableArray();
		self.pap_crops = ko.observableArray();

		//useful variables for the form
		//self.county = ko.observable();
		self.scounty = ko.observable();
		self.parish = ko.observable();
		self.village = ko.observable();
		
		self.filteredSCountiesList = ko.computed(function() {
			if(self.district()){
				return ko.utils.arrayFilter(self.subcountiesList(), function(scounty) {
					return (parseInt(self.district().id)==parseInt(scounty.district));
				});
			}
		});	
		self.filteredParishesList = ko.computed(function() {
			if(self.scounty()){
				return ko.utils.arrayFilter(self.parishesList(), function(parish) {
					return (parseInt(self.scounty().id)==parseInt(parish.subcounty));
				});
			}
		});
		self.filteredVillagesList = ko.computed(function() {
			if(self.parish()){
				return ko.utils.arrayFilter(self.villagesList(), function(village) {
					return (parseInt(self.parish().id)==parseInt(village.parish));
				});
			}
		});
		<?php endif; ?>
		self.filteredDistrictCropRates = ko.computed(function() {
			if(self.district()){
				return ko.utils.arrayFilter(self.district_crop_rates(), function(district_crop_rate) {
					return (parseInt(self.district().id)==parseInt(district_crop_rate.district_id));
				});
			}
		});
		self.filteredDistrictPropertyRates = ko.computed(function() {
			if(self.district()){
				return ko.utils.arrayFilter(self.district_property_rates(), function(district_property_rate) {
					return (parseInt(self.district().id)==parseInt(district_property_rate.district_id));
				});
			}
		});
		
		//operations
		//districts
		self.selectedDistricts = ko.observableArray([new DummyObject()]);
		self.addDistrict = function(){self.selectedDistricts.push(new DummyObject());};
		self.removeSelectedDistrict = function(selectedDistrict){self.selectedDistricts.remove(selectedDistrict);};
		//improvements
		self.selectedImprovements = ko.observableArray();
		self.serverDataImprovements = ko.observableArray(); //data returned from the serve upon clicking the edit button
		self.addImprovement = function(){self.selectedImprovements.push(new DummyObject());};
		self.removeSelectedImprovement = function(selectedImprovement){self.selectedImprovements.remove(selectedImprovement);};
		self.removeServerDataImprovement = function(serverDataImprovement){self.serverDataImprovements.remove(serverDataImprovement);};
		//plants
		self.selectedPlants = ko.observableArray();
		self.serverDataPlants = ko.observableArray(); //data returned from the serve upon clicking the edit button
		self.addPlant = function(){self.selectedPlants.push(new DummyObject());};
		self.removeSelectedPlant = function(selectedPlant){self.selectedPlants.remove(selectedPlant);};
		self.removeServerDataPlant = function(serverDataPlant){self.serverDataPlants.remove(serverDataPlant);};
                
		//set options value after populating the select list
		self.setOptionValue = function(propId) {
			return function (option, item) {
				if (item === undefined) {
					option.value = "";
				} else {
					option.value = item[propId];
				}
			}
		};
                
		//Retrieve page data from the server
		self.getServerData = function() {
			$.ajax({
				type: "post",
				dataType: "json",
				data:{tbl:"project_details", project_id:<?php echo $_GET['id']; ?>},
				url: "getData.php",
				success: function(response){
					self.district_property_rates(response.district_property_rates);
					self.district_crop_rates(response.district_crop_rates);
					<?php if(isset($_GET['pap_id'])):?> 
					<?php else:?>
                                            self.pap_crops(response.pap_crops);
                                            self.pap_improvements(response.pap_improvements);
                                            self.available_districts(response.available_districts);
                                            viewModel.available_districts.valueHasMutated();
					<?php endif;?> 
				}
			})
		};
		//Retrieve pap details from the server
		self.getPapDetails = function(pap_id) {
			$.ajax({
				type: "post",
				dataType: "json",
				data:{tbl:"pap_details", pap_id:pap_id},
				url: "getData.php",
				success: function(response){
						self.serverDataImprovements(response.pap_improvements);
						self.serverDataPlants(response.pap_crop_trees);
						viewModel.serverDataImprovements.valueHasMutated();
						viewModel.serverDataPlants.valueHasMutated();
				}
			})
		};	
		self.resetForm = function() {
			self.pap_details(null);
			if(self.serverDataImprovements().length>0)self.serverDataImprovements.removeAll();
			if(self.serverDataPlants().length>0)self.serverDataPlants.removeAll();
		}
	};
var viewModel = new ViewModel();
var dTable = {};
$(document).ready(function(){
	//deleteDataTableRowData();
        function generateHTML(data_array){
            cellHTML = "";
            if(data_array){
                $.each(data_array, function(key, val){
                    cellHTML += '<p>'+val[0]+' (<span class="text-danger">'+(val[1]*1)+' @'+val[2]*1+'</span>)</p>';
                });
            }
            return cellHTML;
        }
	var handleDataTableButtons = function() {
		<?php if(isset($projectDetails)):?>
		 if ($("#tblPapCondensedReport").length) {
				  dTable['tblPapCondensedReport'] = $('#tblPapCondensedReport').DataTable({
				  dom: '<".col-md-6"B><".col-md-2"l><".col-md-3"f>rt<".col-md-7"i><".col-md-5"p>',
				  "processing": true,
				  "serverSide": true,
				  //"deferRender": true,
					"ajax": {
					  "url":"getData.php",
					  "dataType": "JSON",
					  "type": "POST",
					  "data":  function(d){
							d.tbl = 'project_paps_reports';
							d.project_id = <?php echo $_GET['id']; ?>;
						}
				  },"columnDefs": [ ],
				  "autoWidth": false,
				  "lengthMenu": [[10, 25, 50, -1], [10, 50,  100, "All"]],
				  columns:[ { data: 'id', render: function( data, type, full, meta ) {  return '<a href="project_details.php?id=<?php echo $_GET['id']; ?>&pap_id='+full.id+'" title="View PAP details">'+ data + '</a>';} },
				  { data: 'pap_ref', render: function( data, type, full, meta ) {  return '<a href="project_details.php?id=<?php echo $_GET['id']; ?>&pap_id='+full.id+'" title="View PAP details">'+ data + '</a>';} },
					  { data: 'firstname', render: function( data, type, full, meta ) {return full.lastname+' ' + data + ' ' + (full.othername?full.othername:'');} },
						{ data: 'district_name', render: function( data, type, full, meta ) {return full.district_name+', ' + full.subcounty_name+', ' + full.parish_name+', ' + full.village_name;}},
						{ data: 'phone_contact'},
						{ data: 'nid_no'},
						{ data: 'acc_number'},
						{ data: 'bank_name'},
						{ data: 'x_coord'},
						{ data: 'y_coord'},
						{ data: 'chainage'},
						<?php 
						if( $projectDetails['project_category_unit'] == 1 || $projectDetails['project_category_unit'] == 4 ):?>
							{ data: 'rightofway', render: function( data, type, full, meta ) {return data?curr_format(data*1):0;}},
						<?php 
						endif;
                                                if( $projectDetails['project_category_unit'] == 2 || $projectDetails['project_category_unit'] == 4 ):?>
							{ data: 'way_leave', render: function( data, type, full, meta ) {return data?curr_format(data *1) :0;}},
						<?php 
						endif;
                                                if( $projectDetails['project_category_unit'] == 4 ):?>
							{ data: 'way_leave', render: function( data, type, full, meta ) {return curr_format(((data?parseFloat(data):0)+(full.rightofway?parseFloat(full.rightofway):0)).toFixed(4));}},
						<?php 
						endif;
						if( $projectDetails['project_category_unit'] == 5 ):?>
							{ data: 'total_take', render: function( data, type, full, meta ) {return data?curr_format(data)*1:0;}},
						<?php 
						endif;
						if( $projectDetails['project_category_unit'] == 4 || $projectDetails['project_category_unit'] == 1 || $projectDetails['project_category_unit'] == 5 ): ?>
							{ data: 'rate_per_acre', render: function( data, type, full, meta ) {return data? curr_format(data*1) :0;}},
							{ data: 'land_interest', render: function( data, type, full, meta ) {return data?curr_format(data):0;}},
							<?php endif;
                                                        if ($projectDetails['project_category_unit'] == 4): ?>
							{ data: 'diminution_rate', render: function( data, type, full, meta ) {return data?curr_format(data):0;}},
							<?php 
							endif;
							/* if ($projectDetails['project_category_unit'] == 1 || $projectDetails['project_category_unit'] == 4 || $projectDetails['project_category_unit'] == 5): 
							
								if($projectDetails['project_category_unit'] == 1 || $projectDetails['project_category_unit'] == 4 ){ ?>
									{ data: 'rate_per_acre', render: function( data, type, full, meta ) {return data ? curr_format(parseInt(full.rate_per_acre) * (parseFloat(full.land_interest)/100) * parseFloat(full.rightofway) ):0; }},
								<?php 
								} else { ?>
									{ data: 'rate_per_acre', render: function( data, type, full, meta ) {return data ? curr_format(parseInt(full.rate_per_acre) * (parseFloat(full.land_interest)/100)* parseFloat(full.total_take)):0;  }},
								<?php
								}
							endif; */  ?>
						{data: 'tenure_desc'},
						{data: 'id', render: function ( data, type, full, meta ) {
                                                        pap_crops = ko.utils.arrayFilter(viewModel.pap_crops(), function(pap_crop){
                                                            if(parseInt(pap_crop.pap_id) == parseInt(data))
                                                            return true;
                                                        });
                                                        return generateHTML(pap_crops);
                                                    }
                                                },
						{data: 'id', render: function ( data, type, full, meta ) {
                                                        pap_improvements = ko.utils.arrayFilter(viewModel.pap_improvements(), function(pap_improvement){
                                                            if(parseInt(pap_improvement.pap_id) == parseInt(data))
                                                            return true;
                                                        });
                                                        return generateHTML(pap_improvements);
                                                    }
                                                },
						{data: 'comment'},
						{ data: 'id', render: function ( data, type, full, meta ) {return '<a data-toggle="modal" data-toggle="modal" href="#papModal"   class=" btn-white btn-sm edit_me"><i class="fa fa-pencil"></i> </a><a href="#" class= "btn-danger btn-sm delete_me"><i class="fa fa-trash-o"></i></a>'}}
						
						] ,
				  buttons: [
					{
					  extend: "copy",
					  className: "btn-sm btn-white"
					},
					{
					  extend: "csv",
					  className: "btn-sm btn-white"
					},
					{
					  extend: "excel",
					  className: "btn-sm btn-white"
					},
					{
					  extend: "pdfHtml5",
					  className: "btn-sm btn-white"
					},
					{
					  extend: "print",
					  className: "btn-sm btn-white"
					},
				  ],
				  responsive: false,
				});
				//$("#datatable-buttons").DataTable();
			}
		  /*-- End Project Affected Person DataTable--*/
		<?php endif;?>
		/* -- PAP Crops Data Table --- */
		if ($("#tblPapCrop").length) {
			  dTable['tblPapCrop'] = $('#tblPapCrop').DataTable({
			  dom: '<".col-md-7"B><".col-md-2"l><".col-md-3"f>rt<".col-md-9"i><".col-md-3"p>',
			  "processing": true,
			  "ajax": {
				  "url":"getData.php",
				  "dataType": "JSON",
				  "type": "POST",
				  "data":  function(d){
						d.tbl = 'pap_crops';
						<?php if(isset($_GET['pap_id'])): ?>
						d.pap_id = <?php echo $_GET['pap_id']; ?>;
						<?php endif;?>
					}
			  },"columnDefs": [ {
				  "targets": [6],
				  "orderable": false,
				  "searchable": false
			  }],
			  "autoWidth": false,
			  "footerCallback": function (tfoot, data, start, end, display ) {
				  var api = this.api();
				  //get data arrays for the respective columns
				  var totalQty = api.column(4).data();
				  var totalAmount = api.column(5).data();
				  var pageQty = api.column(4, { page: 'current'}).data();
				  var pageAmount = api.column(5, { page: 'current'}).data();
				  
				  var total = 0, pageTotal = 0;
				  $.each(totalQty, function(key, val){ //summing up the overall total
					  total += (parseInt(val)*parseFloat(totalAmount[key]));
				  });
				  $.each(pageQty, function(key, val){ //summing up the page total
					  pageTotal += (parseInt(val)*parseFloat(pageAmount[key]))+" ";
				  });
				  
					$(api.column(5).footer()).html( curr_format(pageTotal) + ' (' + curr_format(total) + ')' );
			  },
			  columns:[ { data: 'id', render: function( data, type, full, meta ) {return meta.row+1;} },
				  { data: 'croptype' },
					{ data: 'cropdescription'},
					{ data: 'old_rate', render: function( data, type, full, meta ) {return curr_format(parseFloat(data));}},
					{ data: 'quantity', render: function( data, type, full, meta ) {return curr_format(parseFloat(data))+" "+(full.short_form?full.short_form:'') ;}},
					{ data: 'old_rate', render: function( data, type, full, meta ) {return curr_format(parseFloat(data) * parseInt(full.quantity));}},
					{ data: 'id', render: function ( data, type, full, meta ) {return '<a data-toggle="modal" data-toggle="modal" href="#papCropModal" class=" btn-white btn-sm edit_me"><i class="fa fa-pencil"></i> </a><a href="#" class= "btn-danger btn-sm delete_me"><i class="fa fa-trash-o"></i></a>';}}
					
					] ,
			  buttons: [
				{
				  extend: "copy",
				  className: "btn-sm btn-white"
				},
				{
				  extend: "csv",
				  className: "btn-sm btn-white"
				},
				{
				  extend: "excel",
				  className: "btn-sm btn-white"
				},
				{
				  extend: "pdfHtml5",
				  className: "btn-sm btn-white"
				},
				{
				  extend: "print",
				  className: "btn-sm btn-white"
				},
			  ],
			  responsive: true,
			});
			//$("#datatable-buttons").DataTable();
		}
	  /*-- End PAP Crops DataTable--*/
		/* -- PAP Imrpovements Data Table --- */
		if ($("#tblPapImprovement").length) {
			  dTable['tblPapImprovement'] = $('#tblPapImprovement').DataTable({
			  dom: '<".col-md-7"B><".col-md-2"l><".col-md-3"f>rt<".col-md-9"i><".col-md-3"p>',
			  "processing": true,
			  "ajax": {
				  "url":"getData.php",
				  "dataType": "JSON",
				  "type": "POST",
				  "data":  function(d){
						d.tbl = 'pap_improvements';
						<?php if(isset($_GET['pap_id'])): ?>
						d.pap_id = <?php echo $_GET['pap_id']; ?>;
						<?php endif;?>
					}
			  },"columnDefs": [ {
				  "targets": [6],
				  "orderable": false,
				  "searchable": false
			  }],
			  "autoWidth": false,
			  "footerCallback": function (tfoot, data, start, end, display ) {
				  var api = this.api();
				  //get data arrays for the respective columns
				  var totalQty = api.column(4).data();
				  var totalAmount = api.column(5).data();
				  var pageQty = api.column(4, { page: 'current'}).data();
				  var pageAmount = api.column(5, { page: 'current'}).data();
				  
				  var total = 0, pageTotal = 0;
				  $.each(totalQty, function(key, val){ //summing up the overall total
					  total += (parseFloat(val)*parseFloat(totalAmount[key]))
				  });
				  $.each(pageQty, function(key, val){ //summing up the page total
					  pageTotal += (parseFloat(val)*parseFloat(pageAmount[key]))
				  });
					$(api.column(5).footer()).html( curr_format(Math.round(pageTotal) + ' (' + total + ')') );
			  },
			  columns:[ { data: 'id', render: function( data, type, full, meta ) {return meta.row+1;} },
				  { data: 'propertytype' },
					{ data: 'propertydescription'},
					{ data: 'old_rate', render: function( data, type, full, meta ) {return curr_format(parseFloat(data));} },
					{ data: 'quantity', render: function( data, type, full, meta ) {return curr_format(parseFloat(data))+" "+(full.short_form?full.short_form:'') ;}},
					{ data: 'old_rate', render: function( data, type, full, meta ) {return curr_format(parseFloat(data)*parseFloat(full.quantity));}},
					{ data: 'id', render: function ( data, type, full, meta ) {return '<a data-toggle="modal" data-toggle="modal" href="#papImprovementModal" id="'+data+'-tblPapImprovement-tblPapImprovement"class=" btn-white btn-sm edit_me"><i class="fa fa-pencil"></i> </a><a href="#" class= "btn-danger btn-sm delete_me"><i class="fa fa-trash-o"></i></a>';}}
					
					] ,
			  buttons: [
				{
				  extend: "copy",
				  className: "btn-sm btn-white"
				},
				{
				  extend: "csv",
				  className: "btn-sm btn-white"
				},
				{
				  extend: "excel",
				  className: "btn-sm btn-white"
				},
				{
				  extend: "pdfHtml5",
				  className: "btn-sm btn-white"
				},
				{
				  extend: "print",
				  className: "btn-sm btn-white"
				},
			  ],
			  responsive: true,
			});
			//$("#datatable-buttons").DataTable();
		}
	  /*-- End PAP Crops DataTable--*/
	  /* -- Clients Data Table --- */
	  if ($("#tblProjectCoverage").length) {
			  dTable['tblProjectCoverage'] = $('#tblProjectCoverage').DataTable({
			  dom: "Brt",
			  "processing": true,
			  "ajax": {
				  "url":"getData.php",
				  "dataType": "JSON",
				  "type": "POST",
				  "data":  function(d){
					 
						d.project_id = <?php echo $_GET['id']; ?>;
						d.tbl = 'project_coverage';
					}
			  },
			  "initComplete": function(settings,json){
					viewModel.project_districts(json.data);
					viewModel.project_districts.valueHasMutated();
			  },
			  "columnDefs": [ {
				  "targets": [0],
				  "orderable": false,
				  "searchable": false
			  }],
			  "autoWidth": false,
			  columns:[ { data: 'district_name' },
					{ data: 'id', render: function ( data, type, full, meta ) {return '<a href="#" class= "btn-danger btn-sm delete_me" ><i class="fa fa-trash-o"></i></a>';}}
					
					] ,
			  buttons: [
				{
				  extend: "copy",
				  className: "btn-sm btn-white"
				},
				{
				  extend: "csv",
				  className: "btn-sm btn-white"
				},
				{
				  extend: "excel",
				  className: "btn-sm btn-white"
				},
				{
				  extend: "pdfHtml5",
				  className: "btn-sm btn-white"
				},
				{
				  extend: "print",
				  className: "btn-sm btn-white"
				},
			  ],
			  responsive: true,
			});
			//$("#datatable-buttons").DataTable();
		}
	  /*-- End Clients Table --*/
	};
	TableManageButtons = function() {
	  "use strict";
	  return {
		init: function() {
		  handleDataTableButtons();
		}
	  };
	}();
	
	TableManageButtons.init();
        
                $("#projectCoverageForm").validate({submitHandler: saveData});
                $("#tblPapImprovementForm").validate({submitHandler: saveData});
                $("#tblPapPhotoForm").validate({submitHandler: saveData});
                $("#tblPapCropForm").validate({submitHandler: saveData});
                $("#tblLandPapForm").validate({submitHandler: saveData});
                $("#tblPapCondensedReportForm").validate({
		rules: {
			phone_contact: {
				phoneUg: true
			}
		},submitHandler: saveData});
});
viewModel.getServerData();// get data to be populated on the page
ko.applyBindings(viewModel, $("#project_page")[0]); //

//Functions being used in more than one instances / places
//0772307940 clicking the update icon
$('table tbody').on( 'click', '.edit_me', function () {
	var row = $(this).closest("tr");
	var tbl = $(row).parent().parent();
	tbl_id = $(tbl).attr("id");
	var dt = dTable[tbl_id];
	var data = dt.row(row).data();
        //console.log(data);
	var rowId = data.pap_d;
	if(typeof(data)=='undefined'){
		data = dt.row($(row).prev()).data();
	}
        if(typeof rowId !== 'undefined'){
	data.id = rowId;
        }
	edit_data(data, tbl_id+'Form');
        //alert(rowId);
	$("#form_id").val(rowId);
	<?php if(!isset($_GET['pap_id'])): ?>
		// Display the update form
		viewModel.pap_details(data);
		viewModel.getPapDetails(data.pap_d);
		//we need to set the village object accordingly
		viewModel.village(ko.utils.arrayFirst(viewModel.villagesList(), function(currentVillage){
			return (data.village_id == currentVillage.id);
		}));
		$('#village_id').val(data.village_id);
		//we need to set the parish object accordingly
		viewModel.parish(ko.utils.arrayFirst(viewModel.parishesList(), function(currentParish){
			return (data.parish_id == currentParish.id);
		}));
		$('#parish_id').val(data.parish_id);
		//as well as the scounty object
		viewModel.scounty(ko.utils.arrayFirst(viewModel.subcountiesList(), function(currentSCounty){
			return (data.subcounty_id == currentSCounty.id);
		}));
		$('#subcounty_id').val(data.subcounty_id);
		//and the county object
		/* viewModel.county(ko.utils.arrayFirst(viewModel.countiesList(), function(currentCounty){
			return (data.county_id == currentCounty.id);
		})); */
		//$('#county_id').val(data.county_id);
		//finally the district object
		viewModel.district(ko.utils.arrayFirst(viewModel.project_districts(), function(currentDistrict){
			return (data.district_id == currentDistrict.id);
		}));
	<?php else:?>
	<?php endif;?>
} );

/* Delete whenever a Delete Button has been clicked */

$('table tbody').on('click', '.delete_me', function () {
	var confirmation = confirm("Are sure you would like to delete this item?");
	if(confirmation){
		var row = $(this).closest("tr");
		var tbl = $(row).parent().parent();
		var dt = dTable[$(tbl).attr("id")];
		var data = dt.row(row).data();
		if(typeof(data)=='undefined'){
			data = dt.row($(row).prev()).data();
		}
		$.ajax({ // create an AJAX call...
			url: "delete.php?id="+data.pap_d+"&tbl="+$(tbl).attr("id"), // the file to call
			success: function(response) { // on success..
				showStatusMessage(response, "success");
				setTimeout(function(){
					dt.ajax.reload(null,false);
				}, 300);
			}			
		}); 
	}
});


</script>
