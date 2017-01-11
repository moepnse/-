<?php
define('INSTALLING', '1');
define('UPGRADING', '2');
define('REMOVING', '3');
define('INSTALLED', '4');
define('UPGRADED', '5');
define('REMOVED', '6');
define('FAILED', '7');
define('UNKNOWN', '8');

$action = $_GET['action'];

if(in_array($action, array(INSTALLING, UPGRADING, REMOVING, INSTALLED, UPGRADED, REMOVED, FAILED, UNKNOWN))) {
    $package_id = $_GET['package_id'];
}

$hostname = $_GET['hostname'];
$process_id = $_GET['process_id'];

$db = new PDO("sqlite:db/$hostname.db");

switch($action) {
    case 'start':
        $sql = <<<EOT
        CREATE TABLE IF NOT EXISTS processes(id INTEGER PRIMARY KEY,
            process_id INTEGER NOT NULL,
            package_id TEXT NOT NULL,
            status TEXT NOT NULL, 
            timestamp DATE DEFAULT (datetime('now'))
        );
EOT;
        $db->exec($sql);
        break;
    case 'stop':
        break;
    case INSTALLING:
    case UPGRADING:
    case REMOVING:
    case INSTALLED:
    case UPGRADED:
    case REMOVED:
    case FAILED:
    case UNKNOWN:
        $sql = <<<EOT
        INSERT INTO processes(
            process_id,
            package_id,
            status
        ) VALUES (
            ?, ?, ?
        );
EOT;

        $stmt = $db->prepare($sql);
        $stmt->execute(array($process_id, $package_id, $action));
        break;
}
?>