xquery version "3.1";
xquery version "3.1";
let $drafts:=collection('/db/starwars/fixed/')
let $sortOrder := 
            for $d in $drafts
            let $date := $d//date/@date ! data()
            order by $date
            return $d
            (:Answer to Question #2: Inside the $sortOrder varible, this varialbe is affecting how the dates are sorted, especially with the order that the dates appear in the document.:)
for $d in $date
let $date:= $d//date/@date ! data ()
for $sortOrder in collection('/db/starwars/fixed/')
where $date/date>0
order by $date/title
return $date/title
let $titles := $sortOrder[descendant::/db/starwars/fixed/ ! normalize-space() = $d]/db/starwars/fixed/ => count()
return $titles
(:ebb: Your explanation of the $sortOrder variable is correct in that it sorts the documents in the Star Wars collection by date. 
 : However, the XQuery variables you wrote after this point demonstrate a lot of confusion over what you are trying to do.
 : and you are not returning the data you need to on the exam. You need to be looping over the $sortOrder variable, 
 : which returns the drafts in chronological order. For each draft in that sorted collection, you can retrieve its date, its title, a count
 : of its speeches. I don't see evidence that you attempted to get this data out of the draft collection, so this exam is unsatisfactory work.
 :  :)