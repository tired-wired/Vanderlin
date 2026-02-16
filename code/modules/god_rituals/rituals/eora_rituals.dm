//EORA'S PEACE - temporary pacification for a mood boost
/datum/god_ritual/eora_peace
	name = "Eora's Peace"
	ritual_patron = /datum/patron/divine/eora
	incantations = list(
		"There's no need to be so worked up." = 3 SECONDS,
		"Just relax a while." = 3 SECONDS,
		"Let's talk it out." = 3 SECONDS,
	)

/datum/god_ritual/eora_peace/on_completion(success)
	. = ..()
	if(success)
		var/mob/living/carbon/human/target = locate(/mob/living/carbon/human) in get_turf(sigil)
		if(!target)
			return
		target.visible_message(span_warning("[target] sways like windchimes in the wind..."), span_green("I feel the burdens of my heart lifting. Something feels very wrong... I don't mind at all..."))
		target.apply_status_effect(/datum/status_effect/buff/eora_peace)

//GIFT OF BEAUTY - Works like a mirror, allows you to change your hair, facial hair, or hair colour. Gives you the beautiful trait afterwards.
/datum/god_ritual/gift_beauty
	name = "Gift of Beauty"
	ritual_patron = /datum/patron/divine/eora
	cooldown = 1 MINUTES
	incantations = list(
		"Eora, bless us with your gifts!" = 3 SECONDS,
		"Refresh us with new beauty." = 3 SECONDS,
		"We love you!" = 3 SECONDS,
	)

/datum/god_ritual/gift_beauty/on_completion(success)
	. = ..()
	if(success)
		var/mob/living/carbon/human/H = locate(/mob/living/carbon/human) in get_turf(sigil)
		if(!H)
			return
		ADD_TRAIT(H, TRAIT_BEAUTIFUL, "ritual")
		var/list/options = list("hairstyle", "facial hairstyle", "hair color")
		var/chosen = browser_input_list(H, "Change what?", "VANDERLIN", options)
		var/should_update
		switch(chosen)
			if("facial hairstyle")
				var/datum/customizer_choice/bodypart_feature/hair/facial/humanoid/facial_choice = CUSTOMIZER_CHOICE(/datum/customizer_choice/bodypart_feature/hair/facial/humanoid)
				var/list/valid_facial_hairstyles = list()
				for(var/facial_type in facial_choice.sprite_accessories)
					var/datum/sprite_accessory/hair/facial/facial = new facial_type()
					valid_facial_hairstyles[facial.name] = facial_type

				var/new_style = browser_input_list(H, "Choose your facial hairstyle", "Hair Styling", valid_facial_hairstyles)
				if(new_style)
					var/obj/item/bodypart/head/head = H.get_bodypart(BODY_ZONE_HEAD)
					if(head && head.bodypart_features)
						var/datum/bodypart_feature/hair/facial/current_facial = null
						for(var/datum/bodypart_feature/hair/facial/facial_feature in head.bodypart_features)
							current_facial = facial_feature
							break

						if(current_facial)
							// Create a new facial hair entry with the SAME color as the current facial hair
							var/datum/customizer_entry/hair/facial/facial_entry = new()
							facial_entry.hair_color = current_facial.hair_color

							// Create the new facial hair with the new style but preserve color
							var/datum/bodypart_feature/hair/facial/new_facial = new()
							new_facial.set_accessory_type(valid_facial_hairstyles[new_style], facial_entry.hair_color, H)

							// Apply all the color data from the entry
							facial_choice.customize_feature(new_facial, H, null, facial_entry)

							head.remove_bodypart_feature(current_facial)
							head.add_bodypart_feature(new_facial)
							should_update = TRUE

			if("hairstyle")
				var/datum/customizer_choice/bodypart_feature/hair/head/humanoid/hair_choice = CUSTOMIZER_CHOICE(/datum/customizer_choice/bodypart_feature/hair/head/humanoid)
				var/list/valid_hairstyles = list()
				for(var/hair_type in hair_choice.sprite_accessories)
					var/datum/sprite_accessory/hair/head/hair = new hair_type()
					valid_hairstyles[hair.name] = hair_type

				var/new_style = browser_input_list(H, "Choose your hairstyle", "Hair Styling", valid_hairstyles)
				if(new_style)
					var/obj/item/bodypart/head/head = H.get_bodypart(BODY_ZONE_HEAD)
					if(head && head.bodypart_features)
						var/datum/bodypart_feature/hair/head/current_hair = null
						for(var/datum/bodypart_feature/hair/head/hair_feature in head.bodypart_features)
							current_hair = hair_feature
							break

						if(current_hair)
							var/datum/customizer_entry/hair/head/hair_entry = new()
							hair_entry.hair_color = current_hair.hair_color

							if(istype(current_hair, /datum/bodypart_feature/hair/head))
								hair_entry.natural_gradient = current_hair.natural_gradient
								hair_entry.natural_color = current_hair.natural_color
								if(hasvar(current_hair, "hair_dye_gradient"))
									hair_entry.dye_gradient = current_hair.hair_dye_gradient
								if(hasvar(current_hair, "hair_dye_color"))
									hair_entry.dye_color = current_hair.hair_dye_color

							var/datum/bodypart_feature/hair/head/new_hair = new()
							new_hair.set_accessory_type(valid_hairstyles[new_style], hair_entry.hair_color, H)

							hair_choice.customize_feature(new_hair, H, null, hair_entry)

							head.remove_bodypart_feature(current_hair)
							head.add_bodypart_feature(new_hair)
							should_update = TRUE
			if("hair color")
				var/new_hair
				var/list/hairs
				if(H.age == AGE_OLD && (OLDGREY in H.dna.species.species_traits))
					hairs = H.dna.species.get_oldhc_list()
					new_hair = browser_input_list(H, "Choose your character's hair color:", "", hairs)
				else
					hairs = H.dna.species.get_hairc_list()
					new_hair = browser_input_list(H, "Choose your character's hair color:", "", hairs)
				if(new_hair)
					new_hair = "#" + hairs[new_hair]
					H.set_hair_color(new_hair, FALSE)
					H.set_facial_hair_color(new_hair, FALSE) // This doesn't work for some reason?  Just change facial hair and its fine.
					should_update = TRUE
		if(should_update)
			H.update_body()
			H.update_body_parts()
		H.visible_message("[H] glows from within for a moment!", "I feel beautiful!")
