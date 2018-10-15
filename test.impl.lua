C = require 'combine'

-- Aux functions for testing.

local function factorial(n)
   if n == 0 then return 1 end
   return n * factorial(n-1)
end

local function combn_no(n,r)
   return factorial(n)/(factorial(r)*factorial(n-r))
end

local function count(i)
   local c = 0
   for x in i do
      c = c+1
   end
   return c
end

-- combn count tests

assert(count(C.combn({1},1)) == 1)
assert(count(C.combn({1,2,3,4,5},3)) == combn_no(5,3))
assert(count(C.combn({1,2,3,4,5},1)) == combn_no(5,1))
assert(count(C.combn({4,4,4},3)) == combn_no(3,3))
assert(count(C.combn({1,{2},{a=1,b='c'},4,{d='ok'}},4)) == combn_no(5,4))
assert(count(C.combn({1,2,3,4},1)) == combn_no(4,1))
assert(count(C.combn({3,4,5,6,7,8,9,10,11,12},2)) == combn_no(10,2))

-- combn_many count tests

assert(count(C.combn_many({1})) == 1)
assert(count(C.combn_many({3,4,5}, {1,{b=2,c=9}})) == 3*2)
assert(count(C.combn_many({4,5}, {1,2}, {4,4,4,4})) == 2*2*4)
assert(count(C.combn_many({3,'4',5}, {1,2},{1})) == 3*2*1)
assert(count(C.combn_many({3,4,{a=5}}, {1,'2'},{1}, {4,5,6,7})) == 3*2*1*4)

-- powerset count tests

assert(count(C.powerset({1,2,3,4,5})) == 2^5-1)
assert(count(C.powerset({3,4,5})) == 2^3-1)
assert(count(C.powerset({1,2})) == 2^2-1)
assert(count(C.powerset({1})) == 1)

-- permute count tests

assert(count(C.permute({1,2,3,4,5})) == factorial(5))
assert(count(C.permute({1,2,3})) == factorial(3))
assert(count(C.permute({1,2,{3},4,{a=5,b='a'}})) == factorial(5))
assert(count(C.permute({1})) == 1)

