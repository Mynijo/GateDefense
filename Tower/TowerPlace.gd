extends Node2D
export (PackedScene) var tower
export (PackedScene) var player
export (PackedScene) var bullet = preload("res://Bullet/Bullet.tscn")

var bulletIndex = 0
var accTower

var runes_screen = []

func _ready():
	pass
func _on_Area2D_input_event(viewport, event, shape_idx):
	if event is InputEventMouseButton and event.pressed:
		if event.button_index == BUTTON_LEFT and event.pressed:
			if !accTower:
				if player.money -50 < 10:
					return
				player.add_money(-50)
				accTower = tower.instance()
				accTower.Bullet = bullet
				add_child(accTower)
				accTower.spawn(position.normalized())

		
func set_player(_player):
	player = _player