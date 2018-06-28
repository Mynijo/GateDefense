extends Node

enum e_rune_tag{
	enemy_was_hit,
	shoot,
	explode,
	enemy_was_crit,
	effect_tower,
	effect_bullet,
	init_bullet,
	init_tower,
	whlie_flying
}

var bullet
var tower
var tags = []

	
func effect(_obj, _tag):
	pass
	
func get_tags():
	return tags
	
func has_tag(_tag):
	if !tags:
		return false
	return tags.has(_tag)
	
func add_tag(_tag):
	tags.append(_tag)
	
func sort_Obj(_obj):
	if _obj:
		if !tower or true:
			if _obj.has_method('is_Tower'):
				tower = _obj
				return
		if !bullet:
			if _obj.has_method('is_Bullet'):
				bullet = _obj
				return