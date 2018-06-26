extends "res://Rune/RuneEffect.gd"

func _ready():
	_init()

func _init():
	tags.append(e_rune_tag.enemy_was_crit)
	
func effect(obj):
	get_tags()
	
func enemy_was_crit(body):
	if tower:
		tower.shoot()