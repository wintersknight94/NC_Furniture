-- LUALOCALS < ---------------------------------------------------------
local minetest, nodecore, string
    = minetest, nodecore, string
local string_lower
    = string.lower
-- LUALOCALS > ---------------------------------------------------------
local modname = minetest.get_current_modname()
-- ================================================================== --
local wood = "nc_tree_tree_side.png"
local bright = "wc_naturae_bamboo.png"
local bamboo = "wc_naturae_bamboo_dead.png"
local woodframe = "nc_tree_tree_side.png^[mask:nc_api_storebox_frame.png"
local bambooframe = bamboo.. "^[mask:nc_api_storebox_frame.png"
local woodhandle = "nc_tree_tree_side.png^[mask:nc_woodwork_ladder_mask.png"
local dbold = bamboo.. "^(" ..wood.. "^[mask:nc_tote_sides.png)"
local dside = bamboo.. "^(" ..woodframe.. ")"
local drawer = dside.. "^(" ..wood.. "^[mask:" ..modname.. "_drawer.png)"
local glass = "nc_optics_glass_edges.png^(" ..bambooframe.. ")"
local glow = "nc_lux_base.png^(" ..glass.. ")"
local lamplite = glow.. "^[lowpart:60:" ..bamboo,"[combine:1x1"
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
minetest.register_node(modname .. ":bench_bamboo", {
	description = "Bamboo Bench",
	tiles = {bamboo},
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
		flammable = 4,
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
minetest.register_node(modname .. ":chair_bamboo", {
	description = "Bamboo Chair",
	tiles = {bamboo},
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
		flammable = 4,
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
minetest.register_node(modname .. ":table_bamboo", {
	description = "Bamboo Table",
	tiles = {
		"(" ..bamboo.. ")^(" ..woodframe.. ")",
		bamboo
	},
	drawtype = "nodebox",
	paramtype = "light",
	node_box = {
		type = "fixed",
		fixed = tablenodebox
	},
	selection_box = nodecore.fixedbox(),
	groups = {
		choppy = 2,
		flammable = 6,
		fire_fuel = 2,
		furniture = 1,
		table = 1,
		stack_as_node = 1,
	},
	stack_max = 1,
	paramtype = "light",
	sounds = nodecore.sounds("nc_tree_sticky"),
})
------------------------------------------------------------------------
minetest.register_node(modname .. ":shutter_bamboo", {
	description = "Bamboo Shutter",
	tiles = {bamboo.. "^(" ..woodframe.. ")^(" ..woodhandle.. ")"},
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
		flammable = 4,
		fire_fuel = 1,
		shutter = 1,
		flammable = 1,
		furniture = 1
	},
	sounds = nodecore.sounds("nc_tree_sticky")
})
------------------------------------------------------------------------
minetest.register_node(modname .. ":drawers_bamboo", {
	description = "Bamboo Drawers",
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
		choppy = 2,
		furniture = 1,
		flammable = 30,
		fire_fuel = 3,
		drawer = 1,
		stack_as_node = 1,
		storebox = 1,
		visinv = 1
	},
	stack_max = 1,
	sounds = nodecore.sounds("nc_tree_sticky"),
	storebox_access = function(pt) return pt.above.y == pt.under.y end,
	on_ignite = function(pos)
		if minetest.get_node(pos).name == modname .. ":drawers_bamboo" then
			return nodecore.stack_get(pos)
		end
	end
})
------------------------------------------------------------------------
minetest.register_node(modname .. ":lamp_bamboo", {
	description = "Bamboo Lamp",
	tiles = {
		bamboo,
		bamboo,
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
		flammable = 12,
		fire_fuel = 2,
		stack_as_node = 1,
	},
	sounds = nodecore.sounds("nc_tree_sticky")
	})
-- ================================================================== --
nodecore.register_craft({
	label = "make bamboo bench",
	action = "pummel",
	duration = 4,
	indexkeys = {"wc_storage:shelf_bamboo"},
	toolgroups = {thumpy = 2},
	nodes = {
		{match = {name = "wc_storage:shelf_bamboo", empty = true},
		replace = modname .. ":bench_bamboo"}
	}
})
------------------------------------------------------------------------
nodecore.register_craft({
	label = "assemble bamboo chair",
	indexkeys = {"wc_naturae:bamboo_dead_3"},
	nodes = {
		{match = "wc_naturae:bamboo_dead_3", replace = modname.. ":chair_bamboo"},
		{x = -1, match = "wc_naturae:bamboo_dead_1", replace = "air"},
		{x = 1, match = "wc_naturae:bamboo_dead_1", replace = "air"},
		{z = -1, match = "wc_naturae:bamboo_dead_1", replace = "air"},
		{z = 1, match = "wc_naturae:bamboo_dead_1", replace = "air"},
	},
})
------------------------------------------------------------------------
nodecore.register_craft({
	label = "assemble bamboo table",
	indexkeys = {"wc_naturae:bamboo_dead_4"},
	nodes = {
		{match = "wc_naturae:bamboo_dead_4", replace = modname.. ":table_bamboo"},
		{x = -1, match = "wc_naturae:bamboo_dead_1", replace = "air"},
		{x = 1, match = "wc_naturae:bamboo_dead_1", replace = "air"},
		{z = -1, match = "wc_naturae:bamboo_dead_1", replace = "air"},
		{z = 1, match = "wc_naturae:bamboo_dead_1", replace = "air"},
	},
})
------------------------------------------------------------------------
nodecore.register_craft({
	label = "make bamboo shutters",
	action = "pummel",
	duration = 4,
	toolgroups = {choppy = 3},
	indexkeys = {"wc_storage:shelf_bamboo"},
	nodes = {{match = {name = "wc_storage:shelf_bamboo", empty = true}, replace = "air"}},
	items = {{name = modname.. ":shutter_bamboo", count = 2, scatter = 2}},
	itemscatter = 2
})
------------------------------------------------------------------------
nodecore.register_craft({
	label = "assemble bamboo drawers",
	action = "stackapply",
	indexkeys = {"wc_storage:shelf_bamboo"},
	wield = {name = "nc_doors:panel_plank"},
	consumewield = 1,
	nodes = {
		{
			match = {name = "wc_storage:shelf_bamboo", empty = true},
			replace = modname .. ":drawers_bamboo"
		},
	}
})
------------------------------------------------------------------------
nodecore.register_craft({
	label = "make bamboo lamp",
	action = "pummel",
	duration = 1,
	priority = 1,
	toolgroups = {thumpy = 2},
	normal = {y = 1},
	indexkeys = "wc_storage:lantern",
	nodes = {
		{match = "wc_storage:lantern", replace = "air"},
		{y = -1, match = "wc_naturae:bamboo_dead_1", replace = modname.. ":lamp_bamboo"}
	}
})
------------------------------------------------------------------------
-- ================================================================== --
