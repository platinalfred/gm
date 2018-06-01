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
	
	/* self.filteredCountiesList = ko.computed(function() {
		if(self.district()){
			return ko.utils.arrayFilter(self.countiesList(), function(county) {
					
				return (parseInt(self.district().id)==parseInt(scounty.district));
				
			});
		}
	}); */	
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
					/* case "counties":
						self.districtsList(response.districts);
					break; */
					case "subcounties":
						self.districtsList(response.districts);
						//self.countiesList(response.counties);
					break;
					case "parishes":
						self.districtsList(response.districts);
						//self.countiesList(response.counties);
						self.subcountiesList(response.subcounties);	
					break;
					case "villages":
						self.districtsList(response.districts);
						//self.countiesList(response.counties);
						self.subcountiesList(response.subcounties);	
						self.parishesList(response.parishes);
					break;
					default:
					break;
				}
			}
		})
	};
};
 var viewModel = new ViewModel();
 ko.applyBindings(viewModel, $("#tab-6")[0]); //
 
 
 var CropViewModel = function(){
	var self = this;
	self.tree_crop_type = ko.observable();
	self.all_attached = ko.observableArray();
	self.all_crop_descriptions = ko.observableArray();
	self.removeCropDescription = function(data) {
		$.ajax({ 
			url:'delete.php', 
			type:'get',
			data:{id:data.id,tbl:"delete_crop_description"},
			success:function(result){ 
				if(result.trim() === "success"){
					self.getServerData(data.crop_tree_id);
					//self.all_attached_improvements.remove(data); //this is your items list array 
				}else{
					alert(result); 
				}
			}
		}); 
	};
	self.getServerData = function(crop_tree_id){
		if(self.all_attached().length>0){self.all_attached.removeAll();}
		if(self.all_crop_descriptions().length>0){self.all_crop_descriptions.removeAll();}
		$.ajax({
			url:"getData.php",
			type: 'POST',
			data:{crop_id:crop_tree_id, tbl:"crop_types"},
			dataType:'json',
			success: function(response){
				self.all_attached(response.all_attached);
				self.all_crop_descriptions(response.all_crop_descriptions);
				
			}
		});
	};
};
var cropViewModel = new CropViewModel();
ko.applyBindings(cropViewModel, $("#tree_crop_description")[0]);

var ImprovementViewModel = function(){
	var self = this;
	self.improvement_type = ko.observable();
	self.all_attached_improvements = ko.observableArray();
	self.all_improvements_description = ko.observableArray();
	//first delete from the server, if successful, then delete from the local copy of the array
	self.removePropertyDescription = function(data) {
		$.ajax({ 
			url:'delete.php', 
			type:'get',
			data:{id:data.id,tbl:"delete_property_description"},
			success:function(result){ 
				if(result.trim() === "success"){
					self.getServerData(data.property_id);
					//self.all_attached_improvements.remove(data); //this is your items list array 
				}else{
					alert(result); 
				}
			}
		}); 
	};
	self.getServerData = function(property_type_id){
		if(self.all_attached_improvements().length>0){			
			self.all_attached_improvements.removeAll();
		}
		if(self.all_improvements_description().length>0){		
			self.all_improvements_description.removeAll();
		}
		$.ajax({
			url:"getData.php",
			type: 'POST',
			data:{property_id:property_type_id, tbl:"improvement_desc"},
			dataType:'json',
			success: function(response){
				self.all_attached_improvements(response.all_attached_improvements);
				self.all_improvements_description(response.all_improvements_description);
				
			}
		});
	};
};
var improvementViewModel = new ImprovementViewModel();
ko.applyBindings(improvementViewModel, $("#improvement_type_desc")[0]); 

$(document).ready(function(){
	
/* ====  COMMON FUNCTIONS ==== */
        $(".form_validate").validate({submitHandler: saveData});
	
	/*To have a form editable first add a class .edit_me on the row, also add an Id-tbl_name-formId and also add an empty id field in the form */


	
	//Functions being used in more than one instances / places
		/* Delete whenever a Delete Button has been clicked */
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
						{ data: 'id' },
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
				var select_header = ['','Districts'];
				this.api().columns([1]).every( function () {
					var column = this;
					var col_index = column.index();
					var select = $('<select class="form-control input-sm"><option value="">All '+select_header[col_index]+'</option></select>')
						.appendTo( $("#subcounty"+col_index).empty() )
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
					{ data: 'district_name'},{ data: 'id'},
					{ data: 'id', render: function ( data, type, full, meta ) { return '<a data-toggle="modal" href="#subcounty"  id="'+data+'-tblSubCounty-tblSubCountys" class=" btn-white btn-sm edit_me"><i class="fa fa-pencil"></i> </a><span id="'+data+'-tblSubCounty-tblSubCountys" class= "btn-danger btn-sm delete_me"><i class="fa fa-trash-o"></i></span>';}}
					
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
				var select_header = ['', 'SubCounty','Districts'];
				this.api().columns([1,2]).every( function () {
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
					{ data: 'district_name'},{ data: 'id'},
					{ data: 'id', render: function ( data, type, full, meta ) { 					
						return '<a data-toggle="modal" href="#parish"  id="'+data+'-tblParish-tblParishs" class=" btn-white btn-sm edit_me"><i class="fa fa-pencil"></i> </a><span id="'+data+'-tblParish-tblParishs" class= "btn-danger btn-sm delete_me"><i class="fa fa-trash-o"></i></span>'; 
					}}
					
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
				var select_header = ['', 'Parish', 'SubCounty','Districts'];
				this.api().columns([1,2,3]).every( function () {
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
					{ data: 'district_name'},
					{ data: 'id'},
					{ data: 'id', render: function ( data, type, full, meta ) { 
						
					return '<a data-toggle="modal" href="#villages"  id="'+data+'-tblVillage-tblVillages" class=" btn-white btn-sm edit_me"><i class="fa fa-pencil"></i> </a><span id="'+data+'-tblVillage-tblVillages" class= "btn-danger btn-sm delete_me"><i class="fa fa-trash-o"></i></span>'; }}
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
			  dTable['landAcquisitionCategoryUnit'] = $('#land_acquistion_category_unit').DataTable({
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
					{ data: 'id', render: function ( data, type, full, meta ) {return '<span><a data-toggle="modal" href="#categoryUnitModal" id="'+data+'-land_acquistion_category_unit-landAcquisitionCategoryUnit" class=" btn-white btn-sm edit_me"><i class="fa fa-pencil"></i> </a></span><span id="'+data+'-land_acquistion_category_unit-landAcquisitionUnit" class= "delete_me"><i class="fa fa-trash-o"></i></span>';}}
					
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
					{ data: 'id', render: function ( data, type, full, meta ) {return '<a data-toggle="modal" href="#access_level" id="'+data+'-access_levels-tblAccessLevel" class="btn btn-white btn-sm edit_me"><i class="fa fa-pencil"></i> Edit </a>';}}//<span id="'+data+'-access_level-tblbranch" class="btn btn-danger btn-sm delete_me"><i class="fa fa-trash-o"></i> Deleted</span>
					
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
					{ data: 'name'},
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
				  "targets": [4],
				  "orderable": false,
				  "searchable": false
			  }/* , {
				  "targets": [0],
				  "orderable": false
			  } */],
			  "autoWidth": false,
			  columns:[ { data: 'id'},
                                      { data: 'title', render: function ( data, type, full, meta ) { return '<a  href="#croptypes_desc" data-toggle="modal" id="'+full.id +'-treeCropsTypes-tblTreeCrops"  class="ls-modal crops edit_me"><i class="fa fa-folder"></i> '+ data +'</a>'; } },
			{ data: 'measure_unit_id', render: function ( data, type, full, meta ) { return data?(full.measure_unit + ' ('+full.short_form+')'):'count';}},
			{ data: 'description'},
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
				  "targets": [4],
				  "orderable": false,
				  "searchable": false
			  }/* , {
				  "targets": [0],
				  "orderable": false
			  } */],
			  "autoWidth": false,
			  columns:[  { data: 'id'},
                                      {data: 'title', render: function ( data, type, full, meta ) {
                                      return '<a  href="#property_d" data-toggle="modal"  id="'+full.id +'-tblPropertyType-tblPropertyTypes"  class="ls-modal improvement_type edit_me"><i class="fa fa-folder"></i> '+ data +'</a>'; }},
                                  { data: 'measure_unit_id', render: function ( data, type, full, meta ) { return data?(full.measure_unit + ' ('+full.short_form+')'):'count';}},
                                  { data: 'description'},
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
					{ data: 'rate', function ( data, type, full, meta ) { return curr_format(data); }},
					//{ data: 'date_added', render: function ( data, type, full, meta ) {return moment(data).format('LL');}},
					{ data: 'id'},
					{ data: 'id', render: function ( data, type, full, meta ) { return '<a data-toggle="modal" href="#districtrate"  id="'+data+'-district_rate-tblDistrictCropRate" data-toggle="modal"  class="btn btn-white btn-sm edit_me"><i class="fa fa-pencil"></i> Edit </a><span id="'+data+'-cropdescription_rate-tblDistrictCropRate" class="btn btn-danger btn-sm delete_me"><i class="fa fa-trash-o"></i> Deleted</span>'; }}
					
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
					{ data: 'rate', render: function ( data, type, full, meta ) {return curr_format(data); }},
					//{ data: 'date_added', render: function ( data, type, full, meta ) {return moment(data).format('LL');}},
					
					{ data: 'id', render: function ( data, type, full, meta ) {
					return '<a data-toggle="modal" href="#propertyrate"  id="'+data+'-tblPropertyRates-tblPropertyRate" data-toggle="modal"  class="btn btn-white btn-sm edit_me"><i class="fa fa-pencil"></i> Edit </a><span id="'+data+'-tblPropertyRates-tblPropertyRate" class="btn btn-danger btn-sm delete_me"><i class="fa fa-trash-o"></i> Deleted</span>'; }}
					
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
	  
	  /*-- Start Comment--*/
	  
	  if ($("#tblComments").length) {
			  dTable['tblComment'] = $('#tblComments').DataTable({
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
						d.tbl = 'comments';
						//d.start_date = getStartDate();
						//d.end_date = getEndDate();
					}
			  },"columnDefs": [ {
				  "targets": [],
				  "orderable": false,
				  "searchable": false
			  }/* , {
				  "targets": [0],
				  "orderable": false
			  } */],
			  "autoWidth": false,
			  columns:[ { data: 'details' },
					
					{ data: 'id', render: function ( data, type, full, meta ) { return '<a data-toggle="modal"  id="'+data+'-tblComments-tblComment" href="#comment" class="btn btn-white btn-sm edit_me"><i class="fa fa-pencil"></i> Edit </a><span id="'+data+'-tblComments-tblComments" class="btn btn-danger btn-sm delete_me"><i class="fa fa-trash-o"></i> Deleted</span>';}}
					
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
	//This load the property descriptions into a bootstrap modal
	$('.table tbody').on('click', 'tr .edit_propety_rate', function (e) {
		var row = $(this).closest("tr");
		e.preventDefault();
		$('#propertyrate_edt').modal('show').find('.modal-body').load($(this).attr('href'));
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
                var data = dt.row(row).data();
                if(typeof(data)=='undefined'){
                    data = dTable[frm].row($(row).prev()).data();
                }
                if($(this).hasClass('improvement_type')){
                    improvementViewModel.improvement_type(data);
                    improvementViewModel.getServerData(id);
                    //$('#property_d').modal('show');$('#property_d').modal('show').find('.modal-body').load($(this).attr('href'))
                }
                if($(this).hasClass('crops')){
                    cropViewModel.tree_crop_type(data);
                    cropViewModel.getServerData(id);
                    //$('#croptypes_desc').modal('show');find('.modal-body').load($(this).attr('href'))
                }
		edit_data(data, frm);
		
	});
	/*  */
	
});
</script>