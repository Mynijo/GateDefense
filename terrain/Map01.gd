extends Node2D


func _ready():
	for x in get_children():
		if x.has_method('set_player'):
			x.set_player($Player)

func _on_Tower_shoot(bullet, _position, _direction, _tower):
    var b = bullet
    add_child(b)
    b.start(_position, _direction, _tower)

func _on_spawn_rune(rune, _position):
	add_child(rune)
	rune.rect_position = _position

func _on_MapBoarder_area_entered(area):
	if area.has_method('explode'):
		area.explode()