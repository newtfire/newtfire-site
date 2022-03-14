xquery version "3.1";
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
</html>
