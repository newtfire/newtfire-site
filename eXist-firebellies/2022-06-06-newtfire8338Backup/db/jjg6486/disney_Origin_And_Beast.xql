xquery version "3.1";
declare variable $disneySongs := collection('/db/disneySongs');
declare variable $title := $disneySongs//metadata/title ! normalize-space() => distinct-values() => sort();
declare variable $ThisFileContent:=
(: I want to display the Number, The Song, and then the origin of the song :)
(: 1. define the $title variable :)
(: 2:) 
<html>
    <head><title>Disney Songs</title></head>
    <body>
        <h1>The Song and its Origin</h1>
        <table>
            <tr><th>Number</th><th>Song</th><th>Movie</th></tr>
{
        for $t at $pos in $title
            let $tOrigin := $disneySongs[.//title ! normalize-space() = $t]//origin/movie ! normalize-space() => distinct-values() => sort()
            return
                <tr>
          <td>{$pos}</td><td>{$t}</td><td>{$tOrigin}</td>
               
        </tr> 
}
</table>
<h1> Mentions of Beast</h1>
<table>
    <tr><th>Title</th><th>Line</th></tr>
{
    for $d in $disneySongs
        let $beastMentions := $d//song//ln[matches(.,"[Bb]east?")]
        (: let $bTitle := $d[.//song//ln[matches(.,"[Bb]east?")]]//metadata/title ! normalize-space()
        where $bTitle :)
        let $bTitle := $d//metadata/title ! normalize-space()
        where $d//song//ln[matches(.,"[Bb]east?")]
        
        return 
            <tr>
                <td>{$bTitle}</td><td><ol>{
                    for $l in $beastMentions
                    return 
                            <li>{$l}</li>
                }
                </ol>
                </td>
                </tr>
}
</table>
</body>
</html>;
(: http://exist.newtfire.org/exist/rest/db/jjg6486/disney_Origin_And_Beast.html :)
let $filename := "disney_Origin_And_Beast.html"
let $doc-db-uri := xmldb:store("/db/jjg6486", $filename, $ThisFileContent, "html")
return $doc-db-uri  
