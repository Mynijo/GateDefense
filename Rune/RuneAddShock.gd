extends "res://Rune/RuneEffect.gd"

export (PackedScene) var status

func effect(_obj):
	if _obj.has_method('add_Status'):
		var s = status.instance()
		s._init()
		_obj.add_Status(s)