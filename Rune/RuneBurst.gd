extends "res://Rune/RuneEffect.gd"

signal shoot

func _init():
	$Tags.add_tag($Tags.e_rune.shoot)
	$Tags.add_tag($Tags.e_rune.init_tower)
	
var counter = 0
var bullets_to_shoot = 2

var ready = true
	
func effect(_obj, _tag):
	if _tag == $Tags.e_rune.init_tower:
		sort_Obj(_obj)
		self.connect("shoot", tower.get_tree().get_current_scene(), "_on_Tower_shoot")
		$Tags.remove_tag($Tags.e_rune.init_tower)
	if _tag == $Tags.e_rune.shoot:
		if ready:
			$Timer.start()
		
	

func _on_Timer_timeout():
	counter += 1
	if counter >= bullets_to_shoot:
		$Timer.stop()
		counter = 0
		$Cooldown.wait_time = tower.get_gun_cooldown()
		$Cooldown.start()
		ready = false
	tower.shoot()


func _on_Cooldown_timeout():
	ready = true
	$Cooldown.stop()
	
