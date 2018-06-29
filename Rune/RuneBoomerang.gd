extends "res://Rune/RuneEffect.gd"

var bounced = false
export (float) var incraseLifetime = 2
	
func _init():
	$Tags.add_tag($Tags.e_rune.enemy_was_hit)
	$Tags.add_tag($Tags.e_rune.init_tower)
	$Tags.add_tag($Tags.e_rune.effect_bullet)
	$Tags.add_tag($Tags.e_rune.init_bullet)

func effect(_obj, _tag):
	if _tag == $Tags.e_rune.init_tower:
		sort_Obj(_obj)
	if _tag == $Tags.e_rune.init_bullet:
		sort_Obj(_obj)
	if _tag == $Tags.e_rune.effect_bullet:
		bullet.effect_lifetime(bullet.get_lifetime() * incraseLifetime)
	if _tag == $Tags.e_rune.enemy_was_hit:
		$Tags.remove_tag($Tags.e_rune.enemy_was_hit)
		var dir = (tower.global_position - bullet.global_position).normalized()
		bullet.rotation = dir.angle()
		bullet.velocity = dir * bullet.get_speed()
		return false
		


