extends "res://effects/StatusEffekt.gd"

export (int) var damage
export (float) var igniteTickRate
export (float) var speedInc

var ready = true

func _ready():
	$IgniteTicker.wait_time = igniteTickRate
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
		return value * speedInc
		
	return value
	
func refresh(_obj):	
	if _obj.damage * _obj.igniteTickRate  >= damage * igniteTickRate:
		damage = _obj.damage
		igniteTickRate = _obj.igniteTickRate
		set_duration(_obj.duration)

func _on_IgniteTicker_timeout():
	ready = true
