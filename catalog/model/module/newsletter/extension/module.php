<?php
class ModelModuleNewsletterExtensionModule extends Model {
	public function addModule($code, $data) {
        $real_data = $data;
        unset($real_data['name']);
        unset($real_data['email']);
		$this->db->query("INSERT INTO `" . DB_PREFIX . "module` SET `name` = '" . $this->db->escape($data['name']) . "', `code` = '" . $this->db->escape($code) . "', `setting` = '" . $this->db->escape(serialize($real_data)) . "'");
	}
	
	public function editModule($module_id, $data) {
		$this->db->query("UPDATE `" . DB_PREFIX . "module` SET `name` = '" . $this->db->escape($data['name']) . "', `setting` = '" . $this->db->escape(serialize($data)) . "' WHERE `module_id` = '" . (int)$module_id . "'");
	}

	public function getModuleByCode($code) {
		$query = $this->db->query("SELECT * FROM `" . DB_PREFIX . "module` WHERE `code` = '" . $this->db->escape($code) . "'");

        // Loop to get only module with status data max is false
        foreach ($query->rows as $row)
        {
            $setting = unserialize($row['setting']);
            if (isset($setting['max']))
            {
                continue;
            }
            $module = $row;
        }
        if (isset($module))
        {
            return $module;
        }
		else
        {
            return false;
        }
	}

    public function updateMaxModule($module_id, $data)
    {
        $real_data = $data;
        unset($real_data['name']);
        unset($real_data['email']);
        $this->db->query("UPDATE `" . DB_PREFIX . "module` SET `setting` = '" . $this->db->escape(serialize($real_data)) . "' WHERE `module_id` = '" . (int)$module_id . "'");
    }

    public function getEmails($code)
    {
        $query = $this->db->query("SELECT * FROM `" . DB_PREFIX . "module` WHERE `code` = '" . $this->db->escape($code) . "'");

        $emails = array();
        // Loop to get emails of module
        foreach ($query->rows as $row)
        {
            $setting = unserialize($row['setting']);
            $emails = array_merge($emails, $setting['list_emails']);
        }

        return $emails;
    }

    public function clearModuleData($code)
    {
        $this->db->query("DELETE FROM `" . DB_PREFIX . "module` WHERE `code` = '$code'");
    }

    public function isMaxEmailsINDatabase($emails)
    {
        $data = serialize($emails);
        if (function_exists('mb_strlen') && is_callable('mb_strlen'))
        {
            $bytes = mb_strlen($data, '8bit');

            if ($bytes >= 4000000000)
            {
                // 4.000.000.000
                return true;
            }

            return false;
        }
        // max is 21800
        if (strlen($data) >= 21800)
        {
            return true;
        }

        return false;
    }

    /**
     * Once time alter only
     * Change type text of field setting in table module to LONGTEXT
     */
    public function alterFieldSetting()
    {
        $columns = "SHOW COLUMNS FROM ".DB_PREFIX."module";
        $columns_query = $this->db->query($columns);
        $columns_rows = array();
        foreach($columns_query->rows as $col){
            $columns_rows[$col['Field']] = $col['Field'];
        }

        if (isset($columns_rows['setting']))
        {
            $field_type = $this->db->query("SELECT COLUMN_TYPE FROM information_schema.COLUMNS WHERE TABLE_NAME = '".DB_PREFIX."module' AND COLUMN_NAME = 'setting'");

            if ($field_type->row['COLUMN_TYPE'] == 'text')
            {
                $this->db->query("ALTER TABLE `".DB_PREFIX."module` MODIFY `setting` longtext COLLATE 'utf8_general_ci' NOT NULL AFTER `code`;");
            }
        }
    }
}