xquery version "3.1";
let $drafts := collection('/db/starwars/fixed/')//xml

let $tSdCount := $drafts//sd => count()
let $tSpCount := $drafts//sp => count()
let $tLength := $tSdCount + $tSpCount

let $sortOrder := 
            for $d in $drafts
            let $date := $d//date/@date ! data()
            order by $date
            return $d

    for $sO at $pos in $sortOrder
        let $sDraft := $sO//metadata/draft ! data()
        let $sDate := $sO//metadata/date/@date ! data()
        let $sTitle := $sO//metadata/title ! data()
        let $spCount := $sO//sp => count()
        let $spkCount := $sO//sp/@spk ! data() ! normalize-space() => distinct-values() => count()
        let $sdCount := $sO//sd => count()
        let $sLength := $spCount + $sdCount
        let $rTwo := $sO//sp/@spk ! data("ARTWO") ! normalize-space() => distinct-values()
        let $dStar := $sO//setting ! data() ! normalize-space() => distinct-values()
        
let $sPercent := $sLength div $tLength * 100
let $sPercentLabel := $sPercent ! format-number(.,'#.##')

return $dStar
    (:<table>
    <tr>
        <td>{$dStar}</td>
        <td>{$sDraft}</td>
    </tr>
    </table>:)