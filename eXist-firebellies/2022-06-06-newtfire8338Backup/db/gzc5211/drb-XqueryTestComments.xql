xquery version "3.1";
<html>
    <head>
        <title>Star War</title>
    </head>
<body>
<!--ebb: If you plot the outside portion of the table outside the FLWOR,
you don't repeat so much of it. 
-->    
    <table>
           <tr>
            <th>Pos</th>
            <th>Title</th>
            <th>Date</th>
            <th>SpCount</th>
            <th>SPKcount</th>
        </tr>
            {
            let $drafts := collection ('/db/starwars/fixed/')
(:  :return $drafts:)

let $sortOrder := $drafts
for $s at $pos in $sortOrder

(:#2 i think this flower can give us the time order from the old to new :)
(: for $d in $drafts
let $date := $d//date/@date ! data()
order by $date:)
let $date :=$s//date/@date ! data()
let $title :=$s//title ! normalize-space()
let $spcount :=$s//sp => count()
let $spk:=$s//sp/@spk ! normalize-space()=>distinct-values() 
let $spkC:=$s//sp/@spk ! normalize-space()=>distinct-values() => count()

(:  :return concat($pos,"Title",$title,"Date",$date,"spcount",$spcount,"spkC",$spkC):)
return 

        <tr>
            <td>{$pos}</td>
            <td>{$title}</td>
            <td>{$date}</td>
            <td>{$spcount}</td>
            <td>{$spkC}</td>
        </tr>

            }   
      <!--ebb: The only thing you need to be outputting repeatedly is a row for each draft. You don't need 
a new table of each draft, just a row inside it. -->       
    </table>
</body>
        
</html>