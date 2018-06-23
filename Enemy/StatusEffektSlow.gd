extends "res://Enemy/StatusEffekt.gd"

var SlowRate = 0.5



func _init():
	tags.append(e_tags.speed)

func effekt(value, tag):
	if tag == e_tags.speed:
		return value * SlowRate
	return value
func get_tags():
	return tags 