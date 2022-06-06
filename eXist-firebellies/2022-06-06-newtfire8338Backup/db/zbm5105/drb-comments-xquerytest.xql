xquery version "3.1";
<html>
<head>    
    <title>Star Wars</title>
</head>
<body>
<!--ebb: Your original code was plotting 5 different tables, one for each draft.That comes out kind of 
difficult to read because the header is repeated over and over. Basically, you just want ONE table, and have five rows inside it. 
So, I moved the table element and its top header row up here, so you create just ONE table, not five different ones!
That means you get each row stacked underneath the others and it comes out easier to read, with just one header row
at the top. -3 pts -->
    <table border="4">
        <tr>
            <th><b>Pos</b></th> <th><b>Title</b></th> <th><b>Date</b></th> <th><b>Speeches</b></th> <th><b>Speakers</b></th>
        </tr>
{
let $drafts := collection('/db/starwars/fixed/')
(:  :return $drafts:)
let $sortOrder := $drafts
(: ebb: WAIT. You are not using the $sortOrder variable from my exam. That means you are not going
 : to be working with the scripts sorted by date. All you did here was rename the $drafts variable, so
 : you lost the sort information. -2 pts :)
for $s at $pos in $sortOrder            
(: for $d in $drafts
let $date := $d//date/@date ! data()
order by $date :)
let $title := $s//title ! normalize-space()
let $date := $s//date/@date ! data()
let $spCount := $s//sp => count()
let $spk := $s//sp/@spk ! normalize-space()=> distinct-values()  
let $spkCount := $s//sp/@spk ! normalize-space() => distinct-values()=> count()
(: return concat($pos," Title ",$title," Date ",$date," spCount ",$spCount," spkCount ",$spkCount) :)
return
   
    
        <tr>
            <th>{$pos}</th> <th>{$title}</th> <th>{$date}</th> <th>{$spCount}</th> <th>{$spkCount}</th>
        </tr>
    
}
</table>
</body>
</html>
(: Question1 - let $drafts := collection('/db/starwars/fixed/'):)

(: Question2 - The sort order variable is returning all of the dates of the starwars drafts from the oldest books to the newest books:)
(: ebb: No, it's returning the Star Wars draft files *sorted* by date from earliest to latest.  :)
(: Question3 - for $s at $pos in $sortOrder :)

(: Question 4 - let $title := $s//title - let $date := $s//date:)

(: Question 5 - let $sp := $s//sp => count() - return $sp :)

(: Question 6 - let $spk := $s//sp/@spk ! normalize-space()=>distinct-values() - return $spk:)

(: Question 7 - let $spkCount := $s//sp/@spk ! normalize-space()=> distinct-values() => count() - return $spkCount :)

(: Question 8 - return concat($pos," Title ",$title," Date ",$date," spCount ",$spCount," spkCount ",$spkCount) :)
