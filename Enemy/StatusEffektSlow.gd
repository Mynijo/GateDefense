extends "res://Enemy/StatusEffekt.gd"

var SlowRate = 0.5



func _init():
	tags.append(e_tags.speed)

func effekt(value):
	return value * SlowRate
	
func get_tags():
	return tags 