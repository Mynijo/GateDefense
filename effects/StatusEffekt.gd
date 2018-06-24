extends Node

enum e_tags{
	speed,
	health,
	dontStack
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
	
func effekt(value, tag):
	pass

func _on_Duration_timeout():
	delteYou()
	
func delteYou():
	if get_parent().has_method('remove_Status'):
		get_parent().remove_Status(self)
	queue_free()
	
