<script>
//the view model for the page
var dTable = {};
$(document).ready(function(){
    <?php if(isset($projectDetails)):?>
            var handleDataTableButtons = function() {
                var button_options = [
                        { extend: "copy", className: "btn-sm btn-white", footer: true },
                        { extend: "excel", className: "btn-sm btn-white", footer: true },
                        { extend: "pdfHtml5", className: "btn-sm btn-white", footer: true },
                        { extend: "print", className: "btn-sm btn-white", footer: true }
                    ];
            /* -- Project Affected Person Report Data Table --- */
            if ($("#tblPapsReport").length) {
                dTable['tblPapsReport'] = $('#tblPapsReport').DataTable({
                    dom: '<".col-md-7"B><".col-md-2"l><".col-md-3"f>rt<".col-md-7"i><".col-md-5"p>',
                    "searching": true,
                    "ordering": false,
                    "paging": true,
                    "lengthChange": true,
                    "autoWidth": false,
                    "lengthMenu": [[10, 50, 100, -1], [10, 50,  100, "All"]],
                    fixedHeader: true,
                    "order": [ 0, 'asc'],
                    buttons: button_options,
                    responsive: false
                });
            }
            /* -- VILLAGES SUMMARY Report Data Table --- */
            if ($("#tblVillageReport").length) {
                var d_allow = <?php echo $projectDetails['disturbance_allowance']/100;?>; //disturbance_allowance
                dTable['tblVillageReport'] = $('#tblVillageReport').DataTable({
                    dom: '<".col-md-7"B><".col-md-2"l><".col-md-3"f>rt<".col-md-7"i><".col-md-5"p>',
                    "autoWidth": false,
                    "lengthMenu": [[10, 50, 100, -1], [10, 50,  100, "All"]],
                    fixedHeader: true,
                    order: [[0, 'asc'],[1,'asc'],[2,'asc'],[3,'asc']],
                    "ajax": {
                        "url":"getData.php",
                        "dataType": "JSON",
                        "type": "POST",
                        "data":  function(d){
                            d.tbl = 'pap_village_report';
                            d.project_id = <?php echo $_GET['id']; ?>;
                        }
                    },
                        "footerCallback": function (tfoot, data, start, end, display ) {
                            var api = this.api();
                            $.each([4,5,6,7], function(key, val){
                            });
                            var papsPageTotal = api.column(4, {page: 'current'}).data().sum();
                            var papsTotal = api.column(4).data().sum();
                            $(api.column(4).footer()).html( curr_format(papsPageTotal) + " (" + curr_format(papsTotal) +")" );
                            var cropsPageTotal = api.column(5, {page: 'current'}).data().sum();
                            var cropsTotal = api.column(5).data().sum();
                            $(api.column(5).footer()).html( curr_format(Math.round(cropsPageTotal)) + " (" + curr_format(Math.round(cropsTotal)) +")" );
                            var improvementsPageTotal = api.column(6, {page: 'current'}).data().sum();
                            var improvementsTotal = api.column(6).data().sum();
                            $(api.column(6).footer()).html( curr_format(Math.round(improvementsPageTotal)) + " (" + curr_format(Math.round(improvementsTotal)) +")" );
                            var landValuePageTotal = api.column(7, {page: 'current'}).data().sum();
                            var landValueTotal = api.column(7).data().sum();
                            $(api.column(7).footer()).html( curr_format(Math.round(landValuePageTotal)) + " (" + curr_format(Math.round(landValueTotal)) +")" );
                            var pageSubTotal = cropsPageTotal+improvementsPageTotal+landValuePageTotal;
                            var subTotal = cropsTotal+improvementsTotal+landValueTotal;
                            $(api.column(8).footer()).html( curr_format(Math.round(pageSubTotal)) + " (" + curr_format(Math.round(subTotal)) +")" );
                            $(api.column(9).footer()).html( curr_format(Math.round(pageSubTotal*d_allow)) + " (" + curr_format(Math.round(subTotal*d_allow)) +")" );
                            $(api.column(10).footer()).html( curr_format(Math.round(pageSubTotal*d_allow+pageSubTotal)) + " (" + curr_format(Math.round(subTotal+subTotal*d_allow)) +")" );
                            },
                            columns:[ 
                        { data: 'district_name' },
                        { data: 'parish_name' },
                        { data: 'subcounty_name' },
                        { data: 'village_name' },
                        { data: 'no_paps', render: function( data, type, full, meta ) {return data?curr_format(data):"";}},
                        { data: 'crop_tree_value', render: function( data, type, full, meta ) {return data?curr_format(Math.round(data*1)):"";}},
                        { data: 'improvement_value', render: function( data, type, full, meta ) {return data?curr_format(Math.round(data*1)):"";}},
                        { data: 'land_value', render: function( data, type, full, meta ) {return data?curr_format(Math.round(data*1)):"";}},
                        { data: 'improvement_value', render: function( data, type, full, meta ) {
                                var overall_value = (data?parseFloat(data):0)+(full.land_value?parseFloat(full.land_value):0)+(full.crop_tree_value?parseFloat(full.crop_tree_value):0);
                                return curr_format(Math.round(overall_value*1));}
                        },
                        { data: 'improvement_value', render: function( data, type, full, meta ) {
                                var overall_value = (data?parseFloat(data):0)+(full.land_value?parseFloat(full.land_value):0)+(full.crop_tree_value?parseFloat(full.crop_tree_value):0);
                                return curr_format(Math.round(d_allow*overall_value));
                            }
                        },
                        { data: 'improvement_value', render: function( data, type, full, meta ) {
                                var overall_value = (data?parseFloat(data):0)+(full.land_value?parseFloat(full.land_value):0)+(full.crop_tree_value?parseFloat(full.crop_tree_value):0);
                                return curr_format(Math.round(d_allow*overall_value+overall_value));
                            }
                        }
                        ],
                    buttons: button_options,
                    responsive: false
                });
            }
            /* -- IMPROVEMENTS SUMMARY Report Data Table --- */
            if ($("#tblImprovementsReport").length) {
                dTable['tblImprovementsReport'] = $('#tblImprovementsReport').DataTable({
                    dom: '<".col-md-7"B><".col-md-2"l><".col-md-3"f>rt<".col-md-7"i><".col-md-5"p>',
                    "autoWidth": false,
                    "lengthMenu": [[10, 50, 100, -1], [10, 50,  100, "All"]],
                    fixedHeader: true,
                    "order": [ 0, 'asc'],
                    "ajax": {
                        "url":"getData.php",
                        "dataType": "JSON",
                        "type": "POST",
                        "data":  function(d){
                            d.tbl = 'project_improvements_report';
                            d.project_id = <?php echo $_GET['id']; ?>;
                        }
                    },
                        "footerCallback": function (tfoot, data, start, end, display ) {
                            var api = this.api();
                                var totalPageValue = 0, totalOverallValue = 0;
                                
                                var pageQuantities = api.column(3, {page: 'current'}).data();
                                var overallQuantities = api.column(3).data();
                                var pageRates = api.column(4, {page: 'current'}).data();
                                var overallRates = api.column(4).data();
                             $.each(pageQuantities, function(key, val){
                                 totalPageValue += val?(parseFloat(val)*(pageRates[key]?parseFloat(pageRates[key]):0)*1):0;
                                 });
                             $.each(overallQuantities, function(key, val){
                                 totalOverallValue += val?(parseFloat(val)*(overallRates[key]?parseFloat(overallRates[key]):0)*1):0;
                                 });
                                $(api.column(5).footer()).html( curr_format(Math.round(totalPageValue)) + " (" + curr_format(Math.round(totalOverallValue)) +")" );
                            },
                            columns:[ 
                        { data: 'propertytype' },
                        { data: 'propertydescription' },
                        { data: 'property_cnt', render: function( data, type, full, meta ) {return data?curr_format(data*1):"";} },
                        { data: 'qty', render: function( data, type, full, meta ) {return data?curr_format(data*1):"";} },
                        //{ data: 'qty', render: function( data, type, full, meta ) {return data?(curr_format(data*1)+(full.improv_msf?(' '+full.improv_msf):'')):"";} },
                        { data: 'qty_rate', render: function( data, type, full, meta ) {return data?curr_format(data*1):"";} },
                        { data: 'qty_rate', render: function( data, type, full, meta ) {return data?curr_format(Math.round(data*(full.qty?full.qty:0))):"";} }
                        ],
                    buttons: button_options,
                    responsive: false
                });
            }
            /* -- CROPS SUMMARY Report Data Table --- */
            if ($("#tblCropsReport").length) {
                dTable['tblCropsReport'] = $('#tblCropsReport').DataTable({
                    dom: '<".col-md-7"B><".col-md-2"l><".col-md-3"f>rt<".col-md-7"i><".col-md-5"p>',
                    "autoWidth": false,
                    "lengthMenu": [[10, 50, 100, -1], [10, 50,  100, "All"]],
                    fixedHeader: true,
                    "order": [ 0, 'asc'],
                    "ajax": {
                        "url":"getData.php",
                        "dataType": "JSON",
                        "type": "POST",
                        "data":  function(d){
                            d.tbl = 'project_crops_report';
                            d.project_id = <?php echo $_GET['id']; ?>;
                        }
                    },
                        "footerCallback": function (tfoot, data, start, end, display ) {
                            var api = this.api();
                                var totalPageValue = 0, totalOverallValue = 0;
                                
                                var pageQuantities = api.column(3, {page: 'current'}).data();
                                var overallQuantities = api.column(3).data();
                                var pageRates = api.column(4, {page: 'current'}).data();
                                var overallRates = api.column(4).data();
                             $.each(pageQuantities, function(key, val){
                                 totalPageValue += val?(parseFloat(val)*(pageRates[key]?parseFloat(pageRates[key]):0)*1):0;
                                 });
                             $.each(overallQuantities, function(key, val){
                                 totalOverallValue += val?(parseFloat(val)*(overallRates[key]?parseFloat(overallRates[key]):0)*1):0;
                                 });
                                $(api.column(5).footer()).html( curr_format(Math.round(totalPageValue)) + " (" + curr_format(Math.round(totalOverallValue)) +")" );
                            },
                            columns:[ 
                        { data: 'croptype' },
                        { data: 'cropdescription' },
                        { data: 'crop_cnt', render: function( data, type, full, meta ) {return data?curr_format(data*1):"";} },
                        { data: 'qty', render: function( data, type, full, meta ) {return data?curr_format(data*1):"";} },
                        //{ data: 'qty', render: function( data, type, full, meta ) {return data?(curr_format(data*1)+(full.crop_msf?(' '+full.crop_msf):'')):"";} },
                        { data: 'qty_rate', render: function( data, type, full, meta ) {return data?curr_format(data*1):"";} },
                        { data: 'qty_rate', render: function( data, type, full, meta ) {return data?curr_format(Math.round(data*(full.qty?full.qty:0))):"";} }
                        ],
                    buttons: button_options,
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
