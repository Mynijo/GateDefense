extends "res://Rune/RuneEffect.gd"


export (float) var scatter

func _ready():
	pass
func _init():
	add_tag(e_rune_tag.shoot)

func effect(_obj):
	sort_Obj(_obj)
	
func shoot(_sig, _bullet, _pos, _dir):
	tower.emit_shoot(_sig, _bullet.duplicate(DUPLICATE_USE_INSTANCING), _pos, _dir.rotated(-scatter))
	tower.emit_shoot(_sig, _bullet.duplicate(DUPLICATE_USE_INSTANCING), _pos, _dir.rotated(scatter))
	