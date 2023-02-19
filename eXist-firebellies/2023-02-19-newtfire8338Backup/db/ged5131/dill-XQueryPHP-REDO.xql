xquery version "3.1";
declare variable $newspaperArticles := collection('/db/btrees/articles/')/*;
(: let $newspaperArticles := collection('/db/btrees/articles/')/*:)
let $body := $newspaperArticles//body
let $header := $body//header 
let $meta := $newspaperArticles//meta
let $publisher := $meta//publisher
let $issueDate := $meta//issueDate => distinct-values() 
let $issuePage := $meta//issuePage 
let $title := $header//title ! normalize-space() => distinct-values() 
for $t in $title
let $artTitles := $body//header[title ! normalize-space() = $t] ! string() => distinct-values()
(:for $d in $issueDate
let $issueDate := $meta[.//* ! string() = d] => distinct-values():)
return 
<ul>
<li>
    <a href="dill-phpEx2-DIGIT-400-REDO.php?title={$t}">{$t}</a>
</li>
</ul>
(:  :return concat($a, "-----", $d, string-join('-----'),string-join($issuePage)):)



