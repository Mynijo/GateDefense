extends Node

export (int) var health = 100
export (int) var money = 120

func _ready():
	pass
	
func addMoney(value):
	money += value
	
func take_damage(damage):
	health -= damage
	if health <= 0:
		pass