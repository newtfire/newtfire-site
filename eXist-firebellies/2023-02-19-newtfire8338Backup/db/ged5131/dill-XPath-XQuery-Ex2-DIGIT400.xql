xquery version "3.1";
let $newspaperArticle := collection('/db/ged5131/articles/')/*
let $body := $newspaperArticle//body
let $header := $body//header 
let $title := $header//title ! normalize-space() => distinct-values()
let $p := $body//p
let $orgs := $p/org ! normalize-space() => distinct-values()
for $o in $orgs
let $orgparas := $body//p[org ! normalize-space() = $o]/@n ! string()
let $orgtitles := $body[.//org ! normalize-space() = $o]//header/title/text()
return concat($o, '----- ', string-join($orgparas, ', '), string-join(' ----- '), string-join($orgtitles))
