extends "res://Enemy/Waves/Wave.gd"

func build_instance_list():
	var orc = load("res://Enemy/EnemyTank.tscn")
	instance_list.append([orc.instance(), 0.2])
	instance_list.append([orc.instance(), 0.2])
	instance_list.append([orc.instance(), 1])
	instance_list.append([orc.instance(), 0])
	instance_list.append([orc.instance(), 0])