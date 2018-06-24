extends "res://effects/StatusEffekt.gd"

export (float) var SlowRate = 0.5

func _ready():
	_init()

func _init():
	tags.append(e_tags.speed)

func effekt(value, tag):
	if tag == e_tags.speed:
		return value * SlowRate
	return value
func get_tags():
	return tags 