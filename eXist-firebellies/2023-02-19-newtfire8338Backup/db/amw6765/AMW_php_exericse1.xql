xquery version "3.1";
declare variable $index := doc('/db/mayan/sitesIndex.xml');
declare variable $sites := $index//Q{}mayanSites/Q{}site;



<div>
<section id="selection">
     <label for="commonChoice">Choose the common name of a tree: </label>
        <input id="commonChoice" list="common-names" />
        
        <datalist id="common-names">
        
        { 
            for $s in $sites
            let $siteName := $s/Q{}name ! data()
            return 
        
            <option id="c_{$s/@xml:id}" value="{$siteName}"/>
        }
        </datalist>
        </section>
{
for $s in $sites
let $siteName := $s/Q{}name ! data() 
let $yStart := $s/Q{}dateActive/@yearStart ! data()
let $yEnd := $s/Q{}dateActive/@yearEnd ! data()
let $location := $s/Q{}location
let $latLong := concat($location/@lat, ' ', $location/@long)
let $mArtifacts := $s/Q{}artifacts
let $mStructures := $s/Q{}height ! normalize-space()
return 
<table id="{$s/@xml:id}">
    <tr>
       <th>Site Name</th>
       <td>{$siteName}</td>
    </tr>
    <tr>
        <th>Year Start</th>
        <td>{$yStart}</td>
    </tr>
    <tr>
        <th>Year End</th>
        <td>{$yEnd}</td>
    </tr>
    <tr>
        <th>Latitude &amp; Longitude</th>
        <td>{$latLong}</td>
    </tr>
    <tr>
        <th>Artifacts</th>
        <td>{let $relic := $mArtifacts/Q{}relic
            for $r in $relic
            return
                <li>{$r/name}</li>
        }</td>
    </tr>
    <tr>
        <th>Structure</th>
        <td>{let $building := $mStructures/Q{}building
            for $b in $building
            return 
                <li>{$b/name}</li>
        }</td>
    </tr>
</table>
}

</div>

