extends Node2D

export (int) var start_intervall = 10
export (int) var wave = 1

export (PackedScene) var enemy
export (PackedScene) var enemy02
export (PackedScene) var player


func _ready():
	$SpawnTimer.wait_time = 1
	$SpawnTimer.start()
	

func _on_SpawnTimer_timeout():
	
	var mob_to_spawn = enemy
	
		
	player.wave_changed(int(wave/10) + 1)
	for i in range(int(wave/10)+1):
		if int(wave/10)+1 >= 2 and i <= 2:
			mob_to_spawn = enemy02
		else:
			mob_to_spawn = enemy
		++mobs_counter
		var e = mob_to_spawn.instance()
		e.add_to_group('enemys')
		add_child(e)		
		var pos = Vector2()
		pos.x = ((randi() % 100 )+ 1) + position.normalized().x	
		pos.y = ((randi() % 640 )+ 1) -320	
		e.spawn(pos)		
	
	$SpawnTimer.wait_time = start_intervall - (wave % start_intervall)
	$SpawnTimer.start()
	wave += 1
	
		
func set_player(_player):
	player = _player
	
	
