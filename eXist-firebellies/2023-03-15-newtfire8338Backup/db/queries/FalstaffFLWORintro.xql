xquery version "3.1";
declare default element namespace "http://www.tei-c.org/ns/1.0";
let $shakes := collection('/db/apps/shakespeare/data/')
let $falstaffPlays := $shakes//TEI[descendant::speaker = "Falstaff"]
let $fplayTitles := $falstaffPlays//titleStmt/title ! string()
return 
    <html>
        <head>
            <title>Falstaff Plays</title>
        </head>
        <body>
            <h1>Falstaff Plays</h1>
            <table>
                <tr>  
                    <th>Play Title</th><th>Count of Distinct Speakers</th><th>Count of Falstaff's Speeches</th>
                </tr>
        {for $fplay in $falstaffPlays
   let $fplayTitle := $fplay//titleStmt/title ! string()
   let $fspeeches := $fplay//sp[child::speaker = "Falstaff"]
   let $countFS := $fspeeches => count()
   let $fplaySpeakers := $fplay//speaker
   let $distSpeakers := $fplaySpeakers => distinct-values()
   let $countDS := $distSpeakers => count()
         return 
             <tr> 
                 <td>{$fplayTitle}</td>
                 <td>{$countDS}</td>
                 <td>{$countFS}</td>
             </tr>}
        </table>
        </body>
        
    </html>

   
