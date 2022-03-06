<?php echo $header; ?><?php echo $column_left; ?>
<div id="content">
  <div class="page-header">
    <div class="container-fluid">
      <div class="pull-right">
        <button type="submit" form="form-setting" data-toggle="tooltip" title="<?php echo $button_save; ?>" class="btn btn-primary"><i class="fa fa-save"></i></button>
        <a href="<?php echo $cancel; ?>" data-toggle="tooltip" title="<?php echo $button_cancel; ?>" class="btn btn-default"><i class="fa fa-reply"></i></a></div>
      <h1><?php echo $heading_title; ?></h1>
      <ul class="breadcrumb">
        <?php foreach ($breadcrumbs as $breadcrumb) { ?>
        <li><a href="<?php echo $breadcrumb['href']; ?>"><?php echo $breadcrumb['text']; ?></a></li>
        <?php } ?>
      </ul>
    </div>
  </div>
  <div class="container-fluid">
    <?php if ($error_warning) { ?>
    <div class="alert alert-danger"><i class="fa fa-exclamation-circle"></i> <?php echo $error_warning; ?>
      <button type="button" class="close" data-dismiss="alert">&times;</button>
    </div>
    <?php }

    ?>
    <?php if (isset($_GET['success'])) { ?>
    <div class="alert alert-success"><i class="fa fa-check-circle"></i> <?php echo $_GET['success']; ?>
      <button type="button" class="close" data-dismiss="alert">&times;</button>
    </div>
    <?php } ?>
    <div class="panel panel-default">
      <div class="panel-heading">
        <h3 class="panel-title"><i class="fa fa-pencil"></i> <?php //echo $text_edit; ?></h3>
      </div>
      <div class="panel-body">
        <form action="<?php echo $action; ?>" method="post" enctype="multipart/form-data" id="form-setting" class="form-horizontal">
          <ul class="nav nav-tabs">
            <li class="active"><a href="#tab-general" data-toggle="tab"><?php echo $text_ddt_settings; ?></a></li>
            <li><a href="#tab-store" data-toggle="tab"><?php echo $text_ddt; ?></a></li>

          </ul>
          <div class="tab-content">
            <div class="tab-pane active" id="tab-general">

				<!-- Date Range -->
				<div class="form-group">
                    <label class="col-sm-2 control-label" ><span data-toggle="tooltip" data-html="true" title="<?php echo $help_date_range_from?>"><?php echo $start_date; ?> </span></label>
                <div class="col-sm-10">
                    <input type="text" name="date_range_from" id="date_range_from" class="datepickertime1 form-control" value=
                           <?php if(isset($date_range_from))
                           {
                            echo $date_range_from;
                            } ?>>
                </div>
              </div>


                <div class="form-group">
                    <label class="col-sm-2 control-label" ><span data-toggle="tooltip" data-html="true" title="<?php echo $help_date_range_to?>"><?php echo $end_date; ?></span></label>
                <div class="col-sm-10">
                    <input type="text" name="date_range_to" class="datepickertime1 form-control" value=
                           <?php if(isset($date_range_to))
                           {
                            echo $date_range_to;
                            } ?>>
                </div>
              </div>

				<!-- Time Range -->
               <div class="form-group">
                <label class="col-sm-2 control-label"><span data-toggle="tooltip" title="<?php echo $help_start_time; ?>"><?php echo $Shop_start_time ?></span></label>

                <div class="col-sm-10">
                    <input type="text" class="timepicker1 form-control" id="start_time" name="<?php echo $start_time ?>" value=<?php

                           if(isset($config_start_time)){ echo $config_start_time;}?>>
                </div>

              </div>



              <div class="form-group">
                  <label class="col-sm-2 control-label" ><span data-toggle="tooltip" data-html="true" title="<?php echo $help_end_time?>"><?php echo $text_det; ?> </span></label>
                <div class="col-sm-10">
                    <input type="text" name="<?php echo $end_time ?>" id="end_time" class="timepicker1 form-control" value=
                           <?php if(isset($config_end_time))
                           {
                            echo $config_end_time;
                            } ?>>
                </div>
              </div>

              <!--<div class="form-group">

                        <label class="col-sm-2 control-label" ><?php echo $text_date_range; ?></label>

                   </div>-->
				<div class="form-group">
                	<label class="col-sm-2 control-label" ><?php echo $delivery_slot; ?></label>
					<?php //echo '<pre>';print_r($timeSlots);echo '</pre>';

					$from_time = $timeSlots['from_time'];
					$to_time = $timeSlots['to_time'];
					$get_result = count($from_time)-1;
					?>
					<div class="">
						<table class="add-slot">
						<?php
						for($i=0; $i<=$get_result; $i++){
							echo '

							<tr>
								<td><span>From</span></td>
									<td><input type="text" name="from_time[]" class="slot--timing timepicker1 form-control" value="'.$from_time[$i].'" />
								</td>
								<td>
									<span>to</span></td>
									<td><input type="text" name="to_time[]" class="slot--timing timepicker1 form-control" value="'.$to_time[$i].'" />
								</td>
								'.(($i > 0)?'
								<td>
									<a href="javascript:void(0)" class="remove-slot btn btn-info" ><i class="fa fa-minus"></i></a>
								</td>
								':'').'

							</tr>


							';
						}
						?>
						<tr>
<td></td>
<td></td>
<td></td>
<td></td>
<td><a href="javascript:void(0)" class="add_slot btn btn-info" ><i class="fa fa-plus"></i></a></td>
</tr>


						</table>
					</div>
				</div>




              <!--<div class="form-group">
                  <label class="col-sm-2 control-label" ><span data-toggle="tooltip" data-html="true" title="<?php echo $help_slot_duration?>"><?php echo $text_slot_interval_duration; ?></span></label>
                <div class="col-sm-10">
                    <input type="text" name="<?php echo $Intervals ?>" class="form-control" value=<?php if(isset($intervals))echo $intervals?>>
                </div>
              </div>

              <div class="form-group">
                  <label class="col-sm-2 control-label" ><span data-toggle="tooltip" data-html="true" title="<?php echo $help_lead_time?>"><?php echo $text_lead_time; ?></span></label>
                <div class="col-sm-10">
                    <input type="text" name="<?php echo $lead_time ?>" class="form-control" value=<?php if(isset($delivery_starts))echo $delivery_starts?>>
                </div>
              </div>     -->

			  <div class="form-group">
                  <label class="col-sm-2 control-label" ><span data-toggle="tooltip" data-html="true" title="<?php echo $help_lead_time?>"><?php echo $text_lead_time; ?></span></label>
                <div class="col-sm-10">
                    <input type="text" name="<?php echo $lead_time ?>" class="form-control" value=<?php if(isset($delivery_starts))echo $delivery_starts?>>
                </div>
              </div>

              <div class="form-group">
                  <label class="col-sm-2 control-label" ><span data-toggle="tooltip" data-html="true" title="<?php echo $help_slot_display?>"><?php echo $text_number_slot_display; ?></span></label>
                <div class="col-sm-10">
                    <input type="text" name="<?php echo $numberofslots ?>" class="form-control" value=<?php if(isset($showSlots))echo $showSlots?>>
                </div>
              </div>

              <div class="form-group">
                  <label class="col-sm-2 control-label" ><span data-toggle="tooltip" data-html="true" title="<?php echo $help_maximum_order_per_slot?>"><?php echo $text_max_order_per_slot; ?></span></label>
                <div class="col-sm-10">
                    <input type="text" name="<?php echo $order_per_slot ?>" class="form-control" value=<?php if(isset($order_slot))echo $order_slot?>>
                </div>
              </div>

              <div class="form-group">
                  <label class="col-sm-2 control-label" ><span data-toggle="tooltip" data-html="true" title="<?php echo $help_time_format?>"><?php echo $text_time_format; ?></span></label>
                <div class="col-sm-10">

                    <select class="form-control" name="time_format">
						<?php
						$selected12 = $selected24 = '';
						if($time_format=="12 ( AM/PM and O clock )"){
							$selected12 = 'selected';
						}
						if($time_format=="24 ( Military/Continental Time )"){
							$selected24 = 'selected';
						}
						?>
						<option <?php echo $selected12; ?>>12 ( AM/PM and O clock )</option>
                        <option <?php echo $selected24; ?>>24 ( Military/Continental Time )</option>
                        <?php


                        /* if($time_format=="12 ( AM/PM and O clock )"){

                        ?>
                        <option selected="selected">12 ( AM/PM and O clock )</option>
                        <?php }else{ ?>
                        <option>24 ( Military/Continental Time )</option><?php  }
                        if($time_format=="24 ( Military/Continental Time )"){ ?>
                        <option selected="selected">24 ( Military/Continental Time )</option>
                        <?php }else{ ?>
                        <option>12 ( AM/PM and O clock )</option>
						<?php  }if($time_format==""){ ?>

                        <option>12 ( AM/PM and O clock )</option>
                        <option>24 ( Military/Continental Time )</option>

                       <?php } */ ?>

                    </select>
                </div>
              </div>



                 <div class="form-group">
                  <label class="col-sm-2 control-label" ><span data-toggle="tooltip" data-html="true" title="<?php echo $help_time_format?>"><?php echo $text_date_format; ?></span></label>
                <div class="col-sm-10">

                    <select class="form-control" name="date_format">

						<?php
						$selected12 = $selected24 = '';
						if($date_format=="yy-mm-dd"){
							$selected12 = 'selected';
						}
						if($date_format=="dd-mm-yy"){
							$selected24 = 'selected';
						}
						?>
						<option <?php if($date_format=="yy-mm-dd"){echo 'selected';} ?>>yy-mm-dd</option>
                        <option <?php if($date_format=="dd-mm-yy"){echo 'selected';} ?>>dd-mm-yy</option>

                        <?php

                        /*
                        if($date_format=="yy-mm-dd"){

                        ?>
                        <option selected="selected">yy-mm-dd</option>
                        <?php }else{ ?>
                        <option>dd-mm-yy</option><?php  }
                        if($date_format=="dd-mm-yy"){ ?>
                        <option selected="selected">dd-mm-yy</option>
                        <?php }else{ ?>
                        <option>yy-mm-dd</option><?php  }if($date_format==""){ ?>

                        <option>yy-mm-dd</option>
                        <option>dd-mm-yy</option>

                       <?php } */ ?>

                    </select>
                </div>
              </div>

         <div class="form-group">
                  <label class="col-sm-2 control-label" ><span data-toggle="tooltip" data-html="true" title="Select Prefer time zone"><?php echo $text_time_zone; ?></span></label>
                  <div class="col-sm-10">

            <?php
                function generate_timezone_list($time_zone) {
                                static $allRegions = array(
                                DateTimeZone::AFRICA,
                                DateTimeZone::AMERICA,
                                DateTimeZone::ANTARCTICA,
                                DateTimeZone::ASIA,
                                DateTimeZone::ATLANTIC,
                                DateTimeZone::AUSTRALIA,
                                DateTimeZone::EUROPE,
                                DateTimeZone::INDIAN,
                                DateTimeZone::PACIFIC
                        );
                        // Makes it easier to create option groups next
                        $list = array ('AFRICA','AMERICA','ANTARCTICA','ASIA','ATLANTIC','AUSTRALIA','EUROPE','INDIAN','PACIFIC');
                        // Make array holding the regions (continents), they are arrays w/ all their cities
                        $region = array();
                        foreach ($allRegions as $area){
                                    array_push ($region,DateTimeZone::listIdentifiers( $area ));
                        }
                        $count = count ($region); $i = 0; $holder = '';
                        // Go through each region one by one, sorting and formatting it's cities
                        while ($i < $count){
                            $chunck = $region[$i];
                            // Create the region (continents) option group
                            $holder .= '<optgroup label="---------- '.$list[$i].' ----------">';
                            $timezone_offsets = array();
                        foreach( $chunck as $timezone ){
                            $tz = new DateTimeZone($timezone);
                            $timezone_offsets[$timezone] = $tz->getOffset(new DateTime);
                        }
                        asort ($timezone_offsets);
                        $timezone_list = array();
                        foreach ($timezone_offsets as $timezone => $offset){
                            $offset_prefix = $offset < 0 ? '-' : '+';
                            $offset_formatted = gmdate( 'H:i', abs($offset) );
                            $pretty_offset = "UTC ${offset_prefix}${offset_formatted}";
                            $timezone_list[$timezone] = "(${pretty_offset}) $timezone";
                        }
                        // All the formatting is done, finish and move on to next region
                        foreach ($timezone_list as $key => $val){
                        if($key==$time_zone){
                        $holder .= '<option value="'.$key.'" selected="selected">'.$val.'</option>';
                        }else{
                        $holder .= '<option value="'.$key.'">'.$val.'</option>';
                            }
                        }
                        $holder .= '</optgroup>';
                        ++$i;
                        }
                        return $holder;
                        }
                        echo "<select name='time_zone' class='form-control'>".generate_timezone_list($time_zone)."</select>";

?>

                  </div>


         </div>

                <div class="form-group">

                    <label class="col-sm-2 control-label" ><span data-toggle="tooltip" data-html="true" title="<?php echo $help_shop_opening_days?>"><?php echo $text_shop_opening_days; ?></span></label>

                   </div>

              <div class="form-group control-label">
                <label class="col-sm-2" ><span title=""><?php echo $text_monday; ?></span></label>

                 <div class="col-sm-10 control-label" id="w_mon">
                    <label class="col-sm-2" >

                        <span>
                     <?php if($w_mon=='OPEN'){ ?>
                            <button type="button" class="btn-primary w_mon_res" onclick="change_status('w_mon')"><div id="w_mon_res">OPEN</div></button></span></label>
                            <?php }else { ?>
                            <button type="button" class="btn-danger w_mon_res" onclick="change_status('w_mon')"><div id="w_mon_res">CLOSE</div></button></span></label>
                            <?php }?>
                </div>
              </div>

              <div class="form-group control-label">
                <label class="col-sm-2" ><span title=""><?php echo $text_tuesday; ?></span></label>

                 <div class="col-sm-10 control-label weekHide" id="w_tue">
                    <label class="col-sm-2" >

                        <span>
                            <?php if($w_tue=='OPEN'){ ?>
                            <button type="button" class="btn-primary w_tue_res" onclick="change_status('w_tue')"><div id="w_tue_res">OPEN</div></button></span></label>
                            <?php }else { ?>
                            <button type="button" class="btn-danger w_tue_res" onclick="change_status('w_tue')"><div id="w_tue_res">CLOSE</div></button></span></label>
                            <?php }?>

                </div>

              </div>

             <div class="form-group control-label">
                <label class="col-sm-2" ><span title=""><?php echo $text_wednesday; ?></span></label>

                <div class="col-sm-10 control-label weekHide" id="w_wed">
                    <label class="col-sm-2" ><span>
                            <?php if($w_wed=='OPEN'){ ?>
                            <button type="button" class="btn-primary w_wed_res" onclick="change_status('w_wed')"><div id="w_wed_res">OPEN</div></button></span></label>
                            <?php }else { ?>
                            <button type="button" class="btn-danger w_wed_res" onclick="change_status('w_wed')"><div id="w_wed_res">CLOSE</div></button></span></label>
                            <?php }?>
                </div>
              </div>

             <div class="form-group control-label">
                <label class="col-sm-2" ><span title=""><?php echo $text_thursday; ?></span></label>

                 <div class="col-sm-10 control-label weekHide" id="w_thu">
                    <label class="col-sm-2" ><span>
                            <?php if($w_thu=='OPEN'){ ?>
                            <button type="button" class="btn-primary w_thu_res" onclick="change_status('w_thu')"><div id="w_thu_res">OPEN</div></button></span></label>
                            <?php }else { ?>
                            <button type="button" class="btn-danger w_thu_res" onclick="change_status('w_thu')"><div id="w_thu_res">CLOSE</div></button></span></label>
                            <?php }?>
                </div>
              </div>

             <div class="form-group control-label">
                <label class="col-sm-2" ><span title=""><?php echo $text_friday; ?></span></label>
                 <div class="col-sm-10 control-label weekHide" id="w_fri">
                    <label class="col-sm-2" ><span>
                                                        <?php if($w_fri=='OPEN'){ ?>
                            <button type="button" class="btn-primary w_fri_res" onclick="change_status('w_fri')"><div id="w_fri_res">OPEN</div></button></span></label>
                            <?php }else { ?>
                            <button type="button" class="btn-danger w_fri_res" onclick="change_status('w_fri')"><div id="w_fri_res">CLOSE</div></button></span></label>
                            <?php }?>
                </div>
              </div>

              <div class="form-group control-label">
                <label class="col-sm-2" ><span title=""><?php echo $text_saturday; ?></span></label>

                 <div class="col-sm-10 control-label weekHide" id="w_sat">
                    <label class="col-sm-2" ><span>                            <?php if($w_sat=='OPEN'){ ?>
                            <button type="button" class="btn-primary w_sat_res" onclick="change_status('w_sat')"><div id="w_sat_res">OPEN</div></button></span></label>
                            <?php }else { ?>
                            <button type="button" class="btn-danger w_sat_res" onclick="change_status('w_sat')"><div id="w_sat_res">CLOSE</div></button></span></label>
                            <?php }?>
                </div>
              </div>

             <div class="form-group control-label">
                <label class="col-sm-2" ><span title=""><?php echo $text_sunday; ?></span></label>
                <div class="col-sm-10 control-label weekHide" id="w_sun">
                    <label class="col-sm-2" ><span>
                            <?php if($w_sun=='OPEN'){ ?>
                            <button type="button" class="btn-primary w_sun_res" onclick="change_status('w_sun')"><div id="w_sun_res">OPEN</div></button></span></label>
                            <?php }else { ?>
                            <button type="button" class="btn-danger w_sun_res" onclick="change_status('w_sun')"><div id="w_sun_res">CLOSE</div></button></span></label>
                            <?php }?>
                </div>
              </div>






                   <div class="form-group">

                        <label class="col-sm-2 control-label" ><?php echo $Exclude_Time_and_Dates ?></label>

                   </div>
               <div class="form-group">
                   <label class="col-sm-2 control-label" ><span data-toggle="tooltip" data-html="true" title=""><?php echo $From ?></span></label>
                <div class="col-sm-10">

                    <input type="text" name="From" data-toggle="tooltip" title="<?php echo $example_title ?>" id="from" class="form-control datepickertime">
                </div>
              </div>


              <div class="form-group">
                <label class="col-sm-2 control-label" ><span data-toggle="tooltip" data-html="true" title=""><?php echo $To?></span></label>
                <div class="col-sm-10">
                    <input type="text" name="<?php echo $To ?>" data-toggle="tooltip" title="<?php echo $example_title ?>" id="to" class="form-control datepickertime" >
                </div>
              </div>



               <div class="form-group">
                   <label class="col-sm-2 control-label" ></label>
                   <div class="col-sm-2">
                       <div id="error_msg_exc"><p> </p></div>
                       <div id="error_msg_exc_exists"><p><?php echo $text_value_to_date; ?> </p></div>
                       <input id="saveExceed"  type="button" name="txt" value="<?php echo $text_add_exclude_btn; ?>" class="form-control btn-primary">

                   </div>
               </div>

                   <div class="row">
                       <div class="col-md-2"></div>
                        <div class="col-md-10">
                            <div id="Saved"></div>
                        </div>





            </div>

            </div>
            <div class="tab-pane" id="tab-store">


                <div class="form-group">
                   <label class="col-sm-2 control-label" ></label>
                   <div class="col-sm-10">
                       <div id="error_msg_exc"><p> </p></div>
                       <div id="error_msg_exc_exists"><p><?php echo $text_all_slots; ?></p></div>

                       <h3 class=""><?php echo $text_change_max_order; ?></h3>
                  <table id="myTable" class= "table table-striped table-bordered table-hover">
        <thead>
          <tr>
            <th colspan="1" rowspan="1" style="width: 265px;" tabindex="0"><?php echo $text_slot; ?></th>
            <th colspan="1" rowspan="1" style="width: 180px;" tabindex="0"><?php echo $text_max_order; ?></th>
            <th colspan="1" rowspan="1" style="width: 180px;" tabindex="0"><?php echo $text_total_order; ?></th>
            <th colspan="1" rowspan="1" style="width: 180px;" tabindex="0"><?php echo $text_status; ?></th>
          </tr>
        </thead>
        <tbody>

            <?php




             if(isset($generated_slots)){

           foreach ($generated_slots->rows as $result) {

                $slot_id = $result['one_slot_id'];
                echo "<tr>";
                echo  "<td><b>".$result['slot_timing']."</b></td>";
                ?>
        <td id="Max_<?php echo $slot_id ?>"><b><a style="cursor: pointer;" onclick="edit(<?php echo $slot_id ?>)"><?php echo $result['max_no']; ?></a></b></td>

                <td><b><?php echo $result['count']; ?></b></td>

                <td>
                 <?php if($result['Status']=='ENABLE'){ ?>
                 <button type="button" id="Status_<?php echo $slot_id?>" class="btn-primary" onclick="change_status_single_slot('<?php echo $result['Status']?>','<?php echo $slot_id?>')">ENABLED</button>

                <?php }else{ ?>

                 <button type="button" id="Status_<?php echo $slot_id ?>" class="btn-danger" onclick="change_status_single_slot('<?php echo $result['Status']?>','<?php echo $slot_id?>')">DISABLED</button>



                <?php } ?>

                </td>
                </tr>
                <?php
                }



             }

             ?>



        </tbody>
      </table>
                   </div>
               </div>




            </div>

          </div>
        </form>
      </div>
    </div>
  </div>
  <style>

#genrate_btn{
margin-top: 22px;
float:right;
margin-right: 201px;
}
#error_msg_exc_exists{

display: none;
width: 154%;
font-weight: bold;
color: red;
margin-bottom: 22px;
}

div#tab-general {
    margin-top: 60px;
}
div#myTable_wrapper {
    margin-top: 52px;
    float: right;
    width: 100%;
    margin-right: 200px;
}
li.list {
    list-style: none;
    display: -webkit-inline-box;
    margin-left: 10px;
}

</style>

<link rel="stylesheet" href="view/stylesheet/css/bootstrap.min.css" />



<!-- Updated stylesheet url -->
<link rel="stylesheet" href="view/stylesheet/css/jquery.timepicker.css" />




<!-- Updated JavaScript url -->
<script src="view/stylesheet/js/jquery.timepicker.js"></script>


<link rel="stylesheet" href="view/stylesheet/css/jquery.dataTables.min.css" />
<script type="text/javascript" src="view/stylesheet/js/jquery.dataTables.min.js"></script>
<link href="view/stylesheet/bootstrap-editable.css" rel="stylesheet" />
<script src="view/javascript/bootstrap-editable.min.js"></script>



<script>
$(document).ready(function(){
    $('#myTable').dataTable();
});
</script>
          <script type="text/javascript">




        //var str = "Visit Microsoft!";
        //var res = str.replace("Microsoft", "W3Schools");

        function edit(id){


          $('#Max_'+id).editable({
                           type:  'number',
                           pk:    id,
                           name:  'max',
                           url: 'index.php?route=module/timeslot/changeTable&token=<?php echo $token; ?>&template=' + encodeURIComponent(this.value),
                           title: 'Change Maximum Number'
                        });











        }


         function change_status_single_slot(status,id){


          $.ajax({
            url: 'index.php?route=module/timeslot/SingleSlotchangeStatus&token=<?php echo $token; ?>',
            type: 'POST',
            data: { 'status':status,'id':id },
            dataType: 'html',
            success: function (result) {

             var sp = result.split("_");

             var st = sp[0];

             var st_id = sp[1];

             if(st=='ENABLE'){

                 $("#Status_"+st_id).removeClass( "btn-danger" );
                 $("#Status_"+st_id).addClass( "btn-primary" );
                 $("#Status_"+st_id).html('ENABLED');
                 $("#Status_"+st_id).attr('onClick','change_status_single_slot("ENABLE",'+st_id+')');

             }else{

                 $("#Status_"+st_id).removeClass( "btn-primary" );
                 $("#Status_"+st_id).addClass( "btn-danger" );
                 $("#Status_"+st_id).html('DISABLED');
                 $("#Status_"+st_id).attr('onClick','change_status_single_slot("DISABLE",'+st_id+')');
              }



           }
         });


    }



       var time_format = '<?php echo $time_format;?>';


       var time_format_new = 'YYYY-MM-DD';
        //alert(time_format);

        if(time_format=="12 ( AM/PM and O clock )"){

            time_format = 'YYYY-MM-DD HH:00:00';

        }else{

            time_format = 'YYYY-MM-DD HH:00:00';

        }

        var dateToday = new Date();
        $('.datepickertime').datetimepicker({
         format: time_format,
         minDate: dateToday,

    });


      $('.datepickertime1').datetimepicker({
         format: time_format_new,
         minDate: dateToday,

    });


        // $('.datepicker').datetimepicker({
  //       format: time_format_new,

         // minDate: dateToday,

   // });



        $("#error_msg_exc").css("display","none");
        $('.timepicker1').timepicker({ 'timeFormat': 'H:i:s' , 'step': '60' });







        $("#error_msg_exc").css("display","none");
        $("#SaveConf").click(function () {

        var start  =  $("#start_time").val();
        var end  =  $("#end_time").val();

        var rangeFrom   =  $("#date_range_from").val();
        var rangeTo   =  $("#date_range_to").val();



        if(CompareDates(rangeFrom,rangeTo,'-') == 0) {
       // alert('Selected date must be current date or previous date!');
       //return false;
        }




        var arrayOfStringsStart = start.split(":");
        var arrayOfStringsEnd = end.split(":");

        if(arrayOfStringsStart[0]<arrayOfStringsEnd[0]){

            $("#confd").submit();

        }else{

        alert("Please choose different start time and end time");
        }

        });



         $("#saveExceed").click(function () {


           var to  =  $("#to").val();
           var from  =  $("#from").val();

            var date_range_to  =  $("#date_range_to").val();
           var date_range_from  =  $("#date_range_from").val();


           if(to==""){

               $("#to").css("border-color","red");

               return false;
            }else{

                $("#to").css("border-color","rgb(204, 204, 204)");

                }



            if(from=="")
            {
                $("#from").css("border-color","red");
                alert("Please enter values of from date");
                return false;
            }else{

                $("#from").css("border-color","rgb(204, 204, 204)");
             }




            $.ajax({
            url: 'index.php?route=module/timeslot/addExceed&token=<?php echo $token; ?>&template=' + encodeURIComponent(this.value),
            type: 'POST',
            data: { 'to':to , 'from' : from , 'rangeFrom' : date_range_from , 'rangeTo' : date_range_to},
            dataType: 'html',
            success: function (data) {


            if(data==2)
            {
                $("#error_msg_exc_exists").css("display","block");
              // alert("This date is past please select other date");
              $("#error_msg_exc_exists").html("This slot does not exist in Delivery Date & Time");

               return false;
            } else{

            if(data==1){
             $("#error_msg_exc_exists").css("display","none");
            $("#error_msg_exc").css("display","none");
            $.ajax({
            url: 'index.php?route=module/timeslot/showExceed&token=<?php echo $token; ?>&template=' + encodeURIComponent(this.value),
            type: 'POST',
            data: { 'to':to , 'from' : from },
            dataType: 'html',
            beforeSend: function() {
			$('#saveExceed').css("background-color","grey");
                        $('#saveExceed').css("cursor","not-allowed");
		},

            success: function (result) {
             $("#error_msg_exc_exists").css("display","none");
            $('#saveExceed').css("cursor","pointer");
            $('#saveExceed').css("background-color","#337ab7");
            $("#Saved").html(result);
                }
            });
            $("#Saved").css("display", "block");
                }else {
                $("#error_msg_exc_exists").css("display","none");
                $("#error_msg_exc").css("display","block");
                $("#error_msg_exc").html("Slot already exists");
                $("#error_msg_exc").css("color","red");
                $("#error_msg_exc").css("font-weight","bold");
                 $("#error_msg_exc").css("margin-bottom","22px");
                }
            }
         }
        });


        });


    function move(id){

         var ok = confirm("Are you sure to Delete?");
         if(ok==true){

          $.ajax({
            url: 'index.php?route=module/timeslot/DeleteExceed&token=<?php echo $token; ?>&template=' + encodeURIComponent(this.value),
            type: 'POST',
            data: { 'id':id },
            dataType: 'html',
            success: function (result) {
            $("#Saved").html(result);
                }
            });

        }


    }



     $(document).ready(function() {

        $.ajax({
            url: 'index.php?route=module/timeslot/showExceed&token=<?php echo $token; ?>',
            type: 'POST',
            dataType: 'html',
            success: function (result) {

				$("#Saved").html(result);
			}
		});


		$('.add_slot').click(function(){
			$('<tr><td><span>From</span></td><td><input type="text" name="from_time[]" class="slot--timing form-control timepicker1" /></td><td><span>to</span></td><td><input type="text" name="to_time[]" class="slot--timing form-control timepicker1" /></td><td><a href="javascript:void(0)" class="remove-slot btn btn-info"><i class="fa fa-minus"></i></a></td></tr>').insertBefore($(this).closest('tr'));
			$('.timepicker1').timepicker({ 'timeFormat': 'H:i:s' , 'step': '60' });
		});

		$(document).on('click','.remove-slot',function(){
			$(this).closest('tr').remove();
		});

    });



    //$(function () {
    //    $("[data-toggle=\'tooltip\']").tooltip();
    //});



    function change_status(day){

         $.ajax({
            url: 'index.php?route=module/timeslot/WeeklychangeStatus&token=<?php echo $token; ?>',
            type: 'POST',
            data: { 'day':day },
            dataType: 'html',
            success: function (result) {
             var sp = result.split("_");
            $("#w_"+sp[1]+"_"+sp[2]).html(sp[3]);
            $(".w_"+sp[1]+"_"+sp[2]).removeClass( " btn-danger" );
            //$(".w_"+sp[1]+"_"+sp[2]).removeClass( " btn-primary" );
            $(".w_"+sp[1]+"_"+sp[2]).addClass( sp[4] );

                }
            });

    }




    </script>

</div>
<?php echo $footer; ?>
