C = require 'combine'

local function time(f, desc)
   s = os.clock()
   f()
   e = os.clock()
   print("DESC: " .. desc .. '\t' .. e-s .. 's')
end

function combn_test()
   local t = {}
   for i=1,400 do t[i]=i end   
   for a,b,c in C.combn(t,3) do
   end
end

function combn_many_test()
   local t = {}
   for i=1,200 do t[i]=i end
   for a,b,c in C.combn_many(t,t,t) do
   end
end

function powerset_test()
   local t = {}
   for i=1,20 do t[i]=i end
   local f = C.powerset(t)
   while true do
      local x= {f()}
      if #x == 0 then break end
   end
end

function permute_test()
   local t = {}
   for i=1,10 do t[i]=i end
   local f = C.permute(t)
   while true do
      local x= {f()}
      if #x == 0 then break end
   end
end

time(combn_test, "combn, array size #500, pick 3")
time(combn_many_test, "combn_many,3 arrays #200")
time(powerset_test, "powerset, array size #20")
time(permute_test, "permute, array size #10")
