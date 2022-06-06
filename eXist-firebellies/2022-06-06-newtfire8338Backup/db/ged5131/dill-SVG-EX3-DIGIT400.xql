xquery version "3.1";
declare variable $TreeColl := collection('/db/btrees/articles/');
declare variable $timelineSpacer := 135;
declare variable $squareSpacer := 10;

declare variable $dates := $TreeColl//newspaperArticle/meta/issueDate ! string();
declare variable $years := $dates ! tokenize(., '-')[1] ! xs:integer(.);
declare variable $minYear := $years => min();
declare variable $maxYear := $years => max();
declare variable $ThisFileContent := 
<svg width="2000" height="3000">
 <g transform="translate(30, 30)">
 <line x1="100" y1="0" x2="100" y2="{($maxYear - $minYear) *$timelineSpacer}" stroke="brown" stroke-width="3"/>  
   {
    for $y in $years
    let $matchArts := $TreeColl//newspaperArticle/meta[issueDate ! matches (., $y)]/body/header/title 
    let $countArts := $matchArts => count()
    let $titles :=$TreeColl//newspaperArticle/meta/issueDate[matches (., $y)]/following::body/header/title ! string()
    let $joinTitles := string-join ($titles, ", ")
      return 
  <g class="artTimelineData">         
  <rect x="90" y="{($y - $minYear) * $timelineSpacer}" width="20" height="20" fill="green"/>
  <text x="140" y="{($y - $minYear) * $timelineSpacer}" fill="black">{$y}</text>
  <text x="180" y="{($y - $minYear) * $timelineSpacer}" fill="black">{$joinTitles}</text>
  {$joinTitles}
  </g>
}
       
   </g>
</svg>; 
(:  :$ThisFileContent:)
let $filename := "dill-SVG-EX3-timelineForArticles.svg"
let $doc-db-uri := xmldb:store("/db/ged5131/", $filename, $ThisFileContent)
return $doc-db-uri
