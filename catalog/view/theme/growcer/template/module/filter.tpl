<?php //echo $heading_title; ?>
<?php 

$filterCount = 0;

foreach ($filter_groups as $filter_group) { $filterCount++; ?>
<div class="module-sidebar filters">
	<div class="panel-heading">
		<?php echo $filter_group['name']; ?>
		<span class="pull_right"><i class="icn-arrow"></i></span>
	</div>
	
	<div class="panel-list">
		<ul id="filter-group<?php echo $filter_group['filter_group_id']; ?>" class="filterList">
		<?php foreach ($filter_group['filter'] as $filter) { ?>
			<li>
				<?php if (in_array($filter['filter_id'], $filter_category)) { ?>
				<a href="javascript:void(0)" class="active">
				<input type="checkbox" name="filter[]" value="<?php echo $filter['filter_id']; ?>" checked="checked" />
				<?php echo $filter['name']; ?>
				<?php } else { ?>
				<a href="javascript:void(0)">
				<input type="checkbox" name="filter[]" value="<?php echo $filter['filter_id']; ?>" />
				<?php echo $filter['name']; ?>
				<?php } ?>
			  </a> 
			</li>
		<?php } ?>
		</ul>
	</div>	
</div>
<?php } ?>

<?php if( $filterCount>0){ ?>
<div class="filter-panel-footer text-left">
	<button type="button" id="button-filter" class="theme-Btn btn btn-primary"><?php echo $button_filter; ?></button>
</div>
<?php } ?>

<script type="text/javascript"><!--
$('ul.filterList li a').click(function(){
	var n = $(this).find("input[type=checkbox]").prop('checked');
	if(n){
		$(this).find("input[type=checkbox]").prop('checked', false);
		$(this).removeClass('active');
	}else{
		$(this).find("input[type=checkbox]").prop('checked', true);
		$(this).addClass('active');
	}
});
$('#button-filter').on('click', function() {
	filter = [];
	$('input[name^=\'filter\']:checked').each(function(element) {
		filter.push(this.value);
	});
	location = '<?php echo $action; ?>&filter=' + filter.join(',');
});
$('body').on('click', '.filters .panel-heading.collapse span', function(){
	$('.filter-panel-footer').show('slow');
});
$('body').on('click', '.filters .panel-heading.expand span', function(){
	$('.filter-panel-footer').hide('slow');
});
//--></script>