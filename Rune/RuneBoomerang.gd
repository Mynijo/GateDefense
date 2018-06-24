extends "res://Rune/RuneEffect.gd"

var bullet
var bounced = false

func _ready():
	_init()
	
func _init():
	tags.append(e_runeTag.explode)

func effect(_obj):
	bullet = _obj
	if _obj.has_method('set_explose'):
		_obj.set_explose(self, false)
	
func explode():
	if !bounced:
		bounced = true
		if bullet.has_method('set_exploseAfterHit'):
			bullet.set_exploseAfterHit(self, false)
		var dir = bullet.get_velocity()
		dir.rotated(3.14)
		bullet.set_rotation(dir.angle())
		bullet.set_velocity(dir * -1)
	else:
		bullet.set_explose(self, true)