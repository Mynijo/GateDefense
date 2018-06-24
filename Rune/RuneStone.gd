extends TextureRect

func get_drag_data(position):
	var preview = self.duplicate()
	set_drag_preview(preview)
	return self

func can_drop_data(position, data):
	return true
