xquery version "3.1";
declare variable $ThisFileContent :=
<html>
    <head><title>List of Latitudes and Longitudes</title></head>
    
<body>   
    <h1>List of Latitudes and Longitudes</h1>
    
    <table>
        <tr>
            <th>Mayan Site</th> 
            <th>Latitude</th>
            <th>Longitude</th>
        </tr>
        <hr></hr>
{
let $siteIndex := doc('/db/mayan/sitesIndex.xml/')/*
let $site := $siteIndex//site
for $s in $site
let $siteName := $s/name
let $location := $s/location
return 
    <tr>
      <td>{$siteName}</td>
      <td><!-- {string-join($name, ', ')} -->
            {$location/@lat ! data()}
      </td>
      <td>
         {$location/@long ! data()}
        </td>
   </tr>
   
}
</table>
</body>

</html>;

let $filename := "latLongList.html"
let $doc-db-uri := xmldb:store("/db/mayan-queries/", $filename, $ThisFileContent, "html")
return $doc-db-uri 
(: Output at http://newtfire.org:8338/exist/rest/db/mayan-queries/latLongList.html :)

