//I really want to make eye damage stored in an eye organ

/datum/surgery/eye_surgery
	name = "eye surgery"
	steps = list(/datum/surgery_step/incise, /datum/surgery_step/retract_skin, /datum/surgery_step/clamp_bleeders, /datum/surgery_step/fix_eyes, /datum/surgery_step/close)
	species = list(/mob/living/carbon/human, /mob/living/carbon/monkey)
	possible_locs = list("eyes")
	requires_organic_bodypart = 0

//fix eyes
/datum/surgery_step/fix_eyes
	name = "fix eyes"
	implements = list(/obj/item/weapon/hemostat = 100, /obj/item/weapon/screwdriver = 45, /obj/item/weapon/pen = 25)
	time = 64

/datum/surgery_step/fix_eyes/preop(mob/user, mob/living/carbon/target, target_zone, obj/item/tool, datum/surgery/surgery)
	user.visible_message("<span class='notice'>[user] begins to fix [target]'s eyes.</span>")

/datum/surgery_step/fix_eyes/success(mob/user, mob/living/carbon/target, target_zone, obj/item/tool, datum/surgery/surgery)
	user.visible_message("<span class='notice'>[user] successfully fixes [target]'s eyes!</span>")
	target.disabilities &= ~BLIND
	target.disabilities &= ~NEARSIGHT
	target.health_status.vision_blurry = 35	//this will fix itself slowly.
	target.health_status.vision_damage = 0
	return 1

/datum/surgery_step/fix_eyes/failure(mob/user, mob/living/carbon/target, target_zone, obj/item/tool, datum/surgery/surgery)
	var/datum/organ/internal/brain/B = target.get_organdatum("brain")
	if(B && B.exists())
		user.visible_message("<span class='warning'>[user] accidentally stabs [target] right in the brain!</span>")
		target.adjustBrainLoss(100)
	else
		user.visible_message("<span class='warning'>[user] accidentally stabs [target] right in the brain! Or would have, if [target] had a brain.</span>")
	return 0