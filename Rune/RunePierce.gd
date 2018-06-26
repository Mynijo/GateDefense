extends "res://Rune/RuneEffect.gd"

func effect(_obj):
	if _obj.has_method('set_explose_after_hit'):
		_obj.set_explose_after_hit(self, false)