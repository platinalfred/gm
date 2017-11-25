<script>
var dTable = {};
$(document).ready(function(){
	//deleteDataTableRowData();

	var handleDataTableButtons = function() {
			/* -- Project Affected Person Data Table --- */
			
			if ($("#tblProject").length) {
				  dTable['tblPap'] = $('#tblPap').DataTable({
				  dom: "lfrtipB",
				  "processing": true,
				  "ajax": {
					  "url":"getData.php",
					  "dataType": "JSON",
					  "type": "POST",
					  "data":  function(d){
							d.tbl = 'project_report';
							//d.project_id = <?php //echo $_GET['id']; ?>;
						}
				  },"columnDefs": [ {
					  "targets": [last_col],
					  "orderable": false,
					  "searchable": false
				  }],
				  "autoWidth": false,
				  "footerCallback": function (tfoot, data, start, end, display ) {
					var api = this.api();
					$.each([5,6,7], function(key, val){
						var total = api.column(val).data().sum();
						$(api.column(val).footer()).html( curr_format(total) );
					});
				  },
				  columns:[ { data: 'pap_ref', render: function( data, type, full, meta ) {return '<a href="project_details.php?id='+full.project_id+'&amp;pap_id='+full.id+'" title="View PAP details">'+ data + '</a>';} },
					  { data: 'firstname', render: function( data, type, full, meta ) {return full.lastname+' ' + data + ' ' + (full.othername?full.othername:'');} },
						{ data: 'district_name'},
						/* { data: 'county_id'},
						{ data: 'subcounty_id'},
						{ data: 'parish_id'}, */
						{ data: 'village_name'},
						{ data: 'phone_contact'},
						{ data: 'way_leave', render: function( data, type, full, meta ) {return data?curr_format(data):0;}},
						{ data: 'rightofway', render: function( data, type, full, meta ) {return data?curr_format(data):0;}},
						{ data: 'total_take', render: function( data, type, full, meta ) {return data?curr_format(data):0;}},
						{ data: 'chainage'},
						{ data: 'improvement_sum', render: function( data, type, full, meta ) {return data?curr_format(parseInt(data)):0;}},
						{ data: 'crop_tree_sum', render: function( data, type, full, meta ) {return data?curr_format(parseInt(data)):0;}}
						
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

</script>