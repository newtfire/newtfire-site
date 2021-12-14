xquery version "3.1";
declare variable $ThisFileContent :=
<kml>
    <Document>
        <name>Behrend Trees Map</name>
        <description>A collection of unique trees and their locations at Penn State Erie, The Behrend College</description>
        <Folder>
            <name>Trees</name>
{
let $btree := doc('/db/btrees/btrees_tree_book.xml')/*
let $entry := $btree/entry
for $e in $entry
let $cname := $e/cname ! normalize-space()
let $sname := $e/sname ! normalize-space()
let $type := $e/treeType ! normalize-space()
let $origin := for $o in $e/origin/continent
    return concat ($o/@direct," ", $o) 
let $desc := $e/desc ! normalize-space()
let $long := $e/long ! xs:double(.)
let $lat := $e/lat ! xs:double(.)

return
    
    <Placemark>
       <name>
            Common Name: {$cname} 
            Scientific Name: {$sname}</name>
       <description>
            Tree Type: {$type}
            
            Origin: {$origin}
            
            About: {$desc}</description>
       <Point>
           <coordinates>{$long},{$lat}</coordinates>
        </Point>
     </Placemark>  

}
</Folder>
</Document>
</kml>;

let $filename := "allTrees.kml"
let $doc-db-uri := xmldb:store("/db/btrees-queries", $filename, $ThisFileContent, "kml")
return $doc-db-uri 
(: Output at http://newtfire.org:8338/exist/rest/db/btrees-queries/allTrees.kml :)  