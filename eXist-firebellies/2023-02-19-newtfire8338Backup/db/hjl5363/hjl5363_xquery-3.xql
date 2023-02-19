xquery version "3.1";
collection('/db/disneySongs/')
let $disneySongs := collection('/db/disneySongs/')//*
for $d in $disneySongs
for $d in $title
return $title
let $d => string-length()
order by => descending
return $concat()
let $songLengthsAll :=
for $d in $disneySongs
let $length := (: your expression that returns string-length() here:)
return $length
let $maxSongLength := (: your expression to return the max() of the sequence of string-lengths now stored in $songLengthsAll:)
for $title => concat()