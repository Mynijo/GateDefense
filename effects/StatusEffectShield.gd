extends "res://effects/StatusEffect.gd"

export (int) var max_health
var health

func _ready():
	health = max_health
	

func add_Status(_status):
	return
	
func take_damage(damage):
	health -= damage
	emit_signal('health_changed',health)
	if health <= 0:
		get_parent().remove_Status(self)