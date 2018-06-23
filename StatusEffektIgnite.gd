extends "res://Enemy/StatusEffekt.gd"

export (int) var damge = 10
export (float) var igniteTickRate = 0.5
export (float) var speedInc = 1.2

func _init():
	tags.append(e_tags.health)
	$IgniteTicker.wait_time = igniteTickRate
	$IgniteTicker.start()


func effekt(value, tag):
	if tag == e_tags.speed:
		if $IgniteTicker.time_left <= 0:
			$IgniteTicker.start()
			return value - damge
	if tag == e_tags.speed:
		return value * speedInc
		
	return value
	
func get_tags():
	return tags 