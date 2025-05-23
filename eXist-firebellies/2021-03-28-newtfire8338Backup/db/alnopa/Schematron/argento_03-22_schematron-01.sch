<schema xmlns="http://purl.oclc.org/dsdl/schematron" xmlns:sch="http://purl.oclc.org/dsdl/schematron" xmlns:sqf="http://www.schematron-quickfix.com/validator/process" queryBinding="xslt2">
    <pattern>
        <rule context="desc">
            <report test="contains(., 'Bnanksy')">PLEASE try to spell the artist's name correctly, will you????!!!! </report>
        </rule>
    </pattern>
    <pattern>
        <rule context="bibl/location[descendant::text()[contains(., 'AU')]]">
            <assert test="number(@lat) lt 0">Latitude must be a negative number</assert>
            <assert test="number(@long) gt 100">Longitude must be greater than 100</assert>
        </rule>
        <rule context="bibl/location[descendant::text()[contains(., 'USA')]]">
            <assert test="number(@lat) gt 0">Latititude must be greater than 0 </assert>
            <assert test="number(@long) lt 0">Longitude must be less than 0</assert>
        </rule>
    </pattern>
</schema>