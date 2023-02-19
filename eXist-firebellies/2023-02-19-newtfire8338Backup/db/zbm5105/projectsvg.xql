xquery version "3.1";
declare variable $ySpacer := 10;
declare variable $xSpacer := 30;
declare variable $collection := collection('/db/seuss');
declare variable $ThisFileContent :=
<svg width="1000" height="1000">
<g transform="translate(200, 700)">

        <line x1="10" x2="600" y1="0" y2="0" stroke="blue"stroke-width="6"></line>
        <line x1="10" x2="10" y1="3" y2="-600" stroke="blue"stroke-width="6"></line>
        {
        for $i in (1 to 12)
        return
            <g>
                <text x="-15" y="-{$i *$ySpacer * 5-10}"stroke="green" rotate="20">{$i * 1}</text>
                <line x1="10" y1="-{$i *$ySpacer * 5}" x2="600" y2="-{$i *$ySpacer * 5}" style="stroke-dasharray: 10 5 10 5" stroke="blue"></line>
            </g>
            
        }
        
        <!--ebb: You can have two different for loops doing different things as long as you separate them with curly braces! :-) -->
        {
        for $c at $pos in $collection  
        (: This is the for loop that plots across the X axis, for each member
        of your Seuss book collection. Therefore, you should be plotting your 
        data about each book (for each $c output the linecount and character count inside this for loop.)
        :)
        return 
            <g>
            <text x="10" y="-{$pos *$xSpacer}" rotate="20" stroke="green" transform="rotate(90)">Book{$pos}</text>
            </g>    
        }    
            
             <text x="-45"y="-{50 *$ySpacer}" style="writing-mode: tb; glyph-orientation-vertical: 0;"stroke="green"rotate="20">NUMBER OF LINES</text>
             <text x="235" y="150" font-size="35"stroke="green"rotate="20">LINE COUNT OF BOOKS</text>
             <text x="275" y="-650" font-size="35" stroke="green"rotate="20">DR. SEUSS</text>
            
             
    </g>
    
</svg> ;

$ThisFileContent