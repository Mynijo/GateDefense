extends "res://Rune/RuneEffect.gd"

export (PackedScene) var status

func _init():
	$Tags.add_tag($Tags.e_rune.effect_bullet)
	$Tags.add_tag($Tags.e_rune.enemy_was_dmg)
	$Tags.add_tag($Tags.e_rune.init_bullet)
	$Tags.add_tag($Tags.e_rune.fly_animation)

func effect(_obj, _tag):
	if _tag == $Tags.e_rune.enemy_was_dmg:
		if _obj.has_method('add_Status'):
			var s = status.instance()
			_obj.add_Status(s)
	if _tag == $Tags.e_rune.fly_animation:
		$Animation.global_position = _obj.global_position
		$Animation.rotation = _obj.rotation
		$Animation.show()
		$Animation.play("snow")
		return