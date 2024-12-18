xquery version "3.0";

(:~
 : Utility functions to find, install, upload and remove packages from the
 : package repository.
 :)
module namespace apputil="http://exist-db.org/xquery/apps";

import module namespace compression="http://exist-db.org/xquery/compression";
import module namespace map="http://www.w3.org/2005/xpath-functions/map";
import module namespace request="http://exist-db.org/xquery/request";
import module namespace util="http://exist-db.org/xquery/util";
import module namespace xmldb="http://exist-db.org/xquery/xmldb";

declare namespace err="http://www.w3.org/2005/xqt-errors";
declare namespace expath="http://expath.org/ns/pkg";
declare namespace repo="http://exist-db.org/xquery/repo";

declare variable $apputil:collection := "/db/system/repo";

declare variable $apputil:BAD_ARCHIVE := xs:QName("apputil:BAD_ARCHIVE");
declare variable $apputil:NOT_FOUND := xs:QName("apputil:NOT_FOUND");
declare variable $apputil:DEPENDENCY := xs:QName("apputil:DEPENDENCY");

(:~  
 : Cache abbreviation/collection of installed packages. Used to speed up
 : the apputil:resolve-abbrev function, which might be called many times
 : when displaying a page.
 :)
declare variable $apputil:PACKAGES :=
    map:merge(
        for $app in collection(repo:get-root())//expath:package
        return
            map:entry($app/@abbrev/string(), util:collection-name($app))
    );
    
(:~
 : Try to find an application by its unique name and return the relative path to which it
 : has been deployed inside the database.
 : 
 : @param $pkgURI unique name of the application
 : @return database path relative to the collection returned by repo:get-root() 
 : or the empty sequence if the package could not be found or is not deployed into the db
 :)
declare function apputil:resolve($uri as xs:string) as xs:string? {
    let $path := collection(repo:get-root())//expath:package[@name = $uri]
    return
        if ($path) then
            substring-after(util:collection-name($path), repo:get-root())
        else
            ()
};

(:~
 : Try to find an application by its abbreviated name and return the relative path to which it
 : has been deployed inside the database.
 : 
 : @param $pkgURI unique name of the application
 : @return database path relative to the collection returned by repo:get-root() 
 : or the empty sequence if the package could not be found or is not deployed into the db
 :)
declare function apputil:resolve-abbrev($abbrev as xs:string) as xs:string? {
    let $path := $apputil:PACKAGES($abbrev)
    return
        if ($path) then
            substring-after($path, repo:get-root())
        else
            ()
};

(:~
 : Locates the package identified by $uri and returns a path which can be used to link
 : to this package from within the HTML view of another package.
 : 
 : $uri the unique name of the package to locate
 : $relLink a relative path to be added to the returned path
 :)
declare function apputil:link-to-app($uri as xs:string, $relLink as xs:string?) as xs:string {
    let $app := apputil:resolve($uri)
    let $path := string-join((request:get-attribute("$exist:prefix"), $app, $relLink), "/")
    return
        replace($path, "/+", "/")
};

(:~
 : Retrieve an XML resource from the application package identified by the unique
 : name given in the first parameter. The resource is parsed an returned as an
 : XML document node.
 : 
 : @param $app the unique name of the application
 : @param $name relative path to the resource to retrieve
 : 
 :)
declare function apputil:get-resource($app as xs:string, $path as xs:string) as document-node()? {
    let $meta := repo:get-resource($app, $path)
    let $data := if (exists($meta)) then util:binary-to-string($meta) else ()
    return
        if (exists($data)) then
            parse-xml($data)
        else
            ()
};

(:~
 : Check if the application identified by the given unique name is installed. Returns
 : the package descriptor of the application if found or the empty sequence otherwise.
 : 
 : @param $pkgURI unique name of the application
 :)
declare function apputil:is-installed($pkgURI as xs:anyURI, $version as xs:string?) as element(expath:package)? {
    apputil:scan-repo(function($uri, $expath, $repo) {
        if ($uri = $pkgURI) then
            if (empty($version) or $expath/*/@version = $version) then
                $expath/*
            else
                ()
        else
            ()
    })
};

(:~
 : Install a package from the public repository. The package is either specified by its unique name
 : in the first parameter or its file name, e.g. "dashboard-0.1.xar".
 : 
 : @param $name unique name of the package to install (optional)
 : @param $package-path the file name of the package to install (optional)
 : @param $server-uri the URI of the public-repo app on the server
 : @return the empty sequence
 :)
declare function apputil:install-from-repo($name as xs:string?, $package-path as xs:anyURI?, $server-uri as xs:anyURI, $version as xs:string?) {
    let $server-uri :=
        if (ends-with($server-uri, "/modules/find.xql")) then
            $server-uri
        else
            xs:anyURI($server-uri || "/modules/find.xql")
    let $remove := apputil:remove($name)
    return
        repo:install-and-deploy($name, $version, $server-uri)
};

declare function apputil:install-from-repo($name as xs:string?, $package-path as xs:anyURI?, $server-uri as xs:anyURI) {
    apputil:install-from-repo($name, $package-path, $server-uri, ())
};

declare function apputil:upload($server-uri as xs:anyURI) as xs:string {
    let $pkg-metadata := apputil:store-upload()
    return
        apputil:deploy-upload($pkg-metadata, $server-uri)
};

(:~
 : Stores an uploaded XAR to the repo, and returns the metadata.
 :)
declare function apputil:store-upload() as element(pkg-metadata) {
    let $repocol := 
        if (collection($apputil:collection)) then
            ()
        else
            xmldb:create-collection('/db/system','repo')
    let $doc-name := request:get-uploaded-file-name("uploadedfiles[]")
    let $file := request:get-uploaded-file-data("uploadedfiles[]")
    return
        if ($doc-name) then
            let $stored := xmldb:store($apputil:collection, xmldb:encode-uri($doc-name), $file)
            return
                <pkg-metadata file-name="{$doc-name}" repo-path="{$stored}">{
                    try {
                        compression:unzip(
                            util:binary-doc($stored), apputil:entry-filter#3, 
                            (),  apputil:entry-data#4, ()
                        )
                    } catch * {
                        error($apputil:BAD_ARCHIVE, "Failed to unpack archive: " || $err:description)
                    }
                }</pkg-metadata>
        else
            error($apputil:BAD_ARCHIVE, "No file found")
};

(:~
 : Deploys an uploaded XAR to the database.
 :)
declare function apputil:deploy-upload($pkg-metadata as element(pkg-metadata), $server-uri as xs:anyURI) as xs:string {
    apputil:deploy-upload($pkg-metadata//expath:package/string(@name), $pkg-metadata/@repo-path, $pkg-metadata/@file-name, $server-uri)
};

(:~
 : Deploys an uploaded XAR to the database.
 :)
declare function apputil:deploy-upload($package as xs:string, $repo-path as xs:string, $file-name as xs:string, $server-uri as xs:anyURI) as xs:string {
    let $server-uri :=
        if (ends-with($server-uri, "/modules/find.xql")) then
            $server-uri
        else
            xs:anyURI($server-uri || "/modules/find.xql")
    (: TODO: We remove the current package before trying to install the new package. 
       This means if the new package's dependency checks fail and the repo can't satisfy them, we have deleted the package without installing the new one. 
       Consider checking dependencies before removing the current package. :)
    let $remove := apputil:remove($package)
    let $install :=
        repo:install-and-deploy-from-db($repo-path, $server-uri)
    return
        $file-name
};


(:~
 : Remove the package identified by its unique name.
 : 
 : @return true if the package could be removed, false otherwise
 :)
declare function apputil:remove($package-url as xs:string) as xs:boolean {
    if ($package-url = repo:list()) then
        let $undeploy := repo:undeploy($package-url)
        let $remove := repo:remove($package-url)
        return
            $remove
    else
        false()
};

(:~
 : Scan all installed application and library packages. Calls the provided callback function once for
 : every package, passing the package URI as first parameter, the expath pkg descriptor XML as second,
 : and the repo.xml descriptor as third.
 : 
 : @param $callback the callback function to call for every package found
 :)
declare function apputil:scan-repo($callback as function(xs:string, element(), element()?) as item()*) {
    for $app in repo:list()
    let $expathMeta := apputil:get-resource($app, "expath-pkg.xml")
    let $repoMeta := apputil:get-resource($app, "repo.xml")
    return
        $callback($app, $expathMeta, $repoMeta)
};

declare %private function apputil:unresolved-dependencies($expath as element(expath:package)) as element(expath:dependency)* {
    for $dependency in $expath/expath:dependency[@package]
    let $package := xs:anyURI($dependency/@package/string())
    return
        if (apputil:is-installed($package, $dependency/@version/string())) then
            ()
        else
            $dependency
};

declare %private function apputil:entry-data($path as xs:anyURI, $type as xs:string, $data as item()?, $param as item()*) as item()?
{
    if (starts-with($path, "icon")) then
        <icon>{$path}</icon>
    else
        <entry>
        	<path>{$path}</path>
    		<type>{$type}</type>
    		<data>{$data}</data>
    	</entry>
};

declare %private function apputil:entry-filter($path as xs:anyURI, $type as xs:string, $param as item()*) as xs:boolean
{
	starts-with($path, "icon") or $path = ("repo.xml", "expath-pkg.xml")
};
