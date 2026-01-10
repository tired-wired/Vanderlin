/obj/structure/ritual_circle
	name = "ritual circle"
	desc = ""
	icon = 'icons/roguetown/misc/rituals.dmi'
	icon_state = "ritual_base"
	layer = BELOW_OBJ_LAYER
	density = FALSE
	anchored = TRUE
	resistance_flags = INDESTRUCTIBLE | LAVA_PROOF | FIRE_PROOF | UNACIDABLE | ACID_PROOF

	var/required_patron = /datum/patron/godless
	/// Associative of the name of the ritual to the type
	/// No need to fill this out. It autofills when it's initialized based on the patron.
	var/list/god_rites = list()

	/// if this circle is active, other people can't use it and the icon state changes
	var/active = FALSE

	base_icon_state = ""
	var/inactive_suffix = "_chalky"
	var/active_suffix = "_active"

/obj/structure/ritual_circle/Initialize()
	. = ..()
	var/list/found_rites = list()
	for(var/patron in GLOB.all_god_rituals)
		if(ispath(required_patron, patron))
			found_rites |= GLOB.all_god_rituals[patron]
	for(var/rite in found_rites)
		var/datum/god_ritual/ritual_type = rite
		god_rites[initial(ritual_type.name)] = rite

/obj/structure/ritual_circle/attack_hand_secondary(mob/living/user)
	//check to make sure no one is channeling to prevent dick behaviour
	if(active)
		user.visible_message(span_warning("Someone is using this rune!"))
		return
	//otherwise wipe it up
	user.visible_message(span_warning("[user] begins wiping away the rune."))
	if(do_after(user, 1.5 SECONDS))
		playsound(loc, 'sound/foley/cloth_wipe (1).ogg', 100, TRUE)
		qdel(src)

/obj/structure/ritual_circle/attack_hand(mob/living/user)
	//ensure they CAN do rituals
	if(!HAS_TRAIT(user, TRAIT_RITUALIST))
		user.visible_message(span_warning("This is beyond my knowledge."))
		return
	//get your own rune, nerd
	if(active)
		user.visible_message(span_warning("Someone is already using this rune."))
		return
	//...gotta be your god, too
	if(!ispath(required_patron, user.patron))
		user.visible_message(span_warning("I don't know this god's rites."))
		return
	if(!length(god_rites))
		return
	var/choice = browser_input_list(user, "Rituals of [user.patron.name]", "THE GODS", god_rites)
	if(!choice || QDELETED(src) || QDELETED(user))
		return
	var/ritual_type = god_rites[choice]
	var/datum/god_ritual/ritual = new ritual_type(user, src)
	active = TRUE
	update_appearance(UPDATE_ICON_STATE)
	ritual.start_ritual()



/obj/structure/ritual_circle/update_icon_state()
	. = ..()
	if(base_icon_state)
		icon_state = "[base_icon_state][active ? active_suffix : inactive_suffix]"

//Circle structures below

/obj/structure/ritual_circle/astrata
	name = "rune of the sun"
	desc = "This sigil is hot to the touch. It's almost too much to bear."
	icon_state = "astrata_chalky"
	base_icon_state = "astrata"
	required_patron = /datum/patron/divine/astrata

/obj/structure/ritual_circle/noc
	name = "rune of the moon"
	desc = "This sigil is cool to the touch, and shimmers silver in the corner of your eye."
	icon_state = "noc_chalky"
	base_icon_state = "noc"
	required_patron = /datum/patron/divine/noc

/obj/structure/ritual_circle/abyssor
	name = "rune of the storm"
	desc = "This sigil is drawn best with fury in your blood."
	//icon_state = "abyssor_chalky"
	//base_icon_state = "abyssor"
	required_patron = /datum/patron/divine/abyssor

/obj/structure/ritual_circle/dendor
	name = "rune of the wilds"
	desc = "Use your instinct to draw the lines of this sigil."
	icon_state = "dendor_chalky"
	base_icon_state = "dendor"
	required_patron = /datum/patron/divine/dendor

/obj/structure/ritual_circle/malum
	name = "rune of industry"
	desc = "The sigil is drawn with machine-precision."
	icon_state = "malum_chalky"
	base_icon_state = "malum"
	required_patron = /datum/patron/divine/malum

/obj/structure/ritual_circle/ravox
	name = "rune of the valiant" //placeholder
	desc = ""
	//icon_state = "ravox_chalky"
	//base_icon_state = "ravox"
	required_patron = /datum/patron/divine/ravox

/obj/structure/ritual_circle/eora
	name = "rune of the heart"
	desc = "This sigil soothes the eyes. The ritualist has done a beautiful job."
	icon_state = "eora_chalky"
	base_icon_state = "eora"
	required_patron = /datum/patron/divine/eora


/obj/structure/ritual_circle/xylix
	name = "rune of the trickster"
	desc = "This sigil is to be drawn with a laugh on your lips and freedom in your heart."
	//icon_state = "xylix_chalky"
	//base_icon_state = "xylix"
	required_patron = /datum/patron/divine/xylix


/obj/structure/ritual_circle/necra
	name = "rune of the underworld"
	desc = ""
	icon_state = "necra_chalky"
	base_icon_state = "necra"
	required_patron = /datum/patron/divine/necra

/obj/structure/ritual_circle/pestra
	name = "rune of medicine" //placeholder
	desc = ""
	icon_state = "pestra_chalky"
	base_icon_state = "pestra"
	required_patron = /datum/patron/divine/pestra


/obj/structure/ritual_circle/zizo
	name = "rune of the lich" //placeholder
	desc = ""
	icon_state = "zizo_chalky"
	base_icon_state = "zizo"
	required_patron = /datum/patron/inhumen/zizo

/obj/structure/ritual_circle/baotha
	name = "rune of joy"
	desc = ""
	//icon_state = "baotha_chalky"
	//base_icon_state = "baotha"
	required_patron = /datum/patron/inhumen/baotha

/obj/structure/ritual_circle/matthios
	name = "rune of thieves"//or greed?
	desc = ""
	icon_state = "matthios_chalky"
	base_icon_state = "matthios"
	required_patron = /datum/patron/inhumen/matthios

/obj/structure/ritual_circle/graggar
	name = "rune of the warlord"
	desc = ""
	//icon_state = "graggar_chalky"
	//base_icon_state = "graggar"
	required_patron = /datum/patron/inhumen/graggar

