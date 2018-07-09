extends "res://effects/scripts/StatusEffect.gd"

signal health_changed
export (int) var max_health
var health

func _init():
	$Tags.add_tag($Tags.e_effect.buff)
	$Tags.add_tag($Tags.e_effect.init)
	
	
func effekt(value, tag):
	if tag == $Tags.e_effect.init:
		health = max_health
	if damage == null:
		return	
	health = health - damage
	emit_signal('health_changed',health)
	if health <= 0:
		get_parent().remove_Status(self)