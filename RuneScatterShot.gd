extends "res://Rune/RuneEffect.gd"

var bullet
export (float) var scatter

func _ready():
	_init()

func _init():
	tags.append(e_runeTag.shoot)

func effect(_obj):
	bullet = _obj
	
func shoot(_sig, _bullet, _pos, _dir):
	bullet.emit_shoot(_sig, _bullet.duplicate(), _pos, _dir.rotated(-scatter))
	bullet.emit_shoot(_sig, _bullet.duplicate(), _pos, _dir.rotated(scatter))
	