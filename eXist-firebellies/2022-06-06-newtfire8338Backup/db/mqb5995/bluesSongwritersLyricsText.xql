xquery version "3.1";
declare variable $ThisFileContent :=
string-join(
let $blues := collection('/db/blues')
let $songwriters := $blues//songwriter/name ! normalize-space() => distinct-values() => sort()
let $countWriters := $songwriters => count()

let $BBKing := $blues[.//songwriter/name ! normalize-space() => distinct-values() = "B.B. King"]//l/text()

let $HowlinWolf := $blues[.//songwriter/name ! normalize-space() => distinct-values() = "Chester Burnett a.k.a. Howlin' Wolf"]//l/text()

let $JLHooker := $blues[.//songwriter/name ! normalize-space() => distinct-values() = "John Lee Hooker"]//l/text()

let $MudWaters := $blues[.//songwriter/name ! normalize-space() => distinct-values() = "McKinley Morganfield a.k.a. Muddy Waters"]//l/text()

let $RobJohnson := $blues[.//songwriter/name ! normalize-space() => distinct-values() = "Robert Johnson"]//l/text()

let $Bessie := $blues[.//songwriter/name ! normalize-space() => distinct-values () = "Bessie Smith"]//l/text()

(:  :let $traditional := $blues[.//songwriter/name ! normalize-space() => distinct-values() = "traditional"]:)

let $traditional := $blues[.//songwriter/name ! normalize-space() => distinct-values() = "traditional"]//l/text()
(:  :for $t in $traditional
   (: let $traditTitles := $traditional//title:)
    let $traditArtists := $traditional//artist
    let $traditLyrics := $blues[.//songwriter/name ! normalize-space() = $t]//l/text():)
    
    return $Bessie) ;


let $filename := "BessieSmithLyr.txt"
let $doc-db-uri := xmldb:store("/db/mqb5995", $filename, $ThisFileContent, "text/plain")
return $doc-db-uri
(: (: TRADITIONAL output: http://newtfire.org:8338/exist/rest/db/mqb5995/traditionalBluesLyr.txt :) 
 : HOWLIN WOLF output: http://newtfire.org:8338/exist/rest/db/mqb5995/HowlinWolfBluesLyr.txt
 : JOHN LEE HOOKER output: http://newtfire.org:8338/exist/rest/db/mqb5995/JLHookerBluesLyr.txt
 : MUDDY WATERS output: http://newtfire.org:8338/exist/rest/db/mqb5995/MuddyWatersLyr.txt
 : ROBERT JOHNSON output: http://newtfire.org:8338/exist/rest/db/mqb5995/RobertJohnsonLyr.txt
 : BESSIE SMITH output: http://newtfire.org:8338/exist/rest/db/mqb5995/BessieSmithLyr.txt
 : :)


(:  :for $s in $songwriters
    let $songs := $blues[.//songwriter/name ! normalize-space() => distinct-values() = $s]//lyrics/l
    let $titles := $songs//title
    let $lyrics := $songs//lyrics/l
    let $countSongWriterSongs := $blues[.//songwriter/name ! normalize-space() => distinct-values() = $s] => count()

return concat ($s, " wrote ", $countSongWriterSongs):)
