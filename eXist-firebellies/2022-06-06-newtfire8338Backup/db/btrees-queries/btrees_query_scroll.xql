xquery version "3.1";

<html>
    <head>
        <title>Table of Behrend Trees</title>
    </head>
    <body>
        <h1>Meet the Trees</h1>
        <list>
{
let $btrees := collection('/db/btrees/')/*
let $entries := $btrees//entry
for $e in $entries
let $cname := $e/cname ! data() 
let $sname := $e/sname ! normalize-space()
let $desc := $e/desc ! normalize-space()
let $type := $e/treeType ! normalize-space()
let $status := $e/status ! normalize-space()
let $origin := $e/origin ! normalize-space()
let $height := $e/height ! normalize-space()
let $seed := $e/seed ! normalize-space()
let $leaf := $e/leaf ! normalize-space()
return 
   <ul>
        <li>
            <h2>Common Name: </h2>{$cname}
        </li>
        <li>
            <h2>Scientific Name: </h2>{$sname}
        </li>
        <li>
            <h2>Tree Type: </h2>{$type}
        </li>
        <li>
        <h2>Conservation Status: </h2>{$status}
        </li>
        <li>
            <h2>Origin Location: </h2>{$origin}
        </li>
        <li>
            <h2>Height: </h2>{$height}
        </li>
        <li>
        <h2>Seed Type: </h2>{$seed}
        </li>
        <li>
            <h2>Description: </h2>{$desc}
        </li>
        <li>
            <h2>Leaf Description </h2>{$leaf}
        </li>
        <li>
            <h3>______________________________________</h3>
        
        </li>
        <br></br>
    </ul>
}
   </list>
</body>
</html>

(:  :let $autoColl := collection('/db/btrees')/*
let $entries := $autoColl//entry
for $e in $entries
let $cname := $e/cname ! data()
let $sname := $e/sname ! normalize-space()
let $desc := $e/desc ! normalize-space()
return concat($cname,', ', $sname, ': ', $desc)

xquery version "3.1";
let $autoColl := collection('/db/auto')/*
let $entries := $autoColl//entry
for $e in $entries
let $built := $e/built/@when ! data()
let $name := $e/name ! normalize-space()
return concat($built, ': ', $name)
:)
