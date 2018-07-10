extends Node

export (int) var damage

# Enemy, Wait Time
var instance_list = []
var counter = 0

func _ready():
	pass
func _init():
	pass

func reward():
	pass
	
func build_instance_list():
	pass
	

func get_next_instance():
	if instance_list.empty():
		build_instance_list()
	if counter  >= instance_list.size():
		return null
	else:
		counter = counter + 1
		return instance_list[counter - 1]
