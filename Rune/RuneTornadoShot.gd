extends "res://Rune/RuneEffect.gd"


export (float) var tick_rate = 0.1
export (float) var aoe_range = 150

export (PackedScene) var status


var target = []
var ready = false

func _init():
	$Tags.add_tag($Tags.e_rune.whlie_flying)
	$Tags.add_tag($Tags.e_rune.effect_bullet)
	$Tags.add_tag($Tags.e_rune.init_bullet)	
	$Tags.add_tag($Tags.e_rune.fly_animation)
	
	
	
func effect(_obj, _tag):
	if _tag == $Tags.e_rune.init_bullet:
		sort_Obj(_obj)
		$Ticker.wait_time = tick_rate
		$Ticker.start()
	if _tag == $Tags.e_rune.whlie_flying:
		if ready:			
			find_targets()
			for t in target:
				if t.has_method('add_Status'):
					var s = status.instance()
					s._init()
					s.dir = (bullet.global_position - t.global_position).normalized()
					s.add_tag($Tags.e_effect.dont_stack)
					t.add_Status(s)
	if _tag == $Tags.e_rune.fly_animation:
		$Animation.global_position = _obj.global_position
		$Animation.show()
		$Animation.play("tornado")
	return true
		


func find_targets():
	target.clear()
	var enemys = bullet.get_tree().get_nodes_in_group("enemys")
	for e in enemys:
		if  bullet.global_position.distance_to(e.global_position) <= aoe_range:
			target.append(e)

func _on_Ticker_timeout():
	ready = true
