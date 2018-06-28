extends "res://Rune/RuneEffect.gd"

export (float) var incrase

func _init():
	tags.append(e_rune_tag.effect_tower)
	tags.append(e_rune_tag.init_tower)


func effect(_obj, _tag):
	if _tag == e_rune_tag.init_tower:
		sort_Obj(_obj)
	if _tag == e_rune_tag.effect_tower:
		if tower.has_method('effect_gun_cooldown'):
			tower.effect_gun_cooldown(tower.get_gun_cooldown() / incrase)