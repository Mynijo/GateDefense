extends Area2D

signal take_damage
signal dead

export (int) var health
export (PackedScene) var player


func _ready():
	pass


func _on_Gate_body_entered(body):
	if body.has_method('dead'):
		player.take_damage(body.damage)
		body.dead()
		
func take_damage(damage):
	health -= damage
	if health <= 0:
		pass
