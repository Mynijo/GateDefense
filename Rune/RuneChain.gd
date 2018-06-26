extends "res://Rune/RuneEffect.gd"

export (int) var chain
export (int) var detect_distance

var chain_counter = 0
var target_hits = []
var target = []
var detect_radius_shape
var first = false
	
func _ready():
	_init()

func _init():
	tags.append(e_rune_tag.enemy_was_hit)

	
func effect(_obj):
	sort_Obj(_obj)
	
	if _obj == tower:
		return
	
	if bullet and !first:
		first = true
		if bullet.has_method('set_explose_after_hit'):
			bullet.set_explose_after_hit(self, false)

func enemy_was_hit(body):
	target_hits.append(body)
	effect(null)
	chain()
	
func chain():
	#if !bullet:
		#return
	chain_counter += 1
	
	if chain_counter >= chain:
		bullet_Explose()
		return
	
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
		bullet_Explose()
		
func bullet_Explose():
	if bullet.has_method('set_explose_after_hit'):
			bullet.set_explose_after_hit(self, true)

	
func find_targets():
	target.clear()
	var enemys = bullet.get_tree().get_nodes_in_group("enemys")
	for e in enemys:
		if !target_hits.has(e):
			if  bullet.global_position.distance_to(e.global_position) <= detect_distance:
				target.append(e)