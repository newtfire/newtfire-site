xquery version "3.1";
let $autoColl := collection('/db/auto')/*
let $entries := $autoColl//entry
let $wheelbases := $entries//wheelbase
let $wbunits := $wheelbases/@unit ! string() => distinct-values()
let $wbSizes := $wheelbases/@quant ! data() => distinct-values() => sort()
for $w in $wbSizes
  where $w < 2400
  let $carTinyWheels := $entries[.//wheelbase/@quant = $w]/name ! string()
    for $c in $carTinyWheels
    return concat ($c, ' has wheelbase of ', $w, '!')
