extends "res://Rune/RuneEffect.gd"

export (float) var incrase



func effect(_obj):
	if _obj.has_method('effect_detect_radius'):
		_obj.effect_detect_radius(_obj.get_detect_radius() * incrase)