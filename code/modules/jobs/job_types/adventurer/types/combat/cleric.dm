//shield
/datum/advclass/combat/cleric
	name = "Cleric"
	tutorial = "Clerics are wandering warriors of the Gods, drawn from the ranks of temple acolytes who demonstrated martial talent. Protected by armor and zeal, they are a force to be reckoned with."
	allowed_races = RACES_PLAYER_ALL
	vampcompat = FALSE
	outfit = /datum/outfit/job/adventurer/cleric
	category_tags = list(CTAG_ADVENTURER)
	min_pq = 0
	maximum_possible_slots = 4

/datum/outfit/job/adventurer/cleric
	allowed_patrons = ALL_CLERIC_PATRONS

/datum/outfit/job/adventurer/cleric/pre_equip(mob/living/carbon/human/H)
	..()
	if(H.dna && (H.dna.species.id in RACES_PLAYER_HERETICAL_RACE) && !istype(H.patron, /datum/patron/inhumen))
		var/list/inhumen = list(
			/datum/patron/inhumen/graggar,
			/datum/patron/inhumen/zizo,
			/datum/patron/inhumen/matthios,
			/datum/patron/inhumen/baotha
		)
		var/picked = pick(inhumen)
		H.set_patron(picked)
		to_chat(H, span_warning("My patron had not endorsed my practices in my younger years. I've since grown acustomed to [H.patron]."))
	H.virginity = TRUE
	head = /obj/item/clothing/head/helmet/ironpot
	armor = /obj/item/clothing/armor/cuirass/iron // Adventurers are not supposed to have fricking steel, at all
	shirt = /obj/item/clothing/armor/gambeson/light
	pants = /obj/item/clothing/pants/trou/leather
	shoes = /obj/item/clothing/shoes/boots/leather
	neck = /obj/item/clothing/neck/chaincoif/iron // Everyone gets iron coif, instead of variable neck armor
	belt = /obj/item/storage/belt/leather
	backr = /obj/item/weapon/shield/heater
	if(ispath(H.patron?.type, /datum/patron/divine/necra))
		backl = /obj/item/weapon/shovel
	if(ispath(H.patron?.type, /datum/patron/divine/abyssor))
		backl = /obj/item/weapon/polearm/woodstaff/quarterstaff
	else
		if(iself(H) || ishalfelf(H))
			beltl = /obj/item/weapon/mace/elvenclub
		else
			beltl = /obj/item/weapon/mace
	beltr = /obj/item/storage/belt/pouch/coins/poor

	switch(H.patron?.type)
		if(/datum/patron/divine/astrata)
			wrists = /obj/item/clothing/neck/psycross/silver/astrata
			cloak = /obj/item/clothing/cloak/stabard/templar/astrata
			H.cmode_music = 'sound/music/cmode/church/CombatAstrata.ogg'
		if(/datum/patron/divine/dendor)
			wrists = /obj/item/clothing/neck/psycross/silver/dendor
			cloak = /obj/item/clothing/cloak/stabard/templar/dendor
			H.cmode_music = 'sound/music/cmode/garrison/CombatForestGarrison.ogg'
		if(/datum/patron/divine/necra)
			wrists = /obj/item/clothing/neck/psycross/silver/necra
			cloak = /obj/item/clothing/cloak/stabard/templar/necra
			H.cmode_music = 'sound/music/cmode/church/CombatGravekeeper.ogg'
		if(/datum/patron/divine/eora)
			wrists = /obj/item/clothing/neck/psycross/silver/eora
			cloak = /obj/item/clothing/cloak/stabard/templar/eora
			H.cmode_music = 'sound/music/cmode/church/CombatEora.ogg'
			H.virginity = FALSE // this is hilarious lol
			ADD_TRAIT(H, TRAIT_BEAUTIFUL, TRAIT_GENERIC)
		if(/datum/patron/divine/ravox)
			wrists = /obj/item/clothing/neck/psycross/silver/ravox
			cloak =  /obj/item/clothing/cloak/stabard/templar/ravox
			H.cmode_music = 'sound/music/cmode/adventurer/CombatOutlander2.ogg'
		if(/datum/patron/divine/noc)
			wrists = /obj/item/clothing/neck/psycross/noc
			cloak = /obj/item/clothing/cloak/stabard/templar/noc
			H.cmode_music = 'sound/music/cmode/adventurer/CombatMonk.ogg'
		if(/datum/patron/divine/pestra)
			wrists = /obj/item/clothing/neck/psycross/silver/pestra
			cloak = /obj/item/clothing/cloak/stabard/templar/pestra
			H.cmode_music = 'sound/music/cmode/adventurer/CombatMonk.ogg'
		if(/datum/patron/divine/abyssor)
			wrists = /obj/item/clothing/neck/psycross/silver/abyssor
			cloak = /obj/item/clothing/cloak/tabard/crusader
			H.cmode_music = 'sound/music/cmode/adventurer/CombatMonk.ogg'
		if(/datum/patron/divine/malum)
			wrists = /obj/item/clothing/neck/psycross/silver/malum
			cloak = /obj/item/clothing/cloak/stabard/templar/malum
			H.cmode_music = 'sound/music/cmode/adventurer/CombatOutlander2.ogg'
		if(/datum/patron/divine/xylix)
			wrists = /obj/item/clothing/neck/psycross/silver/xylix
			cloak = /obj/item/clothing/cloak/tabard/crusader
			H.cmode_music = 'sound/music/cmode/adventurer/CombatMonk.ogg'
		if(/datum/patron/inhumen/graggar) // Heretical Patrons
			cloak = /obj/item/clothing/cloak/raincloak/mortus
			H.cmode_music = 'sound/music/cmode/antag/combat_werewolf.ogg'
			GLOB.heretical_players += H.real_name
		if(/datum/patron/inhumen/graggar_zizo)
			cloak = /obj/item/clothing/cloak/raincloak/mortus
			H.cmode_music = 'sound/music/cmode/antag/combat_werewolf.ogg'
		if(/datum/patron/inhumen/zizo)
			cloak = /obj/item/clothing/cloak/raincloak/mortus
			H.cmode_music = 'sound/music/cmode/antag/combat_cult.ogg'
			GLOB.heretical_players += H.real_name
		if(/datum/patron/inhumen/matthios)
			cloak = /obj/item/clothing/cloak/raincloak/mortus
			H.cmode_music = 'sound/music/cmode/antag/CombatBandit1.ogg'
			GLOB.heretical_players += H.real_name
		if(/datum/patron/inhumen/baotha)
			head = /obj/item/clothing/head/crown/circlet
			mask = /obj/item/clothing/face/spectacles/sglasses
			cloak = /obj/item/clothing/cloak/raincloak/purple
			H.cmode_music = 'sound/music/cmode/antag/CombatBaotha.ogg'
			GLOB.heretical_players += H.real_name
		else // Failsafe
			cloak = /obj/item/clothing/cloak/tabard/crusader // Give us a generic crusade tabard
			wrists = /obj/item/clothing/neck/psycross/silver // Give us a silver psycross for protection against lickers
			H.cmode_music = 'sound/music/cmode/church/CombatInquisitor.ogg'


	if(H.mind)
		H.adjust_skillrank(/datum/skill/combat/crossbows, 2, TRUE)
		H.adjust_skillrank(/datum/skill/combat/wrestling, 3, TRUE)
		H.adjust_skillrank(/datum/skill/combat/unarmed, 2, TRUE)
		H.adjust_skillrank(/datum/skill/combat/shields, 2, TRUE)
		H.adjust_skillrank(/datum/skill/misc/climbing, 1, TRUE)
		H.adjust_skillrank(/datum/skill/misc/athletics, 3, TRUE)
		H.adjust_skillrank(/datum/skill/misc/reading, 3, TRUE)
		H.adjust_skillrank(/datum/skill/magic/holy, 1, TRUE)
		H.adjust_skillrank(/datum/skill/craft/cooking, 1, TRUE)
		H.adjust_skillrank(/datum/skill/labor/mathematics, 2, TRUE)
		if(ispath(H.patron?.type, /datum/patron/divine/necra))
			H.adjust_skillrank(/datum/skill/combat/polearms, 2, TRUE)
		var/datum/skill/to_add = /datum/skill/combat/axesmaces
		if(ispath(H.patron?.type, /datum/patron/divine/abyssor))
			to_add = /datum/skill/combat/polearms
			H.adjust_skillrank(/datum/skill/labor/fishing, 2, TRUE)
		H.adjust_skillrank(to_add, 3, TRUE)
		if(H.age == AGE_OLD)
			H.adjust_skillrank(to_add, 1, TRUE)
			H.adjust_skillrank(/datum/skill/magic/holy, 1, TRUE)
		H.change_stat(STATKEY_STR, 1)
		H.change_stat(STATKEY_INT, 1)
		H.change_stat(STATKEY_CON, 1)
		H.change_stat(STATKEY_END, 2)
		H.change_stat(STATKEY_SPD, -1)
		if(!H.has_language(/datum/language/celestial)) // For discussing church matters with the other Clergy
			H.grant_language(/datum/language/celestial)
			to_chat(H, "<span class='info'>I can speak Celestial with ,c before my speech.</span>")
	ADD_TRAIT(H, TRAIT_MEDIUMARMOR, TRAIT_GENERIC) // Even if it has limited slots, it is a common drifter role available to anyone. Their armor also is not heavy, so medium armor training is enough
	var/datum/devotion/cleric_holder/C = new /datum/devotion/cleric_holder(H, H.patron)
	C.grant_spells_cleric(H)
	H.verbs += list(/mob/living/carbon/human/proc/devotionreport, /mob/living/carbon/human/proc/clericpray)

