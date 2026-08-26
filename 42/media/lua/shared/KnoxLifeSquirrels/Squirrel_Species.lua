-- Knox Life: Squirrel -- registration.
--
-- The whole spawning side of this mod. There is no generator here and no map
-- analysis: Squirrel_RouteData.lua is baked offline by the base mod's
-- tools/gen_routes.py from habitats.json, and hands its pool over with
-- registerRoutePool. All that is left is to say what this animal is and how
-- common it was.
--
-- ITS OWN GROUND. An addon species that declares no habitat inherits whichever
-- base pool its bucket falls back to, which is fine for something shaped like a
-- raccoon and wrong for this. Declaring `habitat` against a pool of our own
-- means it inherits nothing: its own terrain, its own geometry, no sharing.

if not KnoxLife or (KnoxLife.API_VERSION or 0) < 1 then
    print("[KnoxLifeSquirrels] KnoxLife not found (or too old); "
        .. "this addon needs API_VERSION 1. Not loading.")
    return
end

local KW = KnoxLife
local ID = "kwc_squirrel"

-- Density is the only number that decides how common this animal is. The base
-- mod turns it into routes with
--
--     routes = density * habitat area / mean group size * realism fraction
--
-- so nothing here competes with any other species or mod. Change it and only
-- this animal moves.
--
-- Real eastern grey squirrel density is 50-200 per square mile in hardwood, and
-- an earlier version of this file declared 100 for that reason, accepting that
-- the route pool would cap it. Running capped turned out to have a consequence
-- nobody wanted: a species pinned at its ceiling stops responding to the
-- Wildlife Density dial ENTIRELY. At 100 this asked for 3,230 routes against a
-- pool of 700, so Quarter, Half, Realistic, 1.5x and Double all delivered the
-- same 700 -- turning density DOWN could not thin the squirrels either. The
-- planner also flagged a conflict at the mod's own default settings, which
-- reads as the mod being broken out of the box.
--
-- So this is now the density the shipped pool can actually deliver:
-- 700 routes x 2.750 animals per group / 88.83 sq mi = 21.67 per sq mi. Set
-- just under it so Realistic asks for slightly less than the pool holds and
-- passes without a warning.
--
-- Use the EXACT group size. 22.0 was computed from the 2.8 the planner prints,
-- which is rounded to one decimal; the real mean is 2.750, and the difference
-- asked for 711 routes against a pool of 700 -- still capped, by eleven.
--
-- ⚠️ This is a DELIVERABLE density, not a biological one. The real figure is in
-- the first line above and should stay there. If the pool is ever regenerated
-- larger (tools/gen_routes.py --per-class), raise this to match the new
-- ceiling rather than reaching back toward 100.
local DENSITY = 21.5

-- The animal definitions come from tools/write_definitions.py. If one failed to
-- load, registering anyway would put a group in the spawn pool whose animal does
-- not exist, so check the FEMALE first: ID is the migration GROUP and was never
-- an animal id.
if AnimalDefinitions and AnimalDefinitions.animals
    and AnimalDefinitions.animals["kwc_squirrelfemale"] == nil then
    print("[KnoxLifeSquirrels] no animal definition for kwc_squirrelfemale; not registering. "
        .. "Its Definitions/animal file did not load.")
    return
end

if KW.registerSpecies(ID, {
    female = "kwc_squirrelfemale", male = "kwc_squirrelmale", baby = "kwc_squirrelkit",
    possibleBreed = "default",
    minAnimal = 1, maxAnimal = 2, maxMale = 1,
    babyChance = 50,
    trackSize = "small", speed = 0.05,
    density = DENSITY,
    habitat = ID,
    enabledOption = "KnoxLifeSquirrels.Enabled",
    routeOption  = "KnoxLifeSquirrels.Routes",
    groupOption  = "KnoxLifeSquirrels.GroupSize",
}) then
    -- The bucket decides only the FALLBACK pool, and this declares its own
    -- habitat, so the weight is vestigial. Passed because addToBucket is public
    -- API from version 1 and an addon written then supplies one.
    KW.addToBucket("small", ID, 50)
    print("[KnoxLifeSquirrels] registered on its own habitat (API v" .. KW.API_VERSION .. ")")
end
