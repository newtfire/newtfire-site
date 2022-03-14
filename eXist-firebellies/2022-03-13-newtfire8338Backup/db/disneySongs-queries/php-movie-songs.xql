xquery version "3.1";
let $disneySongs := collection('/db/disneySongs/')
let $movies := $disneySongs//movie
let $distinctMovies := $movies ! normalize-space() => distinct-values()
let $Aladdins := $distinctMovies[contains(., "Aladdin")]
let $BNBs := $distinctMovies[contains(., "Beauty")]
return
<section id="php-query">
    <ul>
        { for $a in $Aladdins
            return
                <li>{$a}
                    <ul>
                        {let $songMatches := $disneySongs//xml[descendant::movie ! normalize-space() = $a]
                         for $s in $songMatches
                         let $sTitle := $s/metadata/title ! normalize-space()
                         let $sFileName := $s ! base-uri() ! tokenize(., '/')[last()] ! substring-before(., '.xml') ! replace(., '[()]', '')
                         order by $sTitle
                         return
                             <li><a href="aladdin/{$sFileName}.html" target="titles">{$sTitle}</a></li>
                            
                        }
                    </ul>
                </li>
        }
    </ul>
    <ul>{for $b in $BNBs
        return 
            <li>{$b}
                 <ul>
                        {let $songMatches := $disneySongs//xml[descendant::movie ! normalize-space() = $b]
                         for $s in $songMatches
                         let $sTitle := $s/metadata/title ! normalize-space()
                         order by $sTitle
                         return
                             <li>{$sTitle}</li>
                            
                        }
                </ul>
            </li>
    }
    </ul>
</section>

