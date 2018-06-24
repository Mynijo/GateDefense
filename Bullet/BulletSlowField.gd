extends "res://Bullet/Bullet.gd"

export (PackedScene) var freez

var targets = []
var effects = []

func _on_Bullet_body_entered(body):
	if body.has_method('add_Status'):
		var s = freez.instance()
		body.add_Status(s)
		targets.append(body)
		effects.append(s)

func _on_BulletSlowField_body_exited(body):
	var index = targets.find(body)
	if index >= 0:
		effects[index].delteYou()
		effects.remove(index)
		targets.erase(body)