extends "res://Bullet/Bullet.gd"

signal shoot
export (PackedScene) var Bullet

export (float) var scattering = 0.15


func explode():
	connect("shoot", self.get_parent(), "_on_Tower_shoot")
	for i in range(5):
		var dir =  Vector2(1, rand_range(-scattering,scattering)).rotated(rotation)
		emit_signal('shoot', Bullet ,position, dir)		
	
	for i in range(4):
			var dir =  Vector2(0.8, rand_range(-scattering,scattering)).rotated(rotation)
			emit_signal('shoot', Bullet ,position, dir)
	
	for i in range(5):
		var dir =  Vector2(0.7, rand_range(-scattering,scattering)).rotated(rotation)
		emit_signal('shoot', Bullet ,position, dir)
			
	for i in range(3):
		var dir =  Vector2(0.6, rand_range(-scattering,scattering)).rotated(rotation)
		emit_signal('shoot', Bullet ,position, dir)
		
	for i in range(3):
		var dir =  Vector2(0.5, rand_range(-scattering,scattering)).rotated(rotation)
		emit_signal('shoot', Bullet ,position, dir)
		
	queue_free()