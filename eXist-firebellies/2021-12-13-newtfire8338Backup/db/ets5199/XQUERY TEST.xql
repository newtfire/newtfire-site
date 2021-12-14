xquery version "3.1";
<html>
    <head><title>Assassin's Creed</title></head>
    <body>
    <h1>Assassin's Creed Chapters, Speakers, and Speachers</h1>
    
    <table>
        <tr><th>Intro</th><th>Chapters</th><th>Chapter Titles</th><th>Speaches</th><th>Speakers</th><th>count</th></tr>
{
let $Creed := collection('/db/assassinsCreed/')
let $Aintro := $Creed//intro ! normalize-space()
let $Achap := $Creed//chapter ! normalize-space()
let $AChapNum := $Creed//chapterNum ! normalize-space() => distinct-values() => sort()
    for $A at $pos in $AChapNum
        let $Atitles := ($Creed[.//chapterNum ! normalize-space() = $A]//chapTitles)[1] ! normalize-space()
        let $Aspeaches := $Creed[.//chapterNum ! normalize-space() = $A]//sp ! normalize-space() => sort() => string-join(', ')
        let $Aspeakers := $Creed[.//chapterNum ! normalize-space() = $A]//speaker ! normalize-space() => distinct-values() => sort() => string-join(', ')
        let $count := count($Creed//speaker)
        order by $count descending
    return <tr>
        <td>{$Aintro}</td><td>{$pos}</td><td>{$A}</td><td>{$Atitles}</td><td>{$Aspeaches}</td><td>{$Aspeakers}</td><td>{$count}</td>
        </tr>
}
    </table>
</body>
</html>