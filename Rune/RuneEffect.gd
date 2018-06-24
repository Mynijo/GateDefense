extends Node

enum e_runeTag{
	enemyWasHit,
	shoot,
	explode,
	aps,
	detect_radius
}

var bullet
var tower

export (e_runeTag) var tags = []

func effect(obj):
	pass
	
func get_tags():
	return tags
	
func has_tag(_tag):
	if tags == null:
		return false
	return tags.has(_tag)
	
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