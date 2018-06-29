extends Node

export (float) var duration
	
func _ready():
	$Duration.wait_time = duration
	$Duration.start()

func _init():
	pass

	
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
	
func remove_tag(_tag):
	$Tags.remove_tag(_tag)

func add_tag(_tag):
	$Tags.add_tag(_tag)

func get_tags():
	return $Tags.get_tags()
	
func has_tag(_tag):
	return $Tags.has_tag(_tag)