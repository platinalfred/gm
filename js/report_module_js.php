<script>
//the view model for the page
var dTable = {};
$(document).ready(function(){
    <?php if(isset($projectDetails)):?>
	var handleDataTableButtons = function() {
			/* -- Project Affected Person Report Data Table --- */
			if ($("#tblPapsReport").length) {
				  dTable['tblPapsReport'] = $('#tblPapsReport').DataTable({
				 dom: '<".col-md-7"B><".col-md-2"l><".col-md-3"f>rt<".col-md-9"i><".col-md-3"p>',
                                  "searching": true,
                                  "ordering": false,
                                  "paging": true,
                                  "lengthChange": true,
				  "autoWidth": false,
				  "lengthMenu": [[10, 25, 50, -1], [10, 50,  100, "All"]],
				  fixedHeader: true,
                                  "order": [ 0, 'asc'],
				  buttons: [
					{
					  extend: "copy",
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
				  responsive: false
			  });
			}
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
	<?php endif;?>
});

</script>
