package = "luacombine"
version = "scm-0"

source = {
  url = "git://github.com/emiruz/luacombine.git",
}

description = {
  summary = "Pure, performant combination and permutation library for Lua and LuaJIT.",
  homepage = "https://github.com/emiruz/luacombine",
  license = "MIT/X11",
  maintainer = "emir@usgroupltd.uk",
  detailed = "Pure, performant combination and permutation library for Lua and LuaJIT."
}

dependencies = {
  "lua >= 5.1"
}

build = {
  type = "builtin",
  modules = { combine = "combine.lua" }
}
