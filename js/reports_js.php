<script>
var dTable = {};
$(document).ready(function(){
    function set_footer_total(api){
        var ttlValuePageTotal = 0; var ttlValueTotal = 0; var project_type = <?php echo $projectDetails['project_category_unit'];?>;
        var rowValuePageTotal = 0; var rowValueTotal = 0; var wlValuePageTotal = 0; var wlValueTotal = 0;
        
        /**Generally total size refers to the total land size affected by the projected
         * in this context total size can mean ROW or WL depending on the project type
         * will also mean way leave size (in the case of category 4, both ROW and WL)
         */
        var total_size_p = api.column(8, {page: 'current'}).data();
        var total_size_ov = api.column(8).data();
        var rate_per_acre_p = api.column(9, {page: 'current'}).data();
        var rate_per_acre_ov = api.column(9).data();
        var land_interest_p = api.column(10, {page: 'current'}).data();
        var land_interest_ov = api.column(10).data();
        var diminution_rate_p = [], row_land_size_p = [];
        var diminution_rate_ov = [], row_land_size_ov = [];
        
        if(project_type == 2){
            diminution_rate_p = api.column(11, {page: 'current'}).data();
            diminution_rate_ov = api.column(11).data();
        }
        if(project_type == 4){
            row_land_size_p = api.column(9, {page: 'current'}).data();
            row_land_size_ov = api.column(9).data();
            rate_per_acre_p = api.column(11, {page: 'current'}).data();
            rate_per_acre_ov = api.column(11).data();
            land_interest_p = api.column(12, {page: 'current'}).data();
            land_interest_ov = api.column(12).data();
            diminution_rate_p = api.column(13, {page: 'current'}).data();
            diminution_rate_ov = api.column(13).data();
        }
        $.each(total_size_p, function(key, val){
            var row_land_value = (row_land_size_p.length?parseFloat(row_land_size_p[key]):0)*parseFloat(rate_per_acre_p[key]) * (parseFloat(land_interest_p[key]/100));
            var diminution_rate = diminution_rate_p.length?(parseFloat(diminution_rate_p[key])/100):1
            var wl_land_value = (parseFloat(val)*diminution_rate)*parseFloat(rate_per_acre_p[key]) * (parseFloat(land_interest_p[key]/100)) ;
            rowValuePageTotal += row_land_value ;
            wlValuePageTotal += wl_land_value;
            ttlValuePageTotal += (row_land_value+wl_land_value) ;
        });
        $.each(total_size_ov, function(key, val){
            var row_land_value = ((row_land_size_ov.length)?parseFloat(row_land_size_ov[key]):0)*parseFloat(rate_per_acre_ov[key]) * (parseFloat(land_interest_ov[key]/100));
            var diminution_rate = diminution_rate_ov.length?(parseFloat(diminution_rate_ov[key])/100):1
            var wl_land_value = (parseFloat(val)*diminution_rate)*parseFloat(rate_per_acre_ov[key]) * (parseFloat(land_interest_ov[key]/100)) ;
            rowValueTotal += row_land_value ;
            wlValueTotal += wl_land_value;
            ttlValueTotal += (row_land_value+wl_land_value);
        });
        if(project_type == 4){
            $(api.column(14).footer()).html( curr_format(round(rowValuePageTotal,4)) + " (" + curr_format(round(rowValueTotal,4)) +")" );
            $(api.column(15).footer()).html( curr_format(round(wlValuePageTotal,4)) + " (" + curr_format(round(wlValueTotal,4)) +")" );
        }
        var land_size_col = project_type==2?12:(project_type==4?16:11);
        $(api.column(land_size_col).footer()).html( curr_format(round(ttlValuePageTotal,4)) + " (" + curr_format(round(ttlValueTotal,4)) +")" );
        
        var crop_total_col = project_type==2?13:(project_type==4?17:12);
        crop_pageTotal = api.column(crop_total_col, {page: 'current'}).data().sum();
        crop_total = api.column(crop_total_col).data().sum();
        $(api.column(crop_total_col).footer()).html( curr_format(round(crop_pageTotal,4)) + " (" + curr_format(round(crop_total,4)) +")" );
        
        var property_total_col = project_type==2?14:(project_type==4?18:13);
        property_pageTotal = api.column(property_total_col, {page: 'current'}).data().sum();
        property_total = api.column(property_total_col).data().sum();
        $(api.column(property_total_col).footer()).html( curr_format(round(property_pageTotal,4)) + " (" + curr_format(round(property_total,4)) +")" );
        
        var sub_total_col = project_type==2?15:(project_type==4?19:14);
        sub_pageTotal = ttlValuePageTotal + crop_pageTotal+ property_pageTotal;
        sub_total = ttlValueTotal + crop_total + property_total;
        $(api.column(sub_total_col).footer()).html( curr_format(round(sub_pageTotal,4)) + " (" + curr_format(round(sub_total,4)) +")" );
        //disturbance allowance
        var da_total_col = project_type==2?16:(project_type==4?20:15);
        da_pageTotal = sub_pageTotal*<?php echo $projectDetails['disturbance_allowance'];?>/100;
        da_total = sub_total*<?php echo $projectDetails['disturbance_allowance'];?>/100;
        $(api.column(da_total_col).footer()).html( curr_format(round(da_pageTotal,4)) + " (" + curr_format(round(da_total,4)) +")" );
        //total compensation
        var tc_total_col = project_type==2?17:(project_type==4?21:16);
        tc_pageTotal = sub_pageTotal+da_pageTotal;
        tc_total = sub_total+da_total;
        $(api.column(tc_total_col).footer()).html( curr_format(round(tc_pageTotal,4)) + " (" + curr_format(round(tc_total,4)) +")" );
    }
	//deleteDataTableRowData();
	var handleDataTableButtons = function() {
            var cols = [8,12,13]; //the index for columns where  the totals appear
            var last_col = 17; //the final index table column
         <?php if( ($projectDetails['project_category_unit'] == 2) ):?>//wl
             cols = [8,13,14]; last_col = 18;
         <?php endif;?>
         <?php if( ($projectDetails['project_category_unit'] == 4) ):?>//both row and wl
             cols = [8,9,10]; last_col = 22;
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
                            "lengthMenu": [[10, 25, 50, -1], [10, 50,  100, "All"]],
                            "footerCallback": function (tfoot, data, start, end, display ) {
                                var api = this.api();
                                $.each(cols, function(key, val){
                                    pageTotal = api.column(val, {page: 'current'}).data().sum();
                                    total = api.column(val).data().sum();
                                    $(api.column(val).footer()).html( curr_format(round(pageTotal,4)) + " (" + curr_format(round(total,4)) +")" );
                                });
                                set_footer_total(api);
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
                                <?php //Total Take/Size OR Both ROW and WL Project
                                if ($projectDetails['project_category_unit'] == 5): ?>
                            { data: 'total_take', render: function( data, type, full, meta ) {return data?curr_format(data):"";}},
                                <?php endif; ?>
                                <?php //Total land size for Both ROW and WL Project
                                if ($projectDetails['project_category_unit'] == 4): ?>
                            { data: 'rightofway', render: function( data, type, full, meta ) {return curr_format(round((data?parseFloat(data):0)+(full.way_leave?parseFloat(full.way_leave):0),4));}},
                                <?php endif; ?>
                                <?php //ROW or Total Take/Size OR Both ROW and WL Project
                                //if ($projectDetails['project_category_unit'] == 1 || $projectDetails['project_category_unit'] == 4 || $projectDetails['project_category_unit'] == 5): ?>
                            { data: 'rate_per_acre', render: function( data, type, full, meta ) {return data?curr_format(Math.round(data)):"";}},
                            { data: 'land_interest', render: function( data, type, full, meta ) {return data?data:0;}},
                                <?php //endif; ?>
                                <?php //Dimunition rate for Both ROW and WL Project
                                if ($projectDetails['project_category_unit'] == 2 || $projectDetails['project_category_unit'] == 4): ?>
                            { data: 'diminution_rate', render: function( data, type, full, meta ) {return data?(data+"%"):"";}},
                                <?php endif; ?>
                                <?php //ROW or both ROW and WL
                                if ($projectDetails['project_category_unit'] == 1 || $projectDetails['project_category_unit'] == 4):
                                    ?>
                            { data: 'rightofway', render: function( data, type, full, meta ) {
                                    row_land_value = (data?data:0)*(full.rate_per_acre?full.rate_per_acre:0);
                                    land_interest = full.land_interest?(full.land_interest/100):0;
                                    return curr_format(round(row_land_value*land_interest,4));
                                }
                            },
                                <?php endif; ?>
                                <?php //Way Leave or both ROW and WL
                                if ($projectDetails['project_category_unit'] == 2 || $projectDetails['project_category_unit'] == 4):
                                    ?>
                            { data: 'way_leave', render: function( data, type, full, meta ) {
                                    land_value = (data?data:0)*(full.rate_per_acre?full.rate_per_acre:0);
                                    land_interest = full.land_interest?(full.land_interest/100):0;
                                    diminution_rate = full.diminution_rate?(full.diminution_rate/100):0;
                                    return curr_format(round(land_value*land_interest*diminution_rate,4));
                                }
                            },
                                <?php endif; ?>
                                <?php if ($projectDetails['project_category_unit'] == 4): ?>
                                    //Total land value, applies to Both ROW and WL
                            { data: 'rightofway', render: function( data, type, full, meta ) {
                                    wl_land_value = (full.way_leave?full.way_leave:0)*(full.rate_per_acre?full.rate_per_acre:0)*(full.land_interest?(full.land_interest/100):0)*(full.diminution_rate?(full.diminution_rate/100):0);
                                    row_land_value = (data?data:0)*(full.rate_per_acre?full.rate_per_acre:0)*(full.land_interest?(full.land_interest/100):0);
                                    return curr_format( round(wl_land_value,4) + round(row_land_value,4) );
                                }
                            },
                                <?php endif; ?>
                               <?php  if ($projectDetails['project_category_unit'] == 5): ?>
                            { data: 'total_take', render: function( data, type, full, meta ) {
                                    row_land_value = (data?data:0)*(full.rate_per_acre?full.rate_per_acre:0);
                                    land_interest = full.land_interest?(full.land_interest/100):0;
                                    return curr_format(round(row_land_value*land_interest,4));
                                }
                            },
                                <?php endif; ?>
                            { data: 'improvement_sum', render: function( data, type, full, meta ) {return data?curr_format(parseInt(data)):"";}},
                            { data: 'crop_tree_sum', render: function( data, type, full, meta ) {return data?curr_format(parseInt(data)):"";}},
                            { data: 'crop_tree_sum', render: function( data, type, full, meta ) {
                                    total_crop_value = (data?parseFloat(data):0)*1;
                                    total_property_value = (full.improvement_sum?parseFloat(full.improvement_sum):0)*1;
                                <?php  if ($projectDetails['project_category_unit'] == 1 || $projectDetails['project_category_unit'] == 4):  ?>
                                            //Right of way or both ROW and WL
                                    row_land_value = (data?data:0)*(full.rate_per_acre?full.rate_per_acre:0);
                                    land_interest = full.land_interest?(full.land_interest/100):0;
                                    total_land_value = row_land_value*land_interest;
                                <?php endif; ?>
                                <?php  if ($projectDetails['project_category_unit'] == 2 || $projectDetails['project_category_unit'] == 4):  ?>
                                            //Way Leave or both ROW and WL
                                    land_value = (data?data:0)*(full.rate_per_acre?full.rate_per_acre:0);
                                    land_interest = full.land_interest?(full.land_interest/100):0;
                                    diminution_rate = full.diminution_rate?(full.diminution_rate/100):0;
                                    total_land_value = land_value*land_interest*diminution_rate;
                                <?php endif; ?>
                                <?php if ($projectDetails['project_category_unit'] == 4): ?>
                                    wl_land_value = (full.way_leave?full.way_leave:0)*(full.rate_per_acre?full.rate_per_acre:0)*(full.land_interest?(full.land_interest/100):0)*(full.diminution_rate?(full.diminution_rate/100):0);
                                    row_land_value = (full.rightofway?full.rightofway:0)*(full.rate_per_acre?full.rate_per_acre:0)*(full.land_interest?(full.land_interest/100):0);
                                    total_land_value = wl_land_value + row_land_value;
                                <?php endif; ?>
                               <?php  if ($projectDetails['project_category_unit'] == 5): ?>
                                    row_land_value = (full.total_take?full.total_take:0)*(full.rate_per_acre?full.rate_per_acre:0);
                                    land_interest = full.land_interest?(full.land_interest/100):0;
                                    total_land_value = row_land_value*land_interest;
                                <?php endif; ?>
                                    return curr_format(round(total_crop_value+total_property_value + total_land_value,4));
                                }
                            },
                            { data: 'crop_tree_sum', render: function( data, type, full, meta ) {
                                    total_crop_value = (data?parseFloat(data):0)*1;
                                    total_property_value = (full.improvement_sum?parseFloat(full.improvement_sum):0)*1;
                                <?php  if ($projectDetails['project_category_unit'] == 1 || $projectDetails['project_category_unit'] == 4):  ?>
                                            //Right of way or both ROW and WL
                                    row_land_value = (data?data:0)*(full.rate_per_acre?full.rate_per_acre:0);
                                    land_interest = full.land_interest?(full.land_interest/100):0;
                                    total_land_value = row_land_value*land_interest;
                                <?php endif; ?>
                                <?php  if ($projectDetails['project_category_unit'] == 2 || $projectDetails['project_category_unit'] == 4):  ?>
                                            //Way Leave or both ROW and WL
                                    land_value = (data?data:0)*(full.rate_per_acre?full.rate_per_acre:0);
                                    land_interest = full.land_interest?(full.land_interest/100):0;
                                    diminution_rate = full.diminution_rate?(full.diminution_rate/100):0;
                                    total_land_value = land_value*land_interest*diminution_rate;
                                <?php endif; ?>
                                <?php if ($projectDetails['project_category_unit'] == 4): ?>
                                    wl_land_value = (full.way_leave?full.way_leave:0)*(full.rate_per_acre?full.rate_per_acre:0)*(full.land_interest?(full.land_interest/100):0)*(full.diminution_rate?(full.diminution_rate/100):0);
                                    row_land_value = (full.rightofway?full.rightofway:0)*(full.rate_per_acre?full.rate_per_acre:0)*(full.land_interest?(full.land_interest/100):0);
                                    total_land_value = wl_land_value + row_land_value;
                                <?php endif; ?>
                               <?php  if ($projectDetails['project_category_unit'] == 5): ?>
                                    row_land_value = (full.total_take?full.total_take:0)*(full.rate_per_acre?full.rate_per_acre:0);
                                    land_interest = full.land_interest?(full.land_interest/100):0;
                                    total_land_value = row_land_value*land_interest;
                                <?php endif; ?>
                                    return curr_format(round((total_crop_value+total_property_value + total_land_value)*<?php echo $projectDetails['disturbance_allowance'];?>/100,4));
                                }
                            },
                            { data: 'crop_tree_sum', render: function( data, type, full, meta ) {
                                    total_crop_value = (data?parseFloat(data):0)*1;
                                    total_property_value = (full.improvement_sum?parseFloat(full.improvement_sum):0)*1;
                                <?php  if ($projectDetails['project_category_unit'] == 1 || $projectDetails['project_category_unit'] == 4):  ?>
                                            //Right of way or both ROW and WL
                                    row_land_value = (data?data:0)*(full.rate_per_acre?full.rate_per_acre:0);
                                    land_interest = full.land_interest?(full.land_interest/100):0;
                                    total_land_value = row_land_value*land_interest;
                                <?php endif; ?>
                                <?php  if ($projectDetails['project_category_unit'] == 2 || $projectDetails['project_category_unit'] == 4):  ?>
                                            //Way Leave or both ROW and WL
                                    land_value = (data?data:0)*(full.rate_per_acre?full.rate_per_acre:0);
                                    land_interest = full.land_interest?(full.land_interest/100):0;
                                    diminution_rate = full.diminution_rate?(full.diminution_rate/100):0;
                                    total_land_value = land_value*land_interest*diminution_rate;
                                <?php endif; ?>
                                <?php if ($projectDetails['project_category_unit'] == 4): ?>
                                    wl_land_value = (full.way_leave?full.way_leave:0)*(full.rate_per_acre?full.rate_per_acre:0)*(full.land_interest?(full.land_interest/100):0)*(full.diminution_rate?(full.diminution_rate/100):0);
                                    row_land_value = (full.rightofway?full.rightofway:0)*(full.rate_per_acre?full.rate_per_acre:0)*(full.land_interest?(full.land_interest/100):0);
                                    total_land_value = wl_land_value + row_land_value;
                                <?php endif; ?>
                               <?php  if ($projectDetails['project_category_unit'] == 5): ?>
                                    row_land_value = (full.total_take?full.total_take:0)*(full.rate_per_acre?full.rate_per_acre:0);
                                    land_interest = full.land_interest?(full.land_interest/100):0;
                                    total_land_value = row_land_value*land_interest;
                                <?php endif; ?>
                                    sub_total = (total_crop_value+total_property_value + total_land_value);
                                    return curr_format(round(sub_total+(sub_total*<?php echo $projectDetails['disturbance_allowance'];?>/100),4));
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