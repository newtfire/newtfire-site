xquery version "3.1";
declare variable $ySpacer := 20;
declare variable $xSpacer := 30;
declare variable $increment1 := 2;
declare variable $increment2 := 50;
declare variable $increment3 := 1;
declare variable $color1 := "blue";
declare variable $thisFileContent :=

<html>
    <head>
        <title>Seuss</title>
    </head>
    <body style="margin: 0px;">
                
        <div class="box" style="background-color:lightblue">
                
            <h1>
                Dr. Seuss Book Data Overview
            </h1>
                
        <svg class="Character Count" height="400" width="350">
                
            {
            let $book := collection('/db/luh429/')
            for $i in (0 to 9)
            for $b at $pos in $book
            let $title := $b//title =>data()
            let $char := $b//char/@name =>distinct-values()
            return
                
            <g transform="translate(100,210)">
                
                <text x="20" y="-185" fill="{$color1}" font-size="25" >Character Count</text>
                <line x1="0" y1="0" x2="0" y2="-{$i * $ySpacer}" stroke="{$color1}" stroke-width="1" />
                <line x1="0" y1="0" x2="{$pos * $xSpacer + $xSpacer}" y2="0" stroke="{$color1}" stroke-width="1" />
                
                <text x="100" y="-25" fill="{$color1}" font-size="15" transform="rotate(-90)" text-anchor="middle">Number of Characters</text>
                <text x="-15" y="-{$i * $ySpacer + 0.5}" fill="{$color1}" font-size="10">{$i * $increment1}</text>
                <line x1="1" y1="-{$i * $ySpacer + 0.5}" x2="{$pos * $xSpacer + $xSpacer}" y2="-{$i * $ySpacer + 0.5}" style="stroke-dasharray: 1 1 1 1" stroke="white" />
                
                <text x="0" y="20" fill="{$color1}" font-size="15">Books</text>
                <text x="30" y="-{$pos * $xSpacer - 5}" fill="{$color1}" transform="rotate(90)" font-size="10">{$b//title =>data()}</text>
                <line x1="{$pos * $xSpacer}" x2="{$pos * $xSpacer}" y1="-0.5" y2="-{$char=>count() * $ySpacer div $increment1  + 0.5}" stroke="orange" stroke-width="{$xSpacer div 2}"/>
             
                <text x="-75" y="75" fill="{$color1}" font-size="15">Mean: {round($book//char/@name =>distinct-values() =>count() div $book//title =>count())}</text>
                
            </g>
            }
        </svg>
                
        <svg class="Line Count" height="400" width="5000">
                
            {
            let $book := collection('/db/seuss/')
            for $i in (0 to 9)
            for $b at $pos in $book
            let $title := $b//title =>data()
            let $lineS := $b//s =>count()
            let $lineL := $b//l =>count()
            let $line := $lineS + $lineL
            return
                
            <g transform="translate(100,210)">
                
                <text x="20" y="-185" fill="{$color1}" font-size="25" >Line Count</text>
                <line x1="0" y1="0" x2="0" y2="-{$i * $ySpacer}" stroke="{$color1}" stroke-width="1" />
                <line x1="0" y1="0" x2="{$pos * $xSpacer + $xSpacer}" y2="0" stroke="{$color1}" stroke-width="1" />
                
                <text x="100" y="-25" fill="{$color1}" font-size="15" transform="rotate(-90)" text-anchor="middle">Number of Lines</text>
                <text x="-15" y="-{$i * $ySpacer + 0.5}" fill="{$color1}" font-size="10">{$i * $increment2}</text>
                <line x1="1" y1="-{$i * $ySpacer + 0.5}" x2="{$pos * $xSpacer + $xSpacer}" y2="-{$i * $ySpacer + 0.5}" style="stroke-dasharray: 1 1 1 1" stroke="white" />
                
                <text x="0" y="20" fill="{$color1}" font-size="15">Books</text>
                <text x="30" y="-{$pos * $xSpacer - 5}" fill="{$color1}" transform="rotate(90)" font-size="10">{$b//title =>data()}</text>
                <line x1="{$pos * $xSpacer}" x2="{$pos * $xSpacer}" y1="-0.5" y2="-{$line * $ySpacer div $increment2 + 0.5}" stroke="orange" stroke-width="{$xSpacer div 2}"/>
                
                <text x="-75" y="75" fill="{$color1}" font-size="15">Mean: {round($book//s =>count() + $book//l =>count() div $book//title =>count())}</text>
             
            </g>
            }
        </svg>
            
            
        <svg class="Made up Word Count" height="400" width="350">
                
            {
            let $book := collection('/db/luh429/')
            for $i in (0 to 9)
            for $b at $pos in $book
            let $title := $b//title =>data()
            let $mUp := $b//mUp =>distinct-values()
            return
                
            <g transform="translate(100,210)">
                
                <text x="20" y="-185" fill="{$color1}" font-size="25" >Made up Word Count</text>
                <line x1="0" y1="0" x2="0" y2="-{$i * $ySpacer}" stroke="{$color1}" stroke-width="1" />
                <line x1="0" y1="0" x2="{$pos * $xSpacer + $xSpacer}" y2="0" stroke="{$color1}" stroke-width="1" />
                
                <text x="100" y="-25" fill="{$color1}" font-size="15" transform="rotate(-90)" text-anchor="middle">Number of Made up Words</text>
                <text x="-15" y="-{$i * $ySpacer + 0.5}" fill="{$color1}" font-size="10">{$i * $increment3}</text>
                <line x1="1" y1="-{$i * $ySpacer + 0.5}" x2="{$pos * $xSpacer + $xSpacer}" y2="-{$i * $ySpacer + 0.5}" style="stroke-dasharray: 1 1 1 1" stroke="white" />
                
                <text x="0" y="20" fill="{$color1}" font-size="15">Books</text>
                <text x="30" y="-{$pos * $xSpacer - 5}" fill="{$color1}" transform="rotate(90)" font-size="10">{$b//title =>data()}</text>
                <line x1="{$pos * $xSpacer}" x2="{$pos * $xSpacer}" y1="-0.5" y2="-{$mUp =>count() * $ySpacer div $increment3 + 0.5}" stroke="orange" stroke-width="{$xSpacer div 2}"/>
             
                <text x="-75" y="75" fill="{$color1}" font-size="15">Mean: {round($book//mUp =>distinct-values() =>count() div $book//title =>count())}</text>
             
            </g>
            }
        </svg>
        
        </div>
        
        
        
        {
            let $book := collection('/db/luh429/')
            for $b in $book
            let $title := $b//title =>data()
            let $char := $b//char/@name =>distinct-values()
            let $lineS := $b//s =>count()
            let $lineL := $b//l =>count()
            let $line := $lineS + $lineL
            let $mUp := $b//mUp =>distinct-values()
            let $sound := $b//sound =>distinct-values()
            let $genre := $b//metadata/@genre ! normalize-space()
            return
               
        <div class="box">
            
            <h1>
                {$title}
            </h1>
            
            <h2>
                Book Type: {$genre}
            </h2>
            
            <hr/>
            
            <h2>
                Characters:
            </h2>
            
            <ul>
            {
            for $c in $char
            return
                <li>{$c}</li>}
            </ul>
            
            <h2>
                Character Count: {$char =>count()}
            </h2>
            
            <hr/>
            
            <h2>
                Line Count: {$line}
            </h2>
            
            <hr/>
            
            <h2>
                Made up Words:
            </h2>
            
            <ul>
            {
            for $m in $mUp
            return
                <li>{$m}</li>}
            </ul>
            
            <h2>
                Made up Word Count: {$mUp =>count()}
            </h2>
            
            <hr/>
            
            <h2>
                Sounds:
            </h2>
            
            <ul>
            {
            for $s in $sound
            return
                <li>{$s}</li>}
            </ul>
            
            <h2>
                Sound Count: {$sound =>count()}
            </h2>
            
            <hr/>
            
        </div>
        }
    </body>
</html>;
$thisFileContent