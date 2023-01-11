//Catslugs need to find edible things!
/datum/ai_planning_subtree/find_and_hunt_target/catslug
	hunting_behavior = /datum/ai_behavior/hunt_target/unarmed_attack_target/catslug
	hunt_targets = list(/mob/living/basic/cockroach, /mob/living/basic/mouse)
	hunt_range = 5
	hunt_chance = 5

//Don't make them too aggressive
/datum/ai_behavior/hunt_target/unarmed_attack_target/catslug
	hunt_cooldown = 20 SECONDS
