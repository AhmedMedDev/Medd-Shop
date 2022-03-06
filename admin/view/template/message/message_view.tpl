<div class="msg_container">
	<h2><?php echo $customer_name ?></h2>
		<?php if($messages) { ?>
			<div class="allmessages">
				<?php 
				foreach($messages as $message) {
					$display_name = $add_class = '';
					if($message['sender']=='user'){ 
						$display_name = $text_administrator;
						$add_class = ' replied';
					}else if($message['sender']=='customer') { 
						$display_name = $message['name'];
					}
					?>
					<div class="listrepeated <?php echo $add_class; ?>">
						<aside class="grid_1">
							<figure class="avtar"><?php echo substr($display_name, 0, 1); ?></figure>
						</aside>
						<aside class="grid_2">
							<h3 class="name"><?php echo $display_name;	?> </h3>
							<span class="datetxt"><?php echo $message['date_added']; ?></span>
							<div class="msg_txt">
								<p><?php echo nl2br($message['message']); ?></p>
							</div>    
						</aside>
					</div>				
				<?php 
				} 
				?>				
			</div>				
			<?php
		}else{ ?>
			<div class="text-center"><?php echo $text_no_message ?></div>
		<?php } ?>		
</div>
<script>
$('.alert_messages').html(' <?php echo $total_unread ?>');
</script>