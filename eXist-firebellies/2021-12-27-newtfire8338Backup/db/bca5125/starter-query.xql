xquery version "3.1";
let $corpus := collection('/db/harryPotter/') 
let $fileAddresses := $corpus ! base-uri()
let $speakers := $corpus//sp/@who/string() ! normalize-space() ! tokenize(.,"\s+") => distinct-values() => sort()
for $s at $pos in $speakers
let $plays := $corpus[.//sp/@who/string() ! normalize-space() ! tokenize(.,"\s+") = $s]
for $p in $plays
    let $pTitle := $p//title
    let $pSpeeches := $p//sp[@who ! tokenize(.,"\s+$")[1] ! tokenize(string(), "\s+") = $s]
    let $pSpeechCount := $pSpeeches => count() 
    (:order by $pSpeechCount descending :)
return $pos || ", "|| $s || ": "|| $pTitle || " Speech Count: " || $pSpeechCount



(: A very simple FLWOR statement :)
(: FLWOR is:
 : for
 : let
 : where
 : order by
 : return 
 : Technically, since we always start with let, it should probably be called LFWOR! But we pronounce it like "flower," so FLWOR has stuck. :)
