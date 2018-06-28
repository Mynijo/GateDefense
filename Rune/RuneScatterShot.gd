extends "res://Rune/RuneEffect.gd"

signal shoot
export (float) var scatter

func _init():
	tags.append(e_rune_tag.shoot)
	tags.append(e_rune_tag.init_tower)
	tags.append(e_rune_tag.effect_tower)

func effect(_obj, _tag):
	if _tag == e_rune_tag.init_tower:
		sort_Obj(_obj)
		self.connect("shoot", tower.get_tree().get_current_scene(), "_on_Tower_shoot")
		tags.erase(init_tower)
	if _tag == e_rune_tag.shoot:
		var temp_scatter = rand_range(0.1,scatter)
		shoot(_obj, temp_scatter)
		shoot(_obj, -temp_scatter)
	
func shoot(_obj, _scatter):
	var _bullet = tower.Bullet.instance()	
	if tower.runes:
		_bullet.set_runes(tower.runes, tower)
	var temp = tower.get_node("Body").rotation + _scatter
	emit_signal("shoot", _bullet, tower.global_position, Vector2(1, 0).rotated(temp))
	