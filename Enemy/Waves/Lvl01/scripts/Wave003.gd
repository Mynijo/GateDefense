extends "res://Enemy/Waves/Wave.gd"


func build_instance_list():
	var boss = load("res://Enemy/EnemyBoss.tscn").instance()
	var status = load("res://effects/StatusEffectHoT.tscn").instance()
	status.add_condition(0.5, status.e_condition.at_life)
	boss.add_Status(status)
	instance_list.append([boss, 0.42])
