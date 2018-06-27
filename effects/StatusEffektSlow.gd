extends "res://effects/StatusEffekt.gd"

export (PackedScene) var StatusEffektFreeze

export (float) var SlowRate = 0.5

var first_time = true
export (float) var freez_chance = 100

func _ready():
	_init()

func _init():
	tags.append(e_tags.speed)	
	

func effekt(value, tag):
	if tag == e_tags.speed:
		if first_time:
			first_time = false
			var counter = 0
			var parent = get_parent()
			var effects = parent.status_effecte
			for x in effects:
				if x.name.is_subsequence_of(self.name):
					counter += 1
			if rand_range(0,100) <= (freez_chance + counter*5):
				parent.add_Status(StatusEffektFreeze.instance())
				for x in effects:
					if x.name.is_subsequence_of(self.name):
						parent.remove_Status(x)
					
		return value * SlowRate
	return value
	
func refresh(_obj):	
	if _obj.SlowRate >= SlowRate:
		first_time = true
		SlowRate = _obj.SlowRate
		set_duration(_obj.duration)