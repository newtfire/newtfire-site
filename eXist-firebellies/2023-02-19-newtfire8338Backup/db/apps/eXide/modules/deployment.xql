(:
 :  eXide - web-based XQuery IDE
 :
 :  Copyright (C) 2011 Wolfgang Meier
 :
 :  This program is free software: you can redistribute it and/or modify
 :  it under the terms of the GNU General Public License as published by
 :  the Free Software Foundation, either version 3 of the License, or
 :  (at your option) any later version.
 :
 :  This program is distributed in the hope that it will be useful,
 :  but WITHOUT ANY WARRANTY; without even the implied warranty of
 :  MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
 :  GNU General Public License for more details.
 :
 :  You should have received a copy of the GNU General Public License
 :  along with this program.  If not, see <http://www.gnu.org/licenses/>.
 :)
xquery version "3.1";

import module namespace apputil="http://exist-db.org/apps/eXide/apputil" at "util.xql";
import module namespace tmpl="http://exist-db.org/xquery/template" at "tmpl.xql";
import module namespace dbutil="http://exist-db.org/xquery/dbutil" at "dbutils.xql";

(:~
    Edit the expath and repo app descriptors.
    Functions to read, update the descriptors and deploy an app.
:)
declare namespace deploy="http://exist-db.org/eXide/deploy";
declare namespace expath="http://expath.org/ns/pkg";
declare namespace repo="http://exist-db.org/xquery/repo";

declare variable $deploy:app-root := request:get-attribute("app-root");

declare variable $deploy:ANT_FILE :=
    <project default="xar" name="$$app$$">
         <xmlproperty file="expath-pkg.xml"/>
        <property name="project.version" value="${{package(version)}}"/>
        <property name="project.app" value="$$app$$"/>
        <property name="build.dir" value="build"/>
        <target name="xar">
            <mkdir dir="${{build.dir}}"/>
            <zip basedir="." destfile="${{build.dir}}/${{project.app}}-${{project.version}}.xar"
                excludes="${{build.dir}}/*"/>
        </target>
    </project>;

(: Handle difference between 4.x.x and 5.x.x releases of eXist :)
declare variable $local:copy-resource :=
    let $fnNew := function-lookup(xs:QName("xmldb:copy-resource"), 4)
    return
        if (exists($fnNew)) then
            $fnNew
        else
            let $fnOld := function-lookup(xs:QName("xmldb:copy"), 3)
            return
                function($sourceCol, $sourceName, $targetCol, $targetName) {
                    $fnOld($sourceCol, $targetCol, $sourceName)
                };

declare function deploy:select-option($value as xs:string, $current as xs:string?, $label as xs:string) {
    <option value="{$value}">
    { if (exists($current) and $value eq $current) then attribute selected { "selected" } else (), $label }
    </option>
};

declare function deploy:store-expath($collection as xs:string?, $userData as xs:string*, $permissions as xs:string?) {
    let $includeAll := request:get-parameter("includeall", ())
    let $descriptor :=
        <package xmlns="http://expath.org/ns/pkg"
            name="{request:get-parameter('name', ())}" abbrev="{request:get-parameter('abbrev', ())}"
            version="{request:get-parameter('version', ())}" spec="1.0">
            <title>{request:get-parameter("title", ())}</title>
            {
                if (empty($includeAll)) then
                    <dependency package="http://exist-db.org/apps/shared"/>
                else
                    ()
            }
        </package>
    return (
        xmldb:store($collection, "expath-pkg.xml", $descriptor, "text/xml"),
        let $targetPath := xs:anyURI($collection || "/expath-pkg.xml")
        return (
            sm:chmod($targetPath, $permissions),
            sm:chown($targetPath, $userData[1]),
            sm:chgrp($targetPath, $userData[2])
        )
    )
};

declare function deploy:repo-descriptor() {
    <meta xmlns="http://exist-db.org/xquery/repo">
        <description>
        {
            let $desc := request:get-parameter("description", ())
            return
                if ($desc) then $desc else request:get-parameter("title", ())
        }
        </description>
        {
            for $author in request:get-parameter("author", ())
            return
                <author>{$author}</author>
        }
        <website>{request:get-parameter("website", ())}</website>
        <status>{request:get-parameter("status", ())}</status>
        <license>GNU-LGPL</license>
        <copyright>true</copyright>
        <type>{request:get-parameter("type", "application")}</type>
        {
            let $target := request:get-parameter("target", ())
            return
                if (exists($target)) then
                    <target>{$target}</target>
                else
                    ()
        }
        <prepare>{request:get-parameter("prepare", ())}</prepare>
        <finish>{request:get-parameter("finish", ())}</finish>
        {
            if (request:get-parameter("owner", ())) then
                let $group := request:get-parameter("group", ())
                return
                    <permissions user="{request:get-parameter('owner', ())}"
                        password="{request:get-parameter('password', ())}"
                        group="{if ($group != '') then $group else 'dba'}"
                        mode="{request:get-parameter('mode', ())}"/>
            else
                ()
        }
    </meta>
};

declare function deploy:store-repo($descriptor as element(), $collection as xs:string?, $userData as xs:string*, $permissions as xs:string?) {
    (
        xmldb:store($collection, "repo.xml", $descriptor, "text/xml"),
        let $targetPath := xs:anyURI($collection || "/repo.xml")
        return (
            sm:chmod($targetPath, $permissions),
            sm:chown($targetPath, $userData[1]),
            sm:chgrp($targetPath, $userData[2])
        )
    )
};

declare function deploy:mkcol-recursive($collection, $components, $userData as xs:string*, $permissions as xs:string?) {
    if (exists($components)) then
        let $permissions :=
            if ($permissions) then
                deploy:set-execute-bit($permissions)
            else
                "rwxr-x---"
        let $newColl := xs:anyURI(concat($collection, "/", $components[1]))
        let $exists := xmldb:collection-available($newColl)
        return (
            xmldb:create-collection($collection, $components[1]),
            if (exists($userData) and not($exists)) then (
                sm:chmod($newColl, $permissions),
                sm:chown($newColl, $userData[1]),
                sm:chgrp($newColl, $userData[2])
            ) else
                (),
            deploy:mkcol-recursive($newColl, subsequence($components, 2), $userData, $permissions)
        )
    else
        ()
};

declare function deploy:mkcol($path, $userData as xs:string*, $permissions as xs:string?) {
    let $path := if (starts-with($path, "/db/")) then substring-after($path, "/db/") else $path
    return
        deploy:mkcol-recursive("/db", tokenize($path, "/"), $userData, $permissions)
};

declare function deploy:create-collection($collection as xs:string, $userData as xs:string+, $permissions as xs:string) {
    let $target := collection($collection)
    return
        if ($target) then
            $target
        else
            deploy:mkcol($collection, $userData, $permissions)
};

declare function deploy:check-group($group as xs:string) {
    if (sm:group-exists($group)) then
        ()
    else
        sm:create-group($group)
};

declare function deploy:check-user($repoConf as element()) as xs:string+ {
    let $perms := $repoConf/repo:permissions
    let $user := if ($perms/@user) then $perms/@user/string() else sm:id()//sm:real/sm:username/string()
    let $group := if ($perms/@group) then $perms/@group/string() else sm:get-user-groups($user)[1]
    let $create :=
        if (sm:user-exists($user)) then
            if (index-of(sm:get-user-groups($user), $group)) then
                ()
            else (
                deploy:check-group($group),
                sm:add-group-member($user, $group)
            )
        else (
            deploy:check-group($group),
            sm:create-account($user, $perms/@password, $group, ())
        )
    return
        ($user, $group)
};

declare function deploy:target-permissions($repoConf as element()) as xs:string {
    let $permissions := $repoConf/repo:permissions/@mode/string()
    return
        if ($permissions) then
            if ($permissions castable as xs:int) then
                sm:octal-to-mode($permissions)
            else
                $permissions
        else
            "rw-rw-r--"
};

declare function deploy:set-execute-bit($permissions as xs:string) {
    replace($permissions, "(..).(..).(..).", "$1x$2x$3x")
};

declare function deploy:copy-templates($target as xs:string, $source as xs:string, $userData as xs:string+, $permissions as xs:string) {
    let $null := deploy:mkcol($target, $userData, $permissions)
    return
    if (xmldb:collection-available($source)) then (
        for $resource in xmldb:get-child-resources($source)
        let $targetPath := xs:anyURI(concat($target, "/", $resource))
        return (
            $local:copy-resource($source, $resource, $target, $resource),
            let $mime := xmldb:get-mime-type($targetPath)
            let $perms :=
                if ($mime eq "application/xquery") then
                    deploy:set-execute-bit($permissions)
                else $permissions
            return (
                sm:chmod($targetPath, $perms),
                sm:chown($targetPath, $userData[1]),
                sm:chgrp($targetPath, $userData[2])
            )
        ),
        for $childColl in xmldb:get-child-collections($source)
        return
            deploy:copy-templates(concat($target, "/", $childColl), concat($source, "/", $childColl), $userData, $permissions)
    ) else
        ()
};

declare function deploy:store-templates-from-db($target as xs:string, $base as xs:string, $userData as xs:string+, $permissions as xs:string) {
    let $template := request:get-parameter("template", "basic")
    let $templateColl := concat($base, "/templates/", $template)
    return
        deploy:copy-templates($target, $templateColl, $userData, $permissions)
};

declare function deploy:chmod($collection as xs:string, $userData as xs:string+, $permissions as xs:string) {
    (
        let $collURI := xs:anyURI($collection)
        return (
            sm:chmod($collURI, $permissions),
            sm:chown($collURI, $userData[1]),
            sm:chgrp($collURI, $userData[2])
        ),
        for $resource in xmldb:get-child-resources($collection)
        let $path := concat($collection, "/", $resource)
        let $targetPath := xs:anyURI($path)
        let $mime := xmldb:get-mime-type($path)
        let $perms :=
            if ($mime eq "application/xquery") then
                deploy:set-execute-bit($permissions)
            else
                $permissions
        return (
            sm:chmod($targetPath, $permissions),
            sm:chown($targetPath, $userData[1]),
            sm:chgrp($targetPath, $userData[2])
        ),
        for $child in xmldb:get-child-collections($collection)
        return
            deploy:chmod(concat($collection, "/", $child), $userData, $permissions)
    )
};

declare function deploy:store-ant($target as xs:string, $permissions as xs:string) {
    let $abbrev := request:get-parameter("abbrev", "")
    let $parameters :=
        <parameters>
            <param name="app" value="{$abbrev}"/>
        </parameters>
    let $antXML := tmpl:expand-template($deploy:ANT_FILE, $parameters)
    return
        xmldb:store($target, "build.xml", $antXML)
};

declare function deploy:expand($collection as xs:string, $resource as xs:string, $parameters as element(parameters)) {
    if (util:binary-doc-available($collection || "/" || $resource)) then
        let $code :=
            let $doc := util:binary-doc($collection || "/" || $resource)
            return
                util:binary-to-string($doc)
        let $expanded := tmpl:parse($code, $parameters)
        return
            xmldb:store($collection, $resource, $expanded)
    else
        ()
};

declare function deploy:expand-xql($target as xs:string) {
    let $name := request:get-parameter("name", ())
    let $includeTmpl := request:get-parameter("includeall", ())
    let $template :=
        if ($includeTmpl) then
            "at &quot;templates.xql&quot;"
        else
            ""
    let $parameters :=
        <parameters>
            <param name="templates" value="{$template}"/>
            <param name="namespace" value="{$name}/templates"/>
            <param name="config-namespace" value="{$name}/config"/>
        </parameters>
    let $storeTemplates := deploy:shared-modules($includeTmpl, $target)
    for $module in ("view.xql", "app.xql", "config.xqm")
    return
        deploy:expand($target || "/modules", $module, $parameters)
};

declare function deploy:shared-modules($includeTmpl, $target) {
    if ($includeTmpl) then
        let $templatesFile := repo:get-resource("http://exist-db.org/apps/shared", "content/templates.xql")
        let $templates := util:binary-to-string($templatesFile)
        return
                xmldb:store($target || "/modules", "templates.xql", $templates, "application/xquery")
    else
        ()
};

declare function deploy:store-templates-from-fs($target as xs:string, $base as xs:string, $userData as xs:string+, $permissions as xs:string) {
    let $pathSep := util:system-property("file.separator")
    let $template := request:get-parameter("template", "basic")
    let $templatesDir := concat($base, $pathSep, "templates", $pathSep, $template)
    return (
        xmldb:store-files-from-pattern($target, $templatesDir, "**/*", (), true(), "**/.svn/**"),
        deploy:chmod($target, $userData, $permissions)
    )
};

declare function deploy:store-templates($target as xs:string, $userData as xs:string+, $permissions as xs:string) {
    let $base := substring-before(system:get-module-load-path(), "/modules")
    return
        if (starts-with($base, "xmldb:exist://")) then
            deploy:store-templates-from-db($target, $base, $userData, $permissions)
        else
            deploy:store-templates-from-fs($target, $base, $userData, $permissions)
};

declare function deploy:store($collection as xs:string?, $expathConf as element()?) {
    let $collection :=
        if (starts-with($collection, "/")) then
            $collection
        else
            repo:get-root() || $collection
    let $repoConf := deploy:repo-descriptor()
    let $permissions := deploy:target-permissions($repoConf)
    let $userData := deploy:check-user($repoConf)
    return
        if (not($collection)) then
            error(QName("http://exist-db.org/xquery/sandbox", "missing-collection"), "collection parameter missing")
        else
            let $create := deploy:create-collection($collection, $userData, $permissions)
            let $null := (
                deploy:store-expath($collection, $userData, $permissions),
                deploy:store-repo($repoConf, $collection, $userData, $permissions),
                if (empty($expathConf)) then (
                    deploy:store-templates($collection, $userData, $permissions),
                    deploy:store-ant($collection, $permissions),
                    deploy:expand-xql($collection)
                ) else
                    ()
            )
            return
                $collection
};

declare function deploy:create-app($collection as xs:string?, $expathConf as element()?) {
    let $collection := deploy:store($collection, $expathConf)
    return
        if (empty($expathConf)) then
            let $expathConf := doc($collection || "/expath-pkg.xml")/*
            return (
                deploy:deploy($collection, $expathConf),
                util:declare-option("exist:serialize", "method=json media-type=application/json"),
                <ok>{ $collection }</ok>
            )
        else (
            util:declare-option("exist:serialize", "method=json media-type=application/json"),
            <ok>{ $collection }</ok>
        )
};

declare function deploy:view($collection as xs:string?, $expathConf as element()?, $repoConf as element()?) {
    let $null := util:declare-option("exist:serialize", "method=html media-type=text/html")
    return
        <form>
            {
                if ($collection) then (
                    <input type="hidden" name="collection" value="{$collection}"/>,
                    <h3>Package collection: {$collection}</h3>
                ) else
                    ()
            }
            <fieldset>
                <legend>Application Properties</legend>
                <ol>
                    {
                        if (empty($repoConf)) then
                            <li>
                                <div class="hint">The template to use for generating the basic package structure.</div>
                                <select name="template">
                                    <option value="existdb" selected="selected">eXist-db Design</option>
                                    <option value="bootstrap">Plain (using Bootstrap CSS)</option>
                                    <option value="plain">Empty package</option>
                                </select>
                                <label for="template">Template:</label>
                            </li>
                        else
                            ()
                    }
                    <li>
                        <div class="hint">Type of the package: a library contains XQuery modules and resources, but no web interface.</div>
                        <select name="type">
                            <option value="application">Application</option>
                            <option value="library">Library</option>
                        </select>
                        <label for="type">Type of the package:</label>
                    </li>
                    <!--li>
                        <div class="hint">By default some XQuery libraries and other resources will be imported from the "shared-resources" package.
                            The generated package will thus have a dependancy on "shared-resources". Check this to avoid the dependency.
                        </div>
                        <input type="checkbox" name="includeall"/>
                        <label for="includeall">Include all libraries</label>
                    </li-->
                    <li>
                        <div class="hint">A relative path to the collection where the package will be installed below the repository root. Leave
                            this empty if the package does not need to be deployed into the database.
                        </div>
                        <input type="text" name="target" value="{$repoConf/repo:target}"
                            placeholder="app-collection" size="40" required="required"/>
                        <label for="target">Target collection:</label>
                    </li>
                    <li><hr/></li>
                    <li>
                        <div class="hint">The name of the package. This must be a URI.</div>
                        <input type="url" name="name" placeholder="http://exist-db.org/apps/yourapp" required="required"
                            value="{if ($expathConf) then $expathConf/@name else ''}" size="40"/>
                        <label for="name">Name:</label>
                    </li>
                    <li>
                        <div class="hint">A short name for the app. This will be the name of the collection into which
                        the app is installed.</div>
                        <input type="text" name="abbrev" placeholder="Short name"
                            value="{$expathConf/@abbrev}" size="25" required="required"/>
                        <label for="abbrev">Abbreviation:</label>
                    </li>
                    <li>
                        <div class="hint">A descriptive title for the application.</div>
                        <input type="text" name="title" value="{$expathConf/expath:title}" size="40" required="required"/>
                        <label for="title">Title:</label>
                    </li>
                    <li>
                        <input type="text" name="version" value="{if ($expathConf) then $expathConf/@version else '0.1'}"
                            size="10" required="required"/>
                        <label for="version">Version:</label>
                    </li>
                    <li>
                    {
                        let $status := $repoConf/repo:status/string()
                        return
                            <select name="status">
                                { deploy:select-option("alpha", $status, "Alpha") }
                                { deploy:select-option("beta", $status, "Beta") }
                                { deploy:select-option("stable", $status, "Stable") }
                                { deploy:select-option("SNAPSHOT", $status, "Snapshot") }
                            </select>
                    }
                        <label for="status">Status:</label>
                    </li>
                    <li><hr/></li>
                    <li>
                        <div class="hint">Optional: name of an XQuery script which will be run <b>before</b> the
                        application is installed. Use this to create users, index configurations and the like.</div>
                        <input type="text" name="prepare" value="{if ($repoConf) then $repoConf/repo:prepare else 'pre-install.xql'}"
                            placeholder="pre-install.xql" size="40"/>
                        <label for="prepare">Pre-install XQuery:</label>
                    </li>
                    <li>
                        <div class="hint">Optional: name of an XQuery script which will be run <b>after</b> the
                        application was installed.</div>
                        <input type="text" name="finish" value="{$repoConf/repo:finish}" size="40"
                            placeholder="post-install.xql"/>
                        <label for="finish">Post-install XQuery:</label>
                    </li>
                </ol>
            </fieldset>
            <fieldset>
                <legend>Description</legend>
                <ol>
                    <li>
                        <div class="hint">The author(s) of the application.</div>
                        <label for="author">Author:</label>
                        <ul class="author-repeat">
                        {
                            if (empty($repoConf)) then
                                <li class="repeat"><input type="text" name="author" size="25"/></li>
                            else
                                for $author in $repoConf/repo:author
                                return
                                    <li class="repeat"><input type="text" name="author" value="{$author}" size="25"/></li>
                        }
                            <li><button id="author-add-trigger">Add</button><button id="author-remove-trigger">Remove</button></li>
                        </ul>
                    </li>
                    <li>
                        <div class="hint">A longer description of the application.</div>
                        <textarea name="description" cols="40">{$repoConf/repo:description/text()}</textarea>
                        <label for="description">Description:</label>
                    </li>
                    <li>
                        <div class="hint">Link to the author's website.</div>
                        <input type="url" name="website" value="{$repoConf/repo:website}" size="40"/>
                        <label for="website">Website:</label>
                    </li>
                </ol>
            </fieldset>
            <fieldset>
                <legend>Default Permissions</legend>

                <p>Default permissions applied to all resources uploaded into the database. To set
                non-default permissions on particular resources, use a post-install script. If a user
                and password is specified, it will be created upon install if it does not yet exist.
                </p>
                {
                    let $owner := $repoConf/repo:permissions/@user
                    let $password := $repoConf/repo:permissions/@password
                    let $group := $repoConf/repo:permissions/@group
                    let $mode := $repoConf/repo:permissions/@mode
                    return
                        <ol>
                            <li>
                                <input type="text" name="owner" value="{$owner}" size="20"/>
                                <label for="owner">Owner:</label>
                            </li>
                            <li>
                                <input type="password" name="password" value="{$password}" size="20"/>
                                <label for="owner">Password:</label>
                            </li>
                            <li>
                                <input type="text" name="group" value="{$group}" size="20"/>
                                <label for="owner">Group:</label>
                            </li>
                            <li>
                                <div class="hint">The default permissions to be applied to resources. For collections
                                    and XQuery scripts, the execute flag ("x") will be set by the installer.
                                </div>
                                <input type="text" name="mode" value="{if ($mode) then $mode else 'rw-rw-r--'}" size="9"/>
                                <label for="mode">Mode:</label>
                            </li>
                        </ol>
                }
            </fieldset>
        </form>
};

declare function deploy:package($collection as xs:string, $expathConf as element()) {
    let $name := concat($expathConf/@abbrev, "-", $expathConf/@version, ".xar")
    let $xar := compression:zip(xs:anyURI($collection), true(), $collection)
    let $mkcol := deploy:mkcol("/db/system/repo", (), ())
    return
        xmldb:store("/db/system/repo", $name, $xar, "application/zip")
};

declare function deploy:download($app-collection as xs:string, $expathConf as element(), $expand-xincludes as xs:boolean, $indent as xs:boolean, $omit-xml-declaration as xs:boolean) {
    let $name := concat($expathConf/@abbrev, "-", $expathConf/@version, ".xar")
    let $entries :=
        (: compression:zip uses default serialization parameters, so we'll construct entries manually :)
        dbutil:scan(xs:anyURI($app-collection), function($collection as xs:anyURI, $resource as xs:anyURI?) {
            (: compression:zip doesn't seem to store empty collections, so we'll scan for only resources :)
            if (exists($resource)) then
                let $relative-path := substring-after($resource, $app-collection || "/")
                return
                    if (util:binary-doc-available($resource)) then
                        <entry type="uri" name="{$relative-path}">{$resource}</entry>
                    else
                        <entry type="xml" name="{$relative-path}">{
                            (: workaround until https://github.com/eXist-db/exist/issues/2394 is resolved :)
                            util:declare-option(
                                "exist:serialize", 
                                "expand-xincludes=" 
                                || (if ($expand-xincludes) then "yes" else "no")
                                || " indent=" 
                                || (if ($indent) then "yes" else "no")
                                || " omit-xml-declaration=" 
                                || (if ($omit-xml-declaration) then "yes" else "no")
                            ),
                            doc($resource)
                        }</entry>
            else
                ()
        })
    let $xar := compression:zip($entries, true())
    return (
        response:set-header("Content-Disposition", concat("attachment; filename=", $name)),
        response:stream-binary($xar, "application/zip", $name)
    )
};

declare function deploy:deploy($collection as xs:string, $expathConf as element()) {
    let $pkg := deploy:package($collection, $expathConf)
    let $null := (
        repo:remove($expathConf/@name),
        repo:install-and-deploy-from-db($pkg)
    )
    return
        ()
};


let $target := request:get-parameter("target", ())
let $collectionParam := request:get-parameter("collection", ())
let $collection :=
    if ($collectionParam) then
        let $root := apputil:get-app-root($collectionParam)
        return
            if ($root) then $root else $collectionParam
    else
        repo:get-root() || $target
let $info := request:get-parameter("info", ())
let $download := request:get-parameter("download", ())
let $expand-xincludes := request:get-parameter("expand-xincludes", false()) cast as xs:boolean
let $indent := request:get-parameter("indent", false()) cast as xs:boolean
let $omit-xml-declaration := request:get-parameter("omit-xml-decl", true()) cast as xs:boolean
let $expathConf := if ($collection) then xmldb:xcollection($collection)/expath:package else ()
let $repoConf := if ($collection) then xmldb:xcollection($collection)/repo:meta else ()
let $abbrev := request:get-parameter("abbrev", ())
return
    try {
        if ($download) then
            deploy:download($collection, $expathConf, $expand-xincludes, $indent, $omit-xml-declaration)
        else if ($info) then
            apputil:get-info($info)
        else if ($abbrev) then
            deploy:create-app($target, $expathConf)
        else
            deploy:view($collection, $expathConf, $repoConf)
    } catch exerr:EXXQDY0003 {
        response:set-status-code(403),
        <span>You don't have permissions to access or write the application archive.
            Please correct the location or log in as a different user.</span>
    } catch exerr:EXREPOINSTALL001 {
        response:set-status-code(404),
        <p>Failed to install application.</p>
    } catch * {
        response:set-status-code(500)
    }
