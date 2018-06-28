extends Node

enum e_tags{
	speed,
	health,
	dont_stack,
	cast_on_death,
	need_body,
	direction
}

export (e_tags) var tags = []
export (float) var duration
	
func _ready():
	$Duration.wait_time = duration
	$Duration.start()
	_init()

func _init():
	pass

func add_tag(_tag):
	tags.append(_tag)

func get_tags():
	return tags
	
func has_tag(_tag):
	if tags == null:
		return false
	return tags.has(_tag)
	
func effekt(value, tag):
	pass

func _on_Duration_timeout():
	delteYou()
	
func delteYou():
	if get_parent().has_method('remove_Status'):
		get_parent().remove_Status(self)
	queue_free()

func refresh(_obj):
	set_duration(_obj.duration)

func set_duration(_duration):
	duration = _duration
	$Duration.wait_time = duration
	$Duration.start()