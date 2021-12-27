xquery version "3.1";
declare variable $newspaperArticles := collection('/db/btrees/articles/')/*;
declare variable $timelineSpacer := 100;
declare variable $meta := $newspaperArticles//meta;
declare variable $publisher := $meta//publisher;
declare variable $issueDate := $meta//issueDate; 
declare variable $date := $issueDate ! tokenize(., '-')[1] ! xs:integer(.);
declare variable $issuePage := $meta//issuePage; 
return $date 


$ThisFileContent