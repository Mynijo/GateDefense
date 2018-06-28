extends "res://effects/StatusEffect.gd"

export (int) var damage
export (float) var ignite_tick_rate
export (float) var speed_inc

var ready = true

func _ready():
	$IgniteTicker.wait_time = ignite_tick_rate
	$IgniteTicker.start()
	_init()

func _init():
	tags.append(e_tags.health)
	tags.append(e_tags.speed)



func effekt(value, tag):
	if tag == e_tags.health:
		if ready:
			ready = false
			$IgniteTicker.start()
			return value - damage
	if tag == e_tags.speed:
		return value * speed_inc
		
	return value
	
func refresh(_obj):	
	if _obj.damage * _obj.ignite_tick_rate  >= damage * ignite_tick_rate:
		damage = _obj.damage
		ignite_tick_rate = _obj.ignite_tick_rate
		set_duration(_obj.duration)

func _on_IgniteTicker_timeout():
	ready = true
