extends StaticBody2D

signal take_damage
signal dead

export (int) var health


func _ready():
	pass


func _on_DetectArea_body_entered(body):
	if body.has_method('dead'):
		take_damage(body.damage)
		body.dead()
		
func take_damage(damage):
	health += damage
	if health <= 0:
		pass
