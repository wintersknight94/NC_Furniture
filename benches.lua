-- LUALOCALS < ---------------------------------------------------------
local core, nc, nodecore, string
	= core, nc, nodecore, string
local string_lower
	= string.lower
-- LUALOCALS > ---------------------------------------------------------
local modname = core.get_current_modname()
-- ================================================================== --
local rfcall = function(pos, data)
	local ref = core.get_player_by_name(data.pname)
	local wield = ref:get_wielded_item()
	wield:take_item(1)
	ref:set_wielded_item(wield)
end
-- ================================================================== --
local wicker	= "nc_flora_wicker.png"
local plank 	= "nc_woodwork_plank.png"
--local anlode	= "nc_lode_annealed.png"
local cloud	= "nc_concrete_cloudstone.png"
--local aurum	= "nc_lode_tempered.png^[colorize:gold:50"
------------------------------------------------------------------------
local wickbench	= wicker..	"^[lowpart:35:nc_tree_tree_side.png","[combine:1x1"
local woodbench	= plank..	"^[lowpart:35:nc_tree_tree_side.png","[combine:1x1"
--local nicebench	= cloud..	"^[lowpart:35:" ..aurum,"[combine:1x1"
------------------------------------------------------------------------
local benchnodebox = {
	{-0.5, -0.125, -0.3125, 0.5, 0, 0.3125},		-- Seat
	{-0.4375, -0.5, 0.0625, -0.3125, -0.125, 0.1875},	-- Leg(BackLeft)
	{0.3125, -0.5, 0.0625, 0.4375, -0.125, 0.1875},	-- Leg(BackRight)
	{0.3125, -0.5, -0.1875, 0.4375, -0.125, -0.0625},	-- Leg(FrontRight)
	{-0.4375, -0.5, -0.1875, -0.3125, -0.125, -0.0625},	-- Leg(FrontLeft)
--	{-0.5, -0.375, -0.0625, 0.5, -0.25, 0.0625}, 	-- Brace
}
-- ================================================================== --
core.register_node(modname .. ":bench_wicker", {
	description = "Wicker Bench",
	tiles = {
			wicker,
			wicker,
			wickbench
			},
	use_texture_alpha = "blend",
	drawtype = "nodebox",
	paramtype = "light",
	paramtype2 = "facedir",
	node_box = {
			type = "fixed",
			fixed = benchnodebox
			},
	selection_box = nc.fixedbox(),
	groups = {
			choppy = 2,
			flammable = 6,
			fire_fuel = 2,
			furniture = 1,
			bench = 1,
			stack_as_node = 1,
			},
	stack_max = 1,
	paramtype = "light",
	sounds = nc.sounds("nc_tree_sticky"),
})
------------------------------------------------------------------------
nc.register_craft({
	label = "make wicker bench",
	action = "pummel",
	duration = 4,
	indexkeys = {"wc_storage:shelf_wicker"},
	toolgroups = {thumpy = 2},
	nodes = {
			{match = {name = "wc_storage:shelf_wicker", empty = true},
			replace = modname .. ":bench_wicker"}
			}
})
------------------------------------------------------------------------
core.register_node(modname .. ":bench_wooden", {
	description = "Wooden Bench",
	tiles = {
			plank,
			plank,
			woodbench
			},
	drawtype = "nodebox",
	paramtype = "light",
	paramtype2 = "facedir",
	node_box = {
			type = "fixed",
			fixed = benchnodebox
			},
	selection_box = nc.fixedbox(),
	groups = {
			choppy = 2,
			flammable = 8,
			fire_fuel = 2,
			furniture = 1,
			bench = 1,
			stack_as_node = 1,
			},
	stack_max = 1,
	paramtype = "light",
	sounds = nc.sounds("nc_tree_woody"),
})
------------------------------------------------------------------------
nc.register_craft({
	label = "make wooden bench",
	action = "pummel",
	duration = 4,
	indexkeys = {"nc_woodwork:shelf"},
	toolgroups = {thumpy = 2},
	nodes = {
			{match = {name = "nc_woodwork:shelf", empty = true},
			replace = modname .. ":bench_wooden"}
			}
})
------------------------------------------------------------------------
local function temper(name, desc, sound, glow, dmg)

local anlode = "nc_lode_"..name..".png"
local aurum = "nc_lode_"..name..".png^[colorize:gold:50"
local nicebench	= cloud..	"^[lowpart:35:" ..aurum,"[combine:1x1"

core.register_node(modname .. ":bench_lode_"..name, {
	description = desc.. " Lode Bench",
	tiles = {
			anlode
			},
	drawtype = "nodebox",
	paramtype = "light",
	paramtype2 = "facedir",
	node_box = {
			type = "fixed",
			fixed = benchnodebox
			},
	selection_box = nc.fixedbox(),
	groups = {
			cracky = 3,
			furniture = 1,
			bench = 1,
			lode_bench = 1,
			lode_cube = 1,
--			stack_as_node = 1,
			metallic = 1,
			light_source = 1,
			damage_touch = dmg
			},
	stack_max = 1,
	paramtype = "light",
	sounds = nc.sounds("nc_lode_annealed"),
})
------------------------------------------------------------------------
core.register_node(modname .. ":bench_lode_"..name.."_fancy", {
	description = "Fancy "..desc.." Bench",
	tiles = {
			cloud,
			cloud,
			nicebench
			},
	drawtype = "nodebox",
	paramtype = "light",
	paramtype2 = "facedir",
	node_box = {
			type = "fixed",
			fixed = benchnodebox
			},
	selection_box = nc.fixedbox(),
	groups = {
			cracky = 3,
			furniture = 1,
			bench = 1,
			lode_bench = 1,
            lode_cube = 1,
--			stack_as_node = 1,
			metallic = 1,
			light_source = 1,
			damage_touch = dmg
			},
	stack_max = 1,
	paramtype = "light",
	sounds = nc.sounds("nc_optics_glassy"),
})
------------------------------------------------------------------------
nc.register_craft({
	label = "heat annealed lode bench",
	action = "cook",
	touchgroups = {flame = 3},
	neargroups = {coolant = 0},
	duration = 10,
	cookfx = true,
    indexkeys = modname .. ":bench_lode_annealed",
	nodes = {
			{match = modname ..":bench_lode_annealed", 
			replace = "air"},
			},
	items =	{{name = modname ..":bench_lode_hot", count = 1}}
})
------------------------------------------------------------------------
nc.register_craft({
	label = "heat tempered lode bench",
	action = "cook",
	touchgroups = {flame = 3},
	neargroups = {coolant = 0},
	duration = 10,
	cookfx = true,
    indexkeys = modname .. ":bench_lode_tempered",
	nodes = {
			{match = modname ..":bench_lode_tempered", 
			replace = "air"},
			},
	items =	{{name = modname ..":bench_lode_hot", count = 1}}
})
------------------------------------------------------------------------
nc.register_craft({
	label = "heat fancy "..desc.." lode bench",
	action = "cook",
	touchgroups = {flame = 3},
	neargroups = {coolant = 0},
	duration = 10,
	cookfx = true,
	indexkeys = modname..":bench_lode_"..name.."_fancy",
	nodes = {
			{match = modname..":bench_lode_"..name.."_fancy",
			replace = "air"},
			},
	items = {
			{name = modname..":bench_lode_hot", count = 1},
			{name = "nc_fire:lump_ash", count = 1, scatter = 2},
			{name = "nc_fire:lump_ash", count = 1, scatter = 2},
			{name = "nc_fire:lump_ash", count = 1, scatter = 2},
			{name = "nc_fire:lump_ash", count = 1, scatter = 2}
			},
})
------------------------------------------------------------------------
nc.register_craft({
	label = "plaster lode bench with spackling",
	action = "pummel",
	duration = 4,
	wield  = "nc_concrete:cloudmix",
	count = 1,
	consumewield = 1,
	indexkeys = modname..":bench_lode_"..name,
	nodes = {
			{match = modname..":bench_lode_"..name, 
			replace = modname..":bench_lode_"..name.."_fancy"}
			},
})
end

--local function temper(name, desc, sound, glow, dmg)
temper("annealed",	"Annealed",	"nc_lode_annealed",	false,	0)
temper("tempered",	"Tempered",	"nc_lode_tempered",	false,	0)
temper("hot",	"Glowing",	"nc_lode_annealed",	true,	0)
------------------------------------------------------------------------
nc.register_craft({
    label = "heat fancy lode bench",
    action = "cook",
    touchgroups = {flame = 3},
    neargroups = {coolant = 0},
    duration = 10,
    cookfx = true,
    nodes = {
			{match = {name = "wc_furniture:bench_lode_annealed_fancy"}, 
			replace = modname .. ":bench_lode_hot_fancy"},
			}
})
------------------------------------------------------------------------
nc.register_craft({
		label = "hot bench annealing",
		action = "cook",
		touchgroups = {flame = 0},
		neargroups = {coolant = 0},
		duration = 30,
		priority = -1,
		cookfx = {smoke = true, hiss = true},
		nodes = {
            	{match = {name = modname .. ":bench_lode_hot"},
                replace = modname .. ":bench_lode_annealed"},
        		}
	})
------------------------------------------------------------------------
nc.register_craft({
		label = "hot bench quenching",
		action = "cook",
		touchgroups = {flame = 0},
		neargroups = {coolant = 1},
		cookfx = true,
		nodes = {
            	{match = {name = modname .. ":bench_lode_hot"},
                replace = modname .. ":bench_lode_tempered"},
        		}
	})
------------------------------------------------------------------------
nc.register_craft({
	label = "make lode bench",
	action = "pummel",
	duration = 4,
	indexkeys = {"wc_storage:shelf_lode_annealed"},
	toolgroups = {thumpy = 3},
	nodes = { 
			{match = {name = "wc_storage:shelf_lode_annealed", empty = true}, 
			replace = modname .. ":bench_lode_annealed"}
			},
})
------------------------------------------------------------------------
nc.register_craft({
	label = "recycle lode bench",
	action = "pummel",
	duration = 4,
	indexkeys = {"wc_furniture:bench_lode_annealed"},
	toolgroups = {choppy = 4},
	nodes = { 
			{match = modname .. ":bench_lode_annealed", 
			replace = "air"},
			{y = -1, match = "nc_lode:block_tempered"}
			},
    items = {
            {name = "nc_lode:bar_annealed", count = 1, scatter = 4},
            {name = "nc_lode:bar_annealed", count = 1, scatter = 4},
            {name = "nc_lode:bar_annealed", count = 1, scatter = 4},
            {name = "nc_lode:bar_annealed", count = 1, scatter = 4},
            {name = "nc_lode:prill_annealed", count = 1, scatter = 3},
            {name = "nc_lode:prill_annealed", count = 1, scatter = 3},
			},
})
------------------------------------------------------------------------
nc.register_craft({
	label = "hot bench annealing",
	action = "cook",
	touchgroups = {flame = 0},
	neargroups = {coolant = 0},
	duration = 30,
	priority = -1,
	cookfx = {smoke = true, hiss = true},
	nodes = {
			{match = {name = modname .. ":bench_lode_hot"},
	 		replace = modname .. ":bench_lode_annealed"}
			},
})
-- ================================================================== --
