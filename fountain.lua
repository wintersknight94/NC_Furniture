-- LUALOCALS < ---------------------------------------------------------
local minetest, nodecore, math
    = minetest, nodecore, math
-- LUALOCALS > ---------------------------------------------------------
local modname = minetest.get_current_modname()
------------------------------------------------------------------------
local frost = "nc_optics_glass_frost.png"
local cloud = "nc_concrete_cloudstone.png"
local woodframe = "nc_tree_tree_side.png^[mask:nc_api_storebox_frame.png"
local lodeframe = "(nc_lode_tempered.png^[colorize:gold:50)^[mask:(nc_api_storebox_frame.png^nc_concrete_pattern_bindy.png)"
local woodside = "nc_tree_tree_side.png^[mask:" ..modname.. "_bind.png"
local lodeside = "(nc_lode_tempered.png^[colorize:gold:50)^[mask:(" ..modname.. "_bind.png^nc_concrete_pattern_bindy.png)"
local woodring = "nc_tree_tree_side.png^[mask:" ..modname.. "_ring.png"
local lodering = "(nc_lode_tempered.png^[colorize:gold:50)^[mask:" ..modname.. "_ring.png"
local spout = "(nc_optics_glass_frost.png^[colorize:black:100)^[mask:nc_woodwork_ladder_mask.png"
------------------------------------------------------------------------
local spoutnodebox = {
	{-0.125, 0, -0.125, 0.125, 0.5, 0.125},			-- Spout
	{-0.5, -0.5, -0.5, 0.5, -0.375, 0.5},				-- Base
	{-0.1875, -0.4375, -0.1875, 0.1875, 0.125, 0.1875},	-- Body
--	{-0.0625, 0.375, -0.0625, 0.0625, 0.6875, 0.0625},	-- SpoutTip
	{-0.25, -0.0625, -0.25, 0.25, 0, 0.25},			-- Medial
	{-0.25, -0.375, -0.25, 0.25, -0.1875, 0.25},		-- Riser
}
-- ================================================================== --
minetest.register_node(modname .. ":fountain", {
	description = "Fountain",
	tiles = {
		frost.. "^(" ..woodframe.. ")^(" ..woodring.. ")^(" ..spout.. ")",
		frost.. "^(" ..woodframe.. ")",
		frost.. "^(" ..woodside.. ")"
	},
	drawtype = "nodebox",
	glasslike_framed = true,
	paramtype = "light",
	paramtype2 = "facedir",
	node_box = {
		type = "fixed",
		fixed = spoutnodebox
	},
	selection_box = nodecore.fixedbox(),
	groups = {
		cracky = 4,
		fountain = 1,
		silica = 1,
		furniture = 1,
		coolant = 1
	},
	sounds = nodecore.sounds("nc_optics_glassy")
	})
------------------------------------------------------------------------
minetest.register_node(modname .. ":fountain_fancy", {
	description = "Fancy Fountain",
	tiles = {
		frost.. "^(" ..lodeframe.. ")^(" ..lodering.. ")^(" ..spout.. ")",
		frost.. "^(" ..lodeframe.. ")",
		frost.. "^(" ..lodeside.. ")"
	},
	drawtype = "nodebox",
	paramtype = "light",
	paramtype2 = "facedir",
	node_box = {
		type = "fixed",
		fixed = spoutnodebox
	},
	selection_box = nodecore.fixedbox(),
	groups = {
		cracky = 4,
		fountain = 1,
		silica = 1,
		furniture = 1,
		coolant = 1
	},
	sounds = nodecore.sounds("nc_optics_glassy")
	})
-- ================================================================== --
local function splashy(posa, posb)
	posb=posb or posa 
	local minpos = {
		x = (posa.x < posb.x and posa.x or posb.x) - 0.1,
		y = (posa.y < posb.y and posa.y or posb.y) - 0.1,
		z = (posa.z < posb.z and posa.z or posb.z) - 0.1
	}
	local maxpos = {
		x = (posa.x > posb.x and posa.x or posb.x) + 0.1,
		y = (posa.y > posb.y and posa.y or posb.y) + 0.5,
		z = (posa.z > posb.z and posa.z or posb.z) + 0.1
	}
	local volume = (maxpos.x - minpos.x + 1) * (maxpos.y - minpos.y + 1)
	* (maxpos.z - minpos.z + 1)
	minetest.add_particlespawner({
			amount = 10 * volume,
			time = 6,
			minpos = minpos,
			maxpos = maxpos,
			minvel = {x = -0.25, y = 0.5, z = -0.25},
			maxvel = {x = 1.0, y = 2.5, z = 1.0},
			texture = "nc_fire_spark.png^[colorize:blue",
			minexptime = 0.5,
			maxexptime = 2,
			collisiondetection = true,
			minsize = 0.25,
			maxsize = 1
		})
end
------------------------------------------------------------------------
nodecore.register_limited_abm({
		label = "particles:fountain",
		interval = 10,
		chance = 1,
		nodenames = {"group:fountain"},
		action = function(pos)
			local above = {x = pos.x, y = pos.y + 1, z = pos.z}
			local below = {x = pos.x, y = pos.y - 1, z = pos.z}
			local blnod = minetest.get_node(below)
			     if blnod.name == "nc_sponge:sponge_wet" then
					splashy(above)
					nodecore.sound_play("nc_terrain_watery", {pos = pos, gain = 0.02, fade = 1})
			end
		end
})
-- ================================================================== --
nodecore.register_craft({
	label = "assemble fountain",
	action = "stackapply",
	indexkeys = {"wc_storage:shelf_frost"},
	wield = {name = "nc_woodwork:frame"},
	consumewield = 1,
	nodes = {
		{
			match = {name = "wc_storage:shelf_frost", empty = true},
			replace = modname .. ":fountain"
		},
	}
})
------------------------------------------------------------------------
nodecore.register_craft({
	label = "assemble fancy fountain",
	action = "stackapply",
	indexkeys = {"wc_storage:shelf_frost"},
	wield = {name = "nc_lode:frame_tempered"},
	consumewield = 1,
	nodes = {
		{
			match = {name = "wc_storage:shelf_frost", empty = true},
			replace = modname .. ":fountain_fancy"
		},
	}
})
-- ================================================================== --
