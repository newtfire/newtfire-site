xquery version "3.1";
declare namespace tei="http://www.tei-c.org/ns/1.0";
declare variable $chas as document-node() := doc('/db/mitford/literary/Charles1.xml');
declare variable $chasPlay as element() := $chas/*;
declare variable $si as document-node() := doc('/db/mitford/si.xml');
declare variable $siPlaces as element()+ := $si//tei:place;
declare variable $chasPlaces as element()+ := $chasPlay//tei:placeName;
declare variable $chasPlaceRefs as xs:string+ := $chasPlaces/@ref ! normalize-space();
declare variable $distChPRs as xs:string+ := $chasPlaceRefs => distinct-values();

<html xmlns="http://www.w3.org/1999/xhtml">
    <head>
        <title>Places in Mitford's Charles the First</title>
        <style type="text/css">
        table, tr, th, td {{border:1px purple solid; border-collapse:collapse;}}
        td, th {{padding:.5em;}}
        </style>
    </head>
<body>
    <h1>Places mentioned in Mitford's Charles I</h1>
    
    <table>
{
for $pr in $distChPRs
let $siMatch as element()? := $si//tei:place[@xml:id = substring-after($pr, '#')]
(:  :let $siNonMatch as xs:string? := $pr[not($siMatch)] :)
where $siMatch
let $sID as xs:string := $siMatch/@xml:id ! string() (: or just $pr ! substring-after($pr, '#') :)
let $sName as xs:string := $siMatch/tei:placeName[1] ! normalize-space()
let $sGeo as xs:string := $siMatch/tei:location/tei:geo ! normalize-space()
let $sNote as xs:string* := $siMatch/tei:note[1] ! normalize-space()
order by $sID 
return
   <tr>
       <td>{$sID}</td>
       <td>{$sName}</td>
       <td>{$sGeo}</td>
       <td>{$sNote}</td>
    </tr>
}
</table>

<h2>Values not matched in the Site Index</h2>

<ol>
{
for $pr in $distChPRs
let $siMatch as element()? := $si//tei:place[@xml:id = substring-after($pr, '#')]
let $siNonMatch as xs:string? := $pr[not($siMatch)] ! normalize-space()
where $siNonMatch
order by $siNonMatch
return 
    
   <li>{$siNonMatch ! substring-after(., '#')}</li> 
 
    }
    </ol>
</body>
</html>


