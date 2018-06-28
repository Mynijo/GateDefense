extends "res://effects/StatusEffect.gd"

export (float) var push_rate
export (PackedScene) var status

var dir

func _init():
	tags.append(e_tags.speed)	
	tags.append(e_tags.direction)
	
	
func effekt(value, tag):
	if tag == e_tags.speed:
		return push_rate
	if tag == e_tags.direction:
		return dir
	return value
	
func refresh(_obj):
	pass
	
func _on_Duration_timeout():
	var t = get_parent()
	if t.has_method('add_Status'):
		var s = status.instance()
		s._init()		
		s.duration = 0.5
		s.SlowRate = 0
		s.freez_chance = 0
		t.add_Status(s)
	delteYou()