xquery version "3.1";
(: 2021-12-04 ebb: This is now working, huzzah! it's outputting two subfolders for Deciduous and Coniferous trees. I'm now thinking we could try outputting nested subfolders for Continent of Origin **within this grouping**, but let's try that in a new XQuery.  :)
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
let $entryTypes := $entry/treeType ! normalize-space() => distinct-values()
for $t in $entryTypes

return 
    <Folder>
        <name>{$t}</name>
    { let $entriesByType := $entry[treeType ! normalize-space() = $t]
    for $e in $entriesByType
    
        let $cname := $e/cname ! normalize-space()
let $sname := $e/sname ! normalize-space()
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
            Tree Type: {$t}
            
            Origin: {$origin}
            
            About: {$desc}</description>
       <Point>
           <coordinates>{$long},{$lat}</coordinates>
        </Point>
     </Placemark> 
}
</Folder>}
</Folder>
</Document>
</kml>;

let $filename := "treeType.kml"
let $doc-db-uri := xmldb:store("/db/btrees-queries", $filename, $ThisFileContent, "xml")
return $doc-db-uri 
(: Output at http://newtfire.org:8338/exist/rest/db/btrees-queries/treeType.kml :)  