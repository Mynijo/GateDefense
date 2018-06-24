extends Node2D

export (int) var StartIntervall = 10
export (int) var wave = 1

export (PackedScene) var enemy
export (PackedScene) var enemy02
export (PackedScene) var player

export (int) var mobs_counter = 0

func _ready():
	$SpawnTimer.wait_time = 1
	$SpawnTimer.start()
	

func _on_SpawnTimer_timeout():
	
	var mobToSpawn = enemy
	
	if wave % 10 == 0 and mobs_counter > 0:
		return
		
	player.wave_changed(int(wave/10) + 1)
	for i in range(int(wave/10)+1):
		if int(wave/10)+1 >= 2 and i <= 2:
			mobToSpawn = enemy02
		else:
			mobToSpawn = enemy
		++mobs_counter
		var e = mobToSpawn.instance()
		add_child(e)		
		var pos = Vector2()
		pos.x = ((randi() % 100 )+ 1) + position.normalized().x	
		pos.y = ((randi() % 640 )+ 1) -320	
		e.spawn(pos)		
	
	$SpawnTimer.wait_time = StartIntervall - (wave % 10)
	$SpawnTimer.start()
	wave += 1
	
		
func set_player(_player):
	player = _player
	
	
