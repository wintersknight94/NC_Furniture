-- LUALOCALS < ---------------------------------------------------------
local minetest, nodecore, ItemStack
    = minetest, nodecore, ItemStack
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
local wood = "nc_tree_tree_side.png"
local glass = "nc_optics_glass_glare.png"
local frost = "nc_optics_glass_frost.png"
local anlode = "nc_lode_annealed.png"
local aurum = "nc_lode_tempered.png^[colorize:gold:50"
local mirror = "nc_optics_glass_frost.png^[colorize:white:120"
------------------------------------------------------------------------
local woodframe = "nc_tree_tree_side.png^[mask:nc_api_storebox_frame.png"
local woodhandle = "nc_tree_tree_side.png^[mask:nc_woodwork_ladder_mask.png"
local lodeframe = "nc_lode_annealed.png^[mask:nc_api_storebox_frame.png"
local lodehandle = "nc_lode_tempered.png^[mask:nc_woodwork_ladder_mask.png"
local tmlodeframe = "nc_lode_tempered.png^[mask:nc_api_storebox_frame.png"
local anlodeframe = "nc_lode_annealed.png^[mask:(nc_api_storebox_frame.png^nc_concrete_pattern_bindy.png)"
local aurumframe = "(nc_lode_tempered.png^[colorize:gold:50)^[mask:(nc_api_storebox_frame.png^nc_concrete_pattern_bindy.png)"
local goldhandle = aurum.. "^[mask:nc_woodwork_ladder_mask.png"
------------------------------------------------------------------------
local flatnodebox = {-0.5, -0.5, 0.4375, 0.5, 0.5, 0.5} -- WallPlate
local panenodebox = {
	{-0.5, -0.5, -0.0625, 0.5, 0.5, 0.0625},	-- Pane
	{-0.5, -0.5, -0.125, -0.4375, 0.5, 0.125},	-- FrameL
	{0.4375, -0.5, -0.125, 0.5, 0.5, 0.125},	-- FrameR
	{-0.5, 0.4375, -0.125, 0.5, 0.5, 0.125},	-- FrameT
	{-0.5, -0.5, -0.125, 0.5, -0.4375, 0.125},	-- FrameB
}
-- ================================================================== --
minetest.register_node(modname .. ":mirror", {
	description = "Mirror",
	tiles = {mirror.. "^(" ..woodframe.. ")"},
	drawtype = "nodebox",
	glasslike_framed = true,
	paramtype = "light",
	paramtype2 = "facedir",
	node_box = {
		type = "fixed",
		fixed = {flatnodebox}
	},
	selection_box = nodecore.fixedbox(-0.5, -0.5, 0.4375, 0.5, 0.5, 0.5),
	groups = {
		snappy = 1,
		mirror = 1,
		silica = 1,
		furniture = 1
	},
	sounds = nodecore.sounds("nc_optics_glassy")
	})
------------------------------------------------------------------------
minetest.register_node(modname .. ":mirror_fancy", {
	description = "Fancy Mirror",
	tiles = {mirror.. "^(" ..aurumframe.. ")"},
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
		mirror = 1,
		silica = 1,
		furniture = 1
	},
	sounds = nodecore.sounds("nc_optics_glassy")
	})
-- ================================================================== --
minetest.register_node(modname .. ":screen_wicker", {
	description = "Wicker Screen",
	tiles = {"nc_flora_wicker.png^(" ..woodframe.. ")"},
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
		screen = 1,
		flammable = 1,
		furniture = 1
	},
	sunlight_propagates = true,
	sounds = nodecore.sounds("nc_tree_sticky")
	})
------------------------------------------------------------------------
minetest.register_node(modname .. ":screen_lode_annealed", {
	description = "Lode Screen",
	tiles = {"(nc_lode_annealed.png^[mask:nc_concrete_pattern_hashy.png)^(" ..lodeframe.. ")"},
	drawtype = "nodebox",
	paramtype = "light",
	paramtype2 = "facedir",
	node_box = {
		type = "fixed",
		fixed = {flatnodebox}
	},
	selection_box = nodecore.fixedbox(-0.5, -0.5, 0.4375, 0.5, 0.5, 0.5),
	groups = {
		cracky = 2,
		screen = 1,
		furniture = 1
	},
	sunlight_propagates = true,
	sounds = nodecore.sounds("nc_lode_annealed")
	})
-- ================================================================== --
minetest.register_node(modname .. ":shutter_wooden", {
	description = "Wooden Shutter",
	tiles = {"nc_woodwork_plank.png^(" ..woodframe.. ")^(" ..woodhandle.. ")"},
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
		flammable = 1,
		furniture = 1
	},
	sounds = nodecore.sounds("nc_tree_woody")
	})
------------------------------------------------------------------------
minetest.register_node(modname .. ":shutter_lode_annealed", {
	description = "Lode Shutter",
	tiles = {"nc_lode_annealed.png^(" ..tmlodeframe.. ")^(" ..lodehandle.. ")"},
	drawtype = "nodebox",
	paramtype = "light",
	paramtype2 = "facedir",
	node_box = {
		type = "fixed",
		fixed = {flatnodebox}
	},
	selection_box = nodecore.fixedbox(-0.5, -0.5, 0.4375, 0.5, 0.5, 0.5),
	groups = {
		cracky = 2,
		shutter = 1,
		furniture = 1
	},
	sounds = nodecore.sounds("nc_lode_annealed")
	})
------------------------------------------------------------------------
minetest.register_node(modname .. ":shutter_fancy", {
	description = "Fancy Shutter",
	tiles = {"nc_concrete_cloudstone.png^(" ..aurumframe.. ")^(" ..goldhandle.. ")"},
	drawtype = "nodebox",
	paramtype = "light",
	paramtype2 = "facedir",
	node_box = {
		type = "fixed",
		fixed = {flatnodebox}
	},
	selection_box = nodecore.fixedbox(-0.5, -0.5, 0.4375, 0.5, 0.5, 0.5),
	groups = {
		cracky = 2,
		shutter = 1,
		furniture = 1
	},
	sounds = nodecore.sounds("nc_lode_annealed")
	})
-- ================================================================== --
minetest.register_node(modname .. ":pane_glass_clear", {
	description = "Clear Glass Window Pane",
	tiles = {
		anlode,
		anlode,
		anlode,
		anlode,
		glass.. "^(" ..anlodeframe.. ")",
		glass.. "^(" ..anlodeframe.. ")"
	},
	drawtype = "nodebox",
	glasslike_framed = true,
	paramtype = "light",
	paramtype2 = "facedir",
	node_box = {
		type = "fixed",
		fixed = panenodebox
	},
	selection_box = nodecore.fixedbox(-0.5, -0.5, -0.0625, 0.5, 0.5, 0.0625),
	groups = {
		snappy = 1,
		windowpane = 1,
		silica = 1,
		furniture = 1
	},
	sounds = nodecore.sounds("nc_optics_glassy")
	})
------------------------------------------------------------------------
minetest.register_node(modname .. ":pane_fancy", {
	description = "Fancy Window Pane",
	tiles = {
		aurum,
		aurum,
		aurum,
		aurum,
		frost.. "^(" ..aurumframe.. ")",
		frost.. "^(" ..aurumframe.. ")"
	},
	drawtype = "nodebox",
	glasslike_framed = true,
	paramtype = "light",
	paramtype2 = "facedir",
	node_box = {
		type = "fixed",
		fixed = panenodebox
	},
	selection_box = nodecore.fixedbox(-0.5, -0.5, -0.0625, 0.5, 0.5, 0.0625),
	groups = {
		snappy = 1,
		windowpane = 1,
		silica = 1,
		furniture = 1
	},
	sounds = nodecore.sounds("nc_optics_glassy")
	})
-- ================================================================== --
-- ================================================================== --
nodecore.register_craft({
	label = "make wicker screen",
	action = "pummel",
	duration = 4,
	toolgroups = {choppy = 3},
	indexkeys = {"wc_storage:shelf_wicker"},
	nodes = {{match = {name = "wc_storage:shelf_wicker", empty = true}, replace = "air"}},
	items = {{name = modname.. ":screen_wicker", count = 2, scatter = 2}},
	itemscatter = 2
})
------------------------------------------------------------------------
nodecore.register_craft({
	label = "make lode screen",
	action = "pummel",
	duration = 4,
	toolgroups = {choppy = 5},
	indexkeys = {"nc_lode:shelf"},
	nodes = {{match = {name = "nc_lode:shelf", empty = true}, replace = "air"}},
	items = {{name = modname.. ":screen_lode_annealed", count = 2, scatter = 2}},
	itemscatter = 2
})
-- ================================================================== --
nodecore.register_craft({
	label = "make wooden shutter",
	action = "pummel",
	duration = 4,
	toolgroups = {choppy = 3},
	indexkeys = {"nc_woodwork:shelf"},
	nodes = {{match = {name = "nc_woodwork:shelf", empty = true}, replace = "air"}},
	items = {{name = modname.. ":shutter_wooden", count = 2, scatter = 2}},
	itemscatter = 2
})
------------------------------------------------------------------------
nodecore.register_craft({
	label = "make lode shutter",
	action = "pummel",
	duration = 4,
	toolgroups = {choppy = 5},
	indexkeys = {"wc_storage:shelf_lode_annealed"},
	nodes = {{match = {name = "wc_storage:shelf_lode_annealed", empty = true}, replace = "air"}},
	items = {{name = modname.. ":shutter_lode_annealed", count = 2, scatter = 2}},
	itemscatter = 2
})
------------------------------------------------------------------------
nodecore.register_craft({
	label = "plaster lode shutter with spackling",
	action = "pummel",
	wield = {name = "nc_concrete:cloudmix"},
	after = rfcall,
		nodes = {
			{match = modname .. ":shutter_lode_annealed", replace = modname .. ":shutter_fancy"}
		}
})
-- ================================================================== --
nodecore.register_craft({
	label = "cut glass windowpane",
	action = "pummel",
	duration = 4,
	toolgroups = {choppy = 5},
	indexkeys = {"nc_optics:shelf"},
	nodes = {{match = {name = "nc_optics:shelf", empty = true}, replace = "air"}},
	items = {{name = modname.. ":pane_glass_clear", count = 4, scatter = 2}},
	itemscatter = 2
})
------------------------------------------------------------------------
nodecore.register_craft({
	label = "cut fancy windowpane",
	action = "pummel",
	duration = 4,
	toolgroups = {choppy = 5},
	indexkeys = {"wc_storage:shelf_frost"},
	nodes = {{match = {name = "wc_storage:shelf_frost", empty = true}, replace = "air"}},
	items = {{name = modname.. ":pane_fancy", count = 4, scatter = 2}},
	itemscatter = 2
})
-- ================================================================== --
nodecore.register_craft({
	label = "polish mirror",
	action = "pummel",
	wield = {name = "nc_concrete:cloudmix"},
	after = rfcall,
		nodes = {
			{match = modname .. ":pane_fancy", replace = modname .. ":mirror"}
		}
})
------------------------------------------------------------------------
nodecore.register_craft({
	label = "polish fancy mirror",
	action = "pummel",
	wield = {name = "nc_concrete:cloudmix"},
	after = rfcall,
		nodes = {
			{match = modname .. ":mirror", replace = modname .. ":mirror_fancy"}
		}
})

