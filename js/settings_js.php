<script>
var dTable = new Object();
var ViewModel = function() {
	var self = this;
	self.districtsList = ko.observableArray();	
	self.countiesList = ko.observableArray();	
	self.subcountiesList = ko.observableArray();	
	self.parishesList = ko.observableArray();

	//useful variables for the form
	self.district = ko.observable();
	self.county = ko.observable();
	self.scounty = ko.observable();
	self.parish = ko.observable();
	
	self.filteredCountiesList = ko.computed(function() {
		if(self.district()){
			return ko.utils.arrayFilter(self.countiesList(), function(county) {
					
				return (parseInt(self.district().id)==parseInt(county.district));
				
			});
		}
	});	
	self.filteredSCountiesList = ko.computed(function() {
		if(self.county()){
			return ko.utils.arrayFilter(self.subcountiesList(), function(scounty) {
				return (parseInt(self.county().id)==parseInt(scounty.county));
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
	
	//set options value afterwards
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
	self.getServerData = function(tbl) {
		$.ajax({
			type: "post",
			dataType: "json",
			data:{origin:tbl},
			url: "geographical_details.php",
			success: function(response){
				switch(tbl){
					case "counties":
						self.districtsList(response.districts);
					break;
					case "subcounties":
						self.districtsList(response.districts);
						self.countiesList(response.counties);
					break;
					case "parishes":
						self.districtsList(response.districts);
						self.countiesList(response.counties);
						self.subcountiesList(response.subcounties);	
					break;
					case "villages":
						self.districtsList(response.districts);
						self.countiesList(response.counties);
						self.subcountiesList(response.subcounties);	
						self.parishesList(response.parishes);
					break;
					default:
					break;
				}
			}
		})
	};
}
 var viewModel = new ViewModel();
 ko.applyBindings(viewModel, $("#tab-6")[0]); //
$(document).ready(function(){
	
	//This function is supposed to make sure when the pop up is not an edit no data is displayed in the form. It picks the id field and makes sure if empty then the form is empty for adding new data
	$('.modal').on('show.bs.modal', function (e) {
		var id = $(this).find('input[name="id"]').val();
		var frm = $(this).find("form");
		if(id == "undefined" || id == ""){
			frm[0].reset(); 
		}
	});
	
	/* Number inputs a thousandsSeparator separator */
		$('input.athousand_separator').keyup(function(event) {

		  // skip for arrow keys
		  if(event.which >= 37 && event.which <= 40){
		   event.preventDefault();
		  }

		  $(this).val(function(index, value) {
			  value = value.replace(/,/g,'');
			  return numberWithCommas(value);
		  });
		});

	function numberWithCommas(x) {
			var parts = x.toString().split(".");
			parts[0] = parts[0].replace(/\B(?=(\d{3})+(?!\d))/g, ",");
			return parts.join(".");
		}
	/* End a thousandsSeparator on an input*/
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
/* ====  COMMON FUNCTIONS ==== */
	
	deleteDataTableRowData();
	saveData();
	
	/*To have a form editable first add a class .edit_me on the row, also add an Id-tbl_name-formId and also add an empty id field in the form */

	//With this one function all settings will be sent to save_data.php for saving
	function saveData(){
		$(".save").click(function(){
			var frm = $(this).closest("form");
			var frmdata = frm.serialize();
			var frmId = frm.attr('id');
			var id_input = frm.find().val();
			var reset = frm.find("input[name = 'noreset']").length;
			
			enableDisableButton(frm, true);
			$.ajax({
				url: "save_data.php",
				type: 'POST',
				data: frmdata,
				success: function (response) {
					
					if($.trim(response) == "success"){
						showStatusMessage("Data successfully saved" ,"success");
						
						setTimeout(function(){
							dTable[frmId].ajax.reload();
						}, 2000);
						if(id_input == "" && reset < 1){
							frm[0].reset();
						}
						enableDisableButton(frm, false);
					}else{
						
						showStatusMessage(response, "fail");
						enableDisableButton(frm, false);
					}
					
					
				}
			});
			return false;
		});
	}
	
	//Functions being used in more than one instances / places
		/* Delete whenever a Delete Button has been clicked */
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
				 $.ajax({ // create an AJAX call...
					url: "delete.php?id="+id+"&tbl="+tbl, // the file to call
					success: function(response) { // on success..
						showStatusMessage(response, "success");
						setTimeout(function(){
							var dt = dTable[dttbl];
							dt.ajax.reload();
						}, 300);
					}			
				}); 
			}
		});
	}
	/*Thousands separator and creates a price format into an input */
	/* $('#minimum_balance, #minAmount, #maxAmount, #defmount').priceFormat({
		thousandsSeparator: '.'
	}); */
/* ====  END COMMON FUNCTIONS ==== */
	
	
	var handleDataTableButtons = function() {
		/* -- Land Acquisition category Data Table --- */
			if ($("#land_acquistion_category").length) {
			  dTable['landAcquisition'] = $('#land_acquistion_category').DataTable({
			  dom: "lfrtipB",
			  "processing": true,
			  /*"serverSide": true,
			  "deferRender": true,
			  "order": [[ 1, 'asc' ]],*/
			  "ajax": {
				  "url":"settings_data.php",
				  "dataType": "JSON",
				  "type": "POST",
				  "data":  function(d){
					 
						d.tbl = 'land_acquistion_category';
						//d.start_date = getStartDate();
						//d.end_date = getEndDate();
					}
			  },"columnDefs": [ {
				  "targets": [2],
				  "orderable": false,
				  "searchable": false
			  }/* , {
				  "targets": [0],
				  "orderable": false
			  } */],
			  "autoWidth": false,
			  columns:[ { data: 'title' },
					{ data: 'description'},//, render: function ( data, type, full, meta ) {return full.firstname + ' ' + full.othername + ' ' + full.lastname;}
					//{ data: 'date_added', render: function ( data, type, full, meta ) {return moment(data).format('LL');}},
					
					{ data: 'id', render: function ( data, type, full, meta ) {return '<a data-toggle="modal" href="#categoryModal"  id="'+data+'-land_acquistion_category-landAcquisition" data-toggle="modal" href="#categoryModal" class=" btn-white btn-sm edit_me"><i class="fa fa-pencil"></i> </a><span id="'+data+'-land_acquistion_category-landAcquisition" class= "btn-danger btn-sm delete_me"><i class="fa fa-trash-o"></i></span>';}}
					
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
	  /* -- Disticts Table --- */
			if ($("#tblDistrict").length) {
			  dTable['tblDistricts'] = $('#tblDistrict').DataTable({
			  dom: "lfrtipB",
			  "processing": true,
			  /*"serverSide": true,
			  "deferRender": true,
			  "order": [[ 1, 'asc' ]],*/
			  "ajax": {
				  "url":"settings_data.php",
				  "dataType": "JSON",
				  "type": "POST",
				  "data":  function(d){
					 
						d.tbl = 'districts';
						//d.start_date = getStartDate();
						//d.end_date = getEndDate();
					}
			  },"columnDefs": [ {
				  "targets": [1],
				  "orderable": false,
				  "searchable": false
			  }/* , {
				  "targets": [0],
				  "orderable": false
			  } */],
			  "autoWidth": false,
			  columns:[ { data: 'district_name' },
					{ data: 'id', render: function ( data, type, full, meta ) {return '<a data-toggle="modal" href="#districts"  id="'+data+'-tblDistrict-tblDistricts" class=" btn-white btn-sm edit_me"><i class="fa fa-pencil"></i> </a><span id="'+data+'-tblDistrict-tblDistricts" class= "btn-danger btn-sm delete_me"><i class="fa fa-trash-o"></i></span>';}}
					
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
	  /*-- End District--*/ 
	  /*-- Counties--*/
		if ($("#tblCounty").length) {
			  dTable['tblCountys'] = $('#tblCounty').DataTable({
			  dom: "lfrtipB",
			  "processing": true,
			  /*"serverSide": true,
			  "deferRender": true,
			  "order": [[ 1, 'asc' ]],*/
			  
			initComplete: function () {
				var select_header = ['','Districts'];
				this.api().columns([1]).every( function () {
					var column = this;
					var col_index = column.index();
					var select = $('<select class="form-control input-sm"><option value="">All '+select_header[col_index]+'</option></select>')
						.appendTo( $("#county"+col_index).empty() )
						.on( 'change', function () {
							var val = $.fn.dataTable.util.escapeRegex(
								$(this).val()
							);
							console.log(val);
							column
								.search( val ? '^'+val+'$' : '', true, false )
								.draw();
						} );
					column.data().unique().sort().each( function ( d, j ) {
						select.append( '<option value="'+d+'">'+d+'</option>' )
					} );
				} );
			},
			"ajax": {
				  "url":"settings_data.php",
				  "dataType": "JSON",
				  "type": "POST",
				  "data":  function(d){
						d.tbl = 'counties';
						//d.start_date = getStartDate();
						//d.end_date = getEndDate();
					}
			  },/*"columnDefs": [ { 
				  "targets": [1], 
				  "orderable": false,
				  "searchable": false
			  } , {
				  "targets": [0],
				  "orderable": false
			  } ],*/
			  "autoWidth": false,
			  columns:[ { data: 'county_name' },
					{ data: 'district_name'},
					{ data: 'id', render: function ( data, type, full, meta ) { return '<a  id="'+data+'-tblCounties-tblCountys"  href="#county" class="btn btn-white btn-sm crop_rate"><i class="fa fa-pencil"></i> Edit </a><span id="'+data+'-tblCounties-tblCountys" class="btn btn-danger btn-sm delete_me"><i class="fa fa-trash-o"></i> Deleted</span>';}}
					
					] ,
			  buttons: [
				{
				  extend: "copy",
				  className: "btn-sm"
				},
				{
				  extend: "csv",
				  className: "btn-sm"
				},
				{
				  extend: "excel",
				  className: "btn-sm"
				},
				{
				  extend: "pdfHtml5",
				  className: "btn-sm"
				},
				{
				  extend: "print",
				  className: "btn-sm"
				},
			  ],
			  responsive: true,
			});
		}
	  /*-- End Counties--*/
	  /*-- Sub Counties--*/
		if ($("#tblSubCounty").length) {
			  dTable['tblSubCountys'] = $('#tblSubCounty').DataTable({
			  dom: "lfrtipB",
			  "processing": true,
			  /*"serverSide": true,
			  "deferRender": true,
			  "order": [[ 1, 'asc' ]],*/
			initComplete: function () {
				var select_header = ['','County','Districts'];
				this.api().columns([1,2]).every( function () {
					var column = this;
					var col_index = column.index();
					var select = $('<select class="form-control input-sm"><option value="">All '+select_header[col_index]+'</option></select>')
						.appendTo( $("#subcounty"+col_index).empty() )
						.on( 'change', function () {
							var val = $.fn.dataTable.util.escapeRegex(
								$(this).val()
							);
							console.log(val);
							column
								.search( val ? '^'+val+'$' : '', true, false )
								.draw();
						} );
					column.data().unique().sort().each( function ( d, j ) {
						select.append( '<option value="'+d+'">'+d+'</option>' )
					} );
				} );
			},
			"ajax": {
				  "url":"settings_data.php",
				  "dataType": "JSON",
				  "type": "POST",
				  "data":  function(d){
						d.tbl = 'subcounties';
						//d.start_date = getStartDate();
						//d.end_date = getEndDate();
					}
			  },/*"columnDefs": [ { 
				  "targets": [1], 
				  "orderable": false,
				  "searchable": false
			  } , {
				  "targets": [0],
				  "orderable": false
			  } ],*/
			  "autoWidth": false,
			  columns:[ { data: 'subcounty_name' },
						{ data: 'county_name' },
					{ data: 'district_name'},
					{ data: 'id', render: function ( data, type, full, meta ) { return '<a  id="'+data+'-tblSubCounties-tblSubCountys"  href="#subcounty" class="btn btn-white btn-sm crop_rate"><i class="fa fa-pencil"></i> Edit </a><span id="'+data+'-tblSubCounties-tblSubCountys" class="btn btn-danger btn-sm delete_me"><i class="fa fa-trash-o"></i> Deleted</span>';}}
					
					] ,
			  buttons: [
				{
				  extend: "copy",
				  className: "btn-sm"
				},
				{
				  extend: "csv",
				  className: "btn-sm"
				},
				{
				  extend: "excel",
				  className: "btn-sm"
				},
				{
				  extend: "pdfHtml5",
				  className: "btn-sm"
				},
				{
				  extend: "print",
				  className: "btn-sm"
				},
			  ],
			  responsive: true,
			});
		}
	  /*-- End SubCounties--*/
	  /*-- Parishes--*/
		if ($("#tblParish").length) {
			  dTable['tblParishs'] = $('#tblParish').DataTable({
			  dom: "lfrtipB",
			  "processing": true,
			  /*"serverSide": true,
			  "deferRender": true,
			  "order": [[ 1, 'asc' ]],*/
			initComplete: function () {
				var select_header = ['', 'SubCounty','County','Districts'];
				this.api().columns([1,2,3]).every( function () {
					var column = this;
					var col_index = column.index();
					var select = $('<select class="form-control input-sm"><option value="">All '+select_header[col_index]+'</option></select>')
						.appendTo( $("#parish"+col_index).empty() )
						.on( 'change', function () {
							var val = $.fn.dataTable.util.escapeRegex(
								$(this).val()
							);
							console.log(val);
							column
								.search( val ? '^'+val+'$' : '', true, false )
								.draw();
						} );
					column.data().unique().sort().each( function ( d, j ) {
						select.append( '<option value="'+d+'">'+d+'</option>' )
					} );
				} );
			},
			"ajax": {
				  "url":"settings_data.php",
				  "dataType": "JSON",
				  "type": "POST",
				  "data":  function(d){
						d.tbl = 'parishes';
						//d.start_date = getStartDate();
						//d.end_date = getEndDate();
					}
			  },/*"columnDefs": [ { 
				  "targets": [1], 
				  "orderable": false,
				  "searchable": false
			  } , {
				  "targets": [0],
				  "orderable": false
			  } ],*/
			  "autoWidth": false,
			  columns:[ { data: 'parish_name' },
					{data: 'subcounty_name' },
					{ data: 'county_name' },
					{ data: 'district_name'},
					{ data: 'id', render: function ( data, type, full, meta ) { return '<a  id="'+data+'-tblParish-tblParishs"  href="#parish" class="btn btn-white btn-sm crop_rate"><i class="fa fa-pencil"></i> Edit </a><span id="'+data+'-tblParish-tblParishs" class="btn btn-danger btn-sm delete_me"><i class="fa fa-trash-o"></i> Deleted</span>';}}
					
					] ,
			  buttons: [
				{
				  extend: "copy",
				  className: "btn-sm"
				},
				{
				  extend: "csv",
				  className: "btn-sm"
				},
				{
				  extend: "excel",
				  className: "btn-sm"
				},
				{
				  extend: "pdfHtml5",
				  className: "btn-sm"
				},
				{
				  extend: "print",
				  className: "btn-sm"
				},
			  ],
			  responsive: true,
			});
		}
	  /*-- End Parishes----*/ 
	  /*-- Parishes--*/
		if ($("#tblVillage").length) {
			  dTable['tblVillages'] = $('#tblVillage').DataTable({
			  dom: "lfrtipB",
			  "processing": true,
			  /*"serverSide": true,
			  "deferRender": true,
			  "order": [[ 1, 'asc' ]],*/
			initComplete: function () {
				var select_header = ['', 'Parish', 'SubCounty','County','Districts'];
				this.api().columns([1,2,3,4]).every( function () {
					var column = this;
					var col_index = column.index();
					var select = $('<select class="form-control input-sm"><option value="">All '+select_header[col_index]+'</option></select>')
						.appendTo( $("#village"+col_index).empty() )
						.on( 'change', function () {
							var val = $.fn.dataTable.util.escapeRegex(
								$(this).val()
							);
							console.log(val);
							column
								.search( val ? '^'+val+'$' : '', true, false )
								.draw();
						} );
					column.data().unique().sort().each( function ( d, j ) {
						select.append( '<option value="'+d+'">'+d+'</option>' )
					} );
				} );
			},
			"ajax": {
				  "url":"settings_data.php",
				  "dataType": "JSON",
				  "type": "POST",
				  "data":  function(d){
						d.tbl = 'villages';
						//d.start_date = getStartDate();
						//d.end_date = getEndDate();
					}
			  },/*"columnDefs": [ { 
				  "targets": [1], 
				  "orderable": false,
				  "searchable": false
			  } , {
				  "targets": [0],
				  "orderable": false
			  } ],*/
			  "autoWidth": false,
			  columns:[ { data: 'village_name' },
					{ data: 'parish_name' },
					{data: 'subcounty_name' },
					{ data: 'county_name' },
					{ data: 'district_name'},
					{ data: 'id', render: function ( data, type, full, meta ) { return '<a  id="'+data+'-tblVillage-tblVillages"  href="#village" class="btn btn-white btn-sm crop_rate"><i class="fa fa-pencil"></i> Edit </a><span id="'+data+'-tblVillage-tblVillages" class="btn btn-danger btn-sm delete_me"><i class="fa fa-trash-o"></i> Deleted</span>';}}
					
					] ,
			  buttons: [
				{
				  extend: "copy",
				  className: "btn-sm"
				},
				{
				  extend: "csv",
				  className: "btn-sm"
				},
				{
				  extend: "excel",
				  className: "btn-sm"
				},
				{
				  extend: "pdfHtml5",
				  className: "btn-sm"
				},
				{
				  extend: "print",
				  className: "btn-sm"
				},
			  ],
			  responsive: true,
			});
		}
	  /*-- End Village----*/
	  /* -- Land Acquisition category Unit Data Table --- */
			if ($("#land_acquistion_category_unit").length) {
			  dTable['landAcquisitionUnit'] = $('#land_acquistion_category_unit').DataTable({
			  dom: "lfrtipB",
			  "processing": true,
			  /*"serverSide": true,
			  "deferRender": true,
			  "order": [[ 1, 'asc' ]],*/
			  "ajax": {
				  "url":"settings_data.php",
				  "dataType": "JSON",
				  "type": "POST",
				  "data":  function(d){
					 
						d.tbl = 'land_acquistion_category_unit';
						//d.start_date = getStartDate();
						//d.end_date = getEndDate();
					}
			  },"columnDefs": [ {
				  "targets": [2],
				  "orderable": false,
				  "searchable": false
			  }/* , {
				  "targets": [0],
				  "orderable": false
			  } */],
			  "autoWidth": false,
			  columns:[ { data: 'title' },/* 
					{ data: 'category'}, */
					{ data: 'description'},
					{ data: 'id', render: function ( data, type, full, meta ) {return '<span><a data-toggle="modal" href="#categoryModalUnit"  id="'+data+'-land_acquistion_category_unit-landAcquisitionUnit" data-toggle="modal" href="#categoryModalUnit" class=" btn-white btn-sm edit_me"><i class="fa fa-pencil"></i> </a></span><span id="'+data+'-land_acquistion_category_unit-landAcquisitionUnit" class= "delete_me"><i class="fa fa-trash-o"></i></span>';}}
					
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
	  /*-- End Land Acquisition category--*/
		/*ACCESS LEVEL */
	  	if ($("#access_levels").length) {
			  dTable['tblAccessLevel'] = $('#access_levels').DataTable({
			  dom: "lfrtipB",
			  "processing": true,
			  "ajax": {
				  "url":"settings_data.php",
				  "dataType": "JSON",
				  "type": "POST",
				  "data":  function(d){
						d.tbl = 'access_level';
						//d.start_date = getStartDate();
						//d.end_date = getEndDate();
					}
			  },"columnDefs": [ {
				  "targets": [2],
				  "orderable": false,
				  "searchable": false
			  }/* , {
				  "targets": [0],
				  "orderable": false
			  } */],
			  "autoWidth": false,
			  columns:[ { data: 'name'},
					{ data: 'description'},
					{ data: 'id', render: function ( data, type, full, meta ) {return '<a data-toggle="modal" href="#edit_account_type" class="btn btn-white btn-sm"><i class="fa fa-pencil"></i> Edit </a>';}}//<span id="'+data+'-access_level-tblbranch" class="btn btn-danger btn-sm delete_me"><i class="fa fa-trash-o"></i> Deleted</span>
					
					] ,
			  buttons: [
				{
				  extend: "copy",
				  className: "btn-sm"
				},
				{
				  extend: "csv",
				  className: "btn-sm"
				},
				{
				  extend: "excel",
				  className: "btn-sm"
				},
				{
				  extend: "pdfHtml5",
				  className: "btn-sm"
				},
				{
				  extend: "print",
				  className: "btn-sm"
				},
			  ],
			  responsive: true,
			});
			//$("#datatable-buttons").DataTable();
		}
		/*End Access Level- --*/
		/*Position */
	  	if ($("#positions").length) {
			  dTable['tblPosition'] = $('#positions').DataTable({
			  dom: "lfrtipB",
			  "processing": true,
			  "ajax": {
				  "url":"settings_data.php",
				  "dataType": "JSON",
				  "type": "POST",
				  "data":  function(d){
						d.tbl = 'positions';
						//d.start_date = getStartDate();
						//d.end_date = getEndDate();
					}
			  },"columnDefs": [ {
				  "targets": [2],
				  "orderable": false,
				  "searchable": false
			  }/* , {
				  "targets": [0],
				  "orderable": false
			  } */],
			  "autoWidth": false,
			  columns:[ { data: 'title'},
					{ data: 'description'},
					{ data: 'access_level'},
					{ data: 'id', render: function ( data, type, full, meta ) {return '<a data-toggle="modal" id="'+data+'-position-tblPosition" href="#position" class="btn btn-white btn-sm edit_me"><i class="fa fa-pencil"></i> Edit </a><span id="'+data+'-position-tblPosition" class="btn btn-danger btn-sm delete_me"><i class="fa fa-trash-o"></i> Deleted</span>';}}
					
					] ,
			  buttons: [
				{
				  extend: "copy",
				  className: "btn-sm"
				},
				{
				  extend: "csv",
				  className: "btn-sm"
				},
				{
				  extend: "excel",
				  className: "btn-sm"
				},
				{
				  extend: "pdfHtml5",
				  className: "btn-sm"
				},
				{
				  extend: "print",
				  className: "btn-sm"
				},
			  ],
			  responsive: true,
			});
			//$("#datatable-buttons").DataTable();
		}
		/*END Position- --*/
		/*-- Expense Type--*/
		if ($("#expense_types").length) {
			  dTable['tblExpenseType'] = $('#expense_types').DataTable({
			  dom: "lfrtipB",
			  "processing": true,
			  /*"serverSide": true,
			  "deferRender": true,
			  "order": [[ 1, 'asc' ]],*/
			  "ajax": {
				  "url":"settings_data.php",
				  "dataType": "JSON",
				  "type": "POST",
				  "data":  function(d){
						d.tbl = 'expense_type';
						//d.start_date = getStartDate();
						//d.end_date = getEndDate();
					}
			  },"columnDefs": [ {
				  "targets": [2],
				  "orderable": false,
				  "searchable": false
			  }/* , {
				  "targets": [0],
				  "orderable": false
			  } */],
			  "autoWidth": false,
			  columns:[ { data: 'name' },
					{ data: 'description'},//, render: function ( data, type, full, meta ) {return full.firstname + ' ' + full.othername + ' ' + full.lastname;}
					//{ data: 'date_added', render: function ( data, type, full, meta ) {return moment(data).format('LL');}},
					
					{ data: 'id', render: function ( data, type, full, meta ) { return '<a data-toggle="modal" href="#expense_type"  id="'+data+'-expense_types-tblExpenseType" data-toggle="modal" href="#expense_type" class="btn btn-white btn-sm edit_me"><i class="fa fa-pencil"></i> Edit </a><span id="'+data+'-expense_types-tblExpenseType" class="btn btn-danger btn-sm delete_me"><i class="fa fa-trash-o"></i> Deleted</span>';}}
					
					] ,
			  buttons: [
				{
				  extend: "copy",
				  className: "btn-sm"
				},
				{
				  extend: "csv",
				  className: "btn-sm"
				},
				{
				  extend: "excel",
				  className: "btn-sm"
				},
				{
				  extend: "pdfHtml5",
				  className: "btn-sm"
				},
				{
				  extend: "print",
				  className: "btn-sm"
				},
			  ],
			  responsive: true,
			});
		}
	  /*-- End Expense Type--*/
	  /*-- Tree or crop Type--*/
		if ($("#treeCropsTypes").length) {
			  dTable['tblTreeCrops'] = $('#treeCropsTypes').DataTable({
			  dom: "lfrtipB",
			  "processing": true,
			  /*"serverSide": true,
			  "deferRender": true,
			  "order": [[ 1, 'asc' ]],*/
			  "ajax": {
				  "url":"settings_data.php",
				  "dataType": "JSON",
				  "type": "POST",
				  "data":  function(d){
						d.tbl = 'treecroptypes';
						//d.start_date = getStartDate();
						//d.end_date = getEndDate();
					}
			  },"columnDefs": [ {
				  "targets": [2],
				  "orderable": false,
				  "searchable": false
			  }/* , {
				  "targets": [0],
				  "orderable": false
			  } */],
			  "autoWidth": false,
			  columns:[ { data: 'title', render: function ( data, type, full, meta ) { return '<a  id="'+full.id +'-treeCropsTypes-tblTreeCrops"  href="crop_types_description.php?id='+full.id +'" class="ls-modal"><i class="fa fa-folder"></i> '+ data +'</a>'; } },
					{ data: 'description'},//
					//{ data: 'date_added', render: function ( data, type, full, meta ) {return moment(data).format('LL');}},
					
					{ data: 'id', render: function ( data, type, full, meta ) { return '<a data-toggle="modal" href="#treecrops"  id="'+data+'-treeCropsTypes-tblTreeCrops"  class="btn btn-white btn-sm edit_me"><i class="fa fa-pencil"></i> Edit </a><span id="'+data+'-treeCropsTypes-tblTreeCrops" class="btn btn-danger btn-sm delete_me"><i class="fa fa-trash-o"></i> Deleted</span>';}}
					
					] ,
			  buttons: [
				{
				  extend: "copy",
				  className: "btn-sm"
				},
				{
				  extend: "csv",
				  className: "btn-sm"
				},
				{
				  extend: "excel",
				  className: "btn-sm"
				},
				{
				  extend: "pdfHtml5",
				  className: "btn-sm"
				},
				{
				  extend: "print",
				  className: "btn-sm"
				},
			  ],
			  responsive: true,
			});
		}
	  /*-- End Crop Type--*/
	  /*-- Tree or Property Type--*/
		if ($("#tblPropertyType").length) {
			  dTable['tblPropertyTypes'] = $('#tblPropertyType').DataTable({
			  dom: "lfrtipB",
			  "processing": true,
			  /*"serverSide": true,
			  "deferRender": true,
			  "order": [[ 1, 'asc' ]],*/
			  "ajax": {
				  "url":"settings_data.php",
				  "dataType": "JSON",
				  "type": "POST",
				  "data":  function(d){
						d.tbl = 'propertytypes';
						//d.start_date = getStartDate();
						//d.end_date = getEndDate();
					}
			  },"columnDefs": [ {
				  "targets": [2],
				  "orderable": false,
				  "searchable": false
			  }/* , {
				  "targets": [0],
				  "orderable": false
			  } */],
			  "autoWidth": false,
			  columns:[ { data: 'title', render: function ( data, type, full, meta ) { return '<a  id="'+full.id +'-treeCropsTypes-tblTreeCrops"  href="propertytypedescription.php?id='+full.id +'" class="property_type"><i class="fa fa-folder"></i> '+ data +'</a>'; } },
					{ data: 'description'},//
					//{ data: 'date_added', render: function ( data, type, full, meta ) {return moment(data).format('LL');}},
					
					{ data: 'id', render: function ( data, type, full, meta ) { return '<a data-toggle="modal" href="#propertytype"  id="'+data+'-tblPropertyType-tblPropertyTypes"  class="btn btn-white btn-sm edit_me"><i class="fa fa-pencil"></i> Edit </a><span id="'+data+'-tblPropertyType-tblPropertyTypes" class="btn btn-danger btn-sm delete_me"><i class="fa fa-trash-o"></i> Deleted</span>';}}
					
					] ,
			  buttons: [
				{
				  extend: "copy",
				  className: "btn-sm"
				},
				{
				  extend: "csv",
				  className: "btn-sm"
				},
				{
				  extend: "excel",
				  className: "btn-sm"
				},
				{
				  extend: "pdfHtml5",
				  className: "btn-sm"
				},
				{
				  extend: "print",
				  className: "btn-sm"
				},
			  ],
			  responsive: true,
			});
		}
	  /*-- End Crop Type--*/
	  /*-- Crop description--*/
		if ($("#cropDescription").length) {
			  dTable['tblCropDescription'] = $('#cropDescription').DataTable({
			  dom: "lfrtipB",
			  "processing": true,
			  /*"serverSide": true,
			  "deferRender": true,
			  "order": [[ 1, 'asc' ]],*/
			  "ajax": {
				  "url":"settings_data.php",
				  "dataType": "JSON",
				  "type": "POST",
				  "data":  function(d){
						d.tbl = 'cropdescription';
						//d.start_date = getStartDate();
						//d.end_date = getEndDate();
					}
			  },"columnDefs": [ {
				  "targets": [2],
				  "orderable": false,
				  "searchable": false
			  }/* , {
				  "targets": [0],
				  "orderable": false
			  } */],
			  "autoWidth": false,
			  columns:[ { data: 'title' },
					{ data: 'description'},//, render: function ( data, type, full, meta ) {return full.firstname + ' ' + full.othername + ' ' + full.lastname;}
					//{ data: 'date_added', render: function ( data, type, full, meta ) {return moment(data).format('LL');}},
					
					{ data: 'id', render: function ( data, type, full, meta ) { return '<a data-toggle="modal" href="#cropdescription"  id="'+data+'-cropdescription-tblCropDescription" data-toggle="modal" href="#cropdescription" class="btn btn-white btn-sm edit_me"><i class="fa fa-pencil"></i> Edit </a><span id="'+data+'-cropdescription-tblCropDescription" class="btn btn-danger btn-sm delete_me"><i class="fa fa-trash-o"></i> Deleted</span>';}}
					
					] ,
			  buttons: [
				{
				  extend: "copy",
				  className: "btn-sm"
				},
				{
				  extend: "csv",
				  className: "btn-sm"
				},
				{
				  extend: "excel",
				  className: "btn-sm"
				},
				{
				  extend: "pdfHtml5",
				  className: "btn-sm"
				},
				{
				  extend: "print",
				  className: "btn-sm"
				},
			  ],
			  responsive: true,
			});
		}
	  /*-- End crop description--*/
	  /*-- District Crop Rate--*/
		if ($("#tblDistrictCropRates").length) {
			  dTable['tblDistrictCropRate'] = $('#tblDistrictCropRates').DataTable({
			  dom: "lfrtipB",
			  "processing": true,
			  /*"serverSide": true,
			  "deferRender": true,
			  "order": [[ 1, 'asc' ]],*/
			  
			initComplete: function () {
				var select_header = ['Districts','Crop/Tree Type','Description'];
				this.api().columns([0,1,2]).every( function () {
					var column = this;
					var col_index = column.index();
					var select = $('<select class="form-control input-sm"><option value="">All '+select_header[col_index]+'</option></select>')
						.appendTo( $("#selector"+col_index).empty() )
						.on( 'change', function () {
							var val = $.fn.dataTable.util.escapeRegex(
								$(this).val()
							);
							column
								.search( val ? '^'+val+'$' : '', true, false )
								.draw();
						} );
					column.data().unique().sort().each( function ( d, j ) {
						select.append( '<option value="'+d+'">'+d+'</option>' )
					} );
				} );
			},
			"ajax": {
				  "url":"settings_data.php",
				  "dataType": "JSON",
				  "type": "POST",
				  "data":  function(d){
						d.tbl = 'districtcroprate';
						//d.start_date = getStartDate();
						//d.end_date = getEndDate();
					}
			  },"columnDefs": [ {
				  "targets": [2],
				  "orderable": false,
				  "searchable": false
			  }/* , {
				  "targets": [0],
				  "orderable": false
			  } */],
			  "autoWidth": false,
			  columns:[ { data: 'district_name' },
					{ data: 'croptype'},
					{ data: 'cropdescription'},//, render: function ( data, type, full, meta ) {return full.firstname + ' ' + full.othername + ' ' + full.lastname;}
					{ data: 'rate'},
					//{ data: 'date_added', render: function ( data, type, full, meta ) {return moment(data).format('LL');}},
					
					{ data: 'id', render: function ( data, type, full, meta ) { return '<a  id="'+data+'-cropdescription-tblCropDescription"  href="edit_croptree_rate.php?id='+data+'" class="btn btn-white btn-sm crop_rate"><i class="fa fa-pencil"></i> Edit </a><span id="'+data+'-cropdescription-tblCropDescription" class="btn btn-danger btn-sm delete_me"><i class="fa fa-trash-o"></i> Deleted</span>';}}
					
					] ,
			  buttons: [
				{
				  extend: "copy",
				  className: "btn-sm"
				},
				{
				  extend: "csv",
				  className: "btn-sm"
				},
				{
				  extend: "excel",
				  className: "btn-sm"
				},
				{
				  extend: "pdfHtml5",
				  className: "btn-sm"
				},
				{
				  extend: "print",
				  className: "btn-sm"
				},
			  ],
			  responsive: true,
			});
		}
	  /*-- End crop description--*/
	  /*-- District Property Rate--*/
		if ($("#tblPropertyRates").length) {
			  dTable['tblPropertyRate'] = $('#tblPropertyRates').DataTable({
			  dom: "lfrtipB",
			  "processing": true,
			  /*"serverSide": true,
			  "deferRender": true,
			  "order": [[ 1, 'asc' ]],*/
			  
			initComplete: function () {
				var select_header = ['Districts','Property Type','Description'];
				this.api().columns([0,1,2]).every( function () {
					var column = this;
					var col_index = column.index();
					var select = $('<select class="form-control input-sm"><option value="">All '+select_header[col_index]+'</option></select>')
						.appendTo( $("#selector"+(col_index+3)).empty() )
						.on( 'change', function () {
							var val = $.fn.dataTable.util.escapeRegex(
								$(this).val()
							);
							column
								.search( val ? '^'+val+'$' : '', true, false )
								.draw();
						} );
					column.data().unique().sort().each( function ( d, j ) {
						
						select.append( '<option value="'+d+'">'+d+'</option>' )
					} );
				} );
			},
			"ajax": {
				  "url":"settings_data.php",
				  "dataType": "JSON",
				  "type": "POST",
				  "data":  function(d){
						d.tbl = 'districtpropertyrate';
						//d.start_date = getStartDate();
						//d.end_date = getEndDate();
					}
			  },"columnDefs": [ {
				  "targets": [2],
				  "orderable": false,
				  "searchable": false
			  }/* , {
				  "targets": [0],
				  "orderable": false
			  } */],
			  "autoWidth": false,
			  columns:[ { data: 'district_name' },
					{ data: 'propertytype'},
					{ data: 'propertydescription'},//, render: function ( data, type, full, meta ) {return full.firstname + ' ' + full.othername + ' ' + full.lastname;}
					{ data: 'rate'},
					//{ data: 'date_added', render: function ( data, type, full, meta ) {return moment(data).format('LL');}},
					
					{ data: 'id', render: function ( data, type, full, meta ) { return '<a  href="edit_propety_rate.php?id='+data+'"     class="btn btn-white btn-sm edit_propety_rate"><i class="fa fa-pencil"></i> Edit </a><span id="'+data+'-cropdescription-tblCropDescription" class="btn btn-danger btn-sm delete_me"><i class="fa fa-trash-o"></i> Deleted</span>';}}
					
					] ,
			  buttons: [
				{
				  extend: "copy",
				  className: "btn-sm"
				},
				{
				  extend: "csv",
				  className: "btn-sm"
				},
				{
				  extend: "excel",
				  className: "btn-sm"
				},
				{
				  extend: "pdfHtml5",
				  className: "btn-sm"
				},
				{
				  extend: "print",
				  className: "btn-sm"
				},
			  ],
			  responsive: true,
			});
		}
	  /*-- End crop description--*/
	  
		if ($("#propertyDescription").length) {
			  dTable['tblPropertyDescription'] = $('#propertyDescription').DataTable({
			  dom: "lfrtipB",
			  "processing": true,
			  /*"serverSide": true,
			  "deferRender": true,
			  "order": [[ 1, 'asc' ]],*/
			  "ajax": {
				  "url":"settings_data.php",
				  "dataType": "JSON",
				  "type": "POST",
				  "data":  function(d){
						d.tbl = 'propertydescription';
						//d.start_date = getStartDate();
						//d.end_date = getEndDate();
					}
			  },"columnDefs": [ {
				  "targets": [2],
				  "orderable": false,
				  "searchable": false
			  }/* , {
				  "targets": [0],
				  "orderable": false
			  } */],
			  "autoWidth": false,
			  columns:[ { data: 'title' },
					{ data: 'description'},//, render: function ( data, type, full, meta ) {return full.firstname + ' ' + full.othername + ' ' + full.lastname;}
					//{ data: 'date_added', render: function ( data, type, full, meta ) {return moment(data).format('LL');}},
					
					{ data: 'id', render: function ( data, type, full, meta ) { return '<a data-toggle="modal"  id="'+data+'-propertydescription-tblPropertyDescription" href="#propertydescription" class="btn btn-white btn-sm edit_me"><i class="fa fa-pencil"></i> Edit </a><span id="'+data+'-propertydescription-tblPropertyDescription" class="btn btn-danger btn-sm delete_me"><i class="fa fa-trash-o"></i> Deleted</span>';}}
					
					] ,
			  buttons: [
				{
				  extend: "copy",
				  className: "btn-sm"
				},
				{
				  extend: "csv",
				  className: "btn-sm"
				},
				{
				  extend: "excel",
				  className: "btn-sm"
				},
				{
				  extend: "pdfHtml5",
				  className: "btn-sm"
				},
				{
				  extend: "print",
				  className: "btn-sm"
				},
			  ],
			  responsive: true,
			});
		}
	  /*-- END property description--*/
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
	//This helps load a page into a bootstrap modal
	$('.table tbody').on('click', 'tr .ls-modal', function (e) {
		e.preventDefault();
		$('#croptypes_desc').modal('show').find('.modal-body').load($(this).attr('href'));
	});
	//This helps load a page into a bootstrap modal
	$('.table tbody').on('click', 'tr .edit_propety_rate', function (e) {
		e.preventDefault();
		$('#propertyrate_edt').modal('show').find('.modal-body').load($(this).attr('href'));
	});
	$('.table tbody').on('click', 'tr .property_type', function (e) {
		e.preventDefault();
		$('#property_d').modal('show').find('.modal-body').load($(this).attr('href'));
	});
	$('.table tbody').on('click', 'tr .crop_rate', function (e) {
		e.preventDefault();
		$('#district_rate_edit').modal('show').find('.modal-body').load($(this).attr('href'));
	});
/* Editing Several tables */
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
	/*  */
	
});
	
	//ko.applyBindings({ depositProductModel: depositProductModel, loanProductModel: loanProductModel });
</script>