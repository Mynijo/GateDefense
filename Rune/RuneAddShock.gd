extends "res://Rune/RuneEffect.gd"

export (PackedScene) var status

func _init():
	tags.append(e_rune_tag.effect_bullet)
	tags.append(e_rune_tag.init_bullet)

func effect(_obj, _tag):
	if _tag == e_rune_tag.effect_bullet:
		if _obj.has_method('add_Status'):
			var s = status.instance()
			s._init()
			_obj.add_Status(s)