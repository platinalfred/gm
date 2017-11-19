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
		<?php if(isset($_GET['pap_id'])):?>
		self.crop_rate_description = ko.observable(); //crop rate object when adding or saving crops
		self.property_rate_description = ko.observable(); //property rate object when adding or saving properties
		<?php endif; ?>
		
		self.selectedDistricts = ko.observableArray([new DummyObject()]);
		self.selectedImprovements = ko.observableArray([new DummyObject()]);
		self.serverDataImprovements = ko.observableArray(); //data returned from the serve upon clicking the edit button
		self.selectedPlants = ko.observableArray([new DummyObject()]);
		self.serverDataPlants = ko.observableArray(); //data returned from the serve upon clicking the edit button
		//operations
		//districts
		self.addDistrict = function(){self.selectedDistricts.push(new DummyObject());};
		self.removeSelectedDistrict = function(selectedDistrict){self.selectedDistricts.remove(selectedDistrict);};
		//improvements
		self.addImprovement = function(){self.selectedImprovements.push(new DummyObject());};
		self.removeSelectedImprovement = function(selectedImprovement){self.selectedImprovements.remove(selectedImprovement);};
		self.removeServerDataImprovement = function(serverDataImprovement){self.serverDataImprovements.remove(serverDataImprovement);};
		//plants
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
					self.available_districts(response.available_districts);
					self.district_property_rates(response.district_property_rates);
					self.district_crop_rates(response.district_crop_rates);
					viewModel.available_districts.valueHasMutated();
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
	//This function is supposed to make sure when the pop up is not an edit, no data is displayed in the form. It picks the id field and makes sure if empty then the form is empty for adding new data
	function showStatusMessage(message='', display_type='success'){
		new PNotify({
			  title: "Action response",
			  text: message,
			  type: display_type,
			  styling: 'bootstrap3',
			  sound: true,
			  hide:true,
			  buttons: {
				closer_hover: false,
			},
			confirm: {
				confirm: true,
				buttons: [{
					text: 'Ok',
					addClass: 'btn-primary',
					click: function(notice) {
						notice.remove();
					}
				},
				null]
			},
			animate: {
				animate: true,
				in_class: 'zoomInLeft',
				out_class: 'zoomOutRight'
			},
			  nonblock: {
				  nonblock: true
			  }
			  
		  });
		
	}

	var handleDataTableButtons = function() {
		/* -- Project Affected Person Data Table --- */
		if ($("#tblPap").length) {
			  dTable['tblPap'] = $('#tblPap').DataTable({
			  dom: "lfrtipB",
			  "processing": true,
			  "ajax": {
				  "url":"getData.php",
				  "dataType": "JSON",
				  "type": "POST",
				  "data":  function(d){
						d.tbl = 'project_paps';
						d.project_id = <?php echo $_GET['id']; ?>;
					}
			  },"columnDefs": [ {
				  "targets": [11],
				  "orderable": false,
				  "searchable": false
			  }],
			  "autoWidth": false,
			  columns:[ { data: 'pap_ref', render: function( data, type, full, meta ) {return '<a href="project_details.php?id=<?php echo $_GET['id']; ?>&amp;pap_id='+full.id+'" title="View PAP details">'+ data + '</a>';} },
				  { data: 'firstname', render: function( data, type, full, meta ) {return full.lastname+' ' + data + ' ' + (full.othername?full.othername:'');} },
					{ data: 'district_name'},
					/* { data: 'county_id'},
					{ data: 'subcounty_id'},
					{ data: 'parish_id'}, */
					{ data: 'village'},
					{ data: 'phone_contact'},
					{ data: 'way_leave', render: function( data, type, full, meta ) {return data?curr_format(data):0;}},
					{ data: 'rightofway', render: function( data, type, full, meta ) {return data?curr_format(data):0;}},
					{ data: 'total_take', render: function( data, type, full, meta ) {return data?curr_format(data):0;}},
					{ data: 'chainage'},
					{ data: 'improvement_sum', render: function( data, type, full, meta ) {return data?curr_format(parseInt(data)):0;}},
					{ data: 'crop_tree_sum', render: function( data, type, full, meta ) {return data?curr_format(parseInt(data)):0;}},
					{ data: 'id', render: function ( data, type, full, meta ) {return '<a data-toggle="modal" data-toggle="modal" href="#papModal" class=" btn-white btn-sm edit_me"><i class="fa fa-pencil"></i> </a><a href="#" class= "btn-danger btn-sm delete_me"><i class="fa fa-trash-o"></i></a>';}}
					
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
	  /*-- End Project Affected Person DataTable--*/
		/* -- PAP Crops Data Table --- */
		if ($("#tblPapCrop").length) {
			  dTable['tblPapCrop'] = $('#tblPapCrop').DataTable({
			  dom: "lfrtipB",
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
			  columns:[ { data: 'id'},
				  { data: 'croptype' },
					{ data: 'cropdescription'},
					{ data: 'old_rate', render: function( data, type, full, meta ) {return curr_format(parseFloat(data));}},
					{ data: 'quantity'},
					{ data: 'rate', render: function( data, type, full, meta ) {return curr_format(parseFloat(data)*parseInt(full.quantity));}},
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
			  dom: "lfrtipB",
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
			  columns:[ { data: 'id'},
				  { data: 'propertytype' },
					{ data: 'propertydescription'},
					{ data: 'old_rate', render: function( data, type, full, meta ) {return curr_format(parseFloat(data));} },
					{ data: 'quantity'},
					{ data: 'rate', render: function( data, type, full, meta ) {return curr_format(parseFloat(data)*parseInt(full.quantity));}},
					{ data: 'id', render: function ( data, type, full, meta ) {return '<a data-toggle="modal" data-toggle="modal" href="#papImprovementModal" class=" btn-white btn-sm edit_me"><i class="fa fa-pencil"></i> </a><a href="#" class= "btn-danger btn-sm delete_me"><i class="fa fa-trash-o"></i></a>';}}
					
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
			  dom: "lfrtipB",
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
});
viewModel.getServerData();// get data to be populated on the page
ko.applyBindings(viewModel, $("#project_page")[0]); //

//Functions being used in more than one instances / places
//With this one function all settings will be sent to save_data.php for saving
function saveData(form,event){
		event.preventDefault();
		var frm = $(form)[0];
		var frmdata = new FormData(frm);
		var id_input = frmdata.get("id");
		var frmId = frmdata.get("tbl");
		$.ajax({
			url: "save_data.php",
			type: 'POST',
			async: false,
			cache: false,
			contentType: false,
			processData: false,
			dataType:'json',
			data: frmdata,
			success: function (response) {
				if(response.success){
					showStatusMessage("Data successfully saved" ,"success");
					setTimeout(function(){
						if(id_input == ""){
							frm.reset();
						}
						if(frmId == 'tblProjectCoverage'){
							//location.reload(true);
							viewModel.getServerData();
						}
						else{
						//if(frmId == 'tblPap'){
						}
						dTable[frmId].ajax.reload();
					}, 2000);
				}else{
					
					showStatusMessage(response.message, "fail");
				}
				
			}
		});

		return false;
	//});
}
//clicking the update icon
$('table tbody').on( 'click', '.edit_me', function () {
	var row = $(this).closest("tr");
	var tbl = $(row).parent().parent();
	tbl_id = $(tbl).attr("id");
	var dt = dTable[tbl_id];
	var data = dt.row(row).data();
	if(typeof(data)=='undefined'){
		data = dt.row($(row).prev()).data();
	}
	<?php if(!isset($_GET['pap_id'])): ?>
		// Display the update form
		viewModel.pap_details(data);
		viewModel.getPapDetails(data.id);
	<?php endif;?>
	edit_data(data, tbl_id+'Form'); /* */
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
			url: "delete.php?id="+data.id+"&tbl="+$(tbl).attr("id"), // the file to call
			success: function(response) { // on success..
				showStatusMessage(response, "success");
				setTimeout(function(){
					dt.ajax.reload();
				}, 300);
			}			
		}); 
	}
});

$("#projectCoverageForm").validate({submitHandler: saveData});
$("#tblPapImprovementForm").validate({submitHandler: saveData});
$("#tblPapCropForm").validate({submitHandler: saveData});
$("#tblPapForm").validate({
		rules: {
			phone_contact: {
				phoneUg: true
			}
		},submitHandler: saveData});

</script>