xquery version "3.1";
(:  :declare variable $ThisFileContent := string-join( :)
let $talks := doc('/db/starwars/fixed/ANHroughDraft.xml')
let $artwo := $talks//sp[@spk = "ARTWO"] ! normalize-space()
  
  
return ($artwo)