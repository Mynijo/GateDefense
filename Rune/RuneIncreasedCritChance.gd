extends "res://Rune/RuneEffect.gd"

export (float) var incrase

func effect(_obj):
	if _obj.has_method('effect_crit_chance'):
		_obj.effect_crit_chance(_obj.get_crit_chance() * incrase)