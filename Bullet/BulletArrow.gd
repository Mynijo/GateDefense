extends "res://Bullet/Bullet.gd"

func _on_Bullet_body_entered(body):	
	if body.has_method('take_damage'):
	    body.take_damage(damage)