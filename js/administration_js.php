<script>
var dTable = {};
$(document).ready(function(){
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
		if ($("#tblStaff").length) {
			  dTable['tblStaffForm'] = $('#tblStaff').DataTable({
			  dom: "lfrtipB",
			  "processing": true,
			  "ajax": {
				  "url":"getData.php",
				  "dataType": "JSON",
				  "type": "POST",
				  "data":  function(d){
						d.tbl = 'staff';
					}
			  },"columnDefs": [ {
				  "targets": [2],
				  "orderable": false,
				  "searchable": false
			  }],
			  "autoWidth": false,
			  columns:[ { data: 'staff_type', render: function ( data, type, full, meta ) { if(data == 1){ return"Permanent Staff"; }else{ return "Temporary Staff"; } }},
				  { data: 'id', render: function ( data, type, full, meta ) { return full.firstname + ' ' + full.othername + ' ' + full.lastname;}},
					{ data: 'title'},
					{ data: 'email'},
					{ data: 'phone_contact'},
					{ data: 'phone_contact2'},
					{ data: 'address'},
					{ data: 'date_added', render: function ( data, type, full, meta ) { return moment(data, 'X').format('DD-MMM-YYYY'); }},
					{ data: 'id', render: function ( data, type, full, meta ) {return '<a data-toggle="modal" data-toggle="modal" id="'+data+'-staff-tblStaffForm" href="#staffModal" class=" btn-white btn-sm edit_me"><i class="fa fa-pencil"></i> </a><span id="'+data+'-staff-tblStaff" class= "btn-danger btn-sm delete_me"><i class="fa fa-trash-o"></i></span>';}}
					
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
	}
	TableManageButtons = function() {
	  "use strict";
	  return {
		init: function() {
		  handleDataTableButtons();
		}
	  };
	}();
	TableManageButtons.init();
	$('.table tbody').on('click', 'tr .edit_me', function () {
		//id="'+data+'-person_type-personTypeTable" 
		
		var tbl, id , frm, dt;
		var d_id = $(this).attr("id");
		var arr = d_id.split("-");
		id = arr[0]; //The  row id 
		tbl = arr[1]; // The table , 
		frm = arr[2]; //The form id
		dt = dTable[frm];
		var row = $(this).parent().parent(); 
		edit_data(dt.row(row).data(), frm);
		
	});
	deleteDataTableRowData();
	
	$("#tblStaffForm").validate({
		rules: {
			email: {
				required: true,
				// Specify that email should be validated
				// by the built-in "email" rule
				email: true,
				remote: {
					url: "check_email.php",
					type: "post",
					data: {
					  email: function() {
							var form_id = $("#form_id").val();
							if(form_id == ""){
								return $( "#email" ).val();
							}
					  }
					}
				}
			},
			email2: {
				required: true,
				// Specify that email should be validated
				// by the built-in "email" rule
				email: true,
				equalTo: "#email"
			},
			password: {
				required: true,
				minlength: 5
			},
			confirm_password: {
				required: true,
				minlength: 5,
				equalTo: "#password"
			}
		},
		 messages: {
			password: {
				required: "Please provide a password",
				minlength: "Your password must be at least 5 characters long"
			},
			email: {
				email:"Please enter valid email",
				required: "An email is required",
				remote: "Email already in use!"
			}
		 },
		submitHandler: saveData
	});
});
function saveData(form,event){
	event.preventDefault();
	var frm =  $(form).closest("form");
	var frmdata = frm.serialize();
	var id_input = frm.find("input[name = 'id']").val();;
	var frmId = frm.attr('id');
	$.ajax({
		url: "save_data.php",
		type: 'POST',
		dataType:'json',
		data: frmdata,
		success: function (response) {
			if(response.success){
				showStatusMessage("Data successfully saved" ,"success");
				setTimeout(function(){
					if(id_input == ""){
						document.getElementById(frmId).reset();
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
function deleteDataTableRowData(){
	$('.table tbody').on('click', 'tr .delete_me', function () {
		var confirmation = confirm("Are sure you would like to delete this item?");
		if(confirmation){
			var tbl;
			var id;
			var d_id = $(this).attr("id")
			var arr = d_id.split("-");
			id = arr[0];//This is the row id
			tbl = arr[1]; //This is the table to delete from 
			var dttbl = arr[2];//Table to reload
			//alert(dttbl);
			 $.ajax({ // create an AJAX call...
				url: "delete.php?id="+id+"&tbl="+tbl, // the file to call
				success: function(response) { // on success..
					showStatusMessage(response, "success");
					window.location.reload(true);
				}			
			}); 
		}
	});
}
	
</script>