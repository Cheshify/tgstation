/obj/item/gravel
	name = "bag of gravel"
	desc = "You wonder how much something like this would cost."
	icon = 'icons/obj/weapons/fireaxe.dmi' //placeholder
	icon_state = "fireaxe0" //placeholder
	base_icon_state = "fireaxe" //placeholder
	lefthand_file = 'icons/mob/inhands/weapons/axes_lefthand.dmi' //placeholder
	righthand_file = 'icons/mob/inhands/weapons/axes_righthand.dmi' //placeholder
	force = 16
	throwforce = 24
	throw_range = 2
	tk_throw_range = 1
	throw_speed = 0.5
	slowdown = 1.1
	drag_slowdown = 1.1
	throw_speed = 1
	demolition_mod = 0.5
	wound_bonus = 15
	bare_wound_bonus = 10
	item_flags = SLOWS_WHILE_IN_HAND
	w_class = WEIGHT_CLASS_HUGE
	attack_verb_continuous = list("thwomps", "bashes", "slams", "crushes")
	attack_verb_simple = list("bash", "crunch", "slam", "crush")
	hitsound = 'sound/items/weapons/gravel_slam.ogg'
	// How much asphalt does this give to the paving machine?
	var/asphalt_add = 40
