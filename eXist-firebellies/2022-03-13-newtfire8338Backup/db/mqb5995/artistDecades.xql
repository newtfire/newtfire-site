xquery version "3.1";
declare variable $ThisFileContent := string-join(
let $blues := collection('/db/blues')
let $recordDates := $blues//recordDate
let $noDatesTagged := $recordDates[not(date)]
let $nineteens := $noDatesTagged[matches(., "recording of 19\s*$")]
(: ebb: These seem to just stop after the number 19, so something got cut off. It affects 154 files. No four-digit year available in these files. :)
let $datesInside := $noDatesTagged ! analyze-string(., "\s\d{4}\s") ! fn:match ! text() ! normalize-space() => distinct-values()
let $DatesTagged := $recordDates//date ! normalize-space() => distinct-values()
let $allDates := ($datesInside, $DatesTagged)
let $decades := distinct-values(
    for $a in $allDates
    let $splitEnd := $a ! tokenize(., '^\d{3}')[last()]
    let $decade := xs:integer($a) - xs:integer($splitEnd)
    order by $decade ascending
    return $decade)
for $d in $decades
let $artistTaggedDates := $blues//metadata[xs:integer(.//recordDate/date[1] ! normalize-space()) - xs:integer(.//recordDate/date[1] ! normalize-space() ! tokenize(., '^\d{3}')[last()]) = $d]//artist ! normalize-space() => distinct-values()

let $artistUntaggedDates := $blues//metadata[xs:integer(.//recordDate ! analyze-string(., "\s\d{4}\s") ! fn:match[1] ! text() ! normalize-space()) - xs:integer(.//recordDate ! analyze-string(., "\s\d{4}\s") ! fn:match[1] ! text() ! normalize-space() ! tokenize(., '^\d{3}')[last()]) = $d]//artist ! normalize-space() => distinct-values()

let $artists := ($artistTaggedDates, $artistUntaggedDates)
for $a in $artists
return concat($a, "&#x9;", "artist", "&#x9;", $d, "&#x9;", "decade"), "&#10;");


let $filename := "bluesDecades-Artists.tsv"
let $doc-db-uri := xmldb:store("/db/mqb5995/", $filename, $ThisFileContent, "text/plain")
return $doc-db-uri
(: View this TSV (text/plain) file at http://newtfire.org:8338/exist/rest/db/mqb5995/bluesDecades-Artists.tsv  :)
