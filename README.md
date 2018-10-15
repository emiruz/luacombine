# luacombine

Pure, performant combination and permutation library for Lua and LuaJIT.

# Installation

    luarocks install --server=http://luarocks.org/dev luacombine

# Documentation

All functions operate on Lua arrays. E.g.

    {1,2,3}
    {'a','b','c','d'}
    {{'a'},{1,2},{a=4,b=9},7}
    etc...

If a function receives an iterator or a table with an overloaded *__call* method, it'll first
convert it to a standard table array, and then continue on. This is moreso for convenience
since the library is quite useful alongside things like luafun or luaiter.

All functions return an iterator which returns multiple results rather than returning tables.
Iterators were used because they are more memory efficient and because they are well optimised
for by LuaJIT. Multiple results are returned instead of tables because creating tables is an
expensive operation in Lua. Returning multiple results allows the decision to create a table
to be passed onwards so that it's only done when it's required. Further, making a table from
multiple results (e.g. local x = {f()}) is more efficient in Lua than making a table by
incrementally adding to it.

Generally inside of each function, I've tried to use as few resources as possible and
to minimise object creation.

## Including in a project

    C = require 'luacombine'

## combn(o,n) -> iterator

Produce all combinations of *n* elements from array *o*. It outputs an iterator which
returns a new combination for every call, except for the last call which returns a nil.

Example:

    for a,b in C.combn({'x','y','z'}, 2) do ... end
    
    -- or ...
    
    local f = C.combn({'x','y','z'}, 2)
    while true do
        local x = {f()}
        if #x == 0 then break end
        ...
    end

## combn_many(...) -> iterator

Produces all of the combination of drawing one element for each list provided. It outputs
an iterator which returns a new combination for every call, except for the last call which
returns a nil.

Example:

    for a,b in C.combn_many({'x','y','z'}, {1,2,3}) do ... end
    
    -- or
    
    local f = C.combn_many({'x','y','z'}, {1,2,3})
    while true do
        local x = {f()}
        if #x == 0 then break end
        ...
    end

## permute(o) -> iterator

Produces all of the permutations of the elements in *o*. It outputs an iterator which
returns a new combination for every call, except for the last call which returns a nil.

Example:

    for a,b,c in C.permute({'x','y','z'}) do ... end
    
    -- or
    
    local f = C.permute({'x','y','z'})
    while true do
        local x = {f()}
        if #x == 0 then break end
        ...
    end


## powerset(o) -> iterator

Produces all of the subsets of the elements in *o*. It outputs an iterator which
returns a new combination for every call, except for the last call which returns a nil.

Example:

    for a,b,c in C.powerset({'x','y','z'}) do ... end
    
    -- or
    
    local f = C.powerset({'x','y','z'})
    while true do
        local x = {f()}
        if #x == 0 then break end
        ...
    end

# Test suite

There is a basic test suite at the moment which verifies that the number of items returned
is as expected. To run it:

    lua test.impl.lua


# Performance

Run the performance tests:

    lua perf.impl.lua

    or

    luajit perf.impl.lua

With vanilla Lua 5.1:

    combn, array size #500, pick 3		4.740285s
    combn_many,3 arrays #200	   		3.596942s
    powerset, array size #20	   		5.3622s
    permute, array size #10	   		3.753631s

With LuaJIT:

    combn, array size #500, pick 3		1.128s
    combn_many,3 arrays #200	   		0.846391s
    powerset, array size #20	   		3.077064s
    permute, array size #10	   		0.830082s

NB: **combn({...},3)** with an array of size 500 would produce 20708500 combinations
of length 3. powerset({...}) with an array of size 20 would produce 1048576
permutations of length 20.


# License

MIT Licensed, please see LICENSE file for more information.
