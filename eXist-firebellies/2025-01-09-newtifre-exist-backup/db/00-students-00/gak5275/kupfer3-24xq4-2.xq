xquery version "3.1";
<html>
    <head><title>Actors and their Roles</title></head>
    <body>
    <h1>Actors and their Roles in the Disney Songs Collection</h1>
    
    <table>
        <tr><th>Actor</th><th>Role</th></tr>
    {
    let $disneySongs := collection('/db/disneySongs/')
    let $actors := $disneySongs//voiceActor ! normalize-space() => distinct-values() => sort()
    let $roles := $disneySongs//@role ! normalize-space() => distinct-values() => sort()
    for $a in $actors
       let $aTitles := $disneySongs[.//voiceActor ! normalize-space() = $a] ! normalize-space() => distinct-values() => sort()
    for $r in $roles
       let $rTitles := $disneySongs[.//@role  ! normalize-space() = $r] ! normalize-space() => distinct-values() => sort()
    return
    <tr><td>{$a}</td><td>{$r}</td></tr> 
    }
    </table>
    </body>
</html>