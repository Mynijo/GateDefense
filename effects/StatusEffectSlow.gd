extends "res://effects/StatusEffect.gd"

export (PackedScene) var StatusEffektFreeze

export (float) var SlowRate

var first_time = true
export (float) var freez_chance

func _init():
	$Tags.add_tag($Tags.e_tags.speed)
	$Tags.add_tag($Tags.e_tags.animation)

func effekt(value, tag):
	if tag == $Tags.e_tags.speed:
		if first_time:
			first_time = false
			var counter = 0
			var parent = get_parent()
			var effects = parent.status_effecte
			for x in effects:
				if x.name.is_subsequence_of(self.name):
					counter += 1
			if rand_range(0,100) <= (freez_chance + counter*5) and freez_chance > 0:
				parent.add_Status(StatusEffektFreeze.instance())
				for x in effects:
					if x.name.is_subsequence_of(self.name):
						parent.remove_Status(x)
		return value * SlowRate
		
	if tag == $Tags.e_tags.animation:
		$Animation.global_position = value.global_position
		$Animation.show()
		$Animation.play("slow")
		return
					
		
	return value
	
func refresh(_obj):	
	if _obj.SlowRate >= SlowRate:
		first_time = true
		SlowRate = _obj.SlowRate
		set_duration(_obj.duration)