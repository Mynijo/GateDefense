extends "res://Rune/RuneEffect.gd"

func _ready():
	_init()

func _init():
	tags.append(e_runeTag.enemyWasCrit)
	
func effect(obj):
	get_tags()
	
func enemyWasCrit(body):
	if tower:
		tower.shoot()