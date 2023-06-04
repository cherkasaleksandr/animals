<?php echo $header; ?>
<div class="container">
  <ul class="breadcrumb">
    <?php foreach ($breadcrumbs as $breadcrumb) { ?>
    <li><a href="<?php echo $breadcrumb['href']; ?>"><?php echo $breadcrumb['text']; ?></a></li>
    <?php } ?>
  </ul>
  <?php if ($success) { ?>
  <div class="alert alert-success"><i class="fa fa-check-circle"></i> <?php echo $success; ?></div>
  <?php } ?>
  <div class="row"><?php echo $column_left; ?>
    <?php if ($column_left && $column_right) { ?>
    <?php $class = 'col-sm-6'; ?>
    <?php } elseif ($column_left || $column_right) { ?>
    <?php $class = 'col-sm-9'; ?>
    <?php } else { ?>
    <?php $class = 'col-sm-12'; ?>
    <?php } ?>
    <div id="content" id="animals_module" class="<?php echo $class; ?>"><?php echo $content_top; ?>
		<h2><?php echo $text_all_animals; ?></h2>
		<div id="all_animals"></div>
		
		
		<h2><?php echo $text_button_add; ?></h2>
		
		<div id="animals_reply" style = "display:none;"></div>
		
		<div id="form_add_animals" style="display:none;">
		
			<div class="form-group required">
				<label class="col-sm-3 control-label" for="input-firstname"><?php echo $enter_types; ?></label>
				<div id="select_types" class="col-sm-9"><span></span></div>
			</div>
			<div class="form-group required">
				<label class="col-sm-3 control-label" for="input-firstname"><?php echo $enter_breeds; ?></label>
				<div id="select_breeds" class="col-sm-9"></div>
			</div>
			<div class="form-group required" id="div_gender" style="display:none">
				<label class="col-sm-3 control-label" for="input-firstname"><?php echo $enter_gender; ?></label>
				<div id="gender" class="col-sm-9"></div>
			</div>
			<div class="form-group required">
				<label class="col-sm-3 control-label" for="input-firstname"><?php echo $enter_age_months; ?></label>
				<div id="age_months" class="col-sm-9"></div>
			</div>
			<hr>
			<div class="form-group required">
			
				<button class="btn btn-primary" onclick="save_animals()"><i class="fa fa-save"></i></button>
				<button class="btn btn-danger" onclick="cancel()"><i class="fa fa-reply"></i></button>
			</div>
			
		
		
			
		</div>
		<button id="add_animals" onclick="add_animals()"><?php echo $text_button_add; ?></button>
	  
	  
	</div>
    <?php echo $column_right; ?></div>
</div>

<script>
let gender_flag = 0;

all_animals();

function all_animals(){
		$.ajax({
		url: 'index.php?route=account/animals/all_animals',
		type: 'post', 
		dataType: 'json',
				success: function(json) {
					
					if (json.length > 0){
					
						let str = '';
						json.forEach(function(elem) {
							str += '<div class="zebra" id="animals_'+elem['id_animals']+'">';
							str += '<div class="col-xs-10 col-sm-10 col-md-10">';
							str += '<p><span>'+elem['name_types']+' '+elem['name_breeds']+' '+elem['age_months']+' <?php echo $text_age_months; ?></span></p>';
							str += '</div>';
							str += '<div class="col-xs-2 col-sm-2 col-md-2">';
							str += '<p><span><button class="btn btn-danger" onclick="dell_animals('+elem['id_animals']+')"><i class="fa fa-trash-o"></i></button></span></p>';
							str += '</div>';
							str += '</div>';
						});
						$('#all_animals').html(str);
					} else {
						$('#all_animals').html('<?php echo $text_no_animals; ?>');
					}
				}
	});
}
function dell_animals(id_animals){
	$('#animals_'+id_animals).remove();
	$('button').hide();
		$.ajax({
			url: 'index.php?route=account/animals/dell_animals',
			type: 'post',
			data: {id_animals},
			dataType: 'json',
					success: function(json) {
						
						
						if (json == 1){
						
							$('#animals_reply').css('display','block');
							$('#animals_reply').html('<?php echo $reply_dell_ok; ?>');
							setTimeout(function() {	
									$('#animals_reply').html('');
									$('#animals_reply').css('display','none');
									all_animals();
									$('button').show();
									
								}, 3000);
						} else {
							$('#animals_reply').css('display','block');
							$('#animals_reply').html('<?php echo $reply_error; ?>');
							setTimeout(function() {	
									$('#animals_reply').html('');
									$('#animals_reply').css('display','none');	
									$('button').show();
								}, 3000);
	
						}
						
					}
		});
}
function add_animals(){
	$('#add_animals').css('display','none');
	$('#form_add_animals').css('display','block');
	
	$.ajax({
		url: 'index.php?route=account/animals/select_types',
		type: 'post', 
		dataType: 'json',
				success: function(json) {
					
					let select = '<select id="select_types_option">';
						select += '<option value="0"><?php echo $selected_types; ?></option>';

					json.forEach(function(elem) {
						
						select += '<option value="'+elem['id_types']+'" gender_flag="'+elem['gender_flag']+'">'+elem['name']+'</option>';
						
					});
					select += '</select>';

					
					$('#select_types').html(select);	
					$('#select_types_option').on('change', select_breeds);
				}
	});
	
}

function select_breeds(){
	let id_types = $('#select_types_option').val();
	let selectedOption = $("#select_types option:selected");
	gender_flag = selectedOption.attr("gender_flag");
	
	$('#div_gender').css('display','none');
	$('#gender').html('');
	$('#age_months').html('');
	
	if(id_types > 0){
		$.ajax({
			url: 'index.php?route=account/animals/select_breeds',
			type: 'post',
			data: {id_types},
			dataType: 'json',
					success: function(json) {
												
						let select = '<select id="select_breeds_option">';
							select += '<option value="0"><?php echo $selected_breeds; ?></option>';
						json.forEach(function(elem) {
							
							select += '<option value="'+elem['id_breeds']+'">'+elem['name']+'</option>';
							
						});
						select += '</select>';

						
						$('#select_breeds').html(select);
						$('#select_breeds_option').on('change', inputs);
						
					}
		});
	} else {
		$('#select_breeds').html('');
	}
}
function inputs(){
	let id_types = $('#select_types_option').val();
	let gender = '';
	if(gender_flag == 1){
		gender += '<span><input type="radio" class="gender_option" name="gender_option" checked value="1"><?php echo $gender_man; ?></span>';
		gender += '<span><input type="radio" class="gender_option" name="gender_option" value="2"><?php echo $gender_woman; ?></span>';
		$('#div_gender').css('display','block');
	}
	$('#gender').html(gender);
	let age_months = '<input type="number" id="select_age_months" name="age_months" min="1" value="1">';
	$('#age_months').html(age_months);

}

function cancel() {
	$('#add_animals').css('display','block');
	$('#form_add_animals').css('display','none');
	$('#select_types').html('');
	$('#select_breeds').html('');
	$('#gender').html('');
	$('#age_months').html('');
	
}

function save_animals() {
	let data = {};
	$('button').hide();
	data['id_types'] = $('#select_types_option').val();
	data['id_breeds'] = $('#select_breeds_option').val();
	if(gender_flag == 1) {
		data['gender'] = $('input[name="gender_option"]:checked').val();
	} else {
		data['gender'] = 0;
	}
	data['age_months'] = $('#select_age_months').val();
	
	var allFieldsHaveData = true;

	for (var key in data) {
	  if (data.hasOwnProperty(key) && (data[key] === undefined || data[key] === '')) {
		allFieldsHaveData = false;
		break;
	  }
	}

	if (allFieldsHaveData) {
	  
	  $.ajax({
			url: 'index.php?route=account/animals/save_animals',
			type: 'post',
			data: {data},
			dataType: 'json',
					success: function(json) {
						
						if (json == 1){
						
							$('#animals_reply').css('display','block');
							$('#animals_reply').html('<?php echo $reply_save_ok; ?>');
							setTimeout(function() {	
									$('#animals_reply').html('');
									$('#animals_reply').css('display','none');
									cancel();
									$('button').show();
								}, 3000);
							
							all_animals();
						} else {
							$('#animals_reply').css('display','block');
							$('#animals_reply').html('<?php echo $reply_error; ?>');
							setTimeout(function() {	
									$('#animals_reply').html('');
									$('#animals_reply').css('display','none');	
									$('button').show();
								}, 3000);
							
							
						}
						
					}
		});
	  
	  
	  
	} else {
		
		$('#animals_reply').css('display','block');
		$('#animals_reply').html('<?php echo $reply_fill; ?>');
		setTimeout(function() {	
				$('#animals_reply').html('');
				$('#animals_reply').css('display','none');	
				$('button').show();
			}, 3000);
		
	}

}

</script>



<?php echo $footer; ?>
