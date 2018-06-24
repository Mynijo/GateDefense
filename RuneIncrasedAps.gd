extends "res://Rune/Rune.gd"

export (float) var incrase

func effect(_obj):
	if _obj.has_method('change_gun_cooldown'):
		_obj.change_gun_cooldown(_obj.get_gun_cooldown() / incrase)