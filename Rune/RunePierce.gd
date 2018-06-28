extends "res://Rune/RuneEffect.gd"

var pierce = 0
export (int) var max_pierce = 3

func _init():
	tags.append(e_rune_tag.effect_bullet)
	tags.append(e_rune_tag.init_bullet)
	tags.append(e_rune_tag.enemy_was_hit)
	
func effect(_obj, _tag):
	if _tag == e_rune_tag.init_bullet:
		sort_Obj(_obj)
	if _tag == e_rune_tag.enemy_was_hit:
		pierce += 1
		if pierce < max_pierce:
			return false
		return true