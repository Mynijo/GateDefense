extends "res://Rune/RuneEffect.gd"

func _init():
	$Tags.add_tag($Tags.e_rune_tag.enemy_was_crit)
	$Tags.add_tag($Tags.e_rune_tag.init_tower)
	$Tags.add_tag($Tags.e_rune_tag.effect_bullet)
	
func effect(_obj, _tag):
	if _tag == $Tags.e_rune_tag.init_tower:
		sort_Obj(_obj)

	
func enemy_was_crit(body):
	if tower:
		tower.shoot()