xquery version "3.1";
(: Find out which Star Wars drafts are the longest in character count. :)
(:   :Calculate as percentage.  :)
let $starWars := collection('/db/starwars/')
(: Organize the collection in chronological order from earliest to latest draft: :)
let $chronSequence := 
            for $s in $starWars
            let $date := $s//metadata/date
            order by $date
            return $s
            
let $stringLengths := $starWars ! string-length() 
(: The simple map operator (!) returns one string-length for each document in the collection. :)
let $totalStringLength := $stringLengths => sum()
(: The arrow operator sends the sequence of string-lengths to the sum() function. :)
(: Write a for loop to get information to output for each document: :)
for $s in $chronSequence
let $sDraft := $s//metadata/draft ! normalize-space()
let $sLength := $s ! string-length()
let $sPercent := $sLength div $totalStringLength * 100
let $sPercentLabel := $sPercent ! format-number(., '#.##')
(: a special function to output as many decimal places as we want. Converts number to text string. :)
return concat($sDraft, ': ', $sPercentLabel)


