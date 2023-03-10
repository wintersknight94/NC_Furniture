-- LUALOCALS < ---------------------------------------------------------
local minetest, nodecore, string
    = minetest, nodecore, string
local string_lower
    = string.lower
-- LUALOCALS > ---------------------------------------------------------
local modname = minetest.get_current_modname()
-- ================================================================== --
local lode = "nc_lode_annealed.png^[colorize:black:50"
local pumice = "nc_igneous_pumice.png"
local lodeframe = lode.. "^[mask:nc_api_storebox_frame.png"
local pumframe = pumice.. "^[mask:nc_api_storebox_frame.png"
local lodehandle = lode.. "^[mask:nc_woodwork_ladder_mask.png"
local pumtop = pumice.. "^(" ..lode.. "^[mask:nc_api_storebox_frame.png)"
local pumtable = pumtop..	"^[lowpart:90:" ..lode,"[combine:1x1"
local pumbench	= pumice..	"^[lowpart:35:" ..lode,"[combine:1x1"
local dbold = pumice.. "^(" ..lode.. "^[mask:nc_tote_sides.png)"
local dside = pumice.. "^(" ..lodeframe.. ")"
local drawer = dside.. "^(" ..lode.. "^[mask:" ..modname.. "_drawer.png)"
local glass = "nc_optics_glass_edges.png^(" ..pumframe.. ")"
local glow = "(nc_lux_base.png^[colorize:darkred:200)^(" ..glass.. ")"
local lamplite = glow.. "^[lowpart:60:" ..pumice,"[combine:1x1"
local pumchair = pumice.. "^(" ..lode.. "^[mask:(" ..modname.. "_trim.png^" ..modname.. "_bind.png))"
local pumseat = pumice.. "^(" ..lode.. "^[mask:(" ..modname.. "_seat.png^nc_concrete_pattern_vermy.png))"
------------------------------------------------------------------------
local benchnodebox = {
	{-0.5, -0.125, -0.3125, 0.5, 0, 0.3125},			-- Seat
	{-0.4375, -0.5, 0.0625, -0.3125, -0.125, 0.1875},	-- Leg(BackLeft)
	{0.3125, -0.5, 0.0625, 0.4375, -0.125, 0.1875},		-- Leg(BackRight)
	{0.3125, -0.5, -0.1875, 0.4375, -0.125, -0.0625},	-- Leg(FrontRight)
	{-0.4375, -0.5, -0.1875, -0.3125, -0.125, -0.0625},	-- Leg(FrontLeft)
--	{-0.5, -0.375, -0.0625, 0.5, -0.25, 0.0625}, 		-- Brace
}
local chairnodebox = {
	{-0.4375, -0.0625, 0.3125, 0.4375, 0.375, 0.4375},	-- Back
	{-0.4375, -0.0625, -0.4375, 0.4375, 0.0625, 0.4375},	-- Seat
	{-0.4375, -0.5, -0.4375, -0.3125, -0.0625, -0.3125},	-- Leg
	{-0.4375, -0.5, 0.3125, -0.3125, -0.0625, 0.4375},	-- Leg
	{0.3125, -0.5, 0.3125, 0.4375, -0.0625, 0.4375},	-- Leg
	{0.3125, -0.5, -0.4375, 0.4375, -0.0625, -0.3125},	-- Leg
	{-0.3125, 0.3125, 0.3125, 0.3125, 0.5, 0.4375},		-- BackArch
}
local tablenodebox = {
	{-0.5, 0.3125, -0.5, 0.5, 0.5, 0.5},				-- Top
	{-0.5, -0.5, -0.5, -0.375, 0.3125, -0.375},		-- Leg
	{0.375, -0.5, 0.375, 0.5, 0.3125, 0.5},			-- Leg
	{0.375, -0.5, -0.5, 0.5, 0.3125, -0.375},			-- Leg
	{-0.5, -0.5, 0.375, -0.375, 0.3125, 0.5},			-- Leg
}
local drawernodebox = {
	{-0.5, -0.5, -0.4375, 0.5, 0.5, 0.5},				-- Cabinet
	{-0.375, 0.0625, -0.5, 0.375, 0.375, 0.375},		-- TopDrawer
	{-0.375, -0.375, -0.5, 0.375, -0.0625, 0.375},		-- BottomDrawer
	{-0.0625, 0.1875, -0.5625, 0.0625, 0.25, -0.4375},	-- TopKnob
	{-0.0625, -0.25, -0.5625, 0.0625, -0.1875, -0.4375},	-- BottomKnob
}
local flatnodebox = {-0.5, -0.5, 0.4375, 0.5, 0.5, 0.5}	-- WallPlate
-- ================================================================== --
minetest.register_node(modname .. ":bench_pumice", {
	description = "Vulcan Bench",
	tiles = {
		pumice,
		pumice,
		pumbench
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
------------------------------------------------------------------------
minetest.register_node(modname .. ":chair_pumice", {
	description = "Vulcan Chair",
	tiles = {
		pumseat,
		pumseat,
		pumchair
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
		furniture = 1,
		chair = 1,
		stack_as_node = 1,
	},
	stack_max = 1,
	paramtype = "light",
	sounds = nodecore.sounds("nc_optics_glassy"),
})
------------------------------------------------------------------------
minetest.register_node(modname .. ":table_pumice", {
	description = "Vulcan Table",
	tiles = {
		pumtop,
		pumtop,
		pumtable
	},
	drawtype = "nodebox",
	paramtype = "light",
	node_box = {
		type = "fixed",
		fixed = tablenodebox
	},
	selection_box = nodecore.fixedbox(),
	groups = {
		cracky = 3,
		furniture = 1,
		table = 1,
		stack_as_node = 1,
	},
	stack_max = 1,
	paramtype = "light",
	sounds = nodecore.sounds("nc_optics_glassy"),
})
------------------------------------------------------------------------
minetest.register_node(modname .. ":shutter_pumice", {
	description = "Vulcan Shutter",
	tiles = {pumice.. "^(" ..lodeframe.. ")^(" ..lodehandle.. ")"},
	drawtype = "nodebox",
	paramtype = "light",
	paramtype2 = "facedir",
	node_box = {
		type = "fixed",
		fixed = {flatnodebox}
	},
	selection_box = nodecore.fixedbox(-0.5, -0.5, 0.4375, 0.5, 0.5, 0.5),
	groups = {
		snappy = 1,
		shutter = 1,
		furniture = 1
	},
	sounds = nodecore.sounds("nc_optics_glassy"),
})
------------------------------------------------------------------------
minetest.register_node(modname .. ":drawers_pumice", {
	description = "Vulcan Drawers",
	tiles = {
		dbold,	--top
		dbold,	--bottom
		dbold,	--side
		dbold,	--side
		dbold,	--back
		drawer	--front
	},
	drawtype = "nodebox",
	paramtype2 = "facedir",
	node_box = {
		type = "fixed",
		fixed = drawernodebox
	},
	selection_box = nodecore.fixedbox(),
	groups = {
		cracky = 3,
		furniture = 1,
		drawer = 1,
		stack_as_node = 1,
		storebox = 1,
		visinv = 1
	},
	stack_max = 1,
	sounds = nodecore.sounds("nc_optics_glassy"),
	storebox_access = function(pt) return pt.above.y == pt.under.y end,
	on_ignite = function(pos)
		if minetest.get_node(pos).name == modname .. ":drawers_pumice" then
			return nodecore.stack_get(pos)
		end
	end
})
------------------------------------------------------------------------
minetest.register_node(modname .. ":lamp_pumice", {
	description = "Vulcan Lamp",
	tiles = {
		pumice,
		pumice,
		lamplite
	},
	drawtype = "nodebox",
	paramtype = "light",
	light_source = 6,
	node_box = {
		type = "fixed",
		fixed = {
			{-0.3125, -0.5, -0.125, 0.3125, -0.4375, 0.125},	-- BaseX
			{-0.125, -0.5, -0.3125, 0.125, -0.4375, 0.3125},	-- BaseZ
			{-0.25, -0.5, -0.25, 0.25, -0.4375, 0.25},			-- BaseC
			{-0.0625, -0.5, -0.0625, 0.0625, 0.5, 0.0625},		-- Post
			{-0.3125, 0.0625, -0.3125, 0.3125, 0.5, 0.3125},	-- Lamp
		}
	},
	groups = {
		snappy = 1,
		stack_as_node = 1,
	},
	sounds = nodecore.sounds("nc_optics_glassy"),
	})
-- ================================================================== --
nodecore.register_craft({
	label = "make pumice bench",
	action = "pummel",
	duration = 4,
	indexkeys = {"wc_storage:shelf_pumice"},
	toolgroups = {thumpy = 4},
	nodes = {
		{match = {name = "wc_storage:shelf_pumice", empty = true},
		replace = modname .. ":bench_pumice"}
	}
})
------------------------------------------------------------------------
nodecore.register_craft({
	label = "assemble pumice chair",
	indexkeys = {"nc_igneous:pumice"},
	nodes = {
		{match = "nc_igneous:pumice", replace = modname.. ":chair_pumice"},
		{x = -1, match = "nc_lode:bar_annealed", replace = "air"},
		{x = 1, match = "nc_lode:bar_annealed", replace = "air"},
		{z = -1, match = "nc_lode:bar_annealed", replace = "air"},
		{z = 1, match = "nc_lode:bar_annealed", replace = "air"},
	},
})
------------------------------------------------------------------------
nodecore.register_craft({
	label = "assemble pumice table",
	indexkeys = {"nc_igneous:pumice"},
	nodes = {
		{match = "nc_igneous:pumice", replace = modname.. ":table_pumice"},
		{x = -1, match = "nc_lode:rod_annealed", replace = "air"},
		{x = 1, match = "nc_lode:rod_annealed", replace = "air"},
		{z = -1, match = "nc_lode:rod_annealed", replace = "air"},
		{z = 1, match = "nc_lode:rod_annealed", replace = "air"},
	},
})
------------------------------------------------------------------------
nodecore.register_craft({
	label = "make pumice shutters",
	action = "pummel",
	duration = 4,
	toolgroups = {choppy = 5},
	indexkeys = {"wc_storage:shelf_pumice"},
	nodes = {{match = {name = "wc_storage:shelf_pumice", empty = true}, replace = "air"}},
	items = {{name = modname.. ":shutter_pumice", count = 2, scatter = 2}},
	itemscatter = 2
})
------------------------------------------------------------------------
nodecore.register_craft({
	label = "assemble pumice drawers",
	action = "stackapply",
	indexkeys = {"wc_storage:shelf_pumice"},
	wield = {name = "nc_doors:panel_bricks_coalstone_bonded"},
	consumewield = 1,
	nodes = {
		{
			match = {name = "wc_storage:shelf_pumice", empty = true},
			replace = modname .. ":drawers_pumice"
		},
	}
})
------------------------------------------------------------------------
nodecore.register_craft({
	label = "make pumice lamp",
	action = "pummel",
	duration = 1,
	priority = 1,
	toolgroups = {thumpy = 2},
	normal = {y = 1},
	indexkeys = "wc_storage:lantern",
	nodes = {
		{match = "wc_storage:lantern", replace = "air"},
		{y = -1, match = "nc_igneous:pumice", replace = modname.. ":lamp_pumice"}
	}
})
------------------------------------------------------------------------
-- ================================================================== --
