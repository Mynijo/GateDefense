extends "res://Rune/RuneEffect.gd"

func _init():
	$Tags.add_tag($Tags.e_rune.init_tower)
	$Tags.add_tag($Tags.e_rune.whlie_processing)


export (float) var incrase
var i = 0
var x = 10

func effect(_obj, _tag):
	if _tag == $Tags.e_rune.init_tower:
		sort_Obj(_obj)
	if _tag == $Tags.e_rune.whlie_processing:
		var dummy
		var dir = attack.direction
		i = i + _obj* 100
		if i <= x:
			dir.y = dir.y + 100 * _obj
			dir.x = dir.x + 100 * _obj
		if i >= x and i <= 2* x:
			dir.y = dir.y - 100 * _obj
			dir.x = dir.x + 100 * _obj	
		if i >= 2* x and i <=3*x:
			dir.y = dir.y - 100 * _obj
			dir.x = dir.x - 100 * _obj
		if i >=3*x and i <= 4*x:
			dir.y = dir.y + 100 * _obj
			dir.x = dir.x - 100 * _obj
		if i >=4+x:
			i = 0
		if attack.has_method('effect_direction'):
			attack.effect_direction(dir)