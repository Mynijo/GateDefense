extends Node2D


func _ready():
	$EnemySpawner.next_wave()
	$TowerPlace.spawn_tower()
	var rune = load("res://ui/RuneStones/RuneStoneFire.tscn").instance()
	add_child(rune)
	($TowerPlace.accTower.rune_slots.get_children())[0].drop_data(Vector2(0,0),rune)
	

func _on_Spawn_Enemy(_Enemy, _pos):
	$EnemySpawner.add_child(_Enemy)
	_Enemy.add_to_group('enemys')	
	_Enemy.spawn(_pos)

func _on_Tower_shoot(attack, _position, _direction, _tower):
    var b = attack
    add_child(b)
    b.start(_position, _direction, _tower)