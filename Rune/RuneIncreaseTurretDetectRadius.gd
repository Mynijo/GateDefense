extends "res://Rune/RuneEffect.gd"

export (float) var incrase

func _init():
	$Tags.add_tag($Tags.e_rune_tag.init_tower)
	$Tags.add_tag($Tags.e_rune_tag.effect_tower)

func effect(_obj, _tag):
	if _tag == $Tags.e_rune_tag.init_tower:
		sort_Obj(_obj)
	if _tag == $Tags.e_rune_tag.effect_tower:
		if tower.has_method('effect_detect_radius'):
			tower.effect_detect_radius(tower.get_detect_radius() * incrase)