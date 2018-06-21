extends Node

export (int) var health
export (int) var money

func _ready():
	pass
	
func addMoney(value):
	money += value
	
func take_damage(damage):
	health -= damage
	if health <= 0:
		pass