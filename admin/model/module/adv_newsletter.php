<?php
/**
 * Created by ANH To <anh.to87@gmail.com>.
 * User: baoan
 * Date: 11/7/15
 * Time: 12:20
 */

class ModelModuleAdvNewsletter extends Model
{
    public function getEmails()
    {
        $this->load->model('extension/module');
        $modules    = $this->model_extension_module->getModulesByCode('adv_newsletter');

        $data = array();
        $emails = array();
        foreach ($modules as $module)
        {
            $setting = unserialize($module['setting']);

            if (isset($setting['list_emails']) && count($setting['list_emails']))
            {
                foreach ($setting['list_emails'] as $email)
                {
                    if (!in_array($email, $emails))
                    {
                        $data[] = array(
                            'email' => $email
                        );
                        $emails[] = $email;
                    }
                }
            }
        }

        return $data;
    }
}