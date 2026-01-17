/datum/repeatable_crafting_recipe/ritual_chalk
	name = "ritual chalk"
	skillcraft = /datum/skill/magic/holy
	requirements = list(
		/obj/item/ore/silver = 1,
	)
	reagent_requirements = list(
		/datum/reagent/water/blessed = 15,
	)
	starting_atom = /obj/item/ore/silver
	attacked_atom = /obj/item/reagent_containers/glass
	output = /obj/item/ritual_chalk
	output_amount = 1
	craft_time = 1 SECONDS
	subtypes_allowed = TRUE
