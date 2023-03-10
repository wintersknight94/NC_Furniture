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
local plank = "nc_woodwork_plank.png"
local wicker = "nc_flora_wicker.png"
local thatch = "nc_flora_thatch.png"
local anlode = "nc_lode_annealed.png"
local tmlode = "nc_lode_tempered.png"
local cloud = "nc_concrete_cloudstone.png"
local aurum	= "nc_lode_tempered.png^[colorize:gold:50"
------------------------------------------------------------------------
local wickchair = wicker..	"^[lowpart:40:nc_tree_tree_side.png","[combine:1x1"
local woodchair = plank..	"^[lowpart:40:nc_tree_tree_side.png","[combine:1x1"
------------------------------------------------------------------------
local wickcushion = thatch.. "^(" ..wicker.. "^[mask:" ..modname.. "_seat.png)"
local woodcushion = thatch.. "^(" ..plank.. "^[mask:" ..modname.. "_seat.png)"
local lodecushion = thatch.. "^(" ..anlode.. "^[mask:" ..modname.. "_seat.png)"
local nicecushion = thatch.. "^(" ..aurum.. "^[mask:" ..modname.. "_seat.png)"
------------------------------------------------------------------------
local wickback = wicker.. "^(" ..thatch.. "^[mask:" ..modname.. "_chair_back.png)"
local woodback = plank.. "^(" ..thatch.. "^[mask:" ..modname.. "_chair_back.png)"
local lodeback = anlode.. "^(" ..thatch.. "^[mask:" ..modname.. "_chair_back.png)"
local niceback = cloud.. "^(" ..aurum.. "^[mask:(" ..modname.. "_trim.png^" ..modname.. "_bind.png))^(" ..thatch.. "^[mask:" ..modname.. "_chair_back.png)"
local nicerear = cloud.. "^(" ..aurum.. "^[mask:(" ..modname.. "_trim.png^" ..modname.. "_bind.png))"
------------------------------------------------------------------------
local padchairnodebox = {
	{0.3125, -0.5, -0.4375, 0.4375, 0, -0.3125},		-- LegFrontRight
	{-0.4375, -0.5, -0.4375, -0.3125, 0, -0.3125},		-- LegFrontLeft
	{-0.4375, -0.5, 0.3125, -0.3125, 0, 0.4375},		-- LegBackLeft
	{0.3125, -0.5, 0.3125, 0.4375, 0, 0.4375},			-- LegBackRight
	{-0.4375, -0.0625, -0.4375, 0.4375, 0.0625, 0.4375},	-- Seat
	{-0.375, 0.0625, -0.375, 0.375, 0.125, 0.375},		-- SeatCushion
	{-0.4375, 0.0625, 0.3125, 0.4375, 0.375, 0.4375},	-- Back
	{-0.3125, 0.375, 0.3125, 0.3125, 0.5, 0.4375},		-- BackArch
	{-0.375, 0.0625, 0.25, 0.375, 0.3125, 0.375},		-- BackCushion
	{-0.25, 0.0625, 0.25, 0.25, 0.4375, 0.375},		-- BackCushionArch
}
-- ================================================================== --
minetest.register_node(modname .. ":chair_wicker_padded", {
	description = "Cushioned Wicker Chair",
	tiles = {
		wickcushion,	--top
		wicker,		--bottom
		wicker,		--side
		wicker,		--side
		wicker,		--back
		wickback		--front
	},
	drawtype = "nodebox",
	paramtype = "light",
	paramtype2 = "facedir",
	node_box = {
		type = "fixed",
		fixed = padchairnodebox
	},
	selection_box = nodecore.fixedbox(),
	groups = {
		choppy = 2,
		flammable = 30,
		fire_fuel = 4,
		furniture = 1,
		chair = 1,
		stack_as_node = 1,
	},
	stack_max = 1,
	sounds = nodecore.sounds("nc_tree_sticky"),
})
------------------------------------------------------------------------
minetest.register_node(modname .. ":chair_wooden_padded", {
	description = "Cushioned Wooden Chair",
	tiles = {
		woodcushion,	--top
		plank,		--bottom
		plank,		--side
		plank,		--side
		plank,		--back
		woodback		--front
	},
	drawtype = "nodebox",
	paramtype = "light",
	paramtype2 = "facedir",
	node_box = {
		type = "fixed",
		fixed = padchairnodebox
	},
	selection_box = nodecore.fixedbox(),
	groups = {
		choppy = 2,
		flammable = 30,
		fire_fuel = 4,
		furniture = 1,
		chair = 1,
		stack_as_node = 1,
	},
	stack_max = 1,
	sounds = nodecore.sounds("nc_tree_woody"),
})
------------------------------------------------------------------------
minetest.register_node(modname .. ":chair_lode_annealed_padded", {
	description = "Cushioned Lode Chair",
	tiles = {
		lodecushion,	--top
		anlode,		--bottom
		anlode,		--side
		anlode,		--side
		anlode,		--back
		lodeback		--front
	},
	drawtype = "nodebox",
	paramtype = "light",
	paramtype2 = "facedir",
	node_box = {
		type = "fixed",
		fixed = padchairnodebox
	},
	selection_box = nodecore.fixedbox(),
	groups = {
		cracky = 3,
		furniture = 1,
		chair = 1,
		stack_as_node = 1,
	},
	stack_max = 1,
	sounds = nodecore.sounds("nc_lode_annealed"),
})
------------------------------------------------------------------------
minetest.register_node(modname .. ":chair_fancy_padded", {
	description = "Cushioned Fancy Chair",
	tiles = {
		nicecushion,	--top
		cloud,		--bottom
		nicerear,		--side
		nicerear,		--side
		nicerear,		--back
		niceback		--front
	},
	drawtype = "nodebox",
	paramtype = "light",
	paramtype2 = "facedir",
	node_box = {
		type = "fixed",
		fixed = padchairnodebox
	},
	selection_box = nodecore.fixedbox(),
	groups = {
		cracky = 3,
		furniture = 1,
		chair = 1,
		stack_as_node = 1,
	},
	stack_max = 1,
	sounds = nodecore.sounds("nc_lode_tempered"),
})
-- ================================================================== --
-- ================================================================== --
nodecore.register_craft({
	label = "attach cushion to wicker chair",
	action = "pummel",
	wield = {name = modname.. ":cushion"},
	after = rfcall,
		nodes = {
			{match = modname .. ":chair_wicker", replace = modname .. ":chair_wicker_padded"}
		}
})
------------------------------------------------------------------------
nodecore.register_craft({
	label = "attach cushion to wooden chair",
	action = "pummel",
	wield = {name = modname.. ":cushion"},
	after = rfcall,
		nodes = {
			{match = modname .. ":chair_wooden", replace = modname .. ":chair_wooden_padded"}
		}
})
nodecore.register_craft({
	label = "attach cushion to lode chair",
	action = "pummel",
	wield = {name = modname.. ":cushion"},
	after = rfcall,
		nodes = {
			{match = modname .. ":chair_lode_annealed", replace = modname .. ":chair_lode_annealed_padded"}
		}
})
------------------------------------------------------------------------
nodecore.register_craft({
	label = "attach cushion to fancy chair",
	action = "pummel",
	wield = {name = modname.. ":cushion_fancy"},
	after = rfcall,
		nodes = {
			{match = modname .. ":chair_fancy", replace = modname .. ":chair_fancy_padded"}
		}
})
-- ================================================================== --
------------------------------------------------------------------------
--- Nodebox For High Backed Chairs, Unused Due To Texture Confusion ---
------------------------------------------------------------------------
--		{0.3125, -0.5, -0.4375, 0.4375, 0, -0.3125}, -- LegFrontRight
--		{-0.4375, -0.5, -0.4375, -0.3125, 0, -0.3125}, -- LegFrontLeft
--		{-0.4375, -0.5, 0.3125, -0.3125, 0, 0.4375}, -- LegBackLeft
--		{0.3125, -0.5, 0.3125, 0.4375, 0, 0.4375}, -- LegBackRight
--		{-0.4375, -0.0625, -0.4375, 0.4375, 0.0625, 0.4375}, -- Seat
--		{-0.375, 0.0625, -0.375, 0.375, 0.125, 0.375}, -- SeatCushion
--		{-0.4375, 0.0625, 0.3125, 0.4375, 1, 0.4375}, -- Back
--		{-0.3125, 0.9375, 0.3125, 0.3125, 1.0625, 0.4375}, -- BackArch
--		{-0.375, 0.0625, 0.25, 0.375, 0.5, 0.375}, -- BackCushion
--		{-0.25, 0.4375, 0.25, 0.25, 0.5625, 0.375}, -- BackCushionArch
------------------------------------------------------------------------
-- ================================================================== --
