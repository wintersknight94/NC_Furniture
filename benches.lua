-- LUALOCALS < ---------------------------------------------------------
local minetest, nodecore, string
    = minetest, nodecore, string
local string_lower
    = string.lower
-- LUALOCALS > ---------------------------------------------------------
local modname = minetest.get_current_modname()
-- ================================================================== --
local rfcall = function(pos, data)
	local ref = minetest.get_player_by_name(data.pname)
	local wield = ref:get_wielded_item()
	wield:take_item(1)
	ref:set_wielded_item(wield)
end
-- ================================================================== --
local wicker	= "nc_flora_wicker.png"
local plank 	= "nc_woodwork_plank.png"
local anlode	= "nc_lode_annealed.png"
local cloud	= "nc_concrete_cloudstone.png"
local aurum	= "nc_lode_tempered.png^[colorize:gold:50"
------------------------------------------------------------------------
local wickbench	= wicker..	"^[lowpart:35:nc_tree_tree_side.png","[combine:1x1"
local woodbench	= plank..	"^[lowpart:35:nc_tree_tree_side.png","[combine:1x1"
local nicebench	= cloud..	"^[lowpart:35:" ..aurum,"[combine:1x1"
------------------------------------------------------------------------
local benchnodebox = {
	{-0.5, -0.125, -0.3125, 0.5, 0, 0.3125},			-- Seat
	{-0.4375, -0.5, 0.0625, -0.3125, -0.125, 0.1875},	-- Leg(BackLeft)
	{0.3125, -0.5, 0.0625, 0.4375, -0.125, 0.1875},		-- Leg(BackRight)
	{0.3125, -0.5, -0.1875, 0.4375, -0.125, -0.0625},	-- Leg(FrontRight)
	{-0.4375, -0.5, -0.1875, -0.3125, -0.125, -0.0625},	-- Leg(FrontLeft)
--	{-0.5, -0.375, -0.0625, 0.5, -0.25, 0.0625}, 		-- Brace
}
-- ================================================================== --
minetest.register_node(modname .. ":bench_wicker", {
	description = "Wicker Bench",
	tiles = {
		wicker,
		wicker,
		wickbench
	},
	use_texture_alpha = "blend",
	drawtype = "nodebox",
	paramtype = "light",
	paramtype2 = "facedir",
	node_box = {
		type = "fixed",
		fixed = benchnodebox
	},
	selection_box = nodecore.fixedbox(),
	groups = {
		choppy = 2,
		flammable = 6,
		fire_fuel = 2,
		furniture = 1,
		bench = 1,
		stack_as_node = 1,
	},
	stack_max = 1,
	paramtype = "light",
	sounds = nodecore.sounds("nc_tree_sticky"),
})
------------------------------------------------------------------------
minetest.register_node(modname .. ":bench_wooden", {
	description = "Wooden Bench",
	tiles = {
		plank,
		plank,
		woodbench
	},
	drawtype = "nodebox",
	paramtype = "light",
	paramtype2 = "facedir",
	node_box = {
		type = "fixed",
		fixed = benchnodebox
	},
	selection_box = nodecore.fixedbox(),
	groups = {
		choppy = 2,
		flammable = 8,
		fire_fuel = 2,
		furniture = 1,
		bench = 1,
		stack_as_node = 1,
	},
	stack_max = 1,
	paramtype = "light",
	sounds = nodecore.sounds("nc_tree_woody"),
})
------------------------------------------------------------------------
minetest.register_node(modname .. ":bench_lode_annealed", {
	description = "Lode Bench",
	tiles = {
		anlode
	},
	drawtype = "nodebox",
	paramtype = "light",
	paramtype2 = "facedir",
	node_box = {
		type = "fixed",
		fixed = benchnodebox
	},
	selection_box = nodecore.fixedbox(),
	groups = {
		cracky = 3,
		furniture = 1,
		bench = 1,
		stack_as_node = 1,
	},
	stack_max = 1,
	paramtype = "light",
	sounds = nodecore.sounds("nc_lode_annealed"),
})
------------------------------------------------------------------------
minetest.register_node(modname .. ":bench_fancy", {
	description = "Fancy Bench",
	tiles = {
		cloud,
		cloud,
		nicebench
	},
	drawtype = "nodebox",
	paramtype = "light",
	paramtype2 = "facedir",
	node_box = {
		type = "fixed",
		fixed = benchnodebox
	},
	selection_box = nodecore.fixedbox(),
	groups = {
		cracky = 3,
		furniture = 1,
		bench = 1,
		stack_as_node = 1,
	},
	stack_max = 1,
	paramtype = "light",
	sounds = nodecore.sounds("nc_optics_glassy"),
})
-- ================================================================== --
nodecore.register_craft({
	label = "make wicker bench",
	action = "pummel",
	duration = 4,
	indexkeys = {"wc_storage:shelf_wicker"},
	toolgroups = {thumpy = 2},
	nodes = {
		{match = {name = "wc_storage:shelf_wicker", empty = true},
		replace = modname .. ":bench_wicker"}
	}
})
------------------------------------------------------------------------
nodecore.register_craft({
	label = "make wooden bench",
	action = "pummel",
	duration = 4,
	indexkeys = {"nc_woodwork:shelf"},
	toolgroups = {thumpy = 2},
	nodes = {
		{match = {name = "nc_woodwork:shelf", empty = true},
		replace = modname .. ":bench_wooden"}
	}
})
------------------------------------------------------------------------
nodecore.register_craft({
	label = "make lode bench",
	action = "pummel",
	duration = 4,
	indexkeys = {"wc_storage:shelf_lode_annealed"},
	toolgroups = {thumpy = 3},
	nodes = {
		{match = {name = "wc_storage:shelf_lode_annealed", empty = true},
		replace = modname .. ":bench_lode_annealed"}
	}
})
------------------------------------------------------------------------
nodecore.register_craft({
	label = "plaster lode bench with spackling",
	action = "pummel",
	duration = 10,
	wield  = "nc_concrete:cloudmix",
	consumewield = 1,
	indexkeys = modname.. ":bench_lode_annealed",
	nodes = {
		{match = modname.. ":bench_lode_annealed", replace = modname.. ":bench_fancy"},
	}
})
-- ================================================================== --