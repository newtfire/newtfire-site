xquery version "3.1";
declare variable $tsv := string-join(
    let $drafts := collection('/db/starwars/fixed/')
    for $d in $drafts
    let $draft := $d//draft ! normalize-space() => distinct-values()
    let $speaker := $d//sp/@spk ! tokenize(., '\(|\[')[1] ! tokenize(., '['']')[1] ! normalize-space()[not(contains(., 'VOICE'))] => distinct-values()
(: ebb: I added two tokenize() functions to your pipeline to try and remove stage directions and simplify the output. 
 See anything weird here?  :)
        for $s in $speaker
    
        return  concat("Draft:", "&#x9;", $draft, "&#x9;", "Character:", "&#x9;", $s), "&#10;");


declare variable $filetsv := "starWarsCharacters.tsv";
declare variable $doc-db-uri := xmldb:store("/db/jbg5721/", $filetsv, $tsv, "text/plain");
$tsv

