xquery version "3.1";
declare variable $ThisFileContent :=

<html>
    <head>
        <title> Assassins Creed Test </title>
        </head>
        <body>
            <table>
                <tr><th>Chapter Number</th><th>Chapter Title</th><th>Speeches</th><th>Distinct Speakers</th></tr>
                {
 let $test := doc('/db/assassinsCreed/assassinscreedodyssey.xml')
let $intro := $test//intro
let $ChapNum := $test//chapterNum
let $segments := ($intro, $ChapNum)
for $s at $pos in $segments
let $title :=
 if ($s//chapTitles)
        then $s//chapTitles/string() ! normalize-space()
        else "intro"
let $speeches := $s//sp ! normalize-space() => count()
        let $speakers := $s//speaker ! normalize-space() => distinct-values()
        let $distSpeakers := $speakers ! normalize-space() => count()
        
order by $pos descending

(:  return concat ($s, $pos, $speakers, $distSpeakers):)
 return
     <tr>
         <td>{$pos}</td><td>{$title}</td><td>{$speeches}</td><td>{$distSpeakers}</td>
         </tr>
  }

 </table>
 </body>
 </html> ;
 let $filename := "Racheltest.html"
let $doc-db-uri := xmldb:store("/db/rgg5144", $filename, $ThisFileContent, "html")
return $doc-db-uri 
(:  :output at :http://newtfire.org:8338/exist/rest/db/rgg5144/Racheltest.html  :)
