extends "res://Rune/RuneEffect.gd"

func effect(_obj):
	if _obj.has_method('set_exploseAfterHit'):
		_obj.set_exploseAfterHit(self, false)