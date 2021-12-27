xquery version "3.1";
let $disneySongs := collection('/db/disneySongs/')
let $linecount := $disneySongs//ln => count()
let $stringLengthsAll := 
   for $d at $pos in $disneySongs
    let $dtitle := $d//title
      let $dlinecount := $d//ln => count()
     let $dString := $d//song ! string-length()
     return $dString
(: ebb: I corrected this so it just returns $dString. Then each string-length gets stored as a series of values in $stringLengthsAll :)
let $maxStringLength := $stringLengthsAll => max()
let $minStringLength := $stringLengthsAll => min()
for $d at $pos in $disneySongs
let $dtitle := $d//title
let $dlinecount := $d//ln => count()
let $dString := $d//song ! string-length()
where $dString = $maxStringLength
(: You had where $dString eq $maxStringLength, and that wasn't working because we needed the other way to say equals, the literal = sign
 : eq is only allowed to match one value on the left with one value on the right. So we have to use = because $dString is a series of string-length values. If you ever see an error like this on a where statement just go and use = instead of eq. 
 :  :)
return concat($pos, ': ', $dtitle, ': ', $dlinecount, ': ', $dString)
