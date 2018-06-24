extends "res://Bullet/Bullet.gd"

export (PackedScene) var freez

func _on_Bullet_body_entered(body):	
	if body.has_method('add_Status'):
		var s = freez.instance()
		body.add_Status(s)
		
	if body.has_method('take_damage'):
	    body.take_damage(damage)
	explode()
