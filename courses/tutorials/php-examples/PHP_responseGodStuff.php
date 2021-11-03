<html>
    <head>
        <title>Find Objects By God</title>
        <meta charset="UTF-8" />
        <meta name="viewport" content="width=device-width, initial-scale=1.0" />
        <link rel="preconnect" href="https://fonts.gstatic.com" />
        <link href="https://fonts.googleapis.com/css2?family=New+Tegomin" rel="stylesheet" />
        <link href="https://fonts.googleapis.com/css2?family=Noto+Sans+Mayan+Numerals"
            rel="stylesheet" />
        <link href="https://fonts.googleapis.com/css2?family=Walter+Turncoat" rel="stylesheet" />
        <link href="https://fonts.googleapis.com/css2?family=Dokdo" rel="stylesheet" />
        <link href="https://fonts.googleapis.com/css2?family=Fredericka+the+Great" rel="stylesheet" />
        <link href="https://fonts.googleapis.com/css2?family=Frijole" rel="stylesheet" />
        <link href="https://fonts.googleapis.com/css2?family=New+Tegomin" rel="stylesheet" />
        <link href="https://fonts.googleapis.com/css2?family=Red+Hat+Display" rel="stylesheet" />
        <link rel="stylesheet" type="text/css" href="mayanStyling.css" />
        <link rel="shortcut icon" type="image/png" href="images/hieroglyphs/woman.jpg" />
        <script src="javascript/php_godDropdownSelect.js">
            /**/</script>
    </head>
    <body>
         <!--#include virtual="top.html" -->
 
        <?php require_once("config.php");
        $godID = htmlspecialchars($_GET["godID"]);
        $contents = REST_PATH . "/db/mayan-queries/PHPgetStuffResponse.xql?godID=$godID";
        $result = file_get_contents($contents);
        echo $result;
        ?>
        
    

        <!--ebb: Here we'll let visitors choose a new year if they wish. -->
 <h1>Choose a god below, to find the Mayan relics and structures that depict that god.</h1>
        <p>The list reflects what relics and structures we have currently have available in our records.</p>
<!--ebb: Now we just set a PHP include to pull in the original autoGetYears.php inside this file. -->
<?php include("PHP_getStuffbyGods.php");?> 

        
         <!--#include virtual="footer.html" -->
    </body>
</html>