extends "res://Rune/RuneEffect.gd"

var bounced = false
export (float) var incraseLifetime = 2

func _ready():
	_init()
	
func _init():
	tags.append(e_runeTag.explode)

func effect(_obj):
	sort_Obj(_obj)
	if _obj.has_method('set_explose'):
		_obj.set_explose(self, false)
	if bullet:
		bullet.effect_lifetime(bullet.get_lifetime() * incraseLifetime)
	
func explode():
	if bullet:
		if !bounced:
			bounced = true
			if bullet.has_method('set_exploseAfterHit'):
				bullet.set_exploseAfterHit(self, false)
				
			var dir = (tower.global_position - bullet.global_position).normalized()
			bullet.set_rotation(dir.angle())
			bullet.set_velocity(dir * bullet.get_speed())
		else:
			bullet.set_explose(self, true)