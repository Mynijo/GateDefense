extends Node2D


export (int) var wave = 0
export (int) var wave_size_multi = 5
var wave_progress = 0
var wave_end = true
var enemys = []
var intervall = 1
var player

var ready = true


func _ready():
	enemys.append(load("res://Enemy/EnemyBlue.tscn"))
	enemys.append(load("res://Enemy/EnemyTank.tscn"))
	enemys.append(load("res://Enemy/EnemyShieldBoss.tscn"))
	$SpawnTimer.wait_time = 1
	$SpawnTimer.start()


func _process(delta):	
	if !wave_end and ready:
		if wave_progress >= wave * wave_size_multi:
			wave_end = true
		ready = false
		for i in range(wave * 2):
			var e = enemys[i%2].instance()
			if i == 0 and wave_end:
				e = enemys[2].instance()
			e.add_to_group('enemys')
			add_child(e)
			var pos = Vector2(0,0)
			pos.x = global_position.x + rand_range(0,100) 
			pos.y = rand_range(0,640)
			#upgrade_mob(e)
			e.spawn(pos)
			wave_progress += 1
		
			
	if wave_end and get_tree().get_nodes_in_group("enemys").size() <= 0:
		player.wave_status("Wave Done")

func _on_SpawnTimer_timeout():	
	$SpawnTimer.wait_time = intervall
	$SpawnTimer.start()
	ready = true
	
func next_wave():
	if wave_end and get_tree().get_nodes_in_group("enemys").size() <= 0:
		wave += 1
		player.wave_changed(wave)		
		wave_end = false
		player.wave_status("Wave Runing")
	
func set_player(_player):
	player = _player
	player.wave_changed(wave)
	
func upgrade_mob(_mob):
	_mob.add_Status((load("res://effects/StatusEffectDropRune.tscn").instance()))
