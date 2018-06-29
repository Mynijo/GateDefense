extends "res://Rune/RuneEffect.gd"

export (float) var incrase

func _init():
	$Tags.add_tag($Tags.e_rune.effect_bullet)
	$Tags.add_tag($Tags.e_rune.init_bullet)

func effect(_obj, _tag):
	if _tag == $Tags.e_rune.init_bullet:
		sort_Obj(_obj)
	if _tag == $Tags.e_rune.effect_bullet:
		if bullet.has_method('effect_crit_chance'):
			bullet.effect_crit_chance(bullet.get_crit_chance() * incrase)