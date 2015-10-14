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

pb = conf:taboption("default", ListValue, "bitmain_beeper", translate("Beeper ringing(Default: false)"))
pb.default = "  "
pb:value("  ", translate("false"))
pb:value("--bitmainbeeper", translate("true"))

pb = conf:taboption("default", ListValue, "bitmain_tempoverctrl", translate("Stop running when temprerature is over 80 degrees centigrade(Default: true)"))
pb.default = "--bitmaintempoverctrl"
pb:value("  ", translate("false"))
pb:value("--bitmaintempoverctrl", translate("true"))

api_allow = conf:taboption("default", Value, "api_allow", translate("API Allow(Default: W:127.0.0.1,R:0/0)"))
api_allow.default = "W:127.0.0.1,R:0/0"

more_options = conf:taboption("default", Value, "more_options", translate("More Options(Default: --quiet)"))
more_options.default = "--quiet"

conf:tab("advanced", translate("Advanced Settings"))
pb = conf:taboption("advanced", ListValue, "freq", translate("Frequency"),"Warning on values marked - may cause damage!!!") 

pb.default = "40:350:4d81"
pb:value("31:450:0880", translate("450M(* Warning)" ))
pb:value("32:425:0800", translate("425M(* Warning)" ))
pb:value("35:400:4f81", translate("400M(* Warning)" ))
pb:value("38:375:4e81", translate("375M(* Warning)" ))
pb:value("40:350:4d81", translate("350M (DEFAULT)"))
pb:value("40:325:4c81", translate("325M"))
pb:value("46:300:0b81", translate("300M"))
pb:value("50:275:0A81", translate("275M"))
pb:value("55:250:0981", translate("250M"))
pb:value("58:237.5:1285", translate("237M"))
pb:value("62:225:0881", translate("225M"))
pb:value("70:200:0781", translate("200M"))
pb:value("72:193:4f02", translate("193M"))
pb:value("80:175:0681", translate("175M"))
pb:value("93:150:0b81", translate("150M"))
pb:value("112:125:0982", translate("125M"))
pb:value("140:200:0782", translate("100M"))
pb:value("186:75:0b83", translate("75M"))

return m
