m = Map("cgminer", translate("Configuration"), translate(""))

conf = m:section(TypedSection, "cgminer", "")
conf.anonymous = true
conf.addremove = false

conf:tab("default", translate("General Settings"))

pool1url = conf:taboption("default", Value, "pool1url", translate("Pool 1"))
pool1user = conf:taboption("default", Value, "pool1user", translate("Pool1 worker"))
pool1pw = conf:taboption("default", Value, "pool1pw", translate("Pool1 password"))
conf:taboption("default", DummyValue, "", translate(""))
pool2url = conf:taboption("default", Value, "pool2url", translate("Pool 2"))
pool2user = conf:taboption("default", Value, "pool2user", translate("Pool2 worker"))
pool2pw = conf:taboption("default", Value, "pool2pw", translate("Pool2 password"))
conf:taboption("default", DummyValue, "", translate(""))
pool3url = conf:taboption("default", Value, "pool3url", translate("Pool 3"))
pool3user = conf:taboption("default", Value, "pool3user", translate("Pool3 worker"))
pool3pw = conf:taboption("default", Value, "pool3pw", translate("Pool3 password"))
conf:taboption("default", DummyValue, "", translate(""))

pb = conf:taboption("default", ListValue, "pool_balance", translate("Pool Balance(Default: Failover)"))
pb.default = "  "
pb:value("  ", translate("Failover"))
pb:value("--balance", translate("Balance"))
pb:value("--load-balance", translate("Load Balance"))

pb = conf:taboption("default", ListValue, "bitmain_nobeeper", translate("Beeper ringing(Default: true)"))
pb.default = "  "
pb:value("  ", translate("true"))
pb:value("--bitmain-nobeeper", translate("false"))

pb = conf:taboption("default", ListValue, "bitmain_notempoverctrl", translate("Stop running when temprerature is over 80 degrees centigrade(Default: true)"))
pb.default = "  "
pb:value("  ", translate("true"))
pb:value("--bitmain-notempoverctrl", translate("false"))

conf:tab("advanced", translate("Advanced Settings"))
pb = conf:taboption("advanced", ListValue, "freq", translate("Frequency")) 
pb.default = "38:100:0783"
pb:value("12:325:0c82", translate("325M"))
pb:value("13:318.75:1906", translate("319M"))
pb:value("13:312.5:0c02", translate("312M"))
pb:value("13:306.25:1806", translate("306M"))
pb:value("13:300:0b82", translate("300M"))
pb:value("13:293.75:1706", translate("294M"))
pb:value("14:287.5:0b02", translate("287M"))
pb:value("14:281.25:1606", translate("281M"))
pb:value("14:275:0a82", translate("275M"))
pb:value("14:268.75:1506", translate("269M"))
pb:value("15:262.5:0a02", translate("262M"))
pb:value("15:256.25:1406", translate("256M"))
pb:value("15:250:0982", translate("250M"))
pb:value("16:243.75:1306", translate("244M"))
pb:value("16:237.5:1286", translate("237M"))
pb:value("17:231.25:1206", translate("231M"))
pb:value("17:225:0882", translate("225M"))
pb:value("18:218.75:1106", translate("219M")) 
pb:value("18:212.5:1086", translate("212M"))
pb:value("19:206.25:1006", translate("206M"))
pb:value("19:200:0782", translate("200M"))
pb:value("19:196.88:1f07", translate("197M"))
pb:value("20:193.75:0f03", translate("193M"))
pb:value("21:181.25:0e83", translate("181M"))
pb:value("22:175:0d83", translate("175M"))
pb:value("24:162.5:0c83", translate("162M"))
pb:value("25:156.25:0c03", translate("156M"))
pb:value("26:150:0b83", translate("150M"))
pb:value("27:143.75:1687", translate("144M"))
pb:value("28:137.5:0a83", translate("137M"))
pb:value("30:131.25:0a83", translate("131M"))
pb:value("31:125:0983", translate("125M"))
pb:value("35:118.75:0903", translate("119M"))
pb:value("35:112.5:0883", translate("112M"))
pb:value("37:106.25:0803", translate("106M"))
pb:value("38:100:0783", translate("100M (default)"))

  
pb = conf:taboption("advanced", Value, "voltage", translate("voltage"),"Modify voltage, click Save &#38; Apply, and then re-power the router.")
pb.default = "0000"
return m
