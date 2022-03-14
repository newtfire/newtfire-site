xquery version "3.1";
let $corpus := collection('/db/harryPotter/') 
let $fileAddresses := $corpus ! base-uri()
let $speakers := $corpus//sp/@who/string() ! tokenize(.,"\s+") => distinct-values() => sort()
for $s at $pos in $speakers

return $pos || ", "|| $s




(: A very simple FLWOR statement :)
(: FLWOR is:
 : for
 : let
 : where
 : order by
 : return 
 : Technically, since we always start with let, it should probably be called LFWOR! But we pronounce it like "flower," so FLWOR has stuck. :)
