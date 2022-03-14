xquery version "3.1";
let $lrcoll := collection('/db/letsrock/')/*
let $songs := $lrcoll//song
let $istories  := $lrcoll//i/@story ! string()
let $countstories := $istories => count()
let $distinct-stories := $istories => distinct-values()
let $stringjoin := string-join($distinct-stories, '!!! ')
return $stringjoin
