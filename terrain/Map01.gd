extends Node2D


func _ready():
	$Gate.player = $Player
	$TowerPlace.player = $Player

func _on_Tower_shoot(bullet, _position, _direction):
    var b = bullet.instance()
    add_child(b)
    b.start(_position, _direction)
