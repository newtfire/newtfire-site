<html xmlns="http://www.w3.org/1999/xhtml"/><?php require_once("config.php");
$contents = REST_PATH . "/db/auto-queries/carTable.xql";
$result=file_get_contents($contents);
echo $result;
?>