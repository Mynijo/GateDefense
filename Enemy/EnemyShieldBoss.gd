extends "res://Enemy/Enemy.gd"

var added_shield = false

	
func take_damage(damage):
	if dead:
		return	
	health -= damage
	if !added_shield and health <= max_health / 2:
		added_shield = true
		add_Status(load("res://effects/StatusEffectShield.tscn").instance())
	emit_signal('health_changed',health)