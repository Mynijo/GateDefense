extends Node2D

export (int) var StartIntervall = 10
export (int) var wave = 1

export (PackedScene) var enemy


func _ready():
	$SpawnTimer.wait_time = 1
	$SpawnTimer.start()
	

func _on_SpawnTimer_timeout():	

	for i in range(int(wave/10)+1):
		var e = enemy.instance()
		add_child(e)		
		var pos = Vector2()
		pos.x = position.normalized().x	
		pos.y = ((randi() % 640 )+ 1) -320	
		e.spawn(pos)		
	
	$SpawnTimer.wait_time = StartIntervall - (wave % 10)
	$SpawnTimer.start()
	wave += 1
		

