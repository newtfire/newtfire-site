xquery version "3.1";
<html>
    <head>
        <title>XQuery Test- Star Wars </title>
    </head>
    
    <body>

{ 
(: Interested in looking at speeches <s> and speakers @spk :)
(: 1.establishing a connection  :)
    let $drafts:= collection('/db/starwars/fixed/')
(: return $sw:)
    let $sortOrder := $drafts
(: 2.Defining the output as $sortOrder, that for every instance of a $draft tag, perform the following for each thing ($s). :)
(: The following to perform is to give the data contained within the date attribute in the date element and define it by $date. :)
(: Order each instance of $s by its $date and return the value of $s only (which would be the data defined in $date for each $s). :)
(: 3.for loop that looks at each member and stores the positon for each member :)
(:  :let $sortOrder := $drafts
for $d in $drafts
  let $date := $d//date/@date ! data()
  let $member:= $d//sp/@spk ! data() 
  order by $date
  return $d:)
    for $s at $pos in $sortOrder
        (: 4.retrives date and title of each draft in the loop :)
        let $date := $s//date/@date ! data()
        let $title := $s//title ! normalize-space() 
        (: 5.counts all speakers in each draft of the loop :)
        let $spkCount := $s//sp => count()
        (: 6.gives each distinct speaker in each draft of the loop:)
        let $spkDiV := $s//sp/@spk ! normalize-space() => distinct-values()
        (: 7.counts each distinct speaker :)
        let $spkDivCount := $s//sp/@spk ! normalize-space() => distinct-values() =>count()
        (: 8. return concatenated values; count of distinct speakers and count of speeched in each draft:)  
        (:concat($pos,":",$title," ,Date:",$date," ,SpeechCount:",$spCount," ,SpeakerCount:",$spkDVCount):)
        return
         <table border="3">
            <tr>
                <th>Position</th> <th>Title</th> <th>Date</th> <th>Speech Count</th> <th>Speakers Count</th>
            </tr>
            <tr>
                <td>1</td> <td>{$drafts[1]//title ! normalize-space()}</td> <td>{$drafts[1]//date/@date ! data()}</td> <td>{$drafts[1]//sp =>count()}</td> <td>{$drafts[1]//sp/@spk ! normalize-space() =>distinct-values() =>count()}</td>
            </tr>
            <tr>
                <td>2</td> <td>{$drafts[2]//title ! normalize-space()}</td> <td>{$drafts[2]//date/@date ! data()}</td> <td>{$drafts[2]//sp =>count()}</td> <td>{$drafts[2]//sp/@spk ! normalize-space() =>distinct-values() =>count()}</td>
            </tr>
            <tr>
                <td>3</td> <td>{$drafts[3]//title ! normalize-space()}</td> <td>{$drafts[3]//date/@date ! data()}</td> <td>{$drafts[3]//sp =>count()}</td> <td>{$drafts[3]//sp/@spk ! normalize-space() =>distinct-values() =>count()}</td>
            </tr>
            <tr>
                <td>4</td> <td>{$drafts[4]//title ! normalize-space()}</td> <td>{$drafts[4]//date/@date ! data()}</td> <td>{$drafts[4]//sp =>count()}</td> <td>{$drafts[4]//sp/@spk ! normalize-space() =>distinct-values() =>count()}</td>
            </tr>
            <tr>
                <td>5</td> <td>{$drafts[5]//title ! normalize-space()}</td> <td>{$drafts[5]//date/@date ! data()}</td> <td>{$drafts[5]//sp =>count()}</td> <td>{$drafts[5]//sp/@spk ! normalize-space() =>distinct-values() =>count()}</td>
            </tr>
        </table>   
}
    </body>
</html>   
            
