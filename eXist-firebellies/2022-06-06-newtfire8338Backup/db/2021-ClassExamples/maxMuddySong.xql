xquery version "3.1";
declare variable $blues := collection('/db/blues'); 


let $metadata := $blues//metadata


let $maxMuddySong := max(
     let $muddies := $blues[.//artist ! normalize-space() = "Muddy Waters"]
      for $m at $pos in $muddies
      let $mLength := $m//lyrics ! string-length()
      order by $mLength descending
      return $mLength)
let $muddyMaxSongTitle := $blues[.//artist ! normalize-space() = "Muddy Waters"][.//lyrics ! string-length() = $maxMuddySong]//title

return concat($muddyMaxSongTitle, ': ', $maxMuddySong)


