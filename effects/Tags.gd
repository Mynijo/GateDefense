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

enum e_tags{
	speed,
	health,
	dont_stack,
	cast_on_death,
	need_body,
	direction,
	animation
}

var tags = []


func _ready():
	pass
	
func remove_tag(_tag):
	tags.erase(_tag)

func add_tag(_tag):
	tags.append(_tag)

func get_tags():
	return tags
	
func has_tag(_tag):
	if tags == null:
		return false
	return tags.has(_tag)