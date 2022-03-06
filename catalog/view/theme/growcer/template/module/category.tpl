<div class="module-sidebar"	>
	<div class="panel-heading"><?php echo $heading_title; ?> <span class="pull_right"><i class="icn-arrow"></i></span></div>
	<div class="panel-list u-vmenu">
		<ul>
			  <?php foreach ($categories as $category_level_1) { ?>
				<li>
					<?php 
						$child_flag = false;
						$menu_state = 'data-option="off"';
						$ul_state = '';
						$menu_class = '';
						if($category_level_1['category_id']==$category_id){
							$menu_state = 'data-option="on"';
							$ul_state = 'style="display:block"';
							$menu_class = 'class="active"';
						}
						if(count($category_level_1['children'])>0){
							$child_flag = true;
						}else{
							$menu_state = '';
							$ul_state = '';
						}
					?>
					<a href="<?php echo $category_level_1['href']; ?>" <?php echo $menu_state.' '.$menu_class; ?>><?php echo $category_level_1['name']; ?><?php if($child_flag){ echo '<span class="parrot_arrow"></span>'; }	?></a>
					<?php 
						if($child_flag){
							?>
							<ul <?php echo $ul_state; ?>>
								<?php 
								foreach($category_level_1['children'] AS $category_level_2){
									?>
									<li>
										<?php 
											$child_child_flag = false;
											$menu_state = 'data-option="off"';
											$ul_state = '';
											$menu_class = '';
											if($category_level_2['category_id']==$child_id){
												$menu_state = 'data-option="on"';
												$ul_state = 'style="display:block"';
												$menu_class = 'class="active-sub"';
											}
											if(count($category_level_2['children'])>0){
												$child_child_flag = true;
											}else{
												$menu_state = '';
												$ul_state = '';
											}
										?>
										<a href="<?php echo $category_level_2['href']; ?>" <?php echo $menu_state.' '.$menu_class; ?>><?php echo $category_level_2['name']; ?><?php if($child_child_flag){ echo '<span class="parrot_arrow"></span>'; } ?></a>
										<?php 
											if($child_child_flag){
												?>
												<ul <?php echo $ul_state; ?>>
													<?php 
													foreach($category_level_2['children'] AS $category_level_3){
														?>
														<li>
															<?php 
																$menu_class = '';
																if($category_level_3['category_id']==$child_child_id){
																	$menu_class = 'class="active-sub-sub"';
																}
															?>
															<a href="<?php echo $category_level_3['href']; ?>" <?php echo $menu_class; ?>><?php echo $category_level_3['name']; ?></a>
															
														</li>
														<?php
													} ?>
												</ul>
												<?php 
											}
										?>
									</li>
									<?php
								} ?>
							</ul>
							<?php 
						}
					?>
				</li>
			  <?php } ?>
		</ul>
	</div>
</div>