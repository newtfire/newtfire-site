xquery version "3.1";
<html>
    <title> X Query 5 </title>
    <head></head>
    <body>
        <table><tr><th>No. </th><th> Chapter </th><th> Paragraph Count </th></tr>
        {
            let $grimms := collection('/db/grimm/')
            let $chapter := $grimms//chapter
            for $c at $pos in $chapter
            let $title := $c//title
            let $pcount := $c//p => count()
            return 
                <tr><td>{$pos}</td><td>{$title/text()}</td><td>{$pcount}</td></tr>
        }
        </table>
    </body>
</html>
