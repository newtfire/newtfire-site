xquery version "3.1";
let $charList := doc('/db/smashtiers/supersmashtierlist.xml')
let $names:= $charList//char ! string(@id)
for $n in $names
let $game := $charList//char[@id=$n]/game/@n ! string()
let $stringjoin := string-join($game,':')
return concat ($n,':',$stringjoin)