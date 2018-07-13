extends "res://Enemy/Waves/Wave.gd"

func build_instance_list():
	var goblin = "res://Enemy/Goblin.tscn"
	var status = "res://effects/StatusEffectMiniMe.tscn"
	
	var test = JSON.print([[goblin,null],[[status,null]], 1, null])
	var test2 = JSON.parse(test)

	instance_list.append(test2.result)
	
	
