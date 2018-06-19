extends StaticBody2D

signal health_changed
signal dead

export (int) var health


func _ready():
	pass


func _on_DetectArea_body_entered(body):
	if body.has_method('dead'):
		health_changed(body.damage)
		body.dead()
		
func health_changed(damage):
	health += damage
	if health <= 0:
		pass
