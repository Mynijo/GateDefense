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
	
func build_instance_list(_path, reset = false):
	if reset:
		instance_list.clear()
		counter = 0
	var wave = load_json(_path)
	if wave:
		for i in wave:
			instance_list.append(i)

func get_next_instance():
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
	var test = instance[0][0]
	var enemy = load(test).instance()
	enemy.load_settings(instance[0][1])
	#Status
	var status = null
	for s in instance[1]:
		if s[0]:
			status = load(s[0]).instance()
			status.load_settings(s[1])
			enemy.add_Status(status)
	#delay
	var delay = instance[2]
	#pos
	var pos = instance[3]
	return [enemy,delay,pos]

func load_json(path):
	var file = File.new()
	file.open(path, file.READ)    
	var tmp_text = file.get_as_text()
	file.close()    
	var data = parse_json(tmp_text)    
	return data

func write_json(path, data):
	var file = File.new()
	file.open(path, file.WRITE)	
	file.store_string(to_json(data))
	file.close()