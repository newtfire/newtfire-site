xquery version "3.1";
let $lrcoll := collection('/db/letsrock/')/*
let $songs := $lrcoll//song
let $istories := $lrcoll//i/@story ! string()

