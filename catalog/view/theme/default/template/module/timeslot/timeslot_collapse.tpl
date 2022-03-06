<p class="description"><?php echo $text_select_date; ?></p>  
<div class="gap"></div>
<form class="intervals siteForm form-horizontal">
	<fieldset>
		<!--div class="radio-input form-group"-->
		<div class="radio-input">
			<input type="hidden" name='last_id' id="last_id" value="<?php echo $Intervals['last_id'][0]?>" />
			<input type="hidden" name='start_id' id="start_id" value="<?php 
				if(isset($Intervals['start_id'][0])){
					echo $Intervals['start_id'][0];
				}
			?>" />
			
			<?php //echo '<pre>';print_r($Intervals);echo '</pre>'; ?>
			<select name="delivery_slot_time" class="form-control" id='slots' onchange="selectDate(this.value)">  
				<option><?php echo $text_select_date_option; ?></option>
				<?php if(is_array($Intervals)) {
                    foreach($Intervals as $val){ 
                            /* echo '<pre>';
                            print_r($val); */
                            if(!is_array($val)) {
                            
                            $exp = explode(" ",$val); 
                                if($exp[0]!="") { 
                                ?>
                                    <option value="<?php echo $exp[0]?>"><?php echo $exp[0]?></option> 
                                <?php 
                                } 
                            }
                        }
                }
				?>
			</select> 
			<div id="error_max_slot"><p><br><?php echo $text_select_date_time_full; ?></p></div>
			<div id="timess"></div>
		</div>
		<!--div class="form-group"-->
		<div class="gap"></div>
		<div>
			<input type="button" value="<?php echo $text_continue_text; ?>" id="button-interval" data-loading-text="<?php echo $text_loading_text; ?>" class="btn btn-primary themeBtn">
		</div>
	</fieldset>
</form>
<script>
$("#error_max_slot").css("display","none");
$("#button-interval").css("display","none");
function selectDate(times){
	var dat = $("#last_id").val();
	var start = $("#start_id").val();
	var msg;
	msg = '<?php echo $error_select_time;?>';
	$.ajax({
		url: 'index.php?route=module/timeslot/timeslot/getDates/',
		type: 'post',
		data: { SearchTime: times,last_id:dat, start_id:start },
		dataType: 'html',
		beforeSend: function() {
			//	$('#recurring-description').html('');
		},
		success: function(result) {
			if(result=="false"){
			    $('#slots').after('<div class="error-slot" style="margin-top:10px;">'+msg+'</div>');
				$("#timess").css("display","none");           
				$("#button-interval").css("display","none");
			} else{   
				$('.error-slot').remove();
				$("#timess").css("display","block");     
				$("#timess").html(result);
				$("#button-interval").css("display","block");
			}
		}
	});
}
</script>       
<!-----------End--------------------->