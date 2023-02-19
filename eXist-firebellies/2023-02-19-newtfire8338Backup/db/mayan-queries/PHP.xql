xquery version "3.1";
declare variable $index := doc('/db/mayan/sitesIndex.xml/');
declare variable $godIndex := doc('/db/mayan/PV_characterIndex.xml/');
declare variable $sites := $index//Q{}mayanSites;
declare variable $gods := $godIndex//Q{}character;
<div>
    
  
<section id="dropdown">
     <button id="dropbutton">Choose a name of a Mayan deity: </button>
     <div id="godDropdown" class="dropdown-content">
      <input type="text" placeholder="Search..." id="godChoice" onkeyup="namefilter()" />
        
        <div id="god-names">
        <button onclick="myFunction()" class="dropbtn">Dropdown</button>
        <div id="godDropdown">
        { 
            for $g in $gods
            let $gname := $g/Q{}name ! data()
            return 
        
            <a id="{$g/@xml:id}">{$gname}</a>
        }
        </div>
        </div>
        </div>
 
        </section>
{
let $relics := $sites//Q{}relic
for $r in $relics
let $rname := $r/Q{}name ! data() 
let $type := $r/@type ! data()
let $desc := $r/Q{}desc ! normalize-space()
let $refgods := $r//Q{}gods
let $origin := $sites/Q{}site[.//Q{}relic/Q{}name = $r]/Q{}name ! normalize-space()

return 
<table id="{$r/@xml:id ! data()}">
    <tr>
       <th>Relic Name</th>
       <td>{$rname}</td>
    </tr>
    <tr>
        <th>Relic Type</th>
        <td>{$type}</td>
    </tr>
    <tr>
        <th>Relic Origin</th>
        <td>{$origin}</td>
        
    </tr>
    <tr>
        <th>Description</th>
        <td>{$desc}</td>
    </tr>
    <tr>
        <th>Gods Referenced</th>
        <td>{
                let $god := $refgods//Q{}deityName
                for $g in $god
                
              
            return 
                <li class="{$g/@godID ! data()}">{$g/text()}</li>
        }</td>
    </tr>
</table>
}

</div>