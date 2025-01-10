xquery version "3.1";
let $disney := collection('/db/disneySongs/')/*
let $all :=
    for $d in $disney
        let $title := $d//title
        let $song := $d//song
        let $line := $song//ln
        let $lc := $line => count()
        let $songSL := $song => string-length()
        let $SLmax := $all => max()
        let $SLmin := $all => min()
        where $songSL = $SLmax
        let $collect := concat($title, " ", $lc, " ", $songSL)
        return $collect