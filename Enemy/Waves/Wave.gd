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
		return get_instance(counter - 1)

func get_instance(counter):
	if counter  >= instance_list.size():
		return null
	var instance = instance_list[counter]
	#Enemys
	var enemy = load(instance[0][0]).instance()
	enemy.load_settings(instance[0][1])
	#Status
	var status = null
	for s in instance[1]:
		status = load(s[0]).instance()
		status.load_settings(s[1])
		enemy.add_Status(status)
	#delay
	var delay = instance[2]
	#pos
	var pos = instance[3]
	return [enemy,delay,pos]