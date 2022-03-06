<?php echo $header; ?>
 <!--body start here-->
  <div id="body">
	<div class="breadcrumb">
		<div class="fix-container">
		  <ul>
			<?php 
				$iteration 	 = 1;
				$bread_count = count($breadcrumbs); 
				foreach ($breadcrumbs as $breadcrumb) { 
					if($iteration<$bread_count){ ?>
					<li>
						<a href="<?php echo $breadcrumb['href']; ?>"><?php echo $breadcrumb['text']; ?></a>
					</li>
					<?php }else{ ?>
					<li>
						<?php echo $breadcrumb['text']; ?>
					</li>
					<?php }
					$iteration++;
				} 
			?>
		  </ul>
		</div>
	</div>
    <div class="page-head clearfix">
      <div class="fix-container">
        <div class="row">
			
	    <?php echo $column_left; ?>
		<?php if ($column_left && $column_right) { ?>
		<?php $class = 'col-sm-6'; ?>
		<?php } elseif ($column_left || $column_right) { ?>
		<?php $class = 'col-sm-9'; ?>
		<?php } else { ?>
		<?php $class = 'col-sm-12'; ?>
		<?php } ?>
		<div id="content" class="<?php echo $class; ?>"><?php echo $content_top; ?>
		
          <div class="col-md-12">
            <div class="cms">
              <h2><?php echo $heading_title; ?></h2>
				<div class="sitemap">   
					<div class="row">
						<?php 
						$total_primary_categories = sizeof($categories) ;
						$col_start = '
						<div class="col-md-4">
						  <ul>';
					    $col_val1 = '';
					    $col_val2 = '';
						$cat_item_count = 0; 
						$per_col_display = 5;
						foreach ($categories as $category_1) { 
							
								if($total_primary_categories>=$per_col_display && $cat_item_count>=$per_col_display){
									$col_val2.='<li><a href="'.$category_1['href'].'">'.$category_1['name'].'</a>'; 
									  if ($category_1['children']) { 
									  $col_val2.='<ul>';
										foreach ($category_1['children'] as $category_2) {
										$col_val2.='<li><a href="'.$category_2['href'].'">'.$category_2['name'].'</a>';
										  if ($category_2['children']) { 
										  $col_val2.='<ul>';
											foreach ($category_2['children'] as $category_3) { 
											$col_val2.='<li><a href="'.$category_3['href'].'">'.$category_3['name'].'</a></li>';
											} 
										  $col_val2.='</ul>';
										  } 
										$col_val2.='</li>';
										} 
									  $col_val2.='</ul>';
									  } 
									  $col_val2.='</li>';
								}else{
									$col_val1.='<li><a href="'.$category_1['href'].'">'.$category_1['name'].'</a>';
									  if ($category_1['children']) { 
									  $col_val1.='<ul>';
										foreach ($category_1['children'] as $category_2) {
										$col_val1.='<li><a href="'.$category_2['href'].'">'.$category_2['name'].'</a>';
										  if ($category_2['children']) {
										  $col_val1.='<ul>';
											foreach ($category_2['children'] as $category_3) {
											$col_val1.='<li><a href="'.$category_3['href'].'">'.$category_3['name'].'</a></li>';
											}
										  $col_val1.='</ul>';
										  } 
										$col_val1.='</li>';
										} 
									  $col_val1.='</ul>';
									  } 
									  $col_val1.='</li>';
								}
								$cat_item_count++;
							
							} 
							
						$col_end='
						 </ul>
						</div>';
						
						echo $col_start.$col_val1.$col_end;
						echo $col_start.$col_val2.$col_end;
						
						?>
						
						<div class="col-md-4">
						  <ul>
							<li><a href="<?php echo $special; ?>"><?php echo $text_special; ?></a></li>
							<li><a href="<?php echo $account; ?>"><?php echo $text_account; ?></a>
							  <ul>
								<li><a href="<?php echo $edit; ?>"><?php echo $text_edit; ?></a></li>
								<li><a href="<?php echo $password; ?>"><?php echo $text_password; ?></a></li>
								<li><a href="<?php echo $address; ?>"><?php echo $text_address; ?></a></li>
								<li><a href="<?php echo $history; ?>"><?php echo $text_history; ?></a></li>
								<li><a href="<?php echo $download; ?>"><?php echo $text_download; ?></a></li>
							  </ul>
							</li>
							<li><a href="<?php echo $cart; ?>"><?php echo $text_cart; ?></a></li>
							<li><a href="<?php echo $checkout; ?>"><?php echo $text_checkout; ?></a></li>
							<li><a href="<?php echo $search; ?>"><?php echo $text_search; ?></a></li>
							<li><?php echo $text_information; ?>
							  <ul>
								<?php foreach ($informations as $information) { ?>
								<li><a href="<?php echo $information['href']; ?>"><?php echo $information['title']; ?></a></li>
								<?php } ?>
								<li><a href="<?php echo $contact; ?>"><?php echo $text_contact; ?></a></li>
							  </ul>
							</li>
						  </ul>
						</div>
						<?php echo $content_bottom; ?>
					</div> 
				</div>
            </div>
          </div>
		  
		  </div><!--content-->
		  <?php echo $column_right; ?>
        </div>
      </div>
    </div>
  </div>
  <!--body end here--> 
<?php echo $footer; ?>