<?php


// Heading
$_['heading_title']			= 'Erweiterungen Installieren';

// Text
$_['text_success']			= 'Erweiterung wurde erfolgreich hochgeladen, um sie anzuwenden müssen jetzt die Anpassungen angewendet werden.<br />Dazu bitte <a href="index.php?route=extension/modification&token=' . $_SESSION['token'] . '">hier</a> klicken und auf Button Aktualisieren klicken';
$_['text_list']				= 'Übersicht';
$_['text_unzip']			= 'Entpacke Dateien';
$_['text_ftp']				= 'Kopiere Dateien';
$_['text_sql']				= 'Führe SQL-Befehle aus';
$_['text_xml']				= 'Wende Anpassungen an';
$_['text_php']				= 'Führe PHP aus';
$_['text_remove']			= 'Entferne temporäre Dateien';
$_['text_clear']			= 'Temporäre Dateien erfolgreich entfernt';

// Entry
$_['entry_upload']			= 'Lade Datei hoch<br />Mehr dazu <a href="https://github.com/opencart/opencart/wiki/Modification-System" target="_blank">hier</a>';
$_['entry_overwrite']		= 'Dateien welche überschrieben oder hinzugefügt werden';
$_['entry_progress']		= 'Ausführen';

// Help
$_['help_upload']			= 'Benötigt entweder eine <b>.zip oder .xml</b> Datei, die Endung muss lauten <b>.ocmod.zip</b> oder <b>.ocmod.xml</b><br />War das Hochladen erfolgreich, muß um die Anpassungen anzuwenden anschließend das Menü <i>Anpassungen</i> aufgerufen werden, die gewünschte Anpassung auswählen und den Button <i>Aktualisieren</i> anklicken';

// Error
$_['error_permission']		= 'Hinweis: keine Rechte zur Ausführung dieser Aktion';
$_['error_temporary']		= 'Achtung: es befinden sich einige temporäre Dateien im Verzeichnis, zum Löschen den Button <b>Bereinigen</b> anklicken';
$_['error_upload']			= 'Datei konnte nicht hochgeladen werden';
$_['error_filetype']		= 'Ungültige Dateiart';
$_['error_file']			= 'Datei nicht gefunden';
$_['error_unzip']			= 'Zipdatei konnte nicht geöffnet werden';
$_['error_code']			= 'Anpassung erfordert eine eindeutige Identifikationsnummer';
$_['error_exists']			= 'Anpassung <b>%s</b> verwendet dieselbe Identifikationsnummer als die Hochzuladende';
$_['error_directory']		= 'Ordner <b>upload</b> mit Dateien zum hochladen konnte nicht gefunden werden';
$_['error_ftp_status']		= 'Hochladen nicht möglich - FTP muss in der <a href="index.php?route=setting/store&token=' . $_SESSION['token'] . '">Systemsteuerung</a> aktiviert sein';
$_['error_ftp_connection']	= 'FTP-Verbindung zu <b>%s:%s</b> nicht möglich';
$_['error_ftp_login']		= 'FTP-Anmeldung als <b>%s</b> nicht möglich';
$_['error_ftp_root']		= 'Hauptverzeichnis <b>%s</b> konnte nicht bestimmt werden';
$_['error_ftp_directory']	= 'Verzeichniswechsel nach <b>%s</b> nicht möglich';
$_['error_ftp_file']		= 'Datei <b>%s</b> konnte nicht hochgeladen werden';