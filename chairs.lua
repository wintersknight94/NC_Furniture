-- LUALOCALS < ---------------------------------------------------------
local minetest, nodecore
    = minetest, nodecore
-- LUALOCALS > ---------------------------------------------------------
local modname = minetest.get_current_modname()
------------------------------------------------------------------------
-- ================================================================== --
local wood		= "nc_tree_tree_side.png"
local plank	= "nc_woodwork_plank.png"
local wicker	= "nc_flora_wicker.png"
local anlode	= "nc_lode_annealed.png"
local cloud	= "nc_concrete_cloudstone.png"
local aurum	= "nc_lode_tempered.png^[colorize:gold:50"
------------------------------------------------------------------------
local woodchair = plank..	"^[lowpart:40:nc_tree_tree_side.png","[combine:1x1"
local wickchair = wicker.. "^(" ..wood.. "^[mask:(" ..modname.. "_trim.png^" ..modname.. "_bind.png))"
local nicechair = cloud.. "^(" ..aurum.. "^[mask:(" ..modname.. "_trim.png^" ..modname.. "_bind.png))"
------------------------------------------------------------------------
local woodseat = plank..	"^[lowpart:40:nc_tree_tree_side.png","[combine:1x1"
local wickseat = wicker.. "^(" ..wood.. "^[mask:" ..modname.. "_seat.png)"
local niceseat = cloud.. "^(" ..aurum.. "^[mask:(" ..modname.. "_seat.png^nc_concrete_pattern_iceboxy.png))"
------------------------------------------------------------------------
local chairnodebox = {
	{-0.4375, -0.0625, 0.3125, 0.4375, 0.375, 0.4375},	-- Back
	{-0.4375, -0.0625, -0.4375, 0.4375, 0.0625, 0.4375},	-- Seat
	{-0.4375, -0.5, -0.4375, -0.3125, -0.0625, -0.3125},	-- Leg
	{-0.4375, -0.5, 0.3125, -0.3125, -0.0625, 0.4375},	-- Leg
	{0.3125, -0.5, 0.3125, 0.4375, -0.0625, 0.4375},		-- Leg
	{0.3125, -0.5, -0.4375, 0.4375, -0.0625, -0.3125},	-- Leg
	{-0.3125, 0.3125, 0.3125, 0.3125, 0.5, 0.4375},		-- BackArch
}
-- ================================================================== --
minetest.register_node(modname .. ":chair_wicker", {
	description = "Wicker Chair",
	tiles = {
		wickseat,
		wickseat,
		wickchair
	},
	drawtype = "nodebox",
	paramtype = "light",
	paramtype2 = "facedir",
	node_box = {
		type = "fixed",
		fixed = chairnodebox
	},
	selection_box = nodecore.fixedbox(),
	groups = {
		snappy = 1,
		flammable = 10,
		fire_fuel = 2,
		furniture = 1,
		chair = 1,
		stack_as_node = 1,
	},
	stack_max = 1,
	paramtype = "light",
	sounds = nodecore.sounds("nc_tree_sticky"),
})
------------------------------------------------------------------------
minetest.register_node(modname .. ":chair_wooden", {
	description = "Wooden Chair",
	tiles = {
		plank,
		plank,
		woodchair
	},
	drawtype = "nodebox",
	paramtype = "light",
	paramtype2 = "facedir",
	node_box = {
		type = "fixed",
		fixed = chairnodebox
	},
	selection_box = nodecore.fixedbox(),
	groups = {
		choppy = 2,
		flammable = 10,
		fire_fuel = 2,
		furniture = 1,
		chair = 1,
		stack_as_node = 1,
	},
	stack_max = 1,
	paramtype = "light",
	sounds = nodecore.sounds("nc_tree_woody"),
})
------------------------------------------------------------------------
minetest.register_node(modname .. ":chair_lode_annealed", {
	description = "Lode Chair",
	tiles = {anlode},
	drawtype = "nodebox",
	paramtype = "light",
	paramtype2 = "facedir",
	node_box = {
		type = "fixed",
		fixed = chairnodebox
	},
	selection_box = nodecore.fixedbox(),
	groups = {
		cracky = 3,
		furniture = 1,
		chair = 1,
		stack_as_node = 1,
	},
	stack_max = 1,
	sounds = nodecore.sounds("nc_lode_annealed"),
})
------------------------------------------------------------------------
minetest.register_node(modname .. ":chair_fancy", {
	description = "Fancy Chair",
	tiles = {
		niceseat,
		niceseat,
		nicechair
	},
	drawtype = "nodebox",
	paramtype = "light",
	paramtype2 = "facedir",
	node_box = {
		type = "fixed",
		fixed = chairnodebox
	},
	selection_box = nodecore.fixedbox(),
	groups = {
		cracky = 3,
		furniture = 1,
		chair = 1,
		stack_as_node = 1,
	},
	stack_max = 1,
	sounds = nodecore.sounds("nc_lode_tempered"),
})
-- ================================================================== --
nodecore.register_craft({
	label = "assemble wicker chair",
	indexkeys = {"nc_flora:wicker"},
	nodes = {
		{match = "nc_flora:wicker", replace = modname.. ":chair_wicker"},
		{x = -1, match = "nc_tree:stick", replace = "air"},
		{x = 1, match = "nc_tree:stick", replace = "air"},
		{z = -1, match = "nc_tree:stick", replace = "air"},
		{z = 1, match = "nc_tree:stick", replace = "air"},
	},
})
------------------------------------------------------------------------
nodecore.register_craft({
	label = "assemble wooden chair",
	indexkeys = {"nc_woodwork:plank"},
	nodes = {
		{match = "nc_woodwork:plank", replace = modname.. ":chair_wooden"},
		{x = -1, match = "nc_tree:stick", replace = "air"},
		{x = 1, match = "nc_tree:stick", replace = "air"},
		{z = -1, match = "nc_tree:stick", replace = "air"},
		{z = 1, match = "nc_tree:stick", replace = "air"},
	},
})
------------------------------------------------------------------------
nodecore.register_craft({
		label = "make lode chair",
		action = "pummel",
		duration = 4,
		toolgroups = {thumpy = 2},
		indexkeys = {"wc_storage:shelf_toolrack_annealed"},
		nodes = {
			{
				match = {name = "wc_storage:shelf_toolrack_annealed", empty = true}, 
				replace = modname .. ":chair_lode_annealed"
			},
			{y = -1, match = "nc_lode:block_tempered"},
		},
	})
------------------------------------------------------------------------
nodecore.register_craft({
	label = "carve fancy chair",
	action = "pummel",
	duration = 3,
	priority = 1,
	wield_item = {"group:chisel"},
	consumewield = 1,
	indexkeys = "nc_concrete:concrete_cloudstone_boxy",
	nodes = {
		{match = "nc_concrete:concrete_cloudstone_boxy", replace = modname.. ":chair_fancy"},
	}
})

-- ================================================================== --
