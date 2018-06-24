extends "res://Bullet/Bullet.gd"

var target = []

func explode():
	for body in target:
		if body.has_method('take_damage'):
			body.take_damage(damage)
	queue_free()

func get_speed():
	return speed
	
func _on_Bullet_body_entered(body):	
	$Lifetime.wait_time = 0.2
	$Lifetime.start()	

func _on_Lifetime_timeout():
	explode()	

func _on_BulletBigStone_body_entered(body):
	target.append(body)

func _on_BulletBigStone_body_exited(body):
	target.erase(body)