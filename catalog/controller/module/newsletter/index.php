<?php
/**
 * Created by ANH To <anh.to87@gmail.com>.
 * User: baoan
 * Date: 11/7/15
 * Time: 10:45
 */

class ControllerModuleNewsletterIndex extends Controller
{
    private $code = 'adv_newsletter';
    //git
    public function index()
    {
        header('Content: application/json');

        if(!filter_var($this->request->post['email'], FILTER_VALIDATE_EMAIL)) {
            // Exist email in the system
            echo json_encode(array(
                'error' => 1,
                'msg'   => 'Email is not valid.'
            ));
            return true;
        }
        $this->load->model('module/newsletter/extension/module');
        $model = $this->model_module_newsletter_extension_module;

        $model->alterFieldSetting();
        $newsletter_info = $model->getModuleByCode($this->code);
        $post_data = $this->request->post;
        $post_data['name']  = 'Newsletter Email Data';
        $email = $post_data['email'];

        if (!isset($newsletter_info['module_id']))
        {
            $post_data['list_emails'] = array($email);
            $this->model_module_newsletter_extension_module->addModule($this->code, $post_data);
        }
        else
        {
            if (isset($newsletter_info['setting']) && !empty($newsletter_info['setting']))
            {
                $emails_data_before = $emails_data_merged = $model->getEmails($this->code);

                if (in_array($email, $emails_data_merged))
                {
                    // Exist email in the system
                    echo json_encode(array(
                        'error' => 1,
                        'msg'   => 'You had submitted to get newsletter with this email.'
                    ));
                    return true;
                }
                // merge email of customer with old list email in the db
                array_push($emails_data_merged, $email);
            }
            else
            {
                $emails_data_merged = array($email);
            }

            // Check maximum data emails in the field of table
            if ($model->isMaxEmailsINDatabase($emails_data_merged))
            {
                $new_post_data = $post_data;
                $new_post_data['list_emails'] = array($email);
                $this->model_module_newsletter_extension_module->addModule($this->code, $new_post_data);

                $post_data['list_emails'] = $emails_data_before;
                $post_data['max'] = true;
                // update status max data for old module id
                $this->model_module_newsletter_extension_module->updateMaxModule($newsletter_info['module_id'], $post_data);
            }
            else
            {
                $post_data['list_emails'] = $emails_data_merged;
                $this->model_module_newsletter_extension_module->editModule($newsletter_info['module_id'], $post_data);
            }
        }

        echo json_encode(array(
            'error' => 0,
            'msg'   => 'Thanks for submitted to get newsletter of our store.'
        ));
        return true;
    }
}