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
return 
<ul>
<li>
    {$newspaperArticles}
</li>
</ul>

