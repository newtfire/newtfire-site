declare variable $banksyColl := collection('/db/Assignments/banksyForSVG/');
 (: declare more global variables to pull data from the Banks collection. :)
declare variable $timelineSpacer := 100;
declare variable $radiusRatio := 2;
declare variable $time := $banksyColl//date/@when ! string ();
declare variable $year := $time ! tokenize(.,'-')[1] => distinct-values();
declare variable $minyear := xs:integer($year => min());
declare variable $maxyear := xs:integer($year => max());
declare variable $title := $banksyColl//bibl/title/text();
declare variable $bibl := $banksyColl//bibl;
declare variable $ThisFileContent :=
<svg width="2000" height="3000">
<g transform="translate(30, 30)">
          <line x1="100" y1="0" x2="100" y2="1800" stroke="black" stroke-width="2"/>
          <!--<text x="90" y="-10">{$minyear}</text>
          <text x="90" y="1820">{$maxyear}</text>-->
          {
           for $y at $pos in $year
           let $work := $banksyColl[.//date/@when! tokenize(.,'-')[1] =$y]//bibl/title
           let $totalwork := $banksyColl[.//bibl/title = $work] => count()
           (: I cannot figure out how to organize it by year order:)
           return (:concat($y, ':' ,string-join($work,',')) $totalwork:)
             <g class="year">
             <circle cx="100" cy="{$pos*$timelineSpacer - 100}" r="{$totalwork*$radiusRatio}" fill="green"/>
             <text x="120" y="{$pos*$timelineSpacer - 100}">{concat($y, ' : ', string-join($work,', '))}</text>
             </g>
          }
          
   </g> 
</svg>
;
let $filename := "timeline.svg"
let $doc-db-uri := xmldb:store("/db/wdjacca", $filename, $ThisFileContent)
return $doc-db-uri
(: Output at http://newtfire.org:8338/exist/rest/db/wdjacca/timeline.svg :)
