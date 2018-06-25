extends Node2D
export (PackedScene) var tower
export (PackedScene) var player
export (PackedScene) var bullet

var bulletIndex = 0
var accTower

var runesScreen = []

func _ready():
	bullet = load("res://Bullet/Bullet.tscn")
	#runesScreen.append(load("res://Rune/RunePierce.tscn"))
	#runesScreen.append(load("res://Rune/RuneChain.tscn"))
	runesScreen.append(load("res://Rune/RuneIncreaseTurretDetectRadius.tscn"))
	#runesScreen.append(load("res://Rune/RuneAddSlow.tscn"))
	#runesScreen.append(load("res://Rune/RuneAddIgnite.tscn"))
	#runesScreen.append(load("res://Rune/RuneScatterShot.tscn"))
	runesScreen.append(load("res://Rune/RuneIncreasedAps.tscn"))
	runesScreen.append(load("res://Rune/RuneIncreasedAps.tscn"))
	runesScreen.append(load("res://Rune/RuneIncreasedAps.tscn"))
	#runesScreen.append(load("res://Rune/RuneIncreasedCritChance.tscn"))
	#runesScreen.append(load("res://Rune/RuneBoomerang.tscn"))
	#runesScreen.append(load("res://Rune/RuneShootOnCrit.tscn"))
	#runesScreen.append(load("res://Rune/RuneIncreasedDamage.tscn"))
	runesScreen.append(load("res://Rune/RuneAddShock.tscn"))

func _on_Area2D_input_event(viewport, event, shape_idx):
	if event is InputEventMouseButton and event.pressed:
		if event.button_index == BUTTON_LEFT and event.pressed:
			if !accTower:
				if player.money -50 < 10:
					return
				player.add_money(-50)
				accTower = tower.instance()
				accTower.set_RunesScreen(runesScreen)
				accTower.Bullet = bullet
				add_child(accTower)
				accTower.spawn(position.normalized())

		
func set_player(_player):
	player = _player