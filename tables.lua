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
local wicker	= "nc_flora_wicker.png"
local plank	= "nc_woodwork_plank.png"
local wood		= "nc_tree_tree_side.png"
local anlode	= "nc_lode_annealed.png"
local cloud	= "nc_concrete_cloudstone.png"
local frost	= "nc_optics_glass_frost.png"
local aurum	= "nc_lode_tempered.png^[colorize:gold:50"
------------------------------------------------------------------------
local woodtop	= wood.. "^[mask:nc_tote_sides.png"
local lodetop	= anlode.. "^[mask:nc_tote_sides.png"
------------------------------------------------------------------------
local glasstop	= "nc_optics_glass_glare.png^(" ..woodtop.. ")"
local frosttop	= frost.. "^(" ..anlode.. "^[mask:nc_api_storebox_frame.png)"
local fancytop	= frost.. "^(" ..aurum.. "^[mask:(nc_api_storebox_frame.png^nc_concrete_pattern_bindy.png))"
------------------------------------------------------------------------
local wickerbot	= wicker.. "^(" ..woodtop.. ")"
local woodenbot	= plank.. "^(" ..woodtop.. ")"
local fancybot	= frost.. "^(" ..aurum.. "^[mask:nc_tote_sides.png)"
------------------------------------------------------------------------
local wickertable = wicker..	"^[lowpart:90:" ..wood,"[combine:1x1"
local woodentable = plank..	"^[lowpart:80:" ..wood,"[combine:1x1"
local glassytable = glasstop..	"^[lowpart:90:" ..wood,"[combine:1x1"
local frostytable = frosttop..	"^[lowpart:90:" ..anlode,"[combine:1x1"
local fancytable  = cloud.. "^(" ..aurum.. "^[mask:" ..modname.. "_trim.png)"
------------------------------------------------------------------------
local tablenodebox = {
	{-0.5, 0.3125, -0.5, 0.5, 0.5, 0.5},			-- Top
	{-0.5, -0.5, -0.5, -0.375, 0.3125, -0.375},	-- Leg
	{0.375, -0.5, 0.375, 0.5, 0.3125, 0.5},		-- Leg
	{0.375, -0.5, -0.5, 0.5, 0.3125, -0.375},		-- Leg
	{-0.5, -0.5, 0.375, -0.375, 0.3125, 0.5},		-- Leg
}
-- ================================================================== --
minetest.register_node(modname .. ":table_wicker", {
	description = "Wicker Table",
	tiles = {
		wicker,
		wickerbot,
		wickertable
	},
	use_texture_alpha = "blend",
	drawtype = "nodebox",
	paramtype = "light",
	node_box = {
		type = "fixed",
		fixed = tablenodebox
	},
	selection_box = nodecore.fixedbox(),
	groups = {
		choppy = 2,
		furniture = 1,
		table = 1,
		stack_as_node = 1,
	},
	stack_max = 1,
	paramtype = "light",
	sounds = nodecore.sounds("nc_tree_sticky"),
})
------------------------------------------------------------------------
minetest.register_node(modname .. ":table_wooden", {
	description = "Wooden Table",
	tiles = {
		plank,
		woodenbot,
		woodentable
	},
	drawtype = "nodebox",
	paramtype = "light",
	node_box = {
		type = "fixed",
		fixed = tablenodebox
	},
	selection_box = nodecore.fixedbox(),
	groups = {
		choppy = 3,
		flammable = 30,
		fire_fuel = 2,
		furniture = 1,
		table = 1,
		stack_as_node = 1,
	},
	stack_max = 1,
	paramtype = "light",
	sounds = nodecore.sounds("nc_tree_woody"),
})
------------------------------------------------------------------------
minetest.register_node(modname .. ":table_glassy", {
	description = "Glass Table",
	tiles = {
		glasstop,
		glasstop,
		glassytable,

	},
	use_texture_alpha = "blend",
	drawtype = "nodebox",
	paramtype = "light",
	node_box = {
		type = "fixed",
		fixed = tablenodebox
	},
	selection_box = nodecore.fixedbox(),
	groups = {
		cracky = 3,
		flammable = 30,
		fire_fuel = 2,
		furniture = 1,
		table = 1,
		stack_as_node = 1,
	},
	stack_max = 1,
	paramtype = "light",
	sounds = nodecore.sounds("nc_optics_glassy"),
})
------------------------------------------------------------------------
minetest.register_node(modname .. ":table_chromatic", {
	description = "Chromatic Table",
	tiles = {
		frosttop,
		frosttop,
		frostytable
	},
	drawtype = "nodebox",
	paramtype = "light",
	node_box = {
		type = "fixed",
		fixed = tablenodebox
	},
	selection_box = nodecore.fixedbox(),
	groups = {
		cracky = 4,
		furniture = 1,
		table = 1,
		stack_as_node = 1,
	},
	stack_max = 1,
	paramtype = "light",
	sounds = nodecore.sounds("nc_optics_glassy"),
})
------------------------------------------------------------------------
minetest.register_node(modname .. ":table_lode_annealed", {
	description = "Lode Table",
	tiles = {anlode},
	drawtype = "nodebox",
	paramtype = "light",
	node_box = {
		type = "fixed",
		fixed = tablenodebox
	},
	selection_box = nodecore.fixedbox(),
	groups = {
		cracky = 4,
		furniture = 1,
		table = 1,
		stack_as_node = 1,
	},
	stack_max = 1,
	sounds = nodecore.sounds("nc_lode_annealed"),
})
------------------------------------------------------------------------
minetest.register_node(modname .. ":table_fancy", {
	description = "Fancy Table",
	tiles = {
		fancytop,
		fancybot,
		fancytable
	},
	drawtype = "nodebox",
	paramtype = "light",
	node_box = {
		type = "fixed",
		fixed = tablenodebox
	},
	selection_box = nodecore.fixedbox(),
	groups = {
		cracky = 5,
		furniture = 1,
		table = 1,
		stack_as_node = 1,
	},
	stack_max = 1,
	sounds = nodecore.sounds("nc_optics_glassy"),
})
-- ================================================================== --
nodecore.register_craft({
	label = "assemble wicker table",
	indexkeys = {"nc_flora:wicker"},
	nodes = {
		{match = "nc_flora:wicker", replace = modname.. ":table_wicker"},
		{x = -1, match = "nc_woodwork:staff", replace = "air"},
		{x = 1, match = "nc_woodwork:staff", replace = "air"},
		{z = -1, match = "nc_woodwork:staff", replace = "air"},
		{z = 1, match = "nc_woodwork:staff", replace = "air"},
	},
})
------------------------------------------------------------------------
nodecore.register_craft({
	label = "assemble wooden table",
	indexkeys = {"nc_woodwork:plank"},
	nodes = {
		{match = "nc_woodwork:plank", replace = modname.. ":table_wooden"},
		{x = -1, match = "nc_woodwork:staff", replace = "air"},
		{x = 1, match = "nc_woodwork:staff", replace = "air"},
		{z = -1, match = "nc_woodwork:staff", replace = "air"},
		{z = 1, match = "nc_woodwork:staff", replace = "air"},
	},
})
------------------------------------------------------------------------
nodecore.register_craft({
	label = "assemble glass table",
	indexkeys = {"nc_optics:glass"},
	nodes = {
		{match = "nc_optics:glass", replace = modname.. ":table_glassy"},
		{x = -1, match = "nc_woodwork:staff", replace = "air"},
		{x = 1, match = "nc_woodwork:staff", replace = "air"},
		{z = -1, match = "nc_woodwork:staff", replace = "air"},
		{z = 1, match = "nc_woodwork:staff", replace = "air"},
	},
})
------------------------------------------------------------------------
nodecore.register_craft({
		label = "assemble lode table",
		action = "pummel",
		duration = 4,
		toolgroups = {thumpy = 2},
		indexkeys = {"wc_storage:shelf_lode_annealed"},
		nodes = {
			{
				match = {name = "wc_storage:shelf_lode_annealed", empty = true}, 
				replace = modname .. ":table_lode_annealed"
			},
			{y = -1, match = "nc_lode:block_tempered"},
		},
	})
------------------------------------------------------------------------
nodecore.register_craft({
	label = "assemble chromatic table",
	indexkeys = {"nc_optics:glass_opaque"},
	nodes = {
		{match = "nc_optics:glass_opaque", replace = modname.. ":table_chromatic"},
		{x = -1, match = "nc_lode:rod_annealed", replace = "air"},
		{x = 1, match = "nc_lode:rod_annealed", replace = "air"},
		{z = -1, match = "nc_lode:rod_annealed", replace = "air"},
		{z = 1, match = "nc_lode:rod_annealed", replace = "air"},
	},
})
------------------------------------------------------------------------
nodecore.register_craft({
	label = "assemble fancy table",
	action = "pummel",
	duration = 3,
	priority = 1,
	wield = {"group:chisel"},
	consumewield = 1,
	indexkeys = {"nc_optics:glass_opaque"},
	
	nodes = {
		{match = "nc_optics:glass_opaque", replace = "air"},
		{y = -1, match = "nc_concrete:concrete_cloudstone_boxy", replace = modname.. ":table_fancy"},
	},
})
-- ================================================================== --
