extends "res://Rune/RuneEffect.gd"

export (float) var incrase

func effect(_obj):
	if _obj.has_method('effect_critChance'):
		_obj.effect_critChance(_obj.get_critChance() * incrase)