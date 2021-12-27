xquery version "3.1";
declare variable $index := doc('/db/mayan/sitesIndex.xml');
declare variable $sites := $index//mayanSites/site;
declare variable $timelineSpacer := 2;
declare variable $dates := $sites//dateActive/@* ! xs:integer(.);

declare variable $minYear := $dates => min();
declare variable $maxYear := $dates => max();
  
 declare variable $ThisFileContent := 
<svg width="500" height="4000">
   <g transform="translate(30, 30)">
    <text x="100" y="0">{$minYear}</text>
        <text x="100" y="{($maxYear - $minYear)}">{$maxYear}</text>
      <line x1="100" y1="0" x2="100" y2="{($maxYear - $minYear)}" stroke="purple" stroke-width="3"/>  
      {
      for $s in $sites
      
      return 
  <g class="yeardata">    
  
   <circle cx="100" cy="{$s/dateActive/@yearStart ! string() ! xs:integer(.)}" r="10" fill="green"/>
   <line x1="110 + {$s[child::mayanSites]/position() => count()}" x2="110 + {$s/position() => count()}" y1="{(($maxYear - $minYear)div $timelineSpacer) + $s/dateActive/@yearStart ! string() ! xs:integer(.) div $timelineSpacer}" y2="{(($maxYear - $minYear)div $timelineSpacer) + $s/dateActive/@yearEnd ! string() ! xs:integer(.) div $timelineSpacer}" stroke-width="2" stroke="red"/>
   <text fill="black" x="130" y="{($s/dateActive/@yearStart ! string() ! xs:integer(.)) - ($s/dateActive/@yearEnd ! string() ! xs:integer(.) - $minYear)}">{$s/name}</text>
   <circle cx="100" cy="{$s/dateActive/@yearEnd ! string() ! xs:integer(.)}" r="10" fill="blue"/>
          <!--<text x="100" y="{($y - $minYear) * $timelineSpacer}">{$y}</text>-->
   
   
  </g>
}
      
   </g>
</svg>;

$ThisFileContent

(:   :let $filename := "SVGmayanSitesActiveTimeline.html"
let $doc-db-uri := xmldb:store("/db/mayan-queries", $filename, $ThisFileContent, "html")
return $doc-db-uri :)
(:  : Output at http://newtfire.org:8338/exist/rest/db/mayan-queries/SVGmayanSitesActiveTimeline.html :)



