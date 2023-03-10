-- LUALOCALS < ---------------------------------------------------------
local include, nodecore
    = include, nodecore
-- LUALOCALS > ---------------------------------------------------------
local modname = minetest.get_current_modname()
------------------------------------------------------------------------
include("cushion")
include("tables")
include("chairs")
include("comfort")
include("benches")
------------------------------------------------------------------------
--include("bed")
--include("couch")
------------------------------------------------------------------------
include("drawers")
------------------------------------------------------------------------
include("lamp")
include("dishes")
------------------------------------------------------------------------
include("kitchenry")
------------------------------------------------------------------------
include("wallplates")
include("fountain")
------------------------------------------------------------------------
if minetest.get_modpath("wc_naturae") then
	include("bamboo")
--	include("pinkfancy")
end
------------------------------------------------------------------------
if minetest.get_modpath("nc_pummine") then
	include("vulcan")
end
------------------------------------------------------------------------
if minetest.get_modpath("wc_pottery") then
	include("ceramic")
end
------------------------------------------------------------------------
