extends Node2D

export (int) var wave_counter = 0

signal Spawn_Enemy

var player

var ready = false
var waves = []
var first = true

func _ready():
	self.connect("Spawn_Enemy", self.get_tree().get_current_scene(), "_on_Spawn_Enemy")
	load_waves()

func load_waves():
	waves.append(load("res://Enemy/Waves/Lvl01/Wave001.tscn").instance())
	waves.append(load("res://Enemy/Waves/Lvl01/Wave002.tscn").instance())
	waves.append(load("res://Enemy/Waves/Lvl01/Wave003.tscn").instance())
	waves.append(load("res://Enemy/Waves/Lvl01/Wave004.tscn").instance())
		
	for w in waves:
		add_child(w)
		
func _process(delta):
	if ready:
		var instance = waves[wave_counter].get_next_instance()
		if instance == null:
			player.wave_status("Wave Done")
			return				
		if instance[1] != 0:
			$SpawnTimer.wait_time =instance[1]
			$SpawnTimer.start()
			ready = false
		var e = instance[0]	
		var pos = Vector2(global_position.x + rand_range(0,100) ,rand_range(0,640))
		emit_signal('Spawn_Enemy', e, pos)
	
func _on_SpawnTimer_timeout():
	ready = true
	
func next_wave():
	if first:
		player.wave_changed(wave_counter +1)
		player.wave_status("Wave Runing")
		first = false
		ready = true
		return
	if  waves[wave_counter].counter >= waves[wave_counter].instance_list.size() and get_tree().get_nodes_in_group("enemys").size() <= 0:
		if waves.size() > wave_counter:
			wave_counter += 1
			player.wave_changed(wave_counter +1)		
			player.wave_status("Wave Runing")
			ready = true
		else:
			player.wave_status("Waves Empty")

	
func set_player(_player):
	player = _player
	player.wave_changed(wave_counter)
	

