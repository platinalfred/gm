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
                dTable['tblVillageReport'] = $('#tblVillageReport').DataTable({
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
                            d.tbl = 'pap_village_report';
                            d.project_id = <?php echo $_GET['id']; ?>;
                        }
                    },
                        "footerCallback": function (tfoot, data, start, end, display ) {
                            var api = this.api();
                            $.each([4,5,6], function(key, val){
                                var pageTotal = api.column(val, {page: 'current'}).data().sum();
                                var total = api.column(val).data().sum();
                                $(api.column(val).footer()).html( curr_format(pageTotal) + " (" + curr_format(total) +")" );
                            });
                            },
                            columns:[ 
                        { data: 'district_name' },
                        { data: 'parish_name' },
                        { data: 'subcounty_name' },
                        { data: 'village_name' },
                        { data: 'no_paps', render: function( data, type, full, meta ) {return data?curr_format(data):"";}},
                        { data: 'crop_tree_value', render: function( data, type, full, meta ) {return data?curr_format(data*1):"";}},
                        { data: 'improvement_value', render: function( data, type, full, meta ) {return data?curr_format(data*1):"";}}
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
                            $.each([2,3], function(key, val){
                                var pageTotal = api.column(val, {page: 'current'}).data().sum();
                                var total = api.column(val).data().sum();
                                $(api.column(val).footer()).html( curr_format(pageTotal) + " (" + curr_format(total) +")" );
                            });
                            },
                            columns:[ 
                        { data: 'propertytype' },
                        { data: 'propertydescription' },
                        { data: 'property_cnt', render: function( data, type, full, meta ) {return data?(full.improv_msf?curr_format(data*1):(curr_format(full.property_sum*1))):"";} },
                        //{ data: 'property_sum', render: function( data, type, full, meta ) {return data?curr_format(data):"";} },
                        { data: 'property_sum', render: function( data, type, full, meta ) {return data?((full.improv_msf?(curr_format(data*1)+' '+full.improv_msf):'')):"";} }
                        //,{ data: 'property_sum', render: function( data, type, full, meta ) {return data?(full.improv_msf?(' '+full.improv_msf):''):"";} }
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
                            $.each([2,3], function(key, val){
                                var pageTotal = api.column(val, {page: 'current'}).data().sum();
                                var total = api.column(val).data().sum();
                                $(api.column(val).footer()).html( curr_format(pageTotal) + " (" + curr_format(total) +")" );
                            });
                            },
                            columns:[ 
                        { data: 'croptype' },
                        { data: 'cropdescription' },
                        { data: 'crop_cnt', render: function( data, type, full, meta ) {return data?(full.crop_msf?curr_format(data*1):(curr_format(full.crop_sum*1))):"";} },
                        //{ data: 'property_sum', render: function( data, type, full, meta ) {return data?curr_format(data):"";} },
                        { data: 'crop_sum', render: function( data, type, full, meta ) {return data?((full.crop_msf?(curr_format(data*1)+' '+full.crop_msf):'')):"";} }
                        //,{ data: 'property_sum', render: function( data, type, full, meta ) {return data?(full.improv_msf?(' '+full.improv_msf):''):"";} }
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
