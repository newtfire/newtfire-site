xquery version "3.1";
declare variable $ThisFileContent :=
<html>
    <head><title>Harry Potter Screenplays: Speakers and Counts</title></head>
    <body>
        <h1>Harry Potter Screenplays: Speakers and Counts</h1>
<table>
    <tr>
        <th>Character</th>
        <th>Count of Speeches</th>
    </tr>
    
{
let $corpus := collection('/db/harryPotter/') 
let $fileAddresses := $corpus ! base-uri()
let $speakers := $corpus//sp/@who/string() ! normalize-space() ! tokenize(.,"\s+") => distinct-values() => sort()
for $s in $speakers
    let $Speeches := $corpus//sp[@who ! normalize-space() ! tokenize(string(), "\s+") = $s]
    let $SpeechCount := $Speeches => count() 
    order by $SpeechCount descending

return
    
     <tr>
         <!-- <td>{$pos}</td> -->
        <td>{$s ! substring-after(., '#')}</td>
        <td>{$SpeechCount}</td>
    </tr>
    

}
</table>
</body>
</html> ;


let $filename := "SpeakerCountsTotal.html"
let $doc-db-uri := xmldb:store("/db/bca5125", $filename, $ThisFileContent, "html")
return $doc-db-uri 
(: output at :http://newtfire.org:8338/exist/rest/db/bca5125/SpeakerCountsTotal.html ) :)   