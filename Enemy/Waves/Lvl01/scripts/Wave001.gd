extends "res://Enemy/Waves/Wave.gd"


func build_instance_list():
	var goblin = load("res://Enemy/EnemyBlue.tscn")
	var g = goblin.instance()
	var status = load("res://effects/StatusEffectDropRune.tscn").instance()
	
	g.add_Status(status)
	instance_list.append([g, 0.2])
	instance_list.append([goblin.instance(), 0.2])
	instance_list.append([goblin.instance(), 0.2])
	instance_list.append([goblin.instance(), 0.2])
	instance_list.append([goblin.instance(), 0.2])