xquery version "3.1";
declare variable $blues := collection('/db/blues');
declare variable $ThisFileContent :=
<html>
    <head>
        <title>Blues Songs</title>
    </head>
<body>
    <h1>Information about The Blues Songs Collection</h1>
   
   <h2>List of Song Titles Sorted Alphabetically Regardless of Artist</h2>
  
  <ol> 
   { let $titles := $blues//metadata/title ! normalize-space() => sort()
   for $t in $titles
      return 
       <li>{$t}</li>
       
   }
   </ol>
   
   
   <h2>Full Table of Artists and Their Song Titles</h2>
   <table>
        <tr><th>Num</th><th>Artist</th><th>Title</th></tr>
    {
    let $artist := $blues//metadata/artist ! normalize-space() => distinct-values() => sort()
    
    for $a at $pos in $artist
    (:Each artist is associated with a series of songs. Let's get the titles of each song per artist.:)
    
    return 
       <tr>
          <td>{$pos}</td>
          <td>{$a}</td>
      <td>
          <ol>{let $titles := $blues[descendant::artist ! normalize-space() = $a]//metadata/title ! normalize-space() => sort()
        for $t at $p in $titles
        (:We'll output both $pos and $p below so you can compare how they count. :)
          return
          <li>Position variable {$p}: {$t}</li>
          
          
      }
          </ol>
      </td>
          <!-- <td>{$recordInfo}</td> -->
               
        </tr> 
   }
   </table>
   
   
   
</body>
</html> ;
$ThisFileContent

(:  :let $filename := "bluesArtistTable.html"
let $doc-db-uri := xmldb:store("/db/2022-ClassExamples", $filename, $ThisFileContent, "html")
return $doc-db-uri  :) 
  (: output at :http://exist.newtfire.org/exist/rest/db/2022-ClassExamples/bluesArtistTable.html ) :)     


