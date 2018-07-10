extends Panel

signal slot_changed

func _ready():
	connect('slot_changed',get_parent(),'_on_RuneSlot_slot_changed')
	
func can_drop_data(position, data):	
	return true
	
func drop_data(position, data):
	if(data.get_parent().has_method('remove_rune')):
		remove_rune(data)
	else:
		data.get_parent().remove_child(data)
	data.rect_position = Vector2(0,0)
	add_child(data)
	emit_signal('slot_changed')
func remove_rune(rune):
	var parent = rune.get_parent()
	parent.remove_child(rune)
	parent.emit_signal('slot_changed')
	#emit_signal('slot_changed')
	