extends "res://Rune/RuneEffect.gd"

export (float) var incrase

func effect(_obj):
	if _obj.has_method('effect_damage'):
		_obj.effect_damage(_obj.get_damage() * incrase)