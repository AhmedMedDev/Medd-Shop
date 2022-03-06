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
	<?php if (isset($success) && $success!='') { ?>
	  <div class="row">
		<div class="fix-container">
			<div class="alert alert-success"><i class="fa fa-check-circle"></i> <?php echo $success; ?>
			<button type="button" class="close" data-dismiss="alert"></button>
			</div>
			<div class="alert-after"></div>
		</div>
	  </div>
	  <?php } ?>
	<?php if ($error_warning) { ?>
		<div class="alert alert-danger"><i class="fa fa-exclamation-circle"></i> <?php echo $error_warning; ?>
		<button type="button" class="close" data-dismiss="alert"></button>
		</div>
			<div class="alert-after"></div>
	<?php } ?>
	<div class="dash-pages">
		<div class="fix-container">
			<div class="row">
			  <div class="col-md-12">
			  &nbsp;
			  <?php echo $content_top; ?>
			  </div>
			</div>
			<div class="row">
				<div class="col-md-3 column">
					<div class="left-panel">
						<?php echo $account_sidebar; ?>
					</div>
				</div>
				<div class="col-md-9 column">
							<div class="heading"><?php echo $heading_title; ?></div>
							<div class="gap"></div>
							<h3><?php echo $text_address_book; ?></h3>
							<div class="gap"></div>
							
							<div class="address-bar">
							<ul>
							<?php if ($addresses) { ?>
							<?php foreach ($addresses as $result) { ?>
								<li>
								  <?php echo $result['address']; ?>
								  <div class="btn-action"> <a href="<?php echo $result['update']; ?>" title="<?php echo $button_edit; ?>" class="action"><i class="icon">
									<svg version="1.1"  xmlns="http://www.w3.org/2000/svg" xmlns:xlink="http://www.w3.org/1999/xlink" x="0px" y="0px"
					 width="528.899px" height="528.899px" viewBox="0 0 528.899 528.899" style="enable-background:new 0 0 528.899 528.899;"
					 xml:space="preserve">
									  <g>
										<path d="M328.883,89.125l107.59,107.589l-272.34,272.34L56.604,361.465L328.883,89.125z M518.113,63.177l-47.981-47.981
						c-18.543-18.543-48.653-18.543-67.259,0l-45.961,45.961l107.59,107.59l53.611-53.611
						C532.495,100.753,532.495,77.559,518.113,63.177z M0.3,512.69c-1.958,8.812,5.998,16.708,14.811,14.565l119.891-29.069
						L27.473,390.597L0.3,512.69z"/>
									  </g>
									</svg>
									</i> </a> <a href="<?php echo $result['delete']; ?>" title="<?php echo $button_delete; ?>" class="action btn btn-danger"><i class="icon">
									<svg version="1.1"  xmlns="http://www.w3.org/2000/svg" xmlns:xlink="http://www.w3.org/1999/xlink" x="0px" y="0px"
					 width="482.428px" height="482.429px" viewBox="0 0 482.428 482.429" style="enable-background:new 0 0 482.428 482.429;"
					 xml:space="preserve">
									  <g>
										<g>
										  <path d="M381.163,57.799h-75.094C302.323,25.316,274.686,0,241.214,0c-33.471,0-61.104,25.315-64.85,57.799h-75.098
							c-30.39,0-55.111,24.728-55.111,55.117v2.828c0,23.223,14.46,43.1,34.83,51.199v260.369c0,30.39,24.724,55.117,55.112,55.117
							h210.236c30.389,0,55.111-24.729,55.111-55.117V166.944c20.369-8.1,34.83-27.977,34.83-51.199v-2.828
							C436.274,82.527,411.551,57.799,381.163,57.799z M241.214,26.139c19.037,0,34.927,13.645,38.443,31.66h-76.879
							C206.293,39.783,222.184,26.139,241.214,26.139z M375.305,427.312c0,15.978-13,28.979-28.973,28.979H136.096
							c-15.973,0-28.973-13.002-28.973-28.979V170.861h268.182V427.312z M410.135,115.744c0,15.978-13,28.979-28.973,28.979H101.266
							c-15.973,0-28.973-13.001-28.973-28.979v-2.828c0-15.978,13-28.979,28.973-28.979h279.897c15.973,0,28.973,13.001,28.973,28.979
							V115.744z"/>
										  <path d="M171.144,422.863c7.218,0,13.069-5.853,13.069-13.068V262.641c0-7.216-5.852-13.07-13.069-13.07
							c-7.217,0-13.069,5.854-13.069,13.07v147.154C158.074,417.012,163.926,422.863,171.144,422.863z"/>
										  <path d="M241.214,422.863c7.218,0,13.07-5.853,13.07-13.068V262.641c0-7.216-5.854-13.07-13.07-13.07
							c-7.217,0-13.069,5.854-13.069,13.07v147.154C228.145,417.012,233.996,422.863,241.214,422.863z"/>
										  <path d="M311.284,422.863c7.217,0,13.068-5.853,13.068-13.068V262.641c0-7.216-5.852-13.07-13.068-13.07
							c-7.219,0-13.07,5.854-13.07,13.07v147.154C298.213,417.012,304.067,422.863,311.284,422.863z"/>
										</g>
									  </g>
									</svg>
									</i> </a></div>
								</li>
							<?php 
							}
							}
							?>
								<li class="add-new"> <a href="<?php echo $add; ?>">
								  <div class="btn-action action-wrapper"> 
									  <span  class="action"> 
									  <i class="icon ion-ios-plus-empty size-64"></i> 
									  </span> 
								  </div>
							    <?php echo $button_new_address; ?></a> 
							  </li>
							</ul>
							</div>
					<div class="gap"></div>
				</div>
			</div>
			<div class="row">
				<div class="col-md-12">
					&nbsp;
					<?php echo $content_bottom; ?>
				</div>
			</div>
		</div>
	</div>
	
</div>
<?php echo $footer; ?>