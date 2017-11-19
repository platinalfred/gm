<script>
//the view model for the page
var ViewModel = function() {
		var self = this;
		self.clients = ko.observableArray();
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
				data:{tbl:"project_setup"},
				url: "getData.php",
				success: function(response){
					self.clients(response.clients);
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
		if ($("#tblLandProject").length) {
			  dTable['tblLandProject'] = $('#tblLandProject').DataTable({
			  dom: "lfrtipB",
			  "processing": true,
			  "ajax": {
				  "url":"getData.php",
				  "dataType": "JSON",
				  "type": "POST",
				  "data":  function(d){
					 
						d.tbl = 'land_access_project';
					}
			  },"columnDefs": [ {
				  "targets": [2],
				  "orderable": false,
				  "searchable": false
			  }],
			  "autoWidth": false,
			  columns:[ { data: 'project_title', render: function ( data, type, full, meta ) {return '<a data-toggle="modal" href="project_details.php?id='+full.id+'">' + data + '</a>';} },
				  { data: 'client_names' },
					{ data: 'project_reference'},
					{ data: 'project_category'},
					{ data: 'date_added'},
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
	  if ($("#tblClient").length) {
			  dTable['tblClient'] = $('#tblClient').DataTable({
			  dom: "lfrtipB",
			  "processing": true,
			  "ajax": {
				  "url":"getData.php",
				  "dataType": "JSON",
				  "type": "POST",
				  "data":  function(d){
					 
						d.tbl = 'gmt_clients';
					}
			  },
			  "initComplete": function(settings,json){
					viewModel.clients(json.data);
					viewModel.clients.valueHasMutated();
			  },
			  "columnDefs": [ {
				  "targets": [2],
				  "orderable": false,
				  "searchable": false
			  }],
			  "autoWidth": false,
			  columns:[ { data: 'client_names'},
					{ data: 'postal_address'},
					{ data: 'phone_contact1'},
					{ data: 'phone_contact2'},
					{ data: 'email_contact1'},
					{ data: 'email_contact2'},
					{ data: 'id', render: function ( data, type, full, meta ) {return '<a data-toggle="modal" data-toggle="modal" href="#clientModal" class=" btn-white btn-sm edit_me"><i class="fa fa-pencil"></i> </a><span class= "btn-danger btn-sm delete_me" id="'+data+'&amp;tbl=tbl_client"><i class="fa fa-trash-o"></i></span>';}}
					
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
//viewModel.getServerData();// get data to be populated on the page
ko.applyBindings(viewModel, $("#loan_account_details")[0]);

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
						if(frmId == 'tblClient'){
							location.reload(true);
							//viewModel.getServerData();
						}
						if(frmId == 'tblLandProject'){
							if(id_input != "")
								location.replace('project_details.php?id='+response.project_id);
							else
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
$('table tbody').on( 'click', '.edit_me', function () {
	var row = $(this).closest("tr");
	var tbl = $(row).parent().parent();
	var dt = dTable[$(tbl).attr("id")];
	var data = dt.row(row).data();
	if(typeof(data)=='undefined'){
		data = dt.row($(row).prev()).data();
	}
    // Display the update form
	edit_data(data, $(tbl).attr("id") + 'Form'); /* */
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

$("#tblClientForm").validate({submitHandler: saveData});
$("#tblLandProjectForm").validate({submitHandler: saveData});
</script>