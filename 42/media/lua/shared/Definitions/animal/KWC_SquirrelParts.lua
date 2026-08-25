-- What you get for butchering a grey squirrel.
--
-- Required, not decorative: vanilla's setAnimalBodyData reads this table at
-- ButcheringUtil.lua:18, checks it for nil on line 19, and then indexes it
-- unguarded on line 27. An animal missing from here throws "attempted index:
-- feather of non-table: null" every time one dies, and the corpse silently
-- loses BloodQty, leather, head, skeleton and meatRatio. The long version of
-- this note is in KnoxLifeFoxes/.../KWC_FoxParts.lua.
--
-- Keys are animal type concatenated with breed name, exactly as vanilla builds
-- them. Half a kilo of animal, so the yield is deliberately small: squirrel was
-- eaten in Kentucky far more than any of the other three, but one of them is a
-- snack rather than a meal, and a bag of them is the point.

AnimalPartsDefinitions = AnimalPartsDefinitions or {};
AnimalPartsDefinitions.animals = AnimalPartsDefinitions.animals or {};

-- Female, 0.4 to 0.65 kg.
local kwc_squirrelfemaledefault = AnimalPartsDefinitions.animals["kwc_squirrelfemaledefault"] or {};
kwc_squirrelfemaledefault.parts = kwc_squirrelfemaledefault.parts or {};
table.insert(kwc_squirrelfemaledefault.parts, {item = "Base.Smallanimalmeat", minNb = 1, maxNb = 2})
kwc_squirrelfemaledefault.bones = kwc_squirrelfemaledefault.bones or {};
table.insert(kwc_squirrelfemaledefault.bones, {item = "Base.SmallAnimalBone", minNb = 1, maxNb = 3})
kwc_squirrelfemaledefault.noSkeleton = true;
kwc_squirrelfemaledefault.xpPerItem = 7;
AnimalPartsDefinitions.animals["kwc_squirrelfemaledefault"] = kwc_squirrelfemaledefault;

-- Male, 0.42 to 0.7 kg.
local kwc_squirrelmaledefault = AnimalPartsDefinitions.animals["kwc_squirrelmaledefault"] or {};
kwc_squirrelmaledefault.parts = kwc_squirrelmaledefault.parts or {};
table.insert(kwc_squirrelmaledefault.parts, {item = "Base.Smallanimalmeat", minNb = 1, maxNb = 2})
kwc_squirrelmaledefault.bones = kwc_squirrelmaledefault.bones or {};
table.insert(kwc_squirrelmaledefault.bones, {item = "Base.SmallAnimalBone", minNb = 1, maxNb = 3})
kwc_squirrelmaledefault.noSkeleton = true;
kwc_squirrelmaledefault.xpPerItem = 7;
AnimalPartsDefinitions.animals["kwc_squirrelmaledefault"] = kwc_squirrelmaledefault;

-- Kit, 0.05 to 0.25 kg. Barely worth the knife, which is the intended message.
local kwc_squirrelkitdefault = AnimalPartsDefinitions.animals["kwc_squirrelkitdefault"] or {};
kwc_squirrelkitdefault.parts = kwc_squirrelkitdefault.parts or {};
table.insert(kwc_squirrelkitdefault.parts, {item = "Base.Smallanimalmeat", minNb = 1, maxNb = 1})
kwc_squirrelkitdefault.bones = kwc_squirrelkitdefault.bones or {};
table.insert(kwc_squirrelkitdefault.bones, {item = "Base.SmallAnimalBone", minNb = 1, maxNb = 2})
kwc_squirrelkitdefault.noSkeleton = true;
kwc_squirrelkitdefault.xpPerItem = 5;
AnimalPartsDefinitions.animals["kwc_squirrelkitdefault"] = kwc_squirrelkitdefault;
