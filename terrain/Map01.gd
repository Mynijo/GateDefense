extends Node2D


func _ready():
	$Gate.player = $Player
	$TurretPlace.player = $Player
	$TurretPlace2.player = $Player
	$TurretPlace3.player = $Player



func _on_TowerPhy_shoot(bullet, _position, _direction):
    var b = bullet.instance()
    add_child(b)
    b.start(_position, _direction)
