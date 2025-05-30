xquery version "3.1";
declare variable $autoColl := collection('/db/auto');
declare variable $built := $autoColl//built;
declare variable $date := $built/@when ! string();
declare variable $timelineSpacer := 25;
(: test
declare variable $cars := $autoColl//name;
declare variable $jeff := $cars ! tokenize(., "-")[1];
declare variable $countDate := count($date);
:)
declare variable $years := $date ! tokenize(., "-")[1] ! xs:integer(.);
declare variable $minYear := $years => min();
declare variable $maxYear := $years => max();
(:this is for the timeline :)
declare variable $ThisFileContent :=
<svg width="500" height="4000">
<g transform="translate(30,30)">
<line x1="100" y1="0" x2="100" y2="{($maxYear - $minYear) * $timelineSpacer}" stroke='green' stroke-width="2"/>
{
for $y in $years 
    return
        <g class="year">
         <text x="120" y="{($y - $minYear) * $timelineSpacer}" fill="blue">{$y}</text>
         <text x="140" y="{($y - $minYear) * $timelineSpacer}" fill="blue"></text>
        <rect x="95" y="{($y - $minYear) * $timelineSpacer}" width="10" height="3" fill="purple"/>
        </g>
}
<text x="0" y="{-3}" fill="blue">The first Datsun!</text>
</g>
</svg>;
let $filename := "carTimeline.svg"
let $doc-db-uri := xmldb:store("/db/auto-queries", $filename, $ThisFileContent, "xml")
return $doc-db-uri