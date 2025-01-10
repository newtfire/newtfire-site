xquery version "3.1";
declare variable $btrees := collection('/db/btrees/')/*;
declare variable $entries := $btrees//entry;
<div>
<section id="selection">
     <label for="commonChoice">Choose the common name of a tree: </label>
        <input id="commonChoice" list="common-names" />
        
        <datalist id="common-names">
        
        { 
            for $e in $entries
            let $cname := $e/cname ! data()
            return 
        
            <option id="c_{$e/@xml:id}" value="{$cname}"/>
        }
        </datalist>
  <label for="scientChoice">Choose the scientific name of a tree: </label>
        <input id="scientChoice" list="scientific-names" />
        
        <datalist id="scientific-names">
        
        { 
            for $e in $entries
            let $sname := $e/sname ! data()
            return 
        
            <option id="s_{$e/@xml:id}" value="{$sname}"/>
        }
        </datalist>
        </section>
{
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
<table id="{$e/@xml:id}">
    <tr>
       <th>Common Name</th>
       <td>{$cname}</td>
    </tr>
    <tr>
        <th>Scientific Name</th>
        <td>{$sname}</td>
    </tr>
    <tr>
        <th>Tree Type</th>
        <td>{$type}</td>
    </tr>
    <tr>
        <th>Conservation Status</th>
        <td>{$status}</td>
    </tr>
    <tr>
        <th>Origin Location</th>
        <td>{$origin}</td>
    </tr>
    <tr>
        <th>Height</th>
        <td>{$height}</td>
    </tr>
    <tr>
        <th>Seed Type</th>
        <td>{$seed}</td>
    </tr>
    <tr>
        <th>Leaf Description</th>
        <td>{$leaf}</td>
    </tr>
    <tr>
        <th>Description</th>
        <td>{$desc}</td>
    </tr>
    <tr class="deco">
        <td></td>
        <td><img src="leaf_breaker.png" alt="decorative leaf"/></td>
    </tr>
</table>
}

</div>
