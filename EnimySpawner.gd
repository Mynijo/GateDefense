extends Node2D

export (int) var StartIntervall = 10
export (int) var wave = 1

export (PackedScene) var enemy


func _ready():
	$SpawnTimer.wait_time = 1
	$SpawnTimer.start()
	

func _on_SpawnTimer_timeout():	
	var e = enemy.instance()
	add_child(e)
	e.spawn((position).normalized())
	$SpawnTimer.wait_time = StartIntervall - wave
	$SpawnTimer.start()
	if wave < StartIntervall -1:
		wave += 1
