extends Node

enum e_tags{
	speed,
	helath
}

export (e_tags) var tags = []
export (float) var duration = 10

	
func _ready():
	$Duration.wait_time = duration
	$Duration.start()

func get_tags():
	return tags
	
func has_tag(_tag):
	if tags == null:
		return false
	return tags.has(_tag)
	
func effekt(value):
	pass

func _on_Duration_timeout():
	if get_parent().has_method('remove_Status'):
		get_parent().remove_Status(self)
	queue_free()
