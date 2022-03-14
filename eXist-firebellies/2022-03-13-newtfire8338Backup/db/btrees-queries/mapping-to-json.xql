xquery version "3.1";
declare namespace output="http://www.w3.org/2010/xslt-xquery-serialization";
declare option output:method "json";
declare option output:media-type "application/json";

declare variable $btrees := collection('/db/btrees/')/*;
declare variable $treebook := doc('/db/btrees/btrees_tree_book.xml');
declare variable $entries := $btrees//entry;
declare variable $ThisFileContent := $treebook;
$ThisFileContent
