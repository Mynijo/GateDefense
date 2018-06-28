extends "res://Rune/RuneEffect.gd"

var bounced = false
export (float) var incraseLifetime = 2
	
func _init():
	tags.append(e_rune_tag.enemy_was_hit)
	tags.append(e_rune_tag.init_tower)
	tags.append(e_rune_tag.effect_bullet)
	tags.append(e_rune_tag.init_bullet)

func effect(_obj, _tag):
	if _tag == e_rune_tag.init_tower:
		sort_Obj(_obj)
	if _tag == e_rune_tag.init_bullet:
		sort_Obj(_obj)
	if _tag == e_rune_tag.effect_bullet:
		bullet.effect_lifetime(bullet.get_lifetime() * incraseLifetime)
	if _tag == e_rune_tag.enemy_was_hit:
		tags.erase(e_rune_tag.enemy_was_hit)
		var dir = (tower.global_position - bullet.global_position).normalized()
		bullet.rotation = dir.angle()
		bullet.velocity = dir * bullet.get_speed()
		return false
		


