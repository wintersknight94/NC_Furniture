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
------------------------------------------------------------------------
local plank = "nc_woodwork_plank.png"
local cloud = "nc_concrete_cloudstone.png"
local thatch = "nc_flora_thatch.png"
local blatch = "nc_flora_thatch.png^(nc_fire_coal_4.png^[opacity:200)"
------------------------------------------------------------------------
local cushtop = thatch.. "^(" ..plank.. "^[mask:nc_tote_sides.png)"
local cushion = thatch.. "^[lowpart:10:" ..plank, "[combine:1x1"
------------------------------------------------------------------------
local darktop = blatch.. "^(" ..plank.. "^[mask:nc_tote_sides.png)"
local darkion = blatch.. "^[lowpart:10:" ..plank, "[combine:1x1"
------------------------------------------------------------------------
local cushpat = "(nc_concrete_pattern_hashy.png^[opacity:80)^(nc_concrete_pattern_iceboxy.png^[opacity:120)"
local nicecush = "(" ..thatch.. ")^(" ..cushpat.. ")"
------------------------------------------------------------------------
local fancytop = nicecush.. "^(" ..cloud.. "^[mask:nc_tote_sides.png)"
local fancybot = nicecush.. "^[lowpart:10:" ..cloud, "[combine:1x1"
------------------------------------------------------------------------
local gothcush = "(" ..blatch.. ")^((" ..cushpat.. "^[colorize:gold:100)^[opacity:75)"
local gothtop = gothcush.. "^(" ..cloud.. "^[mask:nc_tote_sides.png)"
local gothbot = gothcush.. "^[lowpart:10:" ..cloud, "[combine:1x1"
------------------------------------------------------------------------
local cushnodebox = {
	{-0.4375, -0.5, -0.4375, 0.4375, -0.375, 0.4375},	-- Base
	{-0.375, -0.375, -0.375, 0.375, -0.1875, 0.375},		-- Cushion
	{-0.25, -0.25, -0.25, 0.25, -0.125, 0.25},			-- CushionTop
}
-- ================================================================== --
-- ================================================================== --
minetest.register_node(modname .. ":cushion", {
	description = "Cushion",
	tiles = {
		cushtop,	--top
		plank,	--bottom
		cushion	--sides
	},
	drawtype = "nodebox",
	paramtype = "light",
	node_box = {
		type = "fixed",
		fixed = cushnodebox
	},
	groups = {
		snappy = 1,
		flammable = 6,
		fire_fuel = 6,
		peat_grindable_node = 2,
		stack_as_node = 1,
		bouncy = 20,
		fall_damage_add_percent = -20,
	},
	sounds = nodecore.sounds("nc_terrain_grassy")
})
------------------------------------------------------------------------
minetest.register_node(modname .. ":cushion_fancy", {
	description = "Fancy Cushion",
	tiles = {
		fancytop,	--top
		cloud,	--bottom
		fancybot	--sides
	},
	drawtype = "nodebox",
	paramtype = "light",
	node_box = {
		type = "fixed",
		fixed = cushnodebox
	},
	groups = {
		snappy = 1,
		flammable = 6,
		fire_fuel = 4,
		peat_grindable_node = 2,
		stack_as_node = 1,
		bouncy = 20,
		fall_damage_add_percent = -20,
	},
	sounds = nodecore.sounds("nc_terrain_grassy")
})
------------------------------------------------------------------------
minetest.register_node(modname .. ":cushion_dark", {
	description = "Dark Cushion",
	tiles = {
		darktop,	--top
		plank,	--bottom
		darkion	--sides
	},
	drawtype = "nodebox",
	paramtype = "light",
	node_box = {
		type = "fixed",
		fixed = cushnodebox
	},
	groups = {
		snappy = 1,
		flammable = 2,
		fire_fuel = 7,
		peat_grindable_node = 2,
		stack_as_node = 1,
		bouncy = 20,
		fall_damage_add_percent = -20,
	},
	sounds = nodecore.sounds("nc_terrain_grassy")
})
------------------------------------------------------------------------
minetest.register_node(modname .. ":cushion_goth", {
	description = "Dark Fancy Cushion",
	tiles = {
		gothtop,	--top
		cloud,	--bottom
		gothbot	--sides
	},
	drawtype = "nodebox",
	paramtype = "light",
	node_box = {
		type = "fixed",
		fixed = cushnodebox
	},
	groups = {
		snappy = 1,
		flammable = 3,
		fire_fuel = 5,
		peat_grindable_node = 2,
		stack_as_node = 1,
		bouncy = 20,
		fall_damage_add_percent = -20,
	},
	sounds = nodecore.sounds("nc_terrain_grassy")
})
-- ================================================================== --
nodecore.register_craft({
	label = "make cushion",
	action = "pummel",
	duration = 1,
	priority = 1,
	toolgroups = {thumpy = 1},
	normal = {y = 1},
	indexkeys = "nc_flora:thatch",
	nodes = {
		{match = "nc_flora:thatch", replace = "air"},
		{y = -1, match = "nc_woodwork:plank", replace = modname.. ":cushion"}
	}
})
------------------------------------------------------------------------
nodecore.register_craft({
	label = "make fancy cushion",
	action = "pummel",
	duration = 1,
	priority = 1,
	toolgroups = {thumpy = 1},
	normal = {y = 1},
	indexkeys = "nc_flora:thatch",
	nodes = {
		{match = "nc_flora:thatch", replace = "air"},
		{y = -1, match = "nc_concrete:cloudstone", replace = modname.. ":cushion_fancy"}
	}
})
------------------------------------------------------------------------
nodecore.register_craft({
	label = "darken cushion",
	action = "pummel",
	duration = 1,
	priority = 1,
	wield = "nc_fire:lump_coal",
	consumewield = 1,
	indexkeys = modname.. ":cushion",
	nodes = {
		{match = modname.. ":cushion", replace = modname.. ":cushion_dark"},
	}
})
------------------------------------------------------------------------
nodecore.register_craft({
	label = "darken fancy cushion",
	action = "pummel",
	duration = 1,
	priority = 1,
	wield = "nc_fire:lump_coal",
	consumewield = 1,
	indexkeys = modname.. ":cushion_fancy",
	nodes = {
		{match = modname.. ":cushion_fancy", replace = modname.. ":cushion_goth"},
	}
})
-- ================================================================== --
