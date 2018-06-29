extends "res://Rune/RuneEffect.gd"


export (float) var tick_rate = 0.1
export (float) var aoe_range = 150

export (PackedScene) var status


var target = []
var ready = false

func _init():
	$Tags.add_tag($Tags.e_rune_tag.whlie_flying)
	$Tags.add_tag($Tags.e_rune_tag.effect_bullet)
	$Tags.add_tag($Tags.e_rune_tag.init_bullet)
	
	
	
func effect(_obj, _tag):
	if _tag == $Tags.e_rune_tag.init_bullet:
		sort_Obj(_obj)
		$Ticker.wait_time = tick_rate
		$Ticker.start()
	if _tag == $Tags.e_rune_tag.whlie_flying:
		if ready:
			$Ticker.start()
			find_targets()
			for t in target:
				if t.has_method('add_Status'):
					var s = status.instance()
					s._init()
					s.dir = (bullet.global_position - t.global_position).normalized()
					s.add_tag($Tags.e_tags.dont_stack)
					t.add_Status(s)
	return true
		


func find_targets():
	target.clear()
	var enemys = bullet.get_tree().get_nodes_in_group("enemys")
	for e in enemys:
		if  bullet.global_position.distance_to(e.global_position) <= aoe_range:
			target.append(e)

func _on_Ticker_timeout():
	ready = true
