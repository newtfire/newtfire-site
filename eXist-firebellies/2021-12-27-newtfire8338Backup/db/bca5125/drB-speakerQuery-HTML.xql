xquery version "3.1";
declare variable $ThisFileContent :=
<html>
    <head><title>Harry Potter Screenplays: Speakers and Counts</title></head>
    <body>
        <h1>Harry Potter Screenplays: Speakers and Counts</h1>
<table>
    <tr>
        <th>Character</th>
        <th>Screenplay</th>
        <th>Count of Speeches</th>
    </tr>
    
{
let $corpus := collection('/db/harryPotter/') 
let $fileAddresses := $corpus ! base-uri()
let $speakers := $corpus//sp/@who/string() ! normalize-space() ! tokenize(.,"\s+") => distinct-values() => sort()
for $s at $pos in $speakers
let $plays := $corpus[.//sp/@who/string() ! normalize-space() ! tokenize(.,"\s+") = $s]
for $p in $plays
    let $pTitle := $p//title
    let $pSpeeches := $p//sp[@who ! normalize-space() ! tokenize(string(), "\s+") = $s]
    let $pSpeechCount := $pSpeeches => count() 
    order by $pSpeechCount descending

return
    
     <tr>
         <!-- <td>{$pos}</td> -->
        <td>{$s ! substring-after(., '#')}</td>
        <td>{$pTitle/text()}</td>
        <td>{$pSpeechCount}</td>
    </tr>
    

}
</table>
</body>
</html> ;


let $filename := "SpeakerCountsByCountInMovie.html"
let $doc-db-uri := xmldb:store("/db/bca5125", $filename, $ThisFileContent, "html")
return $doc-db-uri 
(: output at :http://newtfire.org:8338/exist/rest/db/bca5125/SpeakerCountsByCountInMovie.html ) :)   