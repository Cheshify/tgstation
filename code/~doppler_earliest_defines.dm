/// We can't reuse the builtin SPRITE_ACCESSORY_BLANK as a bunch of code for CI and consistenthumans are reliant on it to force species parts on in screenshot tests & similar.
/// Thus, we need a custom ID for each part, and to maintain consistency we SHOULD be using /part/none::name but CI alt tests don't like that for some reason.
#define DOPPLER_SPRITE_ACCESSORY_NOTAIL "No Tail"
#define DOPPLER_SPRITE_ACCESSORY_NOEARS "No Ears"
#define DOPPLER_SPRITE_ACCESSORY_NOSNOUT "No Snout"

/// Hi!  This file is here to work around some order-of-operations issues consistent humans & a couple other things have.
/// If our overrides aren't loaded in early enough default TG stuff will end up in the critical [1] slot and break things.

/// Snouts
/datum/sprite_accessory/snouts/none
	icon = 'modular_doppler/modular_customization/accessories/code/~overrides/icons/fallbacks.dmi'
	name = DOPPLER_SPRITE_ACCESSORY_NOSNOUT
	icon_state = "none"

/datum/sprite_accessory/snouts_more/bunny/none
	icon = 'modular_doppler/modular_customization/accessories/code/~overrides/icons/fallbacks.dmi'
	name = DOPPLER_SPRITE_ACCESSORY_NOSNOUT
	icon_state = /datum/sprite_accessory/snouts/none::icon_state

/// Ears
/datum/sprite_accessory/ears/none
	icon = 'modular_doppler/modular_customization/accessories/code/~overrides/icons/fallbacks.dmi'
	name = DOPPLER_SPRITE_ACCESSORY_NOEARS
	icon_state = "none"

/datum/sprite_accessory/ears_more/dog/none
	icon = 'modular_doppler/modular_customization/accessories/code/~overrides/icons/fallbacks.dmi'
	name = DOPPLER_SPRITE_ACCESSORY_NOEARS
	icon_state = /datum/sprite_accessory/ears/none::icon_state

/datum/sprite_accessory/ears_more/fox/none
	icon = 'modular_doppler/modular_customization/accessories/code/~overrides/icons/fallbacks.dmi'
	name = DOPPLER_SPRITE_ACCESSORY_NOEARS
	icon_state = /datum/sprite_accessory/ears/none::icon_state

/// Tail time
/datum/sprite_accessory/tails/none
	icon = 'modular_doppler/modular_customization/accessories/code/~overrides/icons/fallbacks.dmi'
	name = DOPPLER_SPRITE_ACCESSORY_NOTAIL
	icon_state = "none"

/datum/sprite_accessory/tails/lizard/none
	icon = /datum/sprite_accessory/tails/none::icon
	name = DOPPLER_SPRITE_ACCESSORY_NOTAIL
	icon_state = /datum/sprite_accessory/tails/none::icon_state

/datum/sprite_accessory/tails/human/none
	icon = /datum/sprite_accessory/tails/none::icon
	name = DOPPLER_SPRITE_ACCESSORY_NOTAIL
	icon_state = /datum/sprite_accessory/tails/none::icon_state

/datum/sprite_accessory/tails/monkey/none
	icon = /datum/sprite_accessory/tails/none::icon
	name = DOPPLER_SPRITE_ACCESSORY_NOTAIL
	icon_state = /datum/sprite_accessory/tails/none::icon_state

/datum/sprite_accessory/tails/dog/none
	icon = /datum/sprite_accessory/tails/none::icon
	name = DOPPLER_SPRITE_ACCESSORY_NOTAIL
	icon_state = /datum/sprite_accessory/tails/none::icon_state

/datum/sprite_accessory/tails/fox/none
	icon = /datum/sprite_accessory/tails/none::icon
	name = DOPPLER_SPRITE_ACCESSORY_NOTAIL
	icon_state = /datum/sprite_accessory/tails/none::icon_state

/// Lizard exclusive 🦎
/datum/sprite_accessory/lizard_markings/none
	icon = 'modular_doppler/modular_customization/accessories/code/~overrides/icons/fallbacks.dmi'
	name = "No Markings"
	icon_state = "none"

/datum/sprite_accessory/frills/none
	icon = 'modular_doppler/modular_customization/accessories/code/~overrides/icons/fallbacks.dmi'
	name = "No Frills"
	icon_state = "none"

/datum/sprite_accessory/horns/none
	icon = 'modular_doppler/modular_customization/accessories/code/~overrides/icons/fallbacks.dmi'
	name = "No Horns"
	icon_state = "none"

/// Linter sacrifice.  We only need this in the one file I suppose.
#undef DOPPLER_SPRITE_ACCESSORY_NOTAIL
#undef DOPPLER_SPRITE_ACCESSORY_NOEARS
#undef DOPPLER_SPRITE_ACCESSORY_NOSNOUT
