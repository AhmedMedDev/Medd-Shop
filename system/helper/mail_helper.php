<?php

require_once(DIR_SYSTEM . "/library/phpmailer/vendor/autoload.php");

// Import PHPMailer classes into the global namespace
use PHPMailer\PHPMailer\PHPMailer;
use PHPMailer\PHPMailer\Exception;

class MailHelper extends Mail {

    private $mail = '';
    private $sysConfig = array();

    public $error = '';

    public $protocol = 'mail';
    public $parameter = '';
    public $smtp_hostname;
	public $smtp_username;
	public $smtp_password;
	public $smtp_port = 25;
	public $smtp_timeout = 5;
	public $smtp_secure = '';

	public function __construct($registry)
    {
        $this->sysConfig  = $registry;
        if (VERSION < '2.0.2.0' || (VERSION > '2.0.3.1' && VERSION < '2.1.0.1')) {
            $this->mail = new Mail($this->sysConfig->get('config_mail'));
        } else {

            $this->mail = new Mail();
            $this->setupMailSettings();
        }
    }

    public function setupMailSettings()
    {
		$this->mail->protocol = $this->sysConfig->get('config_mail_protocol');
		$this->mail->parameter = $this->sysConfig->get('config_mail_parameter');
		$this->mail->smtp_hostname = $this->sysConfig->get('config_mail_smtp_hostname');
		$this->mail->smtp_username = $this->sysConfig->get('config_mail_smtp_username');
		$this->mail->smtp_password =  html_entity_decode($this->sysConfig->get('config_mail_smtp_password'), ENT_QUOTES, 'UTF-8');
		$this->mail->smtp_secure = $this->sysConfig->get('config_mail_secure');
		$this->mail->smtp_port = $this->sysConfig->get('config_mail_smtp_port');
		$this->mail->smtp_timeout = $this->sysConfig->get('config_mail_smtp_timeout');
    }

    public function getError()
    {
        return $this->error;
    }

    public function setSenderName($senderName = '')
    {
        $this->mail->setSender(html_entity_decode($senderName, ENT_QUOTES, 'UTF-8'));
    }

    public function setSenderEmail($senderEmail = '')
    {
        $this->mail->setFrom($senderEmail);
    }

    public function getSenderName()
    {
        if($this->mail->sender  == '') {
            return $this->sysConfig->get('config_name');
        }

        return $this->mail->sender;
    }

    public function getSenderEmail()
    {
        if($this->mail->from  == '') {
            return $this->sysConfig->get('config_email');
        }

        return $this->mail->from;
    }

    public function sendEmail($toEmail, $subject, $messageHTML = '', $messageText = '')
    {
        $this->mail->setTo($toEmail);

		$this->mail->setFrom($this->getSenderEmail());
		$this->mail->setSender($this->getSenderName());

        $subject  = html_entity_decode($subject, ENT_QUOTES, 'UTF-8');
		$this->mail->setSubject($subject);

        if($messageHTML != '') {
            $this->mail->setHtml($messageHTML);
        }

        if($messageText != '') {
            $this->mail->setText($messageText);
        }

        //$this->mail->send();
		$this->sendSMTPEmail();
    }

    public function sendSMTPEmail()
    {

		if (empty($this->mail->to)) {
			$this->error = 'Error: E-Mail to required!';
            return false;
		}

		if (empty($this->mail->from)) {
			$this->error = 'Error: E-Mail from required!';
            return false;
		}

		if (empty($this->mail->sender)) {
			$this->error = 'Error: E-Mail sender required!';
            return false;
		}

		if (empty($this->mail->subject)) {
			$this->error = 'Error: E-Mail subject required!';
            return false;
		}


		if ((empty($this->mail->text)) && (empty($this->mail->html))) {
			$this->error = 'Error: E-Mail message required!';
            return false;
		}


		if (is_array($this->mail->to)) {
			$to = implode(',', $this->mail->to);
		} else {
			$to = $this->mail->to;
		}

        if ($this->mail->protocol == 'mail') {
    		$boundary = '----=_NextPart_' . md5(time());

    		$header = 'MIME-Version: 1.0' . $this->mail->newline;

    		$header .= 'Date: ' . date('D, d M Y H:i:s O') . $this->mail->newline;
    		$header .= 'From: =?UTF-8?B?' . base64_encode($this->mail->sender) . '?=' . ' <' . $this->mail->from . '>' . $this->mail->newline;

    		if (!$this->mail->reply_to) {
    			$header .= 'Reply-To: =?UTF-8?B?' . base64_encode($this->mail->sender) . '?=' . ' <' . $this->mail->from . '>' . $this->mail->newline;
    		} else {
    			$header .= 'Reply-To: =?UTF-8?B?' . base64_encode($this->mail->reply_to) . '?=' . ' <' . $this->mail->reply_to . '>' . $this->mail->newline;
    		}

    		$header .= 'Return-Path: ' . $this->mail->from . $this->mail->newline;
    		$header .= 'X-Mailer: PHP/' . phpversion() . $this->mail->newline;
    		$header .= 'Content-Type: multipart/related; boundary="' . $boundary . '"' . $this->mail->newline . $this->mail->newline;

    		if (!$this->mail->html) {
    			$message  = '--' . $boundary . $this->mail->newline;
    			$message .= 'Content-Type: text/plain; charset="utf-8"' . $this->mail->newline;
    			$message .= 'Content-Transfer-Encoding: 8bit' . $this->mail->newline . $this->mail->newline;
    			$message .= $this->mail->text . $this->mail->newline;
    		} else {
    			$message  = '--' . $boundary . $this->mail->newline;
    			$message .= 'Content-Type: multipart/alternative; boundary="' . $boundary . '_alt"' . $this->mail->newline . $this->mail->newline;
    			$message .= '--' . $boundary . '_alt' . $this->mail->newline;
    			$message .= 'Content-Type: text/plain; charset="utf-8"' . $this->mail->newline;
    			$message .= 'Content-Transfer-Encoding: 8bit' . $this->mail->newline . $this->mail->newline;

    			/* if ($this->mail->text) {
    				$message .= $this->mail->text . $this->mail->newline;
    			} else {
    				$message .= 'This is a HTML email and your email client software does not support HTML email!' . $this->mail->newline;
    			} */

    			$message .= '--' . $boundary . '_alt' . $this->mail->newline;
    			$message .= 'Content-Type: text/html; charset="utf-8"' . $this->mail->newline;
    			$message .= 'Content-Transfer-Encoding: 8bit' . $this->mail->newline . $this->mail->newline;
    			$message .= $this->mail->html . $this->mail->newline;
    			$message .= '--' . $boundary . '_alt--' . $this->mail->newline;
    		}

    		foreach ($this->mail->attachments as $attachment) {
    			if (file_exists($attachment)) {
    				$handle = fopen($attachment, 'r');

    				$content = fread($handle, filesize($attachment));

    				fclose($handle);

    				$message .= '--' . $boundary . $this->mail->newline;
    				$message .= 'Content-Type: application/octet-stream; name="' . basename($attachment) . '"' . $this->mail->newline;
    				$message .= 'Content-Transfer-Encoding: base64' . $this->mail->newline;
    				$message .= 'Content-Disposition: attachment; filename="' . basename($attachment) . '"' . $this->mail->newline;
    				$message .= 'Content-ID: <' . basename(urlencode($attachment)) . '>' . $this->mail->newline;
    				$message .= 'X-Attachment-Id: ' . basename(urlencode($attachment)) . $this->mail->newline . $this->mail->newline;
    				$message .= chunk_split(base64_encode($content));
    			}
    		}

    		$message .= '--' . $boundary . '--' . $this->mail->newline;


			ini_set('sendmail_from', $this->mail->from);

			if ($this->mail->parameter) {
				mail($to, '=?UTF-8?B?' . base64_encode($this->mail->subject) . '?=', $message, $header, $this->mail->parameter);
			} else {
				mail($to, '=?UTF-8?B?' . base64_encode($this->mail->subject) . '?=', $message, $header);
			}
		} elseif ($this->mail->protocol == 'smtp') {

            $this->sentPHPMailerMail();
		}
	}

    private function sentPHPMailerMail()
    {
        $mail = new PHPMailer(true);                              // Passing `true` enables exceptions
        try {

            $mail->SMTPDebug = 0;                                 // Enable verbose debug output
            $mail->isSMTP();                                      // Set mailer to use SMTP
            $mail->Host = $this->mail->smtp_hostname;  // Specify main and backup SMTP servers
            $mail->SMTPAuth = true;                               // Enable SMTP authentication
            $mail->Username = $this->mail->smtp_username;                 // SMTP username
            $mail->Password = $this->mail->smtp_password;                           // SMTP password
            $mail->SMTPSecure = $this->mail->smtp_secure;                            // Enable TLS encryption, `ssl` also accepted
            $mail->Port = $this->mail->smtp_port;                                    // TCP port to connect to

            //Recipients

            $mail->setFrom($this->getSenderEmail(), $this->getSenderName());

            if (is_array($this->mail->to)) {
                foreach ($this->mail->to as $key => $toEmail) {
                    $mail->addAddress($toEmail);     // Add a recipient
                }
            } else {
                $mail->addAddress($this->mail->to);     // Add a recipient
            }

            if ($this->mail->reply_to) {
                $mail->addReplyTo($this->mail->reply_to);
            }

            // $mail->addCC('cc@example.com');
            // $mail->addBCC('bcc@example.com');

            //Attachments

            foreach ($this->mail->attachments as $attachment) {
                if (file_exists($attachment)) {
                    $mail->addAttachment($attachment);         // Add attachments
                }
            }
            //$mail->addAttachment('/tmp/image.jpg', 'new.jpg');    // Optional name
			
			if(empty($this->mail->html)) {				
				$mail->Body    = $this->mail->text;
			}
			else {				
				$mail->Body = $this->mail->html;
			}
            //Content
            $mail->isHTML(!empty($this->mail->html));                                  // Set email format to HTML
            $mail->Subject = $this->mail->subject;
            //$mail->Body    = $this->mail->html;
            $mail->AltBody = $this->mail->text;
			
            $mail->send();
            return true;

        } catch (Exception $e) {

            $this->error = 'Message could not be sent. Mailer Error: ' . $mail->ErrorInfo;
            return false;
        }

    }
}
