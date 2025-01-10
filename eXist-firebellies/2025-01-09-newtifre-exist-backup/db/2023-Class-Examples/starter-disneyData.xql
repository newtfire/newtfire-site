xquery version "3.1"; 
let $disneySongs := collection('/db/disneySongs/')/xml
let $composerNodes := $disneySongs//composer
let $composers := $disneySongs//composer ! normalize-space() => distinct-values()

for $c in $composers
(: When you start a for loop, USE YOUR INDEX VARIABLE IN SOME WAY FROM NOW ON! :)
    let $cTitles := $disneySongs[descendant::composer ! normalize-space() = $c ]//metadata/title 
    (: this should be the titles for the current composer in the for statement :)
    let $bundleTitles := string-join($cTitles, ', ')
    return ($c || ' : ' || $bundleTitles)
    



