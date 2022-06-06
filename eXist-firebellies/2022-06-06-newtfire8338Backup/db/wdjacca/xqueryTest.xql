xquery version "3.1";
<html>
    <head>
    <title> Xquery Test</title>
    </head>
    <body>
        <table><tr><th>Position</th><th>Section Title</th><th>Count of Speeches</th><th>Count of Speakers</th></tr>
{
let $collection :=doc('/db/assassinsCreed/assassinscreedodyssey.xml')
let $intro := $collection//intro
let $chapNum:= $collection//chapterNum
let $sect:= ($intro, $chapNum)
for $s at $pos in $sect
let $title :=
if ($s = $intro)
then "Intro"
else $s//chapTitles/text()
let $countSp := $s//sp => count()
let $countSpeaker := $s//speaker ! normalize-space() => distinct-values() => count()
order by $countSp descending
(:  :return concat('Position at For Loop: ',$pos, '. Section Title: ', $title, '. Count of Speeches: ', $countSp, '. Count of Speakers: ', $countSpeaker, '.'):)
    return
        <tr>
            <td>{$pos}</td><td>{$title}</td><td>{$countSp}</td><td>{$countSpeaker}</td></tr>
}
</table>
    
</body></html>