-- LUALOCALS < ---------------------------------------------------------
local minetest, nodecore, string
    = minetest, nodecore, string
local string_lower
    = string.lower
-- LUALOCALS > ---------------------------------------------------------
local modname = minetest.get_current_modname()
-- ================================================================== --
local wicker	= "nc_flora_wicker.png"
local plank	= "nc_woodwork_plank.png"
local anlode	= "nc_lode_annealed.png"
local fancy	= "nc_concrete_cloudstone.png"
------------------------------------------------------------------------
local woodchair = plank..	"^[lowpart:35:nc_tree_tree_side.png","[combine:1x1"
-- ================================================================== --
local bednodebox = {
	{-0.5, -0.5, 0.3125, -0.3125, 0.5, 0.5},		-- Post
	{0.3125, -0.5, 0.3125, 0.5, 0.5, 0.5},		-- Post
	{-0.375, -0.25, 0.3125, 0.375, 0.25, 0.4375},	-- Board
	{-0.5, -0.1875, -0.5, 0.5, 0.0625, 0.3125},	-- Base
	{-0.375, 0.0625, -0.5, 0.375, 0.125, 0.3125},	-- Mattress
}
-- ================================================================== --
------------------------------------------------------------------------
minetest.register_node(modname .. ":bed_wicker", {
	description = "Wicker Bed",
	tiles = {
		wicker,
		woodchair
	},
	drawtype = "nodebox",
	paramtype = "light",
	paramtype2 = "facedir",
	node_box = {
		type = "fixed",
		fixed = bednodebox
	},
	selection_box = nodecore.fixedbox(),
	groups = {
		choppy = 3,
		flammable = 12,
		fire_fuel = 7,
		furniture = 1,
		bed = 1,
		stack_as_node = 1,
	},
	stack_max = 1,
	sounds = nodecore.sounds("nc_tree_sticky"),
})
------------------------------------------------------------------------
minetest.register_node(modname .. ":bed_wooden", {
	description = "Wooden Bed",
	tiles = {
		plank,
		woodchair
	},
	drawtype = "nodebox",
	paramtype = "light",
	paramtype2 = "facedir",
	node_box = {
		type = "fixed",
		fixed = bednodebox
	},
	selection_box = nodecore.fixedbox(),
	groups = {
		choppy = 3,
		flammable = 12,
		fire_fuel = 7,
		furniture = 1,
		bed = 1,
		stack_as_node = 1,
	},
	stack_max = 1,
	sounds = nodecore.sounds("nc_tree_woody"),
})
------------------------------------------------------------------------
minetest.register_node(modname .. ":bed_lode_annealed", {
	description = "Lode Bed",
	tiles = {
		anlode,
		woodchair
	},
	drawtype = "nodebox",
	paramtype = "light",
	paramtype2 = "facedir",
	node_box = {
		type = "fixed",
		fixed = bednodebox
	},
	selection_box = nodecore.fixedbox(),
	groups = {
		cracky = 4,
		flammable = 30,
		fire_fuel = 3,
		furniture = 1,
		bed = 1,
		stack_as_node = 1,
	},
	stack_max = 1,
	sounds = nodecore.sounds("nc_lode_annealed"),
})
------------------------------------------------------------------------
minetest.register_node(modname .. ":bed_fancy", {
	description = "Fancy Bed",
	tiles = {
		cloud,
		woodchair
	},
	drawtype = "nodebox",
	paramtype = "light",
	paramtype2 = "facedir",
	node_box = {
		type = "fixed",
		fixed = bednodebox
	},
	selection_box = nodecore.fixedbox(),
	groups = {
		cracky = 4,
		flammable = 30,
		fire_fuel = 3,
		furniture = 1,
		bed = 1,
		stack_as_node = 1,
	},
	stack_max = 1,
	sounds = nodecore.sounds("nc_optics_glassy"),
})
-- ================================================================== --
