xquery version "3.1";
declare namespace request="http://exist-db.org/xquery/request";
declare namespace ft="http://exist-db.org/xquery/lucene";
import module namespace kwic="http://exist-db.org/xquery/kwic";
declare namespace exist = "http://exist.sourceforge.net/NS/exist";
declare namespace tei="http://www.tei-c.org/ns/1.0";

let $input_search := request:get-parameter("input_search", "coffee in a tin kettle")
let $waldenft := collection('/db/waldenft')

let $close := concat($input_search, "~.6")
let $exactMatches := $waldenft//tei:body//tei:seg[ft:query(.,$input_search)] 
(: 2021-01-06 ebb with paul schacht and beth witherell: searches need to be at the paragraph level, but we need to reliably locate either:
 : 1) for segmented paragraphs, which segment a search is part of, or
 : 2) for non-segmented paragraphs, simply which paragraph.
 :  We need to be able to look UP the tree from the point of view of a matched string of text, and find it's immediate ancestor 
 : When we have seg/@n as an ancestor of the match, we're in a segment, and can retrieve what we need from the @n or the child note/seg[@type='paragraph]/text()
 : When we DON'T have seg/@n as an ancestor, go to the closest ancestor tei:p, and its child note/seg[@type='paragraph]/text()
 :  :)
let $ngramMatches := $waldenft//tei:body//tei:p[ngram:wildcard-contains(., $input_search)]
(:  :let $closeMatches := $waldenft//tei:body//tei:seg//*[ft:query(text(),$close)]:)


return 
<div id="searchResults">
    <h3>Exact search results: Count: {count($exactMatches)}</h3>
{let $eResults :=
if (count($exactMatches) > 0)
  then
    for $e at $pos in $exactMatches
(:  :let $uri := $e/tokenize(base-uri(), '/')[last()]:)
let $seg := $e/preceding::tei:seg[@type="paragraph"][1]/text()  
(: EXCEPT this is returning 10a and not 10b as we *think* it should? Check in oXygen on file 006 :)
order by $seg
return <div n="{$e/base-uri() ! tokenize(., '/')[last()]}-{$pos}">{kwic:summarize($e, <config width="60" link="{$seg}"/>)}</div>
else <p>No results found.</p>
return $eResults
}
<h3>Ngram search results:</h3>
{let $nResults :=
   if (count($ngramMatches) > 0)
   then 
       for $n in $ngramMatches
       let $seg := $n/ancestor::tei:seg[1]/@n
       order by $seg
       return kwic:summarize($n, <config width="60" link="{$seg}"/>)
   else <p>No results found.</p>
   return $nResults
(:}:)
(:<h3>Close (fuzzy) search results:</h3>:)
(:{let $cResults :=:)
(:if (count($closeMatches) > 0):)
(:then:)
(:    for $c in $closeMatches:)
(:(:  :let $uri := $e/tokenize(base-uri(), '/')[last()]:):)
(:let $seg := $c/ancestor::tei:seg[1]/@n:)
(:order by $seg:)
(:return kwic:summarize($c, <config width="60" link="{$seg}"/>):)
(:else <p>No results found.</p>:)
(:return $cResults:)
}
</div> 