extends Control

signal slot_changed;

func _ready():
	connect('slot_changed',get_parent(),'runes_changed')
	pass

func _on_RuneSlot_slot_changed():
	emit_signal('slot_changed')
	pass
	
func get_runes():
	var runes = [] 
	for slot in get_children():
		for stone in slot.get_children():
			runes.push_back(stone.rune.instance())
	return runes