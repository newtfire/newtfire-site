xquery version "3.1";
let $disneySongs := collection('/db/disneySongs/')/xml
    
let $songLengthsAll :=
                 for $d in $disneySongs
                 let $length := $d//song ! string-length()(: your expression that returns string-length() here:)
                 return $length
(: ebb: I made a couple of corrections here! First, you had $length set like this:
 : $length := $d//song => string-length(). But it goes node by node, one at a time, to measure a string, so it can't use the arrow-operator. 
 : It needs the simple map or ! 
 : The other issue is, you need to return $length so each value can be stored as a sequence in $songLengthsAll. So I added the return statement 
 :  :)
       let $maxSongLength := $songLengthsAll => max()(: your expression to return the max() of the sequence of string-lengths now stored in $songLengthsAll:) 
       (:Here you had set the $maxSongLength := $length => max(), but $length isn't available and wouldn't work (it's just one calculation at a time inside the $songLengthsAll. $songLengthsAll holds ALL the song lengths, so you want to take the max() of those. :)
     return $maxSongLength