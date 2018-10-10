local combine = {}

local function icombn(tbl,i,n)
   local l = table.getn(tbl)
   if n == 1 then
      local t,j = {},i
      return function()
	 if j > l then return nil end
	 j = j+1
	 return {tbl[j-1]}
      end
   end
   local j = i
   local v = icombn(tbl,j+1,n-1)
   return function()
      if j > l then return nil end
      local x = v()
      if x == nil then
	 j = j+1
	 v = icombn(tbl,j+1,n-1)
	 x = v()
      end
      if x == nil then return nil end
      table.insert(x,tbl[j])
      return x
   end
end

local function icombn_many(n, params)
   if n < 1 then return nil end
   local o = params[n]
   local l = table.getn(o)
   if n == 1 then
      local i = 1
      return function()
	 if i > l then return nil end
	 i=i+1
	 return {o[i-1]}
      end
   end
   local i = 1
   local v = icombn_many(n-1, params)
   return function()
      if i > l then return nil end
      local x = v()
      if x == nil then
	 i = i+1
	 if i > l or n < 0 then return nil end
	 v = icombn_many(n-1,params)
	 x = v()
      end
      if x == nil then return nil end
      table.insert(x,o[i])
      return x
   end
end

local function factorial(n)
   if n == 0 then return 1 end
   return n * factorial(n-1)
end

local function ipermute(n)
   local i = factorial(n)
   local j = 1
   p = {}; for x=1,n do table.insert(p,x) end
   return function()
      if i <= 0 then return nil end; i = i-1
      p[j],p[j+1] = p[j+1],p[j]
      j = (j + 1) % n
      if j == 0 then j = 1 end
      return p
   end
end

function combine.combn(tbl,n)
   if n <= 0 or n > table.getn(tbl) then
      error("Need 0 < n <= tbl length.")
   end
   return icombn(tbl,1,n)
end

function combine.combn_many(...)
   local params = {...}
   if #params == 0 then
      error("Need at least one array.")
   end
   return icombn_many(table.getn(params), params)
end

function combine.powerset(tbl)
   local l = table.getn(tbl)
   local i = 1
   local v = icombn(tbl,1,i)
   return function()
      local x = v()
      if x == nil then
	 i = i + 1
	 if i > l then return nil end
	 v = icombn(tbl,1,i)
	 return v()
      end
      return x
   end
end

function combine.permute(tbl)
   local n = table.getn(tbl)
   if n == 0 then return tbl end
   local v = ipermute(n)
   return function()
      x = v()
      if x == nil then return nil end
      local t = {}
      for _,i in pairs(x) do table.insert(t,tbl[i]) end
      return t
   end
end

return combine
