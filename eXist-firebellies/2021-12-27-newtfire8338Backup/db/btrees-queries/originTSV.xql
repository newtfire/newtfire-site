xquery version "3.1";

declare variable $originfile := doc('/db/btrees/btrees_tree_book.xml');
declare variable $ThisFileContent:=
string-join(
let $contNodes := $originfile//continent
let $contIDs := 