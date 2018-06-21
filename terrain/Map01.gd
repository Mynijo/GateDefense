extends Node2D


func _ready():
	for x in get_children():
		if x.has_method('set_player'):
			x.set_player($Player)

func _on_Tower_shoot(bullet, _position, _direction):
    var b = bullet.instance()
    add_child(b)
    b.start(_position, _direction)
