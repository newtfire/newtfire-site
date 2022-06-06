xquery version "3.1";
<html>
    <head><title>Movie Names and Voice Actors</title></head>
    <body>
    <h1>Movie Names and Voice Actors in the Disney Songs Collection</h1>
    
    <table>
        <tr><th>No.</th><th>Movie Title</th><th>Voice Actors</th><th>Song Titles</th></tr>
    {
let $movieTitle := collection('/db/disneySongs/')//movie
(: ebb: This is stepping into the movie titles too soon. Let's just back up and work with the collection so you have each whole XML tree to work with. 
 : The problem here is that your next variable for voiceActors is NOT a descendant of movie titles. But it IS a descendant of the collection. 
 : What you probably need to be doing is setting up a for loop through each whole file in the collection, like this:
 : 
 : let $disneyColl := collection('/db/disneySongs/')
 : for $d in $disneyColl
 : let $movie := $d//movie
 : (:more variables here with info from each song, like its composer, and its voice actors.:)
 :
 : Then keep on going from there to get other information. That would be going song by song.  
 :
 : It's not really clear to me what you're trying to loop through here.Your voiceActor variable doesn't return anything 
 : because voiceActor elements are not descendants of <title> elements in the source code. So there's nothing to loop through here and you're getting no output.
 : BEFORE you start a for loop, make sure you're getting output. I would start this one over and be really clear with yourself about the source code you're working with
 : and exactly what you want to be outputting. 
 : 
 : You have options here. You can loop through each song file in the collection (like I suggested above). OR you can loop through each distinct movie (there are only like 5 in the whole collection I think). Or you can loop through each distinct voiceActor, or composer. When you do these other kinds of loops, and take distinct values and sort, you have to go back up to the whole collection once you're inside the loop to go and find the data *related* to that particular thing you're looping on. 
 : So if it's looping through one of the 5 movie titles, you need to reach into the whole collection and find where its files hold that movie title, and go looking for its voice actors. 
 : 
 : I'd like you to revise this one so you're clear on the thinking process you need to be working these loops. 
 :  :)
let $voiceActor := $movieTitle//voiceActor ! normalize-space() => distinct-values() => sort()
     for $c at $pos in $voiceActor
       let $cTitles := $movieTitle[.//voiceActor ! normalize-space() = $c]
     return
       <tr>
          <td>{$pos}</td><td>{$c}</td><td>{$cTitles}</td> 
               
        </tr> 
   }
   </table>
</body>
</html>
