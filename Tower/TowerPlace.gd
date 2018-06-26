extends Node2D
export (PackedScene) var tower
export (PackedScene) var player
export (PackedScene) var bullet

var bulletIndex = 0
var accTower

var runes_screen = []

func _ready():
	bullet = load("res://Bullet/Bullet.tscn")
	runes_screen.append(load("res://Rune/RunePierce.tscn"))
	runes_screen.append(load("res://Rune/RuneChain.tscn"))
	runes_screen.append(load("res://Rune/RuneIncreaseTurretDetectRadius.tscn"))
	runes_screen.append(load("res://Rune/RuneAddSlow.tscn"))
	runes_screen.append(load("res://Rune/RuneAddIgnite.tscn"))
	runes_screen.append(load("res://Rune/RuneScatterShot.tscn"))
	runes_screen.append(load("res://Rune/RuneIncreasedAps.tscn"))
	runes_screen.append(load("res://Rune/RuneIncreasedAps.tscn"))
	runes_screen.append(load("res://Rune/RuneIncreasedAps.tscn"))
	runes_screen.append(load("res://Rune/RuneIncreasedCritChance.tscn"))
	runes_screen.append(load("res://Rune/RuneBoomerang.tscn"))
	runes_screen.append(load("res://Rune/RuneShootOnCrit.tscn"))
	runes_screen.append(load("res://Rune/RuneIncreasedDamage.tscn"))
	#runes_screen.append(load("res://Rune/RuneAddShock.tscn"))

func _on_Area2D_input_event(viewport, event, shape_idx):
	if event is InputEventMouseButton and event.pressed:
		if event.button_index == BUTTON_LEFT and event.pressed:
			if !accTower:
				if player.money -50 < 10:
					return
				player.add_money(-50)
				accTower = tower.instance()
				accTower.set_runes_screen(runes_screen)
				accTower.Bullet = bullet
				add_child(accTower)
				accTower.spawn(position.normalized())

		
func set_player(_player):
	player = _player