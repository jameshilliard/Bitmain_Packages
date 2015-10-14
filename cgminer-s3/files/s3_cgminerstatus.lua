--[[
usr/lib/lua/luci/model/cbi/cgminer/cgminerstatus.lua

LuCI - Lua Configuration Interface

Copyright 2015 L. D. Pinney <ldpinney@gmail.com>
Copyright 2015 Andrew Smith
Copyright 2013 Xiangfu
Copyright 2008 Steven Barth <steven@midlink.org>
Copyright 2008 Jo-Philipp Wich <xm@leipzig.freifunk.net>

Licensed under the Apache License, Version 2.0 (the "License");
you may not use this file except in compliance with the License.
You may obtain a copy of the License at

        http://www.apache.org/licenses/LICENSE-2.0

$Id$
]]--
f = SimpleForm("cgminerstatus", translate("Miner Status"))
f.reset = false
f.submit = false

t = f:section(Table, luci.controller.cgminer.summary(), translate("Summary"))
t:option(DummyValue, "Elapsed", translate("Elapsed"))
t:option(DummyValue, "GHS paid", translate("GH/S(paid)"))
t:option(DummyValue, "GHS 5s", translate("GH/S(5s)"))
t:option(DummyValue, "GHS 5m", translate("GH/S(5m)"))
t:option(DummyValue, "GHS 15m", translate("GH/S(15m)"))
t:option(DummyValue, "GHS av", translate("GH/S(avg)"))
t:option(DummyValue, "Found Blocks", translate("FoundBlocks"))
t:option(DummyValue, "Hardware Errors", translate("HW"))
t:option(DummyValue, "Device Hardware%", translate("HW%"))
t:option(DummyValue, "Utility", translate("Utility"))
t:option(DummyValue, "Work Utility", translate("WU"))
t:option(DummyValue, "Best Share", translate("BestShare"))

t1 = f:section(Table, luci.controller.cgminer.pools(), translate("Pools"))
t1:option(DummyValue, "POOL", translate("Pool"))
t1:option(DummyValue, "URL", translate("URL"))
t1:option(DummyValue, "User", translate("User"))
t1:option(DummyValue, "Status", translate("Status"))
t1:option(DummyValue, "Getworks", translate("GetWorks"))
t1:option(DummyValue, "Priority", translate("Priority"))
t1:option(DummyValue, "Difficulty Accepted", translate("DiffA#"))              
t1:option(DummyValue, "Difficulty Rejected", translate("DiffR#"))              
t1:option(DummyValue, "Diff1 Shares", translate("Diff1#"))          
t1:option(DummyValue, "Last Share Difficulty", translate("LSDiff"))
t1:option(DummyValue, "Last Share Time", translate("LSTime"))
t1:option(DummyValue, "Accepted", translate("Accepted"))
t1:option(DummyValue, "Discarded",translate("Discarded"))
t1:option(DummyValue, "Rejected", translate("Rejected"))
t1:option(DummyValue, "Stale", translate("Stale"))

t2 = f:section(Table, luci.controller.cgminer.devs(), translate("AntMiner"))  
t2:option(DummyValue, "chain", translate("Chain#") )
t2:option(DummyValue, "asic", translate("ASIC#"))
t2:option(DummyValue, "frequency", translate("Frequency"))
t2:option(DummyValue, "temp", translate("Temp"))
t2:option(DummyValue, "status", translate("ASIC status"))

t3 = f:section(Table, luci.controller.cgminer.devs(), translate(""))  
t3:option(DummyValue, "regdata", translate("RegData") )
t3:option(DummyValue, "voltage", translate("Voltage") )
t3:option(DummyValue, "opt_bitmain_beeper", translate("Beeper") )
t3:option(DummyValue, "opt_bitmain_tempoverctrl", translate("TempControl") )
t3:option(DummyValue, "opt_bitmain_workdelay", translate("WorkDelay") )

t4 = f:section(Table, luci.controller.cgminer.devs(), translate(""))  
t4:option(DummyValue, "fan_name", translate("Fan#") )
t4:option(DummyValue, "fan1", translate("Fan1") )
t4:option(DummyValue, "fan2", translate("Fan2") )
return f
