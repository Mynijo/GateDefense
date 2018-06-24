extends "res://Rune/RuneEffect.gd"

export (float) var incrase



func effect(_obj):
	if _obj.has_method('change_detect_radius'):
		_obj.change_detect_radius(_obj.get_detect_radius() * incrase)