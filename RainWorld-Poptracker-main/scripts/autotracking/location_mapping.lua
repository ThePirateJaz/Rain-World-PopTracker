-- use this file to map the AP location ids to your locations
-- first value is the code of the target location/item and the second is the item type override (feel free to expand the table with any other values you might need (i.e. special initial values, increments, etc.)!)
-- to reference a location in Pop use @ in the beginning and then path to the section (more info: https://github.com/black-sliver/PopTracker/blob/master/doc/PACKS.md#locations)
-- to reference an item use it's code
-- here are the SM locations as an example: https://github.com/Cyb3RGER/sm_ap_tracker/blob/main/scripts/autotracking/location_mapping.lua
BASE_LOCATION_ID = 0
LOCATION_MAPPING = {
[140005000] = {"@Achievements/The Martyr/The Martyr"},
[140005001] = {"@Achievements/The Mother/The Mother"},
[140005002] = {"@Achievements/The Pilgrim/The Pilgrim"},
[140005003] = {"@Achievements/The Survivor/The Survivor"},
[140005020] = {"@Achievements/The Dragon Slayer/The Dragon Slayer"},
[140005021] = {"@Achievements/The Friend/The Friend"},
[140005022] = {"@Achievements/The Wanderer/The Wanderer"},
[140005040] = {"@Achievements/The Chieftain/The Chieftain"},
[140005041] = {"@Achievements/The Hunter/The Hunter"},
[140005042] = {"@Achievements/The Monk/The Monk"},
[140005043] = {"@Achievements/The Outlaw/The Outlaw"},
[140005044] = {"@Achievements/The Saint/The Saint"},
[140005045] = {"@Achievements/The Scholar/The Scholar"},
[140005046] = {"@Achievements/The Nomad/The Nomad"},
[140005050] = {"@Achievements/1 pip/1 pip"},
[140005051] = {"@Achievements/2 pips/2 pips"},
[140005052] = {"@Achievements/3 pips/3 pips"},
[140005053] = {"@Achievements/4 pips/4 pips"},
[140005054] = {"@Achievements/5 pips/5 pips"},
[140005055] = {"@Achievements/6 pips/6 pips"},
[140005056] = {"@Achievements/7 pips/7 pips"},
[140005057] = {"@Achievements/8 pips/8 pips"},
[140005058] = {"@Achievements/9 pips/9 pips"},
[140005059] = {"@Achievements/10 pips/10 pips"},
[140005060] = {"@Achievements/11 pips/11 pips"},
[140005061] = {"@Achievements/12 pips/12 pips"},
[140005062] = {"@Achievements/12 pips/13 pips"},
[140005063] = {"@Achievements/12 pips/14 pips"},
[140005070] = {"@Chimney Canopy/Chimney Canopy/Echo"},
[140005071] = {"@Shaded Citadel/Shaded Citadel/Echo"},
[140005072] = {"@Farm Arrays/Farm Arrays/Echo"},
[140005073] = {"@The Exterior/The Exterior/Echo"},
[140005074] = {"@Sky Islands/Sky Islands/Echo"},
[140005075] = {"@Subterranean/Subterranean/Echo"},
[140005076] = {"@Metropolis/Metropolis/Echo"},
[140005077] = {"@Undergrowth/Undergrowth/Echo"},
[140005078] = {"@Silent Construct/Silent Construct/Echo"},
[140005079] = {"@Shoreline/Shoreline/Echo"},
[140005080] = {"@Submerged Superstructure/Submerged Superstructure/Echo"},
[140005250] = {"@Achievements/Food Quest/Slime Mold"},
[140005251] = {"@Achievements/Food Quest/Blue Fruit"},
[140005252] = {"@Achievements/Food Quest/Batfly"},
[140005253] = {"@Achievements/Food Quest/Mushroom"},
[140005254] = {"@Achievements/Food Quest/Black Lizard"},
[140005255] = {"@Achievements/Food Quest/Bubble Fruit"},
[140005256] = {"@Achievements/Food Quest/Jellyfish"},
[140005257] = {"@Achievements/Food Quest/Jetfish"},
[140005258] = {"@Achievements/Food Quest/Glow Weed"},
[140005259] = {"@Achievements/Food Quest/Eel Lizard or Salamander"},
[140005260] = {"@Achievements/Food Quest/Snail"},
[140005261] = {"@Achievements/Food Quest/Hazer"},
[140005262] = {"@Achievements/Food Quest/Eggbug"},
[140005263] = {"@Achievements/Food Quest/Lilypuck"},
[140005264] = {"@Achievements/Food Quest/Yellow Lizard"},
[140005265] = {"@Achievements/Food Quest/Grapple Worm"},
[140005266] = {"@Achievements/Food Quest/Neuron Fly"},
[140005267] = {"@Achievements/Food Quest/CentiWing"},
[140005268] = {"@Achievements/Food Quest/Dandelion Peach"},
[140005269] = {"@Achievements/Food Quest/Cyan Lizard"},
[140005270] = {"@Achievements/Food Quest/Gooieduck"},
[140005271] = {"@Achievements/Food Quest/Red Centipede or Aquapede"},
[140005272] = {"@Achievements/Food Quest/Popcorn Plant"},
[140005273] = {"@Achievements/Food Quest/Centipede"},
[140005274] = {"@Achievements/Food Quest/Vulture Grub"},
[140005275] = {"@Achievements/Food Quest/Noodlefly"},
[140005276] = {"@Achievements/Food Quest/Green Lizard"},
[140005277] = {"@Achievements/Food Quest/Blue Lizard"},
[140005278] = {"@Achievements/Food Quest/Pink Lizard"},
[140005279] = {"@Achievements/Food Quest/White Lizard"},
[140005280] = {"@Achievements/Food Quest/Red Lizard"},
[140005281] = {"@Achievements/Food Quest/Caramel Lizard"},
[140005282] = {"@Achievements/Food Quest/Strawberry Lizard"},
[140005283] = {"@Achievements/Food Quest/Train Lizard"},
[140005284] = {"@Achievements/Food Quest/Spider"},
[140005285] = {"@Achievements/Food Quest/Spitter Spider"},
[140005286] = {"@Achievements/Food Quest/Splitter Spider"},
[140005287] = {"@Achievements/Food Quest/Vulture"},
[140005288] = {"@Achievements/Food Quest/King Vulture"},
[140005289] = {"@Achievements/Food Quest/Miros Vulture"},
[140005290] = {"@Achievements/Food Quest/Lantern Mouse"},
[140005291] = {"@Achievements/Food Quest/Squidcada"},
[140005292] = {"@Achievements/Food Quest/Yeek"},
[140005293] = {"@Achievements/Food Quest/Dropwig"},
[140005294] = {"@Achievements/Food Quest/Miros Bird"},
[140005295] = {"@Achievements/Food Quest/Scavenger"},
[140005296] = {"@Achievements/Food Quest/Rot"},
[140005297] = {"@Achievements/Food Quest/Pole Plant"},
[140005298] = {"@Achievements/Food Quest/Monster Kelp"},
[140005299] = {"@Achievements/Food Quest/Leviathan"},
[140005300] = {"@Achievements/Food Quest/Inspector"},
[140004900] = {"@Achievements/Eat a Neuron Fly/Eat a Neuron Fly"},
[140004901] = {"@Shoreline/Shoreline/Give a Neuron Fly to Looks to the Moon"},
[140004902] = {"@Five Pebbles/Five Pebbles/Meet Five Pebbles"},
[140004903] = {"@Shoreline/Shoreline/Meet Looks to the Moon"},
[140004904] = {"@Moon/Moon/Meet Looks to the Moon"},
[140004905] = {"@The Rot/The Rot/Rarefaction Cell"},
[140004906] = {"@Shoreline/Shoreline/Revive Looks to the Moon"},
[140004907] = {"@Silent Construct/Silent Construct/Ascend Five Pebbles"},
[140004908] = {"@Shoreline/Shoreline/Ascend Looks to the Moon"},
[140000000] = {"@Chimney Canopy/Chimney Canopy/Chimney Canopy Token"},
[140000001] = {"@Chimney Canopy/Chimney Canopy/Cyan Lizard Token"},
[140000002] = {"@Chimney Canopy/Chimney Canopy/Pearl"},
[140000003] = {"@Chimney Canopy/Chimney Canopy/White Lizard Token"},
[140000004] = {"@Chimney Canopy/Chimney Canopy/Vulture Token"},
[140000005] = {"@Chimney Canopy/Chimney Canopy/Dropwig Token"},
[140000006] = {"@Drainage System/Drainage System/Salamander Token"},
[140000007] = {"@Drainage System/Drainage System/Bubbleweed Token"},
[140000008] = {"@Drainage System/Drainage System/Hazer Token"},
[140000009] = {"@Drainage System/Drainage System/Level Token"},
[140000010] = {"@Drainage System/Drainage System/Pearl"},
[140000011] = {"@Drainage System/Drainage System/Leech Token"},
[140000012] = {"@Drainage System/Drainage System/Snail Token"},
[140000013] = {"@Garbage Wastes/Garbage Wastes/Scavenger Token"},
[140000014] = {"@Garbage Wastes/Garbage Wastes/Explosive Spear Token"},
[140000015] = {"@Garbage Wastes/Garbage Wastes/Grenade Token"},
[140000016] = {"@Garbage Wastes/Garbage Wastes/Red Lizard Token"},
[140000017] = {"@Garbage Wastes/Garbage Wastes/Bubble Fruit Token"},
[140000018] = {"@Garbage Wastes/Garbage Wastes/Garbage Wastes Token"},
[140000019] = {"@Garbage Wastes/Garbage Wastes/Viridian Pearl"},
[140000020] = {"@Garbage Wastes/Garbage Wastes/Brother Long Legs Token"},
[140000021] = {"@Industrial Complex/Industrial Complex/Level Token"},
[140000022] = {"@Industrial Complex/Industrial Complex/Cherrybomb Token"},
[140000023] = {"@Industrial Complex/Industrial Complex/Blue Lizard Token"},
[140000024] = {"@Industrial Complex/Industrial Complex/Pearl"},
[140000025] = {"@Industrial Complex/Industrial Complex/Vulture Grub Token"},
[140000026] = {"@Industrial Complex/Industrial Complex/Centipede Token"},
[140000027] = {"@Farm Arrays/Farm Arrays/Sporepuff Token"},
[140000028] = {"@Farm Arrays/Farm Arrays/Rain Deer Token"},
[140000029] = {"@Farm Arrays/Farm Arrays/Bee Bomb Token"},
[140000030] = {"@Farm Arrays/Deep Pink Pearl/Pearl"},
[140000031] = {"@Farm Arrays/Farm Arrays/Batnip Token"},
[140000032] = {"@Farm Arrays/Farm Arrays/Grenade Token"},
[140000033] = {"@Farm Arrays/Bright Red Pearl/Pearl"},
[140000034] = {"@Farm Arrays/Farm Arrays/Noodlefly Token"},
[140000035] = {"@Farm Arrays/Farm Arrays/Level Token"},
[140000036] = {"@Farm Arrays/Farm Arrays/Spitter Spider Token"},
[140000037] = {"@Subterranean/Dark Magenta Pearl/Pearl"},
[140000038] = {"@Subterranean/Subterranean/Red Centipede Token"},
[140000039] = {"@Subterranean/Subterranean/Mushroom Token"},
[140000040] = {"@Subterranean/Subterranean/Black Lizard Token"},
[140000041] = {"@Subterranean/Subterranean Token/Level Token"},
[140000042] = {"@Subterranean/Subterranean/Centipede Token"},
[140000043] = {"@Subterranean/Teal Pearl/Pearl"},
[140000044] = {"@Subterranean/Subterranean/Monster Kelp Token"},
[140000045] = {"@Shaded Citadel/Shaded Citadel/Spider Token"},
[140000046] = {"@Shaded Citadel/Shaded Citadel/Coalescipede Token"},
[140000047] = {"@Shaded Citadel/Shaded Citadel/LanternMouse Token"},
[140000048] = {"@Shaded Citadel/Shaded Citadel/Level Token"},
[140000049] = {"@Shaded Citadel/Shaded Citadel/Pearl"},
[140000050] = {"@Shaded Citadel/Shaded Citadel/Lantern Token"},
[140000051] = {"@Shaded Citadel/Shaded Citadel/Miros Bird Token"},
[140000052] = {"@Shaded Citadel/Shaded Citadel/Flashbang Token"},
[140000053] = {"@Sky Islands/Dark Blue Pearl/Pearl"},
[140000054] = {"@Sky Islands/Sky Islands/King Vulture Token"},
[140000055] = {"@Sky Islands/Sky Islands/Level Token"},
[140000056] = {"@Sky Islands/Sky Islands/Centiwing Token"},
[140000057] = {"@Sky Islands/Sky Islands/EggBug Token"},
[140000058] = {"@Sky Islands/Dark Green Pearl/Pearl"},
[140000059] = {"@Shoreline/Shoreline/Jellyfish Token"},
[140000060] = {"@Shoreline/Bright Purple Pearl/Pearl"},
[140000061] = {"@Shoreline/Shoreline/Jetfish Token"},
[140000062] = {"@Shoreline/Pale Yellow Pearl/Pearl"},
[140000063] = {"@Shoreline/Shoreline/Leviathan Token"},
[140000064] = {"@Shoreline/Bright Magenta Pearl/Pearl"},
[140000065] = {"@Shoreline/Shoreline/Level Token"},
[140000066] = {"@Shoreline/Shoreline/SeaLeech Token"},
[140000067] = {"@Five Pebbles/Five Pebbles/Daddy Long Legs Token"},
[140000068] = {"@Outskirts/Light Blue Pearl/Pearl"},
[140000069] = {"@Outskirts/Outskirts/Squidcada Token"},
[140000070] = {"@Outskirts/Outskirts/Level Token"},
[140000071] = {"@Outskirts/Outskirts/Blue Fruit Token"},
[140000072] = {"@Outskirts/Outskirts/Pole Plant Token"},
[140000073] = {"@The Exterior/The Exterior/Pearl"},
[140000074] = {"@The Exterior/The Exterior/Level Token"},
[140000075] = {"@The Exterior/The Exterior/Yellow Lizard Token"},
[140000076] = {"@The Exterior/The Exterior/SlimeMold Token"},
[140000077] = {"@The Exterior/The Exterior/GrappleWorm Token"},
[140000078] = {"@Chimney Canopy/Chimney Canopy/Chatlog"},
[140000079] = {"@Chimney Canopy/Chimney Canopy/Gutter Token"},
[140000080] = {"@Chimney Canopy/Chimney Canopy/Safari Token"},
[140000081] = {"@Silent Construct/Silent Construct/Spider Token"},
[140000082] = {"@Silent Construct/Silent Construct/Level Token"},
[140000083] = {"@Silent Construct/Silent Construct/Yellow Lizard Token"},
[140000084] = {"@Silent Construct/Silent Construct/Saint Token"},
[140000085] = {"@Silent Construct/Silent Construct/Pearl"},
[140000086] = {"@Silent Construct/Silent Construct/Safari Token"},
[140000087] = {"@Silent Construct/Silent Construct/Brother Long Legs Token"},
[140000088] = {"@Silent Construct/Silent Construct/SlimeMold Token"},
[140000089] = {"@Moon/Moon/Spearmaster Token"},
[140000090] = {"@Moon/Moon/Level Token"},
[140000091] = {"@Moon/Chatlog DM0/Chatlog"},
[140000092] = {"@Moon/Moon/Safari Token"},
[140000093] = {"@Moon/Moon/Pearl"},
[140000094] = {"@Moon/Chatlog DM1/Chatlog"},
[140000095] = {"@Moon/Moon/Splitter Spider Token"},
[140000096] = {"@Drainage System/Drainage System/Safari Token"},
[140000097] = {"@Drainage System/Drainage System/Chatlog"},
[140000098] = {"@Drainage System/Drainage System/Broadcast"},
[140000099] = {"@Garbage Wastes/Garbage Wastes/Dull Yellow Pearl"},
[140000100] = {"@Garbage Wastes/Garbage Wastes/Past Garbage Wastes Token"},
[140000101] = {"@Garbage Wastes/Chatlog GW0/Chatlog"},
[140000102] = {"@Garbage Wastes/Chatlog GW1/Chatlog"},
[140000103] = {"@Garbage Wastes/Garbage Wastes/Safari Token"},
[140000104] = {"@Industrial Complex/Industrial Complex/Broadcast"},
[140000105] = {"@Industrial Complex/Industrial Complex/Chatlog"},
[140000106] = {"@Industrial Complex/Industrial Complex/Safari Token"},
[140000107] = {"@Metropolis/Metropolis/Zap Spear Token"},
[140000108] = {"@Metropolis/Bronze Pearl/Pearl"},
[140000109] = {"@Metropolis/Metropolis/Level Token"},
[140000110] = {"@Metropolis/Deep Green Pearl/Pearl"},
[140000111] = {"@Metropolis/Metropolis/Safari Token"},
[140000112] = {"@Metropolis/Metropolis/Artificer Token"},
[140000113] = {"@Metropolis/Metropolis/Singularity Bomb Token"},
[140000114] = {"@Metropolis/Metropolis/Elite Scavenger Token"},
[140000115] = {"@Farm Arrays/Farm Arrays/Broadcast"},
[140000116] = {"@Farm Arrays/Farm Arrays/Safari Token"},
[140000117] = {"@Waterfront Facility/Waterfront Facility/Safari Token"},
[140000118] = {"@Waterfront Facility/Waterfront Facility/Jellyfish Token"},
[140000119] = {"@Waterfront Facility/Bright Purple Pearl/Pearl"},
[140000120] = {"@Waterfront Facility/Waterfront Facility/Level Token"},
[140000121] = {"@Waterfront Facility/Waterfront Facility/Leviathan Token"},
[140000122] = {"@Waterfront Facility/Bright Magenta Pearl/Chatlog"},
[140000123] = {"@Waterfront Facility/Bright Magenta Pearl/Pearl"},
[140000124] = {"@Waterfront Facility/Waterfront Facility/SeaLeech Token"},
[140000125] = {"@Waterfront Facility/Broadcast/Broadcast"},
[140000126] = {"@Waterfront Facility/Broadcast LM1/Chatlog"},
[140000127] = {"@Submerged Superstructure/Submerged Superstructure/Rivulet Token"},
[140000128] = {"@Submerged Superstructure/Submerged Superstructure/Aquapede Token"},
[140000129] = {"@Submerged Superstructure/Submerged Superstructure/Glow Weed Token"},
[140000130] = {"@Submerged Superstructure/Submerged Superstructure/Level Token"},
[140000131] = {"@Submerged Superstructure/Submerged Superstructure/Giant Jellyfish Token"},
[140000132] = {"@Submerged Superstructure/Submerged Superstructure/Pearl"},
[140000133] = {"@Submerged Superstructure/Submerged Superstructure/Safari Token"},
[140000134] = {"@Submerged Superstructure/Submerged Superstructure/Miros Vulture Token"},
[140000135] = {"@Outer Expanse/Outer Expanse/Pearl"},
[140000136] = {"@Outer Expanse/Outer Expanse/Caramel Lizard Token"},
[140000137] = {"@Outer Expanse/Outer Expanse/Yeek Token"},
[140000138] = {"@Outer Expanse/Outer Expanse/JungleLeech Token"},
[140000139] = {"@Outer Expanse/Outer Expanse/Gooieduck Token"},
[140000140] = {"@Outer Expanse/Outer Expanse/Level Token"},
[140000141] = {"@Outer Expanse/Outer Expanse/Safari Token"},
[140000142] = {"@Outer Expanse/Outer Expanse/Gourmand Token"},
[140000143] = {"@Outer Expanse/Outer Expanse/SlugPup Token"},
[140000143] = {},
[140000145] = {"@The Rot/The Rot/Pearl"},
[140000146] = {"@The Rot/The Rot/Level Token"},
[140000147] = {"@The Rot/The Rot/Daddy Long Legs Token"},
[140000148] = {"@The Rot/The Rot/Mother Long Legs Token"},
[140000149] = {"@The Rot/The Rot/Safari Token"},
[140000150] = {"@Subterranean/Subterranean/Chatlog"},
[140000151] = {"@Subterranean/Subterranean/Safari Token"},
[140000152] = {"@Subterranean/Subterranean/Broadcast"},
[140000153] = {"@Subterranean/Filtration System Token/Level Token"},
[140000154] = {"@Shaded Citadel/Broadcast/Broadcast"},
[140000155] = {"@Shaded Citadel/Chatlog/Broadcast"},
[140000156] = {"@Shaded Citadel/Shaded Citadel/Safari Token"},
[140000157] = {"@Sky Islands/Dark Blue Pearl/Chatlog SI0"},
[140000158] = {"@Sky Islands/Dark Blue Pearl/Chatlog SI1"},
[140000159] = {"@Sky Islands/Broadcast SI2/Chatlog"},
[140000160] = {"@Sky Islands/Broadcast SI3/Chatlog"},
[140000161] = {"@Sky Islands/Dark Purple Pearl/Pearl"},
[140000162] = {"@Sky Islands/Sky Islands/Dandelion Peach Token"},
[140000163] = {"@Sky Islands/Dark Magenta Pearl/Pearl"},
[140000164] = {"@Sky Islands/Sky Islands/Safari Token"},
[140000165] = {"@Sky Islands/Olive Green Pearl/Pearl"},
[140000166] = {"@Sky Islands/Broadcast SI4/Chatlog"},
[140000167] = {"@Sky Islands/Chatlog SI5/Chatlog"},
[140000168] = {"@Sky Islands/Sky Islands/Vulture Mask Token"},
[140000170] = {"@Shoreline/Shoreline/Safari Token"},
[140000171] = {"@Five Pebbles/Five Pebbles/Chatlog"},
[140000172] = {"@Five Pebbles/Five Pebbles/Safari Token"},
[140000173] = {"@Five Pebbles/Five Pebbles/Inspector Token"},
[140000174] = {"@Outskirts/Outskirts/Broadcast"},
[140000175] = {"@Outskirts/Outskirts/Safari Token"},
[140000176] = {"@Outskirts/Light Pink Pearl/Pearl"},
[140000177] = {"@Undergrowth/Undergrowth/Salamander Token"},
[140000178] = {"@Undergrowth/Undergrowth/JungleLeech Token"},
[140000179] = {"@Undergrowth/Undergrowth/Bubbleweed Token"},
[140000180] = {"@Undergrowth/Undergrowth/Hazer Token"},
[140000181] = {"@Undergrowth/Undergrowth/Level Token"},
[140000182] = {"@Undergrowth/Undergrowth/Pearl"},
[140000183] = {"@Undergrowth/Undergrowth/Safari Token"},
[140000184] = {"@Undergrowth/Undergrowth/Snail Token"},
[140000185] = {"@The Exterior/The Exterior/Broadcast"},
[140000186] = {"@The Exterior/The Exterior/Safari Token"},
[140000187] = {"@Pipeyard/Pipeyard/Level Token"},
[140000188] = {"@Pipeyard/Broadcast 9/Broadcast"},
[140000189] = {"@Pipeyard/Pipeyard/Pearl Token"},
[140000190] = {"@Pipeyard/Pipeyard/Strawberry Lizard Token"},
[140000191] = {"@Pipeyard/Pipeyard/Lilypuck Token"},
[140000192] = {"@Pipeyard/Pipeyard/Pearl"},
[140000193] = {"@Pipeyard/Broadcast 8/Broadcast"},
[140000194] = {"@Pipeyard/Pipeyard/Safari Token"},
[140000195] = {"@Pipeyard/Pipeyard/Eel Lizard Token"},
[140005350] = {"@Chimney Shelters/Shelter S04/Shelter"},
[140005351] = {"@Chimney Shelters/Shelter S05/Shelter"},
[140005352] = {"@Chimney Shelters/Shelter S01/Shelter"},
[140005353] = {"@Chimney Shelters/Shelter S03/Shelter"},
[140005354] = {"@Drainage Shelters/Shelter S03/Shelter"},
[140005355] = {"@Drainage Shelters/Shelter S01R/Shelter"},
[140005356] = {"@Drainage Shelters/Shelter S04/Shelter"},
[140005357] = {"@Drainage Shelters/Shelter S02L/Shelter"},
[140005358] = {"@Garbage Shelters/Shelter S05/Shelter"},
[140005359] = {"@Garbage Shelters/Shelter S04/Shelter"},
[140005360] = {"@Garbage Shelters/Shelter S03/Shelter"},
[140005361] = {"@Garbage Shelters/Shelter S02/Shelter"},
[140005362] = {"@Garbage Shelters/Shelter S07/Shelter"},
[140005363] = {"@Garbage Shelters/Shelter S01/Shelter"},
[140005364] = {"@Garbage Shelters/Shelter S06/Shelter"},
[140005365] = {"@Garbage Shelters/Shelter S08/Shelter"},
[140005366] = {"@Industrial Shelters/Shelter S06/Shelter"},
[140005367] = {"@Industrial Shelters/Shelter S03/Shelter"},
[140005368] = {"@Industrial Shelters/Shelter S01/Shelter"},
[140005369] = {"@Industrial Shelters/Shelter S02/Shelter"},
[140005370] = {"@Industrial Shelters/Shelter S05/Shelter"},
[140005371] = {"@Industrial Shelters/Shelter S04/Shelter"},
[140005372] = {"@Farm Shelters/Shelter S04/Shelter"},
[140005373] = {"@Farm Shelters/Shelter S02/Shelter"},
[140005374] = {"@Farm Shelters/Shelter S06/Shelter"},
[140005375] = {"@Farm Shelters/Shelter S01/Shelter"},
[140005376] = {"@Farm Shelters/Shelter S07/Shelter"},
[140005377] = {"@Farm Shelters/Shelter S05/Shelter"},
[140005378] = {"@Farm Shelters/Shelter S03/Shelter"},
[140005379] = {"@Subterranean Shelters/Shelter S06/Shelter"},
[140005380] = {"@Subterranean Shelters/Shelter S07/Shelter"},
[140005381] = {"@Subterranean Shelters/Shelter S03/Shelter"},
[140005382] = {"@Subterranean Shelters/Shelter S04/Shelter"},
[140005383] = {"@Subterranean Shelters/Shelter S05/Shelter"},
[140005384] = {"@Subterranean Shelters/Shelter S02/Shelter"},
[140005385] = {"@Subterranean Shelters/Shelter S01/Shelter"},
[140005386] = {"@Shaded Shelters/Shelter S03/Shelter"},
[140005387] = {"@Shaded Shelters/Shelter S05/Shelter"},
[140005388] = {"@Shaded Shelters/Shelter S04/Shelter"},
[140005389] = {"@Shaded Shelters/Shelter S10/Shelter"},
[140005390] = {"@Shaded Shelters/Shelter S01/Shelter"},
[140005391] = {"@Shaded Shelters/Shelter S06/Shelter"},
[140005392] = {"@Shaded Shelters/Shelter S07/Shelter"},
[140005393] = {"@Shaded Shelters/Shelter S02/Shelter"},
[140005394] = {"@Shaded Shelters/Shelter S08/Shelter"},
[140005395] = {"@Shaded Shelters/Shelter S09/Shelter"},
[140005396] = {"@Island Shelters/Shelter S03/Shelter"},
[140005397] = {"@Island Shelters/Shelter S04/Shelter"},
[140005398] = {"@Island Shelters/Shelter S05/Shelter"},
[140005399] = {"@Shoreline Shelters/Shelter S02/Shelter"},
[140005400] = {"@Shoreline Shelters/Shelter S07/Shelter"},
[140005401] = {"@Shoreline Shelters/Shelter S05/Shelter"},
[140005402] = {"@Shoreline Shelters/Shelter S10/Shelter"},
[140005403] = {"@Shoreline Shelters/Shelter S06/Shelter"},
[140005404] = {"@Shoreline Shelters/Shelter S09/Shelter"},
[140005405] = {"@Shoreline Shelters/Shelter S03/Shelter"},
[140005406] = {"@Shoreline Shelters/Shelter S08/Shelter"},
[140005407] = {"@Shoreline Shelters/Shelter S04/Shelter"},
[140005408] = {"@Shoreline Shelters/Shelter S11/Shelter"},
[140005409] = {"@Five Shelters/Shelter S04/Shelter"},
[140005410] = {"@Five Shelters/Shelter S05/Shelter"},
[140005411] = {"@Five Shelters/Shelter S02/Shelter"},
[140005412] = {"@Five Shelters/Shelter S01/Shelter"},
[140005413] = {"@Five Shelters/Shelter S03/Shelter"},
[140005414] = {"@Outskirts Shelters/Shelter S04/Shelter"},
[140005415] = {"@Outskirts Shelters/Shelter S01/Shelter"},
[140005416] = {"@Outskirts Shelters/Shelter S03/Shelter"},
[140005417] = {"@Exterior Shelters/Shelter S03/Shelter"},
[140005418] = {"@Exterior Shelters/Shelter S04/Shelter"},
[140005419] = {"@Exterior Shelters/Shelter S01/Shelter"},
[140005420] = {"@Exterior Shelters/Shelter S02/Shelter"},
[140005421] = {"@Exterior Shelters/Shelter S07/Shelter"},
[140005422] = {"@Exterior Shelters/Shelter S06/Shelter"},
[140005423] = {"@Exterior Shelters/Shelter S05/Shelter"},
[140005424] = {"@Chimney Shelters/Shelter S06/Shelter"},
[140005425] = {"@Chimney Shelters/Shelter S07/Shelter"},
[140005426] = {"@Silent Shelters/Shelter S03/Shelter"},
[140005427] = {"@Silent Shelters/Shelter S12/Shelter"},
[140005428] = {"@Silent Shelters/Shelter S01/Shelter"},
[140005429] = {"@Silent Shelters/Shelter S11/Shelter"},
[140005430] = {"@Silent Shelters/Shelter S10/Shelter"},
[140005431] = {"@Silent Shelters/Shelter S20/Shelter"},
[140005432] = {"@Silent Shelters/Shelter S15/Shelter"},
[140005433] = {"@Silent Shelters/Shelter S21/Shelter"},
[140005434] = {"@Silent Shelters/Shelter LCS2/Shelter"},
[140005435] = {"@Silent Shelters/Shelter S05/Shelter"},
[140005436] = {"@Silent Shelters/Shelter S08/Shelter"},
[140005437] = {"@Silent Shelters/Shelter S14/Shelter"},
[140005438] = {"@Silent Shelters/Shelter S13/Shelter"},
[140005439] = {"@Silent Shelters/Shelter S02/Shelter"},
[140005440] = {"@Moon Shelters/Shelter S01/Shelter"},
[140005441] = {"@Moon Shelters/Shelter S04/Shelter"},
[140005442] = {"@Moon Shelters/Shelter S03/Shelter"},
[140005443] = {"@Moon Shelters/Shelter S05/Shelter"},
[140005444] = {"@Moon Shelters/Top Shelter/Shelter"},
[140005445] = {"@Moon Shelters/Shelter S10/Shelter"},
[140005446] = {"@Moon Shelters/Shelter S06/Shelter"},
[140005447] = {"@Moon Shelters/Shelter LAB5/Shelter"},
[140005448] = {"@Moon Shelters/Shelter S02/Shelter"},
[140005449] = {"@Moon Shelters/Shelter S14/Shelter"},
[140005450] = {"@Moon Shelters/Shelter S11/Shelter"},
[140005451] = {"@Moon Shelters/Shelter S13/Shelter"},
[140005452] = {"@Garbage Shelters/Shelter S09/Shelter"},
[140005453] = {"@Rubicon/Shelter S02/Shelter"},
[140005454] = {"@Rubicon/Shelter S1R/Shelter"},
[140005455] = {"@Rubicon/Shelter SHR/Shelter"},
[140005456] = {"@Rubicon/Shelter S11/Shelter"},
[140005457] = {"@Rubicon/Shelter S04/Shelter"},
[140005458] = {"@Rubicon/Shelter S06/Shelter"},
[140005459] = {"@Rubicon/Shelter S12/Shelter"},
[140005460] = {"@Rubicon/Shelter S05/Shelter"},
[140005461] = {"@Rubicon/Shelter S03/Shelter"},
[140005462] = {"@Rubicon/Shelter S01/Shelter"},
[140005463] = {"@Rubicon/Shelter S10/Shelter"},
[140005464] = {"@Metro Shelters/Shelter Above/Shelter"},
[140005465] = {"@Metro Shelters/Shelter A05/Shelter"},
[140005466] = {"@Metro Shelters/Roof Shelter/Shelter"},
[140005467] = {"@Metro Shelters/Shelter S03/Shelter"},
[140005468] = {"@Metro Shelters/Shelter S01/Shelter"},
[140005469] = {"@Metro Shelters/Shelter S06/Shelter"},
[140005470] = {"@Metro Shelters/Train Shelter/Shelter"},
[140005471] = {"@Metro Shelters/Shelter S05/Shelter"},
[140005472] = {"@Metro Shelters/Shelter S04/Shelter"},
[140005473] = {"@Waterfront Shelters/Shelter S15/Shelter"},
[140005474] = {"@Waterfront Shelters/Shelter S02/Shelter"},
[140005475] = {"@Waterfront Shelters/Shelter S07/Shelter"},
[140005476] = {"@Waterfront Shelters/Shelter S05/Shelter"},
[140005477] = {"@Waterfront Shelters/Shelter S09/Shelter"},
[140005478] = {"@Waterfront Shelters/Shelter S03/Shelter"},
[140005479] = {"@Waterfront Shelters/Shelter S04/Shelter"},
[140005480] = {"@Waterfront Shelters/Shelter S11/Shelter"},
[140005481] = {"@Waterfront Shelters/Shelter S13/Shelter"},
[140005482] = {"@Waterfront Shelters/Shelter S06/Shelter"},
[140005483] = {"@Submerged Shelters/Shelter S01/Shelter"},
[140005484] = {"@Submerged Shelters/Shelter S04/Shelter"},
[140005485] = {"@Submerged Shelters/Shelter S05/Shelter"},
[140005486] = {"@Submerged Shelters/Shelter S03/Shelter"},
[140005487] = {"@Submerged Shelters/Shelter S06/Shelter"},
[140005488] = {"@Submerged Shelters/Shelter S09/Shelter"},
[140005489] = {"@Submerged Shelters/Shelter LAB5/Shelter"},
[140005490] = {"@Submerged Shelters/Shelter S07/Shelter"},
[140005491] = {"@Submerged Shelters/Bitter Shelter/Shelter"},
[140005492] = {"@Submerged Shelters/Shelter S10/Shelter"},
[140005493] = {"@Outer Shelters/Shelter S01/Shelter"},
[140005494] = {"@Outer Shelters/Shelter S04/Shelter"},
[140005495] = {"@Outer Shelters/Ex Shelter/Shelter"},
[140005496] = {"@Outer Shelters/Mid Shelter/Shelter"},
[140005497] = {"@Outer Shelters/Shelter S06/Shelter"},
[140005498] = {"@Outer Shelters/Final Shelter/Shelter"},
[140005499] = {"@Outer Shelters/Shelter S03/Shelter"},
[140005500] = {"@Rot Shelters/Shelter S04/Shelter"},
[140005501] = {"@Rot Shelters/Shelter S05/Shelter"},
[140005502] = {"@Rot Shelters/Shelter S02/Shelter"},
[140005503] = {"@Rot Shelters/Shelter S01/Shelter"},
[140005504] = {"@Rot Shelters/Shelter S03/Shelter"},
[140005505] = {"@Rot Shelters/Shelter LCS2/Shelter"},
[140005506] = {"@Rot Shelters/Shelter LCS1/Shelter"},
[140005507] = {"@Rot Shelters/Dead Shelter/Shelter"},
[140005508] = {"@Rot Shelters/Final Shelter/Shelter"},
[140005509] = {"@Subterranean Shelters/Shelter S10/Shelter"},
[140005510] = {"@Subterranean Shelters/Shelter S09/Shelter"},
[140005511] = {"@Shaded Shelters/Shelter S11/Shelter"},
[140005512] = {"@Island Shelters/Shelter S06/Shelter"},
[140005513] = {"@Shoreline Shelters/Crushed Shelter/Shelter"},
[140005514] = {"@Shoreline Shelters/Shelter S13/Shelter"},
[140005515] = {"@Shoreline Shelters/Shelter S15/Shelter"},
[140005516] = {"@Shoreline Shelters/Top Shelter/Shelter"},
[140005517] = {"@Outskirts Shelters/Shelter S05/Shelter"},
[140005518] = {"@Undergrowth Shelters/Shelter S03/Shelter"},
[140005519] = {"@Undergrowth Shelters/Shelter S01R/Shelter"},
[140005520] = {"@Undergrowth Shelters/Shelter S04/Shelter"},
[140005521] = {"@Undergrowth Shelters/Shelter S02L/Shelter"},
[140005522] = {"@Pipeyard Shelters/Shelter S04/Shelter"},
[140005523] = {"@Pipeyard Shelters/Shelter S01/Shelter"},
[140005524] = {"@Pipeyard Shelters/Shelter S20/Shelter"},
[140005525] = {"@Pipeyard Shelters/Shelter S09/Shelter"},
[140005526] = {"@Pipeyard Shelters/Shelter S05/Shelter"},
[140005527] = {"@Pipeyard Shelters/Shelter S07/Shelter"},
[140005528] = {"@Pipeyard Shelters/Shelter S02/Shelter"},
[140005529] = {"@Pipeyard Shelters/Shelter S06/Shelter"},
[140005530] = {"@Pipeyard Shelters/Shelter S08/Shelter"},
[140005531] = {"@Pipeyard Shelters/Shelter S03/Shelter"}
}
