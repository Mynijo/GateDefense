extends "res://Enemy/StatusEffekt.gd"

export (int) var damge = 10
export (float) var igniteTickRate = 0.5
export (float) var speedInc = 1.2

var ready = true

func _ready():
	$IgniteTicker.wait_time = igniteTickRate
	$IgniteTicker.start()

func _init():
	tags.append(e_tags.health)
	tags.append(e_tags.speed)



func effekt(value, tag):
	if tag == e_tags.health:
		if ready:
			ready = false
			$IgniteTicker.start()
			return value - damge
	if tag == e_tags.speed:
		return value * speedInc
		
	return value
	
func get_tags():
	return tags 

func _on_IgniteTicker_timeout():
	ready = true
