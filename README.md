# luacombine

Pure, performant combination and permutation library for Lua and LuaJIT.

# Installation

    luarocks install luacombine

# Documentation

All functions operate on Lua arrays. E.g.

    {1,2,3}
    {'a','b','c','d'}
    {{'a'},{1,2},{a=4,b=9},7}
    etc...

If a function receives an iterator or a table with an overloaded *__call* method, it'll first
convert it to a standard table array, and then continue on. This is moreso for convenience
since the lirbary is quite useful alongside things like luafun or luaiter.

All functions return an iterator which returns a array on every call. The array is always a
new copy but the elements are included by reference (i.e. they are not a copy).

## Including in a project

    C = require 'luacombine'

## combn(o,n) -> iterator

Produce all combinations of *n* elements from array *o*. It outputs an iterator which
returns a new combination for every call, except for the last call which returns a null.

Example:

    for p in C.combn({'x','y','z'}, 2) do ... end
   

## combn_many(...) -> iterator

Produces all of the combination of drawing one element for each list provided. It outputs
an iterator which returns a new combination for every call, except for the last call which
returns a null.

Example:

    for p in C.combn_many({'x','y','z'}, {1,2,3}) do ... end


## permute(o) -> iterator

Produces all of the permutations of the elements in *o*. It outputs an iterator which
returns a new combination for every call, except for the last call which returns a null.

Example:

    for p in C.permute({'x','y','z'}) do ... end

## powerset(o) -> iterator

Produces all of the subsets of the elements in *o*. It outputs an iterator which
returns a new combination for every call, except for the last call which returns a null.

Example:

    for p in C.powerset({'x','y','z'}) do ... end
