<script>
//the view model for the page
var DummyObject = function(){
	var self = this;
}
var ViewModel = function() {
		var self = this;
		self.project_districts = ko.observableArray(); //list of districts covered by this project
		self.available_districts = ko.observableArray(); //list of districts available to be added to this project
		self.district_property_rates = ko.observableArray(); //list of district property rates
		self.district_crop_rates = ko.observableArray(); //list of district crop rates
		
		self.selectedDistricts = ko.observableArray([new DummyObject()]);
		self.selectedImprovements = ko.observableArray([new DummyObject()]);
		self.serverDataImprovements = ko.observableArray(); //data returned from the serve upon clicking the edit button
		self.selectedPlants = ko.observableArray([new DummyObject()]);
		self.serverDataPlants = ko.observableArray(); //data returned from the serve upon clicking the edit button
		//operations
		self.addDistrict = function(){self.selectedDistricts.push(new DummyObject());};
		self.removeSelectedDistrict = function(selectedDistrict){self.selectedDistricts.remove(selectedDistrict);};
		self.addImprovement = function(){self.selectedImprovements.push(new DummyObject());};
		self.removeSelectedImprovement = function(selectedImprovement){self.selectedImprovements.remove(selectedImprovement);};
		self.addPlant = function(){self.selectedPlants.push(new DummyObject());};
		self.removeSelectedPlant = function(selectedPlant){self.selectedPlants.remove(selectedPlant);};
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
					if(reponse.success){
						self.serverDataImprovements(response.pap_improvements);
						self.serverDataCropTrees(response.pap_crop_trees);
						viewModel.serverDataImprovements.valueHasMutated();
						viewModel.serverCropTrees.valueHasMutated();
					}
				}
			})
		};	
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
		/* -- Land Acquisition category Data Table --- */
		if ($("#tblPap").length) {
			  dTable['tblPap'] = $('#tblPap').DataTable({
			  dom: "lfrtipB",
			  "processing": true,
			  "ajax": {
				  "url":"getData.php",
				  "dataType": "JSON",
				  "type": "POST",
				  "data":  function(d){
						d.tbl = 'paps';
						d.project_id = <?php echo $_GET['id']; ?>;
					}
			  },"columnDefs": [ {
				  "targets": [2],
				  "orderable": false,
				  "searchable": false
			  }],
			  "autoWidth": false,
			  columns:[ { data: 'pap_ref' },
				  { data: 'firstname' },
					{ data: 'district_name'},
					{ data: 'county_name'},
					{ data: 'subcounty_name'},
					{ data: 'parish_name'},
					{ data: 'village'},
					{ data: 'phone_contact'},
					{ data: 'way_leave'},
					{ data: 'rightofway'},
					{ data: 'totaltake'},
					{ data: 'chainage'},
					{ data: 'chainage'},
					{ data: 'id', render: function ( data, type, full, meta ) {return '<a data-toggle="modal" data-toggle="modal" href="#projectModal" class=" btn-white btn-sm edit_me"><i class="fa fa-pencil"></i> </a><span id="'+data+'-land_acquistion_category-landAcquisition" class= "btn-danger btn-sm delete_me"><i class="fa fa-trash-o"></i></span>';}}
					
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
	  /*-- End Land Acquisition category--*/
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
				  "targets": [2],
				  "orderable": false,
				  "searchable": false
			  }],
			  "autoWidth": false,
			  columns:[ { data: 'district_name' },
					{ data: 'id', render: function ( data, type, full, meta ) {return '<a data-toggle="modal"  data-toggle="modal" href="#projectCoverageModal" class=" btn-white btn-sm edit_me"><i class="fa fa-pencil"></i> </a><span class= "btn-danger btn-sm delete_me" id="'+data+'&amp;tbl=tbl_client"><i class="fa fa-trash-o"></i></span>';}}
					
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
ko.applyBindings(viewModel);// , $("#loan_account_details")[0]

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
							dTable[frmId].ajax.reload();
						}
					}, 2000);
				}else{
					
					showStatusMessage(response, "fail");
				}
				
			}
		});

		return false;
	//});
}
//clicking the update icon
$('table#tblPap tbody').on( 'click', '.edit_me', function () {
	var row = $(this).closest("tr");
	var tbl = $(row).parent().parent();
	var dt = dTable[$(tbl).attr("id")];
	var data = dt.row(row).data();
	if(typeof(data)=='undefined'){
		data = dt.row($(row).prev()).data();
	}
    // Display the update form
	viewModel.getPapDetails(data.id);
	edit_data(data, 'tblPapForm'); /* */
} );

/* Delete whenever a Delete Button has been clicked */

$('table tbody').on('click', '.delete_me', function () {
	var confirmation = confirm("Are sure you would like to delete this item?");
	if(confirmation){
		var row = $(this).closest("tr");
		var tbl = $(row).parent().parent();
		
		var del_attr = $(this).attr("id");
		 $.ajax({ // create an AJAX call...
			url: "delete.php?id="+del_attr, // the file to call
			success: function(response) { // on success..
				showStatusMessage(response, "success");
				setTimeout(function(){
					var dt = dTable[$(tbl).attr("id")];
					dt.ajax.reload();
				}, 300);
			}			
		}); 
	}
});

$("#projectCoverageForm").validate({submitHandler: saveData});
$("#tblPapForm").validate({submitHandler: saveData});
</script>