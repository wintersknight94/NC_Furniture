-- LUALOCALS < ---------------------------------------------------------
local minetest, nodecore
    = minetest, nodecore
-- LUALOCALS > ---------------------------------------------------------
local modname = minetest.get_current_modname()
------------------------------------------------------------------------
local wood = "nc_tree_tree_side.png"
local cloud = "nc_concrete_cloudstone.png"
local glass = "nc_optics_glass_edges.png^(nc_tree_tree_side.png^[mask:nc_api_storebox_frame.png)"
local glow = "nc_lux_base.png^(" ..glass.. ")"
local fglass = "nc_optics_glass_edges.png^(" ..cloud.. "^[mask:nc_api_storebox_frame.png)"
local fglow = "nc_lux_base.png^(" ..fglass.. ")"
local lamplite = glow.. "^[lowpart:60:" ..wood,"[combine:1x1"
local flamplite = fglow.. "^[lowpart:60:" ..cloud,"[combine:1x1"
-- ================================================================== --
minetest.register_node(modname .. ":lamp", {
	description = "Tiny Lamp",
	tiles = {
		wood,
		wood,
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
	sounds = nodecore.sounds("nc_tree_woody")
	})
------------------------------------------------------------------------
minetest.register_node(modname .. ":lamp_fancy", {
	description = "Fancy Lamp",
	tiles = {
		cloud,
		cloud,
		flamplite	
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
	sounds = nodecore.sounds("nc_tree_woody")
	})
-- ================================================================== --
nodecore.register_craft({
	label = "make lamp",
	action = "pummel",
	duration = 1,
	priority = 1,
	toolgroups = {thumpy = 2},
	normal = {y = 1},
	indexkeys = "wc_storage:lantern",
	nodes = {
		{match = "wc_storage:lantern", replace = "air"},
		{y = -1, match = "nc_tree:log", replace = modname.. ":lamp"}
	}
})
------------------------------------------------------------------------
nodecore.register_craft({
	label = "make fancy lamp",
	action = "pummel",
	duration = 1,
	priority = 1,
	toolgroups = {thumpy = 2},
	normal = {y = 1},
	indexkeys = "wc_storage:lantern",
	nodes = {
		{match = "wc_storage:lantern", replace = "air"},
		{y = -1, match = "nc_concrete:cloudstone", replace = modname.. ":lamp_fancy"}
	}
})
