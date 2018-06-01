<script>
var dTable = {};
$(document).ready(function(){
	//deleteDataTableRowData();
	var handleDataTableButtons = function() {
            var cols = [6,12]; //the index for columns where  the totals appear
            var last_col = 15; //the final index table column
         <?php if( ($projectDetails['project_category_unit'] == 1) ):?>
                  cols = [8,11,12,13,14,15,16,17]; last_col = 18;
         <?php endif;?>
         <?php if( ($projectDetails['project_category_unit'] == 2) ):?>
             cols = [8,9,10,11,12,13,14]; last_col = 15;
         <?php endif;?>
         <?php if( ($projectDetails['project_category_unit'] == 4) ):?>
             cols = [8,9,10,14,15,16,17,18,19,20,21]; last_col = 22;
         <?php endif;?>
         <?php if( ($projectDetails['project_category_unit'] == 5) ):?>
	cols = [8,11,12,14,15,16]; last_col = 17;
         <?php endif;?>
            /* -- Project Affected Person Data Table --- */
            if ($("#tblPapCompenstation").length) {
                dTable['tblPapCompenstation'] = $('#tblPapCompenstation').DataTable({
                    dom: '<".col-md-7"B><".col-md-2"l><".col-md-3"f>rt<".col-md-7"i><".col-md-5"p>',
                    "processing": true,
                    "ajax": {
                        "url":"getData.php",
                        "dataType": "JSON",
                        "type": "POST",
                        "data":  function(d){
                            d.tbl = 'pap_compensation_report';
                            d.project_id = <?php echo $_GET['id']; ?>;
                        }
                        },"columnDefs": [ {
                            "targets": [last_col],
                            "orderable": false,
                            "searchable": false
                        }],
                            "autoWidth": false,
                            "footerCallback": function (tfoot, data, start, end, display ) {
                                var api = this.api();
                                $.each(cols, function(key, val){
                                    var pageTotal = api.column(val, {page: 'current'}).data().sum();
                                    var total = api.column(val).data().sum();
                                    $(api.column(val).footer()).html( curr_format(pageTotal) + " (" + curr_format(total) +")" );
                                });
                            },
                                columns:[ { data: 'pap_ref', render: function( data, type, full, meta ) {return '<a href="project_details.php?id='+full.project_id+'&amp;pap_id='+full.id+'" title="View PAP details">'+ data + '</a>';} },
                            { data: 'firstname', render: function( data, type, full, meta ) {return full.lastname+' ' + data + ' ' + (full.othername?full.othername:'');} },
                            { data: 'phone_contact'},
                            { data: 'district_name', render:function( data, type, full, meta){
                                    return data + ", " + full.subcounty_name +  ", " + full.parish_name +  ", " + full.village_name;
                            }},
                            { data: 'x_coord'},
                            { data: 'y_coord'},
                            { data: 'chainage'},
                            { data: 'tenure_desc'},
                                <?php //Way Leave or both ROW and WL
                                if ($projectDetails['project_category_unit'] == 2 || $projectDetails['project_category_unit'] == 4): ?>
                            { data: 'way_leave', render: function( data, type, full, meta ) {return data?curr_format(data):"";}},
                                <?php endif; ?>
                                <?php //ROW or Both ROW and WL
                                if ($projectDetails['project_category_unit'] == 1 || $projectDetails['project_category_unit'] == 4): ?>
                            { data: 'rightofway', render: function( data, type, full, meta ) {return data?curr_format(data):"";}},
                                <?php endif; ?>
                                <?php //Dimunition rate for Both ROW and WL Project
                                if ($projectDetails['project_category_unit'] == 4): ?>
                            { data: 'rightofway', render: function( data, type, full, meta ) {return ((data?data:0)+(full.way_leave?full.way_leave:0));}},
                                <?php endif; ?>
                                <?php //Total Take/Size OR Both ROW and WL Project
                                if ($projectDetails['project_category_unit'] == 5 || $projectDetails['project_category_unit'] == 4): ?>
                            { data: 'total_take', render: function( data, type, full, meta ) {return data?curr_format(data):"";}},
                                <?php endif; ?>
                                <?php //ROW or Total Take/Size OR Both ROW and WL Project
                                if ($projectDetails['project_category_unit'] == 1 || $projectDetails['project_category_unit'] == 4 || $projectDetails['project_category_unit'] == 5): ?>
                            { data: 'rate_per_acre', render: function( data, type, full, meta ) {return data?curr_format(data):"";}},
                            { data: 'land_interest', render: function( data, type, full, meta ) {return data?data:0;}},
                                <?php endif; ?>
                                <?php //Dimunition rate for Both ROW and WL Project
                                if ($projectDetails['project_category_unit'] == 4): ?>
                            { data: 'diminution_rate', render: function( data, type, full, meta ) {return data?(data+"%"):"";}},
                                <?php endif; ?>
                                <?php //Way Leave or both ROW and WL
                                if ($projectDetails['project_category_unit'] == 2 || $projectDetails['project_category_unit'] == 4):
                                    ?>
                            { data: 'way_leave', render: function( data, type, full, meta ) {
                                    land_value = (data?data:0)*(full.rate_per_acre?full.rate_per_acre:0);
                                    land_interest = full.land_interest?(full.land_interest/100):0;
                                    diminution_rate = full.diminution_rate?(full.diminution_rate/100):0;
                                    return curr_format(land_value*land_interest*diminution_rate);
                                }
                            },
                                <?php endif; ?>
                                <?php //ROW or both ROW and WL
                                if ($projectDetails['project_category_unit'] == 1 || $projectDetails['project_category_unit'] == 4):
                                    ?>
                            { data: 'rightofway', render: function( data, type, full, meta ) {
                                    row_land_value = (data?data:0)*(full.rate_per_acre?full.rate_per_acre:0);
                                    land_interest = full.land_interest?(full.land_interest/100):0;
                                    return curr_format(row_land_value*land_interest);
                                }
                            },
                                    //Total land value, applies to ROW, (Both ROW and WL)
                            { data: 'rightofway', render: function( data, type, full, meta ) {
                                    wl_land_value = (full.way_leave?full.way_leave:0)*(full.rate_per_acre?full.rate_per_acre:0)*(full.land_interest?(full.land_interest/100):0)*(full.diminution_rate?(full.diminution_rate/100):0);
                                    row_land_value = (data?data:0)*(full.rate_per_acre?full.rate_per_acre:0)*(full.land_interest?(full.land_interest/100):0);
                                    return curr_format( wl_land_value + row_land_value );
                                }
                            },
                                <?php endif; ?>
                                <?php //Total Take Project
                                if ($projectDetails['project_category_unit'] == 5): ?>
                            { data: 'total_take', render: function( data, type, full, meta ) {
                                    row_land_value = (data?data:0)*(full.rate_per_acre?full.rate_per_acre:0);
                                    land_interest = full.land_interest?(full.land_interest/100):0;
                                    return curr_format(Math.round(row_land_value*land_interest));
                                }
                            },
                                <?php endif; ?>
                            { data: 'improvement_sum', render: function( data, type, full, meta ) {return data?curr_format(parseInt(data)):"";}},
                            { data: 'crop_tree_sum', render: function( data, type, full, meta ) {return data?curr_format(parseInt(data)):"";}},
                            { data: 'crop_tree_sum', render: function( data, type, full, meta ) {
                                    total_land_value = 0;
                                    return curr_format((data?parseFloat(data):0)*1+(full.improvement_sum?parseFloat(full.improvement_sum):0)*1);
                                }
                            },
                            { data: 'improvement_sum', render: function( data, type, full, meta ) {
                                    return data?curr_format(parseInt(data)):"";
                                }
                            },
                            { data: 'improvement_sum', render: function( data, type, full, meta ) {
                                    return data?curr_format(parseInt(data)):"";
                                }
                            },
                            { data: 'comment'
                            }
                            ] ,
                                buttons: [
                            {
                                extend: "copy",
                                className: "btn-sm btn-white",
                                footer: true
                            },
                            {
                                extend: "csv",
                                className: "btn-sm btn-white",
                                footer: true
                            },
                            {
                                extend: "excel",
                                className: "btn-sm btn-white",
                                footer: true
                            },
                            {
                                extend: "pdfHtml5",
                                className: "btn-sm btn-white",
                                footer: true
                            },
                            {
                                extend: "print",
                                className: "btn-sm btn-white",
                                footer: true
                            },
                            ]//,responsive: true
                            });
                            //$("#datatable-buttons").DataTable();
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
});

</script>