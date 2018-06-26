extends "res://Rune/RuneEffect.gd"

var bounced = false
export (float) var incraseLifetime = 2

func _ready():
	_init()
	
func _init():
	tags.append(e_rune_tag.explode)

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
			if bullet.has_method('set_explose_after_hit'):
				bullet.set_explose_after_hit(self, false)
				
			var dir = (tower.global_position - bullet.global_position).normalized()
			bullet.rotation = dir.angle()
			bullet.velocity = dir * bullet.get_speed()
		else:
			bullet.set_explose(self, true)