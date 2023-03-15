xquery version "3.1";
<kml>
{
let $mayan := doc('/db/mayan/sitesIndex.xml')/*
let $sites := $mayan//mayanSites/site
for $s in $sites
let $name := $s//name ! normalize-space()
let $desc := $s//desc ! normalize-space()
let $long := $s/location/@long ! xs:double(.)
let $lat := $s/location/@lat ! xs:double(.)

return
    <Placemark>
       <name>{$name}</name>
       <description>{$desc}</description>
       <Point>
           <coordinates>{$long},{$lat}</coordinates>
        </Point>
     </Placemark>  

}
</kml>