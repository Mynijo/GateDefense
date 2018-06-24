extends Panel

export (PackedScene) var rune

func can_drop_data(position, data):	
	prints("can_drop")
	return true
	
func drop_data(position, data):
	prints("Dropped")
	rune = data
	data.get_parent().remove_child(data)
	add_child(rune)