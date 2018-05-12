<script type="text/javascript">
//format numbers with thousands separator
    /*PICK DATA FOR DATA TABLE  */

    $('input.athousand_separator').keyup(function (event) {
        // skip for arrow keys
        if (event.which >= 37 && event.which <= 40) {
            event.preventDefault();
        }
        $(this).val(function (index, value) {
            value = value.replace(/,/g, '');
            //alert(numberWithCommas(value));
            return numberWithCommas(value);
        });
    });

//Only numbers
    function checkInput(input) {
        var invalidChars = /[^0-9]/gi
        if (invalidChars.test(input.value)) {
            input.value = input.value.replace(invalidChars, "");
        }
    }
//% input restrictions
    function handleChange(input) {
        if (input.value < 0)
            input.value = 0;
        if (input.value > 100)
            input.value = 100;
    }
    function enableDisableButton(frm, status) {
        $(frm).find(":input[type=submit], :button[type=submit]").prop("disabled", status);
    }
    function numberWithCommas(x) {
        var parts = x.toString().split(".");
        parts[0] = parts[0].replace(/\B(?=(\d{3})+(?!\d))/g, ",");
        return parts.join(".");
    }
    function curr_format(n) {
        var formatted = "";
        /* if(n<0){
         n = n*-1;
         formatted = n.toString().replace(/./g, function(c, i, a) {
         return i > 0 && c !== "." && (a.length - i) % 3 === 0 ? "," + c : c;
         });
         formatted = "("+formatted + ")";
         }else{
         formatted = n.toString().replace(/./g, function(c, i, a) {
         return i > 0 && c !== "." && (a.length - i) % 3 === 0 ? "," + c : c;
         })
         } */
        formatted = (n < 0) ? ("(" + numberWithCommas(n * -1) + ")") : numberWithCommas(n);
        return formatted;
    }
//sum up values in an array
    function array_total(arr, idx) {
        var total = 0.0;
        $.each(arr, function (key, value) {
            total += parseFloat(value[idx]);
        });
        return total;
    }
//given array, get the total for the transaction type
    function sumUpAmount(items, transactionType) {
        var total = 0;
        if (items) {
            $.map(items, function (item) {
                total += (parseInt(item['transactionType']) == transactionType) ? (item['amount'] ? parseInt(item['amount']) : 0) : 0;
            });
        }

        return total;
    }
//Bar chart
    function draw_bar_chart(url_data) {
        $("#barChart").replaceWith('<canvas id="barChart"></canvas>');
        var ctx = $("#barChart").get(0).getContext("2d");

        var barChart = new Chart(ctx, {
            type: 'bar',
            data: {
                labels: url_data.labels,
                datasets: url_data.datasets
            },
            options: {
                scales: {
                    yAxes: [{
                            ticks: {
                                beginAtZero: true
                            }
                        }]
                }
            }
        });
    }
// Line chart
    function draw_line_chart(url_data) {
        $("#lineChart").replaceWith('<canvas id="lineChart"></canvas>');
        var ctx = $("#lineChart").get(0).getContext("2d");

        var lineOptions = {
            scaleShowGridLines: true,
            scaleGridLineColor: "rgba(0,0,0,.05)",
            scaleGridLineWidth: 1,
            bezierCurve: true,
            bezierCurveTension: 0.4,
            pointDot: true,
            pointDotRadius: 4,
            pointDotStrokeWidth: 1,
            pointHitDetectionRadius: 20,
            datasetStroke: true,
            datasetStrokeWidth: 2,
            datasetFill: true,
            responsive: true,
        };
        var lineChart = new Chart(ctx, {
            type: 'line',
            data: url_data,
            options: lineOptions
        });
    }
    function draw_line_highchart(url_data) {
        Highcharts.chart('lineChart', {

            title: url_data.title,

            yAxis: url_data.yAxis,
            legend: {
                layout: 'vertical',
                align: 'right',
                verticalAlign: 'middle'
            },
            xAxis: {categories: url_data.xAxis.categories},
            plotOptions: {
                line: {
                    dataLabels: {enabled: true}
                }
            },
            series: url_data.datasets
        });
    }
// Pie chart
    function draw_pie_chart(url_data) {
        // Build the chart
        Highcharts.chart('pieChart', {
            chart: {
                plotBackgroundColor: null,
                plotBorderWidth: null,
                plotShadow: false,
                type: 'pie'
            },
            title: url_data.title,
            tooltip: {
                pointFormat: '{series.name}: <b>{point.percentage:.1f}%</b>'
            },
            plotOptions: {
                pie: {
                    allowPointSelect: true,
                    cursor: 'pointer',
                    dataLabels: {
                        enabled: false
                    },
                    showInLegend: true
                }
            },
            series: [{
                    name: url_data.series.name,
                    colorByPoint: true,
                    data: url_data.series.data
                }]
        });
    }
//Save function called when various buttons with .save are clicked , With this one function all settings will be sent to save_data.php for saving
    function saveData(form, event) {
        event.preventDefault();
        var frm = $(event.target);
        var frmdata = frm.serialize();
        var tbl = frm.find("input[name = 'tbl']");
        var id_input = frm.find("input[name = 'id']");
        var reset = frm.find("input[name = 'noreset']").length;

        enableDisableButton(frm, true);
        $.ajax({
            url: "save_data.php",
            type: 'POST',
            data: frmdata,
            success: function (response) {

                if ($.trim(response) == "success") {
                    showStatusMessage("Data successfully saved", "success");

                    setTimeout(function () {
                        if (tbl.length && $(tbl[0]).val() != "") {
                            var dt = dTable[$(tbl[0]).val()];
                            if (typeof dt !== 'undefined') {
                                dt.ajax.reload();
                            }
                        }
                        if (id_input.length && !isNaN(parseInt($(id_input[0]).val()))) {
                            if(typeof cropViewModel !== 'undefined' && (tbl.length && $(tbl[0]).val() == "CropDescription")){
                                cropViewModel.getServerData(parseInt($(id_input[0]).val()));
                            }
                            if(typeof improvementViewModel !== 'undefined' && (tbl.length && $(tbl[0]).val() == "propertyDescription")){
                                improvementViewModel.getServerData(parseInt($(id_input[0]).val()));
                            }
                        }else {
                            if( reset < 1){
                                frm[0].reset();
                            }
                        }
                        enableDisableButton(frm, false);
                    }, 2000);

                } else {

                    showStatusMessage(response, "fail");
                    enableDisableButton(frm, false);
                }


            }
        });
        return false;
    }
    function getWords(s) {
        // American Numbering System
        var th = ['', 'Thousand', 'Million', 'Billion', 'Trillion'];

        var dg = ['Zero', 'One', 'Two', 'Three', 'Four', 'Five', 'Six', 'Seven', 'Eight', 'Nine'];

        var tn = ['Ten', 'Eleven', 'Twelve', 'Thirteen', 'Fourteen', 'Fifteen', 'Sixteen', 'Seventeen', 'Eighteen', 'Nineteen'];

        var tw = ['Twenty', 'Thirty', 'Forty', 'Fifty', 'Sixty', 'Seventy', 'Eighty', 'Ninety'];


        s = s.toString();
        s = s.replace(/[\, ]/g, '');
        if (s != parseFloat(s))
            return 'not a number';
        var x = s.indexOf('.');
        if (x == -1)
            x = s.length;
        if (x > 15)
            return 'too big';
        var n = s.split('');
        var str = '';
        var sk = 0;
        for (var i = 0; i < x; i++) {
            if ((x - i) % 3 == 2) {
                if (n[i] == '1') {
                    str += tn[Number(n[i + 1])] + ' ';
                    i++;
                    sk = 1;
                } else if (n[i] != 0) {
                    str += tw[n[i] - 2] + ' ';
                    sk = 1;
                }
            } else if (n[i] != 0) {
                str += dg[n[i]] + ' ';
                if ((x - i) % 3 == 0)
                    str += 'hundred ';
                sk = 1;
            }
            if ((x - i) % 3 == 1) {
                if (sk)
                    str += th[(x - i - 1) / 3] + ' ';
                sk = 0;
            }
        }
        if (x != s.length) {
            var y = s.length;
            str += 'point ';
            for (var i = x + 1; i < y; i++)
                str += dg[n[i]] + ' ';
        }
        return str.replace(/\s+/g, ' ');
    }
    //function to edit the data
    function edit_data(data_array, form) {
        $.each(data_array, function (key, val) {
            $.map($('#' + form + ' [name="' + key + '"]'), function (named_item) {
                $(named_item).val(val).trigger('change');
            });
        });
    }
    /*$(function () {
     $('[data-toggle="tooltip"]').tooltip()
     })*/
    $(document).ready(function () {
        jQuery.validator.addMethod("phoneUg", function (value, element) {
            return this.optional(element) || /^(0|\+\d{1,4})(\d{8,11})/.test(value);
        }, "Please enter valid phone number");

        ko.bindingHandlers.select2 = {
            init: function (element, valueAccessor, allBindingsAccessor) {
                $(element).select2(valueAccessor());

                ko.utils.domNodeDisposal.addDisposeCallback(element, function () {
                    $(element).select2('destroy');
                });
            },
            update: function (element, valueAccessor, allBindingsAccessor) {
                var allBindings = allBindingsAccessor(),
                        value = ko.utils.unwrapObservable(allBindings.value || allBindings.selectedOptions);
                if (value) {
                    $(element).trigger('change');
                }
            }
        };
        //$(".modal").each(function(key, val){console.log(val)});
	$(".modal").on("hide.bs.modal", function () {
            console.log("Modal closed");
		// put your default event here
		$('form', this)[0].reset();
		$('input[name="id"]', this).val('');
	});
});
//This function is supposed to make sure when the pop up is not an edit, no data is displayed in the form. It picks the id field and makes sure if empty then the form is empty for adding new data
    function showStatusMessage(message = '', display_type = 'success') {
        new PNotify({
            title: "Action response",
            text: message,
            type: display_type,
            styling: 'bootstrap3',
            sound: true,
            hide: true,
            buttons: {
                closer_hover: false,
            },
            confirm: {
                confirm: true,
                buttons: [{
                        text: 'Ok',
                        addClass: 'btn-primary',
                        click: function (notice) {
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
</script>
