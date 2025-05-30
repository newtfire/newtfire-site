xquery version "3.1";
declare variable $thisFileContent :=
<html>
    <head>Code to display character name</head>
        <body>
            <p>This is where the character blurb is. blurby blurb blurb This is also the only place we need to manually add text blurb blurb blurb</p>
            <table>
            {let $masterlist := collection('/db/smashtiers/')
            let $charlist := $masterlist//char/@id ! string()
            for $c at $pos in $charlist 
            return
               <tr><td>{$c}</td><td>{$pos}</td></tr>
            }
            </table>
        </body>
</html>;
let $filename := "character.html"
let $doc-db-uri := xmldb:store("/db/bac5738/",$filename, $thisFileContent, ".html")
return $doc-db-uri