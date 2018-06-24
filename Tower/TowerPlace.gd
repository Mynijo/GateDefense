extends Node2D
export (PackedScene) var tower
export (PackedScene) var player

var placed = false
var BulletList = []
var bulletIndex = 0
var accTower

func _ready():
	BulletList.append(load("res://Bullet/BulletPhy.tscn"))
	BulletList.append(load("res://Bullet/BulletFire.tscn"))
	BulletList.append(load("res://Bullet/BulletSchrotPatrone.tscn"))
	BulletList.append(load("res://Bullet/BulletBouncingBall.tscn"))
	BulletList.append(load("res://Bullet/BulletFreez.tscn"))
	BulletList.append(load("res://Bullet/BulletArrow.tscn"))
	BulletList.append(load("res://Bullet/BulletSlowBomb.tscn"))
	

func _on_Area2D_input_event(viewport, event, shape_idx):
	if event is InputEventMouseButton and event.pressed:
		if !placed:
			if event.button_index == BUTTON_LEFT and event.pressed:
				if player.money -50 < 10:
					return
				player.add_money(-50)
				var t = tower.instance()
				add_child(t)
				t.spawn(position.normalized())
				accTower = t
				placed = true
				accTower.Bullet = BulletList[0]
		else:
			cycleBullet(accTower)
		
func cycleBullet(_tower):
	bulletIndex += 1
	if bulletIndex >= BulletList.size():
		bulletIndex = 0
	_tower.Bullet = BulletList[bulletIndex]

func set_player(_player):
	player = _player