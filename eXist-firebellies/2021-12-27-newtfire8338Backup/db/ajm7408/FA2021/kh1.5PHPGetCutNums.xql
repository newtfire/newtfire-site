xquery version "3.1";
declare variable $location := request:get-parameter('location', 'DestinyIslands');
(: ebb: Austin, I got this working by first just returning all your `@location attribute values. Then I saw that
 : you'd initially input "Destiny Island" but there really was no such value. "Destiny Islands" is the correct parameter! :)
let $kh1.5 := doc('/db/kingdomofhearts/FA2021_Scripts/FA2021_Kingdom_hearts_1.5_script.xml')/*
let $cutscene := $kh1.5//cutscene
(:  :let $years := $built/@when ! string() =>  distinct-values() => sort()
for $y in $years :)
let $cutNums := $kh1.5//cutscene[@location ! string() = $location]/@cutNum ! string()
(: ebb: Also here we needed to correct the XPath so we return ONLY the cutscene elements whose @location attributes match the parameter. :)
for $n in $cutNums
    return 

        <li><a href="kh1.5GetCutScenes.php?number={$n}" target="cutscenes">{$n}</a></li>