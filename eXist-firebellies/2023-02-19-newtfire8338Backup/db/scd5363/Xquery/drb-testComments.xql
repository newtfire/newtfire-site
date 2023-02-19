xquery version "3.1";
<html>
    <head>
        <title>Star Wars</title>
    </head>
            <body>
                <!-- You want to wrap the <table> around the outside of the FLWOR, because
                you only need ONE table, with multiple rows inside it. -->
               <table border ="1">
                    <tr>
                        <th>pos</th>
                        <th>Title </th>
                        <th>Date</th>
                        <th>Speech Count </th>
                        <th>Speaaker Count</th>
                    </tr>
                {
                let $drafts := collection('/db/starwars/fixed/')
                let $sortOrder := $drafts
                (:ebb: Wait, you actually removed the nested FLWOR that I included in the
                test that would sort the $drafts. What you SHOULD have here is:
                   let $sortOrder := 
                            for $d in $drafts
                            let $date := $d//date/@date ! data()
                            order by $date
                            return $d
                     (-3 pts)
                :)
                for $s at $pos in $sortOrder  
                    (: this for loop takes element drafts and turns it in to element d :)
                    (: then it makes date = date from the drafts via element d:)
                    (: next it orders the dates chronological or by date then it returns the d variable and should get us all of the drafts in order by date
                    ebb: I think you made a mistake here in copying in the code for the test, and your comments are intended to be for the for loop that you actually removed earlier in the exam! 
                    :)
                let $date := $s//date/@date ! data()
                let $title := $s//title ! normalize-space() 
                let $spkCount := $s//sp => count()
                let $spkDiV := $s//sp/@spk ! normalize-space() => distinct-values()
                let $spkDivCount := $s//sp/@spk ! normalize-space() => distinct-values() =>count()
                (:concat ($pos," ",$title," ",$date," ", $spkCount," ", $spkDivCount):)
                return
                
               
                    <tr>
                        <th>{$pos}</th>
                        <th>{$title} </th>
                        <th>{$date}</th>
                        <th>{$spkCount} </th>
                        <th>{$spkDivCount}</th>
                    </tr>
             
                }
            <!-- ebb: See how we finish out the table BELOW the XQuery FLWOR portion?
            Notice how much tidier this makes your output: you don't output an entire new table with the same table headings, but instead pack all the content into just ONE table.
            (-3 pts)
            -->    
                </table>
    </body>
</html>
        (:  for $d in $drafts
            let $date := $d//date/@date ! data()
            order by $date
            return $d:)