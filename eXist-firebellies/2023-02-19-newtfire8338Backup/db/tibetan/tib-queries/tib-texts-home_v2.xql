xquery version "3.1";
declare namespace bcrd="http://www.bcrdb.org/ns/1.0";

declare option exist:serialize "method=xhtml media-type=text/html";
declare variable $page-title := "Buddhist Canons Research Database";
declare variable $versionid := "ver. 3.0 (beta 16)";

(: tib-texts-home.xql ver. 2.01, 2019-10-15 :)
(: tib-texts-home.xql ver. 2.02, 2020-03-28 :)

<html>
    <head>
        <meta HTTP-EQUIV="Content-Type" content="text/html; charset=UTF-8"/>
        <title>{$page-title}</title>
    </head>
    <body>
        <center><h1>{$page-title}</h1></center>
        <center><h3>{$versionid}</h3></center>
		<br/>
		<h3>Search Tibetan full-text (literal phrase) using XQuery:</h3>
		<form method="POST" action="search-TIB_new.xql">
			<input type="text" name="searchphrase" size="40"/>
			<input type="submit" value="Search!"/>
		</form>
		<br/>
		<br/>
		<h3>Search Sanskrit full-text (literal phrase) using XQuery:</h3>
		<form method="POST" action="search-SKT_new.xql">
			<input type="text" name="searchphrase" size="40"/>
			<input type="submit" value="Search!"/>
		</form>
		<br/>
		<br/>
		<h3>or display Tibetan by ID (e.g. 2-03-00256-D1445):</h3>
		<form method="POST" action="test-apply-xslt.xql">
			<input type="text" name="searchphrase" size="40"/>
			<input type="submit" value="Search!"/>
		</form>
		<br/>
		<br/>
		<h3>or display Sanskrit by ID (e.g. 2-03-00256-SKT01):</h3>
		<form method="POST" action="test-apply-xslt-skt.xql">
			<input type="text" name="searchphrase" size="40"/>
			<input type="submit" value="Search!"/>
		</form>
		<br/>
		<br/>
		<h3>or display Tibetan statistics by ID (e.g. 2-03-00256-D1445):</h3>
		<form method="POST" action="test-apply-xslt-tibsyll.xql">
			<input type="text" name="searchphrase" size="40"/>
			<input type="submit" value="Search!"/>
		</form>
		<br/>
		<h3>or render table of eXisting text parallels by ID (e.g. 2-03-00256):</h3>
		<form method="POST" action="tabulate_parallel_text2.xql">
			<input type="text" name="searchphrase" size="40"/>
			<input type="submit" value="Search!"/>
		</form>
		<br/>
    </body>
</html>
