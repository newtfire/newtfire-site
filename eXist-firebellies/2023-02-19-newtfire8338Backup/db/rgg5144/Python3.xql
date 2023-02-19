xquery version "3.1";
declare variable $ThisFileContent := string-join( 
    let $loz := collection('/db/zelda')
        let $oot := doc('/db/zelda/ocarina-of-time.xml')
        let $tp := doc('/db/zelda/twilight_princess.xml')
        let $fsa := doc('/db/zelda/four_swords_adventure.xml')
for $o at $pos in $oot
let $Oact := $oot//act
let $Ostage := $oot//stage ! normalize-space()
let $Ochoice := $oot//choice ! normalize-space()
let $Ointeract := $oot//interact ! normalize-space() 
let $Osp := $oot//sp/text() ! normalize-space() => distinct-values()
let $Ocharacter := $oot//act//character ! normalize-space()=> distinct-values()

for $t at $pos in $tp
let $Tact := $tp//act
let $Tstage := $tp//stage ! normalize-space()
let $Tchoice := $tp//choice ! normalize-space()
let $Tinteract := $tp//interact ! normalize-space() 
let $Tsp := $tp//sp/text() ! normalize-space() => distinct-values()
let $Tcharacter := $tp//act//character ! normalize-space()=> distinct-values()

for $f at $pos in $fsa
let $Fact := $fsa//act
let $Fstage := $fsa//stage ! normalize-space()
let $Fchoice := $fsa//choice ! normalize-space()
let $Finteract := $fsa//interact ! normalize-space() 
let $Fsp := $fsa//sp/text() ! normalize-space() => distinct-values()
let $Fcharacter := $fsa//act//character ! normalize-space()=> distinct-values()

let $combine := ($Ostage, $Ointeract, $Osp, $Tstage, $Tinteract, $Tsp, $Fstage, $Finteract, $Fsp)
return $combine, "&#10;") ;


let $filename := "Python3.txt"
let $doc-db-uri := xmldb:store("/db/rgg5144/", $filename, $ThisFileContent, "text/plain")
return $doc-db-uri 
(: View this text file at http://newtfire.org:8338/exist/rest/db/rgg5144/Python3.txt  :)
