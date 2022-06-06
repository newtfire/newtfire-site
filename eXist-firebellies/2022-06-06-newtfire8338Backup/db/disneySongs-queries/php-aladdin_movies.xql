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
                <li class="movieList">{$a}
                    <ul>
                        {let $songMatches := $disneySongs//xml[descendant::movie ! normalize-space() = $a]
                         for $s in $songMatches
                         let $sTitle := $s/metadata/title ! normalize-space()
                         let $sFileName := $s ! base-uri() ! tokenize(., '/')[last()] ! substring-before(., '.xml') ! replace(., '[()]', '')
                         order by $sTitle
                         return
                             <li class="phplist"><a href="aladdin/{$sFileName}.html" target="titles">{$sTitle}</a></li>
                            
                        }
                    </ul>
                </li>
        }
    </ul>
</section>