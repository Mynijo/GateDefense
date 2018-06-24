extends "res://Bullet/Bullet.gd"

export (PackedScene) var ignite

var targets = []
var effects = []

func _on_Bullet_body_entered(body):
	if body.has_method('add_Status'):
		var s = ignite.instance()
		s.speedInc = 1
		body.add_Status(s)
		targets.append(body)
		effects.append(s)

func _on_BulletSlowField_body_exited(body):
	var index = targets.find(body)
	if index >= 0:
		effects[index].delteYou()
		effects.remove(index)
		targets.erase(body)