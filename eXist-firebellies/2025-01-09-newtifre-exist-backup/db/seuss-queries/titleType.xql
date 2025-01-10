xquery version "3.1";
declare variable $seuss := 
string-join(
let $seussBooks:= collection('/db/seuss/tsg-xml/')
for $s at $pos in $seussBooks 
    let $title:= $s//book/title ! normalize-space()
    let $type:= $s//book/metadata/@type ! normalize-space()
    
    return concat($title,"&#x9;", $type, "&#10;") );
    $seuss