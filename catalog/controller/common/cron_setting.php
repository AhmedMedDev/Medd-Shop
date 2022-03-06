<?php
class ControllerCommonCronSetting extends Controller {
    public function index() {

        $this->load->model('setting/cron');
        if($this->config->get('config_auto_restore')){
          $this->model_setting_cron->importDb();
          $this->restore_directory();
			die('Website Restored successfully.');
        }
		die('Check Cron settings.');

    }

    public function create_restore(){
		die('Remove me to execute restore point creation');
        $this->load->model('setting/cron');
        $this->copy_directory();
        $this->model_setting_cron->exportDb();
		die('New Restore point created successfully.');
    }

    private function copy_directory(){
	$this->full_copy(DIR_IMAGE,DIR_RESTORE_DATA);
    }

    private function restore_directory(){
	$this->full_copy(DIR_RESTORE_DATA,DIR_IMAGE);
    }

    private function full_copy( $source, $target,$empty_first=true) {

        if ($empty_first){
                $this->recursiveDelete($target);
        }

        if ( is_dir( $source ) ) {
            @mkdir( $target );						@chmod( $target, 0777);
            $d = dir( $source );
            while ( FALSE !== ( $entry = $d->read() ) ) {
                if ( $entry == '.' || $entry == '..' ) {
                    continue;
                }
                $Entry = $source . '/' . $entry;
                if ( is_dir( $Entry ) ) {
                    $this->full_copy( $Entry, $target . '/' . $entry );
                    continue;
                }
                copy( $Entry, $target . '/' . $entry );
            }

            $d->close();
        }else {
            copy( $source, $target );
        }
    }

    private function recursiveDelete($str) {

        if (is_file($str)) {
            return @unlink($str);
        }
        elseif (is_dir($str)) {

            $scan = glob(rtrim($str,'/').'/*');
            foreach($scan as $index=>$path) {
                $this->recursiveDelete($path);
            }
            return @rmdir($str);
        }
    }

}
