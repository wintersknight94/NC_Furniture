-- LUALOCALS < ---------------------------------------------------------
local minetest, nodecore
    = minetest, nodecore
-- LUALOCALS > ---------------------------------------------------------
local modname = minetest.get_current_modname()
------------------------------------------------------------------------
local wood = "nc_tree_tree_side.png"
local flora = "nc_flora_wicker.png"
local plank = "nc_woodwork_plank.png"
local cloud = "nc_concrete_cloudstone.png"
local alode = "nc_lode_annealed.png^[colorize:black:50"
local tlode = "nc_lode_tempered.png"
local flode = "nc_lode_tempered.png^[colorize:gold:50"
------------------------------------------------------------------------
local pdbold = flora.. "^(" ..wood.. "^[mask:nc_tote_sides.png)"
local pdside = flora.. "^(" ..wood.. "^[mask:nc_api_storebox_frame.png)"
local pdrawer = pdside.. "^(" ..wood.. "^[mask:" ..modname.. "_drawer.png)"
------------------------------------------------------------------------
local wdbold = plank.. "^(" ..wood.. "^[mask:nc_tote_sides.png)"
local wdside = plank.. "^(" ..wood.. "^[mask:nc_api_storebox_frame.png)"
local wdrawer = wdside.. "^(" ..wood.. "^[mask:" ..modname.. "_drawer.png)"
------------------------------------------------------------------------
local ldbold = alode.. "^(" ..tlode.. "^[mask:nc_tote_sides.png)"
local ldside = alode.. "^(" ..tlode.. "^[mask:nc_api_storebox_frame.png)"
local ldrawer = ldside.. "^(" ..tlode.. "^[mask:" ..modname.. "_drawer.png)"
------------------------------------------------------------------------
local fdbold = cloud.. "^(" ..flode.. "^[mask:nc_tote_sides.png)"
local fdside = cloud.. "^(" ..flode.. "^[mask:nc_api_storebox_frame.png)"
local fdrawer = fdside.. "^(" ..flode.. "^[mask:" ..modname.. "_drawer.png)"
------------------------------------------------------------------------
local drawernodebox = {
	{-0.5, -0.5, -0.4375, 0.5, 0.5, 0.5},				-- Cabinet
	{-0.375, 0.0625, -0.5, 0.375, 0.375, 0.375},		-- TopDrawer
	{-0.375, -0.375, -0.5, 0.375, -0.0625, 0.375},		-- BottomDrawer
	{-0.0625, 0.1875, -0.5625, 0.0625, 0.25, -0.4375},	-- TopKnob
	{-0.0625, -0.25, -0.5625, 0.0625, -0.1875, -0.4375},	-- BottomKnob
}
-- ================================================================== --
minetest.register_node(modname .. ":drawers_wicker", {
	description = "Wicker Drawers",
	tiles = {
		pdbold,	--top
		pdbold,	--bottom
		pdbold,	--side
		pdbold,	--side
		pdbold,	--back
		pdrawer	--front
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
		drawer = 1,
		stack_as_node = 1,
		storebox = 1,
		visinv = 1
	},
	stack_max = 1,
	sounds = nodecore.sounds("nc_tree_sticky"),
	storebox_access = function(pt) return pt.above.y == pt.under.y end,
	on_ignite = function(pos)
		if minetest.get_node(pos).name == modname .. ":drawers_wicker" then
			return nodecore.stack_get(pos)
		end
	end
})
------------------------------------------------------------------------
minetest.register_node(modname .. ":drawers_wooden", {
	description = "Wooden Drawers",
	tiles = {
		wdside,	--top
		wdside,	--bottom
		wdside,	--side
		wdside,	--side
		wdside,	--back
		wdrawer	--front
	},
	drawtype = "nodebox",
	paramtype2 = "facedir",
	node_box = {
		type = "fixed",
		fixed = drawernodebox
	},
	selection_box = nodecore.fixedbox(),
	groups = {
		choppy = 3,
		furniture = 1,
		drawer = 1,
		stack_as_node = 1,
		storebox = 1,
		visinv = 1
	},
	stack_max = 1,
	sounds = nodecore.sounds("nc_tree_woody"),
	storebox_access = function(pt) return pt.above.y == pt.under.y end,
		on_ignite = function(pos)
			if minetest.get_node(pos).name == modname .. ":drawers_wooden" then
				return nodecore.stack_get(pos)
			end
		end
})
------------------------------------------------------------------------
minetest.register_node(modname .. ":drawers_lode_annealed", {
	description = "Lode Drawers",
	tiles = {
		ldside,	--top
		ldside,	--bottom
		ldside,	--side
		ldside,	--side
		ldside,	--back
		ldrawer	--front
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
	sounds = nodecore.sounds("nc_lode_annealed"),
	storebox_access = function(pt) return pt.above.y == pt.under.y end,
		on_ignite = function(pos)
			if minetest.get_node(pos).name == modname .. ":drawers_lode_annealed" then
				return nodecore.stack_get(pos)
			end
		end
})
------------------------------------------------------------------------
minetest.register_node(modname .. ":drawers_fancy", {
	description = "Fancy Drawers",
	tiles = {
		fdside,	--top
		fdside,	--bottom
		fdside,	--side
		fdside,	--side
		fdside,	--back
		fdrawer	--front
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
	sounds = nodecore.sounds("nc_lode_tempered"),
	storebox_access = function(pt) return pt.above.y == pt.under.y end,
		on_ignite = function(pos)
			if minetest.get_node(pos).name == modname .. ":drawers_fancy" then
				return nodecore.stack_get(pos)
			end
		end
})

-- ================================================================== --
nodecore.register_craft({
		label = "assemble wicker drawers",
		action = "stackapply",
		indexkeys = {"wc_storage:shelf_wicker"},
		wield = {name = "nc_doors:panel_plank"},
		consumewield = 1,
		nodes = {
			{
				match = {name = "wc_storage:shelf_wicker", empty = true},
				replace = modname .. ":drawers_wicker"
			},
		}
	})
------------------------------------------------------------------------
nodecore.register_craft({
		label = "assemble wooden drawers",
		action = "stackapply",
		indexkeys = {"nc_woodwork:shelf"},
		wield = {name = "nc_doors:panel_plank"},
		consumewield = 1,
		nodes = {
			{
				match = {name = "nc_woodwork:shelf", empty = true},
				replace = modname .. ":drawers_wooden"
			},
		}
	})
------------------------------------------------------------------------
nodecore.register_craft({
		label = "assemble lode drawers",
		action = "stackapply",
		indexkeys = {"wc_storage:shelf_lode_tempered"},
		wield = {name = "nc_lode:block_annealed"},
		consumewield = 1,
		nodes = {
			{
				match = {name = "wc_storage:shelf_lode_tempered", empty = true},
				replace = modname .. ":drawers_lode_annealed"
			},
		}
	})
------------------------------------------------------------------------
nodecore.register_craft({
		label = "assemble fancy drawers",
		action = "stackapply",
		indexkeys = {"wc_storage:shelf_lode_tempered"},
		wield = {name = "nc_doors:panel_bricks_cloudstone_bonded"},
		consumewield = 1,
		nodes = {
			{
				match = {name = "wc_storage:shelf_lode_tempered", empty = true},
				replace = modname .. ":drawers_fancy"
			},
		}
	})

-- ================================================================== --
