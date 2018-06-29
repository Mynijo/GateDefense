extends "res://effects/StatusEffect.gd"



export (float) var iniDamage
export (float) var explodeDamage
export (float) var explodeRadius

var body
var first = true

func _init():
	$Tags.add_tag($Tags.e_effect.cast_on_death)
	$Tags.add_tag($Tags.e_effect.health)
	$Tags.add_tag($Tags.e_effect.dont_stack)
	$Tags.add_tag($Tags.e_effect.need_body)
	$Tags.add_tag($Tags.e_effect.animation)
	
	
func effekt(value, tag):
	if tag == $Tags.e_effect.health:
		$Tags.remove_tag($Tags.e_effect.health)
		return value - iniDamage
	if tag == $Tags.e_effect.cast_on_death:
		for t in find_targets(get_parent()):
			if t.has_method('add_Status'):
				var s = self.duplicate(DUPLICATE_USE_INSTANCING)
				s.iniDamage = explodeDamage
				t.add_Status(s)
	if tag == $Tags.e_effect.animation:
		$Animation.global_position = value.global_position
		$Animation.show()
		$Animation.play("shock")
		return
			
	return value
		
	
func find_targets(_body):
	var enemys = get_tree().get_nodes_in_group("enemys")
	var targets = []
	for e in enemys:
		if e != _body:
			var temp = _body.position.distance_to(e.position)
			if  _body.position.distance_to(e.position) <= explodeRadius:
				targets.append(e)
	return targets

	
func set_duration(_duration):
	duration = _duration
	$Tags.add_tag($Tags.e_effect.health)
	$Duration.wait_time = duration
	$Duration.start()