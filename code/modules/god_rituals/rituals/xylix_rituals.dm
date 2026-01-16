//FREED SOUL - removes the prisoner cursed masks or inquisition collars
/datum/god_ritual/freed_soul
	name = "Freed Soul"
	ritual_patron = /datum/patron/divine/xylix
	invocation_type = INVOCATION_WHISPER
	incantations = list(
		"Locked up and away?" = 3 SECONDS,
		"Not for long, not for long." = 3 SECONDS,
		"Be free, run wild! Make mischief!" = 3 SECONDS,
	)

/datum/god_ritual/freed_soul/on_completion(success)
	. = ..()
	if(success)
		var/mob/living/carbon/target = locate(/mob/living/carbon) in get_turf(sigil)
		if(!target)
			return
		if(istype(target.wear_mask, /obj/item/clothing/face/facemask/prisoner))//check for prisoner masks
			target.dropItemToGround(target.wear_mask, TRUE, FALSE)
		if(istype(target.wear_neck, /obj/item/clothing/neck/gorget/explosive))//check for inquisition collars
			var/obj/item/clothing/neck/gorget/explosive/friendship_necklace = target.wear_neck
			friendship_necklace.collar_unlocked = TRUE
			target.dropItemToGround(friendship_necklace, TRUE, FALSE)

//MASQUERADE - temporarily copy the appearance of someone? or grant prophunt spell?
