xquery version "3.1";
declare variable $radio := collection('/db/holmes/radio-scripts/');
declare variable $lns := $radio//ln[.//mention];
declare variable $ThisFileContent:=
    <html>
        <head></head>
        <body><!--Your HTML file you're constructing here, complete with XQuery inside -->
        <table><tr><th>Speaker</th><th>Referee</th><th>Title</th></tr>
        {
        for $l in $lns
        let $mentions := $l//mention
        for $m in $mentions
        let $speaker:= $l[.//mention =$m]/speaker ! normalize-space()
        let $ref := $m/@ref ! normalize-space()
        return <tr><td>{$speaker}</td><td>{$ref!upper-case(.)}</td><td>{$m ! normalize-space()}</td></tr>
            
        }

        </table>
    </body>    
    </html>;

let $filename := "mention_table.html"
let $doc-db-uri := xmldb:store("/db/wdjacca/radio_holmes", $filename, $ThisFileContent, "html")
return $doc-db-uri  
  (: output at :http://newtfire.org:8338/exist/rest/db/myOutput/bluesArtistTable.html ) :) 



