extends "res://Bullet/Bullet.gd"

signal shoot
export (PackedScene) var Bullet
export (PackedScene) var freez

func _on_Bullet_body_entered(body):	
	if body.has_method('add_Status'):
		var s = freez.instance()
		s.SlowRate = 0.1
		body.add_Status(s)
	explode()


func explode():
	connect("shoot", self.get_parent(), "_on_Tower_shoot")
	emit_signal('shoot', Bullet ,position, Vector2(0,0))
		
	queue_free()