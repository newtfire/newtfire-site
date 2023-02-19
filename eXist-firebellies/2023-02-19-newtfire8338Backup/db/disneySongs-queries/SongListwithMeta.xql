xquery version "3.1";
declare variable $collection := collection('/db/disneySongs/');
declare variable $thisFileContent := 
<xml>
    <title>Master Song List With MetaData</title>
    
    {for $song in $collection
        let $meta := $song//metadata
        let $text := $song//song
        return <song><meta>{$meta}</meta><text>{$text}</text></song>
    }
            
        
</xml>;
let $filename := "masterSongwithMeta.xml"
let $doc-db-uri := xmldb:store("/db/disneySongs-queries/", $filename, $thisFileContent, "xml")
return $doc-db-uri   
(: View this xml at http://newtfire.org:8338/exist/rest/db/disneySongs-queries/masterSongwithMeta.xml  :)