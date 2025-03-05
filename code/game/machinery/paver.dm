/obj/machinery/paver
	name = "road paver"
	desc = "Road work ahead? I sure hope it does. This machine lays asphalt when filled with gravel, sand, or ash."
	icon = 'icons/obj/machines/pda.dmi'
	icon_state = "pdapainter"
	base_icon_state = "pdapainter"
	density = TRUE
	anchored = FALSE
	// What floor is getting put down
	var/turf_paved = /turf/open/floor/asphalt
	// How much asphalt the paver has
	var/current_asphalt = 0
	// How much asphalt the paver can have
	var/max_asphalt = 100
	// If the machine is running
	var/enabled = FALSE

/obj/machinery/paver/add_context(atom/source, list/context, obj/item/held_item, mob/user)
	. = ..()
	context[SCREENTIP_CONTEXT_LMB] = "Fill with material"
	context[SCREENTIP_CONTEXT_RMB] = "Turn off/on"
	return CONTEXTUAL_SCREENTIP_SET

//Returns how much asphalt is in the machine
/obj/machinery/paver/proc/get_asphalt(mob/user)
	return current_asphalt

/obj/machinery/paver/examine(mob/user)
	. = ..()
	. += "The machine currently has"

// Puts an asphalt tile on top of plating
/obj/machinery/paver/proc/pave_turf(turf/open/floor/plating/target_plating)
	if(enabled == FALSE)
		return
	if(!ispath(turf_paved))
		return
	if(!istype(target_plating))
		return
	if(get_asphalt() <= 1)
		return
	target_plating = target_plating.place_on_top(turf_paved, flags = CHANGETURF_INHERIT_AIR)
	playsound(target_plating, 'sound/items/weapons/genhit.ogg', 50, TRUE)
	return target_plating

/obj/machinery/paver/Moved(atom/old_loc, movement_dir, forced, list/old_locs, momentum_change = TRUE)
	. = ..()
	pave_turf(get_turf(src))

/// Adding Materials
/obj/machinery/paver/proc/insert_gravel(obj/item, mob/user)
	var/loaded = FALSE
	if(istype(item, /obj/item/gravel))
		var/obj/item/gravel/ammo = item
		var/load = min(ammo.asphalt_add, max_asphalt - current_asphalt)
		if(load <= 0)
			balloon_alert(user, "storage full!")
			return FALSE
		ammo.asphalt_add -= load
		if(ammo.asphalt_add <= 0)
			qdel(ammo)
		current_asphalt += load
		playsound(loc, 'sound/machines/click.ogg', 50, TRUE)
		loaded = TRUE
	else if(isstack(item))
		loaded = loadwithsheets(item, user)
	if(loaded)
		update_appearance() //ensures that ammo counters (if present) get updated
	return loaded

/obj/machinery/paver/proc/loadwithsheets(obj/item/stack/the_stack, mob/user)
	if(the_stack.asphalt_amount <= 0)
		balloon_alert(user, "invalid sheets!")
		return FALSE
	var/maxsheets = round((max_asphalt-current_asphalt) / the_stack.asphalt_amount) //calculate the max number of sheets that will fit in RCD
	if(maxsheets > 0)
		var/amount_to_use = min(the_stack.amount, maxsheets)
		the_stack.use(amount_to_use)
		current_asphalt += the_stack.asphalt_amount * amount_to_use
		playsound(loc, 'sound/machines/click.ogg', 50, TRUE)
		return TRUE
	balloon_alert(user, "storage full!")
	return FALSE

/obj/machinery/paver/item_interaction(mob/living/user, obj/item/attacking_item, params)
	if(user.combat_mode)
		return ITEM_INTERACT_SKIP_TO_ATTACK
	if(istype(attacking_item, /obj/item/gravel))
		insert_gravel()
		return ITEM_INTERACT_SUCCESS
	if(istype(attacking_item, /obj/item/stack))
		loadwithsheets()
		return ITEM_INTERACT_SUCCESS
	return NONE

/obj/machinery/paver/proc/toggle()
	enabled = !enabled
	playsound(loc, 'sound/machines/click.ogg', 50, TRUE)

//Shake(pixelshiftx = 1, pixelshifty = 0, duration = duration)
