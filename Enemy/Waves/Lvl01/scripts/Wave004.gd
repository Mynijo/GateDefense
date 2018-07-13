extends "res://Enemy/Waves/Wave.gd"

func build_instance_list():
	var goblin = "res://Enemy/Goblin.tscn"
	var status = "res://effects/StatusEffectMiniMe.tscn"
	
	var test = [[[goblin,null],[[status,null]], 1, null], [[goblin,null],[[null,null]], 1, null]]

	write_json("res://Enemy/Waves/Lvl01/Wave004.json", test)
	var test3 = load_json("res://Enemy/Waves/Lvl01/Wave004.json")
	
	for i in test3:
		instance_list.append(i)
	pass
