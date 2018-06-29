extends Panel

func get_drag_data(position):
	set_drag_preview(self.duplicate())
	return self
