-- LUALOCALS < ---------------------------------------------------------
local ItemStack, math, minetest, nodecore, pairs, setmetatable, vector
	= ItemStack, math, minetest, nodecore, pairs, setmetatable, vector
-- LUALOCALS > ---------------------------------------------------------
local modname = minetest.get_current_modname()
------------------------------------------------------------------------
local rfcall = function(pos, data)
	local ref = minetest.get_player_by_name(data.pname)
	local wield = ref:get_wielded_item()
	wield:take_item(1)
	ref:set_wielded_item(wield)
end
-- ================================================================== --
local china = "nc_concrete_cloudstone.png"
local plate = "nc_optics_port_output.png"
local cup = "nc_woodwork_ladder_mask.png"
local chinaplate = china.."^(nc_optics_glass_frost.png^[mask:" ..plate.. ")"
local chinacup = china.."^(nc_optics_glass_frost.png^[mask:" ..cup.. ")"
-- ================================================================== --
minetest.register_node(modname .. ":plate", {
	description = "Plate",
	tiles = {
		chinaplate,	--top
		china,		--bottom
		china			--sides
	},
	drawtype = "nodebox",
	paramtype = "light",
	node_box = {
		type = "fixed",
		fixed = {
			{-0.375, -0.5, -0.1875, 0.375, -0.4375, 0.1875}, -- X
			{-0.1875, -0.5, -0.375, 0.1875, -0.4375, 0.375}, -- Z
			{-0.3125, -0.5, -0.3125, 0.3125, -0.4375, 0.3125}, -- C
		}
	},
	selection_box = nodecore.fixedbox(),
	groups = {
		snappy = 1,
		china = 1,
		stack_as_node = 1,
	},
	sounds = nodecore.sounds("nc_optics_glassy")
	})
------------------------------------------------------------------------
minetest.register_node(modname .. ":bowl", {
	description = "Bowl",
	tiles = {
		chinaplate,	--top
		china,		--bottom
		china			--sides
	},
	drawtype = "nodebox",
	paramtype = "light",
	node_box = {
		type = "fixed",
		fixed = {
			{-0.3125, -0.3125, 0.1875, 0.3125, -0.25, 0.3125}, 
			{-0.3125, -0.3125, -0.3125, 0.3125, -0.25, -0.1875},
			{-0.3125, -0.3125, -0.3125, -0.1875, -0.25, 0.3125},
			{0.1875, -0.3125, -0.3125, 0.3125, -0.25, 0.3125},
			{-0.25, -0.5, -0.25, 0.25, -0.3125, 0.25},
		}
	},
	selection_box = nodecore.fixedbox(),
	groups = {
		snappy = 1,
		china = 1,
		stack_as_node = 1,
	},
	sounds = nodecore.sounds("nc_optics_glassy")
	})
------------------------------------------------------------------------
minetest.register_node(modname .. ":cup", {
	description = "Cup",
	tiles = {
		chinacup,	--top
		china,	--bottom
		china		--sides
	},
	drawtype = "nodebox",
	paramtype = "light",
	node_box = {
		type = "fixed",
		fixed = {
			{-0.125, -0.3125, -0.125, 0.125, -0.0625, 0.125},
			{-0.0625, -0.4375, -0.0625, 0.0625, -0.3125, 0.0625},
			{-0.125, -0.5, -0.125, 0.125, -0.4375, 0.125},
		}
	},
	selection_box = nodecore.fixedbox(),
	groups = {
		snappy = 1,
		china = 1,
		stack_as_node = 1,
	},
	sounds = nodecore.sounds("nc_optics_glassy")
	})
------------------------------------------------------------------------
minetest.register_node(modname .. ":mug", {
	description = "Mug",
	tiles = {
		chinacup,	--top
		china,	--bottom
		china		--sides
	},
	drawtype = "nodebox",
	paramtype = "light",
	node_box = {
		type = "fixed",
		fixed = {
			{-0.125, -0.5, -0.125, 0.125, -0.1875, 0.125},	-- Mug
			{-0.0625, -0.4375, -0.25, 0, -0.25, -0.1875},	-- Handle
			{-0.0625, -0.3125, -0.25, 0, -0.25, -0.0625},	-- HandleTop
			{-0.0625, -0.4375, -0.25, 0, -0.375, -0.0625},	-- HandleBottom
		}
	},
	selection_box = nodecore.fixedbox(),
	groups = {
		snappy = 1,
		china = 1,
		stack_as_node = 1,
	},
	sounds = nodecore.sounds("nc_optics_glassy")
	})
------------------------------------------------------------------------
minetest.register_node(modname .. ":vase", {
	description = "Vase",
	tiles = {
		chinacup,	--top
		china,	--bottom
		china		--sides
	},
	drawtype = "nodebox",
	paramtype = "light",
	node_box = {
		type = "fixed",
		fixed = {
			{-0.0625, -0.5, -0.0625, 0.0625, 0.125, 0.0625},
			{-0.125, 0.125, -0.125, 0.125, 0.1875, 0.125},
			{-0.1875, -0.4375, -0.1875, 0.1875, -0.125, 0.1875},
			{-0.125, -0.5, -0.125, 0.125, 0, 0.125},
		}
	},
	selection_box = nodecore.fixedbox(),
	groups = {
		snappy = 1,
		china = 1,
		stack_as_node = 1,
	},
	sounds = nodecore.sounds("nc_optics_glassy")
	})
-- ================================================================== --
nodecore.register_craft({
	label = "make dishes",
	action = "pummel",
	priority = 1,
	duration = 2,
	wield = "group:chisel",
	indexkeys = "nc_concrete:cloudstone",
	nodes = {
		{match = "nc_concrete:cloudstone", replace = modname.. ":plate"}
	}
})
------------------------------------------------------------------------
nodecore.register_craft({
	label = "swap dishes 1",
	action = "pummel",
--	duration = 1,
	priority = 1,
	toolgroups = {thumpy = 1},
	indexkeys = modname.. ":plate",
	nodes = {
		{match = modname.. ":plate", replace = modname.. ":cup"}
	}
})
------------------------------------------------------------------------
nodecore.register_craft({
	label = "swap dishes 2",
	action = "pummel",
--	duration = 1,
	priority = 1,
	toolgroups = {thumpy = 1},
	indexkeys = modname.. ":cup",
	nodes = {
		{match = modname.. ":cup", replace = modname.. ":mug"}
	}
})
------------------------------------------------------------------------
nodecore.register_craft({
	label = "swap dishes 3",
	action = "pummel",
--	duration = 1,
	priority = 1,
	toolgroups = {thumpy = 1},
	indexkeys = modname.. ":mug",
	nodes = {
		{match = modname.. ":mug", replace = modname.. ":vase"}
	}
})
------------------------------------------------------------------------
nodecore.register_craft({
	label = "swap dishes 4",
	action = "pummel",
--	duration = 1,
	priority = 1,
	toolgroups = {thumpy = 1},
	indexkeys = modname.. ":vase",
	nodes = {
		{match = modname.. ":vase", replace = modname.. ":bowl"}
	}
})
------------------------------------------------------------------------
nodecore.register_craft({
	label = "swap dishes 5",
	action = "pummel",
--	duration = 1,
	priority = 1,
	toolgroups = {thumpy = 1},
	indexkeys = modname.. ":bowl",
	nodes = {
		{match = modname.. ":bowl", replace = modname.. ":plate"}
	}
})
-- ================================================================== --
