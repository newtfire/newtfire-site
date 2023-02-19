xquery version "3.1";
declare variable $sitesIndex := doc('/db/mayan/sitesIndex.xml/');
declare variable $godIndex := doc('/db/mayan/PV_characterIndex.xml/');
declare variable $sources := $sitesIndex//source;
declare variable $descSources := $sitesIndex//desc[@descSource];
declare variable $imgSources := $sitesIndex//img[@src];
declare variable $godSources := $godIndex//source;
declare variable $ThisFileContent :=
<html>
    <head>
        <title>Sources of Information</title>
        <meta charset="UTF-8" />
        <meta name="viewport" content="width=device-width, initial-scale=1.0" />
        <link rel="preconnect" href="https://fonts.gstatic.com" />
        <link href="https://fonts.googleapis.com/css2?family=New+Tegomin" rel="stylesheet" />
        <link href="https://fonts.googleapis.com/css2?family=Noto+Sans+Mayan+Numerals"
            rel="stylesheet" />
        <link href="https://fonts.googleapis.com/css2?family=Walter+Turncoat" rel="stylesheet" />
        <link href="https://fonts.googleapis.com/css2?family=Dokdo" rel="stylesheet" />
        <link href="https://fonts.googleapis.com/css2?family=Fredericka+the+Great" rel="stylesheet" />
        <link href="https://fonts.googleapis.com/css2?family=Frijole" rel="stylesheet" />
        <link href="https://fonts.googleapis.com/css2?family=New+Tegomin" rel="stylesheet" />
        <link href="https://fonts.googleapis.com/css2?family=Red+Hat+Display" rel="stylesheet" />
        <link href="https://fonts.googleapis.com/css2?family=Noto+Sans+Mayan+Numerals" rel="stylesheet"/> 
        <link rel="stylesheet" type="text/css" href="mayanStyling.css" />
        <link rel="shortcut icon" type="image/png" href="images/hieroglyphs/woman.jpg" />
    </head>
        <body>
            <header>
            <div class="titlePic">
                <h1><span><span class="head">Ancient</span><span class="head"> Mayans</span></span>
                    <span class="head">Digitized</span></h1>
                <img alt="eleven gods" class="headImg" src="images/designs/eleven_gods.png" />
            </div>
            <div class="navbar">
                <a class="nav" href="index.html">Home</a>
                <a class="nav" href="siteMap.html">Mayan Sites Map</a>
                <a class="nav" href="godography.html">God-ography</a>
                
                <a class="nav" href="3Dmodels.html">3D Models</a>
                <a class="nav" href="about.html">Project Team</a>
                <div class="dropdown">
                    <button class="dropbtn">Discover</button>
                    <div class="dropdown-content">
                        <a class="nav" href="sitesStructRelicsTimeline.html">Maya Sites
                            Timeline</a>
                        <a class="nav" href="godRelicRefs.html">Mayan Gods in Artifacts</a>
                        <a class="nav" href="godStructureRefs.html">Mayan Gods in Structures</a>
                    </div>
                </div> 
                <a class="nav" rel="license" href="http://creativecommons.org/licenses/by-nc/4.0/"
                        ><img alt="Creative Commons License" style="border-width:0"
                        src="https://i.creativecommons.org/l/by-nc/4.0/80x15.png" /></a>

            </div>
        </header>
        <h1 class="bib">Citations</h1>
        <section class="specBib">
            <h2>Leading Resources</h2>
            <p>
                Coe, Michael D., and Stephen D. Houston. <i>The Maya.</i> 9th ed., Thames &amp; Hudson, 2015.
            </p>
            <p>
                Special thanks and credit to Professor Bondar, instructor of the course of inspiration for this project: <a href="https://bulletins.psu.edu/search/?scontext=courses&amp;search=ANTH+221N">ANTH 221N; Ancient Maya Civilization</a>!
            </p>
        </section>
        <section class="bib">
        <div class="sitesources">
        <h2>Site Index Sources:</h2>
        
        
            {
                for $s in $sources
            let $href := $s/@href ! data()
            return 
                <ul>
                    <li><a href="{$href}">{$href}</a></li>
                    </ul>
            }
            {
                for $d in $descSources
                let $dLink := $d/@descSource ! data()
                return
                    <ul>
                        <li><a href="{$dLink}">{$dLink}</a></li>
                        </ul>
            }
            </div>
            
            <div class="godsources">
            <h2>God Index Sources:</h2>
            {
                for $g in $godSources
                let $ref := $g/@ref ! data()
                return
                    <ul>
                        <li><a href="{$ref}">{$ref}</a></li>
                    </ul>
            }
            
            </div>
            <div class="imgsources">
            <h2>Image Sources:</h2>
            {
                for $i in $imgSources
                let $src := $i/@src ! data()
                return
                    <ul>
                        <li><a href="{$src}">{$src}</a></li>
                        </ul>
            }
            </div>
            </section>
            <img class="banner" src="images/designs/chamaVase_rollout.jpg" />
        <footer>
            <div class="foot">
                <img class="foot" src="images/designs/angleGlyphs.png" />
                <div class="footLinks">
                    <p class="foot">Hosted on <a href="https://newtfire.org/">Newtfire</a></p>
                    <p class="foot">Check out this site on the <a href="https://mayan.newtfire.org/"
                            >Newtfire Server</a></p>
                </div>
                <div class="footLinks">
                    <p class="foot">View this <a href="https://github.com/am0eba-byte/mayan">project repo on GitHub</a></p>
                    <p class="foot"><a href="citations.html">Sources for our Data</a></p>
                </div>
                <img class="foot" src="images/designs/angleGlyph2.png" />
            </div>
        </footer>
            </body>
    </html>;

let $filename := "citations.html"
let $doc-db-uri := xmldb:store("/db/mayan-queries", $filename, $ThisFileContent, "html")
return $doc-db-uri 
(: Output at http://newtfire.org:8338/exist/rest/db/mayan-queries/citations.html :)  


