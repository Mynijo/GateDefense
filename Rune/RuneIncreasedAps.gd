extends "res://Rune/RuneEffect.gd"

export (float) var incrase

func effect(_obj):
	if _obj.has_method('effect_gun_cooldown'):
		_obj.effect_gun_cooldown(_obj.get_gun_cooldown() / incrase)