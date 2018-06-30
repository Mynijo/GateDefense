extends Panel

signal slot_changed

func _ready():
	connect('slot_changed',get_parent(),'_on_RuneSlot_slot_changed')
	
func can_drop_data(position, data):	
	return true
	
func drop_data(position, data):
	if get_parent().has_method('remove_rune'):
		data.get_parent().remove_rune(data)
	else:
		remove_rune(data)
	add_child(data)
	emit_signal('slot_changed')
func remove_rune(rune):
	rune.get_parent().remove_child(rune)
	emit_signal('slot_changed')
	