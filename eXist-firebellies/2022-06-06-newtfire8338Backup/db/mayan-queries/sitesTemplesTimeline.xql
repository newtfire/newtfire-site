xquery version "3.1";
declare variable $ThisFileContent :=
<html>
    <head>
		<title>Timeline</title>
		<meta charset="UTF-8" />
		<meta name="viewport" content="width=device-width, initial-scale=1.0" />
		<link rel="preconnect" href="https://fonts.gstatic.com" />
		<link href="https://fonts.googleapis.com/css2?family=New+Tegomin" rel="stylesheet" />
		<link rel="stylesheet" type="text/css" href="mayanStyling.css" />
		<link rel="shortcut icon" type="image/png" href="images/hieroglyphs/woman.jpg" />
	</head>
    
<body>   
    <header>
			<div class="titlePic">
				<h1>Timeline of Activity</h1>
				<img alt="san bartolo mural" class="headImg" src="images/designs/full_mural.png" />
			</div>
			<div class="navbar">
				<a class="nav" href="index.html">Home</a>
				<a class="nav" href="siteMap.html">Mayan Sites Map</a>
				<a class="nav" href="Gods.html">God-ography</a>
				<a class="nav" href="site_timeline.html">Timeline</a>
				<a class="nav" href="3Dmodels.html">3D Models</a>
				<a class="nav" rel="license" href="http://creativecommons.org/licenses/by-nc/4.0/">
					<img alt="Creative Commons License" style="border-width:0"
						src="https://i.creativecommons.org/l/by-nc/4.0/80x15.png" />
				</a>
			</div>
		</header>
    <h1>List of Mayan Sites and Their Temples</h1>
    
    <table>
        <tr>
            <th>Mayan Site</th> 
            <th>Date Active</th>
            <th>Site Structures</th>
            
            <th>Relics</th>
        </tr>
        <hr></hr>
{
let $siteIndex := doc('/db/mayan/sitesIndex.xml/')/*
let $site := $siteIndex//site
for $s in $site
order by $s/dateActive/@yearEnd => sort() ascending

(:  :where $s [.//structures]:)
let $siteName := $s/name

let $dateActive := $s/dateActive
let $temple := $s//structures/building
let $relics := $s//artifacts/relic
return 
    <tr>
      <td>{$siteName ! string()}</td>
      <td><!-- {string-join($name, ', ')} -->
          <ul>
              <li>{
                  $s/dateActive/@yearStart ! data() => sort()}</li>
              <li>{$s/dateActive/@yearEnd ! data()}</li>
          </ul>
      </td>
      <td>
          <ul>
              {for $t in $temple
              
              return
                  <li>{$t/name/text()} // Type of Structure: {$t/@type ! string()}</li>
              }
            </ul>
        </td>
        <td>
            <ul>{for $r in $relics
                
            return <li>{$r/name/text()} // Type of Relic: {$r/@type ! string()}</li>
            }
                
            </ul>
        </td>
        
   </tr>
   
}
</table>
</body>

</html>;

let $filename := "sitesStructRelics.html"
let $doc-db-uri := xmldb:store("/db/mayan-queries/", $filename, $ThisFileContent, "html")
return $doc-db-uri 
(: Output at http://newtfire.org:8338/exist/rest/db/mayan-queries/sitesStructRelics.html :)
