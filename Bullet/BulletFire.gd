extends "res://Bullet/Bullet.gd"

export (PackedScene) var ignite

func _on_Bullet_body_entered(body):	
	if body.has_method('add_Status'):
		body.add_Status(ignite)
		
	if body.has_method('take_damage'):
	    body.take_damage(damage)
	explode()
