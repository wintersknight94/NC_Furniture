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
local wood		= "nc_tree_tree_side.png"
local anlode	= "nc_lode_annealed.png^[colorize:black:50"
local tmlode	= "nc_lode_tempered.png"
local htlode	= "nc_lode_hot.png"
local aurum	= "nc_lode_tempered.png^[colorize:gold:50"
local cloud	= "nc_concrete_cloudstone.png"
local water	= "nc_terrain_water.png^[verticalframe:32:8"
------------------------------------------------------------------------
local stovebox	= tmlode.. "^(" ..anlode.. "^[mask:nc_api_storebox_frame.png)"
local stovebld	= tmlode.. "^(" ..anlode.. "^[mask:nc_tote_sides.png)"
local stovetop	= stovebox.. "^(" ..anlode.. "^[mask:" ..modname.. "_stovetop.png)"
local ovendoor	= stovebox.. "^(" ..anlode.. "^[mask:" ..modname.. "_oven.png)"
local toasttop	= tmlode.. "^(" ..anlode.. "^[mask:" ..modname.. "_toast.png)"
local toasthot	= tmlode.. "^(" ..htlode.. "^[mask:" ..modname.. "_toast.png)"
local sinkfx	= stovebox.. "^(" ..water.. "^[mask:" ..modname.. "_sink.png)"
local fridge	= tmlode.. "^(" ..anlode.. "^[mask:" ..modname.. "_fridge.png)"
local icebox	= stovebox.. "^(" ..anlode.. "^[mask:nc_concrete_pattern_iceboxy.png)"
------------------------------------------------------------------------
local fstovebox	= cloud.. "^(" ..aurum.. "^[mask:nc_api_storebox_frame.png)"
local fstovebld	= cloud.. "^(" ..aurum.. "^[mask:nc_tote_sides.png)"
local fstovetop	= fstovebox.. "^(" ..aurum.. "^[mask:" ..modname.. "_stovetop.png)"
local fovendoor	= fstovebox.. "^(" ..aurum.. "^[mask:" ..modname.. "_oven.png)"
local ftoasttop	= cloud.. "^(" ..aurum.. "^[mask:" ..modname.. "_toast.png)"
local ftoasthot	= cloud.. "^(" ..htlode.. "^[mask:" ..modname.. "_toast.png)"
local fsinkfx	= fstovebox.. "^(" ..water.. "^[mask:" ..modname.. "_sink.png)"
local ffridge	= cloud.. "^(" ..aurum.. "^[mask:" ..modname.. "_fridge.png)"
local ficebox	= fstovebox.. "^(" ..aurum.. "^[mask:nc_concrete_pattern_iceboxy.png)"
------------------------------------------------------------------------
local barrel	= wood.. "^(" ..anlode.. "^[mask:wc_storage_band_mask.png)"
local wstovebox	= wood.. "^(" ..anlode.. "^[mask:nc_api_storebox_frame.png)"
local wsinkfx	= wstovebox.. "^(" ..water.. "^[mask:" ..modname.. "_sink.png)"
------------------------------------------------------------------------
local stovenodebox = {
	{-0.5, -0.5, -0.5, 0.5, 0.4375, 0.5},				-- Oven
	{-0.375, 0.4375, -0.375, -0.0625, 0.5, -0.0625},	-- FrontLeftBurner
	{0.0625, 0.4375, -0.375, 0.375, 0.5, -0.0625},		-- FrontRightBurner
	{0.0625, 0.4375, 0.0625, 0.375, 0.5, 0.375},		-- BackRightBurner
	{-0.375, 0.4375, 0.0625, -0.0625, 0.5, 0.375},		-- BackLeftBurner
}
local toastnodebox = {
	{-0.1875, -0.5, -0.25, 0.1875, -0.1875, 0.25},		-- Oven
	{-0.25, -0.5, -0.3125, 0.25, -0.4375, 0.3125},		-- Base
	{-0.0625, -0.3125, -0.3125, 0.0625, -0.25, 0.3125},	-- Switch
}
--	{-0.3125, -0.5, -0.1875, 0.3125, -0.125, 0.1875},	-- Oven(old)
--	{-0.375, -0.5, -0.25, 0.375, -0.4375, 0.25},		-- Base(old)
local sinknodebox = {
	{-0.5, -0.5, -0.5, 0.5, 0.375, 0.5},				-- Base
	{-0.5, 0.375, -0.5, 0.5, 0.5, -0.375},			-- SinkwallFront
	{-0.5, 0.375, 0.25, 0.5, 0.5, 0.5},				-- SinkwallBack
	{-0.5, 0.375, -0.5, -0.375, 0.5, 0.5},			-- SinkwallLeft
	{0.375, 0.375, -0.5, 0.5, 0.5, 0.5},				-- SinkwallRight
	{-0.0625, 0.375, -0.4375, 0.0625, 0.5, 0.375},		-- SinkDivider
	{-0.3125, 0.5, 0.3125, -0.1875, 0.5625, 0.4375},	-- KnobLeft
	{0.1875, 0.5, 0.3125, 0.3125, 0.5625, 0.4375},		-- KnobRight
	{-0.0625, 0.5, 0.3125, 0.0625, 0.6875, 0.4375},		-- FaucetY
	{-0.0625, 0.6875, 0.0625, 0.0625, 0.75, 0.4375},	-- FaucetZ
}
local fridgenodebox = {
	{-0.5, -0.5, -0.4375, 0.5, 0.5, 0.5},				-- Fridge
	{-0.375, -0.375, -0.5, 0.375, 0.375, -0.4375},		-- Door
	{0.25, -0.1875, -0.5625, 0.3125, 0.1875, -0.4375},	-- Handle
}
-- ================================================================== --
-- ================================================================== --
minetest.register_node(modname .. ":oven", {
	description = "Cookstove",
	tiles = {
		stovetop,	--top
		stovebld,	--bottom
		stovebld,	--side
		stovebld,	--side
		stovebld,	--back
		ovendoor	--front
	},
	drawtype = "nodebox",
	paramtype2 = "facedir",
	node_box = {
		type = "fixed",
		fixed = stovenodebox
	},
	selection_box = nodecore.fixedbox(),
	groups = {
		cracky = 5,
		furniture = 1,
		stove = 1,
		stack_as_node = 1,
		storebox = 1,
		visinv = 1
	},
	stack_max = 1,
	sounds = nodecore.sounds("nc_lode_tempered"),
	storebox_access = function(pt) return pt.above.y == pt.under.y end
})
------------------------------------------------------------------------
minetest.register_node(modname .. ":oven_fancy", {
	description = "Fancy Cookstove",
	tiles = {
		fstovetop,	--top
		fstovebld,	--bottom
		fstovebld,	--side
		fstovebld,	--side
		fstovebld,	--back
		fovendoor	--front
	},
	drawtype = "nodebox",
	paramtype2 = "facedir",
	node_box = {
		type = "fixed",
		fixed = stovenodebox
	},
	selection_box = nodecore.fixedbox(),
	groups = {
		cracky = 5,
		furniture = 1,
		stove = 1,
		stack_as_node = 1,
		storebox = 1,
		visinv = 1
	},
	stack_max = 1,
	sounds = nodecore.sounds("nc_lode_tempered"),
	storebox_access = function(pt) return pt.above.y == pt.under.y end
})
-- ================================================================== --
-- ================================================================== --
minetest.register_node(modname .. ":toaster", {
	description = "Toaster",
	tiles = {
		toasttop,
		tmlode,
		stovebox
	},
	drawtype = "nodebox",
	paramtype = "light",
	paramtype2 = "facedir",
	node_box = {
		type = "fixed",
		fixed = toastnodebox
	},
	selection_box = nodecore.fixedbox(),
	groups = {
		snappy = 1,
		furniture = 1,
		stack_as_node = 1,
		toaster = 1
	},
	sounds = nodecore.sounds("nc_lode_tempered")
})
------------------------------------------------------------------------
minetest.register_node(modname .. ":toaster_fancy", {
	description = "Fancy Toaster",
	tiles = {
		ftoasttop,
		cloud,
		fstovebox
	},
	drawtype = "nodebox",
	paramtype = "light",
	paramtype2 = "facedir",
	node_box = {
		type = "fixed",
		fixed = toastnodebox
	},
	selection_box = nodecore.fixedbox(),
	groups = {
		snappy = 1,
		furniture = 1,
		stack_as_node = 1,
		toaster = 1
	},
	sounds = nodecore.sounds("nc_lode_tempered")
})
------------------------------------------------------------------------
minetest.register_node(modname .. ":toaster_hot", {
	description = "Toaster",
	tiles = {
		toasthot,
		tmlode,
		stovebox
	},
	drawtype = "nodebox",
	paramtype = "light",
	paramtype2 = "facedir",
	node_box = {
		type = "fixed",
		fixed = toastnodebox
	},
	selection_box = nodecore.fixedbox(),
	groups = {
		snappy = 1,
		furniture = 1,
		stack_as_node = 1,
		toaster = 1,
		toaster_hot = 1
	},
	sounds = nodecore.sounds("nc_lode_tempered")
})
------------------------------------------------------------------------
minetest.register_node(modname .. ":toaster_fancy_hot", {
	description = "Fancy Toaster",
	tiles = {
		ftoasthot,
		cloud,
		fstovebox
	},
	drawtype = "nodebox",
	paramtype = "light",
	paramtype2 = "facedir",
	node_box = {
		type = "fixed",
		fixed = toastnodebox
	},
	selection_box = nodecore.fixedbox(),
	groups = {
		snappy = 1,
		furniture = 1,
		stack_as_node = 1,
		toaster = 1,
		toaster_hot = 1
	},
	sounds = nodecore.sounds("nc_lode_tempered")
})
------------------------------------------------------------------------
nodecore.register_craft({
	label = "Toast Prill",
	action = "pummel",
	wield = {name = "nc_lode:prill_tempered"},
	after = rfcall,
		nodes = {
			{match = modname .. ":toaster", replace = modname .. ":toaster_hot"}
		}
})
------------------------------------------------------------------------
nodecore.register_craft({
	label = "Fancy Toast Prill",
	action = "pummel",
	wield = {name = "nc_lode:prill_tempered"},
	after = rfcall,
		nodes = {
			{match = modname .. ":toaster_fancy", replace = modname .. ":toaster_fancy_hot"}
		}
})
------------------------------------------------------------------------
nodecore.register_abm({
		label = "Toaster Finish",
		interval = 30,
		chance = 1,
		nodenames = {modname .. ":toaster_hot"},
		action = function(pos)
			nodecore.item_eject(pos, "nc_lode:prill_annealed", 1)
			nodecore.sound_play("nc_doors_operate", {gain = 0.25, pos = pos})
			return minetest.set_node(pos, {name = modname .. ":toaster"})
		end
	})
------------------------------------------------------------------------
nodecore.register_abm({
		label = "Fancy Toaster Finish",
		interval = 30,
		chance = 1,
		nodenames = {modname .. ":toaster_fancy_hot"},
		action = function(pos)
			nodecore.item_eject(pos, "nc_lode:prill_annealed", 1)
			nodecore.sound_play("nc_doors_operate", {gain = 0.25, pos = pos})
			return minetest.set_node(pos, {name = modname .. ":toaster_fancy"})
		end
	})
------------------------------------------------------------------------
nodecore.register_abm({
		label = "toaster on",
		interval = 1,
		chance = 1,
		nodenames = {"group:toaster_hot"},
		action = function(pos)
			nodecore.smokeburst(pos, 2)
	end
})
-- ================================================================== --
-- ================================================================== --
minetest.register_node(modname .. ":sink_wooden", {
	description = "Wooden Sink",
	tiles = {
		"(" ..wstovebox.. ")^(" ..wsinkfx.. ")",
		wstovebox,
		barrel
	},
	drawtype = "nodebox",
	paramtype2 = "facedir",
	node_box = {
		type = "fixed",
		fixed = sinknodebox
	},
	selection_box = nodecore.fixedbox(),
	groups = {
		choppy = 5,
		furniture = 1,
		sink = 1,
		stack_as_node = 1,
		coolant = 1
	},
	stack_max = 1,
	sounds = nodecore.sounds("nc_tree_woody"),
})
------------------------------------------------------------------------
minetest.register_node(modname .. ":sink_lode_annealed", {
	description = "Lode Sink",
	tiles = {
		"(" ..stovebox.. ")^(" ..sinkfx.. ")",
		stovebox
	},
	drawtype = "nodebox",
	paramtype2 = "facedir",
	node_box = {
		type = "fixed",
		fixed = sinknodebox
	},
	selection_box = nodecore.fixedbox(),
	groups = {
		cracky = 5,
		furniture = 1,
		sink = 1,
		stack_as_node = 1,
		coolant = 1
	},
	stack_max = 1,
	sounds = nodecore.sounds("nc_lode_tempered"),
})
------------------------------------------------------------------------
minetest.register_node(modname .. ":sink_fancy", {
	description = "Fancy Sink",
	tiles = {
		"(" ..fstovebox.. ")^(" ..fsinkfx.. ")",
		fstovebox
	},
	drawtype = "nodebox",
	paramtype2 = "facedir",
	node_box = {
		type = "fixed",
		fixed = sinknodebox
	},
	selection_box = nodecore.fixedbox(),
	groups = {
		cracky = 5,
		furniture = 1,
		sink = 1,
		stack_as_node = 1,
		coolant = 1
	},
	stack_max = 1,
	sounds = nodecore.sounds("nc_lode_tempered"),
})
------------------------------------------------------------------------
minetest.register_node(modname .. ":fridge", {
	description = "Fridge",
	tiles = {
		icebox,	--top
		icebox,	--bottom
		icebox,	--side
		icebox,	--side
		icebox,	--back
		fridge	--front
	},
	drawtype = "nodebox",
	paramtype2 = "facedir",
	node_box = {
		type = "fixed",
		fixed = fridgenodebox
	},
	selection_box = nodecore.fixedbox(),
	groups = {
		cracky = 5,
		furniture = 1,
		fridge = 1,
		stack_as_node = 1,
		coolant = 1,
		storebox = 1,
		visinv = 1
	},
	stack_max = 1,
	sounds = nodecore.sounds("nc_lode_tempered"),
	storebox_access = function(pt) return pt.above.y == pt.under.y end
})
------------------------------------------------------------------------
minetest.register_node(modname .. ":fridge_fancy", {
	description = "Fancy Fridge",
	tiles = {
		ficebox,	--top
		ficebox,	--bottom
		ficebox,	--side
		ficebox,	--side
		ficebox,	--back
		ffridge		--front
	},
	drawtype = "nodebox",
	paramtype2 = "facedir",
	node_box = {
		type = "fixed",
		fixed = fridgenodebox
	},
	selection_box = nodecore.fixedbox(),
	groups = {
		cracky = 5,
		furniture = 1,
		fridge = 1,
		stack_as_node = 1,
		coolant = 1,
		storebox = 1,
		visinv = 1
	},
	stack_max = 1,
	sounds = nodecore.sounds("nc_lode_tempered"),
	storebox_access = function(pt) return pt.above.y == pt.under.y end
})
-- ================================================================== --
-- ================================================================== --
nodecore.register_craft({
	label = "assemble cookstove",
	action = "pummel",
	duration = 4,
	toolgroups = {thumpy = 5},
	normal = {y = 1},
	indexkeys = "nc_lode:toolhead_mallet_tempered",
	nodes = {
		{match = "nc_lode:toolhead_mallet_tempered", replace = "air"},
		{y = -1, match = "wc_storage:shelf_cauldron_pumwater", replace = modname.. ":oven"}
	}
})
------------------------------------------------------------------------
nodecore.register_craft({
	label = "coat cookstove with spackling",
	action = "pummel",
	duration = 10,
	wield_item = "nc_concrete:cloudmix",
	consumewield = 1,
	indexkeys = modname.. ":oven",
	nodes = {
		{match = modname.. ":oven", replace = modname.. ":oven_fancy"},
	}
})
------------------------------------------------------------------------
nodecore.register_craft({
		label = "assemble toaster",
		action = "stackapply",
		indexkeys = {"wc_storage:shelf_cauldron_tempered"},
		wield = {name = "nc_torch:torch_lit_1"},
		consumewield = 1,
		nodes = {
			{
				match = {name = "wc_storage:shelf_cauldron_tempered", empty = true},
				replace = modname .. ":toaster"
			},
		}
})
------------------------------------------------------------------------
nodecore.register_craft({
	label = "spackle toaster",
	action = "pummel",
	wield = {name = "nc_concrete:cloudmix"},
	after = rfcall,
		nodes = {
			{match = modname .. ":toaster", replace = modname .. ":toaster_fancy"}
		}
})
------------------------------------------------------------------------
nodecore.register_craft({
		label = "assemble wooden sink",
		action = "stackapply",
		indexkeys = {"wc_storage:shelf_lode_barrel_water"},
		wield = {name = "nc_lode:bar_annealed"},
		consumewield = 1,
		nodes = {
			{
				match = {name = "wc_storage:shelf_lode_barrel_water", empty = true},
				replace = modname .. ":sink_wooden"
			},
		}
})
------------------------------------------------------------------------
nodecore.register_craft({
		label = "assemble lode sink",
		action = "stackapply",
		indexkeys = {"wc_storage:shelf_cauldron_annealed"},
		wield = {name = "nc_sponge:sponge_wet"},
		consumewield = 1,
		nodes = {
			{
				match = {name = "wc_storage:shelf_cauldron_annealed", empty = true},
				replace = modname .. ":sink_lode_annealed"
			},
		}
})
------------------------------------------------------------------------
nodecore.register_craft({
	label = "spackle sink",
	action = "pummel",
	wield = {name = "nc_concrete:cloudmix"},
	after = rfcall,
		nodes = {
			{match = modname .. ":sink_lode_annealed", replace = modname .. ":sink_fancy"}
		}
})
------------------------------------------------------------------------
nodecore.register_craft({
		label = "assemble refrigerator",
		action = "stackapply",
		indexkeys = {"wc_storage:shelf_cauldron_tempered"},
		wield = {name = "nc_sponge:sponge_wet"},
		consumewield = 2,
		nodes = {
			{
				match = {name = "wc_storage:shelf_cauldron_tempered", empty = true},
				replace = modname .. ":fridge"
			},
		}
})
------------------------------------------------------------------------
nodecore.register_craft({
	label = "spackle fridge",
	action = "pummel",
	wield = {name = "nc_concrete:cloudmix"},
	after = rfcall,
		nodes = {
			{match = modname .. ":fridge", replace = modname .. ":fridge_fancy"}
		}
})
------------------------------------------------------------------------