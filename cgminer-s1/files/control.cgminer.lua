--[[
usr/lib/lua/luci/controller/

LuCI - Lua Configuration Interface

Copyright 2015 L. D. Pinney <ldpinney@gmail.com>
Copyright 2015 Andrew Smith
Copyright 2013 Xiangfu

Licensed under the Apache License, Version 2.0 (the "License");
you may not use this file except in compliance with the License.
You may obtain a copy of the License at

	http://www.apache.org/licenses/LICENSE-2.0

$Id$
]]--

module("luci.controller.cgminer", package.seeall)

function index()
   entry({"admin", "status", "miner"}, cbi("cgminer/cgminer"), _("Miner Configuration"))
   entry({"admin", "status", "minerstatus"}, cbi("cgminer/cgminerstatus"), _("Miner Status"))
end

function action_cgminerapi()
   local pp   = io.popen("echo -n \"[Firmware Version] => \"; cat /etc/avalon_version; /usr/bin/cgminer-api stats;")
    local data = pp:read("*a")
    pp:close()

    luci.template.render("cgminerapi", {api=data})
end

function num_commas(n)
   return tostring(math.floor(n)):reverse():gsub("(%d%d%d)","%1,"):gsub(",(%-?)$","%1"):reverse()
end

function summary()
   local api = {}
   local data = {}
   local summ = luci.util.execi("/usr/bin/cgminer-api -o summary | sed \"s/|/\\n/g\" ")

   if not summ then
      return
   end

   for line in summ do
      for nam, val in string.gfind(line .. ',', "([^=,]+)=*([^,]*),") do
         api[nam] = val
      end
   end

   -- no data
   if not api['Elapsed'] then
      return
   end

   local elapsed = tonumber(api['Elapsed'])

   local paid = 0
   if elapsed > 0 then
      paid = tostring(math.floor(api['Difficulty Accepted'] * 4294.967296 / elapsed + 0.5) / 1000)
   end

   local str
   local days
   local h
   local m
   local s = elapsed % 60;
   elapsed = elapsed - s
   elapsed = elapsed / 60
   if elapsed == 0 then
      str = string.format("%ds", s)
   else
      m = elapsed % 60;
      elapsed = elapsed - m
      elapsed = elapsed / 60
      if elapsed == 0 then
         str = string.format("%dm %ds", m, s);
      else
         h = elapsed % 24;
         elapsed = elapsed - h
         elapsed = elapsed / 24
         if elapsed == 0 then
            str = string.format("%dh %dm %ds", h, m, s)
         else
            str = string.format("%dd %dh %dm %ds", elapsed, h, m, s);
         end
      end
   end

   data[1] = {
      ['Elapsed'] = str,
      ['GHS paid'] = paid,
      ['GHS 5s'] = tostring(math.floor(api['MHS 5s']+0.5) / 1000),
      ['GHS 5m'] = tostring(math.floor(api['MHS 5m']+0.5) / 1000),
      ['GHS 15m'] = tostring(math.floor(api['MHS 15m']+0.5) / 1000),
      ['GHS av'] = tostring(math.floor(api['MHS av']+0.5) / 1000),
      ['Found Blocks'] = api['Found Blocks'],
      ['Hardware Errors'] = num_commas(api['Hardware Errors']),
      ['Device Hardware%'] = api['Device Hardware%'],
      ['Utility'] = api['Utility'],
      ['Work Utility'] = api['Work Utility'],
      ['Best Share'] = num_commas(api['Best Share'])
   }

   return data
end

function devs()
   local api = {}
   local data = {}
   local estats = luci.util.execi("/usr/bin/cgminer-api -o estats | sed \"s/|/\\n/g\" ")

   if not estats then
      return
   end

   for line in estats do
      for nam, val in string.gfind(line .. ',', "([^=,]+)=*([^,]*),") do
         api[nam] = val
      end
   end

   -- no data
   if not api['ID'] then
      return
   end

   if api['miner_count'] then
     for i = 1, api['miner_count'], 1 do
       if i == 1 then
         data[#data+1] = {
           ['chain'] = '' .. i,
           ['asic'] = api['chain_acn' .. i],
           ['frequency'] = api['frequency'],
           ['fan_name'] = "Speed(r/min)",
           ['fan1'] = api['fan1'],
           ['fan2'] = api['fan2'],
           ['fan3'] = api['fan3'],
           ['fan4'] = api['fan4'],
           ['temp'] = api['temp' .. i],
           ['status'] = api['chain_acs' .. i],
           ['miner_count'] = api['miner_count'],
           ['asic_count'] = api['asic_count'],
           ['timeout'] = api['timeout'],
           ['freq'] =  api['frequency'],
           ['regdata'] = api['regdata'],
           ['voltage'] = api['voltage'],
           ['opt_bitmain_beeper'] = api['opt_bitmain_beeper'],
           ['opt_bitmain_tempoverctrl'] = api['opt_bitmain_tempoverctrl'],
           ['opt_bitmain_workdelay'] = api['opt_bitmain_workdelay']
         }
       else
         data[#data+1] = {
           ['chain'] = '' .. i,
           ['asic'] = api['chain_acn' .. i],
           ['frequency'] =  api['frequency'],
           ['temp'] = api['temp' .. i],
           ['status'] = api['chain_acs' .. i]
         }
       end
     end
   end

   return data
end

function pools()
   local when,sum_a,sum_r,sum_s,sum_d1,sum_da,sum_dr,sum_ds
   local data = {}
   local pls = luci.util.execi("/usr/bin/cgminer-api -o pools | sed \"s/|/\\n/g\" ")

   if not pls then
      return
   end

   when=0 sum_a=0 sum_r=0 sum_s=0 sum_d1=0 sum_da=0 sum_dr=0 sum_ds=0

   for line in pls do
      local api = {}
      for nam, val in string.gfind(line .. ',', "([^=,]+)=*([^,]*),") do
         api[nam] = val
      end

      if api['When'] then
         when = api['When']
      end

      if api['POOL'] then
         local lst,calc
         if api['Last Share Time'] == "0" then
            lst = "Never"
         else
            calc = when - api['Last Share Time']
            -- >= a week ago
            if calc > 604799 then
               lst = "Long ago"
            else
               local lsts,lstm,lsth
               lsts = calc % 60
               calc = calc - lsts
               if calc < 1 then
                  lst = string.format("%ds ago", lsts)
               else
                  calc = calc / 60
                  lstm = calc % 60
                  calc = calc - lstm
                  if calc < 1 then
                     lst = string.format("%dm %ds ago", lstm, lsts)
                  else
                     lsth = calc / 60
                     lst = string.format("%dh %dm %ds ago", lsth, lstm, lsts)
                  end
               end
            end
         end

         sum_a = sum_a + api['Accepted']
         sum_r = sum_r + api['Rejected']
         sum_s = sum_s + api['Stale']
         sum_d1 = sum_d1 + api['Diff1 Shares']
         sum_da = sum_da + api['Difficulty Accepted']
         sum_dr = sum_dr + api['Difficulty Rejected']
         sum_ds = sum_ds + api['Difficulty Stale']

         data[#data+1] = {
            ['POOL'] = api['POOL'],
            ['URL'] = api['URL'],
            ['User'] = api['User'],
            ['Status'] = api['Status'],
            ['Priority'] = api['Priority'],
            ['Bad Work'] = api['Bad Work'],
            ['Difficulty Accepted'] = num_commas(api['Difficulty Accepted']),
            ['Difficulty Rejected'] = num_commas(api['Difficulty Rejected']),
            ['Difficulty Stale'] = num_commas(api['Difficulty Stale']),
            ['Diff1 Shares'] = num_commas(api['Diff1 Shares']),
            ['Last Share Difficulty'] = num_commas(api['Last Share Difficulty']),
            ['Last Share Time'] = lst,
            ['Accepted'] = num_commas(api['Accepted']),
            ['Rejected'] = num_commas(api['Rejected']),
            ['Stale'] = num_commas(api['Stale'])
         }
      end
   end

   if #data > 1 then
         data[#data+1] = {
            ['POOL'] = "Total:",
            ['URL'] = "",
            ['User'] = "",
            ['Status'] = "",
            ['Priority'] = "",
            ['Bad Work'] = "",
            ['Difficulty Accepted'] = num_commas(sum_da),
            ['Difficulty Rejected'] = num_commas(sum_dr),
            ['Difficulty Stale'] = num_commas(sum_ds),
            ['Diff1 Shares'] = num_commas(sum_d1),
            ['Last Share Difficulty'] = "",
            ['Last Share Time'] = "",
            ['Accepted'] = num_commas(sum_a),
            ['Rejected'] = num_commas(sum_r),
            ['Stale'] = num_commas(sum_s)
         }
   end

   return data
end
