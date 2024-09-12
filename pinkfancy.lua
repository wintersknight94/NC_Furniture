-- LUALOCALS < ---------------------------------------------------------
local minetest, nodecore, string
    = minetest, nodecore, string
local string_lower
    = string.lower
-- LUALOCALS > ---------------------------------------------------------
local modname = minetest.get_current_modname()
-- ================================================================== --
local rfcall = function(pos, data)
	local ref = minetest.get_player_by_name(data.pname)
	local wield = ref:get_wielded_item()
	wield:take_item(1)
	ref:set_wielded_item(wield)
end
-- ================================================================== --
local pink = "wc_naturae_shellstone.png"
local aurum	= "nc_lode_tempered.png^[colorize:gold:50"
local thatch = "nc_flora_thatch.png"
local frost	= "nc_optics_glass_frost.png"
local cushpat = "(nc_concrete_pattern_hashy.png^[opacity:80)^(nc_concrete_pattern_iceboxy.png^[opacity:120)"
local nicecush = "(" ..thatch.. ")^(" ..cushpat.. ")"
local fcushtop = nicecush.. "^(" ..pink.. "^[mask:nc_tote_sides.png)"
local fcushbot = nicecush.. "^[lowpart:10:" ..pink, "[combine:1x1"
local nicebench	= pink..	"^[lowpart:35:" ..aurum,"[combine:1x1"
local nicechair = pink.. "^(" ..aurum.. "^[mask:(" ..modname.. "_trim.png^" ..modname.. "_bind.png))"
local niceseat = pink.. "^(" ..aurum.. "^[mask:(" ..modname.. "_seat.png^nc_concrete_pattern_iceboxy.png))"
local fancytop	= frost.. "^(" ..aurum.. "^[mask:(nc_api_storebox_frame.png^nc_concrete_pattern_bindy.png))"
local fancybot	= frost.. "^(" ..aurum.. "^[mask:nc_tote_sides.png)"
local fancytable  = pink.. "^(" ..aurum.. "^[mask:" ..modname.. "_trim.png)"
local fdside = pink.. "^(" ..aurum.. "^[mask:nc_api_storebox_frame.png)"
local fdrawer = fdside.. "^(" ..aurum.. "^[mask:" ..modname.. "_drawer.png)"
local fglass = "nc_optics_glass_edges.png^(" ..pink.. "^[mask:nc_api_storebox_frame.png)"
local fglow = "nc_lux_base.png^(" ..fglass.. ")"
local flamplite = fglow.. "^[lowpart:60:" ..pink,"[combine:1x1"
local aurumframe = "(" ..aurum.. ")^[mask:(nc_api_storebox_frame.png^nc_concrete_pattern_bindy.png)"
local goldhandle = aurum.. "^[mask:nc_woodwork_ladder_mask.png"
------------------------------------------------------------------------
local cushnodebox = {
	{-0.4375, -0.5, -0.4375, 0.4375, -0.375, 0.4375},	-- Base
	{-0.375, -0.375, -0.375, 0.375, -0.1875, 0.375},	-- Cushion
	{-0.25, -0.25, -0.25, 0.25, -0.125, 0.25},			-- CushionTop
}
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
minetest.register_node(modname .. ":bench_pinkfancy", {
	description = "Fancy Bench",
	tiles = {
		pink,
		pink,
		nicebench
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
minetest.register_node(modname .. ":chair_pinkfancy", {
	description = "Fancy Chair",
	tiles = {
		niceseat,
		niceseat,
		nicechair
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
		cracky = 3,
		furniture = 1,
		chair = 1,
		stack_as_node = 1,
	},
	stack_max = 1,
	sounds = nodecore.sounds("nc_optics_glassy"),
})
------------------------------------------------------------------------
minetest.register_node(modname .. ":cushion_pinkfancy", {
	description = "Fancy Cushion",
	tiles = {
		fcushtop,	--top
		pink,	--bottom
		fcushbot	--sides
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
minetest.register_node(modname .. ":table_pinkfancy", {
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
------------------------------------------------------------------------
minetest.register_node(modname .. ":drawers_pinkfancy", {
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
	sounds = nodecore.sounds("nc_optics_glassy"),
	storebox_access = function(pt) return pt.above.y == pt.under.y end,
		on_ignite = function(pos)
			if minetest.get_node(pos).name == modname .. ":drawers_fancy" then
				return nodecore.stack_get(pos)
			end
		end
})
------------------------------------------------------------------------
minetest.register_node(modname .. ":lamp_pinkfancy", {
	description = "Fancy Lamp",
	tiles = {
		pink,
		pink,
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
	sounds = nodecore.sounds("nc_optics_glassy")
})
------------------------------------------------------------------------
minetest.register_node(modname .. ":shutter_pinkfancy", {
	description = "Fancy Shutter",
	tiles = {pink.. "^(" ..aurumframe.. ")^(" ..goldhandle.. ")"},
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
	sounds = nodecore.sounds("nc_optics_glassy")
})
-- ================================================================== --
