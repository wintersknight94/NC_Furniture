-- LUALOCALS < ---------------------------------------------------------
local minetest, nodecore, string
    = minetest, nodecore, string
local string_lower
    = string.lower
-- LUALOCALS > ---------------------------------------------------------
local modname = minetest.get_current_modname()
-- ================================================================== --
local plank = "nc_woodwork_plank.png"
local wicker = "nc_flora_wicker.png"
local thatch = "nc_flora_thatch.png"
local anlode = "nc_lode_annealed.png"
local tmlode = "nc_lode_tempered.png"
local cloud = "nc_concrete_cloudstone.png"
------------------------------------------------------------------------
local wickchair = wicker..	"^[lowpart:40:nc_tree_tree_side.png","[combine:1x1"
local woodchair = plank..	"^[lowpart:40:nc_tree_tree_side.png","[combine:1x1"
------------------------------------------------------------------------
local wickcushion = thatch.. "^(" ..wicker.. "^[mask:" ..modname.. "_seat.png)"
local woodcushion = thatch.. "^(" ..plank.. "^[mask:" ..modname.. "_seat.png)"
local lodecushion = thatch.. "^(" ..anlode.. "^[mask:" ..modname.. "_seat.png)"
local nicecushion = thatch.. "^(" ..cloud.. "^[mask:" ..modname.. "_seat.png)"
------------------------------------------------------------------------
local wickback = wicker.. "^(" ..thatch.. "^[mask:" ..modname.. "_chair_back.png)"
local woodback = plank.. "^(" ..thatch.. "^[mask:" ..modname.. "_chair_back.png)"
local lodeback = anlode.. "^(" ..thatch.. "^[mask:" ..modname.. "_chair_back.png)"
local niceback = cloud.. "^(" ..thatch.. "^[mask:" ..modname.. "_chair_back.png)"
------------------------------------------------------------------------
local couchnodebox = {
	{-0.5, -0.5, -0.5, -0.3125, -0.125, -0.3125},	-- LegFL
	{0.3125, -0.5, -0.5, 0.5, -0.125, -0.3125},	-- LegFR
	{0.3125, -0.5, 0.3125, 0.5, -0.125, 0.5},		-- LegBR
	{-0.5, -0.5, 0.3125, -0.3125, -0.125, 0.5},	-- LegBL
	{-0.5, -0.1875, -0.5, 0.5, -0.0625, 0.5},		-- Base
	{-0.5, -0.0625, 0.375, 0.5, 0.5, 0.5},		-- Back
	{-0.5, -0.0625, -0.4375, 0.5, 0.0625, 0.375},	-- SeatCushion
	{-0.4375, 0.0625, 0.25, 0.4375, 0.4375, 0.375},	-- BackCushion
}
-- ================================================================== --
minetest.register_node(modname .. ":couch_wicker", {
	description = "Wicker Couch",
	tiles = {
		wickcushion,	--top
		wicker,		--bottom
		wicker,		--side
		wicker,		--side
		wicker,		--back
		wickback		--front
	},
	drawtype = "nodebox",
	paramtype = "light",
	paramtype2 = "facedir",
	node_box = {
		type = "fixed",
		fixed = couchnodebox
	},
	selection_box = nodecore.fixedbox(),
	groups = {
		choppy = 3,
		flammable = 30,
		fire_fuel = 6,
		furniture = 1,
		couch = 1,
		stack_as_node = 1,
	},
	stack_max = 1,
	sounds = nodecore.sounds("nc_tree_woody"),
})
------------------------------------------------------------------------
minetest.register_node(modname .. ":couch_wooden", {
	description = "Wooden Couch",
	tiles = {
		woodcushion,	--top
		plank,		--bottom
		plank,		--side
		plank,		--side
		plank,		--back
		woodback		--front
	},
	drawtype = "nodebox",
	paramtype = "light",
	paramtype2 = "facedir",
	node_box = {
		type = "fixed",
		fixed = couchnodebox
	},
	selection_box = nodecore.fixedbox(),
	groups = {
		choppy = 3,
		flammable = 30,
		fire_fuel = 6,
		furniture = 1,
		couch = 1,
		stack_as_node = 1,
	},
	stack_max = 1,
	sounds = nodecore.sounds("nc_tree_woody"),
})
------------------------------------------------------------------------
minetest.register_node(modname .. ":couch_lode_annealed", {
	description = "Lode Couch",
	tiles = {
		nicecushion,	--top
		cloud,		--bottom
		cloud,		--side
		cloud,		--side
		cloud,		--back
		niceback		--front
	},
	drawtype = "nodebox",
	paramtype = "light",
	paramtype2 = "facedir",
	node_box = {
		type = "fixed",
		fixed = couchnodebox
	},
	selection_box = nodecore.fixedbox(),
	groups = {
		cracky = 3,
		furniture = 1,
		couch = 1,
		stack_as_node = 1,
	},
	stack_max = 1,
	sounds = nodecore.sounds("nc_lode_annealed"),
})
------------------------------------------------------------------------
minetest.register_node(modname .. ":couch_fancy", {
	description = "Fancy Couch",
	tiles = {
		cloud
	},
	drawtype = "nodebox",
	paramtype = "light",
	paramtype2 = "facedir",
	node_box = {
		type = "fixed",
		fixed = couchnodebox
	},
	selection_box = nodecore.fixedbox(),
	groups = {
		cracky = 3,
		furniture = 1,
		couch = 1,
		stack_as_node = 1,
	},
	stack_max = 1,
	sounds = nodecore.sounds("nc_tree_woody"),
})
------------------------------------------------------------------------

-- ================================================================== --
