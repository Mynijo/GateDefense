extends Node2D
export (PackedScene) var tower
export (PackedScene) var player
export (PackedScene) var bullet

var placed = false
var bulletIndex = 0
var accTower

var runes = []

func _ready():
	bullet = load("res://Bullet/Bullet.tscn")
	runes.append(load("res://Rune/RuneChain.tscn"))
	runes.append(load("res://Rune/RuneIncreaseTurretDetectRadius.tscn"))
	runes.append(load("res://Rune/RuneAddSlow.tscn"))
	runes.append(load("res://Rune/RuneAddIgnite.tscn"))
	runes.append(load("res://Rune/RuneScatterShot.tscn"))
	runes.append(load("res://Rune/RuneIncrasedAps.tscn"))
	

func _on_Area2D_input_event(viewport, event, shape_idx):
	if event is InputEventMouseButton and event.pressed:
		if event.button_index == BUTTON_LEFT and event.pressed:
			if player.money -50 < 10:
				return
			player.add_money(-50)
			accTower = tower.instance()
			accTower.set_Runes(runes)
			accTower.set_Bullet(bullet)
			add_child(accTower)
			accTower.spawn(position.normalized())
			placed = true

		
func set_player(_player):
	player = _player