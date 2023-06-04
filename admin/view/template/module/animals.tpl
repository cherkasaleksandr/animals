<?php echo $header; ?><?php echo $column_left; ?>
<div id="content">
	<div class="page-header">
		<div class="container-fluid">
		<div class="pull-right">
			<a href="<?php echo $cancel; ?>" data-toggle="tooltip" title="<?php echo $button_cancel; ?>" class="btn btn-default"><i class="fa fa-reply"></i></a>
		</div>
		<h1><?php echo $heading_title; ?></h1>
		
		<ul class="breadcrumb">
			<?php foreach ($breadcrumbs as $breadcrumb) { ?>
				<li>
					<a href="<?php echo $breadcrumb['href']; ?>"><?php echo $breadcrumb['text']; ?></a>
				</li>
			<?php } ?>
		</ul>
		</div>
	</div>
	
	
	<div class="container-fluid">
		<?php if ($error_warning) { ?>
			<div class="alert alert-danger"><i class="fa fa-exclamation-circle"></i> <?php echo $error_warning; ?>
				<button type="button" class="close" data-dismiss="alert">&times;</button>
			</div>
		<?php } ?>
		
		<div class="panel panel-default">
			<div class="panel-heading">
				<h3 class="panel-title"><i class="fa fa-pencil"></i> <?php echo $text_edit; ?></h3>
			</div>

			<div class="panel-body">
				<ul class="nav nav-tabs">
					<li class="active">
						<a href="#tab-types" data-toggle="tab" onClick="types()"><?php echo $text_tab1; ?></a>
					</li>
					<li>
						<a href="#tab-breeds" data-toggle="tab" onClick="breeds()"><?php echo $text_tab2; ?></a>
					</li>
				</ul>
			</div>
			<div class="tab-content content_animals">
<!-- первая вкладка --> 
				<div class="tab-pane active" id="tab-types">
					<div id="div_add_types">
						<p><button id="button_add_types"><?php echo $button_add_types; ?></button></p>
					</div>
					<div id="res_types" class = "reply" style = "display:none;"></div>
					
					<div class="form-group required" id="div_name_types" style="display:none;">
						<div class="h_row">
							<label class="col-sm-2"><?php echo $text_name_types; ?></label>
							<div class="col-sm-10">
								<input type="text" id="add_name_types" value="" placeholder="<?php echo $text_name_types; ?>" class="form-control">
							</div>
						</div>
						<div class="h_row">
							<label class="col-sm-2"><?php echo $text_gender_flag; ?></label>
							<div class="col-sm-10">
								<input type="checkbox" id="add_gender_flag" value="" placeholder="<?php echo $text_gender_flag; ?>" class="form-control">
							</div>
						</div>
						<div id="buttons_add_types">
							<button class="btn btn-primary reset"><i class="fa fa-reply"></i></button>
							<button class="btn btn-primary" id="save_types"><i class="fa fa-save"></i></button>
						</div>
						
					</div>
					
					<hr/>
					<div id="list_types"></div>
				</div>
<!-- /первая вкладка -->  

<!-- вторая вкладка -->
				<div class="tab-pane" id="tab-breeds">
					<div id="div_add_breeds">
						<p><button id="button_add_breeds"><?php echo $button_add_breeds; ?></button></p>
					</div>
					
					<div id="res_breeds" class = "reply" style = "display:none;"></div>
					
					<div class="form-group required" id="div_name_breeds" style="display:none;">
						<div class="h_row">
							<label class="col-sm-2"><?php echo $text_name_types; ?></label>
							<div class="col-sm-10" id="form_breeds"></div>
						</div>
						<div class="h_row">
							<label class="col-sm-2"><?php echo $text_name_breeds; ?></label>
							<div class="col-sm-10">
								<input type="text" id="add_name_breeds" value="" placeholder="<?php echo $text_name_breeds; ?>" class="form-control">
							</div>
						</div>
						<div id="buttons_add_types">
							<button class="btn btn-primary reset"><i class="fa fa-reply"></i></button>
							<button class="btn btn-primary" id="save_breeds"><i class="fa fa-save"></i></button>
						</div>
						
					</div>
					
					<hr/>
					<div id="pagin">
						<div class="col-sm-8" id="bloc-pagin"></div>
						<div class="col-sm-4" id="bloc-limit">
							<label><?php echo $text_limit; ?></label>
							<input type="number" id="limit" value="20" min="1" onchange="pag_limit()">
						</div>
					</div>
					<div id="list_breeds"></div>
					
				</div>
<!-- /вторая вкладка -->  
			</div>
		</div>
	</div>
</div>
<script>
var res_pagin = 0;
pagination();
var limit = 20;

function pag_limit(){
	limit = $('#limit').val();
	res_pagin = 0;
	pagination();
	all_breeds();
	
}


function pagination(){

	let count_res_id = <?php echo $count_breeds; ?>;
	let all_page = Math.ceil(Number(<?php echo $count_breeds; ?>) / limit);
	let pag = '<center>';
				let pplus = limit * (Number(res_pagin)+1);
				pag += '<span  class="pagination_button">'
				if(res_pagin > 0){	pag += '<a onclick="res_pagin_minus()"><</a>';}
				pag += '</span>';
				pag += '<span>'+ (Number(res_pagin)+1) +'/'+all_page+'</span>';
				pag += '<span  class="pagination_button">'
				if(count_res_id > pplus) pag += '<a onclick="res_pagin_plus()">></a>';
				pag += '</span>';
				pag += '</center>';
				
				$('#bloc-pagin').html(pag);
}
function res_pagin_minus(){
	res_pagin--;
	all_breeds();
	pagination();
}


function res_pagin_plus(){
	res_pagin++;
	all_breeds();
	pagination();
}


</script>
<script> //types
all_types();

function types(){
	$('button').show();
	all_types();
	reset();
}


function all_types(){
	$.ajax({
		url: 'index.php?route=module/animals/all_types&token=<?php echo $token; ?>',
		type: 'post',
		dataType: 'json',
				success: function(json) {
					
					let str = '';
					json.forEach(function(elem) {
						if (elem['gender_flag'] == 1){
							cheked_gender_flag = '<i class="fa fa-check-square-o" aria-hidden="true"></i>';
						} else{
							cheked_gender_flag = '<i class="fa fa-square-o" aria-hidden="true"></i>';
						}
						
						
						str += '<div class="zebra" id="types_'+elem['id_types']+'">';
						str += '<div class="col-xs-10 col-sm-10 col-md-10">';
						str += '<p><b><?php echo $text_name_types; ?>:</b>'+elem['name']+'</p>';
						str += '<p><b><?php echo $text_gender_flag; ?>:</b>'+cheked_gender_flag+'</p>';
						str += '</div>';
						str += '<div class="col-xs-2 col-sm-2 col-md-2">';
						str += '<span><button class="btn btn-primary" onclick="upload_types('+elem['id_types']+')"><i class="fa fa-pencil"></i></buttton></span>';
						str += '<span><button class="btn btn-danger" onclick="dell_types('+elem['id_types']+')"><i class="fa fa-trash-o"></i></button></span>';
						str += '</div>';
					
						str += '</div>';
					});
					$('#list_types').html(str);
					pagination();
					
					
				}
	});
	$('button').show();
}


$('#button_add_types').on('click', function () {
	$('#div_name_types').css('display','block');
	$('#div_add_types').css('display','none');
	$('#buttons_add_types').css('display','block');
});
$('.reset').on('click', function () {
	reset();
});

function upload_types(id_types){
$('button').hide();
	$.ajax({
		url: 'index.php?route=module/animals/upload_types&token=<?php echo $token; ?>',
		type: 'post',
		data: {id_types}, 
		dataType: 'json',
				success: function(json) {
									
					let str = '';
					
						if (json['gender_flag'] == 1){
							cheked_gender_flag = 'checked';
						} else{
							cheked_gender_flag = '';
						}
						
						str += '<div class="col-xs-10 col-sm-10 col-md-10">';
						str += '<p><b><?php echo $text_name_types; ?>:</b>';
						str += '<input type="text" id="upload_name_types_'+json['id_types']+'" value="'+json['name']+'" placeholder="<?php echo $text_name_types; ?>" class="form-control"></p>';
						str += '<p><b><?php echo $text_gender_flag; ?>:</b>';
						str += '<input type="checkbox" id="upload_gender_flag_'+json['id_types']+'" '+cheked_gender_flag+' class="form-control"></p>';
						str += '</div>';
						str += '<div class="col-xs-2 col-sm-2 col-md-2">';
						str += '<span><button class="btn btn-primary" onclick="upload_types_yes('+json['id_types']+')"><i class="fa fa-save"></i></buttton></span>';
						str += '<span><button class="btn btn-danger" onclick="all_types()"><i class="fa fa-reply"></i></button></span>';
						str += '</div>';
					
						
					
					$('#types_'+json['id_types']).html(str);	
					
				}
	});


}

function upload_types_yes(id_types){
	let name_types = $('#upload_name_types_'+id_types).val();
	let gender_flag = $('#upload_gender_flag_'+id_types).prop('checked');
	$('button').hide();
	
	$.ajax({
		url: 'index.php?route=module/animals/upload_types_yes&token=<?php echo $token; ?>',
		type: 'post',
		cache: false,
		timeout: 5000,
		data: {name_types, gender_flag, id_types},
		dataType: 'json',
	
				success: function(json) {
					if (json == 1){
						all_types();
						
						$('#res_types').css('display','block');
						$('#res_types').html('<?php echo $text_upload_types_ok; ?>');
						setTimeout(function() {	
								
								$('button').show();
								$('#res_types').html('');
								$('#res_types').css('display','none');
								
							}, 3000);
					} else {
						all_types();
						
						$('#res_types').css('display','block');
						$('#res_types').html('<?php echo $text_add_types_off; ?>');
						setTimeout(function() {	
								
								$('button').show();
								$('#res_types').html('');
								$('#res_types').css('display','none');
								
							}, 3000);
					}
				},
				error: function(xhr, status, error) {
					all_types();
						
					$('#res_types').css('display','block');
					$('#res_types').html('<?php echo $text_add_types_off; ?>');
					setTimeout(function() {	
							
							$('button').show();
							$('#res_types').html('');
							$('#res_types').css('display','none');
							
						}, 3000);
				}
	});

	
	
}


function reset(){
	$('#div_name_types').css('display','none');
	$('#div_add_types').css('display','block');
	$('#add_name_types').val('');
	$('#add_gender_flag').prop('checked', false);
	
	$('#div_name_breeds').css('display','none');
	$('#div_add_breeds').css('display','block');
	$('#button_add_breeds').css('display','block');
	$('#add_name_breeds').val('');
	
}

function dell_types(id_types){
	$('button').hide();
	$.ajax({
		url: 'index.php?route=module/animals/dell_types&token=<?php echo $token; ?>',
		type: 'post',
		cache: false,
		timeout: 5000,
		data: {id_types},
		dataType: 'json',
				success: function(json) {
					if (json == 1){
						
						$('#res_types').css('display','block');
						$('#res_types').html('<?php echo $text_dell_types_ok; ?>');
						setTimeout(function() {	
								$('#res_types').html('');
								$('#res_types').css('display','none');
								all_types();
								$('button').show();
								
							}, 3000);
					} else if (json == 100){
						
						$('#res_types').css('display','block');
						$('#res_types').html('<?php echo $text_dell_types_off; ?>');
						setTimeout(function() {	
								$('#res_types').html('');
								$('#res_types').css('display','none');
								$('button').show();
								
							}, 3000);
					} else {
						
						$('#res_types').css('display','block');
						$('#res_types').html('<?php echo $text_add_types_off; ?>');
						setTimeout(function() {	
								$('#res_types').html('');
								$('#res_types').css('display','none');
								$('button').show();
								
							}, 3000);
					}
				},
				error: function(xhr, status, error) {
					all_types();
						
					$('#res_types').css('display','block');
					$('#res_types').html('<?php echo $text_add_types_off; ?>');
					setTimeout(function() {	
							
							$('button').show();
							$('#res_types').html('');
							$('#res_types').css('display','none');
							
						}, 3000);
				}
	});

}



$('#save_types').on('click', function () {
	
	let name_types = $('#add_name_types').val();
	let gender_flag = $('#add_gender_flag').prop('checked');
	$('#buttons_add_types').css('display','none');

	$.ajax({
		url: 'index.php?route=module/animals/add_types&token=<?php echo $token; ?>',
		type: 'post',
		cache: false,
		timeout: 5000,
		data: {name_types, gender_flag},
		dataType: 'json',
	
				success: function(json) {
					if (json == 1){
						all_types();
						reset();
						$('#res_types').css('display','block');
						$('#res_types').html('<?php echo $text_add_types_ok; ?>');
						setTimeout(function() {	
								$('#res_types').html('');
								$('#res_types').css('display','none');
								
							}, 3000);
					} else {
						reset();
						$('#res_types').css('display','block');
						$('#res_types').html('<?php echo $text_add_types_off; ?>');
						setTimeout(function() {	
								$('#res_types').html('');
								$('#res_types').css('display','none');
								
							}, 3000);
					}
				},
				error: function(xhr, status, error) {
					all_types();
						
					$('#res_types').css('display','block');
					$('#res_types').html('<?php echo $text_add_types_off; ?>');
					setTimeout(function() {	
							
							$('button').show();
							$('#res_types').html('');
							$('#res_types').css('display','none');
							
						}, 3000);
				}	
	});


});


</script>

<script> //breeds

function breeds(){
	$('button').show();
	select_types();
	all_breeds();
	reset();
}

function all_breeds(){
	$.ajax({
		url: 'index.php?route=module/animals/all_breeds&token=<?php echo $token; ?>',
		type: 'post',
		data: {res_pagin, limit},
		dataType: 'json',
				success: function(json) {
					let num = json[0]['id_types'];
					let str = '';
					json.forEach(function(elem) {
						if (num != elem['id_types']) {
							str += '<div class="indent row"></div>';
							num = elem['id_types'];
						}	
						str += '<div class="zebra" id="breeds_'+elem['id_breeds']+'">';
						str += '<div class="col-xs-10 col-sm-10 col-md-10">';
						str += '<p><b><?php echo $text_name_types; ?>:</b>'+elem['name_t']+'</p>';
						str += '<p><b><?php echo $text_name_breeds; ?>:</b>'+elem['name_b']+'</p>';
						str += '</div>';
						str += '<div class="col-xs-2 col-sm-2 col-md-2">';
						str += '<span><button class="btn btn-primary" onclick="upload_breeds('+elem['id_breeds']+')"><i class="fa fa-pencil"></i></buttton></span>';
						str += '<span><button class="btn btn-danger" onclick="dell_breeds('+elem['id_breeds']+')"><i class="fa fa-trash-o"></i></button></span>';
						str += '</div>';
					
						str += '</div>';
					});
					$('#list_breeds').html(str);	
					
					
				}
	});
}

function upload_breeds(id_breeds){
$('button').hide();
	$.ajax({
		url: 'index.php?route=module/animals/upload_breeds&token=<?php echo $token; ?>',
		type: 'post',
		data: {id_breeds}, 
		dataType: 'json',
				success: function(json) {
										
					let select = '<select id="select_types_'+json['breeds']['id_breeds']+'">';

					json['select'].forEach(function(elem) {
						
						if (elem['id_types'] == json['breeds']['id_types']){
							selected = 'selected';
						} else {
							selected = '';
						}
						
						select += '<option value="'+elem['id_types']+'" '+selected+'>'+elem['name']+'</option>';
						
					});
					select += '</select>';
					
					
					let str = '';
	
					str += '<div class="col-xs-10 col-sm-10 col-md-10">';
					str += '<p><b><?php echo $text_name_types; ?>:</b>';
					str += select + '</p>';
					str += '<p><b><?php echo $text_name_breeds; ?>:</b>';
					str += '<input type="text" id="upload_name_breeds_'+json['breeds']['id_breeds']+'" value="'+json['breeds']['name']+'" placeholder="<?php echo $text_name_breeds; ?>" class="form-control"></p>';
					str += '</div>';
					str += '<div class="col-xs-2 col-sm-2 col-md-2">';
					str += '<span><button class="btn btn-primary" onclick="upload_breeds_yes('+json['breeds']['id_breeds']+')"><i class="fa fa-save"></i></button></span>';
					str += '<span><button class="btn btn-danger" onclick="all_breeds()"><i class="fa fa-reply"></i></button></span>';
					str += '</div>';
					
						
					
					$('#breeds_'+json['breeds']['id_breeds']).html(str);	
					
				}
	});


}
function upload_breeds_yes(id_breeds){
	let id_types = $('#select_types_'+id_breeds).val();
	let name_breeds = $('#upload_name_breeds_'+id_breeds).val();
	$('button').hide();

	
	$.ajax({
		url: 'index.php?route=module/animals/upload_breeds_yes&token=<?php echo $token; ?>',
		type: 'post',
		cache: false,
		timeout: 5000,
		data: {name_breeds, id_breeds, id_types},
		dataType: 'json',
	
				success: function(json) {
					if (json == 1){
						all_breeds();
						
						$('#res_breeds').css('display','block');
						$('#res_breeds').html('<?php echo $text_upload_breeds_ok; ?>');
						setTimeout(function() {	
								
								$('button').show();
								$('#res_breeds').html('');
								$('#res_breeds').css('display','none');
								
							}, 3000);
					} else {
						all_breeds();
						
						$('#res_breeds').css('display','block');
						$('#res_breeds').html('<?php echo $text_add_types_off; ?>');
						setTimeout(function() {	
								
								$('button').show();
								$('#res_breeds').html('');
								$('#res_breeds').css('display','none');
								
							}, 3000);
					}
				},
				error: function(xhr, status, error) {
					all_breeds();
						
					$('#res_breeds').css('display','block');
					$('#res_breeds').html('<?php echo $text_add_types_off; ?>');
					setTimeout(function() {	
							
							$('button').show();
							$('#res_breeds').html('');
							$('#res_breeds').css('display','none');
							
						}, 3000);
				}	
				
	});

	
	
}
function select_types(){
	$.ajax({
		url: 'index.php?route=module/animals/select_types&token=<?php echo $token; ?>',
		type: 'post',
		dataType: 'json',
				success: function(json) {
					
					let str = '<select id="select_types">';

					json.forEach(function(elem) {
						
						str += '<option value="'+elem['id_types']+'">'+elem['name']+'</option>';
						
					});
					str += '</select>';
					$('#form_breeds').html(str);	
					
					
				}
	});
	
}

$('#button_add_breeds').on('click', function () {
	$('#div_name_breeds').css('display','block');
	$('#div_add_breeds').css('display','none');
	$('#button_add_breeds').css('display','none');
	$('#save_breeds').css('display','none');
	
	$.ajax({
		url: 'index.php?route=module/animals/select_count&token=<?php echo $token; ?>',
		type: 'post',
		dataType: 'json',
				success: function(json) {
					
					if (json['count'] > 0){
						$('#save_breeds').css('display','inline-block');					
					}
				}
	});
	
	
});

$('#save_breeds').on('click', function () {
	
	let id_types = $('#select_types').val();
	let name_breeds = $('#add_name_breeds').val();
	$('#buttons_add_breeds').css('display','none');

	$.ajax({
		url: 'index.php?route=module/animals/add_breeds&token=<?php echo $token; ?>',
		type: 'post',
		cache: false,
		timeout: 5000,
		data: {id_types, name_breeds},
		dataType: 'json',
	
				success: function(json) {
					if (json == 1){
						all_breeds();
						reset();
						$('#res_breeds').css('display','block');
						$('#res_breeds').html('<?php echo $text_add_breeds_ok; ?>');
						setTimeout(function() {	
								$('#res_breeds').html('');
								$('#res_breeds').css('display','none');
								
							}, 3000);
					} else {
						reset();
						$('#res_breeds').css('display','block');
						$('#res_breeds').html('<?php echo $text_add_types_off; ?>');
						setTimeout(function() {	
								$('#res_breeds').html('');
								$('#res_breeds').css('display','none');
								
							}, 3000);
					}
				},
				error: function(xhr, status, error) {
					all_breeds();
						
					$('#res_breeds').css('display','block');
					$('#res_breeds').html('<?php echo $text_add_types_off; ?>');
					setTimeout(function() {	
							
							$('button').show();
							$('#res_breeds').html('');
							$('#res_breeds').css('display','none');
							
						}, 3000);
				}	
	});


});

function dell_breeds(id_breeds){
	$('button').hide();
	$.ajax({
		url: 'index.php?route=module/animals/dell_breeds&token=<?php echo $token; ?>',
		type: 'post',
		cache: false,
		timeout: 5000,
		data: {id_breeds},
		dataType: 'json',
				success: function(json) {
					
					if (json == 1){
						
						$('#res_breeds').css('display','block');
						$('#res_breeds').html('<?php echo $text_dell_breeds_ok; ?>');
						setTimeout(function() {	
								$('#res_breeds').html('');
								$('#res_breeds').css('display','none');
								all_breeds();
								$('button').show();
								
							}, 3000);
					} else if (json == 100){
						
						$('#res_breeds').css('display','block');
						$('#res_breeds').html('<?php echo $text_dell_breeds_off; ?>');
						setTimeout(function() {	
								$('#res_breeds').html('');
								$('#res_breeds').css('display','none');
								$('button').show();
								
							}, 3000);
					} else {
						
						$('#res_breeds').css('display','block');
						$('#res_breeds').html('<?php echo $text_add_types_off; ?>');
						setTimeout(function() {	
								$('#res_breeds').html('');
								$('#res_breeds').css('display','none');
								$('button').show();
								
							}, 3000);
					}
				},
				error: function(xhr, status, error) {
					all_breeds();
						
					$('#res_breeds').css('display','block');
					$('#res_breeds').html('<?php echo $text_add_types_off; ?>');
					setTimeout(function() {	
							
							$('button').show();
							$('#res_breeds').html('');
							$('#res_breeds').css('display','none');
							
						}, 3000);
				}
	});

}
</script>

<?php echo $footer; ?>