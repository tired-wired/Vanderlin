/obj/structure/ritual_shrine
    name = "Ritual Shrine"
	desc = "A pristine ritual shrine, waiting for attunement."
	//placeholder dmi and icon_state
	icon = 'icons/roguetown/misc/rituals.dmi'
	icon_state = "ritual_base"

	//start with a blank slate. ish.
	var/attuned_patron = /datum/patron/godless
	//list of items put on the shrine
	var/list/offerings = list()
	/// if this shrine is active, other people can't use it
	var/datum/ritual/active = null
	//list of eligible rites
	var/list/god_rites = list()
	//are we attuned yet?
	var/is_attuned = FALSE

/obj/structure/ritual_shrine/proc/get_rites_list(attuned_patron)
	var/list/found_rites = list()
	for(var/patron in GLOB.all_god_rituals)
		if(ispath(attuned_patron, patron))
			found_rites |= GLOB.all_god_rituals[patron]
	for(var/rite in found_rites)
		var/datum/god_ritual/ritual_type = rite
		god_rites[initial(ritual_type.name)] = rite

//do ritual if clicked on post-attunement
/obj/structure/ritual_shrine/attack_hand(mob/living/user)
	//ensure they CAN do rituals
	if(!HAS_TRAIT(user, TRAIT_RITUALIST))
		user.visible_message(null, span_warning("This is beyond my knowledge."))
		return
	//do we have a god and rituals list?
	if(!is_attuned)
		user.visible_message(null, span_warning("This shrine is not yet attuned!"))
		return
	//get your own shrine, nerd
	if(active)
		user.visible_message(null, span_warning("Someone is already using this shrine."))
		return
	//...gotta be your god, too
	if(!ispath(attuned_patron, user.patron))
		user.visible_message(null, span_warning("I don't know this god's rites."))
		return
	//cooldown check.
	if(user.has_status_effect(/datum/status_effect/debuff/ritual_exhaustion))
		user.visible_message(null, span_warning("I've done a ritual too recently, I must rest."))
		return
	if(!length(god_rites))
		return
	var/choice = browser_input_list(user, "Rituals of [user.patron.name]", "THE GODS", god_rites)
	if(!choice || QDELETED(src) || QDELETED(user) || active || !user.CanReach(src))
		return
	var/ritual_type = god_rites[choice]
	active = new ritual_type(user, src)
	INVOKE_ASYNC(active, TYPE_PROC_REF(/datum/god_ritual, start_ritual))

//BASIC ATTUNEMENT ITEMS
/obj/item/ritual_item
	abstract_type =  = /obj/item/ritual_item
	//placeholders
	name = "ritual item"
	icon_state = "chalk"
	desc = "If you see this, something is wrong."
	icon = 'icons/roguetown/misc/rituals.dmi'
	w_class = WEIGHT_CLASS_TINY

/obj/item/ritual_item/astrata

/obj/item/ritual_item/noc

/obj/item/ritual_item/abyssor

/obj/item/ritual_item/dendor

/obj/item/ritual_item/malum

/obj/item/ritual_item/ravox

/obj/item/ritual_item/eora

/obj/item/ritual_item/xylix

/obj/item/ritual_item/pestra

/obj/item/ritual_item/necra

/obj/item/ritual_item/zizo

/obj/item/ritual_item/matthios

/obj/item/ritual_item/graggar

/obj/item/ritual_item/baotha
