xquery version "3.1";
declare variable $collection := collection('/db/disneySongs');
declare variable $movies := $collection//movie => distinct-values();
declare variable $movieCount := $movies => count();
declare variable $title := $collection//title/text();
declare variable $timelineSpacer := 200;
declare variable $lineLengthen := 4;
declare variable $radiusRatio := 10;
declare variable $thisFileContent :=
<svg width="2000" height="3000">
<g transform="translate(30, 30)">
          <line x1="100" y1="100" x2="2000" y2="100" stroke="black" stroke-width="2"/>
          {
            for $m at $pos in $movies
            let $titleCount := $collection[.//movie = $m]=>count()
            let $compCount := $collection[.//movie = $m]//composer => count()
            let $lyricCount := $collection[.//movie = $m]//lyricist => count()
            let $vaCount := $collection[.//movie = $m]//voiceActor => count()
            let $personCount := $compCount + $lyricCount + $vaCount
            let $totalCount := $titleCount + $personCount
            return
                <g class="circles">
                <circle cx="{$pos*$timelineSpacer - 100}" cy="100" r="{math:sqrt($totalCount div math:pi())*$radiusRatio}" fill="#2C7AAF" stroke="#21073A" stroke-width="{$personCount div $lineLengthen}"/>
                <text x="{($pos * $timelineSpacer) - 100}" y="200" style="writing-mode: tb; glyph-orientation-vertical:0" fill="black">{$m}</text>
                <text x="{($pos * $timelineSpacer) - 104}" y="105">{$titleCount}</text>
                
                </g>
            
          }
</g> 
</svg>;
let $filename := "disneyLine.svg"
let $doc-db-uri := xmldb:store("/db/wdjacca", $filename, $thisFileContent)
return $doc-db-uri
(: Output at http://newtfire.org:8338/exist/rest/db/wdjacca/timeline.svg :)
