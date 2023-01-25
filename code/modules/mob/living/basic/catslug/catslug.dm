/mob/living/basic/catslug
	name = "catslug"
	desc = "A nimble and seemingly intelligent little creature."
	icon_state = "catslug"
	icon_living = "catslug"
	icon_dead = "catslug_dead"
	held_state = "catslug"

	melee_damage_lower = 3
	melee_damage_upper = 5
	maxHealth = 75
	health = 75
	see_in_dark = 6
	density = FALSE
	pass_flags = PASSTABLE|PASSGRILLE
	mob_size = MOB_SIZE_TINY
	can_be_held = TRUE
	held_w_class = WEIGHT_CLASS_TINY
	mob_biotypes = MOB_ORGANIC|MOB_BEAST
	gold_core_spawnable = FRIENDLY_SPAWN
	butcher_results = list(/obj/item/food/meat/slab/catslug = 2, /obj/item/organ/internal/ears/cat = 1, /obj/item/organ/external/tail/cat = 1, /obj/item/stack/sheet/animalhide/cat = 1)

	speak_emote = list("purrs", "meows", "blorbles")
	response_help_continuous = "pets"
	response_help_simple = "pet"
	response_disarm_continuous = "pushes aside"
	response_disarm_simple = "push aside"
	response_harm_continuous = "kicks"
	response_harm_simple = "kick"

	ai_controller = /datum/ai_controller/basic_controller/catslug

	//How much the catslug heals from eating
	var/catslug_eating_heal = 15

/mob/living/basic/catslug/Initialize(mapload)
	. = ..()
	AddElement(/datum/element/pet_bonus, "purrs!")
	add_verb(src, /mob/living/proc/toggle_resting)
	ADD_TRAIT(src, TRAIT_VENTCRAWLER_ALWAYS, INNATE_TRAIT)

//Collecting things!
/mob/living/basic/catslug/UnarmedAttack(atom/attack_target, proximity_flag, list/modifiers)
	. = ..()
	if(!.)
		return

	if(!proximity_flag)
		return

	if(istype(attack_target, list(/mob/living/basic/cockroach)))
		try_consume_cockroach(attack_target)
		return TRUE

	if(istype(attack_target, /mob/living/basic/mouse))
		try_consume_mouse(attack_target)
		return TRUE

	if(istype(attack_target, /mob/living/simple_animal/hostile/lightgeist))
		try_consume_lightgeist(attack_target)
		return TRUE

//Procs for eating things
/mob/living/basic/catslug/proc/try_consume_cockroach(mob/living/basic/cockroach)
	visible_message(
		span_warning("[src] quickly grabs and eats \the [cockroach]."),
		span_userdanger("You grab and stuff \the [cockroach] in your mouth, yum!")
	)
	//???
	adjustHealth(-10)	
	return ..()

/datum/ai_controller/basic_controller/catslug
	blackboard = list()

	ai_traits = STOP_MOVING_WHEN_PULLED | STOP_ACTING_WHILE_DEAD
	ai_movement = /datum/ai_movement/basic_avoidance
	idle_behavior = /datum/idle_behavior/idle_random_walk
	planning_subtrees = list(
		/datum/ai_planning_subtree/find_and_hunt_target/catslug_food,
		/datum/ai_planning_subtree/random_speech/catslug
	)
