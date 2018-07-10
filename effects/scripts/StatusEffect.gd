extends Node

export (float) var duration
var parent
var removed_tags = []

enum e_condition{
	at_life
}

var conditions = []

func _ready():
	if duration != 0 and duration != null:
		$Duration.wait_time = duration
		$Duration.start()
	load_condition()
			
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
	
func add_condition(_value, _condition):
	conditions.append([_condition, _value])

func load_condition():
	if conditions.empty():
		return
	for t in $Tags.get_tags():
		if(t != $Tags.e_effect.init):
			removed_tags.append(t)
			$Tags.remove_tag(t)
	for c in conditions:
		if c == e_condition.at_life:
			self.connect("health_changed",get_parent().get_parent().get_parent(), "parent_health_changed")

func parent_health_changed(_health):
	var value = (conditions[conditions.find(e_condition.at_life)])[1]
	if get_parent().get_parent().get_parent() * value <= _health:
		conditions.erase(e_condition.at_life)
		rewrite_tags()
		self.disconnect("health_changed",get_parent().get_parent().get_parent(), "parent_health_changed")
		
func rewrite_tags():
	if conditions.empty():
		for t in $Tags.get_tags():
			if(t != $Tags.e_effect.init):
				removed_tags.erase(t)
				$Tags.add_tag(t)