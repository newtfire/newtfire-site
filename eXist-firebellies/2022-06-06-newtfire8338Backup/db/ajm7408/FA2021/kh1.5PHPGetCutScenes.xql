xquery version "3.1";
declare variable $number := request:get-parameter('number', '63')[1];
let $kh1.5 := doc('/db/kingdomofhearts/FA2021_Scripts/FA2021_Kingdom_hearts_1.5_script.xml')/*
let $cutscene := $kh1.5//cutscene
(:  :let $years := $built/@when ! string() =>  distinct-values() => sort()
for $y in $years :)
let $cutsceneMatch := $cutscene[@cutNum ! normalize-space() = $number]
(: ebb: Also here we needed to correct the XPath so we return ONLY the cutscene elements whose @location attributes match the parameter. :)
    return 

    <div id="cutscene-{$number}">
    {let $elements := $cutsceneMatch/*
        for $e in $elements
        let $speaker := $e[name() = "sp"]/speaker ! string()
        return
        <div class="{$e ! name()}">
        
            {$e ! string()}
         </div>  
        
    }
    
    </div>