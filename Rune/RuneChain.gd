extends "res://Rune/RuneEffect.gd"

export (int) var chain
export (int) var detect_distance

var chain_counter = 0
var target_hits = []
var target = []
var detect_radius_shape
var first = false


func _init():
	tags.append(e_rune_tag.enemy_was_hit)
	tags.append(e_rune_tag.effect_bullet)
	tags.append(e_rune_tag.init_bullet)
	
func effect(_obj, _tag):
	if _tag == e_rune_tag.init_bullet:
		sort_Obj(_obj)
	if _tag == e_rune_tag.enemy_was_hit:
		target_hits.append(_obj)
		return chain()

	
func chain():
	var continue_ = false
	
	chain_counter += 1
	
	
	if chain_counter >= chain:
		continue_ = true
		return continue_
	
	var closestTaget = null
	var newOne = true
	
	find_targets()
	
	for x in target:
		newOne = true
		for y in target_hits:
			if x == y:
				newOne = false
				pass
		if newOne:
			if closestTaget == null:
				closestTaget = x
			else:
				if (x.global_position - bullet.global_position).length() < (closestTaget.global_position - bullet.global_position).length():
					closestTaget = x
	
	if closestTaget:
		var distance = (closestTaget.global_position - bullet.global_position).length()
		var _time = (distance / bullet.get_speed())
		var predicted_position = closestTaget.global_position + (closestTaget.get_velocity() * _time)
		
		var dir = (predicted_position - bullet.global_position).normalized()
		bullet.rotation = dir.angle()
		bullet.velocity = dir * bullet.get_speed()
	else:
		continue_ = true
		return continue_
	
	continue_ = false
	return continue_

	
func find_targets():
	target.clear()
	var enemys = bullet.get_tree().get_nodes_in_group("enemys")
	for e in enemys:
		if !target_hits.has(e):
			if  bullet.global_position.distance_to(e.global_position) <= detect_distance:
				target.append(e)