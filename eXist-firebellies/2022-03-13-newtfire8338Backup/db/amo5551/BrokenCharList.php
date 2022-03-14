    <?php
    require_once("config.php");
    $contents = REST_PATH . "/db/smashtiers/GameList.xql";
    $result = file_get_contents($contents);
    echo $result;
?>

(: AO: looking in the code for The Behrend Trees project I see that under the input boxes are option lists spanning the entirety of their DB, I assume through this PHP Script, $results pours out that option list, so it doesn't have to be hand-coded but I can't quite understand how to get this php script to run. I am copy and pasting. :)