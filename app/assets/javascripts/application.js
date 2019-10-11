// This is a manifest file that'll be compiled into application.js, which will include all the files
// listed below.
//
// Any JavaScript/Coffee file within this directory, lib/assets/javascripts, or any plugin's
// vendor/assets/javascripts directory can be referenced here using a relative path.
//
// It's not advisable to add code directly here, but if you do, it'll appear at the bottom of the
// compiled file. JavaScript code in this file should be added after the last require_* statement.
//
// Read Sprockets README (https://github.com/rails/sprockets#sprockets-directives) for details
// about supported directives.
//
//= require rails-ujs
//= require activestorage
//= require jquery
//= require Chart.min
//= require bootstrap-sprockets
//= require_tree .

var colorSet = {
	red: 'rgb(255, 99, 132)',
	orange: 'rgb(255, 159, 64)',
	yellow: 'rgb(255, 205, 86)',
	green: 'rgb(75, 192, 192)',
	blue: 'rgb(54, 162, 235)',
	purple: 'rgb(153, 102, 255)',
	grey: 'rgb(201, 203, 207)'
};

var myChart;

		var title = gon.big5_title;
		var label_result = gon.big5_labels;
		var value_result = gon.big5_values;
		var color_value = colorSet.red;

		window.draw_graph = function() {
			var ctx;
			var color = Chart.helpers.color;

			ctx = document.getElementById("myChart").getContext('2d');
			if(myChart){
				myChart.destroy();
			}

			myChart = new Chart(ctx, {
				type: 'radar',
				data: {
					labels: label_result,
					datasets: [
						{
							label: title,
							backgroundColor: color(color_value).alpha(0.5).rgbString(),
							borderColor: color_value,
							pointBackgroundColor: color_value,
							data: value_result
						}
					]
				},
				options: {
					scale: {
						ticks: {
							min: 0,              // 最大値
							max: 100,            // 最大値
							stepSize: 20
						}
					}
				}
			});
		};

	$(function() {
		// debugger;
		$('#result_big5').on('click', function(event){
			title = gon.big5_title;
			value_result = gon.big5_values;
			label_result = gon.big5_labels;
			color_value = colorSet.red;
			draw_graph();
		});
	});
	$(function() {
		$('#result_need').on('click', function(event){
			title = gon.need_title;
			value_result = gon.need_values;
			label_result = gon.need_labels;
			color_value = colorSet.blue;
			draw_graph();
		});
	});
	$(function() {
		$('#result_value').on('click', function(event){
			title = gon.value_title;
			value_result = gon.value_values;
			label_result = gon.value_labels;
			color_value = colorSet.orange;
			draw_graph();
		});
	});

// userの退会しますか？画面の切り替え
window.onload = function () {
	$(function() {
    // user側の画面切り替えID名
	var leaveBank = document.getElementById('leaveBank');
	// admin側の画面切り替えID名
	var leaveBank2 = document.getElementById('leaveBank2');
	// 退会しますか？画面の代わりに<body>内を非表示にするためのID取得
	var body1 = document.getElementById('hide');
	var destroybody1 = document.getElementById('showdestroy');
	var backToBank = document.getElementById('backToBank');
		if (leaveBank !== null) {
			leaveBank.addEventListener('click', event => {
				body1.style.display="none";
				destroybody1.style.display="block";
			});
			backToBank.addEventListener('click', event => {
				body1.style.display="block";
				destroybody1.style.display="none";
			});
		}
		if (leaveBank2 !== null) {
			leaveBank2.addEventListener('click', event => {
				body1.style.display="none";
				destroybody1.style.display="block";
			});
			backToBank.addEventListener('click', event => {
				body1.style.display="block";
				destroybody1.style.display="none";
			});
		}
	});
};

// ハンバーガーメニュー
$(function() {
	$('.menu-trigger').on('click', function() {
		$(this).toggleClass('active');
		$('#hamburger').fadeToggle();
		return false;
	});
});