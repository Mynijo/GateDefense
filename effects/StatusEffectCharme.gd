extends "res://effects/StatusEffect.gd"

var dir
var stacks = 1
var min_stacke = 3
var inc_speed = 1.2
var target
var enemy

func _init():
	$Tags.add_tag($Tags.e_effect.animation)
	$Tags.add_tag($Tags.e_effect.dont_stack)
	
func effekt(value, tag):
	if tag == $Tags.e_effect.speed:
		return value * inc_speed
	if tag == $Tags.e_effect.direction:
		if !target:
			find_target()
			return value
		return (enemy.global_position - target.global_position).normalized()
	if tag == $Tags.e_effect.animation:
		$Animation.global_position = value.global_position + Vector2(20,-50)
		$Animation.show()
		if stacks >= min_stacke/3 and stacks < (min_stacke/3) *2:
			$Animation.play("charme01") 
		if stacks >= (min_stacke/3) *2 and stacks < min_stacke:
			$Animation.play("charme02") 
		if stacks >= min_stacke:
			$Animation.play("charme03") 
		
	return value
	
func refresh(_obj):
	stacks += 1

	.refresh(_obj)
	
	if stacks >= min_stacke:
		$Tags.add_tag($Tags.e_effect.speed)
		$Tags.add_tag($Tags.e_effect.direction)
		set_duration(3)
		enemy = get_parent()
		find_target()
		
	
func find_target():
	target = null
	var distance = -1
	var enemys = enemy.get_tree().get_nodes_in_group("enemys")
	for e in enemys:
		if e != enemy:
			if distance > enemy.global_position.distance_to(e.global_position) or distance == -1:
				distance = enemy.global_position.distance_to(e.global_position)
				target = e
				
