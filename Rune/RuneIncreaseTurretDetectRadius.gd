extends "res://Rune/RuneEffect.gd"

export (float) var incrase

func _init():
	tags.append(e_rune_tag.init_tower)
	tags.append(e_rune_tag.effect_tower)

func effect(_obj, _tag):
	if _tag == e_rune_tag.init_tower:
		sort_Obj(_obj)
	if _tag == e_rune_tag.effect_tower:
		if tower.has_method('effect_detect_radius'):
			tower.effect_detect_radius(tower.get_detect_radius() * incrase)