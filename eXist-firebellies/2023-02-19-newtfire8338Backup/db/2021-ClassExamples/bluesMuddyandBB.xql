xquery version "3.1";
declare variable $blues := collection('/db/blues'); 
declare variable $ThisFileContent:=
<html>
    <head><title>Muddy 'n BB King</title></head>
    <body>
        <h1>Information about Muddy Waters and B. B. King</h1>
 {       

let $metadata := $blues//metadata
let $muddyData :=
     let $muddies := $blues[.//artist ! normalize-space() = "Muddy Waters"]
      for $m at $pos in $muddies
      let $mTitle := $m//title
      let $mLength := $m//lyrics ! string-length()
      order by $mLength descending
      return concat($mTitle, ": ", $mLength)
 return
    <div class="data"> 
     <h2>Muddy Waters Data</h2>
     <ol>
        {for $mud in $muddyData
        return 
            <li>{$mud}</li>
        }
      </ol>   
   </div>
 } 
{ 

 let $bbData :=
    let $bbies := $blues[.//artist ! normalize-space() = "B.B. King"]
      for $b at $pos in $bbies
      let $bTitle := $b//title
      let $bLength := $b//lyrics ! string-length()
      order by $bLength descending
      return concat($bTitle, ": ", $bLength)
return
    <div class="data"> 
    <h2>B. B. King Data</h2>
     <ol>
        {for $bb in $bbData
        return 
            <li>{$bb}</li>
        }
      </ol>   
   </div>
}
      
  </body>
 </html> ;
 
let $filename := "classMuddyBBLists.html"
let $doc-db-uri := xmldb:store("/db/", $filename, $ThisFileContent, "html")
return $doc-db-uri  
  (: output at :http://newtfire.org:8338/exist/rest/db/myOutput/bluesArtistTable.html ) :)     

    


