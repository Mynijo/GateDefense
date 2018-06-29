extends "res://Rune/RuneEffect.gd"

export (PackedScene) var status

func _init():
	$Tags.add_tag($Tags.e_rune.effect_bullet)
	$Tags.add_tag($Tags.e_rune.init_bullet)
	$Tags.add_tag($Tags.e_rune.fly_animation)

func effect(_obj, _tag):
	if _tag == $Tags.e_rune.effect_bullet:
		if _obj.has_method('add_Status'):
			var s = status.instance()
			s._init()
			s.add_tag($Tags.e_effect.dont_stack)
			_obj.add_Status(s)
	if _tag == $Tags.e_rune.fly_animation:
		$Animation.global_position = _obj.global_position
		$Animation.show()
		$Animation.play("bullet_on_fire")