extends "res://Enemy/Waves/Wave.gd"


func build_instance_list():
	var goblin = load("res://Enemy/EnemyBlue.tscn")
	instance_list.append([goblin.instance(), 0.2])
	instance_list.append([goblin.instance(), 0.2])
	instance_list.append([goblin.instance(), 0.2])
	instance_list.append([goblin.instance(), 0.2])
	instance_list.append([goblin.instance(), 0.2])