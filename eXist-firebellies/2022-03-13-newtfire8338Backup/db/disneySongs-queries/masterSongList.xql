xquery version "3.1";
declare variable $collection := collection('/db/disneySongs/');
declare variable $thisFileContent := 
<xml>
    <title>Master Song List</title>
    
    {for $song in $collection
        let $songTitle := $song//title
        let $movie := $song//movie
        let $text := $song//song
        return <song><songTitle>{$songTitle}</songTitle><movie>{$movie}</movie><text>{$text}</text></song>
    }
            
        
</xml>;
let $filename := "masterSongList.xml"
let $doc-db-uri := xmldb:store("/db/disneySongs-queries/", $filename, $thisFileContent, "xml")
return $doc-db-uri   
(: View this xml at http://newtfire.org:8338/exist/rest/db/disneySongs-queries/masterSongList.xml  :)