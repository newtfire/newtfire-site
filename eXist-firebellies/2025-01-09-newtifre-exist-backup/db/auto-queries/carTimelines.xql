xquery version "3.1";
declare variable $autoColl := collection('/db/auto');
declare variable $built := $autoColl//built;
declare variable $timelineSpacer := 10;
declare variable $date := $built/@when ! string();
(:no built issue I am happy:)
declare variable $years := $date ! tokenize(., "-")[1] ! xs:integer(.);
declare variable $minYear := $years => min();
declare variable $maxYear := $years => max();
(:this is for the timeline :)
declare variable $svgShenanigans :=
<svg width="2000" height="4000">
<g transform="translate(30,30)">
<line x1="100" y1="0" x2="100" y2="{($maxYear - $minYear) * $timelineSpacer}" stroke='green' stroke-width="2"/>
(: 2021-11-09 ebb: Syed, this wasn't working only because you needed to add a $ to timelineSpacer so XQuery can know it's a variable. Once we change that, it works. I'm correcting it here and saving a copy in the auto-queries folder. You should keep working on this for the project. You may want to space the purple rectangles out more (increase the $timelineSpacer and make your whole timeline bigger to accommodate it.) And you will want to add text labels to the timeline, too. :)
{
for $y in $years 
    return
        <g class="year">
        <rect x="100" y="{($y - $minYear) * $timelineSpacer}" width="10" height="10" fill="purple"/>
        </g>
}
</g>
</svg>;
$svgShenanigans