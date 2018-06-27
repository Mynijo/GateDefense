extends Node

enum e_rune_tag{
	enemy_was_hit,
	shoot,
	explode,
	enemy_was_crit
}

var bullet
var tower
var tags = []

func _init():
	pass
func effect(obj):
	pass
	
func get_tags():
	return tags
	
func has_tag(_tag):
	if tags == null:
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